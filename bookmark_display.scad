// Bookmark Display - Parametric Tiered Design with Anti-Tip Footing
// Refined based on user sketch showing triangular rear stability support.

/* [Bookmark Dimensions] */
// Maximum width of your bookmarks
bookmark_width = 45; 
// Thickness of the bookmark (plus a little wiggle room)
bookmark_thickness = 2.4; // Slightly increased for easier insertion
// Number of bookmarks per tier
slots_per_tier = 2;

/* [Display Configuration] */
// Number of tiered rows
number_of_tiers = 3;
// Height difference between each row for visibility
tier_step_height = 35;
// Degrees to lean bookmarks back (towards the footing)
tilt_angle = 12; 

/* [Structural Settings] */
// Thickness of the walls and base
wall_thickness = 2.4;
// Spacing between bookmarks side-to-side
slot_spacing = 10;
// Horizontal distance between tiers
tier_depth_step = 22;
// Length of the triangular anti-tip footing extending from the back
footing_length = 50;

/* [Internal Calculations] */
total_width = (slots_per_tier * bookmark_width) + ((slots_per_tier + 1) * wall_thickness) + ((slots_per_tier - 1) * slot_spacing);
main_body_depth = (number_of_tiers * tier_depth_step) + (wall_thickness * 2);
total_depth = main_body_depth + footing_length;
max_h = (number_of_tiers * tier_step_height) + 10;

module slot_cutout(w, t, h) {
    translate([0, 0, -1])
    cube([w, t, h + 2]);
}

module tier(tier_index) {
    z_offset = tier_index * tier_step_height;
    y_offset = tier_index * tier_depth_step;
    
    translate([0, y_offset, z_offset]) {
        difference() {
            // Tier block
            cube([total_width, tier_depth_step + wall_thickness, tier_step_height + 10]);
            
            // Slots
            for (i = [0 : slots_per_tier - 1]) {
                x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
                
                translate([x_pos, wall_thickness, 5])
                rotate([-tilt_angle, 0, 0])
                slot_cutout(bookmark_width, bookmark_thickness, 150);
            }
        }
    }
}

module triangular_footing() {
    // This creates the wedge shape shown in the user sketch
    for (x_offset = [0, total_width - wall_thickness]) {
        translate([x_offset, main_body_depth - wall_thickness, 0])
        rotate([0, -90, 0])
        linear_extrude(wall_thickness)
        polygon([
            [0, 0], // Bottom front of footing
            [0, footing_length], // Bottom back of footing
            [max_h * 0.7, 0] // Top contact point on main body
        ]);
    }
}

module main() {
    // Base Plate (under reaching main body)
    cube([total_width, main_body_depth, wall_thickness]);
    
    // Tiers
    for (t = [0 : number_of_tiers - 1]) {
        tier(t);
    }
    
    // Triangular Anti-Tip Footing (as per sketch)
    triangular_footing();
}

main();

// Verification Echoes
echo(str("Total Width: ", total_width, "mm"));
echo(str("Total Depth: ", total_depth, "mm"));
echo(str("Max Height: ", max_h, "mm"));
