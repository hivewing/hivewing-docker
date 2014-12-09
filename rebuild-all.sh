#! /bin/bash

pushd .
cd images
./rebuild.sh
popd

pushd .
cd api
./rebuild.sh
popd
