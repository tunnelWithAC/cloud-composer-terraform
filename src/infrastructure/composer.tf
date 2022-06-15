
resource google_service_account composer_service_account {
  account_id   = "composer-service-account"
  display_name = "Test Service Account for Composer Environment"
}

resource google_service_account new_service_account {
  account_id   = "new-service-account"
  display_name = "Test Service Account for Composer Environment"
}

resource "google_project_iam_member" "composer-custom-service-account-role" {
  for_each = toset([
    "roles/composer.ServiceAgentV2Ext",
    "roles/composer.worker"
  ])
  role = each.key
  member = "serviceAccount:${google_service_account.composer_service_account.email}"
  project = var.project
}

resource "google_project_iam_member" "composer-service-account-role" {
  for_each = toset([
    "roles/composer.ServiceAgentV2Ext",
    "roles/composer.worker"
  ])
  role = each.key
  member = "serviceAccount:${var.composer_service_account}"
  project = var.project
}

resource "google_project_iam_member" new-composer-service-account-role {
  for_each = toset([
    "roles/composer.ServiceAgentV2Ext",
    "roles/composer.worker"
  ])
  role = each.key
  member = "serviceAccount:${google_service_account.new_service_account.email}"
  project = var.project
}


resource "google_compute_network" "test" {
  name                    = "composer-test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "test" {
  name          = "composer-test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "europe-west1"
  network       = google_compute_network.test.id
}

resource "google_composer_environment" mclovin-composer {
  name   = "mclovin"
  region = "europe-west1"

  config {
    software_config {
      image_version = "composer-2.0.8-airflow-2.2.3"

      pypi_packages = {
        numpy = ""
        scipy = "==1.1.0"
      }

      env_variables = {
        warehouse_environment = "dev"
        ENV                   = "dev"
      }
    }

    workloads_config {
      # + scheduler {
      #     + count      = (known after apply)
      #     + cpu        = (known after apply)
      #     + memory_gb  = (known after apply)
      #     + storage_gb = (known after apply)
      # }

      # + web_server {
      #     + cpu        = (known after apply)
      #     + memory_gb  = (known after apply)
      #     + storage_gb = (known after apply)
      # }

      worker {
      #   cpu        = (known after apply)
      #   max_count  = (known after apply)
      #   memory_gb  = (known after apply)
        min_count    = 1 # env variables
        # storage_gb = (known after apply)
      }
    }

    environment_size = "ENVIRONMENT_SIZE_SMALL"

    node_config {
      # network    = google_compute_network.test.id
      # subnetwork = google_compute_subnetwork.test.id
      service_account = google_service_account.composer_service_account.name
    }

  }
}
