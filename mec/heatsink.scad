use <sp6t.scad>

module cCube(v){
    x = v[0]/2;
    y = v[1]/2;
    translate([-x, -y, 0]) cube(v);
}

module quad(x, y){
    translate([x, y, 0]) children();
    translate([x, -y, 0]) children();
    translate([-x, y, 0]) children();
    translate([-x, -y, 0]) children();
}


module x(l){
    translate([l,0,0]) children();
}

module y(l){
    translate([0,l,0]) children();
}

module z(l){
    translate([0,0,l]) children();
}

module dillate(r){
    minkowski(){
        children();
        sphere(r);
    }
}

module erode(r){
    difference(){
        children();
        dillate(r){
            difference(){
            dillate(2*r) children();
            children();
            }
        }
    }
}


module oblongHole(r, l, h=10){
    d = (l-2*r)/2;
    hull(){
        x(d) cylinder(h, r, r, $fn=10);
        x(-d) cylinder(h, r, r, $fn=10);
    }
}

module basePlateBody(){
    t=6.3;
    cCube([89, 56, t]);
    x(10.2/2+21.5/2)cCube([21.5, 77.8, t]);
    x(-10.2/2-21.5/2)cCube([21.5, 77.8, t]);
    cCube([67.4, 68.2, t]);
}


module shroudOpening(){
    //Size is 60*49, radius 1mm, depth = 3mm;
    l = 60;
    w = 49;
    r=1;
    z(1)difference(){
        union(){
                z(-1)cCube([l, w, 3]);
                z(-5)cCube([l+2, w+2, 5]);
        }
        y(-w/2-r)rotate([0, 90, 0])z(-(l+2*r)/2)cylinder(l+2*r, r, r, $fn=16);
        y(w/2+r)rotate([0, 90, 0])z(-(l+2*r)/2)cylinder(l+2*r, r, r, $fn=16);
        
        x(-l/2-r)rotate([90, 0, 0])z(-(w+2*r)/2)cylinder(w+2*r, r, r, $fn=16);
        x(l/2+r)rotate([90, 0, 0])z(-(w+2*r)/2)cylinder(w+2*r, r, r, $fn=16);
    }

}




module coolerVolume(){
    difference(){
        union(){
            z(-17){
                x(10.2/2+21.5/2)cCube([21.5, 77.8, 17]);
                x(-10.2/2-21.5/2)cCube([21.5, 77.8, 17]);
            }
            
            hull(){
                z(-40) cCube([0*67.4+76.4, 68.2, 40]);
                z(-57) cCube([76.4, 61, 57]);
            }
        }
        z(-57) shroudOpening();
        x(32.7)y(37)z(-57+39)cCube([11, 10, 10]);
        x(-32.7)y(37)z(-57+39)cCube([11, 10, 10]);
        y(37)z(-57+40)cCube([10, 10, 10]);
        
        x(32.7)y(-37)z(-57+39)cCube([11, 10, 10]);
        x(-32.7)y(-37)z(-57+39)cCube([11, 10, 10]);
        y(-37)z(-57+40)cCube([10, 10, 10]);
    }
}

module basePlateHoles(){
    x(+14.25-12.4)quad(30.5/2, 62/2) cCube([8.4, 3.9, 10]);
    x(54.2/2) cylinder(10, 1.2, 1.2);
    x(-54.2/2) cylinder(10, 1.2, 1.2);
    x(89/2-5.3/2-3.3)oblongHole(3.6/2, 5.3);
    
    y(-(56/2-3 - 7.8/2))x(89/2)oblongHole(7.8/2, 21.6*2, h=4.3);
    
    y(34.6/2)x(-(89/2-5.3/2-2))oblongHole(3.6/2, 5.3);
    y(-34.6/2)x(-(89/2-5.3/2-2))oblongHole(3.6/2, 5.3);
}

module basePlate(){
    difference(){
        basePlateBody();
        basePlateHoles();
    }
}

module heatSink(){
    difference(){
        z(6.3) rotate([180,0,0])basePlate();
            z(-3) allHoles();
    }
    coolerVolume();
}

module heatSink2(){
    difference(){
        z(6.3) rotate([180,0,0])basePlate();
   
    }
    coolerVolume();
}


module sd80_0798mConnector(){
    s=(17.6+14)/2;
    r = (17.6-14)/2;
    hull() quad((s-2*r)/2, (s-2*r)/2) cylinder(1.7, r, r);
    cylinder(7.8, 6.3/2, 6.3/2);
    z(1.7)quad(12/2, 12/2) cylinder(2.6, 5.5/2, 5.5/2);
}

module sd80_0798mHolePattern(r=1.5, l=4){
    quad(50.8/2, 32.7/2) cylinder(l,r,r);
}

module sd80_0798mFootprint(){
    z(3.3) cCube([61, 25.6,18.2]);
    translate([61/2,(25.6-17.6)/2,18.2/2+3.3]) rotate([0,90,0]) sd80_0798mConnector();
    translate([-61/2,(25.6-17.6)/2,18.2/2+3.3]) rotate([0,-90,0]) sd80_0798mConnector();
    translate([-61/2,-9, 8]) rotate([0,-90,0]) cylinder(9, 3.5, 3.5);
    translate([-61/2,-9, 16]) rotate([0,-90,0]) cylinder(9, 3.5, 3.5);
    difference(){
        cCube([61, 38, 3.3]);
        sd80_0798mHolePattern();
    }
}


