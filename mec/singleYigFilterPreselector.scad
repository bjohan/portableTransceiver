use <preselectorAssembly.scad>
use <ventilatedLid.scad>
use <preselectorAssemblyYig.scad>

module x(d){
    translate([d,0,0]) children();
}

module z(d){
    translate([0,0,d]) children();
}

module cCube(v){
    x=v[0]/2;
    y=v[1]/2;
    translate(-[x,y,0])cube(v);
}

module smaConnector(){
    intersection(){
        cCube([13,13,2]);
        cylinder(2, 8, 8);
    }
    cylinder(10,3.1,3.1);
    for(i=[0:3]){
            rotate([0,0,45+i*90]) translate([11.3/2,0,0]) cylinder(4,2,2);
    }
}

module yigFilterMainBody(){
    translate([0,0,-17/2]){
        intersection(){
            cylinder(17,30,30);
            cCube([50,50,17]);
        }

        translate([0,0,17]) cylinder(17,22,22);
        translate([0,0,-17]) cylinder(17,22,22);
        for(i=[0:3]){
            rotate([0,0,45+i*90])translate([27,0,-3])cylinder(23,2.8,2.8);
        }
    }
    translate([-15,22-6,-15])cube([30, 13+6,30]);
    
}

module yigFilterBody(){
    translate([25,0,0])rotate([0,90,0])smaConnector();
    translate([-25,0,0])rotate([0,-90,0])smaConnector();
    yigFilterMainBody();
}

module yigFilter(){
    difference(){
        yigFilterBody();
        
yigFilterHolePattern() cylinder(5,1.5, 1.5);
    }
}

module yigFilterHolePattern(){
    translate([12.5, -25,0])rotate([-90,0,0]) children();
    translate([-12.5, -25,0])rotate([-90,0,0]) children();
}

module yigFilterMountVolume(){
    minkowski(){
        yigFilter();
        rotate([-90,0,0]) cylinder(100, 0.25, 0.25);
    }

}

module holderMountHolePattern(){
    translate([21,40,30]) rotate([90,0,0]) children();
    translate([21,40,-30]) rotate([90,0,0]) children();
    translate([-21,40,30]) rotate([90,0,0]) children();
    translate([-21,40,-30]) rotate([90,0,0]) children();
}

module yigFilterHolder(){
    difference(){
        translate([0,5,-35])cCube([50, 65,70]);
        translate([0,-10,0])yigFilterHolePattern() cylinder(15,1.5, 1.5);
        yigFilterMountVolume();
        holderMountHolePattern()cylinder(20, 1.5,1.5);
    }
}

module drillPattern(){
    difference(){
        hull() holderMountHolePattern() cylinder(2,4,4);
        holderMountHolePattern() cylinder(2,1.5,1.5, $fn=20);
    }
}

module placeYigFilter(){
    translate([104,0,4])rotate([0,0,90]) children();
}


module yigMountPlateBody(){
    eh=12;
    hull() translate([-3.5-2,0,0]) placeYigFilter() holderMountHolePattern() z(-eh)cylinder(8+eh, 4, 4);
    hull() translate([-3.5-2,0,0]) placeYigFilter() translate([-5-3,40,9.5]) rotate([90,0,0]) quad(21, 7) cylinder(8, 4, 4);
}

module yigMountPlate(){
    difference(){
        yigMountPlateBody();
        translate([-3.0,0,0]) placeYigFilter() holderMountHolePattern() m3Screw(eh=30);
        minkowski(){
            enclosure();
            
            sphere(0.35);
        }
        placeBananas() banana();
            placeDSub() dSub();
        placeBottomBracketScrews() m3Screw(l=30);
        placeTopBracketScrews() m3Screw(l=30);
        hull() translate([-3.5-2,0,0]) placeYigFilter() translate([-5-3,40,9.5]) rotate([90,0,0]) quad(21-3, 7-3) cylinder(5, 4, 4);
        hull() translate([-3.5-2,0,0]) placeYigFilter() translate([0,40,9.5]) rotate([90,0,0]) quad(3, 3) cylinder(10, 4, 4);
        translate([60,0,-27])cCube([20, 35, 40]);
    }
    
}

module placePcbThroughScrews(){
    placePcbScrews() translate([0,0,37]) rotate([180,0,0]) children();
}

module placeBottomBracketScrews(){
    
    translate([62.5,-28,30]) rotate([-90,0,0]) children();
    translate([62.5,28,30]) rotate([90,0,0]) children();
}

