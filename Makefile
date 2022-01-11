FUNCTION_NAME=$(terraform output -raw function_name)

init:
	terraform init

deploy:
	terraform apply 

invoke:
	aws lambda invoke --function-name=${FUNCTION_NAME} response.json

destroy:
	terraform destroy

set-api-key:
	./set_api_key.sh

.PHONY: init deploy invoke destroy set-api-key