module placeIfs4HolePattern(){
    quad(36.2/2, 10.5/2) children();
}


module ifs4HolePattern(r=1.25, l=4){
    placeIfs4HolePattern() cylinder(l,r,r);
}


module ifs4Connector(p=0){
    rotate([0, 0, 90]){
        hull(){
            x(12.5/2)rotate([0,0,180/8]) cylinder(1.6, 3,3, $fn=8);
            x(-12.5/2)rotate([0,0,180/8]) cylinder(1.6, 3,3, $fn=8);
        }
        z(1.6)cylinder(8, 6.3/2, 6.3/2);
        z(1.6)x(12.5/2)rotate([0,0,180/8]) cylinder(2.2, 2.1,2.1, $fn=8);
        z(1.6)x(-12.5/2)rotate([0,0,180/8]) cylinder(2.2+p, 2.1,2.1, $fn=8);
    }
    
}

module ifs4Footprint(){
    cCube([16.3, 17.9, 10.4]);
    cCube([16.3, 9.4, 14.3]);
    x((16.3-2.5)/2) cCube([2.5, 17.9, 13.5]);
    x(-(16.3-2.5)/2) cCube([2.5, 17.9, 13.5]);
    translate([16.3/2, 0,11.3]) rotate([0,90,0]) ifs4Connector();
    translate([-16.3/2, 0,11.3]) rotate([0,-90,0]) ifs4Connector(3.8);
    translate([-16.3/2+5, 0,11.3]) rotate([90,0,0]) cylinder(9, 0.5, 0.5);
    difference(){
        //cCube([44.3, 17.9, 2]);
        hull() quad(36.9/2, 10.5/2)rotate([0,0,180/8])cylinder(2, 4, 4, $fn=8);    
        ifs4HolePattern();
    }
}

module swlConnector(){
    rotate([0, 0, 90]){
        cCube([13, 10, 2]);
        cylinder(10, 6.3/2, 6.3/2);
        z(2) cylinder(1.6, 4.2/2, 4.2/2);
    }
}

module swlFootprint(){
    cCube([44.8, 30, 17]);
    translate([44.8/2,1,9]) rotate([0,90,0]) swlConnector();
    translate([-44.8/2,1,9]) rotate([0,-90,0]) swlConnector();
    translate([-44.8/2,-12,5]) rotate([0,-90,0]) cylinder(8, 5.4/2, 5.4/2);
    translate([-44.8/2,-13.5,11.5]) rotate([0,-90,0]) cylinder(8, 3.6/2, 3.6/2);
}

module dbpAmplifier(){
    cCube([74, 40, 17]);
    translate([74/2, -2 ,9 ]) rotate([0,90,0])ifs4Connector();
    translate([-74/2, -2 ,9 ]) rotate([0,-90,0])ifs4Connector();
    translate([74/2, 16 ,12 ]) rotate([0,90,0])cylinder(6, 2, 2);
    translate([74/2, 16 ,5 ]) rotate([0,90,0])cylinder(8, 3, 3);
}

module placeAmfAmplifierHolPattern(){
    quad(20.4/2, 18.6/2) children();
}

module amfAmplifier(){
    d=(4-2.4)/2;
    difference(){
        cCube([31, 22.3, 8.6]);
        placeAmfAmplifierHolPattern(){ 
            hull(){
                x(-d)cylinder(10, 1.2, 1.2, $fn=15);
                x(d)cylinder(10, 1.2, 1.2, $fn=15);
            }
        }
    }
    translate([31/2, 0 ,5 ]) rotate([0,90,0]) ifs4Connector();
    translate([-31/2, 0 ,5 ]) rotate([0,-90,0]) ifs4Connector();
    translate([-31/2+2.5, 22.3/2, 3]) rotate([-90,0,0]) cylinder(6,2, 2);
    translate([0, 22.3/2, 5]) rotate([-90,0,0]) cylinder(6,2, 2);
}

module connector6201(){
    
    r = 2;
    
    s=13-2*r;
    
    hull() quad(s/2, s/2) cylinder(1.7, r, r);
    cylinder(7.8, 6.3/2, 6.3/2);
    z(1.7)quad(8.5/2, 8.5/2) cylinder(2.6, 2, 2);
}

module amplifier6201(){
    cCube([34, 26.4, 18]);
    translate([-34/2, -26.4/2+12.4, 8.5]) rotate([0,-90,0]) connector6201();
    translate([34/2, -26.4/2+12.4, 8.5]) rotate([0,90,0]) connector6201();
    translate([-34/2, 26.4/2-4, 5]) rotate([0,-90,0]) cylinder(5, 1.8, 1.8);
    translate([-34/2, 26.4/2-5, 14]) rotate([0,-90,0]) cylinder(6.5, 2.25, 2.25);
}

module placeSwlBraceHolePattern(){
    x(-30) children();
    x(30) children();
}

