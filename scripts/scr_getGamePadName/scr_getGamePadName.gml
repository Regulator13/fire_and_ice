/// @funtcion scr_getGamePadName(key)
/// @description takes control key and returns its name
/// @param key | unicode character for key
/// @returns string

// set input
var key = argument0;

// return title
switch (key) {
    case gp_face1:
        return "A";
    case gp_face2:
        return "B";
    case gp_face3:
        return "X";
    case gp_face4:
        return "Y";
	case gp_shoulderl:
		return "Left shoulder button"
	case gp_shoulderlb:
		return "Left shoulder trigger"
	case gp_shoulderr:
		return "Right shoulder button"
	case gp_shoulderrb:
		return "Right shoulder trigger"
	case gp_select:
		return "Select"
	case gp_start:
		return "Start"
	case gp_stickl:
		return "The left stick pressed (as a button)"
	case gp_stickr:
		return "The right stick pressed (as a button)"
	case gp_padu:
		return "D-pad up"
	case gp_padd:
		return "D-pad down"
	case gp_padl:
		return "D-pad left"
	case gp_padr:
		return "D-pad right"
	case gp_axislh:
		return "Left stick Right"
	case -gp_axislh:
		return "Left stick Left"
	case gp_axislv:
		return "Left stick Down"
	case -gp_axislv:
		return "Left stick Up"
	case gp_axisrh:
		return "Right stick horizontal axis (analogue)"
	case gp_axisrv:
		return "Right stick vertical axis (analogue)"
    default:
        return "";
    }

