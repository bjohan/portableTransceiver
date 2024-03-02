use <util.scad>
use <sp6t.scad>
use <cable.scad>
tol = 0.5;


module smaConnector(){
    color([1,0,0])cylinder(8, 6.5/2, 6.5/2);
    centerCube([16, 6, 3.5]);
}

module yigFilterHoles(){
    quad(28.5/2) cylinder(10, 3/2, 3/2);
}


module placeYigFilterConnectors(v=[true, true, true, true]){
    if(v[0]) translate([18,-19.5/2,18])rotate([0,90,0])children();
    if(v[1]) translate([18,19.5/2,18])rotate([0,90,0])children();
    if(v[2]) translate([-18,-19.5/2,18])rotate([0,-90,0])children();
    if(v[3]) translate([-18,19.5/2,18])rotate([0,-90,0])children();
}

module yigFilter(holes=true){
    difference(){
    centerCube(36*[1,1,1]);
        
        if(holes) yigFilterHoles();
    }
    /*translate([18,-19.5/2,18])rotate([0,90,0])smaConnector();
    translate([18,19.5/2,18])rotate([0,90,0])smaConnector();
    translate([-18,-19.5/2,18])rotate([0,-90,0])smaConnector();
    translate([-18,19.5/2,18])rotate([0,-90,0])smaConnector();*/
    placeYigFilterConnectors() smaConnector();
    translate([-5,18,10])cube([16,10,16]);
}


module hexBody(r, h){
    cylinder(h, r, r, $fn=6);
}

module yigFilters(){
    translate([0,0,21])nObj(32, 6,0)rotate([0,90,0]) yigFilter();
}



module rfComponents(){
sp6t();
yigFilters();
}

module rfComponentsTol(){
    minkowski(){rfComponents(); sphere(0.5);}
}

module mainBody(){
    difference(){
    union(){
    rotate([0,0,30])hexBody(32/sin(60), 39.5);
        rotate([0,0,30]) hexBody(60/sin(60), 3);
    }
    rfComponentsTol();
}

}

module topPlate(){
    difference(){
    translate([0,0,39.0]) rotate([0,0,30]) hexBody(60/sin(60), 3);
        rfComponentsTol();
    }
}

module mainBodyPrint(){
    mainBody();
}

module topPlatePrint(){
    rotate([180,0,0])topPlate();
}

module printedPartsAssembly(){
    topPlate();
    mainBody();
}

module completeAssembly(){
    printedPartsAssembly();
    rfComponents();
}

//completeAssembly();
//mainBodyPrint();
//topPlatePrint();

module placeRelays(){
    translate([-18-1.5,0,0]){
        translate([0,+18+2+4,0]) children();
        translate([0,-18-2-4,42.5]) rotate([180,0,0]) children();
    }
}

module relays(){
    placeRelays() sp6t();
/*    translate([-18-1.5,0,0]){
translate([0,+18+2+4,0])sp6t();
translate([0,-18-2-4,42.5]) rotate([180,0,0]) sp6t();
    }*/
}
module yigFilters(){
    translate([-18-1.5,0,3]){
translate([43,18+1.5,18])rotate([0,90,0]) translate([0,0,-18]) yigFilter();
translate([43,-18-1.5,18])rotate([0,90,180])translate([0,0,-18])yigFilter();
translate([43+36+3,18+1.5,18])rotate([0,90,0]) translate([0,0,-18]) yigFilter();
translate([43+36+3,-18-1.5,18])rotate([0,90,180])translate([0,0,-18])yigFilter();
translate([-43,18+1.5,18])rotate([0,90,0]) translate([0,0,-18]) yigFilter();
translate([-43,-18-1.5,18])rotate([0,90,180])translate([0,0,-18])yigFilter();
    }
}

module yigFilters2(){
    translate([-18-1.5,0,3]){
        translate([43,18+1.5,18])rotate([0,90,0]) translate([0,0,-18]) yigFilter();
        translate([43,-18-1.5,18])rotate([0,90,180])translate([0,0,-18])yigFilter();
        translate([43+36+3,18+1.5,18])rotate([0,90,0]) translate([0,0,-18]) yigFilter();
        translate([43+36+3,-18-1.5,18])rotate([0,90,180])translate([0,0,-18])yigFilter();
        translate([-43*0+4,18+1.5,18])rotate([0,90,0]) translate([0,0,-18]) yigFilter();
        translate([-43*0+4,-18-1.5,18])rotate([0,90,180])translate([0,0,-18])yigFilter();
    }
}


