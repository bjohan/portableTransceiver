module cCube(v){
    x = -v[0]/2;
    y = -v[1]/2;
    translate([x, y, 0]) cube(v);
}

module quad(x, y){
    translate(0.5*[x, y , 0]) children();
    translate(0.5*[x, -y , 0]) children();
    translate(0.5*[-x, y , 0]) children();
    translate(0.5*[-x, -y , 0]) children();
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

module placeSmaOnSp2t(){
    d=11.1;
    z(13/2) {
        rotate([0,-90,0]) children();
        y(d) rotate([0,-90,0]) children();
        y(-d) rotate([0,-90,0]) children();
    }
}

module placeScrewHolesOnSp2t(){
    r=3.2/2;
    d1 = 14.3/2-r;
    d2 = 36.7/2-r;
    l1=0.8+r;
    l2=2+r;
    translate([l1, d1, 0]) children();
    translate([l1, -d1, 0]) children();
    translate([l2, d2, 0]) children();
    translate([l2, -d2, 0]) children();
}

module relaySp2tBody(){
    r = 1.5;
    d = [32, 35, 13];
    d2 = [6, 38.2, 13];
    x(d2[0]/2+d[0]/2)z(r){
        hull(){
            quad(d[0]-2*r, d[1]-2*r) sphere(r, $fn=8);
            z(d[2]-2*r)quad(d[0]-2*r, d[1]-2*r) sphere(r, $fn=8);
        }
    }
    x(d2[0]/2) cCube(d2);
    placeSmaOnSp2t()cylinder(7.5, 3.2, 3.2);
}
module relaySp2t(){
    difference(){
        relaySp2tBody();
        placeScrewHolesOnSp2t() cylinder(20, 1.6, 1.6, $fn=10);
    }
}


relaySp2t();