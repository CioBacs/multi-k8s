docker build -t ciobacs/multi-client:latest -t ciobacs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ciobacs/multi-server:latest -t ciobacs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ciobacs/multi-worker:latest -t ciobacs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ciobacs/multi-client:latest
docker push ciobacs/multi-server:latest
docker push ciobacs/multi-worker:latest
docker push ciobacs/multi-client:$SHA
docker push ciobacs/multi-server:$SHA
docker push ciobacs/multi-worker:$SHA
kubectl apply -f k8
kubectl set image deployments/server-deployment server=ciobacs/multi-server:$SHA
kubectl set image deployments/client-deployment client=ciobacs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ciobacs/multi-worker:$SHA
