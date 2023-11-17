# Logging in AZ Subscription Staging with TF SP #

#1 Setting env variables for TF
$RESOURCE_GROUP_NAME='tf-rg'
$STORAGE_ACCOUNT_NAME="tfstg055654770390"
$CONTAINER_NAME='tfstate'
$Env:ARM_TENANT_ID = "62f91faf-22cf-40e1-aa66-30dbbcba5355"
$Env:ARM_SUBSCRIPTION_ID = "9d1017be-3e3c-48f6-94ff-13047e872bbf"
# SP ID
$Env:ARM_CLIENT_ID = "e17f0ee5-8be6-48b3-b746-9dd37b2bf6bc"
# SP Secret
$Env:ARM_CLIENT_SECRET = "AnI8Q~0A0pw3f_YQmh0NKGdubMJwukiwStYFWdb6"

# Logging using the created TF SP
az login --service-principal -u $Env:ARM_CLIENT_ID -p $Env:ARM_CLIENT_SECRET --tenant $Env:ARM_TENANT_ID

# Retrive the STG Key 
$ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

# Using the account_key var and parsing to a TF env var
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY



