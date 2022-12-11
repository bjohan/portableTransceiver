id=6.5;
od=10;//id+5;

ll=od*0.8;
hd=od*1.3;
hb=ll*0.6;
cl=ll*0.5;
eh=2;
hh=hd*0.35 /* 0.1 to 0.4 */;

$fn=40;

module gland()difference(){

    union(){
        intersection(){
            translate([0,0,hh])sphere(d=hd);
            translate([-hd/2,-hd/2,0])cube([hd,hd,hh],false);
        }
        rotate([0,0,180])translate([-od/2,-(od+eh-od/2),hh])cube([od,od+eh-od/2,ll/2]);
        translate([0,0,hh])cylinder(ll,d=od);
    }
    translate([0,0,-1])cylinder(ll+hd,d=id);
}

module cut()translate([-id/2,0,-1])cube([id,hd*0.6,ll+hd]);

difference(){
    gland();
    cut();
}

translate([0,hd/2+2,0])intersection(){
    gland();
    cut();
}

translate([hd+2,0,0]){
    difference(){
        cylinder(cl,d=hd);
        translate([0,0,-1])cylinder(cl*2,d=od);
    }
}


//translate([-od/2,-(od+eh-od/2),hh])cube([od,od+eh-od/2,ll]);