/// @description Destroy if floating

//die if no block below
if (place_free(x, y+1)) {
	instance_destroy()
}
