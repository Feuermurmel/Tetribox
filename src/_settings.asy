real grid_size = 30mm;
real height = 50mm;

int vertical_fingers = 7;

// This better be an even number!
int horizontal_fingers_per_grid = 4;

real wood_thickness = 4mm;
real horizontal_studs_size = 1.5 * wood_thickness;
real vertical_studs_size = 1.5 * wood_thickness;

// Added on all sides to compensate material removed by the laser.
real laser_offset = .05mm;

// Removed between sides.
real slot_gap = .1mm;

real convex_corner_radius = 0.5mm;
real concave_corner_radius = 0.1mm;

pen cut_pen = .01mm + blue;
