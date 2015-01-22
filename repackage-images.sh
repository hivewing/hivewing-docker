
#! /bin/bash
pushd .
cd ../hivewing-images
LEIN_SNAPSHOTS_IN_RELEASE=override lein uberjar
popd

pushd .
cd images
cp ../../hivewing-images/target/uberjar/*.uber.jar hivewing-images.uber.jar
./rebuild.sh

popd
