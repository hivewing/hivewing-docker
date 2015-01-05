#! /bin/bash
pushd .
cd ../hivewing-control
LEIN_SNAPSHOTS_IN_RELEASE=override lein uberjar
popd

pushd .
cd control
cp ../../hivewing-control/target/uberjar/*.uber.jar hivewing-control.uber.jar
./rebuild.sh

popd

./start-services.sh
