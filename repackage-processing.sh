#! /bin/bash
pushd .
cd ../hivewing-processing
LEIN_SNAPSHOTS_IN_RELEASE=override lein uberjar
popd

pushd .
cd processing
cp ../../hivewing-processing/target/uberjar/*.uber.jar hivewing-processing.uber.jar
./rebuild.sh
popd
