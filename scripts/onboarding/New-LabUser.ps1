<#
.SYNOPSIS
    Creates Entra ID users from a CSV file, assigns a license, and sets managers.

.DESCRIPTION
    Reads a CSV (see data/users-sample.csv for the columns) and, for each row:
      1. if the user already exists AND has a license, skips it (safe to re-run)
      2. if the user exists but has NO license (e.g. an earlier run failed midway),
         repairs it: resets to a new random temporary password and assigns the license
      3. otherwise creates the user with a random temporary password
         (must change at first sign-in) and assigns the license
    Directory calls are retried automatically on transient errors (409 concurrency).
    After all users exist, a second pass sets each user's manager.
    Temporary passwords are appended to a local file under exports/ (git-ignored)
    immediately after each user is created, so nothing is lost if the script stops.

    Required Graph scopes: User.ReadWrite.All, Organization.Read.All
    Sign in as a Global Administrator or User Administrator of the LAB tenant.

.PARAMETER CsvPath
    Path to the CSV file.

.PARAMETER Domain
    Your tenant's initial domain, e.g. nglab2026.onmicrosoft.com

.PARAMETER SkuPartNumber
    License SKU part number. Run Get-MgSubscribedSku | Select SkuPartNumber to list yours.

.EXAMPLE
    ./New-LabUser.ps1 -CsvPath ../../data/users-sample.csv -Domain nglab2026.onmicrosoft.com -WhatIf

.EXAMPLE
    ./New-LabUser.ps1 -CsvPath ../../data/users-sample.csv -Domain nglab2026.onmicrosoft.com

.NOTES
    Written for learning; test with -WhatIf first. Run in PowerShell 7 (pwsh).
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$CsvPath,
    [Parameter(Mandatory)][string]$Domain,
    [string]$SkuPartNumber = 'SPB',
    [string]$OutputDir = (Join-Path $PSScriptRoot '../../exports')
)

$ErrorActionPreference = 'Stop'

function New-RandomPassword {
    # 16 chars, guaranteed to contain upper, lower, digit and symbol
    $upper = 'ABCDEFGHJKLMNPQRSTUVWXYZ'
    $lower = 'abcdefghijkmnpqrstuvwxyz'
    $digit = '23456789'
    $symbol = '!@#$%*?'
    $all = $upper + $lower + $digit + $symbol
    $pick = { param($set) $set[[System.Security.Cryptography.RandomNumberGenerator]::GetInt32($set.Length)] }
    $chars = @(& $pick $upper; & $pick $lower; & $pick $digit; & $pick $symbol)
    1..12 | ForEach-Object { $chars += & $pick $all }
    -join ($chars | Sort-Object { [System.Security.Cryptography.RandomNumberGenerator]::GetInt32(1000000) })
}

function Invoke-WithRetry {
    # Retries a script block on transient directory errors (409 concurrency, replication delay)
    param(
        [Parameter(Mandatory)][scriptblock]$Action,
        [int]$MaxAttempts = 5
    )
    for ($i = 1; $i -le $MaxAttempts; $i++) {
        try {
            return (& $Action)
        }
        catch {
            $msg = $_.Exception.Message
            $transient = $msg -match 'ConcurrencyViolation|409|Conflict|Request_ResourceNotFound|does not exist'
            if ($i -lt $MaxAttempts -and $transient) {
                Write-Host "      transient error, retry $i of $MaxAttempts in $(3 * $i)s..." -ForegroundColor DarkYellow
                Start-Sleep -Seconds (3 * $i)
            }
            else {
                throw
            }
        }
    }
}

function Save-TempPassword {
    param([string]$Upn, [string]$Password)
    [pscustomobject]@{ UserPrincipalName = $Upn; TempPassword = $Password } |
        Export-Csv -Path $script:passwordFile -Append -NoTypeInformation
}

if (-not (Test-Path $CsvPath)) { throw "CSV not found: $CsvPath" }
$rows = Import-Csv -Path $CsvPath
Write-Host "Loaded $($rows.Count) rows from $CsvPath"

# Reuse an existing sign-in if you already ran Connect-MgGraph (e.g. with -UseDeviceCode)
$ctx = Get-MgContext
if (-not $ctx -or ($ctx.Scopes -notcontains 'User.ReadWrite.All')) {
    Connect-MgGraph -Scopes 'User.ReadWrite.All', 'Organization.Read.All' -NoWelcome
}

