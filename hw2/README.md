## 1. Project description
Twitter to GCP project it is a clouse to real time data pipeline that will get messages from the Twitter API and store them to 
BigTable and BigQuery for futher analizez.

The poject diagrame:

![alt text](https://github.com/OrestOhorodnyk/ucu-cloud-platforms-2021/blob/main/hw2/project_diagram.png?raw=true)


### Step 1 
Getting tweets from the Twitter API and forward them to the Pub/Sub topic

### Step 2 Pub/Sub as a buffer for tweets
With the Pub/Sub as a buffer the system will be more reliable and will not lose the tweets if next step in pipeline will fail for some reason.

### Step 3 the Dataflow
The dataflow job will read data from the Pub/Sub, transform it and store the data to the BigTable and BigQuery.

### Step 4 the BigQuery
The BigQuery will be a Data Warehouse for tweets and will be used for complex analytical queries for historical data.

### Step 5 The BigTable
The BigQuery will store data needed for getting close to real time reports for short period of time and very basic query. For such kind of data the retention period will be set for 90 days.