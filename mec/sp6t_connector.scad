pinClearance = 0.25;
sep = 30;
module x(d) {
    translate([d,0,0]) children();
}
module z(d) {
    translate([0,0,d]) children();
}

module connectorPin(flare = 0.25){
    cylinder(9, 0.9+flare, 0.9, $fn=10);
    z(9) cylinder(0.8+0.3, 1.1+0.15, 1.1+0.15, $fn=10);
    cylinder(9, 0.9, 0.9, $fn=10);
    cylinder(14+1, 0.9, 0.9, $fn=10);
    cylinder(20, 0.5, 0.5, $fn=10);
}


module placePins(){
    pinPosRadius = (15.9-1.8)/2;
    nPins = 13;
    populatedPins = [true, true, true, false, true, false, true, false, true, false, true, true, true];
    for(i = [0:nPins-1]) if(populatedPins[i]) rotate([0,0,360/nPins*i]) x(pinPosRadius) children();
}

module lockSpheres(d=0){
    sr = 2+d;
    n = 3;
    r = 3.0;
    for(i=[1:n]) rotate([0, 0, i*360/n]) x(r) sphere(sr, $fn=10);
}

module centerScrewThreadHole(){
    cylinder(100, 1.5, 1.5);
}

module centerScrewFreeHole(){
    cylinder(100, 1.6, 1.6, $fn=10);
}

module centerScrewHeadHole(){
    cylinder(100, 4, 4, $fn=10);
}

module connectorBottomBody(){
    cylinder(9, 9, 9);
    z(9)lockSpheres();
}

module pinsWithClearance(){
       minkowski(){
            placePins() connectorPin();
            sphere(pinClearance, $fn=10);
        }
}

module connectorBottom(){
    difference(){
        connectorBottomBody();
        pinsWithClearance();
        centerScrewThreadHole();
    }
}

module connectorMiddleBody(){
    z(9.0) cylinder(3,9,9);
    z(9+3)lockSpheres();
}

module connectorMiddle(){
    difference(){
        connectorMiddleBody();
        z(9)lockSpheres(d=0.4);
        pinsWithClearance();
        centerScrewFreeHole();
    }
}

module connectorTopBody(){
    z(9.0+3.0) cylinder(22-12,9,9);
}

module connectorTop(){
    difference(){
        connectorTopBody();
        z(9+3)lockSpheres(d=0.4);
        z(20) centerScrewHeadHole();
        placePins() z(9+6) cylinder(19, 1.2, 1.2, $fn=10);
        pinsWithClearance();   
        centerScrewFreeHole();
    }
}

module connectorAssembly(){
    connectorBottom();
    z(sep)connectorMiddle();
    z(2*sep)connectorTop();
    placePins() connectorPin();
}

connectorAssembly();

//connectorTop();
//connectorMiddle();
//connectorBottom();
//placePins() connectorPin();