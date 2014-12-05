#! /bin/bash
echo "Running $1"
sudo docker run --name hivewing-images --link redis-dev:redis-dev --link ddb-dev:ddb-dev --link pg-dev:pg-dev --link sqs-dev:sqs-dev --link s3-dev:s3-dev --env-file development.env $1
