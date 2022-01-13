FUNCTION_NAME=$(terraform output -raw function_name)

init:
	terraform init

deploy:
	terraform apply 

invoke:
	aws lambda invoke --function-name=${FUNCTION_NAME} response.json

destroy:
	terraform destroy

.PHONY: init deploy invoke destroy
