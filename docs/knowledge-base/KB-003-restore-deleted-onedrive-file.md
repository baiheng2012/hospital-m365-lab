# KB-003: Restore a deleted OneDrive file

**Audience:** End user / Service Desk | **Category:** OneDrive | **Last updated:** 2026-11-__

## Symptom / When to use this
A file or folder in OneDrive was deleted by mistake, or an older version of a file is needed after it was overwritten.

## Quick fix (end user)
1. Sign in at office.com and open **OneDrive** (or open OneDrive in the browser).
2. In the left menu, open **Recycle bin**.
3. Select the file or folder → **Restore**. It returns to its original location.
4. If the file still exists but has wrong content: right-click it → **Version history** → pick an earlier version → **Restore**.
5. Can't find it? Contact the Service Desk with the file name, the approximate date it was deleted, and where it was stored.

## If that doesn't work (Service Desk)
1. Confirm the identity of the requester. Never restore or open another user's files without the owner's or manager's approval.
2. Ask for the file name, folder, and approximate deletion time.
3. If the file is not in the user's recycle bin, items can also be in the site collection (second-stage) recycle bin; deleted items are normally kept for a limited period (Microsoft documents about 93 days in total, confirm against current documentation).
4. For many files lost at once, the user can use **Restore your OneDrive** (OneDrive web → Settings → Restore your OneDrive) to roll back to a recent point in time.
5. Record in the ticket what was restored and from where.
6. Escalate if the file is outside the retention window: involve the M365 administrator; check whether a retention policy applies.

## Tip for users
Save work files to OneDrive or the department SharePoint site, not only to the local Desktop, so they can be recovered.

## Sync problems (to complete in Phase 3)
Troubleshooting for the OneDrive app on a managed device (red X, "sync pending", file name limits) will be added after testing on the lab Windows 11 VM with Known Folder Move.

## Related articles
- KB-001, KB-002
