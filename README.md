
# What

This is a template for a Terraform project that defines a single stack on AWS.


## Includes:

* Configuration strategy based on per-environment files
* Configure and run inspec tests
* Manage remote state in a Terraform cloud workspace
* Makefile that runs Terraform with the relevant configuration strategies
* Support for running this in a delivery pipeline
** buildspec files for AWS CodePipeline


## Requires

* AWS profile setup with authentication, including a role to assume
* Terraform cloud token


# How

1. Configure the stack
1. Configure the Terraform back end
2. Apply the stack


## Step 1: Configure the stack


Copy and then edit the stack configuration:

```console
cp example-stack.tfvars my-stack.tfvars
```

Edit `my-stack.tfvars`, looking for things in `ALLCAPS` and replacing them:


| Variable | What to put |
| -------- | ----------- |
| environment_name = "sandbox_YOURNAME" | To start with, every developer or pair should use their own sandbox environment, so set this to something unique.
| estate_name = "my_organization" | This is mainly used for tagging and naming things in stacks. |
| assume_role_arn = "arn:aws:iam::NNNNNNNNNNNN:role/ROLE_NAME" | The 'NNN...' is the AWS account ID.


## Step 2: Configure the Terraform back end

Copy and then edit the configuration files:

```console
cp example-backend.hcl my-backend.hcl
```

Edit `my-backend.hcl`:

* _organization_ is the Terraform cloud organization.
* _workspaces_ corresponds to the stack instance you will be working with. As above, this should be unique for each user or pair working on a local instance. Set it to the same value as the _environment_name_ variable in `my-stack.tfvars`.


## Step 3: Apply the stack

- Run `make plan` and `make apply` to taste
- Run `make test` for obvious reasons
