# Import the Microsoft Graph modules
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Identity.SignIns

# Connect to Microsoft Graph with the necessary permissions
Connect-MgGraph -Scopes "User.Read.All", "UserAuthenticationMethod.Read.All"

# Specify the path to your CSV file
$csvPath = "C:\Path\To\users.csv"

# Specify the path to the output CSV file
$outputCsvPath = "C:\Path\To\_$(Get-Date -Format 'yyyyMMdd_HHmm').csv"

# Import the CSV file
$users = Import-Csv -Path $csvPath

# Create an array to store the output
$output = @()

# Loop through each user in the CSV file
foreach ($user in $users) {
    $upn = $user.UserPrincipalName

    try {
        # Get the user's registered authentication methods
        $authMethods = Get-MgUserAuthenticationMethod -UserId $upn

        # Check if the user has more than 2 authentication methods
        if ($authMethods.Count -gt 2) {
            # Loop through each authentication method
            foreach ($authMethod in $authMethods) {
                $output += [PSCustomObject]@{
                    UserPrincipalName = $upn
                    MethodType        = $authMethod.AdditionalProperties["@odata.type"]
                    MethodId          = $authMethod.Id
                }
            }
        }
    } catch {
        Write-Warning "User $upn not found or no permissions to access"
    }
}

# Export the output to a CSV file
$output | Export-Csv -Path $outputCsvPath -NoTypeInformation

# Disconnect from Microsoft Graph
Disconnect-MgGraph