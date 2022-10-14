#!/bin/sh -l
rochtml $1/ro-crate-metadata.json
echo "::set-output name=preview::ro-crate-preview.html"
