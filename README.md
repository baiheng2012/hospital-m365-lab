# Hospital M365 Lab

> A hands-on Microsoft 365 administration lab simulating the IT environment of a fictional mid-size hospital ("Northern General Hospital Lab"). This is a personal learning project and is not affiliated with any real organization.

**Status:** 🚧 In progress — see [PROGRESS.md](PROGRESS.md)

## Scenario

I play the role of a desktop support / IT customer services technician for a fictional hospital with ~24 staff across Nursing, Pharmacy, Finance, IT and Administration. The goal is to stand up and operate a secure, standardized Microsoft 365 environment and document how it is supported day to day.

## What this lab covers

| Area | What I built | Evidence |
|---|---|---|
| Identity (Microsoft Entra ID, formerly Azure AD) | Users, groups (incl. dynamic), admin roles, break-glass account | `docs/architecture.md`, screenshots |
| MFA & Conditional Access | MFA for all users, report-only → enforced, SSPR | `docs/runbooks/` |
| Exchange Online | Shared mailboxes, distribution groups | _TODO_ |
| SharePoint / OneDrive | Department sites, permission model, Known Folder Move | _TODO_ |
| Intune | Entra-joined Windows 11 VM, compliance policy, config profiles, app deployment, update rings | _TODO_ |
| Automation (PowerShell + Microsoft Graph) | Bulk onboarding / offboarding, reporting | `scripts/` |
| Service Desk practice | 10 simulated tickets, 10 knowledge-base articles | `tickets/`, `docs/knowledge-base/` |

## Architecture

_TODO: add diagram (draw.io / Mermaid) and link it here._

## Repository layout

```
docs/            architecture, runbooks, knowledge-base articles
scripts/         PowerShell automation (onboarding, offboarding, reports)
data/            fictional sample data (no real people)
tickets/         simulated support tickets
screenshots/     sanitized screenshots (tenant IDs / domains redacted)
```

## How to use the scripts

_TODO: prerequisites (PowerShell 7, Microsoft.Graph module), required permissions/scopes, example commands._

## Key lessons learned

_TODO: 3–5 problems I hit, how I diagnosed them, what I changed._

## Tools & technologies

Microsoft 365 Business Premium (trial tenant), Microsoft Entra ID, Intune, Exchange Online, SharePoint Online, OneDrive, PowerShell 7, Microsoft Graph PowerShell SDK, Windows 11 (VM), Git/GitHub.

## Safety note

All people, domains and data in this repository are fictional. No credentials, tokens, tenant IDs or real personal information are committed.
