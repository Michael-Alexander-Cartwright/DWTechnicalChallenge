// This "web plan" was developed to assist with modelling the scenario and to help test.
// Designed as a seperate template as per the question.

// Generate unique string for web serverfarm to prevent name conflicts using resource group
var webServicePlanName = toLower('webplan-winos-${uniqueString(resourceGroup().id)}')

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

output hostPlanID string = hostPlan.id
output hostPlanName string = hostPlan.name
