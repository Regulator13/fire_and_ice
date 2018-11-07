/// @description press button
switch(action) {
	//switch to lobby menu
    case "lobby":
        scr_stateSwitch(global.Menu.state, STATE_LOBBY);
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
        scr_stateSwitch(STATE_DEBUGOPTIONS, STATE_OPTIONS);
        break;
	
	// go from the control menu to the options menu
    case "mainControl":
        scr_stateSwitch(STATE_CONTROLS, STATE_MAIN);
        break;
		
    // go from the control menu to the options menu		
    case "optionsControl":
        scr_stateSwitch(STATE_CONTROLS, STATE_OPTIONS);
        break;
	
    case "addNickname":
        with(instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_inputButton)) action = "addNickname";
        break;
	
    case "delNickname":
        with(instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_inputButton)) action = "delNickname";
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
            scr_menuInitControls();
            //reset selected
            selected = 0;
            }
        break;
		
    case "online":
        with(obj_menu) scr_menuInitOnline();
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
        with(instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_inputButton)) action = "createPath";
        break;
	
    case "backMainLobby":
        scr_stateSwitch(STATE_LOBBY, STATE_MAIN);
        break;
	
	// return to main menu from the online menu
    case "backMainOnline":
        scr_stateSwitch(STATE_ONLINE, STATE_MAIN);
        break;
	
	// return to online menu from the lobby
    case "backOnlineLobby":
        scr_stateSwitch(STATE_LOBBY, STATE_ONLINE);
        break;
}

