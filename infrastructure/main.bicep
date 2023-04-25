@allowed([
  'dev'
  'prod'
])
param environment string
param resourcePostfix string
param location string = 'eastus'

module storageAccount 'resources/storageAccount.bicep' = {
  name: 'storageAccount-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix
    location: location
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix
    location: location
  }
}
