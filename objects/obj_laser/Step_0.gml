/// @description Update laser
//set update laser if within 100 px
for(var i=0; i<instance_number(obj_character); i++) {
    with (instance_find(obj_character,i)){
		if (abs(y - other.y) < 100){
			other.updateLaser = true;
		}
	}
}
       
//update the laser
if (updateLaser) {
    laserX = x;
	
    while !(place_meeting(laserX-dir*0, y, par_block)) and !(place_meeting(laserX-dir*0, y, obj_character)){
        laserX += dir*4;
    }
	
    updateLaser = false;
}

/*
switch (dir) {
    case -1: //left
        laserX = 0;
        break;
    case 1: //right
        laserX = room_width;
        break;
    }
*/

/*
while (collision_line(x,y, laserX, y, par_block, false, true) or collision_line(x,y, laserX, y, obj_character, false, true)) {
    laserX -= dir;
    }
    
updateLaser = false;
alarm[0] = 10;
}
*/

//hurt the player
if laser_on{
	with (instance_place(laserX + 1*dir, y, obj_character)) hp -= 2;
}

//die
if (hp < 0) instance_destroy();

//destroy
with(instance_place(x, y, obj_explosion)) {   
    other.hp -= damage;
}
