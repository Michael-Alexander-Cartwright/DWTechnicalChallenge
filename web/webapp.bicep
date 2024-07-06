resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: 'webapp-test'
  location: 'australiaeast'
  kind: 'app'
  properties: {
    serverFarmId: 'ab14cf7f-0e93-482b-a23d-1486fb7a3e7d'
  }
}
