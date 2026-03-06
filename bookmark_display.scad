// Bookmark Display - Parametric Tray with Storage Bin
// Features slanted display slots and a frontal bin for extra bookmarks.

/* [Bookmark Dimensions] */
// Maximum width of your bookmarks
bookmark_width = 45; 
// Thickness of the bookmark (plus a little wiggle room)
bookmark_thickness = 2.4; 
// Number of categories/slots side-by-side
number_of_slots = 5;

/* [Display Configuration] */
// Gap between categories
slot_spacing = 8;
// Degrees to lean the display bookmark back
tilt_angle = 15; 

/* [Storage Bin Settings] */
// Depth of the frontal bin for extras
storage_depth = 20;
// Height of the front retaining wall for storage
storage_wall_h = 10;

/* [Structural Settings] */
// Thickness of the wall/floor
wall_thickness = 2.4;
// Depth of the rear block holding the display bookmark
display_block_depth = 15;
// Height of the display block
display_height = 20;

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
            // Main block for the display slots
            cube([total_width, total_depth, display_height]);
            
            // Front lip for storage bin containment
            cube([total_width, wall_thickness, storage_wall_h]);
        }
        
        // 1. Display Slots (Slanted)
        for (i = [0 : number_of_slots - 1]) {
            x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
            y_pos = storage_depth + wall_thickness;
            
            translate([x_pos, y_pos, wall_thickness * 2])
            rotate([-tilt_angle, 0, 0])
            slot_cutout(bookmark_width, bookmark_thickness, 200);
        }
        
        // 2. Storage Bins (Frontal Area)
        for (i = [0 : number_of_slots - 1]) {
            x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
            
            // Recess the storage area
            translate([x_pos, wall_thickness, wall_thickness])
            cube([bookmark_width, storage_depth, display_height]);
        }
        
        // 3. Aesthetic Slope (Optional: transition from display height to storage height)
        // This makes it look less like a block and more like a tool
        translate([-1, wall_thickness + storage_depth, storage_wall_h])
        rotate([ atan((display_height-storage_wall_h)/5), 0, 0])
        cube([total_width + 2, 10, display_height]);
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
