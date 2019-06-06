lcell = 184;
rcell = 42/2;
rwall = 37/2;
cellYPos = (rcell*2+65);
height = 100-11;

module tolerance(){
    minkowski(){
        children();
        cylinder(0.1,0.5,0.5);
    }
}

module nObj(r, n, offs){
    for(a=[1:n]) rotate([0,0, offs+a*360/n]) translate([r,0,0]) children();
}


module centerCylinder(r, l){
    rotate([0,90,0])translate([0,0,-l/2])cylinder(l,r,r);
}

module centerCube(v){
    translate([-v[0]/2,-v[1]/2,0]) cube(v);
}


module cellOutline(){
    cylinder(lcell, rcell, rcell);
}

module threeCells(){
    nObj(24, 3, 0)
    cellOutline();
    cylinder(lcell, 60/2, 60/2);
}

module placedCells(){
    translate([0,cellYPos,24+21])rotate([0,90,0])threeCells();
}

module boxOutline(){
    translate([0,rwall,rwall])rotate([0,90,0])cylinder(184, rwall, rwall);
    translate([0,rwall,0]) cube([lcell, cellYPos-rwall, rwall]);
    translate([0,0,rwall]) cube([lcell, cellYPos-rwall*0, height-rwall]);
}

module boxHull(){
translate([10,10,10])
difference(){
    boxOutline();
    translate([0,85,70]) cube([lcell, cellYPos-rwall, height-rwall]);
    translate([1,0,0]) placedCells();
    translate([-1,0,0]) placedCells();
}
}
module boxOuterShell(){
    difference(){
    minkowski(){
        boxHull();
        //sphere(2);
        centerCylinder(2.4,2.4);
    }
    boxHull();
}
}


module boxOuterShellOpen(){
    difference(){
    minkowski(){
        boxHull();
        //sphere(2);
        centerCylinder(2.4,2.4);
    }
    minkowski(){
            boxHull();
            centerCylinder(0.01,5);
        }
}
}

module boxShell(){
    intersection(){
        minkowski(){
            boxOuterShell();
            //sphere(2.4);
            centerCylinder(2.4,2.4);
        }
        boxHull();
    }
}


module boxShellOpen(){
    difference(){
    intersection(){
        minkowski(){
            boxOuterShellOpen();
            //sphere(2.4);
            centerCylinder(2.4,2.4);
            
        }
        
            boxHull();
        
    }
    /*minkowski(){
            boxHull();
            centerCylinder(0.01,5);
        }*/
    }
}



module panelReg(){
    centerCube([79,43,2]);
    translate([0,0,-23]) centerCube([72,39,34-11]);
    translate([0,0,-34]) centerCube([72,39-8,34]);
    translate([0,0,-12]) centerCube([76,14,12]);
}

module highPowerRegBody(){
    centerCube([70,41,32]);
}

module highPowerReg(){
    difference(){
        highPowerRegBody();
        highPowerHolePattern(3/2, 3);
    }
}


module highPowerHolePattern(r, l){
    translate([68/2, -4.5,0])cylinder(l,r,r);
    translate([-68/2, 2,0])cylinder(l,r,r);
}

module placedPanelRegulators(){
    so = 7;
    translate([40+so,25+20,height])panelReg();
    translate([40+82+7+so,25+20,height])panelReg();
}


module switch(){
    translate([0,0,-27])cylinder(27,16/2,16/2);
    cylinder(11,23/2,23/2);
}

module placedSwitches(){
    /*translate([30,11,height])switch();
    translate([30+30,11,height])switch();*/
    so = 7;
    translate([40+so,11,height])switch();
    translate([40+82+7+so,11,height])switch();
}

module bananaPlug(){
    cylinder(13,11/2,11/2);
    translate([0,0,-20]) cylinder(20,5/2,5/2);
}

module placeBananaPlugs(){
    so = 7;
    translate([40+so-30,11,height])children();
    translate([40+so+30,11,height])children();
    translate([40+82+7+so+30,11,height])children();
    translate([40+82+7+so-30,11,height])children();
    
    //translate([30+60,11,height])children();
    //translate([30+30+60,11,height])children();
}

module placedBananaPlugs(){
    placeBananaPlugs() bananaPlug();
}

module endCapHoles(){
    translate([5,0,rwall+18]) rotate([0,0,90]) centerCylinder(3/2,30);
    translate([5,50,93]) rotate([0,0,90]) centerCylinder(3/2,130);
}


