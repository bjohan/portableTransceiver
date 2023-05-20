//use <sp6t.scad>
use <filters.scad>
nfilt=8;

module cCube(v){
    x=v[0]/2;
    y=v[1]/2;
    translate([-x, -y, 0]) cube(v);
}

module centerCube(v){
    translate([-v[0]/2,-v[1]/2,0]) c
module x(d){
    translate([d,0,0]) children();
}

module y(d){
    translate([0,d,0]) children();
}

module z(d){
    translate([0,0,d]) children();
}

module quad(x, y){
    x2=x/2;
    y2=y/2;
    translate([x2, y2, 0]) children();
    translate([x2, -y2, 0]) children();
    translate([-x2, y2, 0]) children();
    translate([-x2, -y2, 0]) children();
}

module nObj(r, n, offs){
    for(a=[1:n]) rotate([0,0, offs+a*360/n]) translate([r,0,0]) children();
}

module quadobj(d){
    nObj(sqrt(2)*d, 4, 45) children();
}

module arcPlace(div){
    for(i=[0:$children-1]){
        rotate([0,0,i*div]) children(i);
    }
}

module screw(hr, hh, hsr, hsh, tr, tl){
    xbw=hr/5;
    xbl=hr/3;
    xtw=hr/0.75;
    xtl=hr/3;
    difference(){
        intersection(){
            cylinder(hh+hsh, hr, hr);
            z((-hsr+hh+hsh)) sphere(hsr);
            
        }
        hull(){
                cCube([xbl, xbw, 1]);
                z(hsh+hh) cCube([xtl, xtw, 1]);
            }
            rotate([0,0,90])
             hull(){
                cCube([xbl, xbw, 1]);
                z(hsh+hh) cCube([xtl, xtw, 1]);
            }
    }
    z(-tl) cylinder(tl, tr, tr);
}

module m3Screw(l=20){
    screw(3,1.5, 8, 1, 1.5, l);
}



module screwHole(rh, rt, lh, lt){
    cylinder(lh, rh, rh);
    z(-lt) cylinder(lt, rt, rt);
}
module m3ScrewHole(lh, lt){
    screwHole(3.5, 1.6, lh, lt);
}


module sp6tHolePattern(){
    translate([0,0,45.5])quadobj(35/2) children();
}
module sp6t(holes=true){
    z(-2.5-1)cylinder(42.5+2.5+1, 20.5, 20.5);
    translate([0,0,-9])
    cylinder(9, 11.1, 11.1);
    translate([0,0,42.5]){
        difference(){
            intersection(){
                centerCube([45, 45,3]);
                cylinder(3, 57/2, 57/2, $fn=100);
            }
        if(holes) translate([0,0,-42.5+5])sp6tHolePattern()z(-9)cylinder(10, 3.3/2, 3.3/2, $fn=20);
        }
        translate([0,0,3]){
            color([0,1,0])nObj(13, 6, 0) cylinder(8, 6.5/2, 6.5/2);
            cylinder(8, 6.5/2, 6.5/2);
        }
    }
}


module placeSwitches(){
    translate([0,0,9+10]) children();
    rotate([180,0,0])translate([0,0,9+10]) children();
}



module placeFilterScrews(){
    div=180/5;
    spr=36;
    rotate([0,0,-div/2])arcPlace(div){
        rotate([0,0,-3]) x(spr) rotate([0,90,0])children();
        rotate([0,0,3]) x(spr) rotate([0,90,0])children();
        x(spr) rotate([0,90,0])children();
        x(spr) rotate([0,90,0])children();
        x(spr) rotate([0,90,0])children();
        x(spr) rotate([0,90,0])children();
        x(spr) rotate([0,90,0])children();
        
    }
}



module filterScrews(){
    placeFilterScrews()m3Screw(20);
}



module lowerBandsFilters(){
    arcPlace(180/5) {
        x(35) translate([-2,0,0])telonic350_200();
        x(35) kAndL865_530();
        x(35) kAndL1300_600();
        x(35) kAndL2010_1180();
        x(35) kAndL3300_1800();
        x(35) lp2000();
    }
}

module highBandsFilters(){
    arcPlace(180/5) {
         x(35) kAndLBandpass3200_to_6000();
         x(35+7) rotate([0,0,180])time6to19();
         x(35) allPass($fn=20);
    }
}


module relayHolderBody(){
    difference(){
        placeSwitches() z(-3) cylinder(48, 57/2, 57/2, $fn=100);
        minkowski(){
            placeSwitches() sp6t(holes=false); 
            sphere(0.35);
        }
        placeSwitches(){
            sp6tHolePattern() m3Screw(20);
        }
        z(20) filterScrews();
        z(-20) filterScrews();
        children();
        clippingBlock();
        joinScrews() m3Screw(20);
        joinScrews() m3Screw(30);
    }
}

module innerGirdle(clipped=true){
    h=50;
    hh=6;
    th=8;
    difference() {
        union(){
            z(-h/2) {
                difference(){
                    cylinder(h, 35,35);
                    z(-1) cylinder(h+2, 57/2+0.35, 57/2+0.35, $fn=100);
                }
            }
            
            
            z(-hh/2) {
                difference(){
                    cylinder(hh, 57/2+0.35, 57/2+0.35, $fn=100);
                    z(-1) cylinder(hh+2, 57/2+0.35-th, 57/2+0.35-th, $fn=100);
                }
            }
        }
        z(20) placeFilterScrews() z(-10) cylinder(20,1.6, 1.6, $fn=15);
        z(-20) placeFilterScrews() z(-10) cylinder(20,1.6, 1.6, $fn=15);
        joinScrews() m3Screw(30);
        children();
        if(clipped) clippingBlock();
        y(-25)cableHole();
        placeFilterScrews() z(4) m3Screw(40);
        
            
    }
    
}

module lowBandRelayHolders(){
     relayHolderBody() minkowski(){
        lowerBandsFilters(); 
        sphere(0.35);
    }   
}

module lowBandInnerGirdle(){
     innerGirdle() minkowski(){
        lowerBandsFilters(); 
        sphere(0.35);
    }
    
}

module lowBandOuterGirdle(){
    outerGirdle(){
        minkowski(){
            lowerBandsFilters(); 
            sphere(0.35);
        }
    }
}

module placeAllFilterBankScrews(){
    placeSwitches() sp6tHolePattern() children();
    z(20)placeFilterScrews() z(-1) children();
    z(-20)placeFilterScrews() z(-1) children();
    placeFilterScrews() z(4) children();
    
}

module filterBankLowAssembly(){
    placeSwitches() sp6t(); 
    lowerBandsFilters();
    /*placeSwitches() sp6tHolePattern() m3Screw(20);
    z(20)placeFilterScrews() z(-1) m3Screw(12);
    z(-20)placeFilterScrews() z(-1) m3Screw(12);
    placeFilterScrews() z(4) m3Screw(20);*/
    placeAllFilterBankScrews() m3Screw(20);
    lowBandRelayHolders();
    lowBandInnerGirdle();
    lowBandOuterGirdle();    

