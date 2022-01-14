FUNCTION_NAME=$(terraform output -raw function_name)

init:
	terraform init && poetry install

deploy:
	terraform apply 

invoke:
	aws lambda invoke --function-name=${FUNCTION_NAME} response.json

destroy:
	terraform destroy

test:
	poetry run pytest

.PHONY: init deploy invoke destroy test
