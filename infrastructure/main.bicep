param config object

module storageAccount 'resources/storageAccount.bicep' = {
  name: 'storageAccount-deployment'
  params: {
    environment: config.environment.value
    resourcePostfix: config.resourcePostfix.value
    location: config.location.value
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    environment: config.environment.value
    resourcePostfix: config.resourcePostfix.value
    location: config.location.value
    planConfig: config.planConfig
  }
}
