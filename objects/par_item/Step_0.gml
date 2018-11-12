/// @description Apply Physics

if (active){
	
	// Apply gravity (and jumping)
	if (vspeed < gravity_max) {
		vspeed += gravity_incr;
			
		//keep gravity in bounds
		if (vspeed > gravity_max) vspeed = gravity_max;
	}

	//collide with solid objects
    while(!place_free(x+hspeed, y)){
        hspeed = scr_reduce(hspeed);
		
        if hspeed = 0 break;
    }
	
    while(!place_free(x+hspeed,y+vspeed)){
        vspeed = scr_reduce(vspeed);
		
        if vspeed = 0 break;
    }

	//Set Friction
	if(!place_free(x+hspeed,y+1)){
		if (hspeed >= fric){
			hspeed -= fric;
		}
			
		else if (hspeed <= (-fric)){
			hspeed += fric;
		}
			
		else if(abs(hspeed) < fric){
			hspeed = 0
		}
	}
}

else{
	//set not solid
	if (frozen) {
		hspeed = 0;
		vspeed = 0;
	}
}