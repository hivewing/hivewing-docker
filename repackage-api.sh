
#! /bin/bash
pushd .
cd ../hivewing-api
LEIN_SNAPSHOTS_IN_RELEASE=override lein uberjar
popd

pushd .
cd api
cp ../../hivewing-api/target/*.uber.jar hivewing-api.uber.jar
./rebuild.sh
popd
