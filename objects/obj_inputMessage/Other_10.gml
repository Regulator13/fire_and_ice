/// @description press button
switch(actions[| actionSel]) {
    case "lobby":
        // switch to lobby menu
        scr_stateSwitch(global.Menu.state, STATE_LOBBY);
        break;
    case "game":
        //play button - switch button
        with(obj_menu) event_user(2);
        break;
    case "missions":
        //play button - switch button
        with(obj_menu) event_user(1);
        break;
    case "mainOptions":
        //play button - switch button
        with(obj_menu) event_user(4);
        break;
    case "options":
        //play button - switch button
        with(obj_menu) event_user(5);
        break;
    case "debugOptions":
        //play button - switch button
        with(obj_menu) event_user(6);
        break;
    case "optionsDebug":
        // fo from the debug menu to options menu
        scr_stateSwitch(STATE_DEBUGOPTIONS, STATE_OPTIONS);
        break;
    case "mainControl":
        // go from the control menu to the options menu
        scr_stateSwitch(STATE_CONTROLS, STATE_MAIN);
        break;
    case "optionsControl":
        // go from the control menu to the options menu
        scr_stateSwitch(STATE_CONTROLS, STATE_OPTIONS);
        break;
    case "addNickname":
        //add nickname
        with(instance_create(room_width/2, room_height/2, obj_inputButton)) action = "addNickname";
        break;
    case "delNickname":
        //add nickname
        with(instance_create(room_width/2, room_height/2, obj_inputButton)) action = "delNickname";
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
    case "controls":
        //open controls menu
        with(obj_menu) {
            scr_menuInitControls();
            //reset selected
            selected = 0;
            }
        break;
    case "online":
        //open controls menu
        with(obj_menu) scr_menuInitOnline();
        break;
    case "createServer":
        //host server
        global.InitObject.alarm[1] = 2;
        break;
    case "directConnect":
        //host server
        global.InitObject.alarm[2] = 2;
        break;
    case "new":
        //new path
        with(instance_create(room_width/2, room_height/2, obj_inputButton)) action = "createPath";
        break;
    case "backMainLobby":
        // return to main menu from the online menu
        scr_stateSwitch(STATE_LOBBY, STATE_MAIN);
        break;
    case "backMainOnline":
        // return to main menu from the online menu
        scr_stateSwitch(STATE_ONLINE, STATE_MAIN);
        break;
    case "backOnlineLobby":
        // return to online menu from the lobby
        scr_stateSwitch(STATE_LOBBY, STATE_ONLINE);
        break;
    case "backOnlinePaths":
        // return to online menu from the lobby
        scr_stateSwitch(STATE_PATHS, STATE_ONLINE);
        break;
    case "backOnlineGame":
        // return to online menu from the lobby
        scr_stateSwitch(STATE_GAME, STATE_ONLINE);
        break;
    case "backOnlineScore":
        // return to online menu from the lobby
        scr_stateSwitch(STATE_SCORE, STATE_ONLINE);
        break;
    case "resetDisconnectBuffer":
        // reset client disconnect buffer
        global.Client.alarm[0] = global.Client.disconnectBuffer;
        break;
    case "resetDropBuffer":
        // reset networkPlayer drop buffer
        Source.alarm[0] = Source.dropBuffer;
        break;
    case "dropPlayer":
        // drop player
        with (Source) event_user(1);
        break;
    case "restart":
        game_restart();
        break;
    case "quit":
        game_end();
        break;
    }

