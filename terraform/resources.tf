# Create password for the database root user

resource "random_password" "db_root_password" {
  length = 16

  min_lower = 1
  min_numeric = 1
  min_special = 1
  min_upper = 1
}

# Setup the database

resource "google_sql_database_instance" "jworld" {
  name             = "jworld"
  region           = "europe-west1"
  database_version = "POSTGRES_15"
  settings {
    tier = "db-f1-micro"
  }

  root_password = random_password.db_root_password.result

  deletion_protection  = "true"
}

resource "google_sql_database" "jworld" {
  name     = "jworld"
  instance = google_sql_database_instance.jworld.name
}

# Creating Cloud Run instances

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service" "jworld_api" {
  name     = "jworld-api"
  location = "europe-west1"
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      max_instance_count = 1
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.jworld.connection_name]
      }
    }

    containers {
      image = "europe-west1-docker.pkg.dev/${var.gcloud_project_id}/jworld/jworld-api:0.0.6"

      ports {
        container_port = 8080
      }
      # DO NOT DO THIS FOR PRODUCTION APPLICATIONS
      # Use Secrets Manager instead
      env {
        name = "SPRING_DATASOURCE_PASSWORD"
        value = random_password.db_root_password.result
      }
      env {
        name = "SPRING_DATASOURCE_URL"
        value = "jdbc:postgresql:///${google_sql_database.jworld.name}?cloudSqlInstance=${google_sql_database_instance.jworld.connection_name}&socketFactory=com.google.cloud.sql.postgres.SocketFactory"
      }

    }
  }

  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

resource "google_cloud_run_v2_service_iam_policy" "jworld_api_noauth" {
  project = google_cloud_run_v2_service.jworld_api.project
  location = google_cloud_run_v2_service.jworld_api.location
  name = google_cloud_run_v2_service.jworld_api.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
