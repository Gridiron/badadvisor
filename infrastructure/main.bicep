param config object

module vnet 'resources/vnet.bicep' = {
  name: 'vnet-deployment'
  params: {
    environment: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
  }
}

module storageAccount 'resources/storageAccount.bicep' = {
  name: 'storageAccount-deployment'
  params: {
    environment: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
    subnetId: vnet.outputs.subnetId
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    environment: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
    planConfig: config.planConfig
    vnetName: vnet.outputs.vnetName
    subnetId: vnet.outputs.subnetId
  }
}
