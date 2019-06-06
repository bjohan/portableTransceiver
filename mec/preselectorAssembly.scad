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

module sp6t(){
    cylinder(42.5, 20, 20);
    translate([0,0,-9])
    cylinder(9, 11.1, 11.1);
    translate([0,0,42.5]){
        difference(){
        centerCube([45, 45,3]);
        quad(35/2) cylinder(10, 3/2, 3/2);
        }
        translate([0,0,3]){
            nObj(13, 6, 0) cylinder(8, 6.5/2, 6.5/2);
            cylinder(8, 6.5/2, 6.5/2);
        }
    }
}

module smaConnector(){
    cylinder(8, 6.5/2, 6.5/2);
    centerCube([16, 6, 3.5]);
}

module yigFilter(){
    difference(){
    centerCube(36*[1,1,1]);
        quad(28.5/2) cylinder(10, 3/2, 3/2);
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

module rectangularRfComponents(){
        relays();
        yigFilters();
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

//switchHolder();

rotate([0,90,0]) sideWall();


//rectangularBody();



//rectangularLid();

//rectangularRfComponents();
