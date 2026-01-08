/**
 * Injects major release number into styles, which is needed to resolve the fonts path.
 *
 * @author Jakub Liput
 * @copyright (C) 2025 Onedata (onedata.org)
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

const { getMajorRelease } = require('./utils.js');
const Path = require('path');
const majorRelease = getMajorRelease();

const { readFileSync, writeFileSync } = require('fs');

const stylesDir = './docs/.vuepress/styles/';

const indexTemplateContent = readFileSync(
  Path.join(stylesDir, 'index-template.styl'),
  { encoding: 'utf8' }
);
const indexTargetContent = `$major-release = '${majorRelease}'\n${indexTemplateContent}`;
writeFileSync(Path.join(stylesDir, 'index.styl'), indexTargetContent);

/**
 * @see https://vuepress.vuejs.org/plugin
 * @type {import('@vuepress/types').Plugin}
 */
module.exports = (
  {},
  /* context */
) => ({});