module placeTopBracketScrews(){
    translate([62.5,-28,-6])rotate([-90,0,0])children();
    translate([62.5,28,-6])rotate([90,0,0])children();
}

module topBracketBody(){
    hull(){
        translate([0, 0, -3])fanSpacer();
        placeTopBracketScrews()m3ScrewFastenVolume();
    }
}

module fanBody(){
    hull() quad(32/2, 32/2) cylinder(21,5,5);
}

module fan(){
    difference(){
        fanBody();
        fanHolePattern(l=40);
    }
}

module placeFan(){
    translate([0,0,-21-3]) children();
}

module topBracket(){
    difference(){
        topBracketBody();
        placeTopBracketScrews()m3Screw(eh=10);
        translate([0,0,-8])fanHolePattern();
                minkowski(){
            union(){
                enclosure();
                yigMountPlateBody();
                placeFan() fanBody();
                hull() placeYigFilter() yigFilterHolder();
            }
            sphere(0.3);
        }
        
    hull() translate([40,0,-20])quad(10, 20) cylinder(30, 2, 2);    
        
    }
    
    
}
module placeAllBottomBracketScrews(){
    placePcbThroughScrews() children();
    placeBottomBracketScrews() children();
}

module bottomBracketBody(){
    hull() placeAllBottomBracketScrews() m3ScrewFastenVolume();
}

module bottomBracket(){
    difference(){
        bottomBracketBody();
        placeAllBottomBracketScrews() m3Screw(eh=10);
        minkowski(){
            union(){
                enclosure();
                yigMountPlateBody();
                hull() placeYigFilter() yigFilterHolder();
            }
            
            sphere(0.3);
        }
        hull() translate([0,0,30]) quad(40, 30) cylinder(30, 3, 3); z(d){
    translate([0,0,d]) children();
}
    }
    
}

module assembly(){
    placeYigFilter(){
        yigFilterHolder();
        yigFilter();
    }

    placePcbThroughScrews() m3Screw();
    placeBottomBracketScrews() m3Screw();
    
    placeYigFilter() holderMountHolePattern() cylinder(3, 1.5, 1.5);
    translate([-3.5,0,0]) placeYigFilter() holderMountHolePattern() cylinder(3, 3, 3);

    //lidVentilatedHex();    
    enclosure();
    
    yigMountPlate();
    placeFan() fan();
    
    bottomBracket();
    topBracket();
    
    //placeBananas() banana();
    //placeDSub() dSub();
}


module m3ScrewFastenVolume(){
    translate([0,0,-2]) cylinder(5, 6,6);
}

module m3Screw(l=10, eh=0){
    translate([0,0,-2]){
        translate([0,0,-eh])cylinder(2+eh, 3,3);
        cylinder(3+l,1.5,1.5);
    }

}

module banana(){
    cylinder(4,6,6);
    z(-22)cylinder(22, 4,4);
    x(4)z(-1) cylinder(1,1,1, $fn=20);
}


module placeDsubHolePattern(){
    x(-12.5) children();
    x(12.5) children();
}

module dSubBody(){
    r=1.8;
    l1=19/2-r;
    l2=17/2-r;
    w=10.4/2-r;
    h=12;
    c=0.25;
    hull(){
        translate([l1,w, 0]) cylinder(h,r+c,r+c, $fn=20);
        translate([-l1,w, 0]) cylinder(h,r+c,r+c, $fn=20);
        translate([l2,-w, 0]) cylinder(h,r+c,r+c, $fn=20);
        translate([-l2,-w, 0]) cylinder(h,r+c,r+c, $fn=20);
    }
    z(5) cCube([31, 13.6, 1]);
}

module dSub(){
    difference(){
        dSubBody();
        placeDsubHolePattern() cylinder(10, 1.5, 1.5);
    }
}

module placeBananas(){
    translate([60, 10, -30])rotate([180,0,0]) children();
    translate([60, -10, -30])rotate([180,0,0]) children();
}

module placeDSub(){
    translate([51.5,0,-21]) rotate([0,-90,0])rotate([0,0,90])children();
}


//translate([60, 10, -30])rotate([180,0,0]) banana();
//translate([60, -10, -30])rotate([180,0,0]) banana();
//translate([51.5,0,-21]) rotate([0,-90,0])rotate([0,0,90])dSub();
assembly();
//bottomBracket();
//topBracket();
//yigMountPlate();

