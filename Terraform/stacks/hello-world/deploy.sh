tofu init
tofu destroy --auto-approve
tofu plan -out hello-world.tfplan
tofu apply hello-world.tfplan 