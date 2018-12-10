docker build -t docker387/multi-client:latest -t docker387/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t docker387/multi-server:latest -t docker387/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t docker387/multi-worker:latest -t docker387/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push docker387/multi-client:latest
docker push docker387/multi-server:latest
docker push docker387/multi-worker:latest

docker push docker387/multi-client:$SHA
docker push docker387/multi-server:$SHA
docker push docker387/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=docker387/multi-client:$SHA
kubectl set image deployments/server-deployment server=docker387/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=docker387/multi-worker:$SHA