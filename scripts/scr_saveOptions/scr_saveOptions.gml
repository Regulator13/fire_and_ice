//save options
button = ds_list_find_value(buttons, 0);
gameMode = ds_list_find_value(button.values, button.value);

    //open file
    ini_open("options.ini");
    
    //save data
    section = "default";
    
    ini_section_delete(section);
    ini_write_string(section, "gameMode", gameMode);
    
    //close file
    ini_close(); 
