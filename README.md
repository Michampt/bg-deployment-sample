## Simple Blue / Green deployment demonstration

Requirements:  

- Linux
- Docker

After cloning this repo, you can run the whole project from A to B with ```./start.sh```  
This will:  

- Download and install/start MiniKube
- Create 2 docker images: ```sample:v1``` and ```sample:v2```
- Publish both images to the minikube image repository
- Create replication sets for apps ```blue``` and ```green```
- Create a Service pointing to ```blue```
- Expose and poll the service endpoint for 20 seconds meanwhile swapping the service to the ```green``` deployment, and then back to ```blue```
- The results of the polling are output to a file named ```results``` and displayed on screen once the polling finishes

After the run you may also poll the endpoint as you see fit by first running ```./minikube service bg-sample --url``` to retrieve the url. To swap the service back and forth between ```blue``` and ```green``` you can run  
```./swap.sh blue```
```./swap.sh green```
