/// @description Physics
//Apply gravity
if (vspeed < gravity_max) {
	vspeed += gravity_incr;
			
	//keep gravity in bounds
	if (vspeed > gravity_max) vspeed = gravity_max;
}

//collide with solid objects
while(!place_free(x+hspeed, y)) {
    hspeed = scr_reduce(hspeed);
	
    if hspeed = 0 break;
}

while(!place_free(x+hspeed,y+vspeed)){
    vspeed = scr_reduce(vspeed);
	
    if vspeed = 0 break;
}
