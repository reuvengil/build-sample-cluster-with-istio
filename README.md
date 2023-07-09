# Create Sample Cluster with Istio Using Helm and Terraform

1. To build a cluster with Istio using **Helm** and **Terraform**, follow these steps:
    Build the myapp docker image:
    ```
    sudo chmod +x build.sh
    sudo ./build.sh
    ```
   - If you are using **minikube**, run the following command to create the cluster with the required resources for Istio:
     ```
     minikube start --memory=16384 --cpus=4 --nodes 3 --network-plugin=cni --cni=calico --kubernetes-version=v1.26.1
     ```
     It's important to allocate this amount of memory and CPU because Istio requires it.
     
     Additionally, run `minikube tunnel` to enable [Istio gateway](https://medium.com/globant/load-balance-microservices-using-kubernetes-minikube-88b78dae4796).
   
2. Install the necessary Istio components and gateway using **Terraform** and **Helm** by following these steps:
   ```
   cd istio-terraform
   terraform init
   terraform apply
   ```

3. Start using the provided examples.
   
   ## Example 1
   
   Execute the following command:
   ```
   kubectl apply -f 1-example
   ```
   
   In the file [0-namespace.yaml](./1-example/0-namespace.yaml), you will notice that we have defined `istio-injection: enabled`. This means that any pod created within the `staging` namespace will automatically have an Istio sidecar (envoy) added to it.
   
   Additionally, we have defined a destination rule to provide more information about the traffic to Istiod.
   
   In the file [5-virtual-service.yaml](./1-example/5-virtual-service.yaml), we use a virtual service to enable intelligent routing. This means that the traffic is not randomly routed, but rather 90% of the traffic is directed to v1 and 10% to v2. This type of deployment is known as a `canary deployment`.
   
   Now, let's test it. Since we are not using a gateway, we need to test it within the cluster. Run the following command:
   ```
   kubectl exec -it client -n backend -- sh
   ```
   
   Once inside the container, execute the command:
   ```
   while true; do curl http://first-app.staging:8080/api/devices && echo "" && sleep 1; done;
   ```
   
   This command will continuously send HTTP requests to `first-app`, and you will see that the routing works correctly.
   
   ## Example 2
   
   Execute the following command:
   ```
   kubectl apply -f 2-example
   ```
   
   You will notice that Example 2 is very similar to Example 1, with the only difference being that we now use the `istio-gateway`. This allows us to publish our services outside the cluster. To test it, simply run the command:
   ```
   curl --header "Host: app.devopsbyexample.com" http://localhost/api/devices
   ```
   
   If you are working with a real domain name, replace "app.devopsbyexample.com" with your domain name, and do not add the Host header to the request.
   
   This command will send an HTTP request to `second-app`, and you will see that the routing works correctly.