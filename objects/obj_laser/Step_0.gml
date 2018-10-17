//find laser length

    for(var i=0; i<instance_number(obj_character); i++) {
        with (instance_find(obj_character,i)) if (abs(y - other.y) < 100) other.updateLaser = true;
        }
        
if (updateLaser) {
    laserX = x;
    while !(place_meeting(laserX-dir*0, y, par_block)) && !(place_meeting(laserX-dir*0, y, obj_character)) {
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
while (collision_line(x,y, laserX, y, par_block, false, true) || collision_line(x,y, laserX, y, obj_character, false, true)) {
    laserX -= dir;
    }
    
updateLaser = false;
alarm[0] = 10;
}
*/
    
with (instance_place(laserX + 1*dir, y, obj_character)) hp -= 2;
//with (instance_place(laserX + 1*dir, y, obj_block)) hp -= .01;

//die
if (hp < 0) instance_destroy();

/* */
///collisions
with(instance_place(x, y, obj_explosion)) {   
    other.hp -= damage;
    }

/* */
/*  */
