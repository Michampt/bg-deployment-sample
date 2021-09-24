#! /bin/bash

docker build -t sample:v1 --build-arg VERSION=v1 .
docker build -t sample:v2 --build-arg VERSION=v2 .

curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o minikube

chmod +x minikube
./minikube start
./minikube kubectl -- get po -A

kubectl apply -f bg.yaml

cp app.yaml app-temp.yaml
sed -i 's/\$VER/v1/g' app-temp.yaml
sed -i 's/\$COLOR/blue/g' app-temp.yaml

kubectl apply -f app-temp.yaml
rm -f app-temp.yaml
