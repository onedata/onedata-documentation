#!/usr/bin/env node

/**
 * Generates Markdown files for all templates found in `/templates` dir, using partials
 * from `/partials` dir.
 * 
 * Templates rendering is done automatically when VuePress documentation is built, but
 * it is not re-launched when files change in dev (watch) mode. You can launch this script
 * to update the target docs during the dev session.
 * 
 * See `./docs/.vuepress/template-renderer` module documentation for more information.
 * 
 * Requires Node v16+
 *
 * @author Jakub Liput
 * @copyright (C) 2024 ACK CYFRONET AGH
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

const path = require('path');
const TemplateRenderer = require('./docs/.vuepress/template-renderer');

function main() {
  const templateRenderer = new TemplateRenderer(path.resolve(__dirname));
  templateRenderer.generateAllTemplates();
}

main();