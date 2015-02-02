#! /bin/bash
pushd .
cd ../hivewing-spokesman
LEIN_SNAPSHOTS_IN_RELEASE=override lein uberjar
popd

pushd .
cd spokesman
cp ../../hivewing-spokesman/target/uberjar/*.uber.jar hivewing-spokesman.uber.jar
./rebuild.sh

popd
