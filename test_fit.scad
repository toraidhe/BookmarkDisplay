// Bookmark Display - Test Fit Utility
// Use this file to verify the fit of your 3D models (e.g. Berserk-Bookmark)
// Adjust the alignment settings in the Customizer to line up your STL.

// Include guard: prevents the box from rendering automatically so we can control color/opacity
__BOOKMARK_LID__ = true;
include <bookmark_display.scad>
use <bookmark_lid.scad>

/* [Bookmark Alignment] */
// Manual X, Y, Z translation of the STL relative to its own origin
stl_translate = [-137, -5, 0];
// Manual X, Y, Z rotation of the STL
stl_rotate = [180, 0, 90];
// Scaling factor (e.g. 1.0 for mm, 25.4 for inches if exported wrong)
stl_scale = 1.0;

/* [Visual Testing] */
// Opacity of the display box (0.0 to 1.0)
box_opacity = 0.5; // [0:0.1:1.0]
// Show the lid?
show_lid = false;
// Show a cross-section cut?
cutaway = "none"; // [none, half_x, half_y, front_slot]

/* [Internal Logic - Positioning] */
// Helper to render the bookmark with current alignment
module aligned_bookmark() {
  scale(stl_scale)
    rotate(stl_rotate)
      translate(stl_translate)
        import("Berserk-Bookmark(embossed).stl");
}

module visualization_wrapper() {
  difference() {
    union() {
      // The Box
      color("Gray", box_opacity)
        main_fixture();

      // The Lid (optional)
      if (show_lid) {
        // Ensure lid is included with guard
        // (Guard is handled by __BOOKMARK_LID__ in bookmark_lid.scad)
        color("White", box_opacity)
          translate([0, 0, 0]) // Adjust if you want it lifted
            lid();
      }

      // 1. Vertical Slot Test (Slot 0)
      color("Cyan", 0.9)
        translate([wall_thickness + bookmark_width / 2, total_depth - display_block_depth / 2, wall_thickness - 2])
          rotate([-tilt_angle - 90, 0, 0])
            aligned_bookmark();

      // 2. Storage Fit Test (Slot 1)
      color("Magenta", 0.9)
        translate([wall_thickness + bookmark_width + separator_width + bookmark_width / 2, total_depth / 2, wall_thickness + 2])
          rotate([0, 0, 0])
            // rotate([0, 90, 0]) // Optional: extra tip for laying flat
            aligned_bookmark();
    }

    // Cutaway Logic
    if (cutaway == "half_x") {
      translate([total_width / 2, -50, -50]) cube([total_width, total_depth + 100, 200]);
    } else if (cutaway == "half_y") {
      translate([-50, total_depth / 2, -50]) cube([total_width + 100, total_depth, 200]);
    } else if (cutaway == "front_slot") {
      // Cut away the front of the display block to see the slot engagement
      translate([-50, total_depth - display_block_depth, -50])
        cube([total_width + 100, display_block_depth, 200]);
    }
  }
}

// Final Render
visualization_wrapper();

echo(str("Testing Fit for: Berserk-Bookmark(embossed).stl"));
echo(str("Total Width: ", total_width));
echo(str("Total Depth: ", total_depth));
