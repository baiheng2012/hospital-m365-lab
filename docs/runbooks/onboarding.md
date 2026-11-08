# Runbook: New Employee Onboarding

**Owner:** IT Customer Services | **Last reviewed:** _date_ | **Related script:** `scripts/onboarding/` (Phase 4)

## Purpose
Create a new employee's account, access and device so they can work on day one.

## Inputs (from HR request / ticket)
- Full name, department, job title, manager, office location, start date

## Steps
1. Confirm the request is approved by the manager / HR (ticket reference: ______).
2. Create the user in Entra ID (UPN per naming convention in `docs/architecture.md`).
3. Set usage location (CA) and assign the Business Premium license.
4. Confirm department group membership (dynamic group should add automatically; verify).
5. Set manager attribute.
6. Provide temporary password securely (never by email in plain text); require change at first sign-in.
7. Register MFA with the user (Authenticator) — verify sign-in succeeds.
8. Confirm mailbox, OneDrive and department SharePoint access.
9. Assign / enroll device (see `device-enrollment.md`).
10. Close ticket with notes.

## Verification checklist
- [ ] Can sign in with MFA
- [ ] Mailbox works (send/receive test)
- [ ] Correct department site visible
- [ ] Device compliant in Intune

## Rollback / if something goes wrong
_TODO_