module swlBrace(){
    difference(){
        cCube([70, 10, 2]);
        placeSwlBraceHolePattern() cylinder(10, 1.5, 1.5);
    }
}


module allHoles(l=10){
    x(-24)rotate([0,0,90])z(6.3) sd80_0798mHolePattern(l=l);
    x(36) y(-5)rotate([0,0,90])z(6.3) ifs4HolePattern(l=l);
    x(11)y(-1.5) rotate([0,0,90-22.5])z(6.3) placeSwlBraceHolePattern()cylinder(l, 1.5, 1.5);
}

module drillGuide(){
    difference(){
        z(3)cCube([89+6, 56+6, 10]);
        minkowski(){
            heatSink();
            sphere(0.35);
        }
        z(-30)allHoles(l=100);
    }
}

module placeFanScrewHoles(){
    quad(32/2, 32/2) children();
}
module fanHolePattern(r=1.5, l=10){
    cylinder(l, 38/2, 38/2);
    placeFanScrewHoles() cylinder(l,r,r);
}

module fan(){
    r = 4;
    s = (40-2*r)/2;
    difference(){
        hull() quad2(s,s) cylinder(20, r, r);
        fanHolePattern(r=4.5/2, l=20);
    }
}
module fanHolePattern(r=1.5, l=10){
    cylinder(l, 38/2, 38/2);
    placeFanScrewHoles() cylinder(l,r,r);
}

module fan(){
    r = 4;
    s = (40-2*r)/2;
    difference(){
        hull() quad(s,s) cylinder(20, r, r);
        fanHolePattern(r=4.5/2, l=20);
    }
}
module placeFan(){
    z(-57/2)x(38.2+3)rotate([0,90,0])children();
}

module fanShroudExhaustOpening(){
    x(-10){
        hull(){
            z(-40) cCube([0*67.4+76.4, 68.2-6, 30]);
            z(-57+3) cCube([76.4, 56-6, 47-3]);
        }
    }
}

module fanShroud(){
    intersection(){
        difference(){
            dillate(3) heatSink();
            z(-15.2)x(-3)cCube([76.5+6, 100, 50]);
            z(-3)cCube([89, 100, 500]);
            dillate(0.35) heatSink();
            x(-10)placeFan() fanHolePattern(l=30);
            fanShroudExhaustOpening();
            
            z(-57)shroudOpening();
        }
        z(-3)z(-100)cCube([89-2, 100, 500]);
        
    }
    
}

module fanShroudWithBananas(){
    difference(){
        fanShroud();
        placeBananaConnectors() rotate([0,0,-90]) z(4)minkowski(){
                bananaConnectorBodyRotSym();
                rotate([90,0,0])cylinder(100, 1, 1);
            }
        
    }
    difference(){
        placeBananaConnectors() rotate([0,0,-90])bananaHood();
       hull()fanShroud();
        hull() minkowski(){
            placeFan() fan();
            sphere(0.35);
        }
    }
    
    
}


module bananaConnectorBodyRotSym(){
    cylinder(3, 7, 7);
    
        cylinder(17, 14.5/2, 14.5/2);
     
    cylinder(21.5, 10.6/2, 10.6/2);
    cylinder(30, 3, 3);
}

module bananaConnectorBody(e=0){
    cylinder(3, 7, 7);
    intersection(){
        cylinder(17, 11.7/2+e, 11.7/2+e);
        cCube([10.6, 14, 17]);
    }
    cylinder(21.5, 10.6/2, 10.6/2);
    cCube([6,1,30]);
}

module bananaConnector(nutOffset=3){
    difference(){
        bananaConnectorBody();
        cylinder(18,2,2);
        difference(){
            cylinder(18,4.5,4.5);
            cylinder(18,3,3);
        }
    }
    if(nutOffset > 0){
        z(3+nutOffset){
            difference(){
                cylinder(5, 14.4/2, 14.4/2);
                cylinder(5, 11.4/2, 11.4/2);
                z(3.4)cCube([100, 3, 3]);
            }
        }
    }
}

module placeBananaConnectors(){
    //translate([50,30-2.7,-5.6-10]) rotate([180,0,0])children();
    //translate([50,-30+2.7,-5.6-10]) rotate([180,0,0])children();
    rotate([0,0,20])translate([58,10,-5.6-10-1.3]) rotate([180,0,0])children();
    rotate([0,0,-20])translate([58,-10,-5.6-10-1.3]) rotate([180,0,0])children();
} 

module bananaHood(){
    z(4){
        difference(){
            minkowski(){
                minkowski(){
                    bananaConnectorBodyRotSym();
                    cylinder(8,4,4);
                }
                rotate([90,0,0])cylinder(40, 1, 1);
            }
            z(-5){
            minkowski(){ 
                bananaConnectorBody(e=0.35);
                //cylinder(1, 0.35, 0.35);
            }}
            z(4) bananaConnectorBodyRotSym();
            z(4)minkowski(){
                bananaConnectorBodyRotSym();
                rotate([90,0,0])cylinder(100, 1, 1);
            }
        }
    }
}

