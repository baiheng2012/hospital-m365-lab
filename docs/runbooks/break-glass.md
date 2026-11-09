# Runbook: Break-glass (Emergency Access) Account

**Last reviewed:** 2026-11-06__

## Purpose
A cloud-only Global Administrator used only if normal admin access fails
(for example, a Conditional Access misconfiguration locks everyone out).

## Account
- Name: Break Glass 1 (UPN stored in the password manager)
- Role: Global Administrator
- License: none
- Group: SG-CA-Exclude (excluded from Conditional Access policies)

## Controls
- 24+ character random password, stored only in the password manager
- MFA registered (lab: Authenticator app)
- Never used for daily work

## Lab simplification vs production
Microsoft's mandatory MFA applies to admin portals and does not exempt
break-glass accounts. Production recommendation: phishing-resistant
methods (FIDO2 passkey or certificate-based authentication) stored
offline in a safe, not tied to one person's phone. This lab uses the
Authenticator app because no hardware key is available.

## When to use
- Normal admins cannot sign in due to policy/MFA/service failure

## After use
1. Change the password
2. Review sign-in and audit logs for the session
3. Record what happened (date, reason, who) in a ticket
4. Re-test the account's sign-in quarterly

## Test log
| Date | Tester | Result |
|---|---|---|