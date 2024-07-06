$rgname="rg-bicep-webapp-winos"
$location="australiaeast"

# Resource group creation
az group create --name $rgname --location $location

# Deploy web plan with bicep script
az deployment group create --resource-group $rgname --template-file .\web\webplan.bicep

# Deploy web app with bicep script
az deployment group create --resource-group $rgname --template-file .\web\webapp.bicep