# Runbook: Windows Device Enrollment & Standard Configuration

**Owner:** IT Customer Services | **Last reviewed:** _date_

## Purpose
Join a Windows 11 device to Entra ID, enroll in Intune, and confirm it meets the standard.

## Prerequisites
- User account with Intune license
- Windows 11 Enterprise/Pro VM (evaluation ISO), snapshot taken before enrollment

## Steps
1. Complete OOBE / Settings → Accounts → Access work or school → Connect → **Join this device to Microsoft Entra ID**.
2. Sign in with the user's work account and complete MFA.
3. Rename device per convention (`NGH-<Dept>-<seq>`).
4. In Intune admin center, confirm the device appears; note compliance state.
5. Confirm assigned policies applied (compliance, configuration profile, update ring).
6. Confirm Company Portal installs and the assigned app deploys.

## Verification checklist
- [ ] Device visible in Entra ID (join type: Microsoft Entra joined)
- [ ] Device visible in Intune and **Compliant**
- [ ] BitLocker / security baseline status checked (as supported by VM)
- [ ] Assigned app installed

## Troubleshooting log
| Symptom | Cause | Fix |
|---|---|---|
| _TODO_ | _TODO_ | _TODO_ |