    joinScrews() m3Screw(18);
}

module outerGirdle(){
    h=30;
    rmax=50;
    t=5;
    difference(){
        hull(){
            minkowski(){
                intersection(){
                    z(-h/2)cylinder(h, rmax, rmax);
                    children();
                }
                cylinder(0.001, t, t);
            }
        }
        children();
        hull() minkowski() {
            innerGirdle();
            cylinder(1,1.5, 1.5);
        }
        placeFilterScrews() z(4) m3ScrewHole(30, 30, $fn=15);
        rotate([0,0,1])placeFilterScrews() z(4) m3ScrewHole(30, 30, $fn=15);
        rotate([0,0,-1])placeFilterScrews() z(4) m3ScrewHole(30, 30, $fn=15);
        
    }
}

module highBandRelayHolders(){
    relayHolderBody() minkowski(){
       highBandsFilters(); 
        sphere(0.35);
    }
}

module highBandInnerGirdle(){
    innerGirdle() minkowski(){
       highBandsFilters(); 
        sphere(0.35);
    }
}

module highBandOuterGirdle(){
    outerGirdle(){
        minkowski(){
           highBandsFilters(); 
            sphere(0.35);
        }
    }
}


module filterBankHighAssembly(){
    placeSwitches() sp6t(); 
    highBandsFilters();
    /*placeSwitches() sp6tHolePattern() m3Screw(20);
    z(20)placeFilterScrews() z(-1) m3Screw(20);
    z(-20)placeFilterScrews() z(-1) m3Screw(20);
    placeFilterScrews() z(4) m3Screw(20);*/
    placeAllFilterBankScrews() m3Screw(20);
    highBandRelayHolders();
    highBandInnerGirdle();
    highBandOuterGirdle();
    joinScrews() m3Screw(18);
}

module joinScrews(){
    spr=40;
    rotate([0,0,-90+60]) x(spr) rotate([0,90,0])children();
    rotate([0,0,-90-60]) x(spr) rotate([0,90,0])children();
    
