docker build -t mckoi03/multi-client:latest -t mckoi03/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mckoi03/multi-server:latest -t mckoi03/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mckoi03/multi-worker:latest -t mckoi03/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mckoi03/multi-client:latest
docker push mckoi03/multi-server:latest
docker push mckoi03/multi-worker:latest

docker push mckoi03/multi-client:$SHA
docker push mckoi03/multi-server:$SHA
docker push mckoi03/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mckoi03/multi-server:$SHA
kubectl set image deployments/client-deployment client=mckoi03/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mckoi03/multi-worker:$SHA