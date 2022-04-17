s = 5;
module hackRfBody(){
    cube([126.5, 83, 28]);
}

module centerCube(v){
    translate([-v[0]/2,-v[1]/2,0]) cube(v);
}

module smaConnector(){
    rotate([0,90,0]){
cylinder(4,10/2, 10/2);
translate([0,0,4])cylinder(7, 6.5/2, 6.5/2);
    }
}

module button(){
rotate([0,90,0]) cylinder(1, 1, 1);
}

module placeSmaConnectors(){
    translate([125,83-18,8])children();
    translate([0,83-16,8])rotate([0,0,180])children();
    translate([0,83-(16+19.5),8])rotate([0,0,180])children();
}

module placeButtons(){
    translate([125, 15, 12]) children();
    translate([125, 32, 12]) children();
}

module usbNotch(){
    rotate(0,90,0)centerCube([6,10, 5]);
}

module placeUsbNotch(){
    translate([0,27.5,6.5]) children();
}

module hackRf(){
    difference(){
        hackRfBody();
        placeUsbNotch() usbNotch();
    }
    placeSmaConnectors() smaConnector();
    placeButtons() button();
    
}

module placeHackRfs(){
    translate([s,28+s,0]) rotate([90,0,0]) children();
    translate([s,(28+s)*2,0]) rotate([90,0,0]) children();
    translate([s,(28+s)*3,0]) rotate([90,0,0]) children();
}
module flarp(){
    intersection(){
        union(){
    cube([100, 1.8, 83]);
    translate([0,1.8/2, 83+2.5])rotate([0,90,0])cylinder(100, 3, 3);
        }
    cube(150);
    }
}

module flarps(ang){
    d = 6;
    rotate([-90,0,0])translate([0,-0.6*d-28,0]){
    rotate([-ang,0,0]) flarp();
    translate([0,28+d*1.2,0])mirror([0,1,0]) rotate([-ang,0,0])flarp();
    }
}

module hackRack(){
translate([25/2,0,0]) placeHackRfs() flarps(5);
    difference(){
        cube([125+2*s, (28)*3+4*s, 10]);
   
    placeHackRfs() minkowski() {hackRf(); cylinder(1,0.6, 0.6);}

    }
}
//hackRack();
//placeHackRfs() hackRf();

module slideLock(l){
    d = 3;
    difference(){
        cube([31+2*d,9+d,l]);
        translate([d+1,-80,l])rotate([0,90,0]) minkowski(){flarps(1.8);cylinder(0.6);}
    }
}

slideLock(15);

