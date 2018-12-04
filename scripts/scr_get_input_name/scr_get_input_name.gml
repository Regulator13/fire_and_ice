/// @description scr_get_input_name(code, control, controller)
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
        return(scr_get_key_name(code));
    case CONTROLS_MOUSE:
        if (control < LEFTSELC_KEY)
            return(scr_get_key_name(code));
        else 
            return(scr_get_mouse_name(code));
	default:
		return(scr_get_gamepad_name(code));
    }
