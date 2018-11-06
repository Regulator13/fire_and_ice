/// @description Apply gravity
// Apply gravity
if (arc) {
    if (vspeed < gravity_max) {
        vspeed += gravity_incr;
		
        //keep gravity in bounds
        if (vspeed > gravity_max) vspeed = gravity_max;
    }
}


