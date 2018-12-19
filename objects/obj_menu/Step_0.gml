/// @description Input

// check if game is paused
if !(instance_exists(obj_input_button)){
    var haxis = 0; //left or right
    var vaxis = 0; //up or down
    var action = false; //clicking
    var input; //gamepad input
    var axis_buffer = GAMEPAD_AXIS_TOL; //buffer till push starts counting
    
    //get input
    if (input_buffer < 0) {
        //judge input based on current state
        switch(state){
            case STATE_LOBBY:
				#region STATE_LOBBY
				
                if !(global.online){
                    //number of inputs to check
                    var inputs = array_height_2d(global.controls);
                    for (var i = 0; i < inputs; i++) {
                        //check for join input from players
                        switch (global.controls[i, KEY_TYPE]) {
                            case CONTROLS_KEYBOARD:
                            case CONTROLS_MOUSE:
                                if (keyboard_check_released(global.controls[i, ACTION2_KEY])) {
                                    //join lobby
                                    if (is_undefined(local_players[? i])) {
                                        local_players[? i] = instance_create_layer(0, 0, "lay_instances", obj_local_player);
                                        local_players[? i].controls = i;
										
                                        // update the controls
                                        ds_list_replace(local_controls, ds_list_size(local_controls)-1, i);
                                    }
                                    
									//leave lobby
									else {
                                        scr_join_lobby(local_players[? i]);
                                        instance_destroy(local_players[? i]);
                                        ds_map_delete(local_players, i);
                                    }
                                }
								
                                break;				
                            default:
                                //gamepad input
                                if (gamepad_button_check_released(global.controls[i, KEY_TYPE], global.controls[i, ACTION2_KEY])) {
                                    //join lobby
                                    if (is_undefined(local_players[? i])) {
                                        local_players[? i] = instance_create_layer(0, 0, "lay_instances", obj_local_player);
                                        local_players[? i].controls = i;
                                    }
                                    
									else {
                                        instance_destroy(local_players[? i]);
                                        ds_map_delete(local_players, i);
                                    }
                                }
								
                                break;
                        }
						
                        // check if local player is in
                        var Local = local_players[? i]
                        if (!is_undefined(Local) and instance_exists(Local)) {
                            // set up input
                            var haxis = scr_positive(Local.inputs[LEFT_KEY])*-1 + scr_positive(Local.inputs[RIGHT_KEY]);
                            var vaxis = scr_positive(Local.inputs[DOWN_KEY])*-1 + scr_positive(Local.inputs[UP_KEY]);
                            var playerIndex = ds_list_find_index(players, Local.connectID);
                            
                            // teams
                            var newTeam = scr_increment_in_bounds(ds_list_find_value(teams, playerIndex), vaxis, 0, team_max, true);
                            ds_list_replace(teams, playerIndex, newTeam);
							
                            // characters
                            var classValue = ds_list_find_value(classes, playerIndex);
                            var classIndex = scr_increment_in_bounds(ds_list_find_index(class_options, classValue), haxis, 0, ds_list_size(class_options)-1, true);
                            ds_list_replace(classes, playerIndex, ds_list_find_value(class_options, classIndex));
							
                            // ready up
                            if (Local.inputs[LEFTSELC_KEY]) {
                                ds_list_replace(readys, playerIndex, scr_toggle(ds_list_find_value(readys, playerIndex)));
                                Local.inputs[LEFTSELC_KEY] = scr_toggle_key(Local.inputs[LEFTSELC_KEY]);
                            }
                        }
                    }
					
                    // if there is a player in the lobby
                    if (ds_list_size(players)) {
                        // check for start
                        var start = true; // set to false if a player is not ready
                        
                        // check if any player is not ready
                        for(i = 0; i < ds_list_size(players); i++) {   
                            if !(ds_list_find_value(readys, i)) start = false;
                        }
                        
                        // start if all are ready
                        if (start) {
                            // start game
                            show_debug_message("All ready!");
                            
                            // switch to path menu
                            scr_state_switch(STATE_LOBBY, STATE_PATHS)
                        }
                    }
                }
				
                //press button
                if (action) {
                    //check if button exists
                    var button = ds_list_find_value(buttons, selected);
                    if (ds_list_size(buttons) > 0 and instance_exists(button)) {
                        with (button) {
							//peform the button's purpose
                            event_user(0);
                        }
                    }
                }
            
                break;
				#endregion
            case STATE_GAME:
                break; //no menu
            default: //other menus DOES NOT BREAK OUT!
				#region Get input
				//gamepad input
		        for (input = 0; input < 4; input++) {
		            var chaxis = gamepad_axis_value(input, gp_axislh);
		            var cvaxis = gamepad_axis_value(input, gp_axislv);
			
		            // axis check
		            if (chaxis > axis_buffer or chaxis < -axis_buffer) haxis = 1*sign(chaxis)
		            if (cvaxis > axis_buffer or cvaxis < -axis_buffer) vaxis = 1*sign(cvaxis)
			
		            // action
		            if(gamepad_button_check_released(input, gp_face1)) action = true;
		        }
        
		        //keyboard input
		        if (keyboard_check(vk_left) or keyboard_check(ord("A")) or keyboard_check(ord("J"))) haxis = -1;
		        if (keyboard_check(vk_right) or keyboard_check(ord("D")) or keyboard_check(ord("L"))) haxis = 1;
		        if (keyboard_check(vk_up) or keyboard_check(ord("W")) or keyboard_check(ord("I"))) vaxis = -1;
		        if (keyboard_check(vk_down) or keyboard_check(ord("S")) or keyboard_check(ord("K"))) vaxis = 1;
		        if (keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter)) action = true;  
        
				// reset buffer if got input
		        if (haxis != 0 or vaxis != 0 or action != false){
		            input_buffer = input_buffer_max;
				}
				#endregion
				#region Default
				
                //button controls
                var button = ds_list_find_value(buttons, selected);
                
                //selector
                if (!is_undefined(button)) {
					//if on value button limit changes of selection to only down and up to allow left and right to change value
                    if (instance_exists(button) and button.action == "value" or button.action == "valueAction"){
                        selected = scr_increment_in_bounds(selected, vaxis, 0, ds_list_size(buttons)-1, true);
					}
					//else allow any direction to change selected button
                    else{
                        selected = scr_increment_in_bounds(selected, haxis+vaxis, 0, ds_list_size(buttons)-1, true);
					}
                }
				//DESCR?
				else{
                    selected = scr_increment_in_bounds(selected, haxis+vaxis, 0, ds_list_size(buttons)-1, true);
				}
                                
                //DESCR?
                if (ds_list_size(buttons) > 0 and instance_exists(button)) {
                    if (button.action == "value") {
                        button.value = scr_increment_in_bounds(button.value, haxis, 0, ds_list_size(button.values)-1, true);
                    }
					
                    else if (button.action == "valueAction") {
                        button.value = scr_increment_in_bounds(button.value, haxis, 0, ds_list_size(button.values)-1, true);
                        // if value changed do action
                        if (haxis != 0)
                            with (button) event_user(1);
                    }
					
                    // press button
                    if (action) {
                        with (button) {
							//perform the button's action
                            event_user(0);
                        }
                    }
                }
				
				#endregion
			case STATE_PATHS:
				#region STATE_PATHS
				
                if (global.have_server) {
                    //select a button from the list of possible buttons with left and right controls
                    selected = scr_increment_in_bounds(selected, haxis, 0, ds_list_size(buttons)-1, true);
					
                    //select a path from the list of possible paths with up and down controls
                    path_selected = scr_increment_in_bounds(path_selected, vaxis, 0, ds_list_size(path_names)-1, true);
                    
                    //press button
                    if (action) {
                        //check if button exists
                        var button = ds_list_find_value(buttons, selected);
                        if (ds_list_size(buttons) > 0 and instance_exists(button)) {
                            with (button) {
								//perform the buttons action
                                event_user(0);
                            }
                        }
                    }
                }
				
                break;
				#endregion
        }
    }
	
    else input_buffer--;
}


