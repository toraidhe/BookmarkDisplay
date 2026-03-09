# Changelog

All notable changes to the Bookmark Display project will be documented in this file.

## [1.3.0] - 2026-03-09

### Added (v1.3.0)

- **Decoupled Precision Slots**: Introduced `display_slot_width` (52.4mm) to allow a snugger fit for bookmarks without changing the overall tray width (60mm).
- **Deep-Fit Support**: Increased `display_block_depth` to **26mm** to provide more engagement and prevent vertical lean.

### Added (v1.2.0)

- **Easy-Slide Retrieval Ramp**: Added a 45-degree fillet to the internal front wall of the storage bins for easier bookmark removal.
- **Centering V-Slots**: Display slots now feature a steep V-shaped bottom geometry to self-center bookmarks upon insertion.
- **Documentation Architect Skill**: Integrated a project-specific agentic skill for automated documentation maintenance.

### Changed (v1.2.0)

- **Optimal Display Height**: Adjusted `display_height` to **36mm** for a better balance between support and visibility.
- **Relative Pathing**: Refactored all project documentation to use machine-independent relative file paths.

## [1.1.0] - 2026-03-06

### Added (v1.1.0)

- **Telescoping Lid**: Created a matching cover with internal partitions that follow the box's slope.
- **Lid Grab Gap**: Shortened the lid walls slightly to allow users to grip the base when sliding the lid off.
- **Test-Fit Utility**: Introduced `test_fit.scad` for visual verification of 3D models and lid clearances.

### Changed (v1.1.0)

- **Synchronized Parameters**: Refactored the lid to include the display file as a single source of truth for dimensions.

## [1.0.0] - 2026-03-05

### Added (v1.0.0)

- **Initial Release**: Basic parametric bookmark display with slanted slots and a frontal storage tray.
- **Parametric Width/Height**: Support for custom bookmark sizes and slot counts.
