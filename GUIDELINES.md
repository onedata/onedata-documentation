# Guidelines

Unified guidelines for writing and formatting the Onedata documentation.

## TODO

* VFS-9738 carry on with more guidelines and adjust the existing docs so that they comply.

## Source file structure

The source files reside in `./docs/` and the images reside in `./images/`,
with the mirrored directory structure (image path should correspond to
the markdown source path where it is used - see below).

To add a new page:

* create a new .md file, placing it in a sensible location in the structure,
  e.g. `./docs/admin-guide/onezone/installation.md`,
* add appropriate entry in `./docs/.vuepress/config.js`, in the
  `sidebar` object.

To add an image:

* place the image to be referenced by an .md file in its corresponding directory,
  i.e. for the above-mentioned page, it would be:
  `./images/admin-guide/onezone/installation/first-step.png`,
* embed the image into the Markdown page:
  `![image](../../../images/admin-guide/onezone/installation/first-step.png)`

## Writing tone

* Always use second person and imperative mood to address the user. Don't be
  overly polite (avoid using `please` when giving commands).

  :white\_check\_mark: To upload a file, click on the corresponding button in the top toolbar.

  :x: Files can be uploaded by clicking on the corresponding button in the top toolbar.

  :white\_check\_mark: You can find the transfer statistics below.

  :x: The transfer statistics can be found below.

  :white\_check\_mark: For more information, see this chapter.

  :x: For more information, please see this chapter.

  :white\_check\_mark: Note that the log size can get substantial.

  :x: Please note that the log size can get substantial.

## Code style

### General

* Do not exceed 80-120 characters per line, unless really necessary (e.g. with
  long links or tables).

### Enumeration & itemization

```
* Use only the wildcard (`*`) character for bullet points — do not use the hyphen (`-`).

* For multiline points, indent the content to
  align with the first line content.

* Consider adding blank lines between points in lists that have a lot of content.
```

### Code blocks

Use the three backticks notation to create a multi-line code block. Whenever
possible, specify the language for nice syntax highlighting. More tips and the
list of supported languages can be found in the
[Vuepress docs](https://v1.vuepress.vuejs.org/guide/markdown.html#syntax-highlighting-in-code-blocks).

````
```js
export default {
  name: 'MyComponent',
  // ...
}
```
````

### Custom blocks/containers

Avoid using the default markdown blockquotes, but use the
[Vuepress custom containers](https://v1.vuepress.vuejs.org/guide/markdown.html#custom-containers).

````
::: tip
This is a tip
:::

::: warning
This is a warning
:::

::: danger CUSTOM TITLE
This is a dangerous warning
:::

::: details
This is a details block, which does not work in IE / Edge
:::

::: details Click me to view the code
```js
console.log('Hello, VuePress!')
```
:::
````

## Links & references

Below are some examples how a link or reference can be introduced:

* `For more information about X, refer to [this page](path/to/file.md#section).`
* `For more information about X, see the [Y](path/to/file.md#section) section/chapter.`
* `See [this](path/to/file.md#section) chapter for more details.`

## Technicalities

* Use the hyphen (`-`), en dash (`–`) and em dash (`—`) characters appropriately.

  The hyphen (`-`) is used for compound terms and word division.

  > Onedata is a state-of-the-art system.

  The en dash (`–`) is used for ranges, scores and conflict, connection, or direction:

  > The years 2021–2022 brought rapid improvement of the POSIX–CEPH transfer performance.

  The em dash (`—`) is a versatile punctuation mark that can take the place of
  commas, parentheses, or colons, depending on the context. Always put a space
  before and after the em dash.

  > Authentication is carried by access tokens — bearer tokens that allow acting
  > on behalf of the token subject.

  For more tips, see the [punctuation guide](https://www.thepunctuationguide.com/hyphen.html).

* To abbreviate `identifier`, stick to the `ID` notation rather than `Id`.

* Use the term `provider` when referring to a Onedata provider in most contexts,
  except when talking about a service or a piece of software — use `Oneprovider`
  then. For example:

  > You may choose between the supporting providers in the top menu.

  > The data is distributed between three providers.

  > As an admin, you should install the Oneprovider cluster to expose your storage system via Onedata.

## Screenshots

* Crop as much as possible; leave just enough context so that the user can
  locate the region of interest in GUI, but focus on the discussed feature.

* When taking screenshots, use browser zoom to get better quality images.
  Satisfying zoom level depends on the screenshot region size, but quite often
  is about 125% for a 1920x1080 window. Verify the quality of screenshots
  in the docs preview; if the image is not clear, try different zoom levels.

* Always add the `screenshot` class to all screenshots:
  `![image](../../images/user-guide/spaces/1-no_spaces.png#screenshot)`

## Custom routes

Can be placed in `./docs/.vuepress/enhanceApp.js`.
