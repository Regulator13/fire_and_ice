/// @description Turn around
event_inherited();

//Teleport out of obstacles if there's room for it.
if !place_free(x, y) and place_free(x + 4, y) and !place_free(x + sprite_width + 5, y + 1){
	x += 4
}
else if !place_free(x, y) and place_free(x - 4, y) and !place_free(x - sprite_width - 5, y + 1){
	x -= 4
}

//Turn around
if(!place_free(x+1,y) or place_free(x+sprite_width+1,y+1)){
	hspeed = -hspeed;
}

else if(!place_free(x-1,y) or place_free(x-sprite_width-1,y+1)){
	hspeed = -hspeed;
}