    z(20){
        rotate([0,0,-90+60]) x(spr) rotate([0,90,0])children();
        rotate([0,0,-90-60]) x(spr) rotate([0,90,0])children();
    }
    
    z(-20){
        rotate([0,0,-90+60]) x(spr) rotate([0,90,0])children();
        rotate([0,0,-90-60]) x(spr) rotate([0,90,0])children();
    }
}

module placeLowBank(){
    y(25) children();
}

module placeHighBank(){
        rotate([0,0,180]) y(25) children();
}



module clippingBlock(){
    translate([-150, -300+0.35/2-25, -150]) cube(300);
}


module cableHole(){
    z(10)rotate([0,90,0]) z(-100) cylinder(200, 5, 5);
    z(-10)rotate([0,90,0]) z(-100) cylinder(200, 5, 5);
}


module holderTogetherers(){
    difference(){
        difference(){
            hull(){
                y(25) joinScrews() minkowski(){ sphere(2); m3Screw(5);}
                rotate([0,0,180]) y(25) joinScrews() minkowski(){ sphere(2); m3Screw(5);}
            }
            y(25) hull() innerGirdle(clipped=false);
            rotate([0,0,180]) y(25) hull() innerGirdle(clipped=false);
            
        }
        y(25) placeAllFilterBankScrews() z(-2) m3ScrewHole(30, 30, $fn=15);
        rotate([0,0,180]) y(25) placeAllFilterBankScrews() z(-2) m3ScrewHole(30, 30, $fn=15);
        
        y(25) joinScrews() m3ScrewHole(30, 30, $fn=15);
        rotate([0,0,180]) y(25) joinScrews() m3ScrewHole(30, 30, $fn=15);
        cableHole();
    }
}

module upper(){
    intersection(){
        cylinder(200, 200, 200);
        children();
    }
}

module lower(){
    difference(){
        children();
        cylinder(200, 200, 200);
        
    }
}

module roundedBlock(v, r){
    x=v[0]-2*r;
    y=v[1]-2*r;
    
    hull() quad(x, y) cylinder(v[2], r, r);
}

module relayBox(){
    hull(){
        roundedBlock([113, 61, 4], 5);
        roundedBlock([111, 59.5, 31], 5);
    }
}

module placeRelayBox(){
    translate([-48,0,]) rotate([0,-90,0]) children();
}


module placeBoxHolderFlerpScrews(){
    ts=3;
    tb=6;
    h=30;
    l=113+2*ts*0;
    w=61+2*ts*0;
    translate([l/2, w/2-5-3, -tb/2-0.35])rotate([0, 90,0]) children();
    translate([l/2, w/2-5-3-10, -tb/2-0.35])rotate([0, 90,0]) children();
    translate([l/2, -w/2+5+3, -tb/2-0.35])rotate([0, 90,0]) children();
    translate([l/2, -w/2+5+3+10, -tb/2-0.35])rotate([0, 90,0]) children();
    
    translate([l/2-25-3, w/2, -tb/2-0.35])rotate([-90, 0,0]) children();
    translate([l/2-25-3-10, w/2, -tb/2-0.35])rotate([-90, 0,0]) children();
    translate([-l/2+25+3, w/2, -tb/2-0.35])rotate([-90, 0,0]) children();
    translate([-l/2+25+3+10, w/2, -tb/2-0.35])rotate([-90, 0,0]) children();
    
    rotate([0, 0, 180]){
        translate([l/2, w/2-5-3, -tb/2-0.35])rotate([0, 90,0]) children();
        translate([l/2, w/2-5-3-10, -tb/2-0.35])rotate([0, 90,0]) children();
        translate([l/2, -w/2+5+3, -tb/2-0.35])rotate([0, 90,0]) children();
        translate([l/2, -w/2+5+3+10, -tb/2-0.35])rotate([0, 90,0]) children();

        translate([l/2-25-3, w/2, -tb/2-0.35])rotate([-90, 0,0]) children();
        translate([l/2-25-3-10, w/2, -tb/2-0.35])rotate([-90, 0,0]) children();
        translate([-l/2+25+3, w/2, -tb/2-0.35])rotate([-90, 0,0]) children();
        translate([-l/2+25+3+10, w/2, -tb/2-0.35])rotate([-90, 0,0]) children();
    }
    
}


module placeBoxHolderFlerps(){
    ts=3;
    tb=6;
    h=30;
    l=113+2*ts*0;
    w=61+2*ts*0;
    
