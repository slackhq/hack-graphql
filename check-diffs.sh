#!/bin/sh

if [ "$(git status --porcelain)" ]; then
	echo "Fail"
	exit 1
else
	echo "pass"
fi
