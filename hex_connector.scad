include <polyholes.scad>

clearance = 0.5;
wall_thickness = 2;
extrusion_size = 20;
hole_size = 5;
angle = 50; // 50 degrees for hex connector

foot_hole_size = 10;


size = extrusion_size + clearance + wall_thickness;

module hex_connector(foot_hole = false) {
	difference() {
		union() {
			translate([0,-extrusion_size*2,0]) {
				connector();
			}		

			rotate(-angle) translate([0,extrusion_size*2,0]) {
				mirror([0,1,0]) connector();
			}
		}
		if(foot_hole) {
			rotate([0,0,-angle/2]) 
			  translate([(size/2)/cos(angle/2),0,size/2]) 
			    cylinder(size, foot_hole_size/2, foot_hole_size/2, true);
		}
	}
}

module connector() {
	difference() {
		cube([size,extrusion_size*2,size]);
		translate([wall_thickness,0,0]) cube(extrusion_size + clearance);	
		translate([extrusion_size/2 + wall_thickness + clearance, extrusion_size/2, extrusion_size]) polyhole(wall_thickness + 2*clearance, hole_size);
		translate([0 - clearance, extrusion_size/2, extrusion_size/2]) rotate([0,90,0]) polyhole(wall_thickness + 2*clearance, hole_size);
	}
}



hex_connector(true);