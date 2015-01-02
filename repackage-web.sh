#! /bin/bash
pushd .
cd ../hivewing-web
LEIN_SNAPSHOTS_IN_RELEASE=override lein uberjar
popd

pushd .
cd web
cp ../../hivewing-web/target/uberjar/*.uber.jar hivewing-web.uber.jar
./rebuild.sh

popd

./start-services.sh
