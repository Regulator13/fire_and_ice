// Apply gravity (and jumping)
if (arc) {
    if (vspeed < gravityMax) {
        //gravity increment
        vspeed += gravityI;
        //keep gravity in bounds
        if (vspeed > gravityMax) vspeed = gravityMax;
        }
    }


