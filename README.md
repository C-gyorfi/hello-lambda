# 🪐 Terraform AWS Lambda starter with API Gateway

Started this project based on the [HashiCorp guidance](https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway?in=terraform/aws).

### Initialization 📦
```bash
make init
```

### Deploy 🚀
```
make deploy
```

### Call the API 🔌 
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

### Run tests 🧪 
```bash
make test
```

### Tear down 💥 
```bash
make destroy
```