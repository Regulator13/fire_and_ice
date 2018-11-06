/// @description input

    // intitiate input
    // haxis - left or right
    var haxis = 0;
    // vaxis - up or down
    var vaxis = 0;
    // action - clicking
    var action = false;
    
    // gamepad input
    var input;
    // axis_buffer - buffer till push starts counting
    var axis_buffer = 0.4;
    
    // get input
    if (input_buffer < 0) {
        // gamepad input
        for (input = 0; input < 4; input++) {
            haxis = gamepad_axis_value(input, gp_axislh);
            vaxis = gamepad_axis_value(input, gp_axislv);
            // axis check
            if (haxis < axis_buffer and haxis > -axis_buffer) haxis = 0;
            if (vaxis < axis_buffer and vaxis > -axis_buffer) vaxis = 0;
            // action
            if(gamepad_button_check_released(input, gp_face1)) action = true;
            }
        
        // keyboard input
        if (keyboard_check(vk_left) or keyboard_check(ord("A")) or keyboard_check(ord("J"))) haxis = -1;
        if (keyboard_check(vk_right) or keyboard_check(ord("D")) or keyboard_check(ord("L"))) haxis = 1;
        if (keyboard_check(vk_up) or keyboard_check(ord("W")) or keyboard_check(ord("I"))) vaxis = -1;
        if (keyboard_check(vk_down) or keyboard_check(ord("S")) or keyboard_check(ord("K"))) vaxis = 1;
        if (keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter)) action = true;
        
        // check for input
        
        // change action selected
        actionSel = scr_incrementInBounds(actionSel, haxis + vaxis, 0, ds_list_size(actions)-1, true);
        
        // check if pressed
        if (action) {
            event_user(0);
            instance_destroy();
            }
        
        // reset input_buffer
        if (haxis != 0 or vaxis != 0 or action != 0)
            input_buffer = input_buffer_max;
        }
    else 
        input_buffer--;

