#! /bin/bash

docker build -t sample:v1 --build-arg VERSION=v1 .
docker build -t sample:v2 --build-arg VERSION=v2 .

if [ "$OS" == "Windows_NT" ]; then
    curl -Lo minikube.exe https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe
    ./minikube.exe start
    ./minikube.exe kubectl -- get po -A
fi

kubectl apply -f bg.yaml

cp app.yaml app-temp.yaml
sed -i 's/\$VER/v1/g' app-temp.yaml
sed -i 's/\$COLOR/blue/g' app-temp.yaml

kubectl apply -f app-temp.yaml
rm -f app-temp.yaml