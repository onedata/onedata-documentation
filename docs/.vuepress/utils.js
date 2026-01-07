// FIXME: jsdoc

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