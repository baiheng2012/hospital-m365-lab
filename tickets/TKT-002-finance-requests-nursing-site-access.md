# Ticket TKT-002: Finance user requests access to the Nursing SharePoint site

> Simulated ticket. All people are fictional. Scenario reproduced in the lab (finance test account opens the Nursing site and is denied); fill the bracketed fields from your own run.

| Field | Value |
|---|---|
| Date opened | 2026-11-__ [HH:MM] |
| Requester | Samuel Adeyemi, Accounts Payable Clerk (fictional) |
| Category / Subcategory | Access / SharePoint |
| Priority | P4 Low |
| Impact / Urgency | Single user, no work stopped / Low |
| Status | Closed (request routed for approval; no permission change) |
| Assigned to | Service Desk (self) |
| Date resolved | 2026-11-__ [HH:MM] |
| Time to resolve | [__ minutes] |
| Resolved on first contact? | [Yes / No] |

## Description
"I get 'Access denied' when I open the Nursing site. I need the on-call schedule for invoice approvals."

## Troubleshooting steps
1. Verified the requester signed in with his work account.
2. Checked the permission matrix: the Nursing site Members group is `DYN-Nursing-Users`; Finance staff are not in it.
3. Confirmed his Department attribute is "Finance" and he is correctly in `DYN-Finance-Users`.
4. Conclusion: the denial is **expected and correct**; the permission model is working.

## Root cause
Not a fault. The user is not in the Nursing department, so access is denied by design.

## Resolution
1. Explained why access is denied and that cross-department access needs approval.
2. Asked him to get approval from his manager (Natalie Duchesne) and the Nursing site owner (Elena Marchetti, Director of Nursing).
3. Offered the approved alternative: if approved, IT creates a dedicated group `SG-Nursing-Schedule-Readers`, adds the user, and grants it **Visitors** (read-only) on the site. No direct per-user permission.
4. Closed the ticket with no change made; reopen when approvals arrive. Screenshot reference: `screenshots/p2-xx-access-denied.png` (redact tenant name).

## KB article created or used
KB-002

## Lessons / prevention
- Not every "Access denied" is a bug; check the permission model before changing anything.
- Exceptions go through dedicated groups with documented approval, never direct user grants, so access stays auditable.
