<#
.SYNOPSIS
    Updates the DTU values for a Sql elastic pool.  

.DESCRIPTION
    This script updates the database transation units for a singular Sql elastic pool's name and when also provided 
    the the elastic pool's assocating server name and resource group that it belongs to. 
    
    This script is designed to be executed both with and without parameters passed when executed. This was designed
    intentionally for local development and debugging purposes. The customer user end service that connects to this 
    script for the elastic pool DTU update should do so when all the parameters are passed at execution time.

.PARAMETER ParameterName
    resourceGroupName - string: The name of the Azure Resource Group that the Sql elastic pool exists within.
    serverName - string: The name of the Sql Server under the Azure Resource Group that the Sql elastic pool is associated with. 
    elasticPoolName - string: The name of the Elastic Pool the user wants updated.
    dbTransUnit - int: The Database Transaction Unit that the user wants to be set of the Sql elastic pool. 
    dbTransMax - int: The Maximum Database Transaction Unit that the user wants to be set of the Sql elastic pool. 
    dbTransMin - int: The Minimum Database Transaction Unit that the user wants to be set of the Sql elastic pool. 

.EXAMPLE
    Execute script with all parameters passed:
    .\updateElastiicPoolDTU.ps1 -resourceGroupName <string> -serverName <string> -elasticPoolName <string> -dbTransUnit <int> -dbTransMax <int> -dbTransMin <int>

    Execute manually and be prompted the variables:
    .\updateElastiicPoolDTU.ps1

    Example with test values given:
    .\updateElasticPoolDTU.ps1 -resourceGroupName "SqlDB" -serverName "testdb-asdf1234" -elasticPoolName "testDB-elastic" -dbTransUnit 50 -dbTransMax 5 -dbTransMin 0

.NOTES
    I decided not to implement any checks for the variables being provided by the user executing in relation to the
    elastic pool's current set plan. The Azure error reports are self explanatory to understand what problems the
    update encounters. The customer user end service that connects to this script should handle those checks.
    
    ...I also don't have the funds to test anything higher than a Sql elastic pool's 'Basic' tier.
#>

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

# Print confirmation to assure user operation is executing
Write-Host "Updating Elastic Pool '$elasticPoolName' now. Please wait..."

# Set and update the Sql Elasticpool DB Transaction Unit configuration 
Set-AzSqlElasticPool -ResourceGroupName $resourceGroupName `
                     -ServerName $serverName `
                     -ElasticPoolName $elasticPoolName `
                     -Dtu $dbTransUnit `
                     -DatabaseDtuMax $dbTransMax `
                     -DatabaseDtuMin $dbTransMin
