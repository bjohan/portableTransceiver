tol = 0.5;
module centerCube(v){
    translate([-v[0]/2,-v[1]/2,0]) cube(v);
}

module rectPlace(v){
    translate([-v[0]/2,-v[1]/2,0]) children();
    translate([-v[0]/2,v[1]/2,0]) children();
    translate([v[0]/2,-v[1]/2,0]) children();
    translate([v[0]/2,v[1]/2,0]) children();
}


module nObj(r, n, offs){
    for(a=[1:n]) rotate([0,0, offs+a*360/n]) translate([r,0,0]) children();
}

module quad(d){
    nObj(sqrt(2)*d, 4, 45) children();
}


module sp6tHolePattern(l=10){
translate([0,0,42.5+5-l])quad(35/2) cylinder(l, 3/2, 3/2);
}

module sp6t(){
    cylinder(42.5, 20, 20);
    translate([0,0,-9])
    cylinder(9, 11.1, 11.1);
    translate([0,0,42.5]){
        difference(){
        centerCube([45, 45,3]);
       translate([0,0,-42.5+5])sp6tHolePattern();
        }
        translate([0,0,3]){
            color([0,1,0])nObj(13, 6, 0) cylinder(8, 6.5/2, 6.5/2);
            cylinder(8, 6.5/2, 6.5/2);
        }
    }
}

module smaConnector(){
    color([1,0,0])cylinder(8, 6.5/2, 6.5/2);
    centerCube([16, 6, 3.5]);
}

module yigFilterHoles(){
    quad(28.5/2) cylinder(10, 3/2, 3/2);
}

module yigFilter(holes=true){
    difference(){
    centerCube(36*[1,1,1]);
        
        if(holes) yigFilterHoles();
    }
    translate([18,-19.5/2,18])rotate([0,90,0])smaConnector();
    translate([18,19.5/2,18])rotate([0,90,0])smaConnector();
    translate([-18,-19.5/2,18])rotate([0,-90,0])smaConnector();
    translate([-18,19.5/2,18])rotate([0,-90,0])smaConnector();
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

module placeFilters(){
    dx=53-10+0.2;
    ox=dx/2;
    oz=55;
    translate([1.3,-2,0]){
        for(i=[0:2]){
            translate([-100+i*dx,-50,0]) rotate([0,90,0])children();
        }
        translate([ox, 0, oz])
        for(i=[0:2]){
            translate([-100+i*dx,-50,0]) rotate([0,90,0])children();
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
    translate([2,0,94+25]) rotate([0,-90,0]) children();
    translate([2,-19.02,94+25]) rotate([0,-90,0]) children();
    translate([2,0,-25]) rotate([0,-90,0]) children();
    translate([2,-19.02,-25]) rotate([0,-90,0]) children();
}    

module sideWallAScrews(ss){
    translate([-5,-38-5,-45]){ 
        translate([5, 5, 0]) linPlace(n=4, l=60+38+5-10, v=[0,1,0]) cylinder(10,1.5,1.5);
    }

    translate([-5,-38-5,-45+184-10+30]){
        translate([5, 5, -30]) linPlace(n=4, l=60+38+5-10, v=[0,1,0]) cylinder(10,1.5,1.5);
    }
    if(ss)
    translate([-20,0,0])edgeScrews();
}

module sideWallA(sideScrew=true){
    difference(){
        union(){
            translate([-5,-38-5,-45]) cube([5,60+38+5,94+90]);
            translate([-5,-38-5,38]) cube([10,15,94-38]);
            translate([-5,-38-5,-45]) cube([10,60+38+5,10]);
            translate([-5,-38-5,-45+184-10]) cube([10,60+38+5,10]); 
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
        placeSideWallASma()
         minkowski(){
            smaBulkHead();
            sphere(0.35);
        }
    }
}

module sideWallB(){
    difference(){
        translate([145, 0,94])rotate([0,180,0]) sideWallA(sideScrew=false);
        translate([cx-40+20,0,0]) edgeScrews();
    }
}

module topCover(){
    difference(){
    translate([-5,-43,139]){
        cube([155,103,1.8]);
        translate([10,0,-8]){
            difference(){
                cube([135,103,8]);
                translate([5,5,-1])cube([125,93,11]);
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



module fanHolePattern(l){
    quad(20/2) cylinder(l, 1.5, 1.5);
    cylinder(l, 24.2/2, 24.2/2);
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
 

module assembly(){
    placeComponentAssembly()componentAssembly();    
    holder();
    filterClamp();
    sideWallA();
    sideWallB();
    topCover();
    bottomCover();
    placedEnclosureMountBase();
    placeEnclosureMount()enclosureMountFlerpAssembly();
    fanBracket();
}

//enclosureFlerp(30, 3, 34+8+3-0.7);

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