module rectangularRfComponents(){
        relays();
        yigFilters();
    rotate([0,0,90]) relays();
}



module rectangularBody(){
    dim = [161+6, 75+18, 42.5-3];
    difference(){
        centerCube(dim);
        minkowski(){
            relays();
            cylinder(0.01,tol, tol);
        }
        placeRelays() quad(35/2) cylinder(60, 3/2, 3/2);
        minkowski(){
            yigFilters();
            cylinder(30,tol, tol);
        }
        rectPlace(dim-[10,10,0]) cylinder(60,3/2, 3/2);
        translate([100,47,18])rotate([0,-90,0])cylinder(200, 5,5);
        translate([100,-47,18])rotate([0,-90,0])cylinder(200, 5,5);
        translate([0,46, 0]) cylinder(18,5,5);
translate([0,-46, 42.5-25]) cylinder(25,5,5);
    }
}
module rectangularLid(){
    dim = [161+6, 75+18, 42.5-3];
    difference(){
        translate([0,0,42.5-3])
        centerCube([161+6, 75+18, 3]);
        minkowski(){
            relays();
            cylinder(0.01,tol, tol);
        }
        placeRelays() quad(35/2) cylinder(60, 3/2, 3/2);
        minkowski(){
            yigFilters();
            cylinder(0.01,tol, tol);
        }
        rectPlace(dim-[10,10,0]) cylinder(60,3/2, 3/2);
        translate([0,46, 0]) cylinder(18,5,5);
translate([0,-46, 42.5-25]) cylinder(25,5,5);
        
    }
}


module sideWall(){
    intersection(){
    rectangularBody();
    translate([78.5,0,3])centerCube([10, 95,40]);
    }
}


module switchHolder(){
    intersection(){
    rectangularBody();
    translate([-20+0.5,0,3])centerCube([42+7, 95,40]);
    }
}


module placeRelays(){
    d=37-4;
    ho=2-5;
    translate([-20-2-6,0,24+5]){
translate([d/2,0,0]) children();
translate([-d/2,0,ho]) rotate([180,0,0] )children();
translate([-1.5*d,0,0]) children();
translate([1.5*d,0,ho]) rotate([180,0,0] )children();
    }
}

module placeFilters(v=[true, true, true, true, true, true]){
    dx=53-10+0.2;
    ox=dx/2;
    oz=55;
    translate([1.3,-2,0]){
        for(i=[0:2]){
            if(v[i])translate([-100+i*dx,-50,0]) rotate([0,90,0])children();
        }
        translate([ox, 0, oz])
        for(i=[0:2]){
            if(v[i+3])translate([-100+i*dx,-50,0]) rotate([0,90,0])children();
        }
    }
}

module componentAssembly(){
    placeFilters() yigFilter();
    placeRelays() sp6t();
}

module placeComponentAssembly(){
    translate([100,35,17+2.5])children();
}

module linPlace(n=3, v=[1,0,0], l=120){
    for(i=[0:n-1]) translate(l*(i/(n-1))*v) children();
}


cx=168-24+1.3*2;
cy=60;
cz=90+4;
t=10;

module bottomScrews(){
    translate([40+1.3, t/2,-2])linPlace(l=86)cylinder(40, 1.5,1.5);
}

module topScrews(){
    translate([18+1.3, t/2,cz+2-40])linPlace(l=86)cylinder(40, 1.5,1.5);
}

module edgeScrews(r=1.5){
    translate([0, t/2, t/2]) linPlace(n=3, l=cy-t, v=[0,1,0])rotate([0,90,0]) cylinder(40,r,r);
    translate([0, t/2, t/2]) linPlace(n=4, l=cz-t-1, v=[0,0,1])rotate([0,90,0]) cylinder(40,r,r);
    translate([0, t/2, cz-t/2-1]) linPlace(n=3, l=cy-t, v=[0,1,0])rotate([0,90,0]) cylinder(40,r,r);
}

module holderTop(){
        difference(){
        union(){
            
            translate([0,0,cz-t])cube([cx, cy,t]);
        }
        minkowski(){
            placeComponentAssembly(){
                componentAssembly();
                placeFilters() yigFilter(holes=false);
            }
            sphere(0.35);
        }
        placeComponentAssembly()placeRelays() sp6tHolePattern(l=20);
        topScrews();
        translate([-10,0,0]) edgeScrews();
        translate([cx-40+10,0,0]) edgeScrews();
    }
}

