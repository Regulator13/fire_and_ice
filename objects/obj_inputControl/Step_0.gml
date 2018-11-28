/// @description Input

switch(controller) {
    case CONTROLS_KEYBOARD:
        // check for keyboard input
        if (keyboard_key) {
            scr_changeControl(keyboard_key, control, controller, player, Source);
            instance_destroy();
        }
        break;
		
    case CONTROLS_MOUSE:
		//DESCR?
        if (control < LEFTSELC_KEY) {
            // check for keyboard input
            if (keyboard_key) {
                scr_changeControl(keyboard_key, control, controller, player, Source);
                instance_destroy();
            }
        }
		
        else {
            // check for mouse input
            if (device_mouse_check_button(0, mb_left)) {
                scr_changeControl(mb_left, control, controller, player, Source);
                instance_destroy();
            }
			
            else if (device_mouse_check_button(0, mb_right)) {
                scr_changeControl(mb_right, control, controller, player, Source);
                instance_destroy();
            }
			
            else if (device_mouse_check_button(0, mb_middle)) {
                scr_changeControl(mb_middle, control, controller, player, Source);
                instance_destroy();
            }
        }
        break;
	
	default:
        //check for button presses
		var i
		for (i = gp_face1; i <= gp_padr; i++) {
			if (gamepad_button_check_pressed(controller, i)) {
				scr_changeControl(i, control, controller, player, Source);
				instance_destroy();
			}
        }
		//check left axis
		for (i = gp_axislh; i <= gp_axislv; i++) {
			if abs(gamepad_axis_value(controller, i)) > GAMEPAD_AXIS_TOL {
				scr_changeControl(i*sign(gamepad_axis_value(controller, i)), control, controller, player, Source);
				instance_destroy();
			}
        }
        break;
}
        
// escape
if (keyboard_check(vk_escape)) {
    instance_destroy();
}
