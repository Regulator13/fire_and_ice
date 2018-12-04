/// @description Input
//Make sure the player doesn't go past the top
if y < 6 y = 6

var dropped = false //Set true if the player has just dropped from a block to a ledge

if (active) {
	///Local Initializations
	var moveSpeed;
    var gravity_max;
	var can_throw = true //Set a marker so the player doesn't throw a ball when doing something else
	
    ///Input resets
    haxis1 = 0;
    vaxis1 = 0;
	down_pressed = 0
    jump_pressed = false;
    handicap_released = false;
    left_action_pressed = false;
    left_action_released = false;
    right_action_pressed = false;
    right_action_released = false;
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
			if(Input_player.inputs[DOWN_KEY]) down_pressed = 1;
            if(Input_player.inputs[ACTION_KEY] == KEY_PRESSED) {
                jump_pressed = true;
                //unpress key
                //Input_player.inputs[ACTION_KEY] = KEY_RELEASED;
            }
			
            if(Input_player.inputs[LEFTSELC_KEY] == KEY_PRESSED) {
                left_action_pressed = true;
                left_action_is_pressed = true;
            }
			
            else if(Input_player.inputs[LEFTSELC_KEY] == KEY_RELEASED) {
                left_action_pressed = false;
                left_action_released = true;
                left_action_is_pressed = false;
            }
			
            if (Input_player.inputs[RIGHTSELC_KEY] == KEY_PRESSED) {
                right_action_pressed = true;
                right_action_is_pressed = true;
            }
			
            else if (Input_player.inputs[RIGHTSELC_KEY] == KEY_RELEASED) {
                right_action_released = true;
                right_action_is_pressed = false;
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
			if (!left_action_is_pressed and !right_action_is_pressed) or has_jetpack{
				//down key to inch sideways
				if down_pressed > axis_buffer{
					if place_free(x + haxis1, y + vspeed){
						hspeed = 0
						x += haxis1
					}
				}
				
				
				else{
					//accelerate
					if abs(hspeed) < moveSpeed{
						hspeed += haxis1*acceleration
					}
				
					//move once fully accelerated
					else{
						hspeed = haxis1*moveSpeed
					}
				}
			}
	        //Find direction player is facing
	        if (hspeed != 0) dir = sign(hspeed);
			else if input_method != CONTROLS_KEYBOARD dir = 0 //Keyboard controls use direction to show aim reticule
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
	        if (!left_action_is_pressed and !right_action_is_pressed) or has_jetpack{
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
				}
				
				//Change player's direction
				if hspeed != 0 dir = sign(hspeed)
				else if input_method != CONTROLS_KEYBOARD dir = 0 //Keyboard controls use direction to show aim reticule
			}
		}
	}
	
    //Setting direction
    if (input_method == CONTROLS_MOUSE) {
        if (Input_player.mouseX != mouseX) {
			//Set direction based on mouse
            if (Input_player.mouseX > x) dir = 1;
			
            else dir = -1;
			
            mouseX = Input_player.mouseX;
        }
    }
             
    ///Image
    switch (dir) {
        case 0:
            image_index = 4;
            break;
        case 1:
            image_index = 5 + frame_step;
            break;
        case -1:
            image_index = 0 + frame_step;
            break
        default:
            image_index = 4 + frame_step;
            break;
        }
    
    ///Animatation
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
    if (crouch){
		image_index += crouch_frame;
		y_diff = 8
	}
	else y_diff = 0
	
	///Score
    //update y_score
    if (y < y_score) y_score = y;
	
	///Hang
	//Use down key to move from the top of a ledge to hanging position
	if down_pressed > axis_buffer{
		with instance_place(x, y + 1, par_block){
			if self != other.Grab_object{
				//Hang on right side if right foot is off the side of block
				if position_empty(other.x + other.sprite_width, other.y + other.sprite_height + 1){
					//Check to see if the PLAYER can fit, not the par_block
					with other{
						if place_free(other.x + sprite_width, y){
							x = other.x + other.sprite_width - PLAYER_TOL
							y = other.y - y_diff
							dir = -1
							hspeed = 0
							vspeed = 0
							climb_dir = dir
							gravity_incr = 0
							active = false
							hanging = true
							dropped = true
							if input_method != CONTROLS_MOUSE and input_method != CONTROLS_KEYBOARD{
								alarm[2] = gamepad_drop_delay
								gamepad_can_drop = false
							}
						}
					}
				}
		
				//Hang on left side if left foot is off the side of block
				else if position_empty(other.x, other.y + other.sprite_height + 1){
					//Check to see if the PLAYER can fit, not the par_block
					with other{
						if place_free(other.x - sprite_width, y){
							x = other.x - sprite_width + PLAYER_TOL
							y = other.y - y_diff
							dir = 1
							hspeed = 0
							vspeed = 0
							climb_dir = dir
							gravity_incr = 0
							active = false
							hanging = true
							dropped = true
							if input_method != CONTROLS_MOUSE and input_method != CONTROLS_KEYBOARD{
								alarm[2] = gamepad_drop_delay
								gamepad_can_drop = false
							}
						}
					}
				}
			}
		}
	}

    ///Jump
    if (jumps > 0) {
	    if (jump_pressed) {
			//Can only jump on ground
			if !place_free(x, y + 2){
				//Subtract mass from jump_height
				if instance_exists(Grab_object){
					if strength >= Grab_object.mass{
						vspeed = -jump_height;
						jumps -= 1;
					}
					else{
						vspeed = -(jump_height - (Grab_object.mass - strength)/3)
						jumps -= 1
					}
				}
				else{
					vspeed = -jump_height;
					jumps -= 1;
				}
			}
	    }
    }
