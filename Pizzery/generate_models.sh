# generate swagger models
/opt/homebrew/bin/openapi-generator generate \
    -i swagger.yaml \
    -g swift5 \
    --global-property models,modelDocs=false \
    --model-package openapi \
    --additional-properties=swiftPackagePath="Models/" \
    --additional-properties=useJsonEncodable=false \
    --additional-properties=validatable=false
