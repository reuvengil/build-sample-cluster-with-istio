create cluster
```
minikube start --memory=16384 --cpus=4 --nodes 3 --network-plugin=cni --cni=calico --kubernetes-version=v1.26.1
```
```
kubectl exec -it client -n backend -- sh
```
```
while true; do curl http://first-app.staging:8080/api/devices && echo "" && sleep 1; done;
```
```
helm search repo istio/gateway
```
```
helm show values istio/gateway --version 1.18.0 > helm-defaults/gateway-default.yaml
```