const { logger } = require('@vuepress/shared-utils');
const process = require('process');
const TemplateRenderer = require('./template-renderer');

logger.info('Generating pages from templates...');
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
