// Generate unique string for web app to prevent name conflicts
param webGenUName string = uniqueString(resourceGroup().id)

var webAppName = toLower('webapp-winos-${webGenUName}')
var webServicePlanName = toLower('webplan-winos-${webGenUName}')
var locationTarget = 'australiaeast'

resource hostPlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: webServicePlanName
  location: locationTarget
  sku: {
    // Free tier
    name: 'F1'
  }
  kind: 'windows'
  properties: {
    // Set to false to launch web plan service using Windows and not Linux OS
    reserved: false
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: locationTarget
  kind: 'app'
  properties: {
    serverFarmId: hostPlan.id
  }
}
