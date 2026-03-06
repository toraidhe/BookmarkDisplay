// Bookmark Display - Parametric Tray-Only Design
// Simplified single-row horizontal layout without a kickstand.

/* [Bookmark Dimensions] */
// Maximum width of your bookmarks
bookmark_width = 45; 
// Thickness of the bookmark (plus a little wiggle room)
bookmark_thickness = 2.4; 
// Number of bookmarks to display side-by-side
number_of_bookmarks = 5;

/* [Display Configuration] */
// Gap between bookmarks
bookmark_spacing = 8;
// Degrees to lean bookmarks back
tilt_angle = 15; 

/* [Structural Settings] */
// Thickness of the wall between slots
wall_thickness = 2.4;
// Depth of the block holding the bookmarks (larger depth = more stability)
tray_depth = 40;
// Height of the block holding the bookmarks
tray_height = 20;

/* [Internal Calculations] */
total_width = (number_of_bookmarks * bookmark_width) + ((number_of_bookmarks + 1) * wall_thickness) + ((number_of_bookmarks - 1) * bookmark_spacing);
total_depth = tray_depth;

module slot_cutout(w, t, h) {
    translate([0, 0, -1])
    cube([w, t, h + 2]);
}

module main_tray() {
    difference() {
        // Main structural block
        cube([total_width, tray_depth, tray_height]);
        
        // Slanted Bookmark Slots
        for (i = [0 : number_of_bookmarks - 1]) {
            x_pos = wall_thickness + i * (bookmark_width + bookmark_spacing);
            
            translate([x_pos, wall_thickness, wall_thickness * 2])
            rotate([-tilt_angle, 0, 0])
            slot_cutout(bookmark_width, bookmark_thickness, 200);
        }
    }
}

module main() {
    // Single level Tray holding the slots
    main_tray();
}

main();

// Verification Echoes for 3D Printing
echo(str("Total Footprint Width: ", total_width, "mm"));
echo(str("Total Footprint Depth: ", total_depth, "mm"));
echo(str("Tray Height: ", tray_height, "mm"));
