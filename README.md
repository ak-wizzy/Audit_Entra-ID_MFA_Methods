# Audit_Entra-ID_MFA_Methods
This powershell audits and reports on users that currently have more than 2 Entra ID MFA authentication methods registered

What this script does:

Takes a list of users from a CSV,

Queries each user's registered authentication methods,

Logs any user who has more than 2 methods registered.

What You’ll Get
A .csv report listing:

UserPrincipalName

Number of registered methods

The method types (like phone, Microsoft Authenticator, FIDO2, etc.)

Prereqs
You need the Microsoft Graph module:
Install-Module Microsoft.Graph -Scope CurrentUser

You must authenticate with this permission scope:
Connect-MgGraph -Scopes "UserAuthenticationMethod.Read.All"
