/**
 * Adds support for Mermaid.js diagram rendering from `mermaid` code fences into Vuepress
 * 1.x.
 *
 * Based on MIT Licensed plugin: https://github.com/eFrane/vuepress-plugin-mermaidjs
 * Copyright © 2019-present Stefan "eFrane" Graupner
 *
 * Comparing to the original plugin, this plugin changes usage of local of mermaid.js file
 * (from npm) to usage of recent version of mermaid.js from CDN, which should be included
 * in vuepress project's config.js.  
 *
 * @author Jakub Liput
 * @copyright (C) 2025 ACK CYFRONET AGH
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

const path = require('path');

module.exports = (options, ctx) => {
  return {
    name: 'vuepress-plugin-mermaidjs-cdn',
    enhanceAppFiles: path.resolve(__dirname, 'mermaid.js'),
    extendMarkdown (md) {
      md.use(require('./markdown-it-plugin'));
    },
  }
}