module holderWall(){
        difference(){
        union(){
            translate([0,0,t])cube([cx, t,cz-2*t]);
            
        }
        minkowski(){
            placeComponentAssembly(){
                componentAssembly();
                placeFilters() yigFilter(holes=false);
            }
            sphere(0.35);
        }
        placeComponentAssembly()placeRelays() sp6tHolePattern(l=20);
        topScrews();
        bottomScrews();
        filterClampHoles();
        translate([-10,0,0]) edgeScrews();
        translate([cx-40+10,0,0]) edgeScrews();
    }
}

module holderBottom(){
        difference(){
        union(){
            
            cube([cx, cy,t]);
            
        }
        minkowski(){
            placeComponentAssembly(){
                componentAssembly();
                placeFilters() yigFilter(holes=false);
            }
            sphere(0.35);
        }
        placeComponentAssembly()placeRelays() sp6tHolePattern(l=20);
        bottomScrews();
        translate([-10,0,0]) edgeScrews();
        translate([cx-40+10,0,0]) edgeScrews();
    }
}


module holder(){
    holderBottom();
    holderWall();
    holderTop();
}

module filterClampBody(){
    hi=33;
    w=10;
    tbw=94;
    translate([0,-hi,cz/2-w/2])cube([w,hi,w]);
    translate([cx-w,-hi,cz/2-w/2])cube([w,hi,w]);
    translate([0,-hi-t/2,cz/2-tbw/2])cube([cx,t/1.8,tbw]);
}

module filterClampHoles(){
    hi=33;
    w=10;
    tbw=50;
    translate([w/2,+t+2,cz/2]) rotate([90,0,0])cylinder(42,1.5, 1.5);
    translate([cx-w/2,+t+2,cz/2]) rotate([90,0,0])cylinder(42,1.5, 1.5);
}

module filterClamp(){
    difference(){
        filterClampBody();
        minkowski(){
        placeComponentAssembly() componentAssembly();
            sphere(0.35);
        }
        filterClampHoles();
    }
}
module smaBulkHead(){
    nr=4.0/cos(30);
    cylinder(15,3.1,3.1);
    rotate([0,0,30])cylinder(4,nr,nr, $fn=6);
}        

module placeSideWallASma(){
    lo=16;
    translate([2,0,94+25-lo]) rotate([0,-90,0]) children();
    translate([2,-19.02,94+25-lo]) rotate([0,-90,0]) children();
    translate([2,0,-25+lo]) rotate([0,-90,0]) children();
    translate([2,-19.02,-25+lo]) rotate([0,-90,0]) children();
}    

module placeSideWallABanana(){
    lo=16;
    translate([2,15,94+25-lo]) rotate([0,-90,0]) children();
    translate([2,15+38,94+25-lo]) rotate([0,-90,0]) children();
    translate([2,15,-25+lo]) rotate([0,-90,0]) children();
    translate([2,15+38,-25+lo]) rotate([0,-90,0]) children();
}    

module sideWallAScrews(ss){
    lo=18;
    translate([-5,-38-5,-45+lo]){ 
        translate([5, 5, 0]) linPlace(n=4, l=60+38+5-10, v=[0,1,0]) cylinder(10,1.5,1.5);
    }

    translate([-5,-38-5,-45+184-10+30-lo]){
        translate([5, 5, -30]) linPlace(n=4, l=60+38+5-10, v=[0,1,0]) cylinder(10,1.5,1.5);
    }
    if(ss)
    translate([-20,0,0])edgeScrews();
}

module sideWallABody(sideScrew=true, holes=false){
    lo=18;
    difference(){
        union(){
            translate([-5,-38-5,-45+lo]) cube([5,60+38+5,94+90-lo*2]);
            translate([-5,-38-5,38]) cube([10,15,94-38]);
            translate([-5,-38-5,-45+lo]) cube([10,60+38+5,10]);
            translate([-5,-38-5,-45+184-10-lo]) cube([10,60+38+5,10]); 
        }
        //if(sideScrew)
        sideWallAScrews(sideScrew);
        translate([-10, 10, 10])cube([40, 40, 74]);
        translate([-10, -28, 0])cube([40, 28, 40]);
        translate([-10, -28, 94-40])cube([40, 28, 40]);
        minkowski(){
            filterClamp();
            sphere(0.35);
        }
        if(holes) placeSideWallABanana() translate([0,0,-10]) cylinder(20, 4.5, 4.5);
        if(holes) placeSideWallASma()
         minkowski(){
            smaBulkHead();
            sphere(0.35);
        }
        
    }
    
}

