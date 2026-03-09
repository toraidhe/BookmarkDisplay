// Bookmark Display - Parametric Tray with Flat Storage
// Features slanted display slots and a long frontal tray for extras to lie flat.

/* [Bookmark Dimensions] */
// Width of each slot (fits bookmarks up to 56mm with clearance)
bookmark_width = 60;
// Maximum height of your bookmarks (used for tray depth)
bookmark_height = 220;
// Thickness of the bookmark (plus a little wiggle room)
bookmark_thickness = 1.6;
// Number of categories/slots side-by-side
number_of_slots = 3; // Reduced default to fit standard 3D print beds

/* [Display Configuration] */
// Width of the vertical display slot (snug fit)
display_slot_width = 52.4;
// Gap between categories
slot_spacing = 2;
// Degrees to lean the display bookmark back
tilt_angle = 15;

/* [Storage Bin Settings] */
// Storage tray depth matches bookmark height
storage_depth = bookmark_height;
// Height of the front retaining wall for storage
storage_wall_h = 8;

/* [Structural Settings] */
// Thickness of the wall/floor
wall_thickness = 2.4;
// Depth of the rear block holding the display bookmark
display_block_depth = 26;
// Height of the display block
display_height = 36;

/* [Internal Calculations] */
// Width of internal separator walls (absorbs slot_spacing so storage bins = bookmark_width)
separator_width = wall_thickness + slot_spacing;
// Pitch per slot: bookmark width + one separator
slot_pitch = bookmark_width + separator_width;
total_width = (2 * wall_thickness) + (number_of_slots * bookmark_width) + ( (number_of_slots - 1) * separator_width);
total_depth = display_block_depth + storage_depth + wall_thickness;

module slot_cutout(w, t, h) {
  v_depth = 5; // How deep the V-shape goes
  translate([0, 0, -1]) {
    union() {
      // Main rectangular slot
      cube([w, t, h + 2]);
      // V-shaped bottom for self-centering
      hull() {
        translate([0, 0, 0]) cube([w, t, 0.1]);
        translate([w / 2, 0, -v_depth]) cube([0.1, t, 0.1]);
      }
    }
  }
}

module side_wall(w = wall_thickness) {
  // Elegant sloped side wall using hull to avoid subtractive holes
  hull() {
    // Front pillar
    cube([w, wall_thickness, storage_wall_h + wall_thickness]);
    // Back pillar
    translate([0, total_depth - display_block_depth, 0])
      cube([w, display_block_depth, display_height]);
  }
}

module main_fixture() {
  union() {
    // 1. The rear display block (solid)
    difference() {
      translate([0, total_depth - display_block_depth, 0])
        cube([total_width, display_block_depth, display_height]);

      // Display Slots
      for (i = [0:number_of_slots - 1]) {
        x_base = wall_thickness + i * slot_pitch;
        // Center the display slot within the compartment width
        centering_offset = (bookmark_width - display_slot_width) / 2;
        x_pos = x_base + centering_offset;

        y_pos = (display_block_depth / 2);

        translate([x_pos, total_depth - display_block_depth + y_pos, wall_thickness + 2])
          rotate([-tilt_angle, 0, 0])
            slot_cutout(display_slot_width, bookmark_thickness, 210);
      }
    }

    // 2. The front storage floor (Flat)
    cube([total_width, total_depth - display_block_depth, wall_thickness]);

    // 3. Front retaining wall with retrieval fillet
    union() {
      // Main vertical wall
      cube([total_width, wall_thickness, storage_wall_h + wall_thickness]);
      // Easy-Slide Retrieval Ramp
      ramp_w = storage_wall_h; // Width of the ramp base
      translate([0, wall_thickness, wall_thickness])
        rotate([90, 0, 90])
          linear_extrude(total_width)
            polygon([[0, 0], [ramp_w, 0], [0, storage_wall_h]]);
    }

    // 4. Solid Side Walls (Left and Right)
    side_wall();
    translate([total_width - wall_thickness, 0, 0])
      side_wall();

    // 5. Internal separators (if multiple slots)
    if (number_of_slots > 1) {
      for (i = [1:number_of_slots - 1]) {
        // Place the thick separator wall right after the previous slot
        sep_x = wall_thickness + (i - 1) * slot_pitch + bookmark_width;

        translate([sep_x, 0, 0])
          side_wall(separator_width);
      }
    }
  }
}

module main() {
  main_fixture();
}

// Include guard: only render when this is the top-level file
if (is_undef(__BOOKMARK_LID__)) {
  main();

  // Verification Echoes for 3D Printing
  echo(str("Total Width: ", total_width, "mm"));
  echo(str("Total Depth: ", total_depth, "mm"));
  echo(str("Max Height: ", display_height, "mm"));

  // Warning if dimensions exceed standard print beds
  if (total_width > 220 || total_depth > 220) {
    echo("WARNING: Stand dimensions may exceed standard 220x220mm print beds.");
  }
}
