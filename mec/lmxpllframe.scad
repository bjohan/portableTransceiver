use <transferSwitchAndMixerAssembly.scad>;
use <sp2t.scad>
use<cable.scad>
module cCube(v){
    x = -v[0]/2;
    y = -v[1]/2;
    translate([x, y, 0]) cube(v);
}

module quad2(x, y){
    translate([x, y , 0]) children();
    translate([x, -y , 0]) children();
    translate([-x, y , 0]) children();
    translate([-x, -y , 0]) children();
}
module x(d){
    translate([d,0,0]) children();
}

module y(d){
    translate([0,d,0]) children();
}

module z(d){
    translate([0,0,d]) children();
}

module smaClearance(){
    translate([0,0,1]) cCube([9,9, 15]);
}

module placeScrews(){
    translate([-49/2-2.5,8,0])children();
    translate([49/2+2.5,8,0])children();
    translate([-4, 49/2+2.5,0])children();
}

module frameBody(){
    difference(){
        cCube([51,51,4]);
        cCube([49,49,4]);
    }
    
    cCube([49,49,1]);
    translate([0,27/2, 0])cCube([49,49-27, 2.5 ]);
    
    difference(){
        placeScrews()cylinder(4,4, 4);
        cCube([49,49,4]);
    }
    
}

module frame(){
    difference(){
        frameBody();
        translate([0,0, 0]) cCube([40,40,3]);
        translate([0, -49/2,0]){
            translate([49/2, 23, 0])smaClearance();
            translate([-49/2, 23, 0])smaClearance();
            translate([49/2-2, 42, 0])smaClearance();
            translate([-49/2+2, 42, 0])smaClearance();
            
        }
        translate([-49/2, -49/2,0]){
            translate([11,49,0]) smaClearance();
            translate([30,49,0]) smaClearance();
        }
        placeScrews()cylinder(10,1.5,1.5);
    }

    
}

module hexGrid(l, r, s, nx, ny){
    f=cos(360/(6*2));
    sx=(2*r+s)*f;
    sy=sx*cos(30);
    for(j=[0:ny-1]){
        for(i=[0:nx-1]){
            offset=(j%2)*sx/2;
            %translate([sx*i, 0, 0]) rotate([0,0, 90]) cylinder(l, r, r, $fn=6);
            translate([sx*i+offset, sy*j, 0]) rotate([0,0, 90]) cylinder(l, r, r, $fn=6);
        }
    }
}

module centerHexGrid(r, s, nx, ny){
        f=cos(360/(6*2));
        sx=(2*r+s)*f;
        sy=sx*cos(30);
        if(ny == 1) translate(-[sx*(nx-1), sy*(ny-1), 0]/2) children();
        else translate(-[sx*(nx-0.5), sy*(ny-1), 0]/2) children();
}

module placeFanScrewHoles(){
    quad2(32/2, 32/2) children();
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
module fanInletHoles(l=10){
    x=9;
    y=11;
    intersection(){
        centerHexGrid(2, 1.2, x, y) hexGrid(l, 2, 1.2, x, y);
        cylinder(l, 38/2, 38/2);
    }
}


module fanFrameUnplaced(){
    s = 45;
    h = 25;
    t = 4;
    oh = 15+2;
    hd = 30;
    difference(){
        translate([0, -oh/2, 0]) cCube([s+2*t, s+2*t+oh, h+2*t]);
        translate([0, -oh/2, 0]) cCube([s, s+oh, h]);
        
        translate([0, 0, 20])fanInletHoles(l=30);
        cylinder(h+t,  38/2, 38/2);
        placeFanScrewHoles() cylinder(300, 1.5, 1.5);
        translate([0,0,44]) rotate([0,180,0]) placeScrews()cylinder(40,4, 4);
        translate([0,0,4]) rotate([0,180,0]) placeScrews()cylinder(40,1.5, 1.5);
    }
    
    translate([0,0,4])rotate([0,180,0]) difference(){
        placeScrews()cylinder(4,4, 4);
        placeScrews()cylinder(4,1.5,1.5);
    }
    
    difference(){
        translate([0, 0, -hd]){
            difference(){
                translate([0, -oh/2, 0]) cCube([s+2*t, s+2*t+oh, hd+1]);
                
                translate([0, -oh/2, 0]) cCube([s, s+oh, hd+2]);
                translate([0, -3/2, 0]) cCube([s+2*t, s+2*t+3+2, h+2*t*3]);
                
            }
            
        }
        translate([30,-30,-15-15-2])cCube([38, 6+2, 15]);
    }
}

module placeFanFrame(){
    translate([0, 0, -2])rotate([0,180,0]) children();
}

module fanFrame(){
    difference(){
        placeFanFrame() fanFrameUnplaced();
        placeTransferSwitchOnFanFrame() placeMontingBracketOnRelay411cj() placeMountingPlateHolePattern411cj() cylinder(10, 1.5, 1.5);
    }
}


module placeTransferSwitchOnFanFrame(){
    translate([-20,-60,-3])rotate([0,90,0]) children();
}

module roundedBlock(v, r){
    x=v[0]-2*r;
    y=v[1]-2*r;
    
