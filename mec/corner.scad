r = 16; //18, 20
t = 15;
l = 55-r;
h = 20;

rh=3/2;
module bendBody(t, l, h, r){
    difference(){
        cylinder(h,r,r);
        if(t < r) cylinder(h, r-t, r-t);
        translate([0,-(r-t),0 ]) cube([2*r,r*2,h]);
        translate([-(r-t),0,0 ]) cube([r*2,r*2,h]);
    }

    translate([0,-r, 0])cube([l, t, h]);
    translate([-r,0, 0])cube([t, l, h]);
}



module bendBodyTopHoles(t, l, h, r, rh){
    translate([0,-(r-t)-t/2,0]){
        cylinder(h, rh, rh);
        translate([l-t/2, 0,0]) cylinder(h, rh, rh);
    }
    translate([-(r-t)-t/2,0,0]){
        cylinder(h, rh, rh);
        translate([0,l-t/2,0]) cylinder(h, rh, rh);
    }
}

module sideHolePlane(t, l, h, r, rh){
translate([-(r-t)-t/2,0,0]){
        rotate([0,90,0]) translate([0,rh*3,-t/2])cylinder(t, rh, rh);
        rotate([0,90,0]) translate([0,l-t/2-rh*3,-t/2]) cylinder(t, rh, rh);
    }
    
    
translate([0,-(r-t)-t/2,0]){
        rotate([90,0,0]) translate([rh*3,0,-t/2]) cylinder(t, rh, rh);
        rotate([90,0,0]) translate([l-t/2-rh*3, 0,-t/2]) cylinder(t, rh, rh);
    }
}
module bendBracket(t, l, h, r, rh){
    difference(){
        bendBody(t, l, h, r);
        bendBodyTopHoles(t, l, h, r, rh);
        translate([0,0,rh*3]) sideHolePlane(t, l, h, r, rh);
        translate([0,0,h-rh*3]) sideHolePlane(t, l, h, r, rh);
    }
}



bendBracket(t, l, h, r, rh);
//translate([0,0,3]) bendBracket(t, l, 5, r, rh);
//bendBracket(t+10, l, 3, r+5, rh);

//translate([-r,0,0]) cube(30);