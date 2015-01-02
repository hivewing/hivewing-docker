#! /bin/bash

pushd .
cd images
./rebuild.sh
popd

pushd .
cd api
./rebuild.sh
popd

pushd .
cd web
./rebuild.sh
popd

pushd .
cd control
./rebuild.sh
popd
