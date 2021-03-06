# ๐ช Terraform AWS Lambda starter with API Gateway

Started this project based on the [HashiCorp guidance](https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway?in=terraform/aws).

### Initialization ๐ฆ
```bash
make init
```

### Deploy ๐
```
make deploy
```

### Call the API ๐ 
```bash
export HELLO_API_KEY=$(bash ./set_api_key.sh)
```

```bash
curl -H "Content-Type: application/json" \
  -H "Authorization: Bearer $HELLO_API_KEY" \
  -X GET \
  -i \
  "$(terraform output -raw base_url)/hello"
```

### Run tests ๐งช 
```bash
make test
```

### Tear down ๐ฅ 
```bash
make destroy
```