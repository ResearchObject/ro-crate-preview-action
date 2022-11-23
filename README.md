# Build HTML preview of RO-Crate

## Overview

This action builds an html preview page from an RO Crate metadata file.

It can be used in conjunction with other GitHub actions in order to
commit the files to your (e.g.) gh-pages branch,
and then deploy to your github.io site.

## Example workflow

- Put your `ro-crate-metadata.json` in the root directory of your repo.

- Create a file in `.github/workflows/` in your repository called `ro-crate-to-ghpages.yml`:

  ```yaml
  name: RO Crate to GitHub Pages
  on:
    push:
      branches:
        - master
  jobs:
    build-and-deploy:
      runs-on: ubuntu-22.04
      concurrency: ci-${{github.ref}}
      steps:
        - name: Checkout
          uses: actions/checkout@v3

        - name: Build RO Crate Preview
          uses: ResearchObject/ro-crate-preview-action@v1.1.0

        - name: Deploy
          uses: JamesIves/github-pages-deploy-action@v4
          with:
            folder: .
            branch: gh-pages
  ```

The action will run each time you push to the `master` branch.

The above workflow has steps to checkout your repo code, build `ro-crate-preview.html`,
and commit this to the `gh-pages` branch.

If you have your GitHub repo settings to build a live site from your `gh-pages` branch,
another GitHub action will automatically be triggered to render your preview at
`https://<username>.github.io/<repo>`.
