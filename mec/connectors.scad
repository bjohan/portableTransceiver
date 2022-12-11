use <util.scad>

module smaFemale(threadedL, totalL){
    cylinder(threadedL, 6.3/2, 6.3/2);
    cylinder(totalL, 4.8/2, 4.8/2);
}


module tncFemale(threadedL, totalL){
    cylinder(threadedL, 11/2, 11/2);
    cylinder(totalL, 9.8/2, 9.8/2);
}

module nFemale(neckL, totalL){
    xr(180) zt(-totalL){
        cylinder(8.5, 14.2/2, 14.2/2);
        zt(1.6) cylinder(4.5, 15.8/2, 15.8/2);
        //cylinder(threadedL, 11/2, 11/2);
        cylinder(totalL, 9.8/2, 9.8/2);
        zt(8.5) cylinder(totalL-8.5, 16/2, 16/2);
    }
}

module nMale(){
    cylinder(17, 19.5/2, 19.5/2);
    zt(4.5) cylinder(10.5, 20.2/2, 20.2/2);
}

module bananaFemale(){
    cylinder(4,6,6);
    zt(-28)cylinder(28,4,4);
    zt(-1) hull() {
        cylinder(1,1,1);
        xt(5)cylinder(1,1,1,$fn=10);
    }
}

module smaMale(){
    r=8/cos(360/12)/2;
    cylinder(8.3, 7.8/2, 7.8/2);
    cylinder(6, r, r, $fn=6);
}

smaMale();
//bananaFemale();
//nFemale(11,19);