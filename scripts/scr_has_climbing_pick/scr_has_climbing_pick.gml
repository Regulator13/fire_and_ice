/// @function scr_has_climbing_pick()
/// @description Check whether the player has a climbing pick or not
/// @return bool

for (var i=0; i<ds_list_size(Equipped_objects); i++){
	if Equipped_objects[| i].object_index == obj_climbing_pick{
		return true
	}
}

return false
