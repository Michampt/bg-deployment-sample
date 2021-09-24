#! /bin/bash
NEWCOLOR=$1

cp bg.yaml bgt.yaml
sed -i "s/\$SELECTOR/$NEWCOLOR/g" bgt.yaml
./minikube kubectl -- apply -f bgt.yaml
rm -f bgt.yaml
