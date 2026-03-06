// Include guard: prevents the box from rendering when we include its parameters
__BOOKMARK_LID__ = true;
include <bookmark_display.scad>

/* [Lid Settings] */
// Gap between lid inner walls and box outer walls (print tolerance)
lid_clearance = 0.4;

/* [Derived Box Dimensions for Lid] */
box_front_h = storage_wall_h + wall_thickness;

/* [Lid Calculations] */
lid_outer_width = total_width + 2 * (wall_thickness + lid_clearance);
lid_outer_depth = total_depth + 2 * (wall_thickness + lid_clearance);
// Ceiling height is display_height + clearance. Total lid height adds wall_thickness on top.
lid_ceiling_z = display_height + lid_clearance;
lid_height = lid_ceiling_z + wall_thickness;

module lid_divider(w, d, h_front, h_rear, block_d) {
  // Internal divider that fills the space above the sloped box walls
  // Top is flat at lid_ceiling_z. Bottom is sloped to match the box.
  ceiling = lid_ceiling_z;

  // We use hull to create the sloped volume that fills the gap
  hull() {
    // Front pillar (thin slice at the front wall)
    translate([0, 0, h_front])
      cube([w, 0.1, ceiling - h_front]);

    // Transition point (where the display block starts)
    // At this point the box wall reaches display_height, so gap is zero (+clearance)
    translate([0, d - block_d, h_rear])
      cube([w, 0.1, 0.1]);

    // Keep the top flat across the whole span
    translate([0, 0, ceiling - 0.1])
      cube([w, d - block_d, 0.1]);
  }
}

module lid() {
  // Center the lid coordinate system so the box origin [0,0,0] 
  // is at [wall_thickness + lid_clearance, wall_thickness + lid_clearance, 0]
  box_offset_x = wall_thickness + lid_clearance;
  box_offset_y = wall_thickness + lid_clearance;

  union() {
    // 1. Outer Shell
    difference() {
      cube([lid_outer_width, lid_outer_depth, lid_height]);

      // Hollow out the main cavity
      translate([wall_thickness, wall_thickness, -1])
        cube(
          [
            lid_outer_width - 2 * wall_thickness,
            lid_outer_depth - 2 * wall_thickness,
            lid_ceiling_z + 1,
          ]
        );
    }

    // 2. Internal Dividers
    if (number_of_slots > 1) {
      for (i = [1:number_of_slots - 1]) {
        // Determine x-position of the box separator
        box_sep_x = wall_thickness + (i - 1) * slot_pitch + bookmark_width;

        // Lid divider width set to exactly match box separator width
        div_w = separator_width;

        translate([box_offset_x + box_sep_x, box_offset_y, 0])
          lid_divider(
            w=div_w,
            d=total_depth,
            h_front=box_front_h + lid_clearance,
            h_rear=display_height + lid_clearance,
            block_d=display_block_depth
          );
      }
    }
  }
}

// Render the lid
lid();

// Verification Echoes
echo(str("Lid Outer Width: ", lid_outer_width, "mm"));
echo(str("Lid Outer Depth: ", lid_outer_depth, "mm"));
echo(str("Lid Total Height: ", lid_height, "mm"));
echo(str("Box Front Height: ", box_front_h, "mm"));
echo(str("Box Max Height: ", display_height, "mm"));
