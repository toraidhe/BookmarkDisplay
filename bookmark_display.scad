// Bookmark Display - Parametric Elegant Tray Design
// Features a full-length architectural kickstand and slanted slots for stability.

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
// Degrees to lean bookmarks back (towards the footing)
tilt_angle = 15; 

/* [Structural Settings] */
// Thickness of the wall between slots
wall_thickness = 2.4;
// Depth of the block holding the bookmarks
tray_depth = 28;
// Height of the block holding the bookmarks
tray_height = 20;
// Length of the elegant kickstand extending from the back
footing_length = 65;

/* [Internal Calculations] */
total_width = (number_of_bookmarks * bookmark_width) + ((number_of_bookmarks + 1) * wall_thickness) + ((number_of_bookmarks - 1) * bookmark_spacing);
total_depth = tray_depth + footing_length;

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

module elegant_kickstand() {
    // A single architectural wedge running the full length of the display
    translate([0, tray_depth, 0])
    rotate([0, -90, 0])
    linear_extrude(total_width)
    polygon([
        [0, -wall_thickness], // Anchor to bottom front of tray
        [0, footing_length], // Far tip of the stability footing
        [tray_height * 0.85, -wall_thickness] // Anchor to upper part of tray
    ]);
}

module main() {
    // Single level Tray holding the slots
    main_tray();
    
    // Elegant full-length kickstand for maximum stability and aesthetics
    elegant_kickstand();
}

main();

// Verification Echoes for 3D Printing
echo(str("Total Footprint Width: ", total_width, "mm"));
echo(str("Total Footprint Depth: ", total_depth, "mm"));
echo(str("Tray Height: ", tray_height, "mm"));
