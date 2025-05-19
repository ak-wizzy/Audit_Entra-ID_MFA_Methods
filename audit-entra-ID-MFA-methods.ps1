# Connect to Microsoft Graph
Connect-MgGraph -Scopes "UserAuthenticationMethod.Read.All"

# Load users
$users = Import-Csv -Path "C:\Path\To\users.csv"

# Output log for users with >2 methods
$outputLog = "C:\Path\To\UsersWithMoreThan2MFAMethods_$(Get-Date -Format 'yyyyMMdd_HHmm').csv"
$results = @()

foreach ($user in $users) {
    try {
        $methods = Get-MgUserAuthenticationMethod -UserId $user.UserPrincipalName

        $methodCount = $methods.Count

        if ($methodCount -gt 2) {
            Write-Host "$($user.UserPrincipalName) has $methodCount MFA methods" -ForegroundColor Yellow
            $results += [PSCustomObject]@{
                UserPrincipalName = $user.UserPrincipalName
                MethodCount       = $methodCount
                Methods           = ($methods.ODataType -join "; ")
            }
        }
        else {
            Write-Host "$($user.UserPrincipalName) has $methodCount methods" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "Error retrieving methods for $($user.UserPrincipalName): $_" -ForegroundColor Red
    }
}

# Export the results to CSV
if ($results.Count -gt 0) {
    $results | Export-Csv -Path $outputLog -NoTypeInformation
    Write-Host "Results saved to: $outputLog" -ForegroundColor Cyan
} else {
    Write-Host "No users with more than 2 methods found." -ForegroundColor Green
}