    hull() quad(x, y) cylinder(v[2], r, r);
}


module placeBoxLidHolePattern(){
    quad(109.5, 84) children();
}

module boxBody(){
    hull(){
        roundedBlock([120.3, 94.2, 4], 5);
        roundedBlock([118, 92, 34], 5);
    }
}

module box(){
    difference(){
        boxBody();
        placeBoxLidHolePattern() cylinder(3,3.5,2);
    }
}

module boxSmall(){
    hull(){
        roundedBlock([90, 31, 5], 4);
        roundedBlock([89, 35.2 ,31.1], 4);
    }
}



module placeBox(){
    translate([0,17,32.1]) rotate([180,0,0])children();
}




module placeUsbHolePattern(){
    d=27.3/2;
    x(d) children();
    x(-d) children();
}

module usbBody(){
    cCube([20.5+0.5,14.2+0.5,25]);
    cCube([12,10.6,25+3]);
    z(20) hull() quad(24.5, 0) cylinder(5, 6,6);
    z(-5) cylinder(5, 9.4/2, 9.4/2);
}

module usb(){
    difference(){
        usbBody();
        placeUsbHolePattern() cylinder(30, 2,2);
    }
}

module placeUsb(){
    translate([-34,-9,22.55]) rotate([90,0,0])children();
}


module smaFemaleWithNut(){
    z(2)smaFemale();
    cylinder(0.5, 4.5, 4.5);
    z(0.5)cylinder(1.5, 4.5, 4.5, $fn=6);
}


module placeSmas(v=[true, true, true, true, true]){
    if(v[0]) translate([60-19,-29.5,15]) rotate([90,0,0])children();
    if(v[1])translate([59.5,-0.5,15]) rotate([0,90,0])children();
    if(v[2])translate([59.5, 33,15]) rotate([0,90,0])children();
    
    if(v[3])translate([-59.5,-0.5,15]) rotate([0,-90,0])children();
    if(v[4])translate([-59.5, 33,15]) rotate([0,-90,0])children();
}


module insulatedBanana(){
    cylinder(3.2, 7,7);
    intersection(){
        z(-20) cylinder(20,6.25,6.25);
        z(-20) cCube([11.5,13,20]);
    }
}

module placeInsulatedBananas(){
    translate([75/2,63.2,4.5+4.5]) rotate([-90,0,0]) rotate([0,0,90]) children();
    translate([-75/2,63.2,4.5+4.5]) rotate([-90,0,0]) rotate([0,0,-90]) children();
}

module foot(){
    cylinder(2, 12.5, 12.5);
}

module placeFeet(){
    placeBox() translate([0,0,-2])quad(86, 60) children();
}
module pllFeet(){
    placeFeet() foot();
}

module pllBox(){
    placeBox() box();
}


module sa9SmaConnector(){
    sx=13;
    sy = 9.6;
    r = (17.6-14)/2;
    cCube([sx, sy, 1.5 ]);
    cylinder(7.8, 6.3/2, 6.3/2);
    z(1.7)quad(9, 6) cylinder(2.6, 2, 2);
    
}

module placeSa9Connectors(v=[true, true]){
    s=[95.6, 29.5, 17];
    if(v[0]) translate([-s[0]/2, 1.5 , 4.2+9.6/2]) rotate([0, -90, 0]) rotate([0,0,90]) children();
    if(v[1]) translate([s[0]/2, 1.5 , 4.2+9.6/2]) rotate([0, 90, 0]) rotate([0,0,90]) children();
}
module sa9AmplifierBody(){
    s=[95.6, 29.5, 17];
    cCube(s);
    placeSa9Connectors() sa9SmaConnector();
    translate([-s[0]/2, 3.5-s[1]/2 , 5]) rotate([0, -90, 0]) rotate([0,0,90]) cylinder(9, 5.4/2, 5.4/2);
    translate([-s[0]/2, 3.5-s[1]/2 , 11]) rotate([0, -90, 0]) rotate([0,0,90]) cylinder(6, 4/2, 4/2);
}

module sa9Amplifier(){
    sa9AmplifierBody();
}

module placeSa9Amplifier(){
    translate([44, 17,-1.90]) rotate([0,0,90]) rotate([180,0,0])children();
}
module pllAssembly(withFan=true, withMixer=true){
    frame();
    
