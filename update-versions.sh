#!/bin/bash
set -e
version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/stashapp/stash/releases/tags/latest_develop" | jq -re .target_commitish)
[[ ${version} == "develop" ]] && version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/stashapp/stash/commits/develop" | jq -re .sha)
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    '.version = $version' <<< "${json}" | tee VERSION.json
