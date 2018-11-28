/// @description press button
switch(action) {
	/*
    case "addNickname":
        with(instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_inputButton)) action = "addNickname";
        break;
	
    case "delNickname":
        with(instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_inputButton)) action = "delNickname";
        break;
	*/
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
	
	//quit
	case "quit":
		game_end();
		break;
	
	//universal back button
	case "back":
		scr_stateSwitch(global.Menu.state, ds_stack_top(global.Menu.state_queue))
		break
		
	//universal state switch button
	default:
		scr_stateSwitch(global.Menu.state, action)
		break
}

