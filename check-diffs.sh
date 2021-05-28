#!/bin/sh

if [ "$(git status --porcelain)" ]; then
	echo "Running codegen for this PR produces unexpected diffs:"
	echo ""
	echo "$(git status)"
	exit 1
fi
