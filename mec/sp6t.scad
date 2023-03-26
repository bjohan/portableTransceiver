use <util.scad>

module placeSp6tHolePattern(l=10){
translate([0,0,42.5+5-l])quad(35/2) children();
}

module sp6tHolePattern(l=10){
//translate([0,0,42.5+5-l])quad(35/2) cylinder(l, 3/2, 3/2);
    placeSp6tHolePattern() cylinder(l, 3/2, 3/2);
}

module sp6t(){
    cylinder(42.5, 20, 20);
    translate([0,0,-9])
    cylinder(9, 11.1, 11.1);
    translate([0,0,42.5]){
        difference(){
        centerCube([45, 45,3]);
       translate([0,0,-42.5+5])sp6tHolePattern();
        }
        translate([0,0,3]){
            color([0,1,0])nObj(13, 6, 0) cylinder(8, 6.5/2, 6.5/2);
            cylinder(8, 6.5/2, 6.5/2);
        }
    }
}

sp6t();