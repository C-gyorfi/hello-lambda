# 🪐 Terraform AWS Lambda starter with API Gateway

Created this project based on the [HashiCorp guidance](https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway?in=terraform/aws).

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
curl "$(terraform output -raw base_url)/hello"
```

### Tear down
```bash
make destroy
```