module coverBody(){
    difference(){
        translate([-54.5+5+7-4, 0, 0-8+2-3]) cCube([30-8, 66, 22]);
        union(){
            translate([-54.5+5, 0, 0-8+2]) cCube([10, 60, 16]);
            translate([-54.5+5+7, 0, 0-8+2]) cCube([10, 60, 8]);
        }
        minkowski(){
            heatSink();
            sphere(0.35);
        }    
        minkowski(){
            x(-24)rotate([0,0,90])z(6.3) sd80_0798mFootprint();
            sphere(0.35);
        }   
        minkowski(){
            fanShroud();
            sphere(0.35);
        }   
        x(-24)rotate([0,0,90])z(6.3-10) sd80_0798mHolePattern(l=50, $fn=10);
        z(6.3) rotate([180,0,0])basePlateBody();
    translate([-54.5+5+7+7, 0, 0-8+2-8]) cCube([10, 80, 8]);    
    }
    
}

module placeAmplifierBraceHolePattern(l=10){
    translate([-l/2, 0, 0]) children();
    translate([l/2, 0, 0]) children();
}

module amplifierBrace(l = 10){
    difference(){
        cCube([l+12, 12, 2]);
        placeAmplifierBraceHolePattern(l=l) cylinder(10, 1.5, 1.5, $fn=10);
    }
    
}

module drillGuide2(){
    difference(){
        z(3)cCube([89+6, 56+24, 10]);
        minkowski(){
            heatSink2();
            sphere(0.35);
        }
        z(-30)allHoles2(l=100);
    }
    
}

module assembly1(){
    heatSink();    
    x(-24)rotate([0,0,-90])z(6.3) sd80_0798mFootprint();
    x(36) y(-5)rotate([0,0,-90])z(6.3) ifs4Footprint();
    x(11) y(-1.5) rotate([0,0,-90])z(6.3) swlFootprint();
    z(17 )x(11)rotate([0,0,90-22.5])z(6.3) swlBrace();
    placeFan() fan();
    fanShroudWithBananas();
    placeBananaConnectors() bananaConnector();
    //coverBody();
}

module placeAmfAmplifier(){
    translate([7, -26, 6]) rotate([0, 0, -90]) mirror([1,0,0])children();
}

module assembly2(){
    heatSink2();
    translate([-24.5, 0, 6]) rotate([0, 0, -90]) dbpAmplifier();
    placeAmfAmplifier() amfAmplifier();
    translate([31.5, -3, 6]) rotate([0, 0, 90]){
        amplifier6201();
        //translate([0,0,18]) rotate([0,0,22])amplifierBrace(l=42);
    }
    fanShroudWithBananas();
    placeBananaConnectors() bananaConnector();
    placeFan() fan();
}

module allHoles2(l){

placeAmfAmplifier() placeAmfAmplifierHolPattern() cylinder(l,1,1);
translate([16,10,6])cylinder(l,1.25, 1.25);
translate([-2.5,10,6])cylinder(l,1.25, 1.25);
    
}


module bracket(){
    d=[10, 81, 183*0+120];
    dh=d-[-2, 2*3, 2*2*0];
    difference(){
        x(-39.2) translate(-d/2) cube(d);
        x(-39.2) translate(-dh/2) cube(dh);
    }
};


module fanBracket(){
    d=[10, 89.35, 183*0+120];
    dh=d-[-2, 2*3, 2*2*0];
    difference(){
        x(55.2) translate(-d/2) cube(d);
        x(55.2) translate(-dh/2) cube(dh);
    }
};

//bracket();


//allHoles2(100);
//amplifierBrace(l=30);

//coverBody();

//bananaHood();
//placeBananaConnectors() bananaConnector();
//heatSink2();
//fanShroudWithBananas();


module placeAssembly1(){
    z(-28-1)children();
}

module placeAssembly2(){
    
    rotate([180,0,0])z(-28-1)children();
}

module placeSp6tFan(){
     y(20-13-15)rotate([90,0,0]) x(70*0+80+3) children();
}

module placeSp6tExhaust(){
     y(-20+17 )rotate([-90,0,0]) x(-67-13) children();
}

module layoutTest1(){
    z(60)assembly1();
    rotate([180,0,0])z(60)assembly2();
    y(20 )rotate([90,0,0]) x(85) sp6t();
    y(-20 )rotate([-90,0,0]) x(-65) sp6t();
}

module layoutTest2(){
    rotate([0,0,180])x(45+7) assembly2();
    x(45+7) assembly1();
    z(51)y(20 )rotate([90,0,0]) x(55) sp6t();
    z(51)y(-20 )rotate([-90,0,0]) x(-55) sp6t();
}
module layoutTest3(){
    /*z(-28)assembly1();
    rotate([180,0,0])z(-28)assembly2();*/
    placeAssembly1() assembly1();
    placeAssembly2() assembly2();
    //y(20-13 )rotate([90,0,0]) x(70*0+80+3) sp6t();
    //y(-20+17 )rotate([-90,0,0]) x(-67-13) sp6t();
    placeSp6tFan() sp6t();
    placeSp6tExhaust() sp6t();
}



module exhaustBoundingBox(){
       translate([-38,0,-70])cCube([15,90,60]);
}
module exhaustInterfacePart(){
    intersection(){
        assembly2();
        exhaustBoundingBox();
    }
}

