module quad(x, y){
    translate([x, y , 0]) children();
    translate([x, -y , 0]) children();
    translate([-x, y , 0]) children();
    translate([-x, -y , 0]) children();
}

module roundedCorners(v, r){
    x = v[0];
    y = v[1];
    z = v[2];
    x2=x/2-r;
    y2=y/2-r;
    hull() quad(x2, y2) cylinder(z, r, r);
}


module lid(){
    difference(){
        roundedCorners([120,94,4], 3, $fn=20);
        quad(109.5/2,84/2) cylinder(10,2,2);
        translate([0, 0, 2])quad(109.5/2,84/2) cylinder(3,2,5);
    }
}

module fanHolePattern(r=1.5, l=10){
    cylinder(l, 38/2, 38/2);
    quad(32/2, 32/2) cylinder(l,r,r);
}


module centerHexGrid(r, s, nx, ny){
        f=cos(360/(6*2));
        sx=(2*r+s)*f;
        sy=sx*cos(30);
        if(ny == 1) translate(-[sx*(nx-1), sy*(ny-1), 0]/2) children();
        else translate(-[sx*(nx-0.5), sy*(ny-1), 0]/2) children();
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

module circleGrid(l, r, s, nx, ny, cr){
    f=cos(360/(6*2));
    sx=(2*r+s)*f;
    sy=sx*cos(30);
    for(j=[0:ny-1]){
        for(i=[0:nx-1]){
            offset=(j%2)*sx/2;
            %translate([sx*i, 0, 0]) rotate([0,0, 90]) cylinder(l, cr, cr, $fn=6*3);
            translate([sx*i+offset, sy*j, 0]) rotate([0,0, 90]) cylinder(l, cr, cr, $fn=6*3);
        }
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

module fanInletHolesCircle(l=10, cr){
    x=9;
    y=11;
    intersection(){
        centerHexGrid(2, 1.2, x, y) circleGrid(l, 2, 1.2, x, y, cr);
        cylinder(l, 38/2, 38/2);
    }
}


//fanHolePattern();
module lidVentilatedHex(){
    difference(){
        lid();
        translate([0,0,2])fanHolePattern();
        fanInletHoles();
        quad(32/2, 32/2) cylinder(10,1.5,1.5);
        translate([0,37,0])centerHexGrid(3, 1.2, 15, 2) hexGrid(10, 3, 1.2, 15,2);
        translate([20,-37,0])centerHexGrid(3, 1.2, 6, 2) hexGrid(10, 3, 1.2, 6,2);
    }
}

module lidDrillTemplateCenter(){
        difference(){
        lid();
        translate([0,0,2])fanHolePattern();
        fanInletHolesCircle(10, 1);
        quad(32/2, 32/2) cylinder(10,1.5,1.5);
        translate([0,37,0])centerHexGrid(3, 1.2, 15, 2) circleGrid(10, 3, 1.2, 15,2, 1);
        translate([20,-37,0])centerHexGrid(3, 1.2, 6, 2) circleGrid(10, 3, 1.2, 6,2, 1);
    }
}

module lidDrillTemplateLarge(){
        difference(){
        lid();
        //translate([0,0,2])fanHolePattern();
        fanInletHolesCircle(10, 1.75);
        quad(32/2, 32/2) cylinder(10,1.5,1.5);
        translate([0,37,0])centerHexGrid(3, 1.2, 15, 2) circleGrid(10, 3, 1.2, 15,2, 2.5);
        translate([20,-37,0])centerHexGrid(3, 1.2, 6, 2) circleGrid(10, 3, 1.2, 6,2, 2.5);
    }
}

module fanSpacer(){
difference(){
roundedCorners([40,40,3], 3, $fn=20);
    fanHolePattern();
}
}

module fanGrill(){
difference(){
    roundedCorners([40,40,4], 3, $fn=20);
    fanInletHoles(10, 1.75);
    quad(32/2, 32/2) cylinder(10,1.5,1.5);
    translate([0,0,2])fanHolePattern();
}
}
fanGrill();
//lidVentilatedHex();
//lidDrillTemplateCenter();
//lidDrillTemplateLarge();