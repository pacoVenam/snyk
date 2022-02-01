#!/usr/bin/env bash
set -euo pipefail

LATEST_PACKAGE_VERSION=$(npm view snyk version)
echo "LATEST_PACKAGE_VERSION: ${LATEST_PACKAGE_VERSION}"

echo "Assigning current versions."
if [[ $(uname -s) == "Darwin" ]];then
    echo "this is Mac"
    sed -i "" "s|1.0.0-monorepo|${LATEST_PACKAGE_VERSION}|g" ./lerna.json
    sed -i "" "s|1.0.0-monorepo|${LATEST_PACKAGE_VERSION}|g" ./package.json
    sed -i "" "s|1.0.0-monorepo|${LATEST_PACKAGE_VERSION}|g" ./packages/snyk-protect/package.json
    sed -i "" "s|1.0.0-monorepo|${LATEST_PACKAGE_VERSION}|g" ./packages/snyk-fix/package.json
else
    echo "this is Linux"
    sed -i "s|1.0.0-monorepo|${LATEST_PACKAGE_VERSION}|g" ./lerna.json
    sed -i "s|1.0.0-monorepo|${LATEST_PACKAGE_VERSION}|g" ./package.json
    sed -i "s|1.0.0-monorepo|${LATEST_PACKAGE_VERSION}|g" ./packages/snyk-protect/package.json
    sed -i "s|1.0.0-monorepo|${LATEST_PACKAGE_VERSION}|g" ./packages/snyk-fix/package.json
fi

echo "Current versions:"
cat ./lerna.json ./package.json ./packages/snyk-protect/package.json ./packages/snyk-fix/package.json | grep version

echo "Bumping minor versions."
npx lerna version minor --no-push --no-git-tag-version --exact

echo "Bumped versions:"
cat ./lerna.json ./package.json ./packages/snyk-protect/package.json ./packages/snyk-fix/package.json | grep version
