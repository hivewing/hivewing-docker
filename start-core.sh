#! /bin/bash
DOCKER_PWD=`pwd`
echo "Starting Redis"
sudo docker rm -f redis-dev
sudo docker run -d --name redis-dev -p 3900:6379 redis:latest
sudo docker rm -f redis-test
sudo docker run -d --name redis-test -p 3901:6379 redis:latest

echo "Starting SQS"
sudo docker rm -f sqs-dev
sudo docker run -d --name sqs-dev -p 4100:4568 caryfitzhugh/spurious-sqs
sudo docker rm -f sqs-test
sudo docker run -d --name sqs-test -p 4101:4568 caryfitzhugh/spurious-sqs

echo "Starting PG"
sudo docker rm -f pg-dev
sudo docker run --name pg-dev -p 4300:5432  -e POSTGRES_PASSWORD=hivewing -e POSTGRES_USER=hivewing -d postgres
sudo docker rm -f pg-test
sudo docker run --name pg-test -p 4301:5432 -e POSTGRES_PASSWORD=hivewing -e POSTGRES_USER=hivewing -d postgres

echo "Starting DDB"
sudo docker rm -f ddb-dev
sudo docker run -d --name ddb-dev -p 3800:4570  smaj/spurious-dynamo
sudo docker rm -f ddb-test
sudo docker run -d --name ddb-test -p 3801:4570 smaj/spurious-dynamo

echo "Starting S3"
sudo docker rm -f s3-dev
sudo docker run -d --name s3-dev -p 4200:4569 smaj/spurious-s3
sudo docker rm -f s3-test
sudo docker run -d --name s3-test -p 4201:4569 smaj/spurious-s3

echo "Waiting..."
echo "waiting for things to spin up..."
until nc -z localhost 3900 </dev/null; do sleep 0.1; done
until nc -z localhost 3901 </dev/null; do sleep 0.1; done
echo "Redis up"

until nc -z localhost 4100 </dev/null; do sleep 0.1; done
until nc -z localhost 4101 </dev/null; do sleep 0.1; done
echo "SQS up"

until nc -z localhost 4300 </dev/null; do sleep 0.1; done
until nc -z localhost 4301 </dev/null; do sleep 0.1; done
echo "PG up"

until nc -z localhost 3800 </dev/null; do sleep 0.1; done
until nc -z localhost 3801 </dev/null; do sleep 0.1; done
echo "DDB up"

until nc -z localhost 4200 </dev/null; do sleep 0.1; done
until nc -z localhost 4201 </dev/null; do sleep 0.1; done
echo "S3 up"

echo "Spun up!"

# Migrate the DB
pushd .
  echo "Migrating test database"
  cd ../hivewing-core
  lein with-profile test ragtime migrate #--database jdbc:postgresql:$HIVEWING_SQL_CONNECTION_STRING
popd

# Migrate the DB
pushd .
  echo "Migrating database"
  cd ../hivewing-core
  lein ragtime migrate #--database jdbc:postgresql:$HIVEWING_SQL_CONNECTION_STRING

  echo "Setup AWS"
  lein setup-aws

  echo "Seeding DB with admin@example.com"
  lein seed "admin@example.com" $DOCKER_PWD/ssh/admin@example.com.public 12345678-1234-1234-1234-123456789012
popd

echo "Done..."
