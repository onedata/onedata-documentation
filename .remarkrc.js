module.exports = {
  "settings": {
    bullet: "*",
    listItemIndent: "one",
    fences: true,
  },
  "plugins": {
    "remark-preset-lint-recommended": true,
    "remark-lint-final-newline": true,
    "remark-lint-list-item-indent": "space",
    "remark-lint-list-item-bullet-indent": true,
    "remark-lint-no-shortcut-reference-link": true,
    "remark-lint-hard-break-spaces": true,
    "remark-lint-no-blockquote-without-marker": true,
    "remark-lint-no-undefined-references": {
      allow: ['toc']
    },

    // plugins other than recommended
    "remark-gfm": true,
    "remark-validate-links": ["error"],
    "remark-frontmatter": true,
    "remark-lint-table-pipes" : true,
  }
};