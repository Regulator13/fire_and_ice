/// @description scr_menuInitPaths()
/*
/ Description: initiate the path menu
/ Parameters : none
/ Return     : void
*/

// set state
state = STATE_PATHS;

// create buttons
if (!global.online or (global.online and global.have_server)) {
    var button = instance_create_layer(room_width-96, room_height-32, "lay_instances", obj_button);
    button.action = "game";
    button.title = "play";
    ds_list_add(buttons, button);
    var button = instance_create_layer(room_width/2, room_height-32, "lay_instances", obj_button);
    button.action = "new";
    button.title = "new";
    ds_list_add(buttons, button);
    
    //load paths
    if (file_exists("paths.ini")) {
        //open file
        ini_open("paths.ini");
        
        //load path names
        str = ini_read_string("paths", "names", "");
        if (str != "") ds_list_read(path_names, str);
        
        //load paths data
        for (i = 0; i < ds_list_size(path_names); i++) {
            name = ds_list_find_value(path_names, i);
            
            ds_map_add(paths, name, ds_map_create());
            //path in path map
            path = ds_map_find_value(paths, name);
            //length
            ds_map_add(path, "length", ini_read_real("length", name, 0));
            //score
            ds_map_add(path, "score", ini_read_real("score", name, 0));
            //seeds
            str = ini_read_string("seeds", name, "");
            if (str != "") {
                seeds = ds_list_create();
                ds_list_read(seeds, str);
                ds_map_add(path, "seeds", seeds);
                } 
            }
        
        //destroy default lists
        
        //close file
        ini_close();
        }
        
    // check if any path exists
    if (ds_list_empty(path_names)) {
        //create tutorial path
        scr_createPath("First");
        global.tutorial = true;
        event_user(2);
        }
    }
