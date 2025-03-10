wget https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/7.10.0/openapi-generator-cli-7.10.0.jar

java -jar openapi-generator-cli-7.10.0.jar generate -i openapi.json  -g python-pydantic-v1 -o python_v1


