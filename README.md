# rocrate-to-ghpages-action

## Overview
This action builds an html preview page from an RO Crate metadata file.

It is used in conjunction with other GitHub actions in order to
commit the files to your (e.g.) gh-pages branch,
and then deploy to your github.io site.

## Usage
Create a file in `.github/workflows/` called `rocrate-to-ghpages.yml`:

```yaml
name: RO Crate to GitHub Pages
on:
  push:
    branches:
      - master
  pull_request:
jobs:
  build-and-deploy:
    runs-on: ubuntu-20.04
    concurrency: ci-${{github.ref}}
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Build RO Crate Preview
        uses: gcapes/rocrate-to-ghpages-action@master

      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          folder: .
          branch: gh-pages
```
