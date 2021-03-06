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
	jump_released = false;
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
                jump_pressed = true
				jump_is_pressed = true
			}
			else if (Input_player.inputs[ACTION_KEY] == KEY_RELEASED){
                jump_released = true
				jump_is_pressed = false
            }
			
            if(Input_player.inputs[LEFTSELC_KEY] == KEY_PRESSED) {
                left_action_pressed = true;
                left_action_is_pressed = true;
            }
            else if(Input_player.inputs[LEFTSELC_KEY] == KEY_RELEASED) {
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
		can_change_dir = true //Used with air_dir to prevent players from changing directions mid-air
		//Move if joystick is pushed far enough
	    if !(haxis1 > -axis_buffer and haxis1 < axis_buffer and vaxis1 > -axis_buffer and vaxis1 < axis_buffer) {
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
		//Set the direction the player is traveling if its the player just entered the air
		if can_change_dir air_dir = sign(hspeed)
		can_change_dir = false
		
		if !(haxis1 > -axis_buffer and haxis1 < axis_buffer and vaxis1 > -axis_buffer and vaxis1 < axis_buffer) {
			//If moving from a stop in air
			if hspeed == 0 and air_dir == 0{
				hspeed += haxis1 * drag
				air_dir = sign(hspeed)
			}
			
			//If moving from a stop in air
			if hspeed == 0 and sign(haxis1) == air_dir{
				hspeed += haxis1 * drag
			}

			//If going the same direction
			if sign(haxis1) == air_dir{
				if abs(hspeed) < moveSpeed{
					hspeed += sign(hspeed) * drag
				}
			}

			//If opposing direction
			if sign(haxis1) == -air_dir{
				if (abs(hspeed) - drag) > 0{
					hspeed = (abs(hspeed) - drag) * sign(hspeed)
				}
				else{
					hspeed = 0
				}
			}
				
			//Change player's direction
			if hspeed != 0 dir = sign(hspeed)
			else if input_method != CONTROLS_KEYBOARD dir = 0 //Keyboard controls use direction to show aim reticule
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
	
	///Hang and pick up objects below
	if down_pressed > axis_buffer{
		var down_grab = false //Check if the player grabbed an object with the down key
        //If not already holding something, attempt to grab the object below them
		if (place_meeting(x, y + 1, par_physics)) and not place_meeting(x, y + 1, obj_ball){
	        if (holding = 0) {
				Grab_object = (instance_place(x, y + 1, par_physics));
				
				//Initialize player variables for certain objects
				if instance_exists(Grab_object){
					if Grab_object.Holder == noone{
						//Can't grab frozen or stuck (with the down key)
						if not Grab_object.frozen and not Grab_object.stuck{
							//crouch
							crouch = true;
					
							if Grab_object.object_index == obj_jetpack{
								has_jetpack = true
							}
				
							if Grab_object.object_index == obj_hang_glider{
								has_hang_glider = true
							}
			
							//Initialize Grab_object variables
			                Grab_object.active = false;
			                Grab_object.Holder = self; //whose holding the item
							holding = 2; //Throw the item immediately with a left action
							down_grab = true
						}
						else Grab_object = noone
					}
					else Grab_object = noone
				}
				else Grab_object = noone
	        }
		}
		
		//Use down key to move from the top of a ledge to hanging position if an object was grabbed
		if not down_grab{
			//Check if there is a block under the player's left side
			var Inst = instance_position(x + 4, y + sprite_height + 1, par_block)
			//Otherwise check if there is a block under the player's right side
			if Inst == noone{
				Inst = instance_position(x - 4 + sprite_width, y + sprite_height + 1, par_block)
			}
		
			//If there is a block below the player attempt to climb down
			if Inst != noone{
				//If this is something that can be climbed
				if Inst.climbable{
					//Hang on right side if right foot is off the side of block
					if position_empty(x + sprite_width, y + sprite_height + 1){
						//If there is room to climb down
						if place_free(Inst.x + Inst.sprite_width, Inst.y) and place_free(Inst.x + Inst.sprite_width, Inst.y - sprite_height){
							x = Inst.x + Inst.sprite_width - PLAYER_TOL
							y = Inst.y - y_diff
							dir = -1
							hspeed = 0
							vspeed = 0
							//If the players feet is not touching the ground
							if place_free(x, y + 1){
								climb_dir = dir
								gravity_incr = 0
								active = false
								hanging = true
							}
							dropped = true
							if input_method != CONTROLS_MOUSE and input_method != CONTROLS_KEYBOARD{
								alarm[2] = gamepad_drop_delay
								gamepad_can_drop = false
							}
						}
					}

					//Hang on left side if left foot is off the side of block
					else if position_empty(x, y + sprite_height + 1){
						//If there is room to climb down
						if place_free(Inst.x - sprite_width, Inst.y) and place_free(Inst.x - sprite_width, Inst.y - sprite_height){
							x = Inst.x - sprite_width + PLAYER_TOL
							y = Inst.y - y_diff
							dir = 1
							hspeed = 0
							vspeed = 0
							//If the players feet is not touching the ground
							if place_free(x, y + 1){
								climb_dir = dir
								gravity_incr = 0
								active = false
								hanging = true
							}
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
	//Can begin jumping on ground
	if !place_free(x, y + 2){
		if (jump_pressed) {
			jump_height = jump_height_max
			is_jumping = true
			//Calculate the maximum jump height
			//Subtract mass from jump_height
			if instance_exists(Grab_object){
				if strength >= Grab_object.mass{
					//Jump a little higher to make up for crouching
					jump_height += 0.4
				}
				else{
					jump_height += 0.4 - (Grab_object.mass - strength)/3
				}
			}
		}
		jump_timer = jump_timer_max //After the max has been calculated set the jump height to it.
	}
	
	//Continue jumping as long as they hold down
	if is_jumping{
		if jump_is_pressed{
			if jump_timer > 0{
				//Use the timer to smoothly decrease the jump speed
				vspeed = -(jump_height - jump_timer * gravity_incr / jump_timer_max)
				jump_timer -= 1
			}
			else is_jumping = false
	    }
    }
	
	//Once they stop jumping they can't start again, even if they have jump_timer left
	if jump_released{
		is_jumping = false
	}
	
	//Perform a wall jump if the player just hit a wall
	if abs(wall_jump_speed) > 0{
		hspeed = wall_jump_speed
		vspeed -= 2
		wall_jump_speed = 0
	}

    ///Block collisions
    with(instance_place(x + sign(hspeed) * 2, y, par_physics)){
		//Push blocks
        if (id != other.Grab_object and not frozen and not ignite and not stuck) {
            x+=scr_contactx(other.hspeed);
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
	//If the player is holding down on the fire button and not using a jetpack perform a wall jump
	if right_action_is_pressed and not has_jetpack{
		//Wall jump setup
		if !place_free(x+hspeed, y){
			if place_free(x, y + 2) and place_free(x, y + 16){
				//If the player is clearly attempting a wall jump don't let them shoot a fireball when they release fire
				dont_fire = true
				if vspeed < 0 and abs(hspeed) > (moveSpeed - 1){ 
					wall_jump_speed = -hspeed
					air_dir *= -1
				}
			}
		}
	}
	
	//Horizotal collision
    while(!place_free(x+hspeed, y)) {
        hspeed = scr_reduce(hspeed);
        if hspeed = 0 break;
    }

	//Vertical collision
    while(!place_free(x+hspeed,y+vspeed)) {
        vspeed = scr_reduce(vspeed);
        if vspeed = 0 {
            //reset jumps
            jumps = jumps_max;
			//stop the current jump if the player hits their head on a block
			is_jumping = false
            break;
        }
    }

	//Climb blocks that are open and within 2 pixels left or right of the middle of the player
	with(instance_position(x + max(dir*sprite_width, 0), y + sprite_height/2 + y_diff/2, par_block)){
		if (id != other.Grab_object and climbable){
			//Change the character's variables
			with (other){
				scr_attempt_climbing()
			}
        }
	}
	
	///Platforms
	//Match speed of platforms
	scr_move_with_platform()

	//Jetpack flying
	if right_action_is_pressed and has_jetpack and Grab_object.working{
		if energy >= Grab_object.jetpack_cost{
			can_change_dir = true //Allow the player to change directions mid-air while flying
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
		if (place_meeting(x + sign(dir) * GRAB_TOL, y, par_physics)) and not place_meeting(x + sign(dir) * GRAB_TOL, y, obj_ball){
			
	        if (holding = 0) {
		
				Grab_object = (instance_place(x+sign(dir) * GRAB_TOL, y, par_physics));
				
				if instance_exists(Grab_object){
					//No grabbing items from other player's hands
					if Grab_object.Holder == noone{
						//Initialize variables for certain objects
						if Grab_object.object_index == obj_jetpack{
							has_jetpack = true
						}
				
						if Grab_object.object_index == obj_hang_glider{
							has_hang_glider = true
						}
			
						//Initialize Grab_object variables
			            if Grab_object.frozen = false{
			                Grab_object.active = false;
			                //unstick if sticky
			                if (Grab_object.sticky) Grab_object.stuck = false
			                Grab_object.Holder = self; //whose holding the item
			                holding = 1; //Number of items being held
			            }
			            else Grab_object = noone
			        }
					else Grab_object = noone
				}
				else Grab_object = noone
	        }
		}
		///Player carrying
		if !instance_exists(Grab_object){
			Grab_object = (instance_place(x+sign(dir) * GRAB_TOL, y, obj_character))
			//Make sure the player was grabbed
			if instance_exists(Grab_object){
				//Make sure the player isn't holding an item
				if Grab_object.Grab_object == noone{
					//Make sure the player is on your team
					if Grab_object.Team != Team{
						Grab_object = noone
					}
					else{
						with Grab_object{
							active = false
						}
						Grab_object.Holder = self
						holding = 1
					}
				}
				else Grab_object = noone
			}
			else Grab_object = noone
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
			can_throw = false //Don't throw a fireball if grabbing an item
			dont_fire = true //Don't ignite a block/corpse if grabbing an item
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
				can_change_dir = true //Allow the player to change directions mid-air while gliding
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
			if not dont_fire{
				//Ignite if holding an object that can blow up
		        if (instance_exists(Grab_object)){
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
						//Initialize fireball variables
	                    sprite_index = spr_ball_fire;
	                    attack = 1;
	                    Source = other.id;
					
						//if carrying a gun give the ball special stats
						var has_gun = scr_use_gun()
					
	                    //direction of throwing based on mouse
	                    if (other.input_method = CONTROLS_MOUSE) {
							scr_mouse_set_throw_dir(other.strength, mass, other.x, other.y, other.Input_player.mouseX, other.Input_player.mouseY, other.dir, has_gun)
	                    }
					
	                    //Throw using arrow keys
		                else if (other.input_method == CONTROLS_KEYBOARD) {
		                    scr_throw_using_keyboard(other.strength, mass, other.aim_direction, other.dir, has_gun)
		                }
					
						//Throw using the gamepad right joystick
						else{
							scr_throw_using_gamepad(other.strength, mass, other.Input_player.gamepad_aimx, other.Input_player.gamepad_aimy, has_gun)
						}
                    
	                    //handicap
	                    if (other.will_arc) arc = true;
	                }

	            energy -= energy_fire;
	            }
	        }
			else dont_fire = false //Reset the dont_fire so the next time the player releases the key they shoot
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
						//Initialize iceball stats
		                sprite_index = spr_ball_ice;
		                attack = -1; //add one health
		                Source = other.id;
						
						//if carrying a gun give the ball special stats
						var has_gun = scr_use_gun()
						
		                //Throw using mouse
		                if (other.input_method == CONTROLS_MOUSE) {
		                    scr_mouse_set_throw_dir(other.strength, mass, other.x, other.y, other.Input_player.mouseX, other.Input_player.mouseY, other.dir, has_gun)
		                }
					
						//Throw using arrow keys
	                    else if (other.input_method == CONTROLS_KEYBOARD) {
	                        scr_throw_using_keyboard(other.strength, mass, other.aim_direction, other.dir, has_gun)
	                    }
						
						//Throw using the gamepad right joystick
						else{
							scr_throw_using_gamepad(other.strength, mass, other.Input_player.gamepad_aimx, other.Input_player.gamepad_aimy, has_gun)
						}
                        
		                //activate object
		                active = true;
                        
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
min_jump_speed = 4
with instance_place(x, y + vspeed/4, obj_trampoline){
	//Players can use the down key to NOT jump on the trampoline
	if not toppled and (not(other.down_pressed > other.axis_buffer) or other.has_hang_glider){
		other.can_change_dir = true //Act as if the player had just touched the ground
		//Bounce
		if other.vspeed > other.min_jump_speed{
			other.vspeed *= -1.1
		}
	}
}

//Push back over toppled trampolines
with instance_place(x + hspeed, y, obj_trampoline){
	if toppled{
		//If the player is off the ground
		with other{
			if place_free(x + hspeed, y + 4){
				//change trampoline's stats
				with other{
					//If the player is traveling a direction that would push it upright with a little speed, push it back over
					if (image_index == 0 and other.hspeed < 2) or (image_index == 1 and other.hspeed > 2){
						sprite_index = spr_trampoline
						toppled = false
						//Center the object for more natural look
						if image_index == 1{
							x += sprite_width/2
						}
					}
				}
			}
		}
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

///Break free from player with down key if grabbed
if Input_player.inputs[DOWN_KEY] == KEY_PRESSED{
	if Holder != noone{
		Holder.Grab_object = noone
		Holder.holding = 0
		Holder.crouch = false
		Holder = noone
		active = true
	}
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
				x -= climb_dir * 5
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
		with instance_place(x + max(climb_dir * sprite_width, 0) + climb_dir * 4, y, all){
			//Change the player's stats
			with (other){
				if (y + y_diff >= other.y) and (y + y_diff < other.y + HANGING_TOL/2){
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
	if place_free(x + PLAYER_TOL + 3, y + y_diff) and place_free(x - PLAYER_TOL - 3, y + y_diff){
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
	if(Input_player.inputs[DOWN_KEY] == KEY_PRESSED) or place_free(x + climb_dir * 4, y){
		//Make sure a player using the gamepad controls hasn't just dropped to hanging
		if input_method == CONTROLS_KEYBOARD or input_method == CONTROLS_MOUSE or gamepad_can_drop{
			//make sure the player has not just dropped down to the ledge
			if not dropped{	
				x -= climb_dir * (2 + PLAYER_TOL)
				hanging = false
				active = true
				gravity_incr = 0.4
			}
		}
	}
	
	//The player can lift themselves up
	if(Input_player.inputs[ACTION_KEY] == KEY_PRESSED){
		//Climb if there is a pushable object on top of the ledge (climb_dir * 12 to make sure the block isn't hanging over the ledge)
		var Inst = instance_position(x + max(climb_dir*sprite_width, 0) + climb_dir * 12, y - sprite_height/2, par_physics)
		if Inst != noone{
			//Only push the block if it is in the way
			if abs(Inst.x - x) <= sprite_width + 4{
				Inst.x += climb_dir * 4
			}
			scr_climb()
		}
		
		//Climb if the ledge is open
		else if place_free(x + climb_dir * 4, y - sprite_height){
			scr_climb()
		}
		
		//If the player is hanging on a platform make an exception to allow climbing while moving downward
		else if instance_place(x + climb_dir * 4, y, obj_platform){
			//Move whatever is on the platform
			if Inst != noone{
				if abs(Inst.x - x) <= sprite_width + 4{
					Inst.x += climb_dir * 4
				}
				scr_climb()
			}
			if place_free(x + climb_dir * 4, y - sprite_height - obj_platform.move_speed){
				scr_climb()
			}
		}	
	}
}

///Key
//Collect the key to unlock the door
with instance_place(x, y, obj_key){
	obj_door.is_locked = false
	obj_door.sprite_index = spr_door
	instance_destroy()
}
	
///Win
with (instance_place(x, y, obj_door)){
	if not is_locked{
		with other{
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
	}
}

//TODO Add cheat enabled button
///Cheats
if (keyboard_check_pressed(ord("U"))) {
	can_change_dir = true //Allow the player to change directions mid-air while cheating
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
			if global.Menu.animations_on = true{
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
