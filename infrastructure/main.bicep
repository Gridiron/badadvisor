param config object

module storageAccount 'resources/storageAccount.bicep' = {
  name: 'storageAccount-deployment'
  params: {
    environment: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    environment: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
    planConfig: config.planConfig
  }
}

module vnetService 'resources/vnet.bicep' = {
  name: 'vnet-deployment'
  params: {
    environment: config.environment
    resourcePostfix: config.resourcePostfix
    location: config.location
  }
}
