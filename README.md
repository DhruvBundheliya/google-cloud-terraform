# GCP Infrastructure as Code Repository
This repository serves as an Infrastructure as Code (IaC) solution for managing your Google Cloud Platform (GCP) infrastructure using Terraform. It provides the necessary code to provision and manage resources such as Google Kubernetes Engine (GKE) clusters, Virtual Private Cloud (VPC) networks, subnets, NAT (Network Address Translation), and routers.

### Table of Contents
- Introduction
- Repository Structure
- Usage

## Introduction
The purpose of this repository is to streamline the management of your GCP infrastructure by leveraging the power of Infrastructure as Code principles. By using Terraform, a widely adopted IaC tool, you can define your infrastructure resources in declarative configuration files and apply them to your GCP environment. This approach allows for versioning, collaboration, and reproducibility, enabling easier maintenance and scaling of your infrastructure.

## Repository Structure
This repository follows a well-organized structure to help you easily navigate and manage your infrastructure code:

```
google-cloud-terraform
└── GKE
    ├── main.tf
    ├── variables.tf
    ├── provider.tf
    ├── backend.tf
    ├── outputs.tf
    └── tfvars
        ├── production.tfvars
        └── staging.tfvars
└── VPC
    ├── main.tf
    ├── variables.tf
    ├── provider.tf
    ├── backend.tf
    ├── outputs.tf
    └── tfvars
        ├── production.tfvars
        └── staging.tfvars
```
provider.tf: Defines the provider, this Terraform configuraton belongs to. Some of the examples of the provider are AWS, GCP, Azure, Kubernetes, etc.

backend.tf: A backend defines where Terraform stores its state data files. Basically, defined the primary location to store the current state of the infrastructure deployed with the Terraform code.

main.tf: Contains the main Terraform configuration file defining the resources to be provisioned, including GKE clusters, VPC networks, subnets, NAT, and routers.

variables.tf: Defines input variables used in the Terraform configuration, allowing for customization and parameterization of your infrastructure.

outputs.tf: Specifies the output values that will be shown after Terraform applies the configuration, providing useful information about your provisioned infrastructure.


README.md: The file you are currently reading, providing an overview of the repository and instructions for usage.

## Usage
To use this repository and provision your GCP infrastructure, follow these steps:

Clone the repository to your local machine:
```
git clone https://github.com/DhruvBundheliya/gcp-infrastructure.git
```
Navigate to the repository's root directory:

```
cd ${SERVICES_DIR}
```
Open the variables.tf file and customize the input variables according to your desired infrastructure configuration.

Initialize the Terraform project:
```
terraform init
```
Formate the terraform code:
```
terraform fmt
```
Preview the changes that Terraform will apply:
```
terraform plan 
```
Apply the Terraform configuration to provision your infrastructure:

```
terraform apply
```
Review the changes to be applied and confirm by typing yes.

Wait for Terraform to provision the resources. Once completed, you will see the outputs specified in ```outputs.tf```