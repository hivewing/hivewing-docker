#! /bin/bash
echo "Running hivewing.io/images"
sudo docker rm -f hivewing-images
sudo docker run -d -p 5022:22 --name hivewing-images --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env -e SSH_KEY="`cat ~/.ssh/id_rsa.pub`" hivewing.io/images
#sudo docker run -i  -p 5022:22 --name hivewing-images --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/images bash

echo "Running hivewing.io/api"
sudo docker rm -f hivewing-api
sudo docker run -d -p 5000:3000 --name hivewing-api --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/api
#sudo docker run -i --name hivewing-api --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/api bash

echo "Running hivewing.io/control"
sudo docker rm -f hivewing-control
sudo docker run -d -p 6000:4000 --name hivewing-control --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/control
#sudo docker run -i --name hivewing-control --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/control bash

echo "*********************************************************************************"
echo "*********************************************************************************"
echo "*********************************************************************************"
echo " Images Server running ssh on "
echo "     localhost:5022"
echo ""
echo " API Server running on "
echo "     localhost:5000"
echo ""
echo " Control Server running on "
echo "     localhost:6000"
echo "*********************************************************************************"
echo "*********************************************************************************"
echo "*********************************************************************************"
