#! /bin/bash
pushd .
cd ../hivewing-processing
LEIN_SNAPSHOTS_IN_RELEASE=override lein uberjar
popd

pushd .
cd processing
cp ../../hivewing-processing/target/*.uber.jar hivewing-processing.uber.jar
./rebuild.sh
popd

./start-core.sh
./start-services.sh
