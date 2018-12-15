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

///Recharge Frequency slider
button = ds_list_find_value(buttons, 5);
recharge_frequency = button.value;

///Water Delay slider
button = ds_list_find_value(buttons, 6);
starting_water_delay = button.value;

///Water Rate slider
button = ds_list_find_value(buttons, 7);
starting_water_rate = button.value;

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
ini_write_real(section, "recharge_frequency", recharge_frequency)
ini_write_real(section, "starting_water_delay", starting_water_delay)
ini_write_real(section, "starting_water_rate", starting_water_rate)


//close file
ini_close(); 
