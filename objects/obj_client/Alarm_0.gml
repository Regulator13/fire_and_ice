/// @description  disconnect if server is not responding
with (instance_create(room_width/2, room_height/2, obj_inputMessage)) {
    prompt = "Server not responding, disconnect?";
    switch(global.Menu.state) {
        case STATE_LOBBY:
            ds_list_add(actions, "backOnlineLobby");
            break;
        case STATE_PATHS:
            ds_list_add(actions, "backOnlinePaths");
            break;
        case STATE_GAME:
            ds_list_add(actions, "backOnlineGame");
            break;
        case STATE_SCORE:
            ds_list_add(actions, "backOnlineScore");
            break;
        }
    ds_list_add(actionTitles, "yes");
    ds_list_add(actions, "resetDisconnectBuffer");
    ds_list_add(actionTitles, "no");
    }

