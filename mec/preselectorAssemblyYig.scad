//Distance from top of bottom encolosure to top of PCB 23mm

module cCube(v){
    d=-[v[0], v[1],0]/2;
    translate(d) cube(v);
}

module quadPlace(x,y){
    translate([x,y,0]) children();
    translate([x,-y,0]) children();
    translate([-x,y,0]) children();
    translate([-x,-y,0]) children();
}

module placeAlignmentScrews(){
    rotate([0,0,180])children();
    translate([0,70.739, 0]) children();
}

module placeDriverScrews(){
    translate([2.54+6.858,70.739+4.191,  0]) for(i=[0:7]) translate([i*10.795,0,0])children();
}

module placeRegulatorScrews(){
    translate([ 45.72,-4.572, 0 ]) for(i=[0:3]) translate([i*13.716,0,0])children();
}

module centerInBox(){
    translate([-96.139/2,-70.739/2, 0]) children();
}


module placeTo220Screws(){
    centerInBox() translate([0, 0, 17]){
        placeDriverScrews() rotate([-90,0,0]) children();
        placeRegulatorScrews() rotate([90,0,0]) children();
    }
}

module frame(){
    translate([0,0,17-4])
    difference(){
        cCube([115,89, 8]+[10,10,0]);
        cCube([115,89, 8]);
    }
}


module placePcbScrews(){
    centerInBox() placeAlignmentScrews()  children();
    mirror([1,0,0])centerInBox() placeAlignmentScrews() children();
}

module frameBody(){
    frame();
    intersection(){
        placePcbScrews() hull() {
            cylinder(21, 4, 4);
            translate([0, 20, 0])cylinder(21, 4, 4);
        }
        cCube([115,89, 21]+[10,10,0]);
    }
    placeTo220Screws() cylinder(15,4,4);
}

module pcbYig(){
    difference(){
        frameBody();
        placePcbScrews() cylinder(21,1.5,1.5);
        placeTo220Screws() cylinder(20,1.5,1.5);
        cCube([86,89, 30]);
    }
}

module boxYigBody(){
    difference(){
        cCube([120+6, 94+6,23+3]);
        cCube([120, 94,23+3]-[20, 20,-10]);
        cCube([120, 94,23]);
        
        
    }
    difference(){
        placeTo220Screws() cylinder(15,4,4);
        cCube([120, 94,23]);
        
    }
}

module boxYig(){
    difference(){
        boxYigBody();
        quadPlace(110/2,84/2) cylinder(30, 2, 2);
        placeTo220Screws() cylinder(15,1.5,1.5);
    }
}

difference(){
boxYig();
    cCube([200,200,13]);
}
//pcbYig();



