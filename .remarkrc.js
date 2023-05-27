module.exports = {
  "plugins": {
    "remark-preset-lint-recommended": true,
    "remark-lint-final-newline": false,
    "remark-lint-list-item-indent": "space",
    "remark-lint-list-item-bullet-indent": true,
    "remark-lint-no-shortcut-reference-link": true,
    "remark-lint-hard-break-spaces": true,
    "remark-lint-no-blockquote-without-marker": true,
    "remark-lint-no-undefined-references": { allow: [ 'toc' ] },
    
    // plugins other than recommended
    "remark-validate-links": true,
  }
};