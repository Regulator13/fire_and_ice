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

//Be pulled or pushed
if being_pulled{
	//Move with player unless going into a solid object
	if place_free(x + Puller.hspeed, y){
		hspeed = Puller.hspeed
	}
	
	//When the player is not nearby, stop moving with the player
	if (not place_meeting(x + GRAB_TOL, y, Puller)) and (not place_meeting(x - GRAB_TOL, y, Puller)){
		hspeed = 0
		Puller = noone
		being_pulled = false
	}
}
