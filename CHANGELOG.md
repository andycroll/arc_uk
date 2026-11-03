# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.2.0] - 2026-11-03

### Changed
- Uses cinebase 5.10. `NFF` titles name the Nottingham Film Festival, which Arc Beeston hosts.

## [1.1.0] - 2026-11-03

### Changed
- Uses cinebase 5.9: performances take the raw `title:`, so audience labels become variants, and series prefixes such as `Met Opera:` become the performance's `event`.

### Fixed
- A premiere label after a dash, such as `Party USA - NFF UK Premier`, is removed.

## [1.0.0] - 2026-11-01

### Added
- `ArcUk::Cinema.all` and `ArcUk::Cinema.new(id)` for Arc's cinemas, from the cinema menu and site codes on the Arc home page, with addresses from each venue's cinema info page and coordinates from OpenStreetMap.
- `ArcUk::Performance.at(id, from:, to:)`, from the venue's what's on page, which holds every advertised date, with booking links, variants for Arc's showtime icons, languages and film years from titles, and festivals, on cinebase 5.7's shared A1Web support.
- Fixtures trimmed from live pages, a live shape test that checks real responses without storing them, and GitHub Actions CI and release workflows.
