#!/bin/bash
# This script touch files (updates mtime) that use @include directive in Markdown files.
# It is needed to trigger VuePress to treat them as files to rebuild, as when you modify
# included file, the files that use the include are not marked to be rebuilt.

cd "$(dirname "${BASH_SOURCE[0]}")"
grep -l -r --include '*.md' '@include' docs/ | xargs touch
