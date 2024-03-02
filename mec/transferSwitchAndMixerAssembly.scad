module quad(x2, y2, v=[true, true, true, true]){
    x = x2/2;
    y = y2/2;
    if(v[0]) translate([x, y, 0]) children();
    if(v[1]) translate([x, -y, 0]) children();
    if(v[2]) translate([-x, y, 0]) children();
    if(v[3]) translate([-x, -y, 0]) children();
}

module cCube(v){
    x = v[0]/2;
    y = v[1]/2;
    translate([-x, -y, 0]) cube(v);
}

module smaFemale(){
    r=6.3/2;
    l=7;
    cylinder(l,r,r);
}

module placeRelay411cjSmas(v=[true, true, true, true]){
    lsma=22.6-6.3;
    quad(lsma, lsma, v) rotate([180,0,0]) children();
}

module relayBody411cj(){
    r = 3;
    bs = 32.4;
    th=58.5;
    hull(){
        quad(bs-2*r, bs-2*3) cylinder(1,r,r);
        translate([0,0,th-r])quad(bs-2*r, bs-2*3) sphere(r);
    }
    lsma=22.6-6.3;
    //quad(lsma, lsma) rotate([180,0,0])smaFemale();
    placeRelay411cjSmas() smaFemale();
    translate([0,0,th])rotate([0,0,45])cCube([31, 13, 8]);
    translate([-bs/2, 0,6]) sphere(2.5);
    translate([bs/2, 0,6]) sphere(2.5);
    translate([0, -bs/2,6]) sphere(2.5);
}

module placeMountingPlateHolePattern411cj(){
    s=27.6/2;
    translate([23, 0, 0]) children();
    translate([-23, -s, 0]) children();
    translate([-23, s, 0]) children();
}

module mountingPlateBody411cj(t=1.5){
    l = 55;
    w = 40.4;
    
    cl=11.4;
    cw=14.8;
    
    cl2 = 11.4;
    cw2 = 13.8;
    tc = t+0.5;
    difference(){
    cCube([l, w, t]);
        translate([-l/2+cl/2, 0, 0])cCube([cl, cw, tc]);
        translate([l/2-cl2/2, w/2-cw2/2, 0])cCube([cl2, cw2, tc]);
        translate([l/2-cl2/2, -w/2+cw2/2, 0])cCube([cl2, cw2, tc]);
        //placeMountingPlateHolePattern() cylinder(2, 3.6/2, 3.6/2);
    }
}

module mountingPlate411cj(t=1.5){
    difference(){
        mountingPlateBody411cj(t=t);
        placeMountingPlateHolePattern411cj() cylinder(t+0.5, 3.6/2, 3.6/2);
    }
}

module placeMontingBracketOnRelay411cj() {
    s=40.4/2;
    bs = 32.4/2;
    translate([0, bs, s])rotate([-90,0,0]) children();
}

module relay411cj(){
    placeMontingBracketOnRelay411cj() mountingPlate411cj();
    relayBody411cj();
}


module relayBodyPe71S6119(){
    r = 3;
    bs = 32.4;
    th=45;
    translate([0,1.5,0]){
        hull(){
            quad(bs-2*r, bs-2*3) cylinder(1,r,r);
            translate([0,0,th-r])quad(bs-2*r, bs-2*3) sphere(r);
        }
        lsma=22.6-6.3;
        //quad(lsma, lsma) rotate([180,0,0])smaFemale();
        placeRelay411cjSmas() smaFemale();
        translate([0,7.6/2,th]) cylinder(5,2,2);
        translate([0,-7.6/2,th]) cylinder(5,2,2);
        for(i=[0:3]) rotate([0,0,i*90]) translate([-bs/2, 7.5,6]) sphere(2.5);
        cCube([bs, bs, 3.3]);
    }
}

module relayPe71S6119(){
    relayBodyPe71S6119();
}

module mixerHolePattern(){
    quad(6.2, 11.2) children();
}

module mixerSmaConnector(r=6.3/2){
    //r=6.3/2;
    rm = 4.7/2;
    cylinder(9.6, rm, rm);
    translate([0,0,4])cylinder(5.6, r, r);
    hull(){
        cylinder(1, 2.4, 2.4);
        cCube([13.2, 2, 1]);
    }
    quad(10.4,0)cylinder(2+1, 2.3/2, 2.3/2);
}

module mixerBody(){
        cCube([14.5, 13.2, 4.8]);
}


