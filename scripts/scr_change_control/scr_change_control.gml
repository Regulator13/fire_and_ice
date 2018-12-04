/// @description scr_change_control(code, control, controller, player, Button)
/// @param code
/// @param  control
/// @param  controller
/// @param  player
/// @param  Button
/* 
* Description:  changes the control
* Parameters:   code - unicode key
*               control - the control to be changed
*               controller - type of input, keyboard, mouse, etc
*               player - player whose controls are being changed
*               Button - button to change title of
* Returns:      string
*/

// set input
var code = argument0;
var control = argument1;
var controller = argument2;
var player = argument3;
var Button = argument4;

// initialize local variables
var name;

// get name
name = scr_get_input_name(code, control, controller);
// update controls
if (name != "") {
    // change controls
    global.controls[player, control] = code;
    // reset button title
    Button.title = name;
    }
