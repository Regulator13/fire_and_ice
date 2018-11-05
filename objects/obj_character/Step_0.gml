/// @description Input

if (active) {
	///Local Initializations
	var moveSpeed;
    var gravity_max;
	
    ///Input initializations
    haxis1 = 0;
    vaxis1 = 0;
    jump_pressed = false;
    ice_pressed = false;
    ice_released = false;
    handicap_released = false;
    grab_pressed = false;
    grab_released = false;
    fire_pressed = false;
    fire_released = false;
	axis_buffer = 0.4; //buffer till push starts counting

    //input_buffer - for joystick input
    if (input_buffer > 0){
		input_buffer -= 1;
	}
    
    ///Player inputs
    switch(player_input) {
		//Normal player inputs
        case -1:
		
        case 1:
            // local input
            if(Input_player.inputs[LEFT_KEY]) haxis1 = -1;
            if(Input_player.inputs[RIGHT_KEY]) haxis1 = 1;
            if(Input_player.inputs[UP_KEY] == KEY_PRESSED) vaxis1 = -1;
            if(Input_player.inputs[DOWN_KEY] == KEY_PRESSED) vaxis1 = 1;
            if(Input_player.inputs[ACTION_KEY] == KEY_PRESSED) {
                jump_pressed = true;
                //unpress key
                //Input_player.inputs[ACTION_KEY] = KEY_RELEASED;
            }
			
            if(Input_player.inputs[LEFTSELC_KEY] == KEY_PRESSED) {
                ice_pressed = true;
                ice_is_pressed = true;
                grab_pressed = true;
                grab_is_pressed = true;
            }
			
            else if(Input_player.inputs[LEFTSELC_KEY] == KEY_RELEASED) {
                ice_released = true;
                ice_is_pressed = false;
                grab_released = true;
                grab_is_pressed = false;
            }
			
            if (Input_player.inputs[RIGHTSELC_KEY] == KEY_PRESSED) {
                fire_pressed = true;
                fire_is_pressed = true;
            }
			
            else if (Input_player.inputs[RIGHTSELC_KEY] == KEY_RELEASED) {
                fire_released = true;
                fire_is_pressed = false;
            }
			
            break;
			
		//computer player input
        case 0:
            if (alarm[0] <= 0) {
                haxis1 = choose(1, 0, -1);
                vaxis1 = choose(1, 0, -1);
                action = choose(false, true);
                alarm[0] = irandom_range(10, 20);
            }
			
            break;
    }
    
    //Check if player is underwater
    if (y > room_height-32-obj_control.water_height) {
        moveSpeed = 3;
        gravity_max = 5;
        }
    else {
        moveSpeed = 4;
        gravity_max = 10;
        }
        
    ///Find current hspeed
	//If on the ground
	if not place_free(x, y + 1){
		//Move if joystick is pushed far enough
	    if !(haxis1 > -axis_buffer and haxis1 < axis_buffer and vaxis1 > -axis_buffer and vaxis1 < axis_buffer) {
			if (!ice_is_pressed && !fire_is_pressed) or has_jetpack{
				//accelerate
				if abs(hspeed) < moveSpeed{
					hspeed += haxis1*acceleration
				}
				
				//move once fully accelerated
				else{
					hspeed = haxis1*moveSpeed
				}
			}
	        //direction
	        if (hspeed != 0) dir = sign(hspeed);
	    }
		
		//Apply friction if not moving
	    else {
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
	}
		
	//If in the air
	else{
		if !(haxis1 > -axis_buffer and haxis1 < axis_buffer and vaxis1 > -axis_buffer and vaxis1 < axis_buffer) {
	        if (!ice_is_pressed && !fire_is_pressed) or has_jetpack{
				//If moving from a stop in air
				if hspeed == 0{
					hspeed += haxis1 * drag
				}
					
				//If going the same direction
				if sign(hspeed) == sign(haxis1){
					if abs(hspeed) < moveSpeed{
						hspeed += sign(hspeed) * drag
					}
				}
					
				//If opposing direction
				if sign(hspeed) != sign(haxis1){
					hspeed = (abs(hspeed) - drag) * sign(hspeed)
						
					//Change player's direction
					if hspeed != 0{
						dir = sign(hspeed)
					}
				}
			}
		}
	}
	
    // if mouse controls, set direction based on mouse
    if (input_method == CONTROLS_MOUSE) {
        if (Input_player.mouseX != mouseX) {
            if (Input_player.mouseX > x) dir = 1;
            else dir = -1;
            mouseX = Input_player.mouseX;
            }
        }
             
    //image
    switch (dir) {
        case 0:
            image_index = 4;
            break;
        case 1:
            image_index = 5+frame_step;
            break;
        case -1:
            image_index = 0;
            break
        default:
            image_index = 4+frame_step;
            break;
        }
    
    //animate
	//TODO animation broken in one direction
    if (hspeed != 0) {
        if (frame_buffer < 0) {
            frame_step += 1;
            frame_buffer = frame_buffer_max;
            }
        else frame_buffer --;
        }
    //keep animation in bounds
    if (frame_step > 3) frame_step = 0;
    //crouching image
    if (crouch) image_index += crouch_frame;

    //------------------------------------------------------------------
    //Main Code
    //------------------------------------------------------------------
    
    //update y_score
    if (y < y_score) y_score = y;

    // Jump
    if (jumps > 0) {
		//if not has_jetpack{
	        if (jump_pressed) {
				if instance_exists(grab_object){
					var total_mass = mass + grab_object.mass
				}
			
				else var total_mass = mass

	            vspeed = -(jump_height - total_mass / 12);
	            jumps -= 1;
	        }
		//}
    }

    //block collisions
    with(instance_place(x+sign(hspeed)*2,y,par_physics)){
		//Push blocks
        if (id != other.grab_object && not frozen && !stuck) {
            x+=scr_contactx(other.hspeed);
            }
		
		//Climb blocks
		if (id != other.grab_object) and (frozen or stuck){
			//Slide slowly down blocks' sides
			other.hspeed = 0
			other.vspeed = 0
			
			//Climb up them
			if other.jump_pressed{
				//While climbing
				if other.y + other.sprite_height - 6 > y{
					if other.energy >= .5{
						other.vspeed = -5 
						other.energy -= .5
					}
				}
				
				//Once at the top
				else{
					if other.energy >= 1{
						//If on left side
						if other.x < x{
							if place_free(x - 3/4 * sprite_width, y - 16){
								other.x = x - 3/4 * sprite_width
								other.y = y - 16
								with other alarm_set(1,15)
								other.vspeed = 0
								other.hspeed = 0
								other.active = false
								other.energy -= 1
								exit
							}
						}
						
						//If on the right side
						else{
							if place_free(x + 3/4 * sprite_width, y - 16){
								other.x = x + 3/4 * sprite_width
								other.y = y - 16
								with other alarm_set(1,15)
								other.vspeed = 0
								other.hspeed = 0
								other.active = false
								other.energy -= 1
								exit
							}
						}
					}
				}
			}
        }
	}

    // Apply gravity (and jumping)
    if (vspeed < gravity_max) {
        //gravity increment
        vspeed += gravityI
        }
    //keep gravity in bounds
    if (vspeed > gravity_max) vspeed = gravity_max;

	//Match speed of platforms
	with instance_place(x, y+vspeed, obj_platform){
		//Vertical
		if is_vertical{
			other.y += (vspeed + sign(vspeed)*other.gravityI)
			
			//apply friction if not stopped
			if hp < hp_max{
				if (other.hspeed >= other.fric*3) {
	                other.hspeed -= other.fric*3;
	            }
	            else if (other.hspeed <= (-other.fric*3)) {
	                other.hspeed += other.fric*3;
	            }
	            else if(abs(other.hspeed) < other.fric*3) {
	                other.hspeed = 0
				}
            }
		}
	}
	
	//Horizontal
	with instance_place(x, y + 1, obj_platform){
		if not is_vertical{
			other.x += hspeed
		}
	}
	
    
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

    //fire
    if (fire_released) {
		//turn jetpack off
		if has_jetpack{
			if grab_object.working{
				grab_object.image_index = 0
			}
		}
		
        if (energy > energy_fire) {
            if (instance_exists(grab_object)) {
                if (grab_object.hp > grab_object.hpNormal-1 or grab_object.hp < grab_object.hpNormal+1) { //lasers subtract decimal points
                    grab_object.ignite = true;
                    grab_object.hp = grab_object.hpNormal;
                    }
                else grab_object.hp -= 1;
                }
            else {
                //throw
                with(instance_create_layer(x,y,"lay_instances",obj_ball)) {
                    //direction of throwing based on mouse
                    if (other.input_method = CONTROLS_MOUSE) {
						scr_mouse_set_throw_dir(other.strength, mass, other.x, other.y, other.Input_player.mouseX, other.Input_player.mouseY, other.dir)
                    }
					
					//Otherwise based on arrow keys
                    else {
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
                    if (other.will_arc) arc = true;
                    }
                //energy
                energy -= energy_fire;
                }
            }
            // if online player, unpress key
            //if (player_input == -1) Input_player.inputs[RIGHTSELC_KEY] = scr_toggleKey(Input_player.inputs[RIGHTSELC_KEY]); //unpress key
        }
	
	//Jetpack flying
	if fire_is_pressed{
		if has_jetpack{
			if grab_object.working{
				if energy >= grab_object.jetpack_cost{
					if vspeed > -10{
						//Floating
						if vspeed > -3{
							if place_free(x + hspeed, y + vspeed - .8){
								vspeed -= .8
							}
						}
						
						//Flying
						else{
							if place_free(x + hspeed, y + vspeed - .3){
								vspeed -=.3
							}
						}
						
						energy -= grab_object.jetpack_cost
						grab_object.image_index = 1
					}
				}
			}
		}
	}
				
	
    // freeze_holding_buffer
    if (ice_is_pressed) freeze_holding_buffer--;
    // freeze holding block
    if (freeze_holding_buffer < 0) {
        // check if enough energy
        if (energy > energy_fire) {
            // if holding an block, set timer to freeze it
            if (instance_exists(grab_object)) {
                if (grab_object.hp > grab_object.hpNormal-1 or grab_object.hp < grab_object.hpNormal+1) { //lasers subtract decimal points
                    grab_object.willFreeze = true;
                    grab_object.hp = grab_object.hpNormal;
                    }
                else grab_object.hp += 1;
                }
            }
        }
    //ice
    if (ice_released) {
        if (freeze_holding_buffer >= 0) {
            // if not about to grab an object
            if !(place_meeting(x + sign(dir) * 4, y, par_physics)) {
                // check if enough energy
                if (energy > energy_fire) {
                    //throw
                    with(instance_create_layer(x,y,"lay_instances",obj_ball)) {
                        //Throw using mouse
                        if (other.input_method == CONTROLS_MOUSE) {
                            scr_mouse_set_throw_dir(other.strength, mass, other.x, other.y, other.Input_player.mouseX, other.Input_player.mouseY, other.dir)
                            }
					
						//Throw using arrow keys
                        else {
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
                        if (other.will_arc) arc = true;
                        }
                    //energy
                    energy -= energy_fire;
                    }
            // if online player, unpress key
            if (player_input == -1) {
                //Input_player.inputs[LEFTSELC_KEY] = scr_toggleKey(Input_player.inputs[LEFTSELC_KEY]); //unpress key
                }
            // do not grab
            grab_pressed = false;
            }
            }
        else
            grab_released = false; // do not throw
        // reset freeze buffer
        freeze_holding_buffer = freeze_holding_buffer_max;
        }

    //grab
    if (grab_pressed) {
        //crouch
        crouch = true;
        //if not already holding
        if (holding = 0) {
            grab_object = (instance_place(x+sign(dir)*4,y,par_physics));
			
			//jetpack
			if instance_exists(grab_object){
				if object_get_name(grab_object.object_index) == "obj_jetpack"{
					has_jetpack = true
				}
			}
			
            if (instance_exists(grab_object)) {//non character objects
                if (grab_object.frozen = false) {
                    grab_object.active = false;
                    //check if sticky
                    if (grab_object.sticky) grab_object.stuck = false //unstick
                    //set holder
                    grab_object.holder = self;
                    holding = 1;
                    }
                else grab_object = noone;
                }
            if !(instance_exists(grab_object)) grab_object = (instance_place(x+sign(dir)*4,y,obj_character));
            if (instance_exists(grab_object)) {
                if (grab_object.team == team || grab_object.team == noone) {
                    grab_object.active = false;
                    //check if sticky
                    if (grab_object.sticky) grab_object.stuck = false //unstick
                    //set holder
                    grab_object.holder = self;
                    holding = 1;
                    }
                else grab_object = noone;
                }
            }
        }
    //if (grab_is_pressed) {
    if (instance_exists(grab_object)) {
        grab_object.x = x+hspeed;
        grab_object.y = y-9+vspeed;
        }
    if (grab_released) {
        //if grabbing object, throw it
        if (instance_exists(grab_object)) {
            if (holding > 1) {
                //stop holding
                holding = 0;
                //stop crouching
                crouch = false;
				//does not have jetpack
				has_jetpack = false
                //throw
                with(grab_object) {
                    //Throw using mouse
                    if (other.input_method = CONTROLS_MOUSE) {
                        scr_mouse_set_throw_dir(other.strength, mass, other.x, other.y, other.Input_player.mouseX, other.Input_player.mouseY, other.dir)
                        }
					
					//Throw using arrow keys
                    else {
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
    
                
                //remove grab_object's holder
                grab_object.holder = noone;
                grab_object = noone;
                }
            else holding += 1;
            }
        else {
            crouch = false;
            holding = 0;
            }
        }
    
    //handicap
    if (handicap_released) {
        //toggle arcing
        if (will_arc) will_arc = false;
        else will_arc = true;
        }
    }

/// hp and energy
if (active) {
	//Hurt the player if they fall below the water
	if(y > room_height-obj_wall.sprite_height-obj_control.water_height){
		hp -= .4;
	}

	//Collision with patrols
    with (instance_place(x, y, par_enemy)) {
		if can_attack{
			other.hp -= dmg;
			alarm[0] = attack_delay
			can_attack = false
		}
    }

	//Collision with pirahnas
	if(place_meeting(x,y,obj_pirahna)){
		hp -= 1;
	}

	//Collision with blown up big blocks
	with (instance_place(x, y, obj_blockBig)){
		if hp <= 0 {
			other.hp -= 10
		}
	}

	//Jump on trampolines
	var min_jump_speed = 3
	if place_meeting(x, y + vspeed/4, obj_trampoline){
		//Reset jump
		if vspeed < min_jump_speed + 4{
			jumps = jumps_max
		}
		
		//Bounce
		if vspeed > min_jump_speed{
			vspeed *= -1
		}
	}

	//Kill the player if they run out of health
	if(hp < 1) {
	    //create corpse
	    with (instance_create_layer(x,y,"lay_instances",obj_corpse)) sprite_index = other.sprite_index;
		
	    //create pirahna
	    with (instance_create_layer(x,y,"lay_instances",obj_pirahna)) {
	        player_input = other.player_input;
	        Input_player = other.Input_player;
	        input_method = other.input_method;
	        if (instance_exists(Input_player)) Input_player.gameCharacter = self;
	        }
			
	    //drop object if grabbed
	    if (instance_exists(grab_object)) {
	        //remove grab_object's holder
	        grab_object.holder = noone;
	        grab_object.active = true;
	        }
			
	    //subtract score
	    //team.tScore += (room_height-y_score)*global.scoreY;
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
    team.tScore += global.score_win/ds_list_size(team.players);
    if !(global.win) team.tScore += global.score_first; //first
    global.win = true;
    instance_destroy();
    /*
    //subtract score for each player based on y
    for(var i=0; i<instance_number(obj_player); i++) {
        with (instance_find(obj_player,i)) global.playerScore[player_id] -= y_score*global.scoreY;
        }
    */
    }

/* */
///cheats
if (keyboard_check_pressed(ord("U"))) {
    vspeed = -jump_height;
    hp = hp_max;
    }

/* */
///score
with (instance_place(x, y, obj_score)) {
    //add score
    with (other) team.tScore += round(global.score_object/ds_list_size(team.players));
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
if (mooch_buffer < 0) {
    with (instance_place(x, y+16, obj_block)) {
        // mooch
        if (moochProof != other.team.team && moochProof != -1) {
            instance_create_layer(x, y-32, "lay_instances", prt_mooch);
            other.mooch_buffer = other.mooch_buffer_max;
            }
        }
    }
else mooch_buffer--;

/* */
/*  */
