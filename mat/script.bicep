var prefix = 'prod'

var regions = [
  'australiacentral'
  'australiaeast'
]

resource storageAccountProd 'Microsoft.Storage/storageAccounts@2023-05-01' = if (prefix == 'prod') {
  name: '20240706prod'
  location: first(regions)
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource storageAccountDev 'Microsoft.Storage/storageAccounts@2023-05-01' = if (prefix == 'dev') {
  name: '20240706dev'
  location: last(regions)
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
