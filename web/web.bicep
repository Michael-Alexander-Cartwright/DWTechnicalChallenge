// Generate unique string for web app to prevent name conflicts
param webAppGenUName string = uniqueString(resourceGroup().id)

var webAppSiteName = toLower('webapp-winos-${webAppGenUName}')

resource hostPlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'testWebPlan'
  location: 'australiaeast'
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
  name: webAppSiteName
  location: 'australiaeast'
  kind: 'app'
  properties: {
    serverFarmId: hostPlan.id
  }
}
