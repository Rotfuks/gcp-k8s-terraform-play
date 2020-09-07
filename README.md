# GCP K8S + Terraform Testproject
This is a test to automatically create a kubernetes cluster on google cloud platform via terraform.

### Make this test run
In order to try it out yourself you first have to setup a project on gcp. 
You can create a free tier or use the free credits you get when creating an account for the first time.
This project is focused on trying to be as cheap as possible :) 

##### Download the clis
First you will need the [terraform](https://www.terraform.io/downloads.html) cli to run the scripts.
Checkout the explanations from HashiCorp on how to set it up.

Also you need the [gcloud](https://cloud.google.com/sdk/downloads) and 
[kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) clis for accessing your cloud environment and the k8s cluster.

##### Get your Service Account Key
Go to your gcp project (or create one) and create an service account for this example. 
Generate a key from the service account in json format and save it in the /infa folder. 
It is expected to be named *gcp-service-key.json*.

##### Build and push the docker image
In order to have something to deploy, you can build and push the docker image in the /app folder into the gcr.
It's just a basic application posting a message on *localhost:3000* (and later in your k8s engine).
Check out [this explanation](https://cloud.google.com/container-registry/docs/pushing-and-pulling) on how to build and push docker images into the gcr.

##### Make your GCR Repo public
To make it easier to pull the image you have to make the repository you pushed the app to public.
Else terraform will not be able to pull the image from your repository. 
You can do this in the Configuration of the GCR on *console.cloud.google.com*

##### Fill out the variables
Last but not least you have to fill out the variables in *infra/main.tf*. 
Keep the Defaults but Type in everything that is surrounded with `<>`.
 
### Run this Test
Start in the */infra* directory and run 
```
$ terraform plan
```
To verify if everything is set and working properly - usually here terraform will list what it is planning to do.
Verify all changes. 

Afterwards you can run
```
$ terraform apply
```
to start creating your environment. This can take some times (>5minutes).
After some time you can already see on your cloud console that the k8s cluster is being created.

When everything is run successful you can verify your cluster, the services and your app already!

### Check your app
You can find out your freshly created ip-address with your orchestrated app-container via
```
$ gcloud auth activate-service-account  --key-file gcp-service-key.json
$ gcloud container clusters get-credentials rotfuks-cluster --region us-central1 --project <PROJECT_ID>
$ kubectl get services
```
Then access the app with 
```
http://${public-ip-from-the-service}:3000
```
