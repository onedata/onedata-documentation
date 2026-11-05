/**
 * Part of original vuepress-plugin-mermaidjs customized to work with Mermaid.js from CDN.
 * 
 * See: https://github.com/eFrane/vuepress-plugin-mermaidjs
 * 
 * @author Stefan "eFrane" Graupner, Jakub Liput
 * @copyright (C) 2019-present Stefan "eFrane" Graupner, (C) 2025 ACK CYFRONET AGH
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */


const hash = require('./hash-sum');
const markdownItFence = require('./markdown-it-fence');

module.exports = function mermaidjsPlugin (md) {
  return markdownItFence(md, 'mermaid-fence', {
    render: (tokens, idx, _options, env, self) => {
      const token = tokens[idx];
      const key = `mermaid_${hash(idx)}`;
      const { content } = token;
      
      md.$dataBlock[key] = content;
  
      return `<Mermaid id="${key}" :graph="$dataBlock.${key}"></Mermaid>`;
    },
    validate: (params) => {
      return params.trim().split(' ').includes('mermaid');
    }
  })
}
