/**
 * Logic of template rendering system.
 * 
 * Templates are Markdown files placed in `/templates` dir that include other files
 * (partials) placed in `/partials`. The result structure of generated files is mirroring
 * the structure of documents in `/templates` dir. For example:
 * 
 * - there is a template: `/templates/user-guide/page.md`,
 * - it uses `<!-- @include something.md -->` and `<!-- @include /one/other.md -->`
 *   partials includes in the content,
 * - partials should be placed in `/partials/something.md` and `/partials/one/other.md`
 *   paths
 * - during the generation, page with included content from partials is copied to
 *   `/docs/user-guide/page.md`.
 * 
 * The `@include` directive can hold optional JSON with strings to replace in the result.
 * For example you can define replacements this way:
 * 
 * ```
 * <!-- @include something.md { "variableName": "some **Markdown** text" } -->
 * ```
 * 
 * The strings to replace are present in partial documents and have the following format:
 * 
 * ```
 * **@insert variableName**
 * ```
 * 
 * See documentation of `TemplateRenderer.includeRe` in the code for more information.
 *
 * @author Jakub Liput
 * @copyright (C) 2024 ACK CYFRONET AGH
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

const fs = require('fs');
const path = require('path');

module.exports = class TemplateRenderer {
  static get generatedComment() {
    return '<!-- THIS FILE WAS GENERATED FROM TEMPLATE, DO NOT EDIT IT MANUALLY -->';
  }

  /**
   * Parses include directives in the following format:
   * 
   * `<!-- @include <partial-path.md> <optional JSON with interpolation variables> -->`
   * 
   * - `partial-path.md` is a relative path to partial Markdown file from /partials dir,
   * - the JSON is optional,
   * - the JSON is a flat maping of variable name used in partial -> value to be inserted,
   * - the directive can be written multiline, whitespaces are ignored.
   * 
   * For example:
   * 
   * ```
   * <!-- @include maintenance.md
   * {
   *   "serviceUpper": "Onezone",
   *   "service": "onezone",
   *   "installationAnchor": "[Installation][]",
   *   "installationRef": "[Installation]: installation.md"
   * }
   * -->
   * ```
   * 
   * @returns {RegExp}
   */
  static get includeRe() {
    return /<!--\s+@include\s+(\S+)\s*((\{(.|\s)*?\})(.|\s)*?-->|\s*-->)/gm;
  }

  constructor(projectDir) {
    this.projectDir = projectDir;
    this.templatesDir = projectDir + '/templates';
    this.sourceDir = projectDir + '/docs';
    this.partialsDir = projectDir + '/partials';
  }

  generateAllTemplates() {
    const templates = readdirSync(this.templatesDir).filter(name => name.endsWith('.md'));
    templates.forEach(templatePath => {
      const outputPath = templatePath.replace(this.templatesDir, this.sourceDir);
      console.log(`${templatePath} -> ${outputPath}`);
      const originalContent = fs.readFileSync(templatePath, {
        encoding: 'utf8'
      });
      const processedContent = this.processTemplate(originalContent);
      fs.writeFileSync(outputPath, processedContent);
    });
  }

  /**
   * @param {string} content 
   * @returns {string}
   */
  processTemplate(content) {
    let newContent = content.replaceAll(
      TemplateRenderer.includeRe,
      (match, partialFileName, suffix, specRawJson) => {
        const partialPath = this.partialsDir + '/' + partialFileName;
        const specData = specRawJson ? JSON.parse(specRawJson) : null;
        const partialContent = fs.readFileSync(partialPath, {
          encoding: 'utf8'
        });
        return specData ? this.replaceVariables(partialContent, specData) : partialContent;
      });
    newContent = newContent.replace(
      /^(#.*\n)/m,
      `$1\n${TemplateRenderer.generatedComment}\n`
    );
    return newContent;
  }

  replaceVariables(content, specData) {
    return content.replaceAll(/\*\*\s*@insert\s+(.*?)\s*\*\*/gm, (match, variable) => {
      return specData[variable];
    });
  }
}

function readdirSync(dirPath, result = []) {
  if (fs.statSync(dirPath).isDirectory()) {
    fs.readdirSync(dirPath).map(f =>
      readdirSync(result[result.push(path.join(dirPath, f)) - 1], result)
    );
  }
  return result;
}