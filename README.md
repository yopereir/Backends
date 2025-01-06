# Backends
Repo containing Backends and Platforms.

## Conventions:
* Project organization is done as follows: Framework->[stacks->API/Service Name]. If no custom stacks are present, just put all files inside Framework.

* Each Project should have a README.md file with instructions on how to get the service running.

* When building Docker images or to Kubernetes, use the naming convention `Framework[-ServiceName]` for the main Image name and Namespace name.