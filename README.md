# Creating a docker image
  https://www.digitalocean.com/community/tutorials/docker-explained-how-to-create-docker-containers-running-memcached

# Core Services

* Redis
  * pub/sub
* SQS
* S3
* DynamoDB
* Postgresql

# Applications

* Hivewing-Images
  * docker run --name hivewing-images
    --link redis-dev:redis \
    --link sqs-dev:sqs \
    --link ddb-dev:ddb \
    --link pg-dev:pg \
    --link s3-dev:s3 \
    --env-file ../development.env <the-ref-of-the-build>

# Running
You need to start them up in this order.

## Redis
  * docker run --name redis-dev  -p 3900:6379 redis:latest
  * docker run --name redis-test -p 3901:6379 redis:latest

## Fake SQS
  * docker run --name sqs-dev  -p 4100:4568 caryfitzhugh/spurious-sqs
  * docker run --name sqs-test -p 4101:4568 caryfitzhugh/spurious-sqs

## Fake S3
  * docker run --name s3-dev -p 4200:4569 smaj/spurious-s3
  * docker run --name s3-test -p 4201:4569 smaj/spurious-s3

# DynamoDB
  * docker run --name ddb-dev -p 3800:4570 smaj/spurious-dynamo
  * docker run --name ddb-test -p 3801:4570 smaj/spurious-dynamo

# Postgresql
  * docker run --name pg-dev -p 4300:5432 -e POSTGRES_PASSWORD=hivewing -e POSTGRES_USER=hivewing -d postgres:latest
  * docker run --name pg-test -p 4301:5432 -e POSTGRES_PASSWORD=hivewing -e POSTGRES_USER=hivewing -d postgres:latest
