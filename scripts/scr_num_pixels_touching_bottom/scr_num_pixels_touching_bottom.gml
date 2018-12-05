/// @function scr_num_pixels_touching_bottom()
/// @description  checks how many pixels are in contact with a solid object on the bottom
/// @return  Int - number of pixels attached

var count = 0 //number of pixels touching

//Check for touching object on either side
for (var i=0; i<sprite_width; i++){
	if !position_empty(x + i, y + sprite_height + 1){
		count ++
	}
}
			
return count
