#! /bin/bash

echo "Running hivewing.io/api"
sudo docker rm -f hivewing-api
sudo docker run -d -p 5000:3000 --name hivewing-api --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/api
#sudo docker run -i --name hivewing-api --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/api bash

echo "Running hivewing.io/control"
sudo docker rm -f hivewing-control
sudo docker run -d -p 6000:4000 --name hivewing-control --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/control
#sudo docker run -i --name hivewing-control --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/control bash

echo "Running hivewing.io/web"
sudo docker rm -f hivewing-web
sudo docker run -d -p 8000:3000 --name hivewing-web --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/web
#sudo docker run -i -p 8000:3000 --name hivewing-web --link redis-dev:redis --link ddb-dev:ddb --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env hivewing.io/web bash

echo "*********************************************************************************"
echo "*********************************************************************************"
echo "*********************************************************************************"
echo " API Server running on "
echo "     localhost:5000"
echo ""
echo " Control Server running on "
echo "     localhost:6000"
echo ""
echo " Web Server running on "
echo "     localhost:8000"
echo "*********************************************************************************"
echo "*********************************************************************************"
echo "*********************************************************************************"
