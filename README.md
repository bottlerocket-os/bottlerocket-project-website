# Bottlerocket Project Website

This repository is the source to the Bottlerocket project website. It contains the content (as [Markdown](https://commonmark.org/) files), templates (HTML), stylesheets (CSS), and [Hugo](https://gohugo.io/) configurations (mostly [TOML](https://toml.io/en/), some [YAML](https://yaml.org/)).

## Contributing

The Bottlerocket website is open to contribution and collaboration. See [CONTRIBUTING](CONTRIBUTING.md) for specific instructions.

### Rendering Locally

This site uses [Hugo](https://github.com/gohugoio/hugo) for rendering.
You may run `hugo` locally to validate your changes render properly.

#### Rendering

If [`hugo` is installed](#hugo-installation), you may view the rendered site by running:

```sh
# To render everything, including draft posts
hugo server -D

# To render the site as it will appear when being published
hugo server
```

If you use `make`, have `docker`, and do not have `hugo` installed, you may also use the following `make` target as a convenience:

```sh
make preview
```

#### Hugo Installation

Hugo is available for many platforms.

- Linux: most native package managers
- macOS: `brew install hugo`
- Windows: `choco install hugo`

See the [Hugo installation instructions](https://gohugo.io/getting-started/installing/) for additional options.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License Summary

Site templates, source code, and stylesheets are made available under the Apache 2.0 license. See the LICENSE file.

The content and documenation is made available under the Creative Commons Attribution-ShareAlike 4.0 International License. See the LICENSE-CONTENT file.

The sample code within this documentation is made available under a modified MIT-0 license. See the LICENSE-SAMPLECODE file.
