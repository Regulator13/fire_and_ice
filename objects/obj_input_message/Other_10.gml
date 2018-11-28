/// @description Press button
//perform action
switch(actions[| actionSel]) {
	// switch to lobby menu
    case "lobby":
        scr_state_switch(global.Menu.state, STATE_LOBBY);
        break;
	
	//play button
    case "game":
        with(obj_menu) event_user(2);
        break;
	
    case "missions":
        with(obj_menu) event_user(1);
        break;
	
    case "mainOptions":
        with(obj_menu) event_user(4);
        break;
		
    case "options":
        with(obj_menu) event_user(5);
        break;
		
    case "debugOptions":
        with(obj_menu) event_user(6);
        break;
	
	//go from the debug menu to options menu
    case "optionsDebug":
        scr_state_switch(STATE_DEBUGOPTIONS, STATE_OPTIONS);
        break;
	
	// go from the control menu to the options menu
    case "mainControl":
        scr_state_switch(STATE_CONTROLS, STATE_MAIN);
        break;
		
    // go from the control menu to the options menu		
    case "optionsControl":
        scr_state_switch(STATE_CONTROLS, STATE_OPTIONS);
        break;
	
    case "addNickname":
        with(instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_input_button)) action = "addNickname";
        break;
	
    case "delNickname":
        with(instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_input_button)) action = "delNickname";
        break;
		
    case "delOptions":
        //delete file
        file_delete(obj_menu.gameMode + ".ini");
        game_restart();
        break;
		
    case "delMissions":
        //delete file
        file_delete("paths.ini");
        game_restart();
        break;
		
    case "delControls":
        //delete file
        file_delete("controls.ini");
        game_restart();
        break;
	
	//open controls menu
    case "controls":
        with(obj_menu) {
            scr_menu_init_controls();
            //reset selected
            selected = 0;
            }
        break;
		
    case "online":
        with(obj_menu) scr_menu_init_online();
        break;
		
	//host server
    case "createServer":
        global.InitObject.alarm[1] = 2;
        break;
		
	//connect to server directly
    case "directConnect":
        global.InitObject.alarm[2] = 2;
        break;
	
	//new path
    case "new":
        with(instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_input_button)) action = "createPath";
        break;
	
    case "backMainLobby":
        scr_state_switch(STATE_LOBBY, STATE_MAIN);
        break;
	
	// return to main menu from the online menu
    case "backMainOnline":
        scr_state_switch(STATE_ONLINE, STATE_MAIN);
        break;
	
	// return to online menu from the lobby
    case "backOnlineLobby":
        scr_state_switch(STATE_LOBBY, STATE_ONLINE);
        break;
	
	// return to online menu from the paths
    case "backOnlinePaths":
        scr_state_switch(STATE_PATHS, STATE_ONLINE);
        break;
	
	// return to online menu from the game
    case "backOnlineGame":
        scr_state_switch(STATE_GAME, STATE_ONLINE);
        break;
	
	// return to online menu from the score screen
    case "backOnlineScore":
        scr_state_switch(STATE_SCORE, STATE_ONLINE);
        break;
	
    // reset client disconnect buffer
    case "resetDisconnectBuffer":
        global.Client.alarm[0] = global.Client.disconnectBuffer;
        break;
	
	// reset networkPlayer drop buffer
    case "resetDropBuffer":
        Source.alarm[0] = Source.dropBuffer;
        break;
		
    case "dropPlayer":
        with (Source) event_user(1);
        break;
		
    case "restart":
        game_restart();
        break;
		
    case "quit":
        game_end();
        break;
}
