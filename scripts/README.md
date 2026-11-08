# Scripts

PowerShell 7 + Microsoft Graph PowerShell SDK. Built in Phase 4 (and earlier as you practice).

Planned layout:

```
onboarding/    New-LabUser.ps1       create users from a CSV
offboarding/   Disable-LabUser.ps1   block sign-in, revoke sessions, remove licenses
reports/       Get-MfaRegistrationReport.ps1, Get-NonCompliantDevices.ps1, Get-InactiveUsers.ps1
```

Rules for every script:
- Support `-WhatIf` (use `[CmdletBinding(SupportsShouldProcess)]`)
- Read inputs from CSV / parameters, never hard-code tenant names or passwords
- Request the minimum Graph scopes and list them in the header comment
- Write a log to `exports/` (git-ignored)
