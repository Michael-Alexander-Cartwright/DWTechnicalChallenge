var prefix = 'dw'
var storageName = '${prefix}20240706storage'

var regions = [
  'australiacentral'
  'australiaeast'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = [for (region,i) in regions: {
  name: '${storageName}${i}'
  location: region
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}]