$sku = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -eq $SkuPartNumber
if (-not $sku) {
    Write-Host 'Available SKUs in this tenant:'
    Get-MgSubscribedSku -All | Select-Object SkuPartNumber, ConsumedUnits, @{n='Total';e={$_.PrepaidUnits.Enabled}}
    throw "SKU '$SkuPartNumber' not found. Re-run with -SkuPartNumber <one of the above>."
}

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
$script:passwordFile = Join-Path $OutputDir ("temp-passwords-{0:yyyyMMdd-HHmmss}.csv" -f (Get-Date))
$failed = @()

# ---- Pass 1: create users + license ----
foreach ($r in $rows) {
    $upn = "$($r.UserName)@$Domain"
    try {
        $existing = Get-MgUser -Filter "userPrincipalName eq '$upn'" -Property Id, UserPrincipalName, AssignedLicenses -ErrorAction SilentlyContinue

        if ($existing -and @($existing.AssignedLicenses).Count -gt 0) {
            Write-Host "SKIP  $upn (already exists and licensed)" -ForegroundColor Yellow
            continue
        }

        if ($existing) {
            # Repair: user was created earlier but has no license
            if ($PSCmdlet.ShouldProcess($upn, 'Repair: reset password and assign license')) {
                $tempPassword = New-RandomPassword
                Invoke-WithRetry { Update-MgUser -UserId $existing.Id -PasswordProfile @{ Password = $tempPassword; ForceChangePasswordNextSignIn = $true } }
                Invoke-WithRetry { Set-MgUserLicense -UserId $existing.Id -AddLicenses @{ SkuId = $sku.SkuId } -RemoveLicenses @() | Out-Null }
                Save-TempPassword -Upn $upn -Password $tempPassword
                Write-Host "FIXED $upn (license assigned, new temp password saved)" -ForegroundColor Green
            }
            continue
        }

        if ($PSCmdlet.ShouldProcess($upn, 'Create user and assign license')) {
            $tempPassword = New-RandomPassword
            $user = Invoke-WithRetry {
                New-MgUser `
                    -AccountEnabled:$true `
                    -UserPrincipalName $upn `
                    -MailNickname $r.UserName `
                    -DisplayName $r.DisplayName `
                    -GivenName $r.GivenName `
                    -Surname $r.Surname `
                    -Department $r.Department `
                    -JobTitle $r.JobTitle `
                    -OfficeLocation $r.OfficeLocation `
                    -UsageLocation $r.UsageLocation `
                    -PasswordProfile @{ Password = $tempPassword; ForceChangePasswordNextSignIn = $true }
            }
            # Save the password right away, before the license step, so it is never lost
            Save-TempPassword -Upn $upn -Password $tempPassword
            Start-Sleep -Seconds 2   # give the directory a moment to replicate
            Invoke-WithRetry { Set-MgUserLicense -UserId $user.Id -AddLicenses @{ SkuId = $sku.SkuId } -RemoveLicenses @() | Out-Null }
            Write-Host "OK    $upn" -ForegroundColor Green
        }
    }
    catch {
        Write-Warning "FAILED $upn : $($_.Exception.Message)"
        $failed += $upn
    }
}

# ---- Pass 2: managers (all users now exist) ----
foreach ($r in $rows | Where-Object Manager) {
    $upn = "$($r.UserName)@$Domain"
    $mgrUpn = "$($r.Manager)@$Domain"
    try {
        if ($PSCmdlet.ShouldProcess($upn, "Set manager to $mgrUpn")) {
            $u = Get-MgUser -Filter "userPrincipalName eq '$upn'"
            $m = Get-MgUser -Filter "userPrincipalName eq '$mgrUpn'"
            if ($u -and $m) {
                Invoke-WithRetry { Set-MgUserManagerByRef -UserId $u.Id -BodyParameter @{ '@odata.id' = "https://graph.microsoft.com/v1.0/users/$($m.Id)" } }
                Write-Host "MGR   $upn -> $mgrUpn"
            }
            else {
                Write-Warning "Could not set manager for $upn (user or manager missing)"
            }
        }
    }
    catch {
        Write-Warning "FAILED manager for $upn : $($_.Exception.Message)"
        $failed += "$upn (manager)"
    }
}

if (Test-Path $script:passwordFile) {
    Write-Host "Temporary passwords saved to $script:passwordFile (this folder is git-ignored; delete after use)" -ForegroundColor Cyan
}
if ($failed.Count -gt 0) {
    Write-Host "`n$($failed.Count) item(s) failed. Re-run the script; it will repair or skip as needed:" -ForegroundColor Red
    $failed | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
}
else {
    Write-Host "`nAll done." -ForegroundColor Green
}
Disconnect-MgGraph | Out-Null
