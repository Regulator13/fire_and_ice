//save game options
var button

///Animations button
button = ds_list_find_value(buttons, 0);
animations_on = button.value;

///Water button
button = ds_list_find_value(buttons, 1);
water_on = button.value;

//open file
ini_open("options.ini");
    
///Game options menu
section = string("gameOptions")
	
ini_section_delete(section);
ini_write_real(section, "animations_on", animations_on);
ini_section_delete(section);
ini_write_real(section, "water_on", water_on)

//close file
ini_close(); 
