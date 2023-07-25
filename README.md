# Onedata documentation

This documentation is built using [VuePress](https://vuepress.vuejs.org).

## Guidelines

All docs should be edited and formatted in compliance with the [guidelines](GUIDELINES.md).

## Building and developing

### Makefile targets

Most Makefile targets use our build-docker with all dependencies installed.
These scripts are suitable for most developers and documentation users.

* `make build` builds the documentation using a docker.
* `make dev` prepares a local preview with livereload using a docker, allowing
  convenient development. The livereload might not cope with some structural
  changes, in such case the command must be re-run. `Ctrl-C` interrupts the preview.
  Note that in this mode, the `RELEASE` version is not injected, only the
  placeholders are visible, as opposed to the `make preview` target.
  This target uses a docker, like `make build`.
* `make preview` starts a simple HTTP server in Python that serves the docs
  statically, giving a preview of what's in the build artifact. This task is not performed
  using a docker, so Python 2 or 3 is required to be installed.
* `make lint` launches Markdown linter on all documents using a docker.
* `make format-all` performs auto-formatting on all Markdown documents using a docker.
  Note, that this task will modify Markdown files when there is a need to apply
  formatting, so it is recommended to use it when you have your current changes staged.

### Development

A recommended IDE to develop documentation is Visual Studio Code.

You can set up recommended Visual Studio Code workspace configuration using
`./setup-vscode.sh` that will apply setting from the `.vscode.example` directory to your
workspace configuration.

There are a few recommended extensions for documentation development. You should be
asked for installing them on opening this workspace (as they are listed in
`extensions.json`).

#### remark (`unifiedjs.vscode-remark`)

Before installing this addon, you should install Node.js runtime in version 14.14+. Follow
instructions on the [nvm website](https://github.com/nvm-sh/nvm#installing-and-updating).

Next, you should install a set of remark packages. Do it using `npm run deps` command in
the repository root. This command will install `yarn` globally and all needed dependencies
in local `node_modules`.

With all needed dependencies, remark extension enables Markdown files check with linter
that is configured in `.remarkrc.js` file, and enables code auto-formatter. By default,
you can format your code using `Format Document` Visual Studio Code command (accessible
using `ctrl+shift+p`). If something does not work, try restarting Visual Studio Code.

It is also recommended to change your workspace settings to enable auto-formatting on each
file save as described below.

```json
  "[markdown]": {
    "editor.defaultFormatter": "unifiedjs.vscode-remark",
    "editor.formatOnSave": true
  }
```

#### Grammarly (`znck.grammarly`)

This extension enables Markdown and plaintext files check using
[Grammarly](https://www.grammarly.com/) service. You can use the extension without
authentication, but it is recommended to create an account and log in to it in Visual
Studio Code to have your personal dictionary, [customized
here](https://account.grammarly.com/customize). Currently (as of July 2023) the Grammarly
extension does not support personal dictionary configured locally.

#### Code Spell Checker (`streetsidesoftware.code-spell-checker`)

Code Spell Checker adds an offline spell check. However, as the Grammarly addon also
performs spell checking that cannot be turned of (as of July 2023), you can resign from
using this extension.

If you applied the default configuration for the workspace (using `setup-vscode.sh`
script), the Code Spell Check extension uses `cspell-dictionary.txt` file with known
words.

### Development using a natively-installed toolkit

In the Makefile section, most build commands use docker with all dependencies installed,
which does not require installing Node.js with Node packages locally. To use locally
installed Node (v14.14+ is required) install the Node packages using `npm run deps` in
the repository root and use package scripts with `npm run`:

* `npm run docs:dev` - runs a development server with livereload,
* `npm run docs:build` - builds static documentation to `docs/.vuepress/dist` directory,
* `npm run docs:lint` - launches a remark linter on all Markdown documents,
* `npm run docs:format-all` - applies standardized formatting on all Markdown documents.

Note, that for the local development, the `yarn` package manager is used, so do not try
installing dependencies using `npm install`.

## Versioning

The current Onedata version to which the docs correspond is placed in the
`RELEASE` file and injected into the docs using the `./inject-release.sh`
script during the build.

## Build artifact

After a successful build, the static HTML files are placed in `docs/.vuepress/dist`.
Calling `make package` will pack it up into a tarball.
