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
* `make dev` prepares a local preview with livereload, allowing
  convenient development. The livereload might not cope with some structural
  changes, in such case the command must be re-run. `Ctrl-C` interrupts the preview.
  Note that in this mode, the `RELEASE` version is not injected, only the
  placeholders are visible, as opposed to the `make preview` target.
* `make preview` starts a simple HTTP server in Python that serves the docs
  statically, giving a preview of what's in the build artifact. **This task is not
  performed using a docker**, so Python 2 or 3 is required to be installed.
* `make lint` launches Markdown linter on all documents.
* `make format-all` performs auto-formatting on all Markdown documents.
  Note that this task will modify Markdown files where needed, so it is
  recommended to use it after staging current changes.

### Development

The recommended IDE to develop the documentation is Visual Studio Code (VSCode).

You can set up recommended VSCode workspace configuration using
`./setup-vscode.sh`, that will apply settings from the `.vscode.example` directory to your
workspace configuration.

There are a few recommended extensions for documentation development. You should be
asked to install them when opening this workspace in VSCode (as they are listed in
`extensions.json`). If not, install them manually.

#### remark (`unifiedjs.vscode-remark`)

Before installing this addon, you should install Node.js runtime in version 14.14+. Follow
instructions on the [nvm website][].

Next, you should install a set of remark packages. Do it using `npm run deps` command in
the repository root. This command will install `yarn` globally and all needed dependencies
in local `node_modules`.

With all needed dependencies, remark extension enables Markdown files check with linter
that is configured in `.remarkrc.js` file, and enables code auto-formatter. By default,
you can format your code using `Format Document` VSCode command (accessible
using `ctrl+shift+p`). If it does not work, try restarting VSCode.

It is also recommended to change your workspace settings to enable auto-formatting on each
file save (use `ctrl+shift+p` and type `open workspace settings (JSON)`):

```json
  "[markdown]": {
    "editor.defaultFormatter": "unifiedjs.vscode-remark",
    "editor.formatOnSave": true
  }
```

#### Grammarly (`znck.grammarly`)

This extension enables Markdown and plaintext files check using
[Grammarly][] service. You can use the extension without authentication, but we recommend
creating an account and logging into it in VSCode to enable the personal dictionary, which
can be customized [here][Grammarly account customize]. As of July 2023, the Grammarly
extension does not support personal dictionary configured locally.

#### Code Spell Checker (`streetsidesoftware.code-spell-checker`)

Code Spell Checker adds an offline spell check. However, as the Grammarly addon also
performs spell checking that cannot be turned off (as of July 2023), you can resign from
using this extension.

If you applied the default configuration for the workspace (using `setup-vscode.sh`
script), the Code Spell Check extension uses `cspell-dictionary.txt` file with known
words. Do add new words if needed and commit the changes.

Sometimes you need to silence Code Spell Checker warnings, because text includes
some code examples, which contains many non-dictionary words, which should not be added to
the dictionary. Refer to **Enable / Disable checking sections of code** section of
[Code Spell Checker documentation][1] for more information.

### Development using a natively-installed toolkit

In the Makefile section, most build commands use docker with all dependencies installed,
which does not require installing Node.js with Node packages locally. To use locally
installed Node (v14.14+ is required) install the Node packages using `npm run deps` in
the repository root and use package scripts with `npm run`:

* `npm run docs:dev` - runs a development server with livereload,
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

[Grammarly]: https://www.grammarly.com/

[Grammarly account customize]: https://account.grammarly.com/customize

[1]: https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
