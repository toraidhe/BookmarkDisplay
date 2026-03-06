// Bookmark Display - Parametric Design

/* [General] */
// Height of the display
display_height = 150;
// Width of the display
display_width = 100;
// Depth of the display
display_depth = 50;
// Thickness of the walls
wall_thickness = 2.4;

/* [Internal] */

module main() {
    difference() {
        cube([display_width, display_depth, display_height]);
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([display_width - 2*wall_thickness, display_depth - 2*wall_thickness, display_height]);
    }
}

main();
