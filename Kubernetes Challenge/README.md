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
 
Step5: Deploy PHP service with Mongo db
Reference: https://kubernetes.io/docs/tutorials/stateless-application/guestbook/
