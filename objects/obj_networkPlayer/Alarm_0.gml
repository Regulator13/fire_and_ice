/// @description  drop player if not responding
switch(global.Menu.state) {
    case STATE_LOBBY:
        // just drop
        event_user(1);
    default:
        with (instance_create(room_width/2, room_height/2, obj_inputMessage)) {
            prompt = other.name + " is not responding, drop?";
            ds_list_add(actions, "dropPlayer");
            ds_list_add(actionTitles, "yes");
            ds_list_add(actions, "resetDropBuffer");
            ds_list_add(actionTitles, "no");
            Source = other;
            }
    }

