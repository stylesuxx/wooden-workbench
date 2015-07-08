// The measurements of the table
tableHeight = 850;
tableWidth = 1035;
tableLength = 2305;

topThickness = 20;

// Measurements of the available planks
plankWidth = 44;
plankHeight = 98;

// How much space should there be for your feet
footSpace = 399;

// At which height from the bottom should the shelves be
shelfHeight = 400;

module plank(width, depth, length) {
	cube([width, length, depth]);
}

module foot(width, depth, length) {	
	rotate([270, 0, 90])
		plank(width, depth, length);
	rotate([270, 0, 0])
		plank(width, depth, length);
}

module foot_t(width, depth, length) {
	translate([0, depth / 2 -(width / 2), 0])
		rotate([270, 0, 90])
			plank(width, depth, length);
	rotate([270, 0, 0])
		plank(width, depth, length);
}


// Calculated values
footHeight = tableHeight - topThickness;
innerWidth = tableWidth - plankWidth * 4;
outerWidth = tableWidth - plankWidth * 2;
bottomPlateLength = (tableLength - plankWidth * 5) / 2;

// Print the needed parts
echo("Plates:");
echo("1  x", tableWidth, " x ", tableLength, " x ", topThickness, "mm");
echo("2  x", innerWidth - footSpace, " x ", tableWidth - plankWidth * 5, " x ", topThickness, "mm");

echo("Planks:");
echo("2  x ", plankHeight, " x ", plankWidth, " x ", tableLength, "mm");
echo("12 x ", plankHeight, " x ", plankWidth, " x ", footHeight, "mm");

echo("6  x ", plankHeight, " x ", plankWidth, " x ", innerWidth, "mm");

// front left
foot(plankWidth, plankHeight, footHeight);

// back left
translate([-(tableWidth - plankWidth * 4), 0, -footHeight])
	rotate([180, 0, 180])
		foot(plankWidth, plankHeight, footHeight);

// front center
translate([0, tableLength / 2 - plankHeight, 0])
		foot_t(plankWidth, plankHeight, footHeight);

// back center
translate([-tableWidth + plankWidth * 4, tableLength / 2 - plankHeight, -tableHeight])
	rotate([0, 180, 0])
		foot_t(plankWidth, plankHeight, footHeight);

translate([0, tableLength - plankWidth * 2, -footHeight]) {
	rotate([180, 0, 0]) {
		// front right
		foot(plankWidth, plankHeight, footHeight);

		// back right
		translate([-tableWidth + plankWidth * 4, 0, -footHeight])
			rotate([180, 0, 180])
				foot(plankWidth, plankHeight, footHeight);
	}
}

// Outer connection
color("black", 0.5) {
	// connection left
	translate([plankWidth, -plankWidth, -plankHeight])
		rotate([0, 0, 90])
			plank(plankWidth, plankHeight, tableWidth - plankWidth * 2);

	// connection right
	translate([plankWidth, -plankWidth * 2 + tableLength, -plankHeight])
		rotate([0, 0, 90])
			plank(plankWidth, plankHeight, tableWidth - plankWidth * 2);

	// connection front
	translate([plankWidth, -plankWidth, -plankHeight])
		plank(plankWidth, plankHeight, tableLength);

	// connection back
	translate([-tableWidth + plankWidth * 2, -plankWidth, -plankHeight])
		plank(plankWidth, plankHeight, tableLength);
}

// inner connection
color("red", 0.4) {
	// center left top
	translate([0, tableLength / 2 -plankWidth - plankHeight / 2 - plankWidth / 2, -plankHeight])
		rotate([0,0,90])
			plank(plankWidth, plankHeight, innerWidth);
	
	// center right top
	translate([0, tableLength / 2 -plankWidth - plankHeight / 2 - plankWidth / 2 + plankWidth * 2, -plankHeight])
		rotate([0,0,90])
			plank(plankWidth, plankHeight, innerWidth);

	// center left center
	translate([0, tableLength / 2 -plankWidth - plankHeight / 2 - plankWidth / 2, -(tableHeight - shelfHeight + plankHeight)])
		rotate([0,0,90])
			plank(plankWidth, plankHeight, innerWidth);
	
	// center right center
	translate([0, tableLength / 2 -plankWidth - plankHeight / 2 - plankWidth / 2 + plankWidth * 2, -(tableHeight - shelfHeight + plankHeight)])
		rotate([0,0,90])
			plank(plankWidth, plankHeight, innerWidth);

	// left center
	translate([0, plankWidth,-(tableHeight - shelfHeight + plankHeight)])
		rotate([0, 0, 90])
			plank(plankWidth, plankHeight, innerWidth);
	
	// right center
	translate([0, tableLength -plankWidth * 4, -(tableHeight - shelfHeight + plankHeight)])
		rotate([0,0,90])
			plank(plankWidth, plankHeight, innerWidth);
}

color("green", 0.5) {
	// top
	translate([-tableWidth + plankWidth * 2, -plankWidth, 0])
		cube([tableWidth, tableLength, topThickness]);

	// left shelf
	translate([-tableWidth + plankWidth * 4, plankWidth, -(tableHeight - shelfHeight)])
		cube([innerWidth - footSpace, bottomPlateLength, topThickness]);

	// right shelf
	translate([-tableWidth + plankWidth * 4, tableLength / 2 - plankWidth / 2, -(tableHeight - shelfHeight)])
		cube([innerWidth - footSpace, bottomPlateLength, topThickness]);
}