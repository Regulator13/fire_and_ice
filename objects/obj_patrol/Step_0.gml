/// @description Turn around
event_inherited();

//Turn around
if(!place_free(x+1,y) or place_free(x+sprite_width+1,y+1)){
	hspeed = -hspeed;
}

else if(!place_free(x-1,y) or place_free(x-sprite_width-1,y+1)){
	hspeed = -hspeed;
}
