/// @description  input

// check if active
if (active) {
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
            // local input
            if(InputPlayer.inputs[LEFT_KEY]) haxis1 = -1;
            if(InputPlayer.inputs[RIGHT_KEY]) haxis1 = 1;
            if(InputPlayer.inputs[UP_KEY] == KEY_PRESSED) vaxis1 = -1;
            if(InputPlayer.inputs[DOWN_KEY] == KEY_PRESSED) vaxis1 = 1;
            if(InputPlayer.inputs[ACTION_KEY] == KEY_PRESSED) {
                jumpPressed = true;
                //unpress key
                //InputPlayer.inputs[ACTION_KEY] = KEY_RELEASED;
                }
            if(InputPlayer.inputs[LEFTSELC_KEY] == KEY_PRESSED) {
                icePressed = true;
                iceIsPressed = true;
                grabPressed = true;
                grabIsPressed = true;
                }
            else if(InputPlayer.inputs[LEFTSELC_KEY] == KEY_RELEASED) {
                iceReleased = true;
                iceIsPressed = false;
                grabReleased = true;
                grabIsPressed = false;
                }
            if (InputPlayer.inputs[RIGHTSELC_KEY] == KEY_PRESSED) {
                firePressed = true;
                fireIsPressed = true;
                }
            else if (InputPlayer.inputs[RIGHTSELC_KEY] == KEY_RELEASED) {
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
    // gravityMax - maximum gravity speed
    var gravityMax;
    
    // check if player is underwater
    if (y > room_height-32-obj_control.water_height) {
        moveSpeed = 3;
        gravityMax = 5;
        }
    else {
        moveSpeed = 4;
        gravityMax = 10;
        }
        
    //Find current hspeed
    if !(global.cooperativeMode) {
        if !(haxis1 > -axisBuffer and haxis1 < axisBuffer and vaxis1 > -axisBuffer and vaxis1 < axisBuffer) {
            if (!iceIsPressed && !fireIsPressed) hspeed = haxis1*moveSpeed;
            //direction
            if (hspeed != 0) dir = sign(hspeed);
            }
        else {
            if (!place_free(x+hspeed,y+1)) hspeed = 0;
            }
        }
    else {
        if !(haxis1 > -axisBuffer and haxis1 < axisBuffer and vaxis1 > -axisBuffer and vaxis1 < axisBuffer) {
            if (!iceIsPressed && !fireIsPressed) hspeed += haxis1*moveSpeed;
            if (hspeed > moveSpeed) hspeed = moveSpeed;
            if (hspeed < -moveSpeed) hspeed = -moveSpeed;
            //direction
            if (hspeed != 0) dir = sign(hspeed);
            }
        else {
            if (!place_free(x+hspeed,y+1)) hspeed = 0;
            }
        // set Friction
        if(!place_free(x+hspeed,y+1)) {
            if (hspeed >= fric) {
                hspeed -= fric;
                }
            else if (hspeed <= (-fric)) {
                hspeed += fric;
                }
            else if(abs(hspeed) < fric) {
                hspeed = 0
                }
            }
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
    if (crouch) image_index += crouchFrame;

    //------------------------------------------------------------------
    //Main Code
    //------------------------------------------------------------------
    
    //update yMin
    if (y < yMin) yMin = y;

    // Jump
    if (jumps > 0) {
        if (jumpPressed) {
            vspeed = -jumpHeight;
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
    if (vspeed < gravityMax) {
        //gravity increment
        vspeed += gravityI
        }
    //keep gravity in bounds
    if (vspeed > gravityMax) vspeed = gravityMax;
    
    //collide with solid objects
    while(!place_free(x+hspeed, y)) {
        hspeed = scr_reduce(hspeed);
        if hspeed = 0 break;
        }
    while(!place_free(x+hspeed,y+vspeed)) {
        vspeed = scr_reduce(vspeed);
        if vspeed = 0 {
            //reset jumps
            jumps = jumpsMax;
            break;
            }
        }

    //fire
    if (fireReleased) {
        if (energy > energyFire) {
            if (instance_exists(grabObject)) {
                if (grabObject.hp > grabObject.hpNormal-1 or grabObject.hp < grabObject.hpNormal+1) { //lasers subtract decimal points
                    grabObject.ignite = true;
                    grabObject.hp = grabObject.hpNormal;
                    }
                else grabObject.hp -= 1;
                }
            else {
                //throw
                with(instance_create(x,y,obj_ball)) {
                    //direction of throwing
                    if (other.inputType = CONTROLS_MOUSE) {
                        // if network player, throw based on mouse
                        dir = other.dir;
                        vspeed = -(other.strength/mass)*((other.y - other.InputPlayer.mouseY)/100); //(-other.vaxis1*2);
                        if (vspeed > -2) vspeed = -2; // keep vspeed in bounds
                        //subtract height from distance
                        xspeed = (other.strength/mass-abs(vspeed/4));
                        //set only if positive
                        if (xspeed > 0) hspeed = dir*(xspeed)*2;
                        }
                    else {
                        // throw based on arrow keys
                        dir = other.dir;
                        vspeed = -(other.strength/mass)*(-other.vaxis1*2);
                        if (vspeed > -2) vspeed = -2;
                        //subtract height from distance
                        xspeed = (other.strength/mass-abs(vspeed/4));
                        //set only if positive
                        if (xspeed > 0) hspeed = dir*(xspeed);
                        }
                    
                    //fire
                    sprite_index = spr_ballFire;
                    attack = 1;
                    source = other.id;
                    
                    //handicap
                    if (other.willArc) arc = true;
                    }
                //energy
                energy -= energyFire;
                }
            }
            // if online player, unpress key
            //if (playerInput == -1) InputPlayer.inputs[RIGHTSELC_KEY] = scr_toggleKey(InputPlayer.inputs[RIGHTSELC_KEY]); //unpress key
        }

    // freezeHoldingBuffer
    if (iceIsPressed) freezeHoldingBuffer--;
    // freeze holding block
    if (freezeHoldingBuffer < 0) {
        // check if enough energy
        if (energy > energyFire) {
            // if holding an block, set timer to freeze it
            if (instance_exists(grabObject)) {
                if (grabObject.hp > grabObject.hpNormal-1 or grabObject.hp < grabObject.hpNormal+1) { //lasers subtract decimal points
                    grabObject.willFreeze = true;
                    grabObject.hp = grabObject.hpNormal;
                    }
                else grabObject.hp += 1;
                }
            }
        }
    //ice
    if (iceReleased) {
        if (freezeHoldingBuffer >= 0) {
            // if not about to grab an object
            if !(place_meeting(x + sign(dir) * 4, y, par_physics)) {
                // check if enough energy
                if (energy > energyFire) {
                    //throw
                    with(instance_create(x,y,obj_ball)) {
                        //direction of throwing
                        if (other.inputType == CONTROLS_MOUSE) {
                            // if network player, throw based on mouse
                            dir = other.dir;
                            vspeed = -(other.strength/mass)*((other.y - other.InputPlayer.mouseY)/100); //(-other.vaxis1*2);
                            if (vspeed > -2) vspeed = -2; // keep vspeed in bounds
                            //subtract height from distance
                            xspeed = (other.strength/mass-abs(vspeed/4));
                            //set only if positive
                            if (xspeed > 0) hspeed = dir*(xspeed)*2;
                            }
                        else {
                            // throw based on arrow keys
                            dir = other.dir;
                            vspeed = -(other.strength/mass)*(-other.vaxis1*2);
                            if (vspeed > -2) vspeed = -2;
                            //subtract height from distance
                            xspeed = (other.strength/mass-abs(vspeed/4));
                            //set only if positive
                            if (xspeed > 0) hspeed = dir*(xspeed);
                            }
                        
                        //activate object
                        active = true;
                        
                        //ice
                        sprite_index = spr_ballIce;
                        attack = -1; //add one health
                        source = other.id;
                        
                        //handicap
                        if (other.willArc) arc = true;
                        }
                    //energy
                    energy -= energyFire;
                    }
            // if online player, unpress key
            if (playerInput == -1) {
                //InputPlayer.inputs[LEFTSELC_KEY] = scr_toggleKey(InputPlayer.inputs[LEFTSELC_KEY]); //unpress key
                }
            // do not grab
            grabPressed = false;
            }
            }
        else
            grabReleased = false; // do not throw
        // reset freeze buffer
        freezeHoldingBuffer = freezeHoldingBufferMax;
        }

    //grab
    if (grabPressed) {
        //crouch
        crouch = true;
        //if not already holding
        if (holding = 0) {
            grabObject = (instance_place(x+sign(dir)*4,y,par_physics));
            if (instance_exists(grabObject)) {//non character objects
                if (grabObject.frozen = false) {
                    grabObject.active = false;
                    //check if sticky
                    if (grabObject.sticky) grabObject.stuck = false //unstick
                    //set holder
                    grabObject.holder = self;
                    holding = 1;
                    }
                else grabObject = noone;
                }
            if !(instance_exists(grabObject)) grabObject = (instance_place(x+sign(dir)*4,y,obj_character));
            if (instance_exists(grabObject)) {
                if (grabObject.team == team || grabObject.team == noone) {
                    grabObject.active = false;
                    //check if sticky
                    if (grabObject.sticky) grabObject.stuck = false //unstick
                    //set holder
                    grabObject.holder = self;
                    holding = 1;
                    }
                else grabObject = noone;
                }
            }
        }
    //if (grabIsPressed) {
    if (instance_exists(grabObject)) {
        grabObject.x = x+hspeed;
        grabObject.y = y-9+vspeed;
        }
    if (grabReleased) {
        //if grabbing object, throw it
        if (instance_exists(grabObject)) {
            if (holding > 1) {
                //stop holding
                holding = 0;
                //stop crouching
                crouch = false;
                //throw
                with(grabObject) {
                    //direction of throwing
                    if (other.inputType = CONTROLS_MOUSE) {
                        // if mouse player, throw based on mouse
                        dir = other.dir;
                        vspeed = -(other.strength/mass)*((other.y - other.InputPlayer.mouseY)/100); //(-other.vaxis1*2);
                        if (vspeed > -2) vspeed = -2; // keep vspeed in bounds
                        //subtract height from distance
                        xspeed = (other.strength/mass-abs(vspeed/4));
                        //set only if positive
                        if (xspeed > 0) hspeed = dir*(xspeed);
                        }
                    else {
                        // throw based on arrow keys
                        dir = other.dir;
                        vspeed = -(other.strength/mass)*(-other.vaxis1*2);
                        if (vspeed > -2) vspeed = -2;
                        //subtract height from distance
                        xspeed = (other.strength/mass-abs(vspeed/4));
                        //set only if positive
                        if (xspeed > 0) hspeed = dir*(xspeed);
                        }
                    
                    //activate object
                    active = true;
                    }
    
                
                //remove grabObject's holder
                grabObject.holder = noone;
                grabObject = noone;
                }
            else holding += 1;
            }
        else {
            crouch = false;
            holding = 0;
            }
        }
    
    //handicap
    if (handicapReleased) {
        //toggle arcing
        if (willArc) willArc = false;
        else willArc = true;
        }
    }

/// hp and energy
if (active) {
//Hurt the player if they fall below the water
if(y > room_height-obj_wall.sprite_height-obj_control.water_height)
{hp -= .4;
}

//Collision with patrols
    with (instance_place(x, y, par_enemy)) {
        other.hp -= dmg;
        }

//Collision with pirahnas
if(place_meeting(x,y,obj_pirahna))
{hp -= 1;
}

//Collision with blown up big blocks
with (instance_place(x, y, obj_blockBig)){
	if hp <= 0 {
		other.hp -= 10
	}
}

//Kill the player if they run out of health
if(hp < 1) {
    //create corpse
    with (instance_create(x,y,obj_corpse)) sprite_index = other.sprite_index;
    //create pirahna
    with (instance_create(x,y,obj_pirahna)) {
        playerInput = other.playerInput;
        InputPlayer = other.InputPlayer;
        inputType = other.inputType;
        if (instance_exists(InputPlayer)) InputPlayer.gameCharacter = self;
        }
    //drop object if grabbed
    if (instance_exists(grabObject)) {
        //remove grabObject's holder
        grabObject.holder = noone;
        grabObject.active = true;
        }
    //subtract score
    //team.tScore += (room_height-yMin)*global.scoreY;
    //subtract life
    team.tLives -= 1;
    //keep in bounds
    if (team.tLives < 0) team.tLives = 0;
    //destroy self
    instance_destroy(self);
    }

    //recharge station
    if (place_meeting(x, y, obj_rechargeStation)) {
        if (energy < energy_max) {
            energy +=1;
            }
        }
    
    //hp
    with(instance_place(x, y, obj_health)) {
        //add health
        other.hp += value;
        //add lives
        other.team.tLives += 1;
        //keep in bounds
        if (other.hp > other.hp_max) other.hp = other.hp_max;
        //destroy
        instance_destroy();
        }
    }

///win
if (place_meeting(x, y, obj_door)) {
    //win score
    team.tScore += global.scoreWin/ds_list_size(team.players);
    if !(global.win) team.tScore += global.scoreFirst; //first
    global.win = true;
    instance_destroy();
    /*
    //subtract score for each player based on y
    for(var i=0; i<instance_number(obj_player); i++) {
        with (instance_find(obj_player,i)) global.playerScore[playerId] -= yMin*global.scoreY;
        }
    */
    }

/* */
///cheats
if (keyboard_check_pressed(ord("U"))) {
    vspeed = -jumpHeight;
    hp = hp_max;
    }

/* */
///score
with (instance_place(x, y, obj_score)) {
    //add score
    with (other) team.tScore += round(global.scoreObject/ds_list_size(team.players));
    //destroy self
    instance_destroy();
    }

//height
cLVL = ceil((room_height-y)/(room_height/10));
if (cLVL > team.LVL) {
    team.LVL = cLVL;
    }

/* */
/// move camera
if !(global.online) {
    obj_camera.x = x;
    obj_camera.y = y;
    }

/* */
/// mooch
if (moochBuffer < 0) {
    with (instance_place(x, y+16, obj_block)) {
        // mooch
        if (moochProof != other.team.team && moochProof != -1) {
            instance_create(x, y-32, prt_mooch);
            other.moochBuffer = other.moochBufferMax;
            }
        }
    }
else moochBuffer--;

/* */
/*  */
