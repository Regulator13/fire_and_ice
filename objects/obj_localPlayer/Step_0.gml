/// @description  get input
if (input_buffer < 0) {
    var buffer = false; // whether or not input was put in
    
    // get input
    switch (global.controls[controls, KEY_TYPE]) {
        case CONTROLS_KEYBOARD:
            inputs[LEFT_KEY] = scr_getKeyInput(global.controls[controls, LEFT_KEY]);
            inputs[RIGHT_KEY] = scr_getKeyInput(global.controls[controls, RIGHT_KEY]);
            inputs[UP_KEY] = scr_getKeyInput(global.controls[controls, UP_KEY]);
            inputs[DOWN_KEY] = scr_getKeyInput(global.controls[controls, DOWN_KEY]);
            inputs[ACTION_KEY] = scr_getKeyInput(global.controls[controls, ACTION_KEY]);
            inputs[ACTION2_KEY] = scr_getKeyInput(global.controls[controls, ACTION2_KEY]);
            inputs[LEFTSELC_KEY] = scr_getKeyInput(global.controls[controls, LEFTSELC_KEY]);
            inputs[RIGHTSELC_KEY] = scr_getKeyInput(global.controls[controls, RIGHTSELC_KEY]);
            // check if there was any input
            if (keyboard_check(vk_anykey))
                buffer = true;
            break;
        case CONTROLS_MOUSE:
            inputs[LEFT_KEY] = scr_getKeyInput(global.controls[controls, LEFT_KEY]);
            inputs[RIGHT_KEY] = scr_getKeyInput(global.controls[controls, RIGHT_KEY]);
            inputs[UP_KEY] = scr_getKeyInput(global.controls[controls, UP_KEY]);
            inputs[DOWN_KEY] = scr_getKeyInput(global.controls[controls, DOWN_KEY]);
            inputs[ACTION_KEY] = scr_getKeyInput(global.controls[controls, ACTION_KEY]);
            inputs[ACTION2_KEY] = scr_getKeyInput(global.controls[controls, ACTION2_KEY]);
            inputs[LEFTSELC_KEY] = scr_getMouseInput(global.controls[controls, LEFTSELC_KEY]);
            inputs[RIGHTSELC_KEY] = scr_getMouseInput(global.controls[controls, RIGHTSELC_KEY]);
            // set mouse position
            mouseX = mouse_x;
            mouseY = mouse_y;
            // check if there was any input
            if (keyboard_check(vk_anykey) || device_mouse_check_button(0, mb_any))
                buffer = true;
            break;
        default:
            // joystick input
            break;
        }
    
    // reset input buffer if in menu
    if (global.Menu.state != STATE_GAME && buffer)
        input_buffer = input_buffer_max;
    }
else {
    // tick
    input_buffer --;
    
    // reset input
    inputs[LEFT_KEY] = 0;
    inputs[RIGHT_KEY] = 0;
    inputs[UP_KEY] = 0;
    inputs[DOWN_KEY] = 0;
    inputs[ACTION_KEY] = 0;
    inputs[ACTION2_KEY] = 0;
    inputs[LEFTSELC_KEY] = 0;
    inputs[RIGHTSELC_KEY] = 0;
    }

