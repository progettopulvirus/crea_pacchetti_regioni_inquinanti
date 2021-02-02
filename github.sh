#!/bin/bash

for i in */; do 

pushd ${i}

regione=${i%/}

git add *
git commit -m "Eliminato campo reporting_year, aggiunto campo giorno dd"
git push origin master

popd

done
