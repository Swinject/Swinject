#
# Run help command as the default.
#
all: help

#
# Shows help message.
#
.PHONY: help
help:
	@echo 'To release a version of Swinject, run the following commands in order on the branch where you make a release.'
	@echo '  $$ make VERSION=<version#> set-new-version (e.g. make VERSION=1.2.3 set-new-version)'
	@echo '  $$ make [UPSTREAM=<upstream>] push-to-upstream (e.g. make push-to-upstream)'
	@echo '  $$ make carthage-release'
	@echo '  $$ make cocoapods-release'

#
# Set a specified version in Info.plist and podspec files, and tag the version.
#
.PHONY: set-new-version
set-new-version:
ifndef VERSION
	$(error Specify a new version. E.g. $$ make VERSION=1.2.3 set-new-version)
endif
ifeq ($(wildcard ./Swinject.podspec),)
	$(error Run the command in the directory containing Swinject.podspec.)
endif
ifeq ($(shell git diff --quiet; echo $$?), 1)
	$(error Your current git working tree is dirty. Stash all to run this command.)
endif
	agvtool new-marketing-version $(VERSION)
	sed -i '' -e 's/\(s\.version.*=\).*/\1 "$(VERSION)"/' ./Swinject.podspec
	git commit -a -m "Update the version to $(VERSION)"
	git tag $(VERSION)

#
# Push the commit and tag for the new version to upstream.
#
VERSION_TAG=$(shell git describe --tags --abbrev=0)
ifndef UPSTREAM
UPSTREAM=upstream
endif
.PHONY: push-to-upstream
push-to-upstream:
	git push $(UPSTREAM) $(shell git rev-parse --abbrev-ref HEAD)
	git push $(UPSTREAM) $(VERSION_TAG)

#
# Make a release for Carthage.
#
VERSION_TAG=$(shell git describe --tags --abbrev=0)
.PHONY: carthage-release
carthage-release:
ifeq ($(shell which gh),)
	$(error gh command not found. Install gh command and run `gh auth login` beforehand.)
endif
ifneq ($(VERSION_TAG),$(shell agvtool what-marketing-version -terse1))
	$(error The version tag $(VERSION_TAG) does not match the version in Info.plist)
endif
	gh release create $(VERSION_TAG) --draft --title v$(VERSION_TAG) --notes ""
	@echo Open https://github.com/Swinject/Swinject/releases/edit/$(VERSION_TAG) to describe the release and publish it.

#
# Make a release for Cocoapods.
#
.PHONY: cocoapods-release
cocoapods-release:
	pod lib lint
	pod trunk push Swinject.podspec
