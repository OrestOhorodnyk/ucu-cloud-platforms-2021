provider "google" {

  # credentials = file("playground-s-11-c97dfb50-9228e41f2689.json")

  project = "terraform-321413"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network-1"
} 

terraform {
  backend "gcs" {
    bucket = "terraform-321413"
    prefix = "state"
   }
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
resource "google_compute_address" "static_ip" {
  name = "terraform-static-ip"
}
