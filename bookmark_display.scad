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

module main_fixture() {
    difference() {
        union() {
            // Main base block covering the entire footprint
            cube([total_width, total_depth, display_height]);
        }
        
        // 1. Display Slots (at the very back)
        for (i = [0 : number_of_slots - 1]) {
            x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
            y_pos = total_depth - display_block_depth;
            
            translate([x_pos, y_pos + (display_block_depth/2), wall_thickness * 2])
            rotate([-tilt_angle, 0, 0])
            slot_cutout(bookmark_width, bookmark_thickness, 210);
        }
        
        // 2. Flat Storage Trays (Frontal Area)
        for (i = [0 : number_of_slots - 1]) {
            x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
            
            // Recess the storage area so bookmarks lie flat
            // The depth is now significant to allow them to lie flat lengthwise
            translate([x_pos, wall_thickness, wall_thickness])
            cube([bookmark_width, storage_depth + (total_depth - storage_depth - display_block_depth - wall_thickness), display_height - wall_thickness + 1]);
        }
        
        // 3. Front Wall Height Trim
        // This lowers the front of the block to the 'storage_wall_h'
        translate([-1, -1, storage_wall_h])
        cube([total_width + 2, storage_depth + wall_thickness, display_height]);
        
        // 4. Aesthetic Slope transition from front wall to back display
        translate([-1, storage_depth + wall_thickness, storage_wall_h])
        rotate([-15, 0, 0])
        cube([total_width + 2, 30, display_height]);
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
