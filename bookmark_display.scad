// Bookmark Display - Parametric Tiered Design
// Designed for visibility, stability, and FDM printability.

/* [Bookmark Dimensions] */
// Maximum width of your bookmarks
bookmark_width = 45; 
// Thickness of the bookmark (plus a little wiggle room)
bookmark_thickness = 2.0;
// Number of bookmarks per tier
slots_per_tier = 2;

/* [Display Configuration] */
// Number of tiered rows
number_of_tiers = 3;
// Height difference between each row for visibility
tier_step_height = 35;
// Degrees to lean bookmarks back (helps visibility and stability)
tilt_angle = 8; 

/* [Structural Settings] */
// Thickness of the walls and base
wall_thickness = 2.4;
// Spacing between bookmarks side-to-side
slot_spacing = 10;
// Horizontal distance between tiers
tier_depth_step = 20;
// Extra length for the rear footing to prevent tipping
base_rear_extension = 40;

/* [Internal Calculations] */
total_width = (slots_per_tier * bookmark_width) + ((slots_per_tier + 1) * wall_thickness) + ((slots_per_tier - 1) * slot_spacing);
total_depth = (number_of_tiers * tier_depth_step) + wall_thickness + base_rear_extension;

module slot_cutout(w, t, h) {
    // A slightly deeper cutout to ensure clean subtraction
    translate([0, 0, -1])
    cube([w, t, h + 2]);
}

module tier(tier_index) {
    z_offset = tier_index * tier_step_height;
    y_offset = tier_index * tier_depth_step;
    
    translate([0, y_offset, z_offset]) {
        // Main block for this tier
        difference() {
            cube([total_width, tier_depth_step + wall_thickness, tier_step_height + 10]);
            
            // Generate slots for this tier
            for (i = [0 : slots_per_tier - 1]) {
                x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
                
                translate([x_pos, wall_thickness, 5])
                rotate([-tilt_angle, 0, 0])
                slot_cutout(bookmark_width, bookmark_thickness, 100);
            }
        }
    }
}

module side_bracing() {
    // Triangulated side support for stability and aesthetics
    for (x_offset = [0, total_width - wall_thickness]) {
        translate([x_offset, 0, 0])
        linear_extrude(wall_thickness)
        polygon([
            [0, 0],
            [total_depth, 0],
            [total_depth, (number_of_tiers-1) * tier_step_height],
            [0, 0]
        ]);
    }
}

module main() {
    // Base Plate
    cube([total_width, total_depth, wall_thickness]);
    
    // Tiers
    for (t = [0 : number_of_tiers - 1]) {
        tier(t);
    }
    
    // Stability Bracing
    side_bracing();
}

// Display the result
main();

// Stability Echoes for Verification
echo(str("Total Width: ", total_width, "mm"));
echo(str("Total Depth: ", total_depth, "mm"));
echo(str("Max Height: ", (number_of_tiers-1) * tier_step_height + 10, "mm"));