module powerHousing(){
    difference(){
        union(){
            translate([-10,-10,-10]) boxShellOpen();
            translate([00,0,89-3]) cube([100, 84, 2.4]);
            //Strengthening bar for screw holes
            translate([0,2.4,50+2.4]) cube([lcell-20, 10, 10]);
            highPowerRegConsole();
            
        }
        minkowski(){
        union(){
            
            tolerance() placedPanelRegulators();
            tolerance() placedSwitches();
            tolerance() placedBananaPlugs();
            
        }
        cylinder(0.1,0.6,0.6);
        }
        for(i=[0:7]) translate([10+i*20,0,50+2.4+5]) rotate([0,0,90]) centerCylinder(3/2,30);
        endCapHoles();
        translate([lcell-10,0,0]) endCapHoles();
        
        placeHighPowerReg() translate([0,0,-10])highPowerHolePattern(3/2, 10);
        
    }
    
    //Bottom shelf and board guides
    translate([0,0,25]) cube([lcell-60, 82.5, 2.4]);
    translate([0,0,25+2.4*2+0.5]) cube([lcell-60, 5, 2.4]);
    translate([0,74,25+2.4*2+0.5]) cube([lcell-60, 5, 2.4]);
    
    
}

module bms(){
    cube([115,70,20]);
}

module placeBms(){
    translate([10, 12,4]) children();
}
    

module placeHighPowerReg(){
    translate([150, 38, 8]) rotate([-8,0,0])rotate([0,0,90]) children();
}

module highPowerRegConsole(){
    intersection(){
    difference(){
    placeHighPowerReg() translate([0,0,-15])highPowerRegBody();
        minkowski(){
      placeHighPowerReg() highPowerRegBody();
            cylinder(0.1, 2,2);
        }
    }
    translate([-10,-10, -10])boxHull();
    }
}



module relayHoles(r, l){
    translate([0,-13-5,13])rotate([0,90,0])translate([0,0,-l])cylinder(2*l,r,r);
    translate([0,+13+5,4])rotate([0,90,0])translate([0,0,-l])cylinder(2*l,r,r);
    translate([0,+13+5,26-4])rotate([0,90,0])translate([0,0,-l])cylinder(2*l,r,r);
}

module relayBody(){
    
    translate([0,-13,0]){
    cube(26);
    difference(){
        translate([4,-9,0])cube([9,9,26]);
        translate([4+1,-9-1,0])cube([9,9,26]);
    }
    difference(){
        translate([4,26,0])cube([9,9,26]);
        translate([4+1,27,0])cube([9,9,26]);
    }
}
}

module relay(){
    difference(){
        relayBody();
        relayHoles(3/2, 50);
    }
}

module relayBracket(){
    difference(){
        translate([5,-25,0]) cube([15, 50,26]);
        tolerance() relayBody();
        relayHoles(3/2, 30);
    }
}

module placeRelay(){
    translate([30,48-12,0]) rotate([0,0,90]) children();
}

module grid(nx, ny, sx, sy){
    for(i=[0:nx-1])
        for(j=[0:ny-1])
            translate([i*sx, j*sy, 0]) children();
}

module testGrid(){
translate([15+45, 6, 0]) grid(5, 5, 15,15)children();
translate([15, 6, 0]) grid(3, 2, 15,15)children();
}

module electronicsTrayBody(){
    placeRelay() relayBracket();
    testGrid() cylinder(6,3, 3);
  cube([125, 74, 2]);

}

module 5(){
    difference(){
        electronicsTrayBody();
        tolerance() placeRelay() relayBody();
        testGrid() cylinder(6,3/2, 3/2);
    }
}

//relayBracket();
//relay();
//relayHoles(3/2,10);
//placeRelay() relay();
electronicsTray();


//bananaPlug();
//placeBms() bms();

//placeHighPowerReg() highPowerReg();

//rotate([0,90,0]) powerHousing();


//boxHull();

//boxOutline();
/*rotate([0,90,0])
intersection(){
    boxShell();
    translate([50,0,0])
    cube([40, 150, 150]);
}*/

//centerCylinder(2.4, 10);


//placedPanelRegulators();
//placedSwitches();
//placedBananaPlugs();
//highPowerReg();
//boxHull();