module fanInterfaceBoundingBox(){
       translate([58,0,-70])cCube([19,90,53]);
}

module fanInterfacePart(){
    intersection(){
        assembly2();
        fanInterfaceBoundingBox();
    }
}


module exhaustSideInterface(){
    difference(){
        intersection(){
            dillate(3) exhaustInterfacePart();
                
            exhaustBoundingBox();
        }
        fanShroudExhaustOpening();
        
        hull(){
            dillate(0.3){
                intersection(){
                    fanShroud();
                    exhaustBoundingBox();
                }
            }
        }
        placeBracketScrewExhaustRight()z(-5)cylinder(15, 1.5,1.5);
        placeBracketScrewExhaustLeft()z(-5) cylinder(15, 1.5,1.5);

    }

    placeBracketScrewExhaustRight() difference() { cylinder(5, 5, 5); cylinder(10, 1.5,1.5);}
    placeBracketScrewExhaustLeft()difference() { cylinder(5, 5, 5); cylinder(10, 1.5,1.5);}
}


module fanSideInterface(){
    difference(){
        intersection(){
            dillate(3)fanInterfacePart();
            fanInterfaceBoundingBox();
        }
        minkowski(){
            fanInterfacePart();
            rotate([0,-90,0])cylinder(100, 0.3, 0.3);
        }
        placeFan() hull(){ 
            minkowski(){
            fan();
                rotate([0,0,0])cylinder(100, 0.3, 0.3);
            }
        }
        placeBracketScrewFanRight()z(-5)cylinder(15, 1.5,1.5);
        placeBracketScrewFanLeft()z(-5) cylinder(15, 1.5,1.5);
    }
    placeBracketScrewFanRight() difference() { cylinder(5, 5, 5); cylinder(10, 1.5,1.5);}
    placeBracketScrewFanLeft() difference() { cylinder(5, 5, 5); cylinder(10, 1.5,1.5);}
}

module exhaustBracketsBody(){
    placeAssembly1()exhaustSideInterface();
    placeAssembly2() exhaustSideInterface();
    bracket();
}

module exhaustBrackets(){
    difference(){
        exhaustBracketsBody();
        placeAssembly1() placeBracketScrewExhaustRight() z(-20) cylinder(60, 1.5, 1.5);
        placeAssembly1() placeBracketScrewExhaustLeft() z(-20) cylinder(60, 1.5, 1.5);
        placeAssembly2() placeBracketScrewExhaustRight() z(-20) cylinder(60, 1.5, 1.5);
        placeAssembly2() placeBracketScrewExhaustLeft() z(-20) cylinder(60, 1.5, 1.5);
    }
}

module fanBracketsBody(){
    placeAssembly1() fanSideInterface();
    placeAssembly2() fanSideInterface();
    fanBracket();
}

module fanBrackets(){
    difference(){
        fanBracketsBody();
        placeAssembly1() placeBracketScrewFanRight() z(-20) cylinder(60, 1.5, 1.5);
        placeAssembly1() placeBracketScrewFanLeft() z(-20) cylinder(60, 1.5, 1.5);
        placeAssembly2() placeBracketScrewFanRight() z(-20) cylinder(60, 1.5, 1.5);
        placeAssembly2() placeBracketScrewFanLeft() z(-20) cylinder(60, 1.5, 1.5);
    }
}

module placeBracketScrewFanRight(j=[0:3]){
    for(i = j)
    translate([55, 52-10, -30+15*i])rotate([-90,0,0])children();
}
module placeBracketScrewFanLeft(j=[0:3]){
    for(i = j)
    translate([55, -52+10, -30+15*i])rotate([90,0,0])children();
}

module placeBracketScrewExhaustRight(j=[0:3]){
    for(i = j)
    translate([-38, 50-2-10, -30+15*i])rotate([-90,0,0])children();
}
module placeBracketScrewExhaustLeft(j=[0:3]){
    for(i = j)
    translate([-38, -48+10, -30+15*i])rotate([90,0,0])children();
}




module placeBracketScrewsRight(j=[0:3]){
    placeBracketScrewExhaustRight(j) children();
    placeBracketScrewFanRight(j) children();
    
}


module placeBracketScrewsLeft(j=[0:3]){
    placeBracketScrewExhaustLeft(j) children();
    placeBracketScrewFanLeft(j) children();
}

module leftBracket(){
    placeAssembly1() placeBracketScrewsLeft() cylinder(10,1.5, 1.5);
}

module assembly1RightBracket(){
    difference(){
        hull(){
            placeAssembly1() placeBracketScrewsRight(j=[0]) cylinder(8,8, 8);
        }
        placeAssembly1() placeBracketScrewsRight(j=[0]) cylinder(10,1.6, 1.6, $fn=10);
        minkowski(){
            union(){
                exhaustBrackets();
                fanBrackets();
            }
            sphere(0.35);
        }
    }
}

module assembly1LeftBracket(){
    difference(){
        hull(){
            placeAssembly1() placeBracketScrewsLeft(j=[0]) cylinder(8,8, 8);
        }
        placeAssembly1() placeBracketScrewsLeft(j=[0]) cylinder(10,1.6, 1.6, $fn=10);
        minkowski(){
            union(){
                exhaustBrackets();
                fanBrackets();
            }
            sphere(0.35);
        }
    }
}

