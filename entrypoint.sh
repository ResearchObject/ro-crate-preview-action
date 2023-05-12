#!/bin/sh -l
rochtml $1/ro-crate-metadata.json
ln -sf $1/ro-crate-preview.html $1/index.html
echo "preview=$1/ro-crate-preview.html" >> $GITHUB_OUTPUT