module sideWallA(){
    difference(){
        sideWallABody();
        translate([6,45,0])placeEnclosureMount() centerCube([38,20,8]);    
    }
}


module sideWallB(){
    difference(){
        translate([145, 0,94])rotate([0,180,0]) sideWallABody(sideScrew=false, holes=true);
        translate([cx-40+20,0,0]) edgeScrews();
    }
}

module topCover(){
    lo=18;
    difference(){
    translate([-5,-43,139-lo]){
        cube([155,103,1.8]);
        translate([10,0,-8]){
            difference(){
                cube([135,103,8]);
                translate([5-3,5,-1])cube([125+6,93,11]);
            }
        }
    }
        translate([0,0,5]){
            sideWallAScrews();
            translate([145, 0,94])rotate([0,180,0])sideWallAScrews();
        }
    }
}

module bottomCover(){
    lo=18;
    translate([0,17,94])rotate([180,0,0])topCover();
}


module roundedPlate(v, r){
    lx=(v[0]-2*r)/2;
    ly=(v[1]-2*r)/2;
    lz=v[2];
    translate([-lx, -ly, 0]) cylinder(lz, r, r);
    translate([-lx, ly, 0]) cylinder(lz, r, r);
    translate([lx, -ly, 0]) cylinder(lz, r, r);
    translate([lx, ly, 0]) cylinder(lz, r, r);
}

module enclosure(){
    translate([0,0,1])
    minkowski(){
    hull(){
        roundedPlate([120-2, 94-2, 0.1], 5);
        translate([0,0,34-2])roundedPlate([117-2, 92-2, 0.1], 5);
    }
    sphere(1, $fn=10);
    }
}


module flerpScrews(l,h){
    translate([l/4,4,h])rotate([90,0,0])cylinder(30, 1.5, 1.5);
    translate([l-l/4,4,h])rotate([90,0,0])cylinder(30, 1.5, 1.5);
}
module enclosureFlerp(l, t, h){
    difference(){
        cube([l, t, h]);
        flerpScrews(l,4);
        
    }
    translate([0,0,h])rotate([0,90,0])cylinder(l, t, t, $fn=16);
    
}

module enclosureFlerp2(l, t, h){
    notchOffs=7;
    notchDepth=5;
    notchHeight=15;
    difference(){
        union(){
            cube([l, t, h]);
            translate([0,0,h-notchOffs-t-notchHeight]) cube([l, notchDepth+t, notchHeight+2*t]);
        }
        translate([0,0,h-notchOffs-notchHeight]) cube([l, notchDepth, notchHeight]);
        flerpScrews(l,4);
        
    }
    translate([0,0,h])rotate([0,90,0])cylinder(l, t, t, $fn=16);
    
}

module rectPlace(x,y){
    translate([x,y,0]) children();
    translate([x,-y,0]) children();
    translate([-x,y,0]) children();
    translate([-x,-y,0]) children();
}

module enclosureBase(){
    difference(){
    hull()roundedPlate([120, 94, 8], 5);
        placeFlerps() flerpScrews(30,4);
        translate([0,4.5,0])centerCube([140,12+6,5]);
        centerCube([38,140,5]);
        rectPlace(96/2, 71/2) cylinder(10,4,4);
    }
    
}


module placeFlerps(){
    //translate([50-30,47,0])children();
    translate([-50,47,0])children();
    translate([-60,10,0])rotate([0,0,90])children();
    //translate([-60,-(30+10),0])rotate([0,0,90])children();
    rotate([0,0,180]){
        translate([50-30,47,0])children();
        translate([-50,47,0])children();
        translate([-60,10,0])rotate([0,0,90])children();
        translate([-60,-(30+10),0])rotate([0,0,90])children();
    }
}

module enclosureMountFlerpAssembly(){
    placeFlerps()enclosureFlerp(30, 3, 34+8+3-0.7);
    
    translate([0,0,8]){
        //rotate([180,0,0])translate([0,0,-34])enclosure();
    }
}

module placeEnclosureMount(){
translate([-5,13,(39+55)/2])rotate([0,-90,0])children();
    
}

module placedEnclosureMountBase(){
    difference(){
     placeEnclosureMount()enclosureBase();
        translate([-15,0,0])edgeScrews();
        translate([-53+4,0,0])edgeScrews(r=4);
    }
}



