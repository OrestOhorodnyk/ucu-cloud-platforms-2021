## *Prerequisites*: 
1. Enabled Cloud Function 
1. Enabled Cloud Build API 
1. Cteate a bucket and a folder for terraform state (e. g. terraform-32141312/state)
1. Service account key.json is pleased to terraform/key folder. Required roles: Cloud Functions Admin, 
1. update the `ucu-cloud-platforms-2021/hw2/task2/terraform/src/variable.tf` with correct values.


## *How to run*
1. cd `ucu-cloud-platforms-2021/hw2/task2/terraform/src`
1. run 
`terraform init`
1. run
`terraform apply`
1.  Generate JWT tocken:
	1. login to gcloud conol with service account that has the `Cloud Functions Invoker` role (this command may be used to login with the SA `gcloud auth activate-service-account test-service-account@google.com --key-file=/path/key.json --project=testproject`)
	1. get the JWT tocken `gcloud auth print-identity-token`
1. now you can query the function:

```
curl --location --request POST '<the function url>' \
--header 'Authorization: bearer <the JWT here>' \
--header 'Content-Type: application/json' \
--data-raw '{
    "body":"some alue here"
}'
```

## *The Screenshots*
1. Function is deployed to your cloud account

	![alt text](https://github.com/OrestOhorodnyk/ucu-cloud-platforms-2021/blob/main/hw2/task2/screenshots/code.png?raw=true)

1. Function could be triggered via HTTP request

	![alt text](https://github.com/OrestOhorodnyk/ucu-cloud-platforms-2021/blob/main/hw2/task2/screenshots/with-jwt.png?raw=true)

1. Function does not allow anonymous access

	![alt text](https://github.com/OrestOhorodnyk/ucu-cloud-platforms-2021/blob/main/hw2/task2/screenshots/no-jwt.png?raw=true)

1. Content of a request is stored as json file in Object Store and New requests does not override any file in Object Store

	![alt text](https://github.com/OrestOhorodnyk/ucu-cloud-platforms-2021/blob/main/hw2/task2/screenshots/gcs.png?raw=true)
	![alt text](https://github.com/OrestOhorodnyk/ucu-cloud-platforms-2021/blob/main/hw2/task2/screenshots/content1.png?raw=true)
	![alt text](https://github.com/OrestOhorodnyk/ucu-cloud-platforms-2021/blob/main/hw2/task2/screenshots/content2.png?raw=true)