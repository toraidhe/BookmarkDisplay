// Bookmark Display - Parametric Simple Tray Design
// Single-row horizontal layout with triangular rear stability footing.

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
tilt_angle = 12; 

/* [Structural Settings] */
// Thickness of the walls and base
wall_thickness = 2.4;
// Depth of the main slot block
tray_depth = 25;
// Height of the main slot block
tray_height = 15;
// Length of the triangular anti-tip footing extending from the back
footing_length = 60;

/* [Internal Calculations] */
total_width = (number_of_bookmarks * bookmark_width) + ((number_of_bookmarks + 1) * wall_thickness) + ((number_of_bookmarks - 1) * bookmark_spacing);
total_depth = tray_depth + footing_length;

module slot_cutout(w, t, h) {
    translate([0, 0, -1])
    cube([w, t, h + 2]);
}

module main_tray() {
    difference() {
        // Main block
        cube([total_width, tray_depth, tray_height]);
        
        // Slots
        for (i = [0 : number_of_bookmarks - 1]) {
            x_pos = wall_thickness + i * (bookmark_width + bookmark_spacing);
            
            translate([x_pos, wall_thickness, 5])
            rotate([-tilt_angle, 0, 0])
            slot_cutout(bookmark_width, bookmark_thickness, 150);
        }
    }
}

module triangular_footing() {
    // Triangular wedge at the ends for stability
    for (x_offset = [0, total_width - wall_thickness]) {
        translate([x_offset, tray_depth - wall_thickness, 0])
        rotate([0, -90, 0])
        linear_extrude(wall_thickness)
        polygon([
            [0, 0], // Bottom front
            [0, footing_length], // Bottom back
            [tray_height * 0.9, 0] // Top contact
        ]);
    }
}

module main() {
    // Single level Tray
    main_tray();
    
    // Stability Footing (per sketch)
    triangular_footing();
    
    // Base connector between footings (optional but helps stability)
    translate([0, tray_depth - wall_thickness, 0])
    cube([total_width, wall_thickness, wall_thickness]);
}

main();

// Verification Echoes
echo(str("Total Width: ", total_width, "mm"));
echo(str("Total Depth: ", total_depth, "mm"));
echo(str("Max Height: ", tray_height, "mm"));
