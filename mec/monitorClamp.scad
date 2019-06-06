h1 = 19;
h2 = 23;
w = 15;
l = 50;
oh = 15;
nh = 3;
r = 3/2;

module clamp(h, w, t, oh, l, nh, r){
    difference(){
        union(){
            cube([l, w, h]);
            translate([0,0,h]){
                cube([l, w+oh, t]);
            }
        }
        s = l/(nh+1);
        for(i=[1:nh]){
            translate([s*i,w/2,0]) cylinder(h+t, r, r);
        }
    }
}


module nucClamp(){
    //cube([115, 65, 3]);
    difference(){
        union(){
            cube([115, 50, 19]);
            translate([-10,0,0]) cube([10, 50-38, 55]);
            translate([115,0,0]) cube([10, 50-38, 55]);
        }
            translate([-5,6,35]) cylinder(100,r,r);
            translate([120,6,35])cylinder(100,r,r); 
        nh = 5;
        s = 115/(nh+1);
        for(i=[1:nh]){
                translate([s*i,50-w/2,0]) cylinder(100, r, r);
        }
        
        translate([25,18,0]) cylinder(100, 5, 5);
        translate([36,18,0]) cylinder(100, 4, 4);
    }
    
}

module nucPlate(){
    difference(){
        union(){
            cube([115, 65+2, 3]);
            translate([-10,0,0]) cube([10, 50-38, 3]);
            translate([115,0,0]) cube([10, 50-38, 3]);
        }
            translate([-5,6,0]) cylinder(100,r,r);
            translate([120,6,0])cylinder(100,r,r); 
        
        d1 = 13;
        translate([d1,15,0]) cylinder(100,7,7);
        translate([115-d1,15,0])cylinder(100,7,7); 
        d2 = 15.5;
        translate([d2,15+47.5,0]) cylinder(100,2.5,2.5);
        translate([115-d2,15+47.5,0])cylinder(100,2.5,2.5); 
    }
    
}

module nucClampDrillGuides(){
    difference(){
        cylinder(20, 4.2, 4.2);
        cylinder(20, 3/2, 3/2);
    }
    
    translate([12,0,0])
    difference(){
        cylinder(20, 3.2, 3.2);
        cylinder(20, 3/2, 3/2);
    }
}

module buttonGuide(){
        nh = 6;
        s = 75/(nh-1);
        r=3;
        difference(){
        translate([-15/2,0,0])cube([90,15,3]);
        for(i=[1:nh]){
                translate([s*(i-1),7,0]) cylinder(20, 3, 3);
        }
    }
        translate([s*4+1.5*2-0.5,-10,0])cube([10,10,3]);
}

//buttonGuide();
//nucClampDrillGuides();

//rotate([180,0,0]) clamp(h2, w, 5, oh, l, nh, r);
//nucClamp();
nucPlate();
