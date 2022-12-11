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

module fanShroud(){
    intersection(){
        difference(){
            dillate(3) heatSink();
            z(-15.2)x(-3)cCube([76.5+6, 100, 50]);
            z(-3)cCube([89, 100, 500]);
            dillate(0.35) heatSink();
            x(-10)placeFan() fanHolePattern(l=30);
            x(-10){
                hull(){
                    z(-40) cCube([0*67.4+76.4, 68.2-6, 30]);
                    z(-57+3) cCube([76.4, 56-6, 47-3]);
                }
            }
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


module assembly1(){
    heatSink();    
    x(-24)rotate([0,0,90])z(6.3) sd80_0798mFootprint();
    x(36) y(-5)rotate([0,0,90])z(6.3) ifs4Footprint();
    x(11) y(-1.5) rotate([0,0,90])z(6.3) swlFootprint();
    z(17 )x(11)rotate([0,0,90-22.5])z(6.3) swlBrace();
    placeFan() fan();
    fanShroudWithBananas();
    placeBananaConnectors() bananaConnector();
    coverBody();
}

module assembly2(){
    heatSink2();
    translate([-24, 0, 6]) rotate([0, 0, 90]) dbpAmplifier();
    translate([8, -20, 6]) rotate([0, 0, -90]) amfAmplifier();
    translate([31, 16, 6]) rotate([0, 0, -90]){
        amplifier6201();
        translate([0,0,18]) rotate([0,0,22])amplifierBrace(l=42);
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

//amplifierBrace(l=30);

//coverBody();

//bananaHood();
//placeBananaConnectors() bananaConnector();
//heatSink();
fanShroudWithBananas();
//assembly2();


//drillGuide();