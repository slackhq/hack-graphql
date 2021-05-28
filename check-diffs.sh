#!/bin/sh

if [ "$(git status --porcelain)" ]; then
	echo 'Running codegen for this PR produces unexpected diffs. Did you run "make test" and commit the ouput?'
	exit 1
fi
