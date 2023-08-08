# Guidelines

Unified guidelines for writing and formatting the Onedata documentation.

Some of the formatting guidelines are automatically cared for with proper
workspace configuration — make sure to set it up as described in [the README][].

## Source file structure

The source files reside in `./docs/` and the images reside in `./images/`,
with the mirrored directory structure (the image path should correspond to
the markdown source path where it is used - see below).

To add a new page:

* create a new Markdown file, placing it in a sensible location in the structure,
  e.g. `./docs/admin-guide/onezone/installation.md`,
* add appropriate entry in `./docs/.vuepress/config.js`, in the
  `sidebar` object.

To add an image:

* place the image to be referenced by a .md file in its corresponding directory,
  i.e. for the above-mentioned page, it would be:
  `./images/admin-guide/onezone/installation/first-step.png`,

* embed the image into the Markdown page:
  ```![image](../../../images/admin-guide/onezone/installation/first-step.png)```

## Writing tone

* Always use the second person and imperative mood to address the user. Don't be
  overly polite (avoid using `please` when giving commands).

  ✅ To upload a file, click on the corresponding button in the top toolbar.

  ❌ Files can be uploaded by clicking on the corresponding button in the top toolbar.

  ✅ You can find the transfer statistics below.

  ❌ The transfer statistics can be found below.

  ✅ For more information, see this chapter.

  ❌ For more information, please see this chapter.

  ✅ Note that the log size can get substantial.

  ❌ Please note that the log size can get substantial.

## Code style

### General

* Do not exceed 80-120 characters per line, unless necessary (e.g. with
  long links or tables).

### Enumeration & itemization

```md
* Use only the wildcard (`*`) character for bullet points — do not use the hyphen (`-`).

* For multiline points, indent the content to
  align with the first line content.

* Consider adding blank lines between points in lists that have a lot of content.

* Add proper punctuation — each entry should end with a period if it is a sentence.
* for short entries, that are not full sentences, but for instance single items,
* one,
* two,
* three,
* add a comma, but for the last one, add a period.
```

### Code blocks

Use the three backticks notation to create a multi-line code block. Whenever
possible, specify the language for nice syntax highlighting. More tips and the
list of supported languages can be found in the
[VuePress docs][VuePress code blocks].

````md
```js
export default {
  name: 'MyComponent',
  // ...
}
```
````

### Custom blocks/containers

Avoid using the default markdown blockquote, but use the
[VuePress custom containers][].

````md
::: tip
This is a tip
:::

::: tip NOTE
This is a note, reusing the same style as the tip container
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

Below are some examples of how a link or reference can be introduced:

```md
* For more information about X, refer to [this page][A].
* For more information about X, see the [B][] section/chapter.
* See [this][C] chapter for more details.

[A]: path/to/file-one.md#section
[B]: path/to/file-two.md#section
[C]: path/to/file-three.md#section
```

Always use references for links (like `[page][]`), never use inline links (like `[page](./path/to/page.md)`). 

Wherever it is possible, use the name of the link used in the text as a reference name, for example:

✅ Correct

```md
This is some [test][].

[test]: path/to/page.md
```

❌ Incorrect

```md
This is some [test][link-1].

[link-1]: path/to/page.md
```

In some cases, the reference name could be another, e.g. when you want to name the reference meaningful:

✅ Correct in special cases

```md
Refer to [this][file-chapter] section of documentation.

[file-chapter]: path/to/page.md
```

All references must be placed at the end of the document.

✅ Correct

```md
# First

First, refer to the [File Chapter][].

# Second

Next, go to [example.com][].

[File Chapter]: path/to/page.md

[example.com]: https://example.com
```

### Referring to GUI elements

Use consistent naming of structural GUI elements, as shown below:

![GUI elements][]

To refer to a named GUI element, use **bold** text style. You may also use the *italic*
style to express a placeholder (some meta information), e.g.:

