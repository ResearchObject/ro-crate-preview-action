#!/bin/sh -l
rochtml $1/ro-crate-metadata.json
mv ro-crate-preview.html $2
echo "::set-output name=preview::$2"
