/// @description Change to missions menu

//clear buttons
for (var i = 0; i < ds_list_size(buttons); i++) {
    with(ds_list_find_value(buttons, i)){
		instance_destroy();
	}
}

ds_list_clear(buttons);

// initiate path menu
scr_menuInitPaths();
