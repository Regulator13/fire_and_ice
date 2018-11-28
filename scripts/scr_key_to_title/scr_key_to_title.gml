/// @description scr_key_to_title(key)
/// @param key
/* 
* Description: takes control key and returns title
* Parameters:  none
* Returns:     string
*/

// set input
var key = argument0;

// return title
switch (key) {
    case LEFT_KEY:
        return "Left: ";
    case RIGHT_KEY:
        return "Right: ";
    case UP_KEY:
        return "Aim Up: ";
    case DOWN_KEY:
        return "Aim Down: ";
    case ACTION_KEY:
        return "Jump: ";
    case ACTION2_KEY:
        return "Join: ";
    case LEFTSELC_KEY:
        return "Ice + Grab: ";
    case RIGHTSELC_KEY:
        return "Fire: ";
    default:
        return "Invalid Key! ";
    }

