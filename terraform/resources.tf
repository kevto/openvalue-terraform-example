# Create password for the database root user

# TODO Random password
# TODO See: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password

# Setup the database

# TODO Create instance and database
# TODO See: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database

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
# TODO See: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service#example-usage---cloudrunv2-service-sql
# TODO See: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service_iam#google_cloud_run_v2_service_iam_policy

# Frontend application

# TODO Cloud Run service and IAM policy
# TODO See: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service#example-usage---cloudrunv2-service-sql
# TODO See: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service_iam#google_cloud_run_v2_service_iam_policy
