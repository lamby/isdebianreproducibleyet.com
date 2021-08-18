#!/usr/bin/env Make

CURRENT := $(shell curl -qs https://tests.reproducible-builds.org/debian/reproducible.html | \
		sed -n '/bookworm\/amd64/{n;p}' | \
		head -n1 | \
		sed -ne 's@</td><td>[0-9]* / \([^%]*\)%.*@\1@gp')

all:
	sed -i -e "s@is .* reproducible@is $(CURRENT)% reproducible@g" index.html
	git add index.html
	-git commit -m "Update current status to $(CURRENT)%."
	git push
	PAGER=cat git show
	@echo https://github.com/lamby/isdebianreproducibleyet.com/commit/$(shell git rev-parse HEAD)
