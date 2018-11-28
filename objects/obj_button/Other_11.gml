/// @description Value action
switch (valueAction) {
    case "changeControlsPlayer":
        // change selected player
        global.Menu.controlSelected = value;
        // reset menu
        scr_state_switch(STATE_CONTROLS, STATE_CONTROLS);
        break;
		
    case "changeControlsController":
        // change the controller type
        global.controls[global.Menu.controlSelected, KEY_TYPE] = value;
        // set to default
        scr_set_controls_default(global.Menu.controlSelected, value);
        // reset menu
        scr_state_switch(STATE_CONTROLS, STATE_CONTROLS);
        break;
}
