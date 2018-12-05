/// @function scr_num_pixels_touching_sides()
/// @description  checks how many pixels are in contact with a solid object on either side
/// @return  Int - number of pixels attached

var count = 0 //number of pixels touching

//Check for touching object on either side
for (var i=0; i<sprite_height; i++){
	if !position_empty(x + sprite_width + 2, y + i) or !position_empty(x - 2, y + i){
		count ++
	}
}
			
return count
