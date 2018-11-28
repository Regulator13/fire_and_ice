//save path
    //open file
    ini_open("paths.ini");
    
    //save paths
    section = "paths";
    ini_section_delete(section);
    ini_write_string(section, "names", ds_list_write(path_names));
    
    ini_section_delete("length");
    ini_section_delete("score");
    ini_section_delete("seeds");
    for (i = 0; i < ds_list_size(path_names); i++) {
        key = ds_list_find_value(path_names, i);
        path = ds_map_find_value(paths, key);
        
        if !(is_undefined(key)) {
            ini_write_real("length", key, ds_map_find_value(path, "length"));
            ini_write_real("score", key, ds_map_find_value(path, "score"));
            ini_write_string("seeds", key, ds_list_write(ds_map_find_value(path, "seeds")));
            }
        }
    
    //delete default lists
    //ds_list_clear(nicknamesDefault);
    
    //close file
    ini_close(); 
