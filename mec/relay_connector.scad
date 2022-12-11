pinWideLength=13.8;
pinWideWidth=1.8;
pinFlare=0.2;
pinNarrowLength = 6.1;
pinNarrowWidth = 1.0;
pinFlangeOffset=8.8;
pinFlangeLength=0.8;
pinFlangeWidth=2.2;
pinTol=0.15;
retainerTol = 0.3;

connectorPinBodyL=pinFlangeOffset;//pinWideLength;
connectorPinBodyR=20/2-0.15;

rinkHeight=10;
flangeHeight = 9;
flangeWidening = 6+1.5;

pinHolderThickness = 3;
pinHolderWall = 2;

 keyDepth = 0;

module pin(){
    $fn=8;
    cylinder(pinWideLength, pinWideWidth/2+pinFlare, pinWideWidth/2);
    translate([0,0,pinWideLength])cylinder(pinNarrowLength, pinNarrowWidth/2, pinNarrowWidth/2);
    translate([0,0,pinFlangeOffset])cylinder(pinFlangeLength, pinFlangeWidth/2, pinFlangeWidth/2);
}

module circularPattern(r, n, skip=[]){
    for(i = [0:1:n-1]){
        //echo(search(i,skip));
        if(search(i,skip)==[])
            rotate([0,0,-i*360/n]) translate([r,0,0]) children();
    }
}


module placePins(){
    circularPattern(14.3/2, 13, skip=[4, 6, 8, 10]) children();
    //circularPattern(14.5/2, 13) children();
    //circularPattern(7.5/2, 7) children();
    //children();
}

module connectorBody(){
    cylinder(connectorPinBodyL+2,connectorPinBodyR ,connectorPinBodyR);
}


module key(r,w, d,l){
    translate([r-d,-w/2,0])cube([d*2,w,l]);
}

module keys(){
   
    /*key(connectorPinBodyR,2.2,1,connectorPinBodyL);
    rotate([0,0,-95]) key(connectorPinBodyR,1.2,keyDepth,connectorPinBodyL);
    rotate([0,0,-95-50]) key(connectorPinBodyR,1.2,keyDepth,connectorPinBodyL);
    rotate([0,0,-90-45-90+5+1]) key(connectorPinBodyR,1.2,keyDepth,connectorPinBodyL);
    rotate([0,0,-90-45-90+5-34]) key(connectorPinBodyR,1.2,keyDepth,connectorPinBodyL);*/
}

module pins(){
    placePins()minkowski(){ pin(); sphere(pinTol);}
}
module pinBody(){
    difference(){
        connectorBody();
        pins();
    }
    rotate([0,0,127])keys();
}

module pinHull(l){
    cylinder(l, 14/2+pinFlangeWidth/2+pinTol,14/2+pinFlangeWidth/2+pinTol);
    //hull() pins();
}

module flange(){
    fcr = 0.5*(2*connectorPinBodyR+flangeWidening);
    difference(){
        cylinder(flangeHeight+2, connectorPinBodyR+1.6, connectorPinBodyR+flangeWidening);
        pinHull(30);
        circularPattern(fcr, 6)cylinder(30, 1.5, 1.5);
    }
}

module connectorUpper(){
    translate([0,0,connectorPinBodyL]){
        difference(){
            cylinder(rinkHeight-connectorPinBodyL+4,connectorPinBodyR+keyDepth,connectorPinBodyR+keyDepth+3);
            pinHull(30);
        }
        translate([0,0,rinkHeight-connectorPinBodyL]){
           flange();
        }
    }
}

module pinHolderBase(){
     th = rinkHeight-connectorPinBodyL+flangeHeight+0.1;
    
     ro = 21.5/2+pinFlangeWidth/2+pinTol+pinHolderWall;
     cylinder(pinHolderThickness, 21.5/2+pinFlangeWidth/2+pinTol,21.5/2+pinFlangeWidth/2+pinTol);
     translate([0,0,pinHolderThickness])
     cylinder(pinHolderThickness, 21.5/2+pinFlangeWidth/2+pinTol,21.5/2+pinFlangeWidth/2+pinTol+pinHolderWall);
     translate([0,0,pinHolderThickness*2]){
         difference(){
            cylinder(th-2*pinHolderThickness,ro,ro);
             cylinder(th-2*pinHolderThickness,ro-pinHolderWall,ro-pinHolderWall);
         }
     }
}

module pinHolder(){
    difference(){
        //cylinder(pinHolderThickness, 21.5/2+pinFlangeWidth/2+pinTol,21.5/2+pinFlangeWidth/2+pinTol);
        pinHolderBase();
        translate([0,0,-pinFlangeOffset-2])pins();
        placePins()cylinder(10,0.8, 0.8, $fn=10);
    }
    
    
}

module upper(){
    difference(){
        //connectorUpper();
        translate([0,0,connectorPinBodyL+2]){
            minkowski(){
                pinHolder();
                cylinder(0.1,retainerTol, retainerTol);
            }
            
        }
    }
}

module connectorHouseBody(){
     fcr = 0.5*(2*connectorPinBodyR+flangeWidening);
    difference(){
        union(){
            pinBody();
            upper();
        }
        circularPattern(fcr, 6)cylinder(300, 1.5, 1.5);
         translate([0,0,connectorPinBodyL])placePins()cylinder(10,1.6, 1.6, $fn=10);
    }
}

module placeScrews(){
    translate([connectorPinBodyR+2, 0, 4.8]) children();  
    translate([-connectorPinBodyR-2, 0, 4.8]) children(); 
}
module alternativeBody(){
    pinBody();
    placeScrews() difference(){ cylinder(6, 3,3); cylinder(6, 3/2,3/2);} 
    
    
}

//connectorUpper();
alternativeBody();
//pinHull(30);
//connectorHouseBody();

//pinHull();
//cylinder(flangeHeight, connectorPinBodyR, connectorPinBodyR+flangeWidening);

//pinHolder();
//translate([0,0,connectorPinBodyL]) 




