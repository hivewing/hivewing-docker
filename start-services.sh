#! /bin/bash
CUR_PWD=`pwd`
echo "Setting logs dir permissions..."
sudo rm -rf logs/hivewing-api.log
sudo touch logs/hivewing-api.log
sudo rm -rf logs/hivewing-control.log
sudo touch logs/hivewing-control.log
sudo rm -rf logs/hivewing-web.log
sudo touch logs/hivewing-web.log
sudo chmod 777 -R logs

echo "Running hivewing.io/api"
sudo docker rm -f hivewing-api
sudo docker run -d -p 5000:3000 --name hivewing-api --link redis-dev:redis  --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env -v $CUR_PWD/logs/hivewing-api.log:/home/hivewing/hivewing-api.log hivewing.io/api
#sudo docker run -i -p 5000:3000 --name hivewing-api --link redis-dev:redis  --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env -v $CUR_PWD/logs:/home/hivewing/logs hivewing.io/api bash

echo "Running hivewing.io/control"
sudo docker rm -f hivewing-control
sudo docker run -d -p 6000:6000 --name hivewing-control --link redis-dev:redis  --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env -v $CUR_PWD/logs/hivewing-control.log:/home/hivewing/hivewing-control.log hivewing.io/control
#sudo docker run -i -p 6000:6000 --name hivewing-control --link redis-dev:redis  --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env -v $CUR_PWD/logs/hivewing-control.log:/home/hivewing/hivewing-control.log hivewing.io/control

echo "Running hivewing.io/web"
sudo docker rm -f hivewing-web
sudo docker run -d -p 8000:3000 --name hivewing-web --link redis-dev:redis  --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env -v $CUR_PWD/logs/hivewing-web.log:/home/hivewing/hivewing-web.log hivewing.io/web
#sudo docker run -i -p 8000:3000 --name hivewing-web --link redis-dev:redis  --link pg-dev:pg --link sqs-dev:sqs --link s3-dev:s3 --env-file container.env -v $CUR_PWD/logs/hivewing-web.log:/home/hivewing/hivewing-web.log hivewing.io/web

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