module placeMixerConnectors(v=[true, true,true]){
    l=14.5;
    w=13.2;
    h=4.8/2;
    if(v[0]) translate([0, -w/2, h])rotate([90, 0, 0]) rotate([0,0,-45/4])children();
    if(v[1]) rotate([0,0,90])translate([0, -l/2, h])rotate([90, 0, 0]) rotate([0,0,-45/4])children();
    if(v[2]) rotate([0,0,3*90])translate([0, -l/2, h])rotate([90, 0, 0]) rotate([0,0,-45/4])children();
}

module mixer(r=6.3/2){
    l=14.5;
    w=13.2;
    h=4.8/2;
    difference(){
        mixerBody();
         mixerHolePattern() cylinder(6,0.8, 0.8);
    }
    //translate([0, -w/2, h])rotate([90, 0, 0]) rotate([0,0,-45/4])mixerSmaConnector(r=r);
    //rotate([0,0,90])translate([0, -l/2, h])rotate([90, 0, 0]) rotate([0,0,-45/4])mixerSmaConnector(r=r);
    //rotate([0,0,3*90])translate([0, -l/2, h])rotate([90, 0, 0]) rotate([0,0,-45/4])mixerSmaConnector(r=r);
    placeMixerConnectors() mixerSmaConnector(r=r);
}

module bracketBody(){
    r=5;
    difference(){
        union(){
            hull() quad(35-r, 35-r) cylinder(19.5,r,r);
            placeMontingBracketOnRelay411cj()mountingPlateBody411cj(t=3.8);
            intersection(){
                translate([-30,0,0]) cube(20);
                translate([0,-2.5,0])placeMontingBracketOnRelay411cj()mountingPlateBody411cj(t=3.8-1.5);
            }
            
        }
        minkowski(){
            children();
            //relay411cj();
            sphere(0.3);
        }
        minkowski(){
            union(){
                placeMixer() mixerBody();
                placeMixer() mixer(r=5);
            }
            sphere(0.3);
        }
        placeMontingBracketOnRelay411cj(){
            minkowski(){
                mountingPlateBody411cj();
                rotate([90, 0, 0])cylinder(100, 0.3, 0.3);
            }
        }
    }
    
}

module bracket411cj(){
    difference(){
        bracketBody() relayBody411cj();
        translate([0,-10,0])placeMontingBracketOnRelay411cj() placeMountingPlateHolePattern411cj() cylinder(20, 1.5, 1.5);
        translate([-8,0,0])placeMixer() mixerHolePattern() cylinder(10, 0.5, 0.5);
    }
    
}

module bracket87222c(){
    difference(){
        bracketBody() relay87222cBody();
        translate([0,-10,0])placeMontingBracketOnRelay411cj() placeMountingPlateHolePattern411cj() cylinder(20, 1.5, 1.5);
        translate([-8,0,0])placeMixer() mixerHolePattern() cylinder(10, 0.5, 0.5);
    }
    
}

module bracketPe71S6119(){
    difference(){
        bracketBody() relayPe71S6119();
        translate([0,-10,0])placeMontingBracketOnRelay411cj() placeMountingPlateHolePattern411cj() cylinder(20, 1.5, 1.5);
        translate([-8,0,0])placeMixer() mixerHolePattern() cylinder(10, 0.5, 0.5);
    }
    
}

module placeMixer(){
    translate([20,-(22.6-6.3)/2,9.8])rotate([0,90,0])children();
}

module transferSwitch411cjAssembly(){
    placeMixer() mixer();
    relay411cj(); 
    bracket411cj();
}

module relay87222cControlConnectorBody(){
    difference(){
        cCube([20.6, 8.8, 5]);
        cCube([18.6, 6.8, 5]);
        translate([0,5.5,0])cCube([5,5,7]);
    }
    translate([0,5.5,0])cCube([2,2,7]);
}

module relay87222cBody(){
    translate([0,1.5,0]){
        cCube([32, 32, 55]);
        lsma=19.2-6.3;
        quad(lsma, lsma) rotate([180,0,0])smaFemale();
        translate([5,-11,55]) relay87222cControlConnectorBody();    
    }
}

module placeRelay87222cHoles(){
    lshole=18.5-2;
    rotate([0,0,45]) quad(lshole, lshole) children();
}

module relay87222c(){
    difference(){
        relay87222cBody();
        placeRelay87222cHoles() cylinder(10,1,1);
    }
}

module placeMountingPlateOnrelay87222c(){
    s=40.4/2;
    bs = 32.4/2;
    translate([0, bs, s])rotate([-90,0,0]) children();
}


//relayPe71S6119();
bracketPe71S6119();
//relay411cj();
//bracket87222c();
//relay87222c();
//placeMountingPlateOnrelay87222c() mountingPlate411cj();
//bracket411cj();
//transferSwitch411cjAssembly();
//bracket();