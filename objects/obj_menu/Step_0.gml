/// @description input

// check if game is paused
if !(instance_exists(obj_inputButton)) {
    // intitiate input
    // haxis - left or right
    var haxis = 0;
    // vaxis - up or down
    var vaxis = 0;
    // action - clicking
    var action = false;
    
    // gamepad input
    var input;
    // axis_buffer - buffer till push starts counting
    var axis_buffer = 0.4;
    
    // get input
    if (input_buffer < 0) {
        // gamepad input
        for (input = 0; input < 4; input++) {
            haxis = gamepad_axis_value(input, gp_axislh);
            vaxis = gamepad_axis_value(input, gp_axislv);
            // axis check
            if (haxis < axis_buffer and haxis > -axis_buffer) haxis = 0;
            if (vaxis < axis_buffer and vaxis > -axis_buffer) vaxis = 0;
            // action
            if(gamepad_button_check_released(input, gp_face1)) action = true;
            }
        
        // keyboard input
        if (keyboard_check(vk_left) || keyboard_check(ord("A")) || keyboard_check(ord("J"))) haxis = -1;
        if (keyboard_check(vk_right) || keyboard_check(ord("D")) || keyboard_check(ord("L"))) haxis = 1;
        if (keyboard_check(vk_up) || keyboard_check(ord("W")) || keyboard_check(ord("I"))) vaxis = -1;
        if (keyboard_check(vk_down) || keyboard_check(ord("S")) || keyboard_check(ord("K"))) vaxis = 1;
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) action = true;  
        
        // judge input based on current state
        switch(state) {
            case STATE_PATHS:
                if (!global.online || global.online && global.haveserver) {
                    // selector
                    selected = scr_incrementInBounds(selected, haxis, 0, ds_list_size(buttons)-1, true);
                    // path selector
                    pathSelected = scr_incrementInBounds(pathSelected, vaxis, 0, ds_list_size(pathNames)-1, true);
                    
                    //press button
                    if (action) {
                        //check if button exists
                        var button = ds_list_find_value(buttons, selected);
                        if (ds_list_size(buttons) > 0 && instance_exists(button)) {
                            with (button) {
                                event_user(0);
                                }
                            }
                        }
                    }
                // reset buffer if got input
                if (haxis != 0 || vaxis != 0 || action != false)
                    input_buffer = input_buffer_max;
                break;
            case STATE_LOBBY:
                if !(global.online) {
                    // join input
                    var inputs = array_height_2d(global.controls);
                    for (i = 0; i < inputs; i++) {
                        // check for join input
                        switch (global.controls[i, KEY_TYPE]) {
                            case CONTROLS_KEYBOARD:
                            case CONTROLS_MOUSE:
                                if (keyboard_check_released(global.controls[i, ACTION2_KEY])) {
                                    // join lobby
                                    if (is_undefined(localPlayers[? i])) {
                                        localPlayers[? i] = instance_create_layer(0, 0, "lay_instances", obj_localPlayer);
                                        localPlayers[? i].controls = i;
                                        // update the controls
                                        ds_list_replace(localControls, ds_list_size(localControls)-1, i);
                                        }
                                    else {
                                        // leave lobby
                                        scr_joinLobby(localPlayers[? i]);
                                        instance_destroy(localPlayers[? i]);
                                        ds_map_delete(localPlayers, i);
                                        }
                                    }
                                break;
                            default:
                                // gamepad input
                                if (gamepad_button_check_released(global.controls[i, KEY_TYPE], global.controls[i, ACTION2_KEY])) {
                                    // join lobby
                                    if (is_undefined(localPlayers[? i])) {
                                        localPlayers[? i] = instance_create_layer(0, 0, "lay_instances", obj_localPlayer);
                                        localPlayers[? i].controls = i;
                                        }
                                    else {
                                        instance_destroy(localPlayers[? i]);
                                        ds_map_delete(localPlayers, i);
                                        }
                                    }
                                break;
                            }
                        // check if local player is in
                        var Local = localPlayers[? i]
                        if (!is_undefined(Local) && instance_exists(Local)) {
                            // set up input
                            var haxis = Local.inputs[LEFT_KEY]*-1 + Local.inputs[RIGHT_KEY];
                            var vaxis = Local.inputs[UP_KEY]*-1 + Local.inputs[DOWN_KEY];
                            var playerIndex = ds_list_find_index(players, Local.connectID);
                            
                            // teams
                            var newTeam = scr_incrementInBounds(ds_list_find_value(teams, playerIndex), vaxis, 0, teamMax, true);
                            ds_list_replace(teams, playerIndex, newTeam);
                            // characters
                            var classValue = ds_list_find_value(classes, playerIndex);
                            var classIndex = scr_incrementInBounds(ds_list_find_index(classOptions, classValue), haxis, 0, ds_list_size(classOptions)-1, true);
                            ds_list_replace(classes, playerIndex, ds_list_find_value(classOptions, classIndex));
                            // ready up
                            if (Local.inputs[LEFTSELC_KEY]) {
                                ds_list_replace(readys, playerIndex, scr_toggle(ds_list_find_value(readys, playerIndex)));
                                Local.inputs[LEFTSELC_KEY] = scr_toggleKey(Local.inputs[LEFTSELC_KEY]);
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
                            event_user(1);
                            }
                        }
                    }
                //press button
                if (action) {
                    //check if button exists
                    var button = ds_list_find_value(buttons, selected);
                    if (ds_list_size(buttons) > 0 && instance_exists(button)) {
                        with (button) {
                            event_user(0);
                            }
                        }
                    }
            
                break;
            case STATE_GAME:
                break; // do nothing
            default:
                //button controls
                var button = ds_list_find_value(buttons, selected);
                
                // selector
                if (!is_undefined(button)) {
                    if (instance_exists(button) && button.action == "value" || button.action == "valueAction")
                        selected = scr_incrementInBounds(selected, vaxis, 0, ds_list_size(buttons)-1, true);
                    else
                        selected = scr_incrementInBounds(selected, haxis+vaxis, 0, ds_list_size(buttons)-1, true);
                    }
                else
                    selected = scr_incrementInBounds(selected, haxis+vaxis, 0, ds_list_size(buttons)-1, true);
                                
                //check if button exists
                if (ds_list_size(buttons) > 0 && instance_exists(button)) {
                    // check if value button
                    if (button.action == "value") {
                        // adjust value
                        button.value = scr_incrementInBounds(button.value, haxis, 0, ds_list_size(button.values)-1, true);
                        }
                    else if (button.action == "valueAction") {
                        // adjust value
                        button.value = scr_incrementInBounds(button.value, haxis, 0, ds_list_size(button.values)-1, true);
                        // if value changed do action
                        if (haxis != 0)
                            with (button) event_user(1);
                        }
                    // press button
                    if (action) {
                        with (button) {
                            event_user(0);
                            }
                        }
                    }
                // reset buffer if got input
                if (haxis != 0 || vaxis != 0 || action != false)
                    input_buffer = input_buffer_max;
                break;
            }
        }
    else input_buffer--;
    }


