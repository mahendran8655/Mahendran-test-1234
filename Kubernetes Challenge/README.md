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

2)Create a file named clusterRole.yaml and copy the following RBAC role.
















Reference: https://kubernetes.io/docs/tutorials/stateless-application/guestbook/
https://www.digitalocean.com/community/tutorials/how-to-install-software-on-kubernetes-clusters-with-the-helm-2-package-manager

