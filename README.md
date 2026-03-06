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

Open [**`bookmark_display.scad`**](./bookmark_display.scad) in OpenSCAD. This file houses all critical parameters:

- `bookmark_width`: Width of your bookmark + clearance.
- `bookmark_thickness`: Adjust based on your bookmark stack height.
- `number_of_slots`: Define how many categories to display.
- `display_height`: Currently set to **36mm** for optimal support.

> [!TIP]
> Changing values in the display file will automatically update the Lid and the Test Utility!

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

> [!IMPORTANT]
> Ensure your `lid_clearance` (default 0.4mm) is calibrated to your printer's tolerances for a smooth telescoping action.
