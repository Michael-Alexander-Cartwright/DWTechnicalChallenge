@minLength(3)
@maxLength(24)
param storageName string

param locationName string 

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: locationName
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

output storageEndpoint object = storageAccount.properties.primaryEndpoints
