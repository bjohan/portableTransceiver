module centerCube(v){
    translate([-v[0]/2,-v[1]/2,0]) cube(v);
}

module nObj(r, n, offs){
    for(a=[1:n]) rotate([0,0, offs+a*360/n]) translate([r,0,0]) children();
}

module quad(d){
    nObj(sqrt(2)*d, 4, 45) children();
}

module quad2(x,y){
    translate([x,y,0]) children();
    translate([x,-y,0]) children();
    translate([-x,y,0]) children();
    translate([-x,-y,0]) children();
}

module zt(z){
    translate([0,0,z]) children();
}

module xt(x){
    translate([x,0,0]) children();
}

module yt(y){
    translate([0,y,0]) children();
}

module zr(z){
    rotate([0,0,z]) children();
}

module xr(x){
    rotate([x,0,0]) children();
}

module yr(y){
    rotate([0,y,0]) children();
}