module assembly2RightBracket(){
    difference(){
        hull(){
            placeAssembly2() placeBracketScrewsRight(j=[0]) cylinder(8,8, 8);
        }
        placeAssembly2() placeBracketScrewsRight(j=[0]) cylinder(10,1.6, 1.6, $fn=10);
        minkowski(){
            union(){
                exhaustBrackets();
                fanBrackets();
            }
            sphere(0.35);
        }
    }
}

module assembly2LeftBracket(){
    difference(){
        hull(){
            placeAssembly2() placeBracketScrewsLeft(j=[0]) cylinder(8,8, 8);
        }
        placeAssembly2() placeBracketScrewsLeft(j=[0]) cylinder(10,1.6, 1.6, $fn=10);
        minkowski(){
            union(){
                exhaustBrackets();
                fanBrackets();
            }
            sphere(0.35);
        }
    }
}


module sp6tHolderBodyInnerSide(offs=0, length=42){
    difference(){
        hull(){ 
            difference(){
                z(offs-37) placeSp6tHolePattern() cylinder(length, 5, 5);
                translate([-25,0,0])cCube([50, 50, 50]);
            }
        }
        minkowski(){
            sp6t();
            sphere(0.4);
        }
        z(offs-37) placeSp6tHolePattern()cylinder(length, 1.5, 1.5);
    }
}


module sp6tHolderBody(offs=0, length=42){
    difference(){
        hull() z(offs-37) placeSp6tHolePattern()cylinder(length, 5, 5);
        minkowski(){
            sp6t();
            sphere(0.4);
        }
        z(offs-37) placeSp6tHolePattern()cylinder(length, 1.5, 1.5);
    }
}




module sp6tExhaustSmaSideBracketBody(){
    placeSp6tExhaust() sp6tHolderBody(length=5, offs=38);
    hull() {
        placeSp6tExhaust() sp6tHolderBodyInnerSide(length=5, offs=38);
        placeAssembly1() placeBracketScrewExhaustRight([2, 3]) cylinder(5+3, 5+3, 5+3);
        placeAssembly2() placeBracketScrewExhaustLeft([2, 3]) cylinder(5+3, 5+3, 5+3);
    }
}
module sp6tExhaustSmaSideBracket(){
    difference(){
        sp6tExhaustSmaSideBracketBody();
        placeSp6tExhaust(){
            minkowski(){
                sp6t();
                sphere(0.4);
            }
            //z(offs-37) placeSp6tHolePattern()cylinder(100, 1.5, 1.5);
            z(-37) placeSp6tHolePattern()cylinder(100, 1.5, 1.5);
        }
        hull() bracket();
        placeAssembly1() placeBracketScrewExhaustRight([2, 3]) z(-1) cylinder(6.35, 5.35, 5.35);
        placeAssembly2() placeBracketScrewExhaustLeft([2, 3]) z(-1) cylinder(6.35, 5.35, 5.35);
        placeAssembly1() placeBracketScrewExhaustRight([2, 3]) cylinder(15, 1.6, 1.6, $fn=10);
        placeAssembly2() placeBracketScrewExhaustLeft([2, 3]) cylinder(15, 1.6, 1.6, $fn=10);
        translate([-29.3, 42, -20])cCube([10, 10, 40]);
    }
}

module sp6tExhaustBottomSideBracketBody(){
    placeSp6tExhaust() sp6tHolderBody(length=5, offs=0);
    hull() {
        placeSp6tExhaust() sp6tHolderBodyInnerSide(length=5, offs=0);
        translate([-3,0,0]){
            placeAssembly1() placeBracketScrewExhaustLeft([2, 3]) z(2) cylinder(3, 5, 5);
            placeAssembly2() placeBracketScrewExhaustRight([2, 3]) z(2) cylinder(3, 5, 5);
        }
    }
    placeAssembly1() placeBracketScrewExhaustLeft([2, 3]) z(2) cylinder(3, 5, 5);
    placeAssembly2() placeBracketScrewExhaustRight([2, 3]) z(2) cylinder(3, 5, 5);
    placeAssembly1() placeBracketScrewExhaustLeft([2, 3]) cylinder(5+3, 5+3, 5+3);
    placeAssembly2() placeBracketScrewExhaustRight([2, 3]) cylinder(5+3, 5+3, 5+3);
}

module sp6tExhaustBottomSideBracket(){
    difference(){
        sp6tExhaustBottomSideBracketBody();
        placeSp6tExhaust(){
            minkowski(){
                z(-20) sp6t();
                //z(10)sp6t();
                sphere(0.4);
            }
            //z(offs-37) placeSp6tHolePattern()cylinder(100, 1.5, 1.5);
            z(-37) placeSp6tHolePattern()cylinder(100, 1.5, 1.5);
        }
        hull() bracket();
        placeAssembly1() placeBracketScrewExhaustLeft([2, 3]) cylinder(5, 5, 5);
        placeAssembly2() placeBracketScrewExhaustRight([2, 3]) cylinder(5, 5, 5);
        placeAssembly1() placeBracketScrewExhaustLeft([2, 3]) cylinder(15, 1.6, 1.6, $fn=10);
        placeAssembly2() placeBracketScrewExhaustRight([2, 3]) cylinder(15, 1.6, 1.6, $fn=10);
        placeSp6tExhaust() z(-100) placeSp6tHolePattern()cylinder(100, 1.5, 1.5);
        placeSp6tExhaust() z(-137) placeSp6tHolePattern()cylinder(100, 4, 4);
        translate([-40,-30+13-3, 15])cCube([20,20,20]);
        translate([-40,-30+13-3, -15-20])cCube([20,20,20]);
    }
    
}