    if(withFan){
        fanFrame();
        placeFanFrame() translate([0,0,5])fan();
    }
    if(withMixer){
        placeTransferSwitchOnFanFrame() transferSwitch411cjAssembly();
    }
    pllBox();
    placeUsb() usb();
    placeSmas() smaFemaleWithNut();
    placeInsulatedBananas() insulatedBanana();
    pllFeet();
    placeSa9Amplifier() sa9Amplifier();
}


module bottomHousingBody(){
    hi=41;
    t = 2;
    roc=5;
    difference(){
        union(){
            hull() rotate([180,0,0]) placeBoxLidHolePattern() cylinder(hi+t, roc, roc);
            rotate([180,0,0]) placeBoxLidHolePattern() cylinder(hi+t, 7, 7);    
        }
        hull() rotate([180,0,0]) placeBoxLidHolePattern() cylinder(hi, roc-t, roc-t);
    }
    
}

module bottomHousing(){
    difference(){
        union(){
            difference(){
                union(){
                    placeBox() bottomHousingBody();
                    hull() placeSp2t() placeScrewHolesOnSp2t() z(13) cylinder(8,6,6);
                    inlet();
                    
                }
                inletHole();
                placeTransferSwitchAssembly()placeMontingBracketOnRelay411cj() placeMountingPlateHolePattern411cj() cylinder(20, 1.5, 1.5);
                placeSp2t() placeScrewHolesOnSp2t() z(13) cylinder(10,1.5,1.5);
                translate([-77, 22, 30]) cCube([40, 73, 38]);
                translate([70, 36.5, 30]) cCube([40, 25, 25]);
            }
            
            intersection(){
                placeBox() rotate([180,0,0]) placeBoxLidHolePattern() cylinder(3, 8, 8);
                hull() placeBox() rotate([180,0,0]) placeBoxLidHolePattern() cylinder(3, 5, 5);
            }
        }
        placeBox() rotate([180,0,0]) placeBoxLidHolePattern() cylinder(3, 2, 2);
        z(3) placeBox() rotate([180,0,0]) placeBoxLidHolePattern() cylinder(50, 4, 4);
        placeBottomInsulatedBananas() insulatedBanana();
        placeTransferSwitchAssembly() minkowski() {bracket411cj(); sphere(0.25);};
    }
    
}


module pllAssembly2(withFan=true, withMixer=true){
    frame();
    
