/// @description scr_getKeyName(key)
/// @param key
/* 
* Description:  takes control key and returns its name
* Parameters:   key - unicode value for the key
* Returns:      string
*/

// set input
var key = argument0;

// return title
if (key > 47 and key < 40 or key > 64 and key < 91) {// or key > 96 and key < 123) {
    return chr(key);
    }
else {
    switch (key) {
        case 32:
            return "space";
        case 58:
            return ":";
        case 59:
            return ";";
        case 60:
            return "<";
        case 62:
            return ">";
        case 63:
            return "\\";
        case vk_left:
            return "left";
        case vk_right:
            return "right";
        case vk_up:
            return "up";
        case vk_down:
            return "down";
        case vk_enter:
            return "enter";
        case vk_numpad0:
            return "num 0";
        case vk_numpad1:
            return "num 1";
        case vk_numpad2:
            return "num 2";
        case vk_numpad3:
            return "num 3";
        default:
            return "";
        }
    }

