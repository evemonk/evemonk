# EveMonk Feature Flags (via flipper gem)

All external calls should be wrapper with feature flags.

## Current feature flags

This is current list with description:

| name                    | description                        |
|-------------------------|------------------------------------|
| `:pghero`               | Disable pghero jobs                |
| `:eve_server_status`    | Disable ESI server status calls    |
| `:eve_races`            | Disable ESI races calls            |
| `:eve_bloodlines`       | Disable ESI bloodlines calls       |
| `:eve_ancestries`       | Disable ESI ancestries calls       |
| `:eve_factions`         | Disable ESI factions calls         |
| `:eve_character`        | Disable ESI character calls        |
| `:eve_character_assets` | Disable ESI character assets calls |
| `:eve_character_online` | Disable ESI character online calls |
| `:eve_character_ship`   | Disable ESI character ship calls   |
| `:eve_corporation`      | Disable ESI corporation calls      |
| `:eve_alliance`         | Disable ESI alliance calls         |
| `:eve_alliances`        | Disable ESI alliances calls        |

## Enable/Disable feature flag

To enable feature flag e.g. `:pghero`:

```ruby
Flipper.enable(:pghero)
```

To disable feature flag e.g. `:pghero`:

```ruby
Flipper.disable(:pghero)
```

## New feature flags

All new feature flags should be added in disabled state.

## UI

UI mounted at `/flipper`. Require `admin` flag on user.
