use <util.scad>
use <connectors.scad>



module kAndLSmaFilter(bodyl=114, bodyr=12.8/2){
    translate(-[0,0,7.5+bodyl/2]){
        smaFemale(6, 7.5);
        zt(7.5){
            cylinder(bodyl, bodyr, bodyr);
            zt(bodyl){
                zt(7.5){
                    xr(180){
                        smaFemale(6, 7.5);
                    }
                }
            }
        }
    }
}

module kAndL3300_1800(){
    kAndLSmaFilter(bodyl=114);
}

module kAndL2010_1180(){
    kAndLSmaFilter(bodyl=114);
}

module kAndL1300_600(){
    kAndLSmaFilter(bodyl=140);
}

module kAndL865_530(){
    kAndLSmaFilter(bodyl=166);
}

module kAndL482_10(){
    kAndLSmaFilter(bodyl=115);
}

module kAndL462d5_10(){
    kAndLSmaFilter(bodyl=115);
}

module kAndL505_10(){
    kAndLSmaFilter(bodyl=109);
}

module kAndL150Lp(){
    kAndLSmaFilter(bodyl=108, bodyr=19.2/2);
}

module cirqtel4500Lp(){
    kAndLSmaFilter(bodyl=54.5, bodyr=7.4/2);
}

module cirqtel492_50(){
    kAndLSmaFilter(bodyl=124, bodyr=13/2);
}

module rlc1182_50(){
    kAndLSmaFilter(bodyl=96, bodyr=12.8/2);
}


module rlc2100Lp(){
    kAndLSmaFilter(bodyl=105, bodyr=12.8/2);
}

module nFilter(endL, endR, bodyr, totalL, neckL=11, nFemaleL=19){
    zt(-17-neckL-totalL/2){
        nMale();
        zt(17){
            cylinder(totalL, bodyr, bodyr);
            cylinder(endL, endR, endR);
            zt(totalL-endL)cylinder(endL, endR, endR);
            zt(totalL)nFemale(neckL, nFemaleL);
        }
    }
}

module singer6000Hp(){
    nFilter(17, 19/2, 11.2/2, 85);
}

module singer3000Hp(){
    nFilter(17, 19/2, 11.2/2, 61);
}

module singer8300Lp(){
    nFilter(0, 0, 13.2/2, 144, nFemaleL=20, neckL=12);
}

module singer3000Lp(){
    nFilter(0, 0, 13.2/2, 140, nFemaleL=20, neckL=12);
}

module telonic154d8_43(){
    bodyl=130.2;
     kAndLSmaFilter(bodyl=bodyl, bodyr=19/2);
    zt(12.8+0*7.5-bodyl/2)centerCube([22.2, 22.2, 6.4]);
    zt(130.2+0*7.5-6.4-12.8-bodyl/2)centerCube([22.2, 22.2, 6.4]);
}

module telonic350_200(){
    zt(-11-199/2){
        tncFemale(8, 11);
        zt(11){
            cylinder(199, 14.5/2, 14.5/2);
            zt(7) cylinder(199-2*7, 19.2/2, 19.2/2);
        }
        zt(11+199)xr(180)zt(-11)tncFemale(8, 11);
    }
}

module ewt600Lp(){
    smaFemale(6, 7.5);
    zt(7.5) centerCube([19, 11.3, 38.3]);
    zt(7.5+38.3)xr(180)zt(-7.5)smaFemale(6, 7.5);
}

module ewt1000_100(){
    smaFemale(6, 7.5);
    zt(7.5) centerCube([9.7, 9.7, 51]);
    zt(7.5+51)xr(180)zt(-7.5)smaFemale(6, 7.5);
}

module kAndLBandpass3200_to_6000(){
    bodyr=6.4/2;
    bodyl=76;
    zt(-7.5-bodyl/2){
        smaFemale(6, 7.5);
        zt(7.5){
            cylinder(bodyl, bodyr, bodyr);
            zt(bodyl){
                smaMale();
            }
        }
    }
}


module lp2000(){
    kAndLSmaFilter(bodyl=104.6);
}

module smaFemaleOnFlange(){
    w=12.8;
    smaFemale(6, 7.5);
    translate([0,0,7.5]){
        translate(-[w,w,0]/2) cube([w,w,1.6]);
        translate([-(w/2-2), -(w/2-2), -1.8]) cylinder(1.8, 2,2);
        translate([-(w/2-2), (w/2-2), -1.8]) cylinder(1.8, 2,2);
        translate([(w/2-2), -(w/2-2), -1.8]) cylinder(1.8, 2,2);
        translate([(w/2-2), (w/2-2), -1.8]) cylinder(1.8, 2,2);
    }
}

module time6to19(){
    w=12.8;
    d=20.7;
    h=32.1;
    translate(-[0, 0, 7.5+1.6+h/2]){
        smaFemaleOnFlange();
        translate([-w/2, -w/2, 7.5+1.6])cube([d, w, h]);
        translate([0, 0, 2*(7.5+1.6)+h])rotate([180,0,0])smaFemaleOnFlange();
    }
}

module allPass(){
    translate([0,0,-50]) cylinder(100, 2.5/2, 2.5/2);
}

module all(){
    translate([0,20,0]) ewt1000_100();
    translate([0,40,0]) ewt600Lp();
    translate([0,60,0]) telonic350_200();
    translate([0,80,0]) telonic154d8_43();
    translate([0,100,0]) singer3000Lp();
    translate([0,120,0]) singer8300Lp();
    translate([0,140,0]) singer3000Hp();
    translate([0,160,0]) singer6000Hp();
    translate([0,180,0]) rlc2100Lp();
    translate([0,200,0]) rlc1182_50();
    translate([0,220,0]) cirqtel492_50();
    translate([0,240,0]) cirqtel4500Lp();
    translate([0,260,0]) kAndL150Lp();
    translate([0,280,0]) kAndL505_10();
    translate([0,300,0]) kAndL462d5_10();
    translate([0,320,0]) kAndL482_10();
    translate([0,340,0]) kAndL865_530();
    translate([0,360,0]) kAndL1300_600();
    translate([0,380,0]) kAndL2010_1180();
    translate([0,400,0]) kAndL3300_1800();
    translate([0,420,0]) lp2000();
    translate([0,440,0]) kAndLBandpass3200_to_6000();
    translate([0,460,0]) time6to19();
    translate([0,480,0]) allPass();
}

all();