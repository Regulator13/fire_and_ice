/// @description Set variables
event_inherited();

///Stats
dmg = 0;
can_attack = true
attack_delay = 5


///Choose a direction
var count_left = 0
var count_right = 0
var grid_size = 32
//find right side distace to nearest obstacle
for (i=0; i<(room_width - x) / grid_size; i++){
	count_right += 1
	if !place_free(x + i * grid_size, y){
		break
	}
}

//find left side distance to nearest obstacle
for (i=0; i<x / grid_size; i++){
	count_left += 1
	if !place_free(x - i * grid_size, y){
		break
	}
}

//Set direction
if count_right > count_left{
	dir = 1
}

else dir = -1

///Animation
image_speed = 0;
//face right if facing right (default left)
if dir = 1{
	image_index = 1
}
