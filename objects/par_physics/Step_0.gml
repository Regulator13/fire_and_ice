/// @description  @description Apply Physics

if (active) {
//set solid
if (!place_meeting(x, y, obj_character)) solid = true;
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

//Set Friction
if(!place_free(x+hspeed,y+1))
{
if (hspeed >= fric)
{hspeed -= fric;
}
else if (hspeed <= (-fric))
{hspeed += fric;
}
else if(abs(hspeed) < fric)
{hspeed = 0
}
}
}
else {
//set not solid
if (frozen) {
hspeed = 0;
vspeed = 0;
if (place_free(x, y)) solid = true;
}
else if !(stuck) solid = false;
}


