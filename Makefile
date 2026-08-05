.DEFAULT_GOAL := help


.PHONY: all
all:


.PHONY: help
help:
	@echo "Usage: make <target> [options]\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Examples:"
	@echo "make create ROLE=vim"
	@echo "make install ROLE=vim"
	@echo "make install"
	@echo "make update ROLE=hammerspoon"
	@echo "make list"


.PHONY: create
create: ## Create ROLE <ROLE=RoleName>
	@scripts/create.sh $(ROLE)


.PHONY: install
install: ## Install ROLEs [ROLE=RoleName]
	@scripts/install.sh $(ROLE)


.PHONY: update
update: ## Update ROLEs (run roles/<role>/update.sh if present) [ROLE=RoleName]
	@scripts/update.sh $(ROLE)


.PHONY: list
list: ## List ROLEs
	@scripts/list.sh

