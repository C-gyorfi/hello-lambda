# 🪐 Terraform AWS Lambda starter with API Gateway

Started this project based on the [HashiCorp guidance](https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway?in=terraform/aws).

## Initialization
```bash
make init
```

### Deploy
```
make deploy
```

### Call the API:
```bash
curl -H "Content-Type: application/json" \
  -H "Authorization: Bearer [ACCESS_TOKEN]" \
  -X GET \
  -i \
  "$(terraform output -raw base_url)/hello"
```

### Tear down
```bash
make destroy
```