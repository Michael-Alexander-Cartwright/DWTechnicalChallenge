# Set the resource group's name
$rgname="dw-bicep-webapp-winos"

# Set the resource group's location 
$rglocation="australiaeast"

# Create the resource group on Azure
az group create --name $rgname --location $rglocation

# Create server farm (Web Hosting Plan)
az deployment group create `
    --resource-group $rgname `
    --template-file .\web\webplan.bicep `
    --output json > serverFarmOutput.json

# Deploy web apps where user provides server farm
# I have the output provided in json to help with obtaining the server farm name.
$servfarmname=Read-Host "Please enter server farm name"
az deployment group create `
    --resource-group $rgname `
    --template-file .\web\webapp.bicep `
    --parameters servFarmName=$servfarmname