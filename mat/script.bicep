resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '20240706teststorage'
  location: 'australiaeast'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
