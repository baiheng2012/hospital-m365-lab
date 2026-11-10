# Ticket TKT-003: Nurse accidentally deleted an on-call schedule file from OneDrive

> Simulated ticket. All people and files are fictional. Scenario reproduced in the lab (upload a test file to the user's OneDrive, delete it, restore it); fill the bracketed fields from your own run.

| Field | Value |
|---|---|
| Date opened | 2026-11-__ [HH:MM] |
| Requester | Hannah Cho, Registered Nurse (fictional) |
| Category / Subcategory | OneDrive / File recovery |
| Priority | P3 Medium |
| Impact / Urgency | Single user, file needed this week / Medium |
| Status | Resolved |
| Assigned to | Service Desk (self) |
| Date resolved | 2026-11-__ [HH:MM] |
| Time to resolve | [__ minutes] |
| Resolved on first contact? | [Yes / No] |

## Description
"I deleted `Oncall-Schedule-Nov.xlsx` from my OneDrive by mistake and I need it back."

## Troubleshooting steps
1. Verified requester identity.
2. Asked for file name and approximate deletion time.
3. Walked the user through OneDrive web → Recycle bin (the file was found).
4. Checked that the file was not shared with others in a way that restoring would change.

## Root cause
User error (accidental deletion).

## Resolution
1. User selected the file in the Recycle bin and chose **Restore**; it returned to its original folder.
2. Verified the file opens and content is intact.
3. Advised the user to keep important schedules on the department SharePoint site, where files are recoverable by site owners and covered by the site permission model.
4. Screenshot reference: `screenshots/p2-xx-onedrive-recycle-bin.png`.

## KB article created or used
KB-003

## Lessons / prevention
- Recycle bin recovery is a common first-contact fix; a short KB article lets users self-serve.
- Teach "Version history" for overwritten files.
