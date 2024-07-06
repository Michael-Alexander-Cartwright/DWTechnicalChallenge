@description('Set the hot storage name.')
module storageModule 'storage.bicep' = {
  name: 'storageModule'
  params: {
    storageName: '20240706stor'
  }
}