    translate([l/2, w/2-5-3-5, -tb/2-0.35])rotate([0, 90,0]) children();
  
    translate([l/2, -w/2+5+3+5, -tb/2-0.35])rotate([0, 90,0]) children();
    
  
    translate([l/2-25-3-5, w/2, -tb/2-0.35])rotate([0, 90,0]) rotate([-90, 0,0]) children();
  
    translate([-l/2+25+3+5, w/2, -tb/2-0.35])rotate([0, 90,0]) rotate([-90, 0,0]) children();
    
    rotate([0, 0, 180]){
  
        translate([l/2, w/2-5-3-5, -tb/2-0.35])rotate([0, 90,0]) children();
  
        translate([l/2, -w/2+5+3+5, -tb/2-0.35])rotate([0, 90,0]) children();

  
        translate([l/2-25-3-5, w/2, -tb/2-0.35])rotate([0, 90,0]) rotate([-90, 0,0]) children();
  
        translate([-l/2+25+3+5, w/2, -tb/2-0.35])rotate([0, 90,0]) rotate([-90, 0,0]) children();
    }
    
}


module relayBoxHolderBody(){
    ts=3;
    tb=6;
    h=30;
    l=113+2*ts;
    w=61+2*ts;
    difference(){
        union(){
            z(-tb-0.35)roundedBlock([113+2*ts*0, 61+2*ts*0, tb], 5);
            hull(){
                z(-tb-0.35)roundedBlock([113+2*ts*0, 40, tb], 5);
                z(-h-0.35)roundedBlock([113+2*ts*0, 20, h], 1);
            }
        }
        placeBoxHolderFlerpScrews() m3ScrewHole(3,30);
    }
}

module relayBoxHolder(){
    difference(){
        difference(){
            placeRelayBox() relayBoxHolderBody();
            cableHole();
        }
        minkowski(){
            union(){
                placeHighBank(){
                    placeAllFilterBankScrews() z(-8) m3ScrewHole(30, 30, $fn=15);
                    hull() highBandRelayHolders();
                    hull() highBandInnerGirdle();
                    hull() highBandOuterGirdle();
                    joinScrews() m3ScrewHole(100, 30, $fn=15);;
                }
                
                placeLowBank(){
                    placeAllFilterBankScrews() z(-8) m3ScrewHole(30, 30, $fn=15);;
                    hull() lowBandRelayHolders();
                    hull() lowBandInnerGirdle();
                    hull() lowBandOuterGirdle();
                    joinScrews() m3ScrewHole(100, 30, $fn=15);
                }
            }
            sphere(0.35);
            
        }

    }
}

module flerp(){
    h=39-0.5;
    difference(){
        x(-h/2+3) cCube([h, 15, 3]);
        translate([0,5, 3])m3ScrewHole(30, 30, $fn=20);
        translate([0,-5, 3])m3ScrewHole(30, 30, $fn=20);
    }
    z(1)x(-h+3)rotate([90,0,0])z(-15/2)cylinder(15, 2, 2, $fn=20);
}



module assembly(){
    placeLowBank() filterBankLowAssembly();
    placeHighBank() filterBankHighAssembly();
    holderTogetherers();
    relayBoxHolder();
    placeRelayBox(){
        
        relayBox();    
        placeBoxHolderFlerpScrews() z(3) m3Screw();
        placeBoxHolderFlerps() flerp();
    }
}

module screwTower(l, ri, t){
    difference(){
        cylinder(l, ri+t, ri+t);
        z(t) cylinder(l, ri, ri);
        cylinder(t+2, 1.6/2, 1.6/2, $fn=10);
    }
}

/*placeRelayBox(){ 
    placeBoxHolderFlerpScrews() z(3) m3Screw();
    relayBox();    
}*/

/*relayBoxHolderBody();
relayBox();    
placeBoxHolderFlerpScrews() z(3) m3Screw();
placeBoxHolderFlerps() flerp();*/
//flerp();
//relayBoxHolder();
//Complete assembly
//assembly();

coverLength=90;
module protectiveCover(){
    