/// client input
switch(state) {
    case STATE_LOBBY:
        if(global.online && global.haveserver) {
            var Server = obj_server;
            // check for client input
            var count = ds_list_size(Server.iplist);
            var iplist = Server.iplist //store locally because it is called many times
            
            // check join key
            for(i=0;i<count;i++) {   
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
                    inst.inputs[UP_KEY] = scr_toggleKey(inst.inputs[UP_KEY]);
                    }
                if (inst.inputs[DOWN_KEY] == KEY_PRESSED) {
                    vaxis = 1;
                    // unpress key
                    inst.inputs[DOWN_KEY] = scr_toggleKey(inst.inputs[DOWN_KEY]);
                    }
                if (inst.inputs[LEFT_KEY] == KEY_PRESSED) {
                    haxis = -1;
                    // unpress key
                    inst.inputs[LEFT_KEY] = scr_toggleKey(inst.inputs[LEFT_KEY]);
                    }
                if (inst.inputs[RIGHT_KEY] == KEY_PRESSED) {
                    haxis = 1;
                    // unpress key
                    inst.inputs[RIGHT_KEY] = scr_toggleKey(inst.inputs[RIGHT_KEY]);
                    }
                if (inst.inputs[LEFTSELC_KEY] == KEY_PRESSED) {
                    ds_list_replace(readys, playerIndex, scr_toggle(ds_list_find_value(readys, playerIndex)));
                    // unpress key
                    inst.inputs[LEFTSELC_KEY] = scr_toggleKey(inst.inputs[LEFTSELC_KEY]);
                    }
                
                // teams
                var newTeam = scr_incrementInBounds(ds_list_find_value(teams, playerIndex), vaxis, 0, teamMax, true);
                ds_list_replace(teams, playerIndex, newTeam);
                // characters
                var classValue = ds_list_find_value(classes, playerIndex);
                var classIndex = scr_incrementInBounds(ds_list_find_index(classOptions, classValue), haxis, 0, ds_list_size(classOptions)-1, true);
                ds_list_replace(classes, playerIndex, ds_list_find_value(classOptions, classIndex));
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
                    event_user(1);
                    }
                }
            }
    }

