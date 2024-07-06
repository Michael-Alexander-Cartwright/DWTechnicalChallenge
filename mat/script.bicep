targetScope = 'subscription'

var rescGrpName = 'DeployedFromBicepRescGrp'
var locationName = 'australiaeast'
resource testNewGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: rescGrpName
  location: locationName
}

@description('Set the hot storage name.')
module storageModule 'storage.bicep' = {
  name: 'storageModule'
  scope: resourceGroup(testNewGroup.name)
  params: {
    storageName: '20240706stor'
    locationName: locationName
  }
}
