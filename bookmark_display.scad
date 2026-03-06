// Bookmark Display - Parametric Tray with Flat Storage
// Features slanted display slots and a long frontal tray for extras to lie flat.

/* [Bookmark Dimensions] */
// Maximum width of your bookmarks
bookmark_width = 45; 
// Maximum height of your bookmarks (used for tray depth)
bookmark_height = 200;
// Thickness of the bookmark (plus a little wiggle room)
bookmark_thickness = 2.4; 
// Number of categories/slots side-by-side
number_of_slots = 3; // Reduced default to fit standard 3D print beds

/* [Display Configuration] */
// Gap between categories
slot_spacing = 8;
// Degrees to lean the display bookmark back
tilt_angle = 15; 

/* [Storage Bin Settings] */
// How much of the bookmark height should be supported in the flat tray
storage_depth = 180; 
// Height of the front retaining wall for storage
storage_wall_h = 8;

/* [Structural Settings] */
// Thickness of the wall/floor
wall_thickness = 2.4;
// Depth of the rear block holding the display bookmark
display_block_depth = 20;
// Height of the display block
display_height = 25;

/* [Internal Calculations] */
total_width = (number_of_slots * bookmark_width) + ((number_of_slots + 1) * wall_thickness) + ((number_of_slots - 1) * slot_spacing);
total_depth = display_block_depth + storage_depth + wall_thickness;

module slot_cutout(w, t, h) {
    translate([0, 0, -1])
    cube([w, t, h + 2]);
}

module side_wall() {
    // Elegant sloped side wall using hull to avoid subtractive holes
    hull() {
        // Front pillar
        cube([wall_thickness, wall_thickness, storage_wall_h + wall_thickness]);
        // Back pillar
        translate([0, total_depth - display_block_depth, 0])
        cube([wall_thickness, display_block_depth, display_height]);
    }
}

module main_fixture() {
    union() {
        // 1. The rear display block (solid)
        difference() {
            translate([0, total_depth - display_block_depth, 0])
            cube([total_width, display_block_depth, display_height]);
            
            // Display Slots
            for (i = [0 : number_of_slots - 1]) {
                x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
                y_pos = (display_block_depth / 2);
                
                translate([x_pos, total_depth - display_block_depth + y_pos, wall_thickness * 2])
                rotate([-tilt_angle, 0, 0])
                slot_cutout(bookmark_width, bookmark_thickness, 210);
            }
        }
        
        // 2. The front storage floor
        cube([total_width, total_depth - display_block_depth, wall_thickness]);
        
        // 3. Front retaining wall
        cube([total_width, wall_thickness, storage_wall_h + wall_thickness]);
        
        // 4. Solid Side Walls (Left and Right)
        side_wall();
        translate([total_width - wall_thickness, 0, 0])
        side_wall();
        
        // 5. Internal separators (if multiple slots)
        if (number_of_slots > 1) {
            for (i = [1 : number_of_slots - 1]) {
                x_pos = i * (bookmark_width + slot_spacing + wall_thickness);
                // Adjusting to line up with the wall spacing
                actual_x = wall_thickness + i * (bookmark_width + slot_spacing) - slot_spacing/2 - wall_thickness/2;
                
                translate([actual_x, 0, 0])
                side_wall();
            }
        }
    }
}

module main() {
    main_fixture();
}

main();

// Verification Echoes for 3D Printing
echo(str("Total Width: ", total_width, "mm"));
echo(str("Total Depth: ", total_depth, "mm"));
echo(str("Max Height: ", display_height, "mm"));

// Warning if dimensions exceed standard print beds
if (total_width > 220 || total_depth > 220) {
    echo("WARNING: Stand dimensions may exceed standard 220x220mm print beds.");
}
