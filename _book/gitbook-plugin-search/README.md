# plugin-search

This plugin adds interactive search in sidebar

## Important note

This plugin is modified version of original `gitbook-plugin-search` from
<https://github.com/GitBookIO/plugin-search> with patch that fixes async indexing
problem (disappearing sidebar content). Also the build process is modified to
use it directly from source files in GitBook.

### Disable this plugin

This is a default plugin and it can be disabled using a `book.json` configuration:

```
{
    plugins: ["-search"]
}
```
