# Prerequisites: 
## 1) Enabled Cloud Function 
## 2) Enabled Cloud Build API 
## 3) Service account key.json is pleased to terraform/key folder. Required roles: Cloud Functions Admin, 
## 4) update the ucu-cloud-platforms-2021/hw2/task2/terraform/src/variable.tf with correct values.


# How to run
## 1) cd ucu-cloud-platforms-2021/hw2/task2/terraform/src
## 2) terraform init
## 3) terraform apply
## 4) Generate JWT tocken:
### * login to gcloud conol with service account that has the `Cloud Functions Invoker` role (e. g. `gcloud auth activate-service-account test-service-account@google.com --key-file=/path/key.json --project=testproject`)
### * get the JWT tocken `gcloud auth print-identity-token`
## 5) now you can query the function:
   ```curl --location --request POST '<the function url>' \
--header 'Authorization: bearer <the JWT here>' \
--header 'Content-Type: application/json' \
--data-raw '{
    "body":"some alue here"
}'```