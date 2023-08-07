param project string
@allowed([
  'dev'
  'stg'
  'prod'
])
param env string
param location string = resourceGroup().location
param deployment_id string
param contributor_principal_id string

<<<<<<< HEAD
//https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
var contributor = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
=======

//https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
var contributor = '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'

>>>>>>> e15dc70 (E2E Parking Sensor: Convert ARM templates to Bicep, Improve Deployment script, and bugfix #370 (#378))

resource databricks 'Microsoft.Databricks/workspaces@2018-04-01' = {
  name: '${project}-dbw-${env}-${deployment_id}'
  location: location
  tags: {
    DisplayName: 'Databricks Workspace'
    Environment: env
  }
  sku: {
    name: 'premium'
  }
  properties: {
<<<<<<< HEAD
    managedResourceGroupId: subscriptionResourceId('Microsoft.Resources/resourceGroups', '${project}-${deployment_id}-dbw-${env}-rg')
=======
    managedResourceGroupId: '${subscription().id}/resourceGroups/${project}-dbw-rg-${env}-${deployment_id}'
>>>>>>> e15dc70 (E2E Parking Sensor: Convert ARM templates to Bicep, Improve Deployment script, and bugfix #370 (#378))
  }
}

resource databricks_roleassignment 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: guid(databricks.id)
  scope: databricks
  properties: {
    roleDefinitionId: contributor
    principalId: contributor_principal_id
<<<<<<< HEAD
    principalType: 'ServicePrincipal'
=======
>>>>>>> e15dc70 (E2E Parking Sensor: Convert ARM templates to Bicep, Improve Deployment script, and bugfix #370 (#378))
  }
}

output databricks_output object = databricks
output databricks_id string = databricks.id
