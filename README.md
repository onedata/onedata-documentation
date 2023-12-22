# Onedata documentation

This documentation is built using [VuePress][].

## Contributing

Before making any changes in the docs, make sure to set up your working environment
(see [Development][] below).

**Before creating a PR**:

* Make sure your contribution **sticks to the [guidelines][]**.
* Fix any linguistic or grammatical errors detected by the plugins. If you are touching
  a file with pre-existing errors, please take some time to tidy it up a bit.
* Make sure the build is passing (may require re-formatting, pleasing the linter or solving
  forgotten code tags).

## Building and developing

### Makefile targets

Most Makefile targets use our build-docker with all dependencies installed.
These scripts are suitable for most developers and documentation users.

* `make build` builds the documentation, producing an artifact.
* `make dev` prepares a local preview with `livereload`, allowing
  convenient development. The `livereload` might not cope with some structural
  changes, in such case the command must be re-run. `Ctrl-C` interrupts the preview.
  Note that in this mode, the `RELEASE` version is not injected, only the
  placeholders are visible, as opposed to the `make preview` target.
* `make preview` starts a simple HTTP server in Python that serves the docs
  statically, giving a preview of what's in the build artifact. **This task is not
  performed using a docker**, so Python 2 or 3 is required to be installed.
* `make lint` launches Markdown linter on all documents.
* `make check-language` launches LanguageTool toolkit for checking text grammar and
  spelling.
* `make format-all` performs auto-formatting on all Markdown documents.
  Note that this task will modify Markdown files where needed, so it is
  recommended to use it after staging current changes.

### Development

The recommended IDE to develop the documentation is Visual Studio Code (VSCode).

The VSCode workspace configuration is checked out in the repository, so please be careful
to not commit your personal changes. Only changes that should be shared amongst the other
users should be committed, like `LTeX` configuration.

There are a few recommended extensions for documentation development. You should be
asked to install them when opening this workspace in VSCode (as they are listed in
`extensions.json`). If not, install them manually.

#### remark (`unifiedjs.vscode-remark`)

Before installing this add-on, you should install Node.js runtime in version 14.14+. Follow
instructions on the [nvm website][].

Next, you should install a set of remark packages. Do it using `npm run deps` command in
the repository root. This command will install `yarn` globally and all needed dependencies
in local `node_modules`.

With all needed dependencies, remark extension enables Markdown files check with linter
that is configured in `.remarkrc.js` file, and enables code auto-formatter. By default,
you can format your code using `Format Document` VSCode command (accessible
using `ctrl+shift+p`). If it does not work, try restarting VSCode.

It is also recommended changing your workspace settings to enable auto-formatting on each
file save (use `ctrl+shift+p` and type `open workspace settings (JSON)`):

```json
  "[markdown]": {
    "editor.defaultFormatter": "unifiedjs.vscode-remark",
    "editor.formatOnSave": true
  }
```

#### LTeX – LanguageTool grammar/spell checking (`valentjn.vscode-ltex`)

[LTeX][] add-on provides offline grammar and spell checking using the [LanguageTool][].
Note, that the LanguageTool server is automatically downloaded to your local filesystem
and launched locally — no data is sent to the LanguageTool servers. Also note, that the
free version of LanguageTool launched locally lacks some checking made in the cloud
version.

A configuration of the LTeX is placed entirely in the `.vscode/settings.json` file. It is
also used by `make check-language` which uses the LTeX server to perform checking outside
the IDE. The `dictionary`, `disabledRules`, and `hiddenFalsePositives` lists in the
configuration must be placed in the `settings.json` file due to the `ltex-cli` limitations
(as of version 16.0.0).

You can add words to dictionary, disable rules and hide false positives using the IDE
"quick fix" functionality (hover over the underlined language problem). These
words/rules/false positives will be added to the `settings.json` file, and the changes
should be committed.

### Development using a natively-installed toolkit

In the Makefile section, most build commands use docker with all dependencies installed,
which does not require installing Node.js with Node packages locally. To use locally
installed Node (v14.14+ is required) install the Node packages using `npm run deps` in
the repository root and use package scripts with `npm run`:

* `npm run docs:dev` - runs a development server with `livereload`,
* `npm run docs:build` - builds static documentation to `rel/` directory (notice the
  `future-documentation` subdirectory which is a subpath for serving),
* `npm run docs:lint` - launches a remark linter on all Markdown documents,
* `npm run docs:format-all` - applies standardized formatting on all Markdown documents.

Note, that for the local development, the `yarn` package manager is used, so do not try
installing dependencies using `npm install`.

## Versioning

The current Onedata version to which the docs correspond is placed in the
`RELEASE` file and injected into the docs using the `./inject-release.sh`
script during the build.

## Build artifact

After a successful build, the static HTML files are placed in `rel/future-documentation`.
Calling `make package` will pack it up into a tarball.

[VuePress]: https://vuepress.vuejs.org

[Development]: #development

[guidelines]: GUIDELINES.md

[nvm website]: https://github.com/nvm-sh/nvm#installing-and-updating

[LTeX]: https://marketplace.visualstudio.com/items?itemName=valentjn.vscode-ltex

[LanguageTool]: https://languagetool.org
