/// @description Physics

// Apply gravity (and jumping)
if (vspeed < gravityMax) {
	//gravity increment
	vspeed += gravityI;
			
	//keep gravity in bounds
	if (vspeed > gravityMax) vspeed = gravityMax;
	}

//collide with solid objects
while(!place_free(x+hspeed, y)) {
    hspeed = scr_reduce(hspeed);
    if hspeed = 0 break;
}
while(!place_free(x+hspeed,y+vspeed))
{
    vspeed = scr_reduce(vspeed);
    if vspeed = 0 break;
}