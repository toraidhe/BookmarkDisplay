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
            // 1. The main display block (high part at the back)
            translate([0, total_depth - display_block_depth, 0])
            cube([total_width, display_block_depth, display_height]);
            
            // 2. The storage tray base (lower part at the front)
            cube([total_width, total_depth - display_block_depth, storage_wall_h + wall_thickness]);
            
            // 3. Side walls to contain the flat bookmarks
            for (x_offset = [0, total_width - wall_thickness]) {
                translate([x_offset, 0, 0])
                cube([wall_thickness, total_depth - display_block_depth, display_height]);
            }
            
            // 4. Front retaining wall for the flat storage
            cube([total_width, wall_thickness, storage_wall_h + wall_thickness]);
        }
        
        // A. Display Slots (Slanted) - These sit in the high display block
        for (i = [0 : number_of_slots - 1]) {
            x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
            // Position the slot comfortably within the display block
            y_pos = total_depth - (display_block_depth / 2);
            
            translate([x_pos, y_pos, wall_thickness * 2])
            rotate([-tilt_angle, 0, 0])
            slot_cutout(bookmark_width, bookmark_thickness, 210);
        }
        
        // B. Flat Storage Recesses
        for (i = [0 : number_of_slots - 1]) {
            x_pos = wall_thickness + i * (bookmark_width + slot_spacing);
            
            // Cut out the tray area so bookmarks can lie flat
            translate([x_pos, wall_thickness, wall_thickness])
            cube([bookmark_width, total_depth - display_block_depth - wall_thickness, display_height]);
        }
        
        // C. Aesthetic Slope (transition side walls down to front wall)
        for (x_offset = [-1, total_width - wall_thickness-1]) {
            translate([x_offset, 0, storage_wall_h + wall_thickness])
            rotate([0, 90, 0])
            linear_extrude(wall_thickness + 2)
            polygon([
                [0, 0],
                [0, total_depth - display_block_depth],
                [display_height - (storage_wall_h + wall_thickness), total_depth - display_block_depth]
            ]);
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
