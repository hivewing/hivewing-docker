#! /bin/bash
echo "Running hivewing.io/images"
sudo docker rm -f hivewing-images
sudo docker run -d -p 5022:22 --name hivewing-images --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/images
#sudo docker run -i            --name hivewing-images --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/images bash

echo "Running hivewing.io/api"
sudo docker rm -f hivewing-api
sudo docker run -d -p 5000:3000 --name hivewing-api --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/api
#sudo docker run -i --name hivewing-api --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/api bash

echo "*********************************************************************************"
echo "*********************************************************************************"
echo "*********************************************************************************"
echo " Images Server running ssh on "
echo "     localhost:5022"
echo ""
echo " API Server running on "
echo "     localhost:5000"
echo "*********************************************************************************"
echo "*********************************************************************************"
echo "*********************************************************************************"
