//save game options
var button

///Animations button
button = ds_list_find_value(buttons, 0);
animations_on = button.value;

///Water button
button = ds_list_find_value(buttons, 1);
water_on = button.value;

///Jetpack button
button = ds_list_find_value(buttons, 2);
jetpack_on = button.value;

///Locked Door button
button = ds_list_find_value(buttons, 3);
locked_door_on = button.value;

///Difficulty slider
button = ds_list_find_value(buttons, 4);
difficulty = button.value;

//open file
ini_open("options.ini");
    
///Game options menu
section = string("gameOptions")
	
ini_section_delete(section);
ini_write_real(section, "animations_on", animations_on);
ini_write_real(section, "water_on", water_on)
ini_write_real(section, "jetpack_on", jetpack_on)
ini_write_real(section, "locked_door_on", locked_door_on)
ini_write_real(section, "difficulty", difficulty)

//close file
ini_close(); 
