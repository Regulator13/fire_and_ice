/// @description Break jetpack if under water

// Inherit the parent event
event_inherited();

//Break jetpack underwater
if working{
	if y > (room_height-obj_wall.sprite_height-obj_control.water_height){
		image_index = 2
		working = false
	}
}