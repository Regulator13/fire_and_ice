/// @description Value action
switch (valueAction) {
    case "changeControlsPlayer":
        // change selected player
        global.Menu.controlSelected = value;
        // reset menu
        scr_stateSwitch(STATE_CONTROLS, STATE_CONTROLS);
        break;
		
    case "changeControlsController":
        // change the controller type
        global.controls[global.Menu.controlSelected, KEY_TYPE] = value;
        // set to default
        scr_setControlsDefault(global.Menu.controlSelected, value);
        // reset menu
        scr_stateSwitch(STATE_CONTROLS, STATE_CONTROLS);
        break;
}
