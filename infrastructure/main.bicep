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