module fanHolePattern(l, hole=true){
    quad(20/2) cylinder(l, 1.5, 1.5);
    if(hole) cylinder(l, 24.2/2, 24.2/2);
}

module fan(){
    difference(){
        hull() quad((25.3-5)/2) cylinder(10.5, 5/2, 5/2, $fn=10);
        fanHolePattern(11);
    }
    
}

module fanBase(){
    difference(){
        hull() quad((25.3-5)/2) cylinder(3, 5/2+1, 5/2+1, $fn=10);
        fanHolePattern(11);
    }
}


module placeFanBase(){
    translate([142.5,-14,28])rotate([0,130,0]) translate([1,0,0])children();
}

module fanBracketBody(){
    translate([142,-14,28]){
        translate([8,-13.6,5])cube([3, 30,21]);
        translate([8,14,0])cube([3, 10,35+2]);
    }
    placeFanBase()fanBase();
}

module fanBracket(){
    difference(){
        fanBracketBody();
        placeFanBase() translate([0,0,-3.2])fanHolePattern(10);
        placeFanBase() translate([-3,0,3]) hull() quad((25.3-3)/2) cylinder(3, 5/2, 5/2, $fn=10);
        translate([140,0,0])edgeScrews();
    }
}
 

//enclosureFlerp(30, 3, 34+8+3-0.7);
//enclosureFlerp2(30, 3, 34+8+3-0.7);


cableR=3.6/2;

module inputPreCable1(){
    cableSection(57+5, cableR, 10, 90, -80) 
        cableSection(23, cableR, 10, 90, 0) 
            cableSection(6, cableR, 10, 0, 0) children();
}

module inputPreCable2(){
    cableSection(5+2, cableR, 10, 90, -54) 
        cableSection(18, cableR, 10, 90, 0) 
            cableSection(6, cableR, 10, 0, 0) children();
}

module inputPreCable3(){
    cableSection(57+5, cableR, 10, 90, -45) 
        cableSection(23.5, cableR, 10, 90, 0)
            cableSection(6, cableR, 10, 0, 0) children();
}

module inputPreCable4(){
    cableSection(5+2, cableR, 10, 90, -42.5) 
        cableSection(42.5, cableR, 10, 90, 0) 
            cableSection(6, cableR, 10, 0, 0) children();
}

module inputPreCable5(){
    cableSection(57+5, cableR, 10, 90, -36) 
        cableSection(71.5, cableR, 10, 90, 0) 
            cableSection(6, cableR, 10, 0, 0) children();
}

module inputPreCable6(){
     cableSection(5+2, cableR, 10, 90, 0)  
        cableSection(0, cableR, 10, 36, -90) 
            cableSection(90, cableR, 10, 50, 180) 
                cableSection(2, cableR, 10, 90, -90) 
                    cableSection(6, cableR, 10, 0, 0) children();
}

module cablesInputPreFilter(){
    //High frequency pre filter input cable
    placeFilters([false, false, false, false, false, true]) placeYigFilterConnectors([false, true, false, false]) translate([0, 0, 8])
    inputPreCable1();

    //Second highest frequency pre filter input cable
    placeFilters([false, false, true, false, false, false]) placeYigFilterConnectors([false, true, false, false]) translate([0, 0, 8])
    inputPreCable2();

    //Third highest frequency pre filter input cable
    placeFilters([false, false, false, false, true, false]) placeYigFilterConnectors([false, true, false, false]) translate([0, 0, 8])
    inputPreCable3();

    //Fourth highest frequency pre filter input cable
    placeFilters([false, true, false, false, false, false]) placeYigFilterConnectors([false, true, false, false]) translate([0, 0, 8]) inputPreCable4();
    

    //Fifth highest frequency pre filter input cable
    placeFilters([false, false, false, true, false, false]) placeYigFilterConnectors([false, true, false, false]) translate([0, 0, 8])
    inputPreCable5();

    //Sixth highest frequency pre filter input cable
    placeFilters([true, false, false, false, false, false]) placeYigFilterConnectors([false, true, false, false]) translate([0, 0, 8])
   inputPreCable6();
}


module inputPostCable1(){
        cableSection(57, cableR, 10, 90, -117.75)         
        cableSection(62, cableR, 10, 90, -25-90) 
            cableSection(0, cableR, 10, 115, 90)
                cableSection(6, cableR, 10, 0, 0) children();
}