* `Navigate to the **Data > *Space name* > Files** view.`
* `Click on the **Consume** button in the **Tokens** tab.`
* `Open the **Tokens** tab and click on the **Consume** button.`
* `Choose the **Tokens** tab from the navigation bar and click on the **Consume** button.`
* `In the **Tokens** tab, click on the **Consume** button.`
* `Navigate to the **Data** tab and select the *Space name* in the left submenu.`
* `Choose the **Remove** action from the share's actions in the sidebar.`
* `Choose an action from the actions menu for the desired row.`
* `Open the actions menu on the right and choose **Remove**.`
* `Open the context menu for the file and choose **Information**.`
* `Select the **Metadata** tab in the right-side panel.`

## Screenshots

* Crop as much as possible; leave just enough context so that the user can
  locate the region of interest in GUI, but focus on the discussed feature.
  **This typically does not apply to the first screenshot in a section**.
  It's generally a good idea to have a broader context in the first screenshot,
  e.g. with the navigation bar and sidebar visible, so it's easy for the user
  to reproduce the steps. Consecutive ones can be then cropped.

* When taking screenshots, use browser zoom to get better-quality images.
  Satisfying zoom level depends on the screenshot region size, but quite often
  is about 125% for a 1920x1080 window. Verify the quality of screenshots
  in the docs preview; if the image is not clear, try different zoom levels.

* Don't overdo it; avoid screenshots of obvious steps such as a confirmation
  modal; it's enough to describe it in the text, e.g.:
  ```text
  Confirm deletion of the file when prompted.
  You will be prompted to confirm deletion of the file.
  ```

* **Always add** the `screenshot` class to all screenshots:
  ```md
  ![image](../../images/user-guide/spaces/1-no_spaces.png#screenshot)
  ```

## REST API examples

In general, avoid including REST API call examples in the docs — this is what the API (swaggers)
docs are for. There are some exceptions to this rule though. If the REST API is complicated,
it may be a good idea to include one or two examples to give the reader a kickstart.

Do include useful links to the REST API, typically at the end of a section. Make sure
to link the section with the guide on how to use the REST API of the corresponding service.
Below is an example of how to do that.

```md
You can interact with the LUMA DB using the Onepanel's REST API — see [this section][rest-api]
for a guide on how to get started.

Below are some links to the REST API documentation of commonly used operations:

| Operation                             | Link to the API docs                |
|---------------------------------------|-------------------------------------|
| Get LUMA DB configuration             | [API][luma-get-config]              |
| Clear LUMA DB                         | [API][luma-clear-db]                |
| Lookup default display credentials    | [API][luma-get-display-credentials] |

[rest-api]: ./rest-api.md

[luma-get-config]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_config

[luma-clear-db]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_clear_db

[luma-get-display-credentials]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/luma_get_display_credentials

```

## Technicalities

* Use the hyphen (`-`), en dash (`–`), and em dash (`—`) characters appropriately.

  The hyphen (`-`) is used for compound terms and word division.

  > Onedata is a state-of-the-art system.

  The en dash (`–`) is used for ranges, scores and conflict, connection, or direction:

  > The years 2021–2022 brought rapid improvement of the POSIX–CEPH transfer performance.

  The em dash (`—`) is a versatile punctuation mark that can take the place of
  commas, parentheses, or colons, depending on the context. Always put a space
  before and after the em dash.

  > Authentication is carried by access tokens — bearer tokens that allow acting
  > on behalf of the token subject.

  For more tips, see the [punctuation guide][].

* To abbreviate the word `identifier`, stick to the `ID` notation rather than `Id`.

* Use the term `provider` when referring to a Onedata provider in most contexts,
  except when talking about a service or a piece of software — use `Oneprovider`
  then. For example:

  > You may choose between the supporting providers in the top menu.

  > The data is distributed between three providers.

  > As an admin, you should install the Oneprovider cluster to expose your storage system via Onedata.

* Use the term **storage backend** to refer to an instance of a storage system, do not use
  the legacy name (**storage**, **storages**).

## Custom routes

Can be placed in `./docs/.vuepress/enhanceApp.js`.

[the README]: README.md#development

[VuePress code blocks]: https://v1.vuepress.vuejs.org/guide/markdown.html#syntax-highlighting-in-code-blocks

[VuePress custom containers]: https://v1.vuepress.vuejs.org/guide/markdown.html#custom-containers

[GUI elements]: images/guidelines/gui-elements.png

[punctuation guide]: https://www.thepunctuationguide.com/hyphen.html
