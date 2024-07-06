$group="DWTestResGrp"
$location="australiaeast"

az configure --defaults location=$location

az group create --name $group
az deployment group create --resource-group $group --template-file .\mat\script.bicep --mode Complete

az group delete --resource-group $group --yes