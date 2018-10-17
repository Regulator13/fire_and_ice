/// @description destory if out of room
if (x > room_width) instance_destroy();

///Destroy if on wall
if (place_meeting(x,y,obj_blockBig)) instance_destroy();
if (place_meeting(x,y,obj_wall)) instance_destroy();

event_inherited();


///animate
image_speed = 0.5;

