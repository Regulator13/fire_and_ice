// Apply gravity (and jumping)
if (arc) {
    if (vspeed < gravity_max) {
        //gravity increment
        vspeed += gravityI;
        //keep gravity in bounds
        if (vspeed > gravity_max) vspeed = gravity_max;
        }
    }


