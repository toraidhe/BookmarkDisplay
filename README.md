# Bookmark Display Utility

A parametric OpenSCAD project for displaying and storing bookmarks. This system creates a high-capacity base stand with slanted display slots and matches it with a custom-fit telescoping lid.

## 🚀 Key Features

- **Enhanced Display Stability**: Display height adjusted to **36mm** with internal **V-shaped centering slots** for perfect bookmark alignment.
- **Easy-Slide Retrieval**: Built-in retrieval ramp in the storage tray floor for effortless bookmark removal.
- **Parametric Synchronization**: All components (Base, Lid, and Test Utility) share a single source of truth for dimensions.
- **Aesthetic "Block" Design**: When the lid is closed, the unit forms a clean, rectangular cube that hides the internal sloped geometry.
- **Anti-Rattle Dividers**: The lid includes internal spacers that match the box slope to keep bookmarks secure during transport.
- **Diagnostic Tooling**: Integrated test-fit utility for aligning custom 3D models before printing.

## 📂 Project Structure

| File | Description |
| :--- | :--- |
| [bookmark_display.scad](./bookmark_display.scad) | **Primary File**. Defines all shared dimensions and the base display fixture. |
| [bookmark_lid.scad](./bookmark_lid.scad) | The protective telescoping cover with internal dividers. |
| [test_fit.scad](./test_fit.scad) | Utility for visualizing the fit of external STLs (e.g. Berserk-Bookmark). |
| [SKILL.md](./.agents/skills/documentation_architect/SKILL.md) | Agentic skill for maintaining project documentation synchronization. |

## 🛠 Usage Instructions

### 1. Customizing the Design

Open [**`bookmark_display.scad`**](./bookmark_display.scad) in OpenSCAD. The following core parameters control the entire assembly:

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `bookmark_width` | 60mm | Width of the slot. Usually `real_width + 4mm`. |
| `bookmark_height` | 220mm | Used for tray depth and lid height calculations. |
| `bookmark_thickness` | 1.6mm | Slot width. Adjust for thick wooden or metal bookmarks. |
| `number_of_slots` | 3 | How many bins/display slots side-by-side. |
| `display_height` | 36mm | Height of the rear display block for bookmark support. |
| `slot_spacing` | 2mm | Gap between categories (controls divider thickness). |
| `tilt_angle` | 15° | Angle at which the display bookmark leans back. |

> [!TIP]
> **Single Source of Truth**: Changing values in the display file will automatically update the Lid and the Test Utility dimensions!

### 2. Verifying Model Fit

If you have a complex or embossed 3D bookmark (like the Berserk Bookmark), use [**`test_fit.scad`**](./test_fit.scad):

- Adjust `stl_rotate` and `stl_translate` in the Customizer to align your model.
- Toggle `show_lid` to check the fit with the cover on.
- Use `cutaway` modes to inspect internal clearances.

### 3. Printing the Cover

Open [**`bookmark_lid.scad`**](./bookmark_lid.scad) to render and export the telescoping lid.

## 🖨 3D Printing Recommendations

- **Material**: PLA, PETG, or ABS.
- **Infill**: 10-15% is sufficient.
- **Orientation**:
  - **Base**: Print as-is (no supports needed).
  - **Lid**: **Print upside down** (open side facing up). This ensures the ceiling prints perfectly without any internal supports.

## 🔍 Technical Deep Dive

### Self-Centering V-Slots

Unlike standard rectangular slots, this design uses a `hull()` between a flat surface and a central point to create a **drastic V-bottom**. This ensures that regardless of how thin or wide your bookmark is (relative to the slot width), gravity will naturally guide it to the dead center of the display block.

### Retrieval Ramp (Ramp-to-Retrieval)

The storage tray features a 45-degree ramp on the frontal wall. This is implemented via a `linear_extrude` of a triangle polygon. It transforms the storage bin from a simple "box" into an ergonomic tray where you can "roll" bookmarks up and out using a single finger.

### Synchronized Telescoping Lid

The lid uses an `if (is_undef(__BOOKMARK_LID__))` guard to include `bookmark_display.scad` without rendering the box itself.

- **Anti-Rattle Dividers**: The lid's internal dividers are not simple rectangles. They are generated using a `hull()` that precisely matches the slope of the box's internal separators.
- **Lid Grab Gap**: The lid height is intentionally calculated to stop 10mm short of the table at the rear, exposing the base unit's bottom for a secure grip during opening.

## 🤝 Contributing

Contributions are welcome! Please ensure any geometric changes are parametric and reflected in the [**`test_fit.scad`**](./test_fit.scad) utility. This project is maintained using the [**Documentation Architect**](./.agents/skills/documentation_architect/SKILL.md) skill.
