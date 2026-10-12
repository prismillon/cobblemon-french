#!/usr/bin/env bash
#
# Print every Modrinth version of a project as a JSON array on stdout.
#
# GET /project/{slug}/version can trail a fresh publish: the newly published
# version is missing from that listing while the project's version id list
# already contains it. A release check reading only the listing would then still
# see the previous version as "latest" and publish the same version twice.
#
# So the listing is reconciled against the project's version id list, and any id
# the listing is missing is fetched individually.
#
# Usage: modrinth-versions.sh <project-slug>

set -euo pipefail

SLUG="${1:?usage: modrinth-versions.sh <project-slug>}"
API="${MODRINTH_API:-https://api.modrinth.com/v2}"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

get() {
  curl -sSL --fail --retry 3 --retry-all-errors "$1"
}

# JSON is kept in files, never in shell arguments: a large project payload (the
# Cobblemon project has hundreds of versions) exceeds the argument length limit.
get "$API/project/$SLUG" > "$TMP/project.json"
get "$API/project/$SLUG/version" > "$TMP/list.json"

jq -n --slurpfile project "$TMP/project.json" --slurpfile list "$TMP/list.json" \
  '($project[0].versions // []) - ($list[0] | map(.id))' > "$TMP/missing.json"

COUNT=$(jq 'length' "$TMP/missing.json")
if [ "$COUNT" -gt 0 ]; then
  echo "Note: $COUNT version(s) absent from the /version listing, fetching directly: $(jq -r 'join(", ")' "$TMP/missing.json")" >&2
fi

{
  jq -c '.[]' "$TMP/list.json"
  for ID in $(jq -r '.[]' "$TMP/missing.json"); do
    get "$API/version/$ID"
  done
} | jq -s '.'
