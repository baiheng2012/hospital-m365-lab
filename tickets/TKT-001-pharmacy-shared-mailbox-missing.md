# Ticket TKT-001: Pharmacy technician cannot see the pharmacy-orders shared mailbox

> Simulated ticket. All people are fictional. Scenario reproduced in the lab by removing the user's mailbox permission; fill the bracketed fields from your own run.

| Field | Value |
|---|---|
| Date opened | 2026-11-__ [HH:MM] |
| Requester | Ethan Brouwer, Pharmacy Technician (fictional) |
| Category / Subcategory | Email / Shared mailbox |
| Priority | P3 Medium |
| Impact / Urgency | Single user affected; colleagues can still process orders (workaround exists) / Normal |
| Status | Resolved |
| Assigned to | Service Desk (self) |
| Date resolved | 2026-11-__ [HH:MM] |
| Time to resolve | [__ minutes] |
| Resolved on first contact? | [Yes / No] |

## Description
"I can't see the pharmacy-orders mailbox in Outlook anymore. It was there yesterday."

## Troubleshooting steps
1. Verified requester identity and that he is a member of Pharmacy (manager: Robert Castellanos).
2. Asked user to try Outlook on the web and "Add shared folder or mailbox". Result: "You don't have permission".
3. Exchange admin center → Recipients → Mailboxes → Pharmacy Orders → Delegation: user **not listed** under Read and manage or Send as.
4. Confirmed the user has an Exchange Online license and his own mailbox works.

## Root cause
The user's Full Access and Send As permissions on the shared mailbox were missing. (Lab: removed intentionally to reproduce.)

## Resolution
1. Confirmed with the Pharmacy director that access is still required.
2. Re-added **Read and manage** and **Send as** for the user.
3. Waited for replication; user added the mailbox manually in Outlook on the web.
4. Verified: user received and sent a test message as pharmacy-orders. Screenshot reference: `screenshots/p2-xx-...png`.

## KB article created or used
KB-001

## Lessons / prevention
- Exchange mailbox permissions cannot use the dynamic Entra group `DYN-Pharmacy-Users`; permissions are per user. Consider a mail-enabled security group if the team grows.
- Review shared mailbox permissions periodically, and on every offboarding or role change.