module inputPostCable2(){
    cableSection(5+2, cableR, 10, 90+41.5, -110.5) 
        cableSection(0, cableR, 10, 41.5, 180)
            cableSection(29.5, cableR, 10, 90, 90-25)
                cableSection(0, cableR, 10, 115, 90)
                    cableSection(6, cableR, 10, 0, 0) children();
}

module inputPostCable3(){
    cableSection(57, cableR, 10, 90, -152)
        cableSection(15, cableR, 10, 30, 90)
            cableSection(13, cableR, 10, 30, 0)
                cableSection(0, cableR, 8, 45, 90)
                    cableSection(0, cableR, 8, 90+45, 180)
                        cableSection(7, cableR, 8, 0, 180)children();
}

module inputPostCable4(){
    cableSection(5+2, cableR, 10, 90+41.5, -125) 
        cableSection(0, cableR, 10, 41.5, 180)
            cableSection(20, cableR, 10, 59, -90+35-6)
                cableSection(4, cableR, 10, 115, -90-25+10)
                    cableSection(6, cableR, 10, 0, 0) children();
}

module inputPostCable5(){
    cableSection(57, cableR, 10, 90, -122)
        cableSection(22, cableR, 10, 53, 90)
            cableSection(22, cableR, 10, 30, 0)
                cableSection(0, cableR, 8, 45, 90)
                    cableSection(0, cableR, 8, 90+45, 180)
                        cableSection(7, cableR, 8, 0, 180) children();
}

module inputPostCable6(){
    cableSection(5+2, cableR, 10, 90, -105) 
            cableSection(20, cableR, 10, 35, 90)
                cableSection(30, cableR, 10, 35, 0)
                    cableSection(20, cableR, 10, 72, 0)
                        cableSection(0, cableR, 10, 90, -90)
                            cableSection(6, cableR, 10, 0, -90) children();
}



module cablesInputPostFilter(){
    //High frequency post filter input cable
    placeFilters([false, false, false, false, false, true]) placeYigFilterConnectors([true, false, false, false]) translate([0, 0, 8])
inputPostCable1();

    //Second highest frequency post filter input cable
    placeFilters([false, false, true, false, false, false]) placeYigFilterConnectors([true, false, false, false]) translate([0, 0, 8])
    inputPostCable2();

    //Third highest frequency post filter input cable
    placeFilters([false, false, false, false, true, false]) placeYigFilterConnectors([true, false, false, false]) translate([0, 0, 8])
    inputPostCable3();
   

    //Fourth highest frequency post filter input cable
    placeFilters([false, true, false, false, false, false]) placeYigFilterConnectors([true, false, false, false]) translate([0, 0, 8])
    inputPostCable4();

    //Fifth highest frequency post filter input cable
    placeFilters([false, false, false, true, false, false]) placeYigFilterConnectors([true, false, false, false]) translate([0, 0, 8])
    inputPostCable5();

    //Sixth highest frequency post filter input cable
    placeFilters([true, false, false, false, false, false]) placeYigFilterConnectors([true, false, false, false]) translate([0, 0, 8])
    inputPostCable6();
}



module outputPreCable1(){
    cableSection(7, cableR, 10, 90, -58.5) 
        cableSection(29.5, cableR, 10, 90, 0) 
            cableSection(6, cableR, 10, 0, 0) children();
}

module outputPreCable2(){
    cableSection(57+5, cableR, 10, 90, -78.5) 
        cableSection(34.5, cableR, 10, 90, 0) 
            cableSection(6, cableR, 10, 0, 0) children();
}

module outputPreCable3(){
    cableSection(7, cableR, 10, 90, -100) 
        cableSection(16.5, cableR, 10, 60, 90)
            cableSection(0, cableR, 10, 53, 180)
                cableSection(0, cableR, 10, 90, 90)
                    cableSection(6, cableR, 10, 0, 0)  children();
}

module outputPreCable4(){
    cableSection(57+5, cableR, 10, 90, -107) 
        cableSection(24, cableR, 10, 90, 0) 
            cableSection(6, cableR, 10, 0, 0) children();
}

module outputPreCable5(){
    cableSection(7, cableR, 10, 90, 165) 
        cableSection(7, cableR, 10, 81.5, 90)
            cableSection(22, cableR, 10, 90, -90)
            cableSection(6, cableR, 10, 0, 0) children();
}

module outputPreCable6(){
    cableSection(57+5, cableR, 10, 90, 165) 
        cableSection(30, cableR, 10, 30, 90) 
            cableSection(25, cableR, 10, 74, 0)
                cableSection(15.5, cableR, 10, 90, -90)
                    cableSection(6, cableR, 10, 0, 0)  children();
}

