/// @description Set variables
//Set is_locked if the player has that option on
if global.Menu.locked_door_on is_locked = true
else is_locked = false

///Animation
if is_locked{
	sprite_index = spr_door_locked
}
image_speed = 0;
imageOpen = 7; //image where door is fully open
imageSpeed = .5; //animation speed when opening and closing
imageMax = 13; //number of frames
