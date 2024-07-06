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
