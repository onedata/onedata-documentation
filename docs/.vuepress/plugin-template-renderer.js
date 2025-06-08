/**
 * Invokes template renderer before VuePress build starts (both `build` and `dev`).
 * See README.md in this project for more information about template system.
 * 
 * We cannot use `ready` hook because VuePress needs files generated before it starts -
 * otherwise it will crash because of lack of pages in the index.
 * 
 * Currently this plugin does not support livereload re-rendering because `updated` hook
 * seems to not work properly (from our tests: it does not work at all) in VuePress 1.9.9.
 *
 * @author Jakub Liput
 * @copyright (C) 2024 ACK CYFRONET AGH
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

const process = require('process');
const TemplateRenderer = require('./template-renderer');

console.log('Generating pages from templates...');
const templateGenerator = new TemplateRenderer(process.cwd());
templateGenerator.generateAllTemplates();

/**
 * @see https://vuepress.vuejs.org/plugin
 * @type {import('@vuepress/types').Plugin}
 */
module.exports = (
  {},
  /* context */
) => ({});