/*
    ///Block collisions
    with(instance_place(x + sign(hspeed) * 2, y, par_physics)){
		//Push blocks
        if (id != other.Grab_object and not frozen and !stuck) {
            x+=scr_contactx(other.hspeed);
        }
	*/
	
	//Climb blocks
	with(instance_place(x + dir * 2, y, par_block)){
		if (id != other.Grab_object and climbable){
			//Change the character's variables
			with (other){
				scr_attempt_climbing()
			}
        }
	}

    ///Gravity
    if (vspeed < gravity_max) {
        //gravity increment
        vspeed += gravity_incr
        }
		
    //keep gravity in bounds
    if (vspeed > gravity_max) vspeed = gravity_max;
    
    ///Collisions
	//Horizotal collision
	//Make a list of collisions, if you can't move through all of them, stop
	Collided = ds_list_create()
	num = 0
	while instance_place(x + hspeed, y, all){
		var inst = instance_place(x + hspeed, y, all){
			if instance_exists(inst){
				Collided[| num] = inst
				num++
				instance_deactivate_object(inst)
			}
		}
	}
	
	if not ds_list_empty(Collided){
		for(i=0; i<num; i++){
			instance_activate_object(Collided[| i])
			with Collided[| i]{
				if not can_pass_through{
					with other{ //Change the player's speed
						while(!place_free(x + hspeed, y)){
						    hspeed = scr_reduce(hspeed);
						    if hspeed == 0 break;
						}
					}
				}
			}
		}
	}
	ds_list_destroy(Collided)
	
	//Vertical collision
	//Make a list of collisions, if you can't move through all of them, stop
	Collided = ds_list_create()
	num = 0
	while instance_place(x + hspeed, y + vspeed, all){
		var inst = instance_place(x + hspeed, y + vspeed, all){
			if instance_exists(inst){
				Collided[| num] = inst
				num++
				instance_deactivate_object(inst)
			}
		}
	}
	
	if not ds_list_empty(Collided){
		for(i=0; i<num; i++){
			instance_activate_object(Collided[| i])
			with Collided[| i]{
				if not can_pass_through{
					with other{ //Change the player's speed
						while(!place_free(x + hspeed, y + vspeed)) {
						    vspeed = scr_reduce(vspeed);
						    if vspeed == 0 {
						        //reset jumps
						        jumps = jumps_max;
						        break;
							}
						}
					}
				}
			}
        }
    }
	ds_list_destroy(Collided)
	
	///Platforms
	//Match speed of platforms
	scr_move_with_platform()
	
	//Jetpack flying
	if right_action_is_pressed and has_jetpack and Grab_object.working{
		if energy >= Grab_object.jetpack_cost{
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
						
				energy -= Grab_object.jetpack_cost
				Grab_object.image_index = 1
			}
		}
	}
				
	///Ice
    if (left_action_is_pressed) freeze_holding_buffer--;
	
    //freeze the block being held
    if (freeze_holding_buffer < 0) {
        // check if enough energy
        if (energy > energy_fire) {
            // if holding an block, set timer to freeze it
            if (instance_exists(Grab_object)) {
                if (Grab_object.hp > Grab_object.hp_normal-1 or Grab_object.hp < Grab_object.hp_normal+1){
                    Grab_object.will_freeze = true;
                    Grab_object.hp = Grab_object.hp_normal;
					holding = 1 //Reset buffer so the block is not thrown
                }
				
                else Grab_object.hp += 1;
            }
        }
    }

    ///Grabbing
    if (left_action_pressed) {
        //crouch
        crouch = true;
		
        //If not already holding something, attempt to grab close thing
		if (place_meeting(x + sign(dir) * GRAB_TOL, y, par_physics)) {
			
	        if (holding = 0) {
		
				Grab_object = (instance_place(x+sign(dir) * GRAB_TOL, y, par_physics));
			
	            if !instance_exists(Grab_object){
					Grab_object = (instance_place(x+sign(dir) * GRAB_TOL, y, obj_character));
				}
			
				//Initialize variables for certain objects
				if instance_exists(Grab_object){
					if Grab_object.object_index == obj_jetpack{
						has_jetpack = true
					}
				
					if Grab_object.object_index == obj_hang_glider{
						has_hang_glider = true
					}
				}
			
				//Initialize Grab_object variables
	            if (instance_exists(Grab_object)) {
	                if (Grab_object.frozen = false) {
	                    Grab_object.active = false;
	                    //unstick if sticky
	                    if (Grab_object.sticky) Grab_object.stuck = false
	                    Grab_object.Holder = self; //whose holding the item
	                    holding = 1; //Number of items being held
	                }
					
	                else Grab_object = noone;
	            }
			
	            if (instance_exists(Grab_object)) {
	                if (Grab_object.Team == Team or Grab_object.Team == noone) {
	                    Grab_object.active = false;
	                    //check if sticky
	                    if (Grab_object.sticky) Grab_object.stuck = false //unstick
	                    //set Holder
	                    Grab_object.Holder = self;
	                    holding = 1;
	                }
				
					else Grab_object = noone;
	            }
	        }
		}
    }
	
	//Move the grabbed object with the player
    scr_carry_object()
	
	///Aim with keyboard
	if input_method == CONTROLS_KEYBOARD{
		if Input_player.inputs[UP_KEY] == KEY_ISPRESSED{
			aim_direction = scr_change_keyboard_aim(aim_direction)
		}
	}
	
	//If grabbing object, throw it
    if (left_action_released) {
		//Grab onto a trampoline if nearby
		var Trampoline = instance_place(x + sign(dir) * GRAB_TOL, y, obj_trampoline)
		if not instance_exists(Trampoline){
			var Trampoline = instance_place(x - sign(dir) * GRAB_TOL, y, obj_trampoline)
		}
		if instance_exists(Trampoline){
			can_throw = false
			
			with Trampoline{
				if place_meeting(x - other.dir*GRAB_TOL, y, other) and not being_pulled{
					being_pulled = true
					Puller = other
				}
			
				else if Puller == other{
					hspeed = 0
					being_pulled = false
					Puller = noone
				}
			}
		}
		
	    if (instance_exists(Grab_object)) {
			can_throw = false
			
			if place_free(Grab_object.x, Grab_object.y){
	            if (holding > 1) {
	                holding = 0;
	                crouch = false;
					has_jetpack = false
					has_hang_glider = false
					gravity_incr = 0.4 //reset gravity from hang glider
					gravity_max = 10 //reset gravity from hang_glider
				
	                //throw
	                with(Grab_object) {
	                    //Throw using mouse
	                    if (other.input_method == CONTROLS_MOUSE) {
	                        scr_mouse_set_throw_dir(other.strength, mass, other.x, other.y, other.Input_player.mouseX, other.Input_player.mouseY, other.dir, false)
	                    }
					
						//Throw using arrow keys
	                    else if (other.input_method == CONTROLS_KEYBOARD) {
	                        scr_throw_using_keyboard(other.strength, mass, other.aim_direction, other.dir, false)
	                    }
						
						//Throw using the gamepad right joystick
						else{
							scr_throw_using_gamepad(other.strength, mass, other.Input_player.gamepad_aimx, other.Input_player.gamepad_aimy, false)
						}
                    
	                    //activate object
	                    active = true;
	                }
    
	                //remove Grab_object's Holder
	                Grab_object.Holder = noone;
	                Grab_object = noone;
				
	            }
	            else holding += 1;
	        }
	    }
		
		else {
	        crouch = false;
	        holding = 0;
		}
	}
	
	///Equip
	if (right_action_released){
        //Attempt to equip the item next to the player
        if instance_exists(instance_place(x + sign(dir) * GRAB_TOL, y, par_item)){
			can_throw = false
			ds_list_add(Equipped_objects, instance_place(x + sign(dir) * GRAB_TOL, y, par_item));

			//Remove the item from the game
			with Equipped_objects[| ds_list_size(Equipped_objects) - 1]{
				visible = false
				x = 0
				y = 0
			}
        }
    }

	///Gliding
	if has_hang_glider{
		if not climbing{
			if vspeed > 0{
				Grab_object.falling = false //for animation
				gravity_incr = 0.02
				gravity_max = 1
			}
		
			else{
				gravity_incr = 0.4
				gravity_max = 10
			}
		}
		
		//Press down to fall at normal speed
		if down_pressed{
			gravity_incr = 0.4
			gravity_max = 10
			Grab_object.falling = true //for animation
		}
	}

    //Handicap
    if (handicap_released) {
        //toggle arcing
        if (will_arc) will_arc = false;
        else will_arc = true;
    }
	
	///Fire
    if (right_action_released) {
		//Turn jetpack off
		if has_jetpack{
			if Grab_object.working{
				Grab_object.image_index = 0
			}
		}
		
		//Shoot a fireball
        if (energy > energy_fire) {
			//Ignite if holding an object that can blow up
            if (instance_exists(Grab_object)) {
                if (Grab_object.hp > Grab_object.hp_normal-1 or Grab_object.hp < Grab_object.hp_normal+1){
                    Grab_object.ignite = true;
                    Grab_object.hp = Grab_object.hp_normal;
                }
				
				//Otherwise perform fire action on it
                else Grab_object.hp -= 1;
            }
			
			//If the player isn't doing something else instead
			else if can_throw{
				//Throw
                with(instance_create_layer(x + 4, y + 4, "lay_instances", obj_ball)) {
					//if carrying a gun give the ball special stats
					scr_use_gun()
					
                    //direction of throwing based on mouse
                    if (other.input_method = CONTROLS_MOUSE) {
						scr_mouse_set_throw_dir(other.strength, mass, other.x, other.y, other.Input_player.mouseX, other.Input_player.mouseY, other.dir, other.has_gun)
                    }
					
                    //Throw using arrow keys
	                else if (other.input_method == CONTROLS_KEYBOARD) {
	                    scr_throw_using_keyboard(other.strength, mass, other.aim_direction, other.dir, other.has_gun)
	                }
					
					//Throw using the gamepad right joystick
					else{
						scr_throw_using_gamepad(other.strength, mass, other.Input_player.gamepad_aimx, other.Input_player.gamepad_aimy, other.has_gun)
					}
                    
                    //Initialize fireball variables
                    sprite_index = spr_ball_fire;
                    attack = 1;
                    Source = other.id;
                    
                    //handicap
                    if (other.will_arc) arc = true;
                }

            energy -= energy_fire;
            }
        }
    }

	//Ice action
    if (left_action_released) {
        if (freeze_holding_buffer >= 0) {
			//If the player isn't doing something else instead
			if can_throw{
				//Throw
		        if (energy > energy_fire) {
		            with(instance_create_layer(x + 4, y + 4, "lay_instances", obj_ball)) {
		                //Throw using mouse
		                if (other.input_method == CONTROLS_MOUSE) {
		                    scr_mouse_set_throw_dir(other.strength, mass, other.x, other.y, other.Input_player.mouseX, other.Input_player.mouseY, other.dir, other.has_gun)
		                }
					
						//Throw using arrow keys
	                    else if (other.input_method == CONTROLS_KEYBOARD) {
	                        scr_throw_using_keyboard(other.strength, mass, other.aim_direction, other.dir, other.has_gun)
	                    }
						
						//Throw using the gamepad right joystick
						else{
							scr_throw_using_gamepad(other.strength, mass, other.Input_player.gamepad_aimx, other.Input_player.gamepad_aimy, other.has_gun)
						}
                        
		                //activate object
		                active = true;
                        
		                //Initialize iceball stats
		                sprite_index = spr_ball_ice;
		                attack = -1; //add one health
		                Source = other.id;
						
						//if carrying a gun give the ball special stats
						scr_use_gun()
                        
		                //handicap
		                if (other.will_arc) arc = true;
		            }
		            //energy
		            energy -= energy_fire;
				}
			}
        }
		
		//If holding a block and trying to freeze it, do not throw
        else{
			//grab_released = false;
		}
		
        //Reset freeze buffer
        freeze_holding_buffer = freeze_holding_buffer_max;
    }
}