    z(coverLength+45.5) cylinder(3, 45, 45);
    sp6tHolePattern() screwTower(coverLength, 3.5, 2);
}

module coversBody(){
    t=1.5;
    
    difference(){
        union(){
            placeLowBank() placeSwitches()  z(45.5) cylinder(coverLength+46-45.5, 45, 45);
            placeHighBank() placeSwitches() z(45.5) cylinder(coverLength+46-45.5, 45, 45);
    
        }
        placeLowBank() placeSwitches()  cylinder(coverLength+46, 45-t, 45-t);
        placeHighBank() placeSwitches() cylinder(coverLength+46, 45-t, 45-t);
        
    }
    difference(){
        
        union(){
            placeLowBank() placeSwitches() protectiveCover();
            placeHighBank() placeSwitches() protectiveCover();
                    placeLowBank() placeSwitches()  placeSmaBulkhead() smaBulkheadSeatBody();
            placeHighBank() placeSwitches()  placeSmaBulkhead() smaBulkheadSeatBody();
        }
        placeLowBank() placeSwitches() sp6tHolePattern() z(3) cylinder(coverLength+10, 3.5, 3.5);
        placeHighBank() placeSwitches() sp6tHolePattern() z(3) cylinder(coverLength+10, 3.5, 3.5);
        placeLowBank() placeSwitches()  placeSmaBulkhead() smaBulkhead();
        placeHighBank() placeSwitches()  placeSmaBulkhead() smaBulkhead();
    }
    /*placeHighBank() placeSwitches() {
        for(i=[0, 3])
        rotate([0,0,45+i*90]) y(37)z(45.5) cCube([2, 15, 136-45.5]);
    }*/
    //High bank braces
    placeHighBank() placeSwitches() rotate([0,0,45]) y(37)z(45.5) cCube([2, 15, coverLength]);
    placeHighBank() placeSwitches() rotate([0,0,90+35]) y(36.5)z(45.5) rotate([0,0,-20])cCube([2, 16, coverLength]);
    placeHighBank() placeSwitches() rotate([0,0,180+55]) y(36.5)z(45.5) rotate([0,0,20])cCube([2, 16, coverLength]);
    placeHighBank() placeSwitches() rotate([0,0,270+45]) y(37)z(45.5) cCube([2, 15, coverLength]);
    /*placeLowBank() placeSwitches() {
        for(i=[0, 3])
        rotate([0,0,45+i*90]) y(37)z(45.5) cCube([2, 15, 136-45.5]);
    }*/
    //Low bank braces
    placeLowBank() placeSwitches()rotate([0,0,45-5]) y(37)z(45.5) rotate([0,0,-5]) cCube([2, 15, coverLength]);
    placeLowBank() placeSwitches() rotate([0,0,90+35]) y(36.5)z(45.5) rotate([0,0,-20])cCube([2, 16, coverLength]);
    placeLowBank() placeSwitches() rotate([0,0,180+55]) y(36.5)z(45.5) rotate([0,0,20])cCube([2, 16, coverLength]);
    placeLowBank() placeSwitches()rotate([0,0,45+270+8]) y(36.5)z(45.5) rotate([0,0,8]) cCube([2, 15.5, coverLength]);
    
    
    
}


module endCoverA(){
    intersection(){
    coversBody();
        cylinder(1000, 1000, 1000);
    }
}

module endCoverB(){
    mirror([0,0,1])endCoverA();
}

module placeSmaBulkhead(){
    z(45.5) z(coverLength) z(-4) children();
}


module smaBulkhead(){
    tol=0.35;
    nr=4.0/cos(30)+tol;
    cylinder(15,3.1+tol,3.1+tol);
    rotate([0,0,30])cylinder(4,nr,nr, $fn=6);
}   

module smaBulkheadSeatBody(){
    z(1) cylinder(3, 10, 10);
}

 
endCoverB();
endCoverA();
assembly();
//smaBulkHead();
//smaBulkheadSeatBody();
 


//lower() rotate([0,90,0]) holderTogetherers();


//upper() highBandRelayHolders();
//lower() highBandRelayHolders();
//highBandInnerGirdle();
//highBandOuterGirdle();

//upper() lowBandRelayHolders();
//lower() lowBandRelayHolders();
//lowBandInnerGirdle();
//lowBandOuterGirdle();

