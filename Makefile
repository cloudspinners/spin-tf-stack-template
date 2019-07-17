.DEFAULT_GOAL := help

STACK_CONFIG ?= my-stack.tfvars
BACKEND_CONFIG ?= my-backend.hcl

include $(STACK_CONFIG)

ARCHIVE_VERSION=$(shell date '+%Y%m%d_%H%m%S')

ifeq ($(OS),Darwin)
	TAR=gtar
else
	TAR=tar
endif


bundle:
	bundle install

bundleup:
	bundle update

_work/inspec_attributes_aws.yaml: init my-stack.tfvars
	mkdir -p _work
	sed 's/[ \t]*=/:/' < my-stack.tfvars > $@
	( cd src && terraform output ) | sed 's/[ \t]*=/:/' >> $@

clean: ## Remove temporary files from local folders
	rm -rf _work _dist src/.terraform .kitchen

test: bundle _work/inspec_attributes_aws.yaml ## Inspec tests
	bundle exec inspec exec test/using_aws -t aws://$(region)/$(assume_role_profile) --attrs=_work/inspec_attributes_aws.yaml
	bundle exec inspec exec test/from_here --attrs=_work/inspec_attributes_aws.yaml

init:
	cd src && terraform init -backend=true -backend-config=../$(BACKEND_CONFIG)
	rm -f _work/inspec_attributes_aws.yaml

plan: init ## Terraform plan
	cd src && terraform plan -var-file=../$(STACK_CONFIG)

apply: init ## Terraform apply
	cd src && terraform apply -auto-approve -var-file=../$(STACK_CONFIG)

destroy: init ## Terraform destroy
	cd src && terraform destroy -auto-approve -var-file=../$(STACK_CONFIG)

plan-destroy: init ## Show what would be destroyed
	cd src && terraform plan -destroy -var-file=../$(STACK_CONFIG)

package: ## Build an artefact package
	mkdir -p _dist
	$(TAR) czvf _dist/$(stack_name)-$(ARCHIVE_VERSION).tgz \
		--exclude=_* \
		--exclude=my-* \
		--exclude='.[^/]*' \
		--transform=s/^\./$(stack_name)-$(ARCHIVE_VERSION)/ \
		--show-stored-names \
		.

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
