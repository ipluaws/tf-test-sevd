We can provision our basic infrastructure from here which is built by Terraform.
tf-remote-state: We deploy S3 and Dynamodb as an initial setup. By using S3 for storage and DynamoDB for locking, we achieve a robust and scalable solution for managing our Terraform state in centralized and secure way.
After intial setup, we navigate back to infra folder, and execute our terraform init, plan, apply. This will deploy our complete infrastructure. we can change values in our variables.tf configuration file to adapt the current requirements.

