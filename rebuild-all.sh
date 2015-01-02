#! /bin/bash


for dir in images api web control
do
    pushd .
    cd $dir
    ./rebuild.sh
    popd
done
