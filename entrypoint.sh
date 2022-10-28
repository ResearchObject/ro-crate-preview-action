#!/bin/sh -l
rochtml $1/ro-crate-metadata.json
ln -sf ro-crate-preview.html index.html
echo "::set-output name=preview::ro-crate-preview.html"