module sp6tBodyExhaust(){
    difference(){
    placeSp6tExhaust() sp6tHolderBody();
        minkowski(){
            union(){
                sp6tExhaustSmaSideBracket();
                sp6tExhaustBottomSideBracket();
            }
            sphere(0.35);
        }
    }
}


module sp6tFanSmaSideBracketBody(){
    placeSp6tFan() sp6tHolderBody(length=37, offs=5);//sp6tHolderBody(length=5, offs=38);
    hull() {
        placeSp6tFan() rotate([0,0,180])sp6tHolderBodyInnerSide(length=5, offs=38);
        placeAssembly2() placeBracketScrewFanRight([2, 3]) cylinder(5+3, 5+3, 5+3);
        placeAssembly1() placeBracketScrewFanLeft([2, 3]) cylinder(5+3, 5+3, 5+3);
    }
}
module sp6tFanSmaSideBracket(){
    difference(){
        sp6tFanSmaSideBracketBody();
        placeSp6tFan() minkowski() {sp6t(); sphere(0.35);};
        placeSp6tFan() placeSp6tHolePattern() z(-50) cylinder(100, 1.5, 1.5);
        placeAssembly2() placeBracketScrewFanRight([2, 3]) z(-5) cylinder(15, 1.6, 1.6);
        placeAssembly1() placeBracketScrewFanLeft([2, 3]) z(-5) cylinder(15, 1.6, 1.6);
        minkowski(){
            union(){
                fanBracket();
                placeAssembly2() placeBracketScrewFanRight([2, 3]) cylinder(5, 5, 5);
                placeAssembly1() placeBracketScrewFanLeft([2, 3]) cylinder(5, 5, 5);
            }
            sphere(0.35);
        }
    }
}


module sp6tFanBottomSideBracketBody(){
    placeSp6tFan() sp6tHolderBody(length=5,  offs=0);//sp6tHolderBody(length=5, offs=38);
    hull() {
        placeSp6tFan() rotate([0,0,180])sp6tHolderBodyInnerSide(length=5, offs=0);
        placeAssembly2() placeBracketScrewFanLeft([2, 3]) cylinder(5+3, 5+3, 5+3);
        placeAssembly1() placeBracketScrewFanRight([2, 3]) cylinder(5+3, 5+3, 5+3);
    }
}
module sp6tFanBottomSideBracket(){
    difference(){
        sp6tFanBottomSideBracketBody();
        placeSp6tFan() minkowski() {sp6t(); sphere(0.35);};
        placeSp6tFan() placeSp6tHolePattern() z(-150) cylinder(200, 1.6, 1.6, $fn=20);
        placeAssembly2() placeBracketScrewFanLeft([2, 3]) z(-5) cylinder(15, 1.6, 1.6, $fn=20);
        placeAssembly1() placeBracketScrewFanRight([2, 3]) z(-5) cylinder(15, 1.6, 1.6, $fn=20);
        minkowski(){
            union(){
                hull() fanBracket();
                translate([-5, -3, 0]) hull() fanBracket();
                placeAssembly2() placeBracketScrewFanLeft([2, 3]) cylinder(5, 5, 5);
                placeAssembly1() placeBracketScrewFanRight([2, 3]) cylinder(5, 5, 5);
            }
            sphere(0.35);
        }
        placeSp6tFan() placeSp6tHolePattern() z(-37-50) cylinder(50, 4, 4);
    }
    
}





module screwTower(t, ri, rs, l){
    difference(){
        cylinder(l, ri+t, ri+t);
        z(t) cylinder(l, ri, ri);
        cylinder(l+t,rs, rs);
    }
    
}

module screwToweriHole(t, ri, rs, l){
    difference(){
        //cylinder(l, ri+t, ri+t);
        z(t) cylinder(l, ri, ri);
        //cylinder(l+t,rs, rs);
    }
    
}



/*placeSp6tExhaust() sp6t();
placeSp6tFan() sp6t();
sp6tFanBottomSideBracket();
sp6tExhaustSmaSideBracket();*/
lof=20+9-10;
lofa=20+9;
module sideLidABody(){
    t = 2;
    difference(){
        translate([-20,70-lofa/2,-37]) cCube([170, 50-lofa, 74]);
        translate([-20,70-t-lofa/2,-37+t]) cCube([170-2*t, 50-lofa, 74-2*t]);
        placeAScrews() screwToweriHole(3, 5, 1.6, 50-lofa);
    }
    intersection(){
        placeAScrews() screwTower(3, 5, 1.6, 50-lofa);
        translate([-20,60-lofa/2,-37]) cCube([170, 70-lofa, 74]);
    }
    placeSideLidABulkhead() cylinder(5, 8, 8);
}