    //if(withFan){
        fanFrame();
        placeFanFrame() translate([0,0,5])fan();
    //}
    //if(withMixer){
        //placeTransferSwitchOnFanFrame() transferSwitch411cjAssembly();
    //}
    pllBox();
    placeBox() bottomHousing();
    placeUsb() usb();
    placeSmas() smaFemaleWithNut();
    placeInsulatedBananas() insulatedBanana();
    //pllFeet();
    //placeScrews() rotate([180,0,0]) cylinder(300, 1.5, 1.5);
    //placeSa9Amplifier() sa9Amplifier();
    translate([-3, 0, 0]){
        translate([0+4,45-10, 32.1])sa9Amplifier();
        translate([-47.8+4, 40, 60-7]) rotate([0, 0, -0])  relaySp2t();
        translate([-47.8+4, -0, 50+3]) rotate([0, 0, 90]) rotate([90,0,0]){ 
            relay411cj();
            bracket411cj();
        }
    }
    
    
}

module placeTransferSwitchAssembly(){
    translate([-3, 0, -0.25]) translate([-47.8+4, -0, 50+3]) rotate([0, 0, 90]) rotate([90,0,0]) children();
}

module placeSp2t(){
    translate([-3, 0, 0]) translate([-47.8+4, 40, 60-7]) rotate([0, 0, -0]) children();
}

module placeSa9Amplifier(){
    translate([-3, 0, 0]) translate([0+4,45-10, 32.1]) rotate([0,0,180])children();
}

module assembly3BottomComponents(){
    placeTransferSwitchAssembly(){
        relay411cj();
        bracket411cj();
        
    }
    placeSp2t() relaySp2t();
    placeSa9Amplifier() sa9Amplifier();
}

module pllBoxAssembly(){
    pllBox();
    placeUsb() usb();
    placeSmas() smaFemaleWithNut();
    placeInsulatedBananas() insulatedBanana();
}

module placeBottomInsulatedBananas(){
    translate([75/2,64,60]) rotate([-90,0,0]) rotate([0,0,90]) children();
    translate([75/2-19.02,64,60]) rotate([-90,0,0]) rotate([0,0,-90]) children();
}


module bottomHousingAssembly(){
    bottomHousing();
    assembly3BottomComponents();
    placeBottomInsulatedBananas() insulatedBanana();
}

module fanAssembly(){
    frame();
    fanFrame();
    placeFanFrame() translate([0,0,5])fan();
}

module pllAssembly3(){
    fanAssembly();
    pllBoxAssembly();
    bottomHousingAssembly();
    cables();
}

module inletHole(){
    translate([0,-28.5+3,28.5]) cCube([53-6, 30, 46.6-2]);
}
module inlet(){
    difference(){
        translate([0,-28.5-7.5,28.5]) cCube([53, 15, 46.6]);
        inletHole();
        minkowski() {pllBox(); sphere(0.5);}
        minkowski() {placeUsb() usb(); sphere(0.5);}
        
    }
}


module placeMixerOnTransferSwitch(){
    placeRelay411cjSmas(v=[false, false, true, false]) translate([0,0,24+12.4]) rotate([0,90,0]) rotate([-135+20,0,0]) translate([0,0,-2.4]) children();
}




cableR=3.6/2;




module highPowerToSpdtCable(){
    cableSection(5, cableR, 10, 90, 202)cableSection(28, cableR, 10, 90, 0) cableSection(19.11, cableR, 10, 0, 0);
}

module sa9InputCable(){
    cableSection(5, cableR, 10, 90, -1) cableSection(6, cableR, 10, 90, 0) cableSection(16.8, cableR, 10, 0, 0);
}

module sa9OutputCable(){
    cableSection(5, cableR, 9, 90, 255)cableSection(1, cableR, 9, 90, 0)cableSection(5, cableR, 9, 0, 0);
}

module rfIfCableShort(){
    cableSection(12.4, cableR, 0, 0, 0);
}

module rfIfCableLong(){
    mixerBendR=8;
    inclination=10;
    cableSection(5, cableR, mixerBendR, 90, 45/4+180+inclination) cableSection(0, cableR, mixerBendR+3+1, 90, inclination) cableSection(0, cableR, mixerBendR+3+1, 90, inclination)  cableSection(0, cableR, mixerBendR, 90, inclination)cableSection(0, cableR, mixerBendR, 90, inclination)cableSection(20, cableR, mixerBendR, 0, 0);
}

module loCable(){
    mixerBendR=8;
    cableSection(5, cableR, mixerBendR, 90, 178) cableSection(32, cableR, mixerBendR, 90, 0) cableSection(51, cableR, mixerBendR, 0, 0);
}

module placeRfIfCableLong(){
    
    inclination=10;
    placeTransferSwitchAssembly() placeMixerOnTransferSwitch() placeMixerConnectors([true, false, false]) translate([0,0,10]) rotate([0,0,-inclination]) children();
}

module cables(){
    placeSmas([false, false, false, false, true]) translate([0,0,9]) highPowerToSpdtCable();
    placeSmas([false, false, true, false, false]) translate([0,0,9]) sa9InputCable();
    placeSa9Amplifier() placeSa9Connectors([false, true ]) translate([0,0,8]) sa9OutputCable();
    placeTransferSwitchAssembly() placeRelay411cjSmas(v=[false, false, true, false]) translate([0,0,7.1]) rfIfCableShort();
    placeTransferSwitchAssembly() placeMixerOnTransferSwitch() mixer();
    placeRfIfCableLong() rfIfCableLong();
    placeTransferSwitchAssembly() 
        placeMixerOnTransferSwitch() 
            placeMixerConnectors([false, false, true]) translate([0,0,10]) rotate([0,0,-10]) loCable();
}

//cableForm2() highPowerToSpdtCable($fn=10);
//cableForm2() sa9InputCable();
//cableForm2() sa9OutputCable();
//cableForm2() rfIfCableShort();
//cableForm2() rfIfCableLong();
//cableForm2() loCable();

//cables();
//placeTransferSwitchAssembly() translate([-12.9/2-4.1+2.4,12.9/2+1.6,-24-12.4]);

//placeTransferSwitchAssembly() translate([-12.9/2-4.1+2.4,12.9/2+1.6,-24-12.4]) rotate([0,90,0]) rotate([-45,0,0])translate([0,0,-2.4]) mixer();

//mixer();
//inlet();
//fanFrame();
//box();
//bottomHousing();

//placeBox() bottomHousingBody();
//placeSp2t() relaySp2t();
//placeSp2t() placeScrewHolesOnSp2t() z(13) cylinder(100,2,2);
//assembly3BottomComponents();
//bottomHousingAssembly();
pllAssembly3();
//frame();
//fanFrame();
//fanHolePattern();
//pllAssembly(withMixer=true, withFan=true);





