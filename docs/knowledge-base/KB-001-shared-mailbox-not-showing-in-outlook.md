# KB-001: A shared mailbox doesn't appear in Outlook

**Audience:** End user / Service Desk | **Category:** Email | **Last updated:** 2026-11-__

## Symptom / When to use this
You were told you have access to a shared mailbox (for example `pharmacy-orders@<tenant>.onmicrosoft.com`), but it is not listed in the folder pane in Outlook (desktop or web), or you get "you don't have permission" when opening it.

## Quick fix (end user)
1. If access was granted recently, wait up to 60 minutes. Permission changes and automatic mapping are not instant.
2. Close Outlook completely and reopen it (or sign out and back in to Outlook on the web).
3. In **Outlook on the web**: right-click your own mailbox name in the folder pane → **Add shared folder or mailbox** → type the shared mailbox address → **Add**.
4. Still nothing? Contact the Service Desk with the shared mailbox address and the time you were told access was granted.

## If that doesn't work (Service Desk)
1. **Verify the request is approved** by the user's manager or the mailbox owner. Shared mailboxes in a hospital may hold sensitive information; never grant access on the user's word alone.
2. In the Exchange admin center: **Recipients → Mailboxes →** select the shared mailbox → **Delegation**. Check the user is listed under **Read and manage** (full access) and, if they must send from it, **Send as**.
3. If missing, add the user. Use the individual user, not a group (see note below).
4. Confirm the user has an Exchange Online license and a mailbox (Recipients → Mailboxes).
5. Test in an InPrivate window in Outlook on the web as the user.
6. Escalate to the Exchange administrator with: user, shared mailbox address, time of request, screenshot of the Delegation tab, steps already tried.

> **Note:** Exchange mailbox permissions accept individual users or *mail-enabled* security groups. A dynamic Entra security group (for example `DYN-Pharmacy-Users`) is not mail-enabled and cannot be selected here.

## Cause
- Permission was never granted, or was removed
- Permission granted recently and not yet replicated / mapped
- Access was attempted to a group that cannot hold mailbox permissions

## Related articles
- KB-002, KB-003
- Runbook: `docs/runbooks/shared-mailbox-access.md`
