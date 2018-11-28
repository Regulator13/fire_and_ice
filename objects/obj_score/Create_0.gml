/// @description Destory if out of room
event_inherited();

if (x > room_width) instance_destroy();

///Destroy if on wall
if (place_meeting(x,y,obj_blockBig)) instance_destroy();
if (place_meeting(x,y,obj_wall)) instance_destroy();

///animate
if global.Menu.animations_on = true{
	image_speed = 0.5;
}

else{
	image_speed = 0
}
