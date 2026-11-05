/**
 * Utilites to use in documentation build scripts/plugins.
 *
 * @author Jakub Liput
 * @copyright (C) 2025 Onedata (onedata.org)
 * @license This software is released under the MIT license cited in 'LICENSE.txt'.
 */

function getMajorRelease() {
  const { execSync } = require('child_process');
  const Path = require('path');
  const repoRoot = Path.join(__dirname, '..', '..');
  const majorRelease = execSync(
    `${Path.join(repoRoot, 'get-release.sh')} --major`,
    { encoding: 'utf-8' }
  ).trim();
  return majorRelease;
}

module.exports = {
  getMajorRelease,
};