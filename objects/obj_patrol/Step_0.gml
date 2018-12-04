/// @description Turn around
event_inherited();

//Teleport out of obstacles if there's room for it.
if !place_free(x, y) and place_free(x + 4, y) and !place_free(x + sprite_width + 5, y + 1){
	x += 4
}
else if !place_free(x, y) and place_free(x - 4, y) and !place_free(x - sprite_width - 5, y + 1){
	x -= 4
}

//Set speed
hspeed = move_speed*dir

//Turn around
if(!place_free(x + move_speed, y) or place_free(x+sprite_width + move_speed, y + 1)){
	dir = -1
}

else if(!place_free(x - move_speed, y) or place_free(x - sprite_width - move_speed, y + 1)){
	dir = 1
}

if (!place_free(x + move_speed*2, y) or place_free(x + sprite_width + move_speed*2, y + 1)) and (!place_free(x - move_speed*2, y) or place_free(x - sprite_width - move_speed*2, y + 1)){
	hspeed = 0
}
