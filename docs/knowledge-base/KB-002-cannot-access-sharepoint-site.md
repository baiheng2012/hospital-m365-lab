# KB-002: "Access denied" when opening a SharePoint site

**Audience:** End user / Service Desk | **Category:** SharePoint / Access | **Last updated:** 2026-11-__

## Symptom / When to use this
Opening a department SharePoint site shows **Access denied** or **You need permission to access this site**.

## Quick fix (end user)
1. Check the web address is correct (copy it from the original email or link).
2. Make sure you are signed in with your **work account**, not a personal account. Click your profile picture at the top right to check.
3. Close the browser, open a new InPrivate/private window, and sign in again.
4. If your department or role changed recently, wait 15 minutes and retry. Group membership updates are not instant.
5. Still denied? Do not ask a colleague to share files by email. Contact the Service Desk or ask your manager to approve access.

## If that doesn't work (Service Desk)
1. **Decide first whether the denial is correct.** Cross-department access (for example Finance staff opening the Nursing site) is denied by design. If so, do not change permissions. Ask the requester to get approval from their manager and the site owner, then follow the exception process below.
2. If the user *should* have access:
   - Entra admin center → **Users →** the user → **Properties**: is **Department** filled in and spelled exactly as the group rule expects?
   - **Groups →** the department dynamic group (for example `DYN-Nursing-Users`) → **Members**: is the user listed? Check the dynamic membership processing status.
   - Site → **Settings → Site permissions**: confirm the department group is in the site's **Members** group.
3. If the attribute was wrong, fix it, wait for dynamic group processing (can take several minutes), then retest in an InPrivate window.
4. **Do not add individual users directly to the site** as a shortcut; it breaks the permission model and is hard to audit.
5. Exceptions: create a dedicated group (for example `SG-Nursing-Schedule-Readers`), add the approved user, grant that group **Visitors** on the site, and record the approval in the ticket.
6. Escalate to the SharePoint administrator with: user, site URL, error text, group membership screenshot.

## Cause
- Access is correctly denied (not in the department)
- Department attribute blank or misspelled, so the dynamic group excludes the user
- Dynamic group processing delay
- Signed in with the wrong account

## Related articles
- KB-001, KB-003
- `docs/permission-matrix.md`
