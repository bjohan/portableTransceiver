use <util.scad>
use <connectors.scad>
body=[38.2,38.2, 19.2];
smaHeight=13;
smaL=6.2;
smaThread=6.2;
smaSep=12.8;
pinL=7.5;
pinR=0.3;
pinHeight=4;
pinSep=4.5;
testBoxBodyDim=[65,60,20];
testBoxWt=1.5;
testBoxTt=4;
cableHoleR=3;
cornerScrewOffset=4;
testBoxLidT=3;


module Sp4tSolidStateBody(){
    centerCube(body);
    translate([0,body[0]/2+smaL, smaHeight]) rotate([90,0,0])smaFemale(smaThread,smaL);
    translate([0,-body[0]/2-smaL, smaHeight]) rotate([-90,0,0])smaFemale(smaThread,smaL);
    translate([-body[0]/2-smaL, smaSep/2, smaHeight]) rotate([0,90,0])smaFemale(smaThread,smaL);
    translate([-body[0]/2-smaL, -smaSep/2, smaHeight]) rotate([0,90,0])smaFemale(smaThread,smaL);
    translate([body[0]/2+smaL, smaSep/2, smaHeight]) rotate([0,-90,0])smaFemale(smaThread,smaL);

    translate([0,-body[0]/2, pinHeight]) rotate([90,0,0]) cylinder(pinL,pinR,pinR);
    translate([-1*pinSep,-body[0]/2, pinHeight]) rotate([90,0,0]) cylinder(pinL,pinR,pinR);
    translate([-2*pinSep,-body[0]/2, pinHeight]) rotate([90,0,0]) cylinder(pinL,pinR,pinR);
    translate([-3*pinSep,-body[0]/2, pinHeight]) rotate([90,0,0]) cylinder(pinL,pinR,pinR);

    translate([3*pinSep,-body[0]/2, pinHeight]) rotate([90,0,0]) cylinder(pinL,pinR,pinR);
    translate([3*pinSep,-body[0]/2, pinHeight+pinSep]) rotate([90,0,0]) cylinder(pinL,pinR,pinR);
    translate([3*pinSep,-body[0]/2, pinHeight+2*pinSep]) rotate([90,0,0]) cylinder(5,1,1);
}

module placeSp4tSolidStateHolePattern(){
    quad(32.8/2) children();
}

module sp4tSolidStateHolePattern(l=20, r=1.5){
    placeSp4tSolidStateHolePattern() cylinder(l, r,r);
}

module Sp4tSolidState(){
    difference(){
        Sp4tSolidStateBody();
        sp4tSolidStateHolePattern();
    }
}

module placeTestBoxLidHoles(){
    quad2((testBoxBodyDim[0])/2-cornerScrewOffset,(testBoxBodyDim[1])/2-cornerScrewOffset) children();
}


module testBoxBody(){
    difference(){
        centerCube(testBoxBodyDim);
        centerCube(testBoxBodyDim-[2*testBoxWt,2*testBoxWt,testBoxTt]);
        zt(testBoxBodyDim[2]-testBoxTt-1)sp4tSolidStateHolePattern(l=testBoxTt+2, r=1.5);
    }
    placeTestBoxLidHoles() cylinder(10,cornerScrewOffset,cornerScrewOffset);
}

module testBoxLid(){
    difference(){
        centerCube([testBoxBodyDim[0], testBoxBodyDim[1], testBoxLidT]);
        placeTestBoxLidHoles() cylinder(10,1.5,1.5, $fn=10);
    }
}


module testBox(){
    difference(){
        testBoxBody();
        placeBananas() bananaFemale();
        placeSwitches() cylinder(10,3,3);
        placeCableHoles() cylinder(30,cableHoleR,cableHoleR);
        placeTestBoxLidHoles() cylinder(15, 1.5,1.5);
    }
}

module placeBananas(){
    zt((testBoxBodyDim[2]-testBoxTt)/2){
        yt(-testBoxBodyDim[1]/2)xr(90) children();
        xt(-19.05)yt(-testBoxBodyDim[1]/2)xr(90) children();
        xt(19.05)yt(-testBoxBodyDim[1]/2)xr(90) children();
    }
}

module placeSwitches(){
    zt((testBoxBodyDim[2]-testBoxTt)/2){
        //            yt(testBoxBodyDim[1]/2+2) xr(90) children();
        xt(-13/2)  yt(testBoxBodyDim[1]/2+2) xr(90) children();
        xt(13/2)   yt(testBoxBodyDim[1]/2+2) xr(90) children();
        xt(-13/2-13)  yt(testBoxBodyDim[1]/2+2) xr(90) children();
        xt(13/2+13)   yt(testBoxBodyDim[1]/2+2) xr(90) children();
    }
}

module assembly(){
    zt(20)Sp4tSolidState();
    testBox();
    placeBananas() bananaFemale();
    placeSwitches() cylinder(10,3,3);
    zt(-5)testBoxLid();
}

module placeCableHoles(){
    zt((testBoxBodyDim[2]-testBoxTt)-cableHoleR){
        xt(-testBoxBodyDim[0]/2+testBoxWt+cableHoleR)yt(-10)xr(90) children();
        xt(testBoxBodyDim[0]/2-testBoxWt-cableHoleR)yt(-10)xr(90) children();
    }
}


//testBox();
testBoxLid();
//assembly();

