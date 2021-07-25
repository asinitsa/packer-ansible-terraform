# packer-ansible-terraform

Install required utilities

```shell
brew install ansible

brew tap hashicorp/tap

brew install hashicorp/tap/packer
brew install hashicorp/tap/terraform

```

Build custom AMI

```shell
packer init .

packer build aws-ubuntu.pkr.hcl
```

Build infrastructure with terraform 

```shell
terraform init .

terraform plan 

terraform apply

```
