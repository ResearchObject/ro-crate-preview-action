# Build HTML preview of RO-Crate

## Overview

This action builds an html preview page from an RO Crate metadata file.

It can be used in conjunction with other GitHub actions in order to
commit the files to your (e.g.) gh-pages branch,
and then deploy to your github.io site.

## Example workflow

- Put your `ro-crate-metadata.json` in the root directory of your repo.

- Create a file `.github/workflows/ro-crate-to-ghpages.yml` with the following contents:

  ```yaml
  name: RO Crate to GitHub Pages
  on:
    push:
      branches:
        - main
  jobs:
    build-and-deploy:
      runs-on: ubuntu-22.04
      concurrency: ci-${{github.ref}}
      steps:
        - name: Checkout
          uses: actions/checkout@v3

        - name: Build RO Crate Preview
          uses: ResearchObject/ro-crate-preview-action@v1.2.0

        - name: Upload artifact
          uses: actions/upload-pages-artifact@v1
          with:
            # Upload entire repository
            path: '.'

        - name: Deploy to GitHub Pages
          id: deployment
          uses: actions/deploy-pages@v1  

  ```

The action will run each time you push to the `main` branch. 

The above workflow has steps to checkout your repo code, build `ro-crate-preview.html`,
and commit this to the `gh-pages` branch. Note that this workflow will publish the whole of the repository "as-is" without any page rendering.

### Automatic commit

Instead of publishing the generated RO-Crate preview directly to GitHub Pages, you may prefer
for the `ro-crate-preview.html` to be committed back into the main branch. In this way the preview
will also become part of any releases and downloads, such as 
[Zenodo DOI deposits from GitHub releases](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content).

```yaml
name: Generate RO-Crate preview
on:
  push:
    branches:
      - main
jobs:
  build-and-deploy:
    runs-on: ubuntu-22.04
    concurrency: ci-${{github.ref}}
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Build RO Crate Preview
        uses: ResearchObject/ro-crate-preview-action@v1.2.0
              
      - name: Commit RO Crate Preview
        uses: swinton/commit@v2.0.0
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}        
        with:
          files: |
            ro-crate-preview.html
            index.html
          commit-message: |
            Updated RO-Crate preview
```

**Note**: One downside of this approach is that every push of commits to GitHub 
will cause an additional commit back to the repository, which means you will
need to use `git pull` to merge your local changes more frequently.
