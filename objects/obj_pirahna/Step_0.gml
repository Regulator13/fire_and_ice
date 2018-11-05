/// @description  input

// check if active
    //input
    //left, up, right, down, action - keys
    haxis1 = 0;
    vaxis1 = 0;
    jumpPressed = false;
    //iceIsPressed = false;
    icePressed = false;
    iceReleased = false;
    handicapReleased = false;
    grabPressed = false;
    //grabIsPressed = false;
    grabReleased = false;
    //fireIsPressed = false;
    firePressed = false;
    fireReleased = false;

    //inputBuffer - for joystick input
    if (inputBuffer > 0) inputBuffer -= 1;
    
    //axisBuffer - buffer till push starts counting
    axisBuffer = 0.4;
    
    //Player
    switch(playerInput) {
        case -1:
        case 1:
            // online input
            if(InputPlayer.inputs[LEFT_KEY]) haxis1 = -1;
            if(InputPlayer.inputs[RIGHT_KEY]) haxis1 = 1;
            if(InputPlayer.inputs[UP_KEY] == KEY_PRESSED) vaxis1 = -1;
            if(InputPlayer.inputs[DOWN_KEY] == KEY_PRESSED) vaxis1 = 1;
            if(InputPlayer.inputs[ACTION_KEY] == KEY_PRESSED) {
                jumpPressed = true;
                //unpress key
                InputPlayer.inputs[ACTION_KEY] = KEY_RELEASED;
                }
            if(InputPlayer.inputs[LEFTSELC_KEY] == KEY_PRESSED) {
                icePressed = true;
                iceIsPressed = true;
                grabPressed = true;
                grabIsPressed = true;
                }
            if(InputPlayer.inputs[LEFTSELC_KEY] == KEY_RELEASED) {
                iceReleased = true;
                iceIsPressed = false;
                grabReleased = true;
                grabIsPressed = false;
                }
            if (InputPlayer.inputs[RIGHTSELC_KEY] == KEY_PRESSED) {
                firePressed = true;
                fireIsPressed = true;
                }
            if (InputPlayer.inputs[RIGHTSELC_KEY] == KEY_RELEASED) {
                fireReleased = true;
                fireIsPressed = false;
                }
            break;
        case 0:
            //input
            if (alarm[0] <= 0) {
                haxis1 = choose(1, 0, -1);
                haxis1 = choose(1, 0, -1);
                action = choose(false, true);
                alarm[0] = irandom_range(10, 20);
                }
            break;
        }
    
    // moveSpeed - speed of character
    var moveSpeed;
    // gravity_max - maximum gravity speed
    var gravity_max;
    // biting - whether pirahna is out of water
    var biting;
    
    // check if player is underwater
    if (y > room_height-obj_wall.sprite_height-obj_control.water_height) {
        move_speed = 4;
        gravity_max = 1;
        biting = false;
        }
    else {
        move_speed = 1;
        gravity_max = 10;
        biting = true;
        }
    
    // find current hspeed
    if !(haxis1 > -axisBuffer and haxis1 < axisBuffer and vaxis1 > -axisBuffer and vaxis1 < axisBuffer) {
        hspeed = haxis1*move_speed;
        //direction
        if (hspeed != 0) dir = sign(hspeed);
        //image_angle = dir;
        }
    else {
        if (!place_free(x+hspeed,y+1)) hspeed = 0;
        }

    // if mouse controls, set direction based on mouse
    if (inputType == CONTROLS_MOUSE) {
        if (InputPlayer.mouseX != mouseX) {
            if (InputPlayer.mouseX > x) dir = 1;
            else dir = -1;
            mouseX = InputPlayer.mouseX;
            }
        }
             
    //image
    switch (dir) {
        case 0:
            image_index = 4;
            break;
        case 1:
            image_index = 5+frameStep;
            break;
        case -1:
            image_index = 0;
            break
        default:
            image_index = 4+frameStep;
            break;
        }
    
    //animate
    if (hspeed != 0) {
        if (frameBuffer < 0) {
            frameStep += 1;
            frameBuffer = frameBufferMax;
            }
        else frameBuffer --;
        }
    //keep animation in bounds
    if (frameStep > 3) frameStep = 0;
    //crouching image
    if (biting) image_index += bitingFrame;

    //------------------------------------------------------------------
    //Main Code
    //------------------------------------------------------------------
    
    //update y_score
    if (y < y_score) y_score = y;

    // Jump
    if (jumps > 0) {
        if (jumpPressed) {
            vspeed = -jump_height;
            jumps -= 1;
            }
        }

    //push blocks
    with(instance_place(x+sign(hspeed)*2,y,par_physics))
        {
        if (id != other.grabObject && not frozen && !stuck) {
            x+=scr_contactx(other.hspeed);
            }
        }

    // Apply gravity (and jumping)
    if (vspeed < gravity_max) {
        //gravity increment
        vspeed += gravityI
        }
    //keep gravity in bounds
    if (vspeed > gravity_max) vspeed = gravity_max;
    
    //collide with solid objects
    while(!place_free(x+hspeed, y)) {
        hspeed = scr_reduce(hspeed);
        if hspeed = 0 break;
        }
    while(!place_free(x+hspeed,y+vspeed)) {
        vspeed = scr_reduce(vspeed);
        if vspeed = 0 {
            //reset jumps
            jumps = jumps_max;
            break;
            }
        }

    // destory blocks
    if (firePressed) {
        with (instance_place(x, y, obj_block)) instance_destroy();
        with (instance_place(x, y, obj_corpse)) instance_destroy();
        }

    // reset jumps the player if is below water
    if(y > room_height-obj_wall.sprite_height-obj_control.water_height) {
        jumps = jumps_max;
        }