module cablesOutputPreFilter(){
    //High frequency pre filter input cable
    placeFilters([false, false, false, false, false, true]) placeYigFilterConnectors([false, false, false, true]) translate([0, 0, 8]) outputPreCable1();

    //Second highest frequency pre filter input cable
    placeFilters([false, false, true, false, false, false]) placeYigFilterConnectors([false, false, false, true]) translate([0, 0, 8])
    outputPreCable2();

    //Third highest frequency pre filter input cable
    placeFilters([false, false, false, false, true, false]) placeYigFilterConnectors([false, false, false, true]) translate([0, 0, 8])
    outputPreCable3();

    //Fourth highest frequency pre filter input cable
    placeFilters([false, true, false, false, false, false]) placeYigFilterConnectors([false, false, false, true]) translate([0, 0, 8]) outputPreCable4();
    

    //Fifth highest frequency pre filter input cable
    placeFilters([false, false, false, true, false, false]) placeYigFilterConnectors([false, false, false, true]) translate([0, 0, 8])
    outputPreCable5();

    //Sixth highest frequency pre filter input cable
    placeFilters([true, false, false, false, false, false]) placeYigFilterConnectors([false, false, false, true]) translate([0, 0, 8])
   outputPreCable6();
}

module outputPostCable1(){
    cableSection(5+2, cableR, 10, 90+41.5, -60) 
        cableSection(0, cableR, 10, 41.5, 180)
            cableSection(22, cableR, 10, 60, -90)
                cableSection(34.5, cableR, 10, 37.75, 180)
                    cableSection(0, cableR, 10, 42, -90)
                        cableSection(0, cableR, 10, 42, 180)
                            cableSection(2, cableR, 10, 90, 0) 
                                cableSection(6, cableR, 10, 0, 0) children();
}


module outputPostCable2(){
    cableSection(52, cableR, 10, 90, -60)
        cableSection(68.5, cableR, 10, 60, 90)
            //cableSection(22, cableR, 10, 60, -90)
                //cableSection(34.5, cableR, 10, 37.75, 180)
                    cableSection(0, cableR, 10, 57, 90)
                        cableSection(0, cableR, 10, 57, 180)
                            cableSection(2, cableR, 10, 90, 0) 
                                cableSection(6, cableR, 10, 0, 0) children();
}


module outputPostCable3(){
    cableSection(5+2, cableR, 10, 90+41.5, -10) 
        cableSection(0, cableR, 10, 41.5, 180)
            cableSection(5, cableR, 10, 75, 90)
                cableSection(5, cableR, 10, 30, -90)
                    cableSection(5, cableR, 10, 30, 180)
                        cableSection(9, cableR, 8, 50, 90)
                            cableSection(10, cableR, 8, 50, 180)
                                cableSection(0, cableR, 8, 51, 180)
                                    cableSection(3.5, cableR, 10, 90, -90) 
                                        cableSection(6, cableR, 10, 0, 0) children();
}


module outputPostCable4(){
    cableSection(57+5, cableR, 10, 90, 30)
        cableSection(0, cableR, 10, 30, -90)
            cableSection(29.5, cableR, 10, 90, 0)
                //cableSection(43, cableR, 10, 0, 0)
                    cableSection(47.5, cableR, 10, 90, 90) 
                        cableSection(6, cableR, 10, 0, 0) children();
}



module outputPostCable5(){
    cableSection(7, cableR, 10, 90, -30) 
        cableSection(15, cableR, 10, 63.5, -90) 
            cableSection(18.5, cableR, 10, 90, 90)
                cableSection(6, cableR, 10, 0, 0) children();
}


module outputPostCable6(){
    cableSection(57, cableR, 10, 90, -110)
        cableSection(6, cableR, 10, 42, 180)
            cableSection(0, cableR, 10, 42, 180)
                cableSection(5, cableR, 10, 30, 90)
            cableSection(3.25, cableR, 10, 90, -90)
                cableSection(6, cableR, 10, 0, 0)
    
    
    children();
}



module cablesOutputPostFilter(){
    //High frequency pre filter input cable
    placeFilters([false, false, false, false, false, true]) placeYigFilterConnectors([false, false, true, false]) translate([0, 0, 8]) outputPostCable1();

    //Second highest frequency pre filter input cable
    placeFilters([false, false, true, false, false, false]) placeYigFilterConnectors([false, false, true, false]) translate([0, 0, 8])
    outputPostCable2();

