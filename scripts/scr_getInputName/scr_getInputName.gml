/// @description scr_getInputName(code, control, controller)
/// @param code
/// @param  control
/// @param  controller
/* 
* Description:  takes control key and returns its name
* Parameters:   code - unicode value for the key
*               controller - the controller type, keyboard, mouse, etc
* Returns:      string
*/

// set input
var code = argument0;
var control = argument1;
var controller = argument2;

// get name
switch (controller) {
    case CONTROLS_KEYBOARD:
        return(scr_getKeyName(code));
    case CONTROLS_MOUSE:
        if (control < LEFTSELC_KEY)
            return(scr_getKeyName(code));
        else 
            return(scr_getMouseName(code));
	default:
		return(scr_getGamePadName(code));
    }