module sideLidA(){
    difference(){
        sideLidABody();
        
        minkowski() {
            sphere(0.35);
            sp6tFanBottomSideBracket();
            //sp6tExhaustSmaSideBracket();
        }
        minkowski() {
            sphere(0.35);
            //sp6tFanBottomSideBracket();
            sp6tExhaustSmaSideBracket();
        }
        placeSideLidABulkhead() smaBulkHead();
    }
}




module placeAScrew(){
    z(8)children();
}
module placeAScrews(){
    placeAssembly2() placeBracketScrewFanLeft([2]) placeAScrew()children();
    placeAssembly1() placeBracketScrewFanRight([2]) placeAScrew()children();
    placeAssembly2() placeBracketScrewExhaustLeft([2]) placeAScrew()children();
    placeAssembly1() placeBracketScrewExhaustRight([2]) placeAScrew()children();
}


module placeBScrews(){
    placeAssembly2() placeBracketScrewFanRight([2]) placeAScrew()children();
    placeAssembly1() placeBracketScrewFanLeft([2]) placeAScrew()children();
    placeAssembly2() placeBracketScrewExhaustRight([2]) placeAScrew()children();
    placeAssembly1() placeBracketScrewExhaustLeft([2]) placeAScrew()children();
}


module sideLidB(){
    difference(){
        sideLidBBody();
        
        minkowski() {
            sphere(0.35);
            sp6tFanSmaSideBracket();
        }
        minkowski() {
            sphere(0.35);
            sp6tExhaustBottomSideBracket();
        }
        placeSideLidBBulkhead() smaBulkHead();
    }
}


module smaBulkHead(){
    tol=0.35;
    nr=4.0/cos(30)+tol;
    cylinder(15,3.1+tol,3.1+tol);
    rotate([0,0,30])cylinder(4,nr,nr, $fn=6);
}   


/*placeSp6tExhaust() sp6t();
placeSp6tFan() sp6t();
sp6tFanSmaSideBracket();
sp6tExhaustBottomSideBracket();
sideLidB();*/

module sideLidBBody(){
    t = 2;
    position = [20,-75+lof/2,-37];
    size= [170, 50-lof, 74];
    difference(){
        translate(position) cCube(size);
        translate(position+[0,t,t]) cCube(size+[-2*t, 0, -2*t]);
        placeBScrews() screwToweriHole(3, 6.5, 1.6, 70);
        placeBananaConnectorsOnLidB() bananaConnectorBody(e=0.35);
        placeSp6tFan() translate([20,0,40])cCube([50, 50, 10-2]);
    }
    intersection(){
        placeBScrews() screwTower(3, 6.5, 1.6, 70);
        translate(position+[-10,10,0]) cCube(size+[0, 20, 0]);
    }
    placeSideLidBBulkhead() cylinder(5, 8, 8);
}

module placeBananaConnectorsOnLidB(){
    y(lof/2){ children();
    }
}


module placeBananaConnectorsOnLidB(){
    y(lof/2){
        translate([-68,-75,19.05/2]) rotate([0,90,0]) rotate([0, 0, 90]) children();
        translate([-68,-75,-19.05/2]) rotate([0,90,0]) rotate([0, 0, 90]) children();
    }
}

module assembly(){
    exhaustBrackets();
    fanBrackets();
    layoutTest3();
    assembly1RightBracket();
    assembly1LeftBracket();
    assembly2RightBracket();
    assembly2LeftBracket();
    sp6tBodyExhaust();
    sp6tExhaustSmaSideBracket();
    sp6tExhaustBottomSideBracket();
    sp6tFanBottomSideBracket();
    sp6tFanSmaSideBracket();
    sideLidA();
    sideLidB();
    placeBananaConnectorsOnLidB() bananaConnectorBody();
    placeSideLidBBulkhead() smaBulkHead();
    placeSideLidABulkhead() smaBulkHead();
}

module placeSideLidBBulkhead(){
    y(lof) placeSp6tFan() z(92-4-2) children();
}

module placeSideLidABulkhead(){
    y(-lofa) placeSp6tExhaust() z(98-2-4) children();
}


//placeBananaConnectorsOnLidB() bananaConnectorBody();
//sideLidA();
//sideLidB();
//placeSp6tExhaust() sp6t();
//placeSp6tFan() sp6t();


assembly();
//sideLidB();

//placeBananaConnectorsOnLidB() bananaConnectorBody();
//placeBananaConnectorsOnLidB() bananaConnectorBody();
//assembly1RightBracket();
//assembly2LeftBracket();


//fanBracket();
//placeSp6tFan() sp6tHolderBody();
//placeSp6tFan() sp6t();
//sp6t();
//sp6tHolderBodyInnerSide();
//placeSp6tExhaust()  sp6tHolderBodyInnerSide();
//placeSp6tExhaust() sp6t();


//fanBrackets();
//fanSideInterface();
//exhaustSideInterface();
//assembly2();
//fanShroud();


//layoutTest2();
//layoutTest1();
//drillGuide();
//drillGuide2();