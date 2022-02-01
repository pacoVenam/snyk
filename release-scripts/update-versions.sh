#!/usr/bin/env bash
set -euo pipefail

release_branch="master"
if [ "${CIRCLE_BRANCH}" == "${release_branch}" ]; then
  ./release-scripts/update-versions.sh
else
  ./release-scripts/update-dev-versions.sh
fi

npx ts-node ./release-scripts/prune-dependencies-in-packagejson.ts
