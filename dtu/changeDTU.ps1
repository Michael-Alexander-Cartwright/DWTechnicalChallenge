

# Parameters required for updating Sql Elastic Pool on for given Azure Resource Group and Server 
param (
    [string]$resourceGroupName, #SqlDB
    [string]$serverName, #testdb-asdf1234
    [string]$elasticPoolName, #testDB-elastic
    [int]$dbTransUnit, #50
    [int]$dbTransMax, #5
    [int]$dbTransMin #0
)

<#
Check if any of the parameters below were provided via command line at script's execution
If not, we prompt the user. This functionality provides two things:
    1. Double checks that a parameter has a given value.
    2. Provides a user the ability to execute this script and use the terminal as a graphical guide to setting up an elastic pool DTU update  
#> 

# Check if Resource Group name parameter was provided, if not we prompt the user
if (-not $resourceGroupName) {
    $resourceGroupName = Read-Host "Please enter the 'Resource Group Name' that the SQL database elastic pool belongs within"
}

# Check if the Server Name parameter was provided, if not we prompt the user
if (-not $serverName) {
    $serverName = Read-Host "Please enter the 'Server Name' that the SQL database elastic pool belongs to"
}

# Check if the Elastic Pool Name parameter was provided, if not we prompt the user
if (-not $elasticPoolName) {
    $elasticPoolName = Read-Host "Please enter the 'Elastic Pool Name' to be updated"
}

# Check if the new DTU value was provided, if not we prompt the user
if (-not $dbTransUnit) {
    $dbTransUnit = Read-Host "Please enter the new 'DTU (Database Transaction Units)' value for the Elastic Pool '$elasticPoolName'"
}

# Check if the new max DTU value was provided, if not we prompt the user
if (-not $dbTransMax) {
    $dbTransMax = Read-Host "Please enter the new 'Maximum DTU' value for the Elastic Pool '$elasticPoolName'"
}

# Check if the new min DTU value was provided, if not we prompt the user
if (-not $dbTransMin) {
    $dbTransMin = Read-Host "Please enter the new 'Minimum DTU' value for the Elastic Pool '$elasticPoolName'"
}

# Print to console changes that will apply
Write-Host "The Elastic Pool '$elasticPoolName' that exists under the Resource Group '$resourceGroupName' and the Sql Server '$serverName' will have the following changes:"
Write-Host "DTU: $dbTransUnit - DTU Max: $dbTransMax - DTU Min: $dbTransMin"

# Check if user wishes to continue or cancel operation
$checkMessage = "Do you wish to proceed with updating the Elastic Pool '$elasticPoolName' with the values shown above (Y/n)?"

while ($true) {
    $response = Read-Host -Prompt "$checkMessage"
    if ($response -eq "Y" -or $response -eq "y") {
        # Print confirmation to assure user operation is executing
        Write-Host "Updating Elastic Pool '$elasticPoolName' now. Please wait..."

        # Set and update the Sql Elasticpool DB Transaction Unit configuration 
        Set-AzSqlElasticPool -ResourceGroupName $resourceGroupName `
                             -ServerName $serverName `
                             -ElasticPoolName $elasticPoolName `
                             -Dtu $dbTransUnit `
                             -DatabaseDtuMax $dbTransMax `
                             -DatabaseDtuMin $dbTransMin
        
        break
    } 
    elseif ($response -eq "N" -or $response -eq "n") {
        Write-Host "Terminating..."
        break
    } 
    else {
        Write-Host "Please enter either Y (yes) or N (no)."
    }
}
