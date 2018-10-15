///scr_sendInput()
/*
* Description:  send input data
* Parameters:   none
* Return:       void
*/

// start
    {
    // Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
    buffer_seek(buff, buffer_seek_start, 0);

    //write msgId
    buffer_write(buff, buffer_s8, CLIENT_PLAY);
    
    // write command
    buffer_write(buff, buffer_u8, INPUT_CMD);
    
    // write all the input
    var controls = 0;
    var amount = array_length_2d(global.controls, controls);
    buffer_write(buff, buffer_u8, amount);
    
    // send input according to type
    switch (global.controls[controls, KEY_TYPE]) {
        case CONTROLS_KEYBOARD:
            for (var i = 0; i < amount-1; i++;) {
                // input the input state
                var input = scr_getKeyInput(global.controls[controls, i]);
                buffer_write(buff, buffer_s8, input);
                }
            break;
        case CONTROLS_MOUSE:
            for (var i = 0; i < amount-3; i++;) {
                // input the input state
                var input = scr_getKeyInput(global.controls[controls, i]);
                buffer_write(buff, buffer_s8, input);
                }
            for (var i = amount-3; i < amount-1; i++;) {
                // input the input state
                var input = scr_getMouseInput(global.controls[controls, i]);
                buffer_write(buff, buffer_s8, input);
                }
            break;
        default:
            // joystick input
        }
    // send type
    buffer_write(buff, buffer_s8, global.controls[controls, KEY_TYPE]);
    
    // write the mousX and mouseY
    buffer_write(buff, buffer_u16, mouse_x);
    buffer_write(buff, buffer_u16, mouse_y);

    // Send this to the server
    network_send_udp(client,ip,port,buff,buffer_tell(buff));
    }
