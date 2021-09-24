#! /bin/bash

function longPoll() {
	echo "" > result
	for i in {1..20}; do
		curl -s $1/version >> result
		sleep 1
	done
}

echo "Downloading MiniKube"
curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o minikube > /dev/null

echo "Starting MiniKube"
chmod +x minikube
./minikube start --force > /dev/null

echo "Building sample docker images"
eval $(./minikube docker-env)
docker build -t sample:v1 --build-arg VERSION=v1 . > /dev/null
docker build -t sample:v2 --build-arg VERSION=v2 . > /dev/null

echo "Deploying applications"
./minikube kubectl -- apply -f app.yaml

echo "Starting the LB initially pointing to Blue (v1)"
./swap.sh blue

URL=$(./minikube service bg-sample --url)

echo "Polling app"
longPoll $URL &
POLL_PID=$!

# Give the poll some time to have some output
sleep 5

# Swap to the green deployment
echo "Swapping to green"
./swap.sh green
sleep 5

# Swap back to blue as if it was a rollback
echo "Rolling back to blue"
./swap.sh blue

# Wait until the polling is done
tail --pid=$POLL_PID -f /dev/null

echo "Viewing results"

cat ./result
