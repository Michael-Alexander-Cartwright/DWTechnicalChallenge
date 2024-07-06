param servFarmName string

// Generate unique string for web apps to prevent name conflicts using resource group
var webAppName = toLower('webapp-winos-${uniqueString(resourceGroup().id)}')

// Being creative and simplistic here to spawn three web apps on Azure
// One being 'Brisbane Australia' 
var timeZones = [
  'Australia/Brisbane'
  'Australia/Melbourne'
  'Australia/Hobart'
]

resource webApp 'Microsoft.Web/sites@2023-12-01' = [for timeZone in timeZones: {
  // Unique name based from resource group ID and appended timezone TZ
  // Could index timeZone to append numeric number to web app for shorter name
  name: replace('${webAppName}-${timeZone}', '/', '-')
  location: resourceGroup().location
  kind: 'app'
  properties: {
    serverFarmId: '/subscriptions/${subscription().id}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Web/serverfarms/${servFarmName}'
    siteConfig: {
      // Uses TZ database timezone format
      websiteTimeZone: timeZone
    }
  }
}]
