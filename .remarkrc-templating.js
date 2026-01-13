/**
 * Special settings for templates and partials used to generate complete pages.
 *
 * Templates and partials often contain inconsistent indentation, references to other
 * parts of templates and so on. Templates and partials are not checked by linter when
 * using Makefile and CI, it is up to the creator to manually check these files against
 * the warnings. The settings disable some of the repeating linter warnings that are often
 * for templates and partials.
 *
 * Note that complete documents compiled from templates and partials are checked in
 * Makefile targets and CI.
 *
 * @author Jakub Liput
 * @copyright (C) 2025 ACK CYFRONET AGH
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

const globalConfig = require('./.remarkrc.js');
module.exports = {
  "settings": {
    ...globalConfig.settings,
  },
  "plugins": {
    ...globalConfig.plugins,
    // Partials should not have final line, which would insert unexpected new line to the
    // result document.
    "remark-lint-final-newline": false,
    // Partials often refer to references that are defined in the other partial, which is
    // inserted at the end of template.
    "remark-lint-no-undefined-references": false,
    "remark-validate-links": false,
    "remark-lint-no-unused-definitions": false,
    // Partials are fragments from the middle (except the first one), so they typically
    // don't contain first header.
    "remark-lint-missing-heading-in-file": false,
    // Sometimes a partial can contain continuation of list or something else which is
    // indented, so it is indented without valid remark context.
    "remark-lint-list-item-bullet-indent": false,
    "remark-lint-blockquote-indentation": false,
    "remark-lint-no-table-indentation": false,
  }
};
