/// @description Initialize variables
event_inherited();

///Stats
hspeed = 3;
dmg = 10;
can_attack = true
attack_delay = 20

///Animation
image_speed = 0;

//destroy if outside of room
if (x > room_width){
	instance_destroy();
}