    //Third highest frequency pre filter input cable
    placeFilters([false, false, false, false, true, false]) placeYigFilterConnectors([false, false, true, false]) translate([0, 0, 8])
    outputPostCable3();

    //Fourth highest frequency pre filter input cable
    placeFilters([false, true, false, false, false, false]) placeYigFilterConnectors([false, false, true, false]) translate([0, 0, 8]) outputPostCable4();
    

    //Fifth highest frequency pre filter input cable
    placeFilters([false, false, false, true, false, false]) placeYigFilterConnectors([false, false, true, false]) translate([0, 0, 8])
    outputPostCable5();

    //Sixth highest frequency pre filter input cable
    placeFilters([true, false, false, false, false, false]) placeYigFilterConnectors([false, false, true, false]) translate([0, 0, 8])
   outputPostCable6();
}


module assembly(){
    placeComponentAssembly(){
        componentAssembly();    
        cablesInputPostFilter();
        cablesInputPreFilter();
        cablesOutputPreFilter();
        cablesOutputPostFilter();
    }
    holder();
    filterClamp();
    sideWallA();
    sideWallB();
    topCover();
    bottomCover();
    placedEnclosureMountBase();
    placeEnclosureMount()enclosureMountFlerpAssembly();
    fanBracket();
    placeEnclosureMount()translate([0,0,42]) rotate([180,0,0])enclosure();
    
    translate([145, 0,94])rotate([0,180,0]){
    placeSideWallABanana() cylinder(10, 4.5, 4.5);
    placeSideWallASma() smaBulkHead();
    }
    
    
}


/*translate([100, 0, 0]) cableForm() outputPostCable1();
translate([200, 0, 0]) cableForm() outputPostCable2();
translate([300, 0, 0]) cableForm() outputPostCable3();
translate([400, 0, 0]) cableForm() outputPostCable4();
translate([500, 0, 0]) cableForm() outputPostCable5();
translate([600, 0, 0]) cableForm() outputPostCable6();

translate([100, 100, 0]) cableForm() inputPostCable1();
translate([200, 100, 0]) cableForm() inputPostCable2();
translate([300, 100, 0]) cableForm() inputPostCable3();
translate([400, 100, 0]) cableForm() inputPostCable4();
translate([500, 100, 0]) cableForm() inputPostCable5();
translate([600, 100, 0]) cableForm() inputPostCable6();


translate([100, 200, 0]) cableForm() outputPreCable1();
translate([200, 200, 0]) cableForm() outputPreCable2();
translate([300, 200, 0]) cableForm() outputPreCable3();
translate([400, 200, 0]) cableForm() outputPreCable4();
translate([500, 200, 0]) cableForm() outputPreCable5();
translate([600, 200, 0]) cableForm() outputPreCable6();

translate([100, 300, 0]) cableForm() inputPreCable1();
translate([200, 300, 0]) cableForm() inputPreCable2();
translate([300, 300, 0]) cableForm() inputPreCable3();
translate([400, 300, 0]) cableForm() inputPreCable4();
translate([500, 300, 0]) cableForm() inputPreCable5();
translate([600, 300, 0]) cableForm() inputPreCable6();*/


//cablesInputPostFilter();
//cablesInputPreFilter();
//cablesOutputPreFilter();
//cablesOutputPostFilter();
//componentAssembly();

//sideWallA();
//placedEnclosureMountBase();
assembly();

//fanBracket();
//placeFanBase() translate([0,0,3.2])fan();
//enclosureFlerp(30, 3, 34+8+3-0.7);
//placedEnclosureMountBase();
//enclosureFlerp(30, 3, 34+8+3-0.7);

//flerpScres(30,4);
//placeComponentAssembly() placeRelays() sp6t();
//placeComponentAssembly()placeRelays() sp6tHolePattern(l=30);
//placeComponentAssembly() componentAssembly();
//translate([cx-40+20,0,0]) edgeScrews();
//sp6t();
//sp6tHolePattern(l=20);
//placeRelays() sp6tHolePattern();
//rotate([180,0,0] ){
//translate([22.5+1,0,10]) sp6t();
//translate([-22.5-1,0,10]) sp6t();
//}
//yigFilters2();
//translate([23.5,-50,0])rotate([0,0,90])relays();
//translate([23.5,89,0])rotate([0,0,90])relays();
//sideWall();
//switchHolder();
//rotate([0,90,0]) sideWall();
//rectangularBody();
//rectangularLid();
//rectangularRfComponents();
