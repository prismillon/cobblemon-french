# Cobblemon French

[![Release](https://github.com/prismillon/cobblemon-french/actions/workflows/update-and-release.yml/badge.svg)](https://github.com/prismillon/cobblemon-french/actions/workflows/update-and-release.yml)
[![Modrinth](https://img.shields.io/modrinth/dt/eaLh3Exs?logo=modrinth&label=Modrinth)](https://modrinth.com/resourcepack/cobblemon-french)

A Minecraft resource pack that provides **French translations** for [Cobblemon](https://modrinth.com/mod/cobblemon).

## Features

- French translations taken from Cobblemon's own `fr_fr.json`
- One pack release per Cobblemon release: pack version `X.Y.Z` is built from Cobblemon tag `X.Y.Z`
- Published automatically within a day of every Cobblemon release

## Installation

1. Download from [Modrinth](https://modrinth.com/resourcepack/cobblemon-french) (or from this repository's latest release)
2. Place the `.zip` in your `resourcepacks` folder
3. Enable it in-game: **Options -> Resource Packs**
4. Keep your Minecraft language set to **English (US)**

## How it works

This pack replaces `en_us.json` with Cobblemon's official French translations (`fr_fr.json`), so you get French Pokemon names, items, and UI while playing on English Minecraft.

The translation file is always taken from the git tag matching the released Cobblemon version, never from a moving branch, so a pack release always matches the mod it is built for.

## Release process

The [workflow](.github/workflows/update-and-release.yml) runs daily and:

1. Reads the latest Cobblemon release version from the Modrinth API
2. Compares it with the latest published version of this pack
3. If they differ, downloads `fr_fr.json` at the matching Cobblemon tag, commits it, builds the `.zip`, publishes it to Modrinth and creates a matching tag and release here
4. If they match, it does nothing

Translation changes that Cobblemon makes without a new mod release are picked up by the next release.

Manual runs support `dry_run` (build and validate without publishing) and `force_release` (re-publish the current version).

## Known limitations

`fr_fr.json` does not contain every string present in Cobblemon's `en_us.json`. Strings that upstream has not translated yet are missing from the pack and show up in game as their raw translation key rather than as English text. Each release summary reports the current untranslated count.

## License

Translations are from [Cobblemon](https://gitlab.com/cable-mc/cobblemon) under [MPL-2.0](LICENSE).
