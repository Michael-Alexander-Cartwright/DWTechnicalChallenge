// Generate unique string for web app to prevent name conflicts
param webGenUName string = uniqueString(resourceGroup().id)

var webAppName = toLower('webapp-winos-${webGenUName}')
var webServicePlanName = toLower('webplan-winos-${webGenUName}')

// Being creative and simplistic here to spawn three web apps on Azure
// One being 'Brisbane Australia' 
var timeZones = [
  'Australia/Brisbane'
  'Australia/Melbourne'
  'Australia/Hobart'
]

resource hostPlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: webServicePlanName
  location: resourceGroup().location
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

resource webApp 'Microsoft.Web/sites@2023-12-01' = [for timeZone in timeZones: {
  // Unique name based from resource group ID and appended timezone TZ
  // Could index timeZone to append numeric number to web app for shorter name
  name: replace('${webAppName}-${timeZone}', '/', '-')
  location: resourceGroup().location
  kind: 'app'
  properties: {
    serverFarmId: hostPlan.id
    siteConfig: {
      // Uses TZ database timezone format
      websiteTimeZone: timeZone
    }
  }
}]
