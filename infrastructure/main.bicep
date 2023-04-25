param planConfig object

module storageAccount 'resources/storageAccount.bicep' = {
  name: 'storageAccount-deployment'
  params: {
    environment: planConfig.environment
    resourcePostfix: planConfig.resourcePostfix
    location: planConfig.location
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    environment: planConfig.environment
    resourcePostfix: planConfig.resourcePostfix
    location: planConfig.location
    planConfig: planConfig
  }
}
