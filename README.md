# Bookmark Display Utility

A parametric OpenSCAD project for displaying and storing bookmarks. Features a base stand with slanted display slots and a high-capacity storage tray, plus a sleek telescoping lid for protection.

## Project Structure

- **`bookmark_display.scad`**: The main base unit. Features a high-capacity storage tray and slanted display slots.
- **`bookmark_lid.scad`**: A telescoping "cube-style" lid that encloses the display. Includes internal anti-rattle dividers.
- **`test_fit.scad`**: A utility script to visually verify the fit of 3D models (e.g., the Berserk Bookmark) within the design before printing.

## Features

- **High Capacity**: Storage walls are sized to hold up to **50 bookmarks** stacked per category.
- **Parametric Design**: Easily adjust bookmark width, height, thickness, and the number of slots. The lid and display are linked for perfect fit.
- **Sleek Aesthetic**: Uniform-height outer walls create a clean rectangular "block" look when the lid is on.
- **Visual Verification**: Use the `test_fit.scad` utility to verify clearances for embossed or complex bookmark models.

## Usage

1. Open **`bookmark_display.scad`** in OpenSCAD to customize the base.
2. Open **`bookmark_lid.scad`** to preview or export the protective cover.
3. (Optional) Open **`test_fit.scad`** to check your specific bookmark model's fit using the Customizer alignment settings.

## 3D Printing Recommendations

- **Material**: PLA, PETG, or ABS.
- **Infill**: 10-15% is sufficient for the lid.
- **Support**: Not required. Print the **lid upside down** (open side up) to avoid the need for internal supports on the ceiling.
