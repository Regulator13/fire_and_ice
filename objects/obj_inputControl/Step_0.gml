/// @description input

switch(controller) {
    case CONTROLS_KEYBOARD:
        // check for keyboard input
        if (keyboard_key) {
            scr_changeControl(keyboard_key, control, controller, player, Source);
            instance_destroy();
            }
        break;
    case CONTROLS_MOUSE:
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
    }
        
// escape
if (keyboard_check(vk_escape)) {
    instance_destroy();
    }