///Hp
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
	
//Collision with laser beam
with instance_place(x, y, obj_laser_beam){
	other.hp -= dmg
	instance_destroy()
}

//Collision with pirahnas
if(place_meeting(x,y,obj_pirahna)){
	hp -= 1;
}

//Collision with blown up big blocks
with (instance_place(x, y, obj_block_big)){
	if hp <= 0 {
		other.hp -= 10
	}
}

//Jump on trampolines
var min_jump_speed = 3
if place_meeting(x, y + vspeed/4, obj_trampoline){		
	//Bounce
	if vspeed > min_jump_speed{
		vspeed *= -1.1
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
		Team = other.Team
	    if (instance_exists(Input_player)) Input_player.gameCharacter = self;
	}
			
	//drop object if grabbed
	if (instance_exists(Grab_object)) {
	    //remove Grab_object's Holder
	    Grab_object.Holder = noone;
	    Grab_object.active = true;
	}
			
	//subtract life from team
	Team.tLives -= 1;
	if (Team.tLives < 0) Team.tLives = 0;
		
	//destroy self
	instance_destroy(self);
}

///Recharge Energy
if (place_meeting(x, y, obj_recharge_station)) {
	if (energy < energy_max) {
	    energy +=1;
	    }
	}
    
//Restore health with heart
with(instance_place(x, y, obj_health)) {
	//add health
	other.hp += value;
	//add lives
	other.Team.tLives += 1;
	//keep in bounds
	if (other.hp > other.hp_max) other.hp = other.hp_max;
	//destroy
	instance_destroy();
}

