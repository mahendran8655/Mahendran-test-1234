Step1: set project id
gcloud config set project test_project

Step2:
Create kubernetes cluster
gcloud container clusters create test-cluster \
    --zone us-central1-a \
    --node-locations us-central1-a,us-central1-b,us-central1-c
   
Step3: 
connect the cluster
gcloud container clusters get-credentials test-cluster

Step4:
 Create namepace 
 kubectl create ns development
 
Step5: Deploy guest book

Step 5.1: Deploy Mongo DB
kubectl apply -f mongo-deployment.yaml
Step 5.2: kubectl get pods -n development
Step5.3:
Deploy the mondo db service
kubectl apply -f mongo-service.yaml
kubectl get service -n development
step5.4:
kubectl apply -f frontend-deployment.yaml
kubectl get services -n development
step5.5:
port forward in terminal
kubectl port-forward svc/frontend 8080:80

**Installing Helm:**
Step1:
cd /tmp
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
Step2:
chmod u+x install-helm.sh
./install-helm.sh

Step3: Installing Tiller
kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller

helm init --service-account tiller

kubectl get pods --namespace kube-system

Step4: Installing a Helm Chart
helm install stable/kubernetes-dashboard --name dashboard-demo
helm list
kubectl get services

Step5: Updating a Release
helm upgrade dashboard-demo stable/kubernetes-dashboard --set fullnameOverride="dashboard"
kubectl get services

**Prometheus Setup**
1)kubectl create namespace monitoring or kubectl create ns monitoring

2)Create a file named clusterRole.yaml 
kubectl create -f clusterRole.yaml
3) Create configmap, deployment and service
kubectl create -f config-map.yaml
kubectl create  -f prometheus-deployment.yaml 
kubectl create -f prometheus-service.yaml --namespace=monitoring
kubectl port-forward <prometheus-pod-name> 8080:9090 -n monitoring
kubectl create -f ingress-controller.yaml

****Grafana Setup****

Create configmap, deployment, service
kubectl create -f grafana-datasource-config.yaml
kubectl create -f deployment.yaml
kubectl create -f service.yaml
kubectl port-forward -n monitoring <grafana-pod-name> 3000 &
    

**ELK**
 
Step1: Helm init

Step2: Deploying Elastic search 
    Helm repo add elastic https://Helm.elastic.co
Step3:
    Install the Elasticsearch Helm chart using the configuration
    Helm install --name elasticsearch elastic/elasticsearch -f helm-config.yaml 
    
Step4: deploy kibana
    Helm install --name kibana elastic/kibana 
    
STep5: 
    Helm install --name metricbeat elastic/metricbeat
    



Reference: https://kubernetes.io/docs/tutorials/stateless-application/guestbook/
https://www.digitalocean.com/community/tutorials/how-to-install-software-on-kubernetes-clusters-with-the-helm-2-package-manager

