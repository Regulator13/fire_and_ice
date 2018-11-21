/// @description  scr_stateSwitch(from, to)
/// @param from
/// @param  to
/*
/ Description: switches the current menu state to the new state
/ Script Call: scr_stateSwitch(from, to)
/ Parameters : from - id of state to switch from
/              to - id of state to switch to
/ Return     : void
*/

// set input
var from = argument0;
var to = argument1;

// switch menu state
with (global.Menu) {
	//check if going back one state
	if ds_stack_top(state_queue) = to
		ds_stack_pop(state_queue)//delete last entry
	else
		ds_stack_push(state_queue, from)//add new entry
	
	//set state
	state = to;

	//switch state
    switch (from) {
        case STATE_MAIN:
            switch (to) {
                case STATE_LOBBY:
                    // clear preivous menu
                    scr_menuClear();
                    
                    // initiate lobby menu
                    scr_menuInitLobby(from);
                    
                    // join player
                    local_players[? 0] = instance_create_layer(0, 0, "lay_instances", obj_localPlayer);
                    local_players[? 0].controls = 0;
                    break;
				case STATE_OPTIONS:
					// clear preivous menu
                    scr_menuClear();
                    
                    // initiate options menu
                    scr_menuInitOptions();
					
					break;
				case STATE_ONLINE:
					// clear preivous menu
                    scr_menuClear();
                    
                    // initiate menu
                    scr_menuInitOnline();
					
					break;
                }
        case STATE_CONTROLS:
            switch (to) {
                case STATE_CONTROLS:
                    // return to options menu
                    scr_menuClear();
                    
                    // save controls
                    scr_saveControls();
                    
                    // initiate controls menu
                    scr_menuInitControls();
                    break;
                case STATE_OPTIONS:
                    // return to options menu
                    scr_menuClear();
                    
                    // save controls
                    scr_saveControls();
                    
                    // initiate options menu
                    scr_menuInitOptions();
                    break;
                case STATE_MAIN:
                    // clear previous menu
                    scr_menuClear();
                    
                    // save controls
                    scr_saveControls();
                    
                    // initiate main menu
                    scr_menuInitMain();
                    break;
                }
            break;
        case STATE_ONLINE:
            switch (to) {
                case STATE_LOBBY:
                    // clear preivous menu
                    scr_menuClear();
                    
                    // initiate lobby menu
                    scr_menuInitLobby(from);
                    
                    break;
                case STATE_MAIN:
                    // delete obj_online
                    instance_destroy(global.InitObject);
					// go offline
					global.online = false;
                    
                    // clear previous menu
                    scr_menuClear();
                    
                    // initiate main menu
                    scr_menuInitMain();
                    break;
                }
            break;
			
		case STATE_OPTIONS:
            switch (to) {
				case STATE_MAIN:
					//save options
					scr_saveOptions();
					
					// clear preivous menu
                    scr_menuClear();
					
					// initiate main menu
                    scr_menuInitMain();
					
					break;
					
                case STATE_GAME_OPTIONS:
                    // clear preivous menu
                    scr_menuClear();
                    
                    // initiate lobby menu
                    scr_menuInitGameOptions();
                    
                    break;
				
				case STATE_DEBUGOPTIONS:
                    // clear preivous menu
                    scr_menuClear();
                    
                    // initiate debug options menu
                    scr_menuInitDebugOptions();
                    
                    break;
				
				case STATE_CONTROLS:
                    // clear preivous menu
                    scr_menuClear();
                    
                    // initiate debug options menu
					scr_menuInitControls();
					
					break;
			}
            break;
			
		case STATE_GAME_OPTIONS:
            switch (to) {
                case STATE_OPTIONS:
					//save the changes
					scr_saveGameOptions()
					
                    // clear preivous menu
                    scr_menuClear();
					
                    // initiate lobby menu
                    scr_menuInitOptions();
                    
                    break;
			}
            break;
			
        case STATE_LOBBY:
            switch (to) {
                case STATE_MAIN:
                    // clear previous menu
                    scr_menuClear();
                    
                    // drop players
                    with (obj_menu) event_user(0);
                    
                    // initiate main menu
                    scr_menuInitMain();
                    break;
                case STATE_ONLINE:
                    // destroy online objects
                    if (global.have_server) // check if hosting
                        instance_destroy(obj_server);
                    instance_destroy(obj_client);
                    
                    // initiate online menu
                    scr_menuInitOnline();
                    break;
				case STATE_PATHS:
					// clear preivous menu
                    scr_menuClear();
					
					// initiate path menu
					scr_menuInitPaths();
					
					break;
                }
            break;
        case STATE_PATHS:
            switch (to) {
				case STATE_GAME:
					event_user(2);
					break;
                case STATE_ONLINE:
                    // destroy online objects
                    if (global.have_server) // check if hosting
                        instance_destroy(obj_server);
                    instance_destroy(obj_client);
                    
                    // initiate online menu
                    scr_menuInitOnline();
                    break;
                }
            break;
        case STATE_GAME:
            switch (to) {
                case STATE_SCORE:
                    // initiate score menu
                    scr_menuInitScore();
                    break;
                case STATE_ONLINE:
                    // goto menu screen
                    room_goto(mnu_main);
                    
                    // destroy online objects
                    if (global.have_server) // check if hosting
                        instance_destroy(obj_server);
                    instance_destroy(obj_client);
                    
                    // initiate online menu
                    scr_menuInitOnline();
                    break;
                }
            break;
        case STATE_SCORE:
            switch (to) {
                case STATE_GAME:
                    // clear previous menu
                    scr_menuClear();
                    
                    // set menu state
                    global.Menu.state = STATE_GAME;
                    
                    // goto score screen
                    room_goto(rm_level);
                    
                    break;
                case STATE_ONLINE:
                    // goto menu screen
                    room_goto(mnu_main);
                    
                    // destroy online objects
                    if (global.have_server) // check if hosting
                        instance_destroy(obj_server);
                    instance_destroy(obj_client);
                    
                    // initiate online menu
                    scr_menuInitOnline();
                    break;
                }
            
            break;
        case STATE_DEBUGOPTIONS:
            switch (to) {
                case STATE_OPTIONS:
                    // clear previous menu
                    scr_menuClear();
                    
                    //save options
                    //button = ds_list_find_value(buttons, 0);
                    //deactivateOutside = ds_list_find_value(button.values, button.value);
                    //button = ds_list_find_value(buttons, 1);
                    //yallVehicleCircles = ds_list_find_value(button.values, button.value);
                    //button = ds_list_find_value(buttons, 2);
                    //supplyPackValue = ds_list_find_value(button.values, button.value);

                    //open file
                    ini_open("options.ini");
                    
                    //save data
                    section = "debug";
                    
                    ini_section_delete(section);
                    //ini_write_string(section, "deactivateOutside", deactivateOutside);
                    //ini_write_string(section, "yallVehicleCircles", yallVehicleCircles);
                    //ini_write_real(section, "supplyPackValue", supplyPackValue);
                    
                    //delete default lists
                    //ds_list_clear(nicknamesDefault);
                    
                    //close file
                    ini_close(); 
    
                    // initate options menu
                    scr_menuInitOptions();
                    break;
                }
            
            break;
        }
    }
