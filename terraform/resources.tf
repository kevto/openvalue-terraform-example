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

  deletion_protection  = "false" # Set to true on production
}

resource "google_sql_database" "jworld" {
  name     = "jworld"
  instance = google_sql_database_instance.jworld.name
}

# Creating Cloud Run instances
# Creating a policy to all everyone invoke the Cloud Run instances

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# Api application

# TODO Cloud Run service and IAM policy

# Frontend application

# TODO Cloud Run service and IAM policy
