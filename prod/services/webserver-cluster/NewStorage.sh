
$RESOURCE_GROUP_NAME='tf-resources'
$STORAGE_ACCOUNT_NAME="tfstgam555051"
$CONTAINER_NAME='prod'

# Create RG
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create STG
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku STANDARD_LRS --encryption-service blob

# Create Blob Container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# Get stg access key and store it as an ENV
$ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY