#!/bin/bash

for i in */; do 

pushd ${i}

regione=${i%/}

rm -rf .git
git init 
git add *
git commit -m "First commit"
git remote add origin "https://github.com/progettopulvirus/${regione}.git"
popd

done
