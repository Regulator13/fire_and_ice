/// @description Set Variables
event_inherited()

hp = 5;
dmg = 0;

//destroy if outside of room
if (x > room_width){
	instance_destroy();
}

