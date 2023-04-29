param environment string
param resourcePostfix string
param location string
param planConfig object
param vnetName string
param subnetId string

resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'plan-badadvisor-${environment}-${resourcePostfix}'
  location: location
  sku: {
    tier: planConfig.skuTier
    name: planConfig.skuName
  }
  kind: 'linux'
  properties: {
    maximumElasticWorkerCount: 1
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: 'appservice-badadvisor-${environment}-${resourcePostfix}'
  location: location
  properties: {
    serverFarmId: plan.id
    enabled: true
    siteConfig: {
      appSettings: [
        {
          name: 'StorageAccountUrl'
          value: 'https://mytrdevmiseastus.table.core.windows.net/'
        }
        {
          name: 'StorageAccountAccessKey'
          value: 'n0fBxmUDpt4keLNQktvn2Xzk+2bXjtpE6aHbZ1/XBVKQgb76WMFrA6Uc31gZ4Dox22bRtDH9kazI+AStKmSf8w=='
        }
      ]
      linuxFxVersion: 'DOTNETCORE|6.0'
      alwaysOn: true
      vnetName: vnetName
      vnetRouteAllEnabled: true
    }
    virtualNetworkSubnetId: subnetId
  }
}
