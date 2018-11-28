/// @description scr_getMouseName(key)
/// @param key
/* 
* Description: takes control key and returns its name
* Parameters:  key - unicode value for the key
* Returns:     string
*/

// set input
var key = argument0;

// get name
switch (key) {
    case mb_left:
        return "mouse left";
    case mb_right:
        return "mouse right";
    case mb_middle:
        return "mouse middle";
    default:
        return "";
    }

