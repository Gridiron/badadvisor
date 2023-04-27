param environment string
param resourcePostfix string
param location string
param subnetId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'mytr${environment}${resourcePostfix}${location}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      virtualNetworkRules: [
        {
          id: subnetId
          action: 'Allow'
          state: 'Succeeded'
        }
      ]
    }
  }

}
