Export Users with More Than 2 MFA Authentication Methods Script

Overview

This PowerShell script exports a list of users with more than 2 registered MFA authentication methods in Entra ID (formerly Azure AD). The script uses a CSV file to specify the target users and outputs a CSV file containing the users' UPNs, MFA method types, and method IDs.

Requirements
PowerShell 5.1 or later
Microsoft Graph PowerShell module (Microsoft.Graph.Users and Microsoft.Graph.Identity.SignIns)
Entra ID (formerly Azure AD) tenant with necessary permissions

Usage
Install the Microsoft Graph PowerShell module if you haven't already:
PowerShell

Install-Module Microsoft.Graph
Update the script with the path to your CSV file and output CSV file.
Run the script in PowerShell.

CSV File Format
The CSV file should have a single column named "UserPrincipalName" containing the UPNs of the users to target. For example:

Code
UserPrincipalName
user1@example.com
user2@example.com
user3@example.com
Script Parameters

$csvPath: Path to the CSV file containing the users to target.
$outputCsvPath: Path to the output CSV file.

Output
The output CSV file will contain the following columns:
UserPrincipalName: The user's UPN.

MethodType: The type of MFA authentication method.

MethodId: The ID of the MFA authentication method.

Permissions
The script requires the following permissions in Entra ID:
User.Read.All
UserAuthenticationMethod.Read.All

Troubleshooting
Make sure you have the necessary permissions in Entra ID.
Check the output CSV file for errors.
Verify that the CSV file is formatted correctly.

Disclaimer
This script is provided as-is without warranty. Use at your own risk. Make sure to test the script in a development environment before running it in production.