///Climbing
if climbing{
	//move carried objects with the player (since the player isn't active)
	scr_carry_object()
	
	//Drop with down key
	if(Input_player.inputs[DOWN_KEY] == KEY_PRESSED){
		//Make sure a player using the gamepad controls hasn't just dropped to hanging
		if input_method == CONTROLS_KEYBOARD or input_method == CONTROLS_MOUSE or gamepad_can_drop{
			//make sure the player has not just dropped down to the ledge
			if not dropped{	
				x -= climb_dir * 3
				climbing = false
				gravity_incr = 0.4
				active = true
			}
		}
	}
	
	if energy >= climbing_cost*2{
		//use fire to go up
		if place_free(x, y - 1){
			if (Input_player.inputs[RIGHTSELC_KEY] == KEY_ISPRESSED){
				vspeed = -1
				energy -= climbing_cost
			}
		}
			
		else vspeed = 0
			
		//use ice to go down
		if place_free(x, y + 1){
			if (Input_player.inputs[LEFTSELC_KEY] == KEY_ISPRESSED){
				vspeed = 1
				energy -= climbing_cost
			}
		}
			
		else vspeed = 0
			
		//Let go to stop
		if(Input_player.inputs[RIGHTSELC_KEY] == KEY_RELEASED) or (Input_player.inputs[LEFTSELC_KEY] == KEY_RELEASED){
			vspeed = 0
		}
		
		//If the player is within the hanging tolerance, change their state to hanging
		with instance_place(x + climb_dir * 4, y, all){
			with (other){
				if (y + y_diff > other.y - hanging_tol) and (y + y_diff < other.y + hanging_tol){
					if place_free(x + dir * 4, other.y - sprite_height){
						climbing = false
						scr_enter_hanging()
					}
				}
			}
	    }
	}
		
	else vspeed = 0
		
	//if the player is no longer touching a wall, make them fall
	if place_free(x + 3, y + y_diff) and place_free(x - 3, y + y_diff){
		climbing = false
		gravity_incr = 0.4
		active = true
	}
}

if hanging{
	//move carried objects with the player (since the player isn't active)
	scr_carry_object()
	
	//Move with platforms
	scr_hang_with_platforms()
	
	//Drop down with down key OR if whatever they are hanging onto disappears
	if(Input_player.inputs[DOWN_KEY] == KEY_PRESSED) or place_free(x + climb_dir * 3, y){
		//Make sure a player using the gamepad controls hasn't just dropped to hanging
		if input_method == CONTROLS_KEYBOARD or input_method == CONTROLS_MOUSE or gamepad_can_drop{
			//make sure the player has not just dropped down to the ledge
			if not dropped{	
				x -= climb_dir * 3
				hanging = false
				active = true
				gravity_incr = 0.4
			}
		}
	}
	
	//The player can lift themselves up
	if(Input_player.inputs[ACTION_KEY] == KEY_PRESSED){
		if place_free(x + climb_dir * 4, y - sprite_height){
			hanging = false
			x += climb_dir * 4
			y -= sprite_height - y_diff
			//apply gravity again after it was lost
			gravity_incr = 0.4
			//give a short pause before allowing players to move again
			alarm[1] = 5
		}
	}
}
	
///Win
if (place_meeting(x, y, obj_door)) {
    //win score
    Team.tScore += global.score_win/ds_list_size(Team.players);
    if !(global.win) Team.tScore += global.score_first; //first
    global.win = true;
	ds_list_destroy(Equipped_objects)
    instance_destroy();
    /*
    //subtract score for each player based on y
    for(var i=0; i<instance_number(obj_player); i++) {
        with (instance_find(obj_player,i)) global.playerScore[player_id] -= y_score*global.scoreY;
        }
    */
    }

//TODO Add cheat enabled button
///Cheats
if (keyboard_check_pressed(ord("U"))) {
    vspeed = -jump_height;
    hp = hp_max;
	active = true
    }

///Score
//Pick up coins
with (instance_place(x, y, obj_score)) {
    //add score
    with (other) Team.tScore += round(global.score_object/ds_list_size(Team.players));
	
    //destroy self
    instance_destroy();
}

//Set level
cLVL = ceil((room_height-y)/(room_height/10));
if (cLVL > Team.LVL) {
    Team.LVL = cLVL;
}

///Camera
//Move camera
if !(global.online) {
    obj_camera.x = x;
    obj_camera.y = y;
}

///Mooch
if (mooch_buffer < 0) {
    with (instance_place(x, y+16, obj_block)) {
        // mooch
        if (mooch_proof != other.Team.Team and mooch_proof != -1) {
			if obj_control.animation_on = true{
				if global.online{
		            instance_create_layer(x, y-32, "lay_instances", obj_mooch);
				}
				else{
					part_particles_create(obj_particle.ps_mooch, other.x, other.y, obj_particle.prt_mooch, 1)
						
					other.mooch_buffer = other.mooch_buffer_max;
				}
			}
        }
    }
}
else mooch_buffer--;
