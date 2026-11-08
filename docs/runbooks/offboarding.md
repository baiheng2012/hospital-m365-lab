# Runbook: Employee Offboarding

**Owner:** IT Customer Services | **Last reviewed:** _date_ | **Related script:** `scripts/offboarding/` (Phase 4)

## Purpose
Remove access promptly and safely when an employee leaves, while preserving data the organization needs.

## Steps
1. Confirm the request from HR / manager (ticket reference: ______) and the effective date.
2. Block sign-in and revoke active sessions.
3. Reset password (random) and remove registered MFA methods if policy requires.
4. Remove from groups and licenses (after data retention steps below).
5. Mailbox: convert to shared mailbox or grant manager access, per retention decision.
6. OneDrive: transfer files to manager (retention window: ____ days).
7. Devices: retire or wipe in Intune; collect hardware; update inventory.
8. Document what was done and when; close ticket.

## Verification checklist
- [ ] Sign-in blocked
- [ ] Sessions revoked
- [ ] Manager has needed data
- [ ] Device retired / wiped
- [ ] License released

## Notes
Healthcare context: handle patient-related data and confidential information per policy; never copy data to personal storage.
