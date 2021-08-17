provider "google" {
  credentials = file("${path.root}/../key/key.json")
  project = var.project
  region  = var.region
  zone    = var.zone
}

# terraform {
#   backend "gcs" {
#     bucket = "terraform-321412"
#     prefix = "state"
# }
# }


# resource "google_storage_bucket" "source_code" {
#   name          = var.source_code
#   location      = "US"
#   force_destroy = true

#   lifecycle_rule {
#     condition {
#       age = 3
#     }
#     action {
#       type = "Delete"
#     }
#   }
# }

data "archive_file" "app_zipped" {
  type        = "zip"
  output_path = "${path.root}/../../app.zip"

  source {
      content  = "${path.root}/../../app/__init__.py"
      filename = "__init__.py"
    }
  source {
      content  = "${path.root}/../../app/keys.py"
      filename = "keys.py"
    }
  source {
      content  = "${path.root}/../../app/main.py"
      filename = "main.py"
    }

  source {
      content  = "${path.root}/../../app/publisher.py"
      filename = "publisher.py"
    }


  source {
    content  = "${path.root}/../../app/publisher.py"
    filename = "publisher.py"
  }

  source {
    content  = "${path.root}/../../app/publisher.py"
    filename = "publisher.py"
}

  source {
    content  = "${path.root}/../../app/requirements.txt"
    filename = "requirements.txt"
}

  source {
    content  = "${path.root}/../../app/tweetListener.py"
    filename = "tweetListener.py"
}
}

resource "google_storage_bucket" "app-files" {
  name          = "app-files_${var.project}"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket_object" "source-code" {
  name   = "app.zip"
  source = "${path.root}/../../app.zip"
  bucket = "${google_storage_bucket.app-files.name}"
}


# resource "google_storage_bucket" "function-files" {
#   name          = "function-files_${var.project}"
#   location      = "US"
#   force_destroy = true

#   lifecycle_rule {
#     condition {
#       age = 3
#     }
#     action {
#       type = "Delete"
#     }
#   }
# }

# resource "google_storage_bucket_object" "archive" {
#   name   = "index.zip"
#   bucket = google_storage_bucket.bucket.name
#   source = "/workspaces/ucu-cloud-platforms-2021/hw2/task2/cloud-function/index.zip"
# }

# resource "google_cloudfunctions_function" "function" {
#   name        = "create-file-on-gcs"
#   description = "Functions store request body to a file on GCS"
#   runtime     = "python39"
#   project     = "${var.project}"

#   available_memory_mb   = 256
#   source_archive_bucket = google_storage_bucket.bucket.name
#   source_archive_object = google_storage_bucket_object.archive.name
#   trigger_http          = true
#   timeout               = 60
#   entry_point           = "store_to_file"
#   labels = {
#     my-label = "my-label-value"
#   }

#   environment_variables = {
#     BUCKET_NAME = google_storage_bucket.function-files.name
#   }
# }

# # IAM entry for a single user to invoke the function
# resource "google_cloudfunctions_function_iam_member" "invoker" {
#   project        = google_cloudfunctions_function.function.project
#   region         = google_cloudfunctions_function.function.region
#   cloud_function = google_cloudfunctions_function.function.name

#   role   = "roles/cloudfunctions.invoker"
#   member = "user:terraform-sa@terraform-321413.iam.gserviceaccount.com"
# }

# # IAM entry for all users to invoke the function
# resource "google_cloudfunctions_function_iam_member" "invoker" {
#   project        = google_cloudfunctions_function.function.project
#   region         = google_cloudfunctions_function.function.region
#   cloud_function = google_cloudfunctions_function.function.name

#   role   = "roles/cloudfunctions.invoker"
#   member = "allUsers"
# }


resource "google_app_engine_standard_app_version" "publisher" {
  version_id = "v1"
  service    = "default"
  runtime    = "python39"

  entrypoint {
    shell = "python ./app/main.py"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.app-files.name}/${google_storage_bucket_object.source-code.name}"
    }
  }

  env_variables = {
    port = "8080"
  }

  automatic_scaling {
    max_concurrent_requests = 10
    min_idle_instances = 1
    max_idle_instances = 3
    min_pending_latency = "1s"
    max_pending_latency = "5s"
    standard_scheduler_settings {
      target_cpu_utilization = 0.5
      target_throughput_utilization = 0.75
      min_instances = 2
      max_instances = 10
    }
  }

  delete_service_on_destroy = true
}