/// client input
//REMOVE? Switch case with 1 case
switch(state) {
    case STATE_LOBBY:
        if(global.online and global.have_server) {
            var Server = obj_server;
			
            // check for client input
            var count = ds_list_size(Server.iplist); //total number of players
            var iplist = Server.iplist //store locally because it is called many times
            
            //check join key for each player
            for(i=0 ;i<count; i++) {   
                //get the ip
                var ip = ds_list_find_value(iplist,i);
        
                //get the player instance so that we can check it
                var inst = ds_map_find_value(Server.Clients, ip);
                
                // other input
                var playerIndex = ds_list_find_index(players, inst.connectID);

                // initiate input
                var vaxis = 0;
                var haxis = 0;
                
                // get input
                if (inst.inputs[UP_KEY] == KEY_PRESSED) {
                    vaxis = -1;
                    // unpress key
                    inst.inputs[UP_KEY] = scr_toggle_key(inst.inputs[UP_KEY]);
                }
				
                if (inst.inputs[DOWN_KEY] == KEY_PRESSED) {
                    vaxis = 1;
                    // unpress key
                    inst.inputs[DOWN_KEY] = scr_toggle_key(inst.inputs[DOWN_KEY]);
                }
				
                if (inst.inputs[LEFT_KEY] == KEY_PRESSED) {
                    haxis = -1;
                    // unpress key
                    inst.inputs[LEFT_KEY] = scr_toggle_key(inst.inputs[LEFT_KEY]);
                }
				
                if (inst.inputs[RIGHT_KEY] == KEY_PRESSED) {
                    haxis = 1;
                    // unpress key
                    inst.inputs[RIGHT_KEY] = scr_toggle_key(inst.inputs[RIGHT_KEY]);
                }
				
                if (inst.inputs[LEFTSELC_KEY] == KEY_PRESSED) {
                    ds_list_replace(readys, playerIndex, scr_toggle(ds_list_find_value(readys, playerIndex)));
                    // unpress key
                    inst.inputs[LEFTSELC_KEY] = scr_toggle_key(inst.inputs[LEFTSELC_KEY]);
                }
                
                // teams
                var newTeam = scr_increment_in_bounds(ds_list_find_value(teams, playerIndex), vaxis, 0, team_max, true);
                ds_list_replace(teams, playerIndex, newTeam);
				
                // characters
                var classValue = ds_list_find_value(classes, playerIndex);
                var classIndex = scr_increment_in_bounds(ds_list_find_index(class_options, classValue), haxis, 0, ds_list_size(class_options)-1, true);
                ds_list_replace(classes, playerIndex, ds_list_find_value(class_options, classIndex));
            }
			
			//REMOVE? Duplicate code to above, perhaps this should be a script, it would clean things up
            // if there is a player in the lobby
            if (ds_list_size(players)){
                // check for start
                var start = true; // set to false if a player is not ready
                
                // check if any player is not ready
                for(i = 0; i < ds_list_size(players); i++) {   
                    if !(ds_list_find_value(readys, i)) start = false;
                }
                
                // start if all are ready
                if (start) {
                    // start game
                    show_debug_message("All ready!");
                    
                    // switch to path menu
                    scr_state_switch(STATE_LOBBY, STATE_PATHS)
                }
            }
        }
}
