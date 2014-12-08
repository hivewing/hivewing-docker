#! /bin/bash
echo "Running $1"
sudo docker rm hivewing-images
sudo docker run --name hivewing-images --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env $1
#sudo docker run -i --name hivewing-images --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env $1 bash
