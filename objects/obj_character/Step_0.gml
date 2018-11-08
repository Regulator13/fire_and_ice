/// @description Input

if (active) {
	///Local Initializations
	var moveSpeed;
    var gravity_max;
	
    ///Input resets
    haxis1 = 0;
    vaxis1 = 0;
	down_pressed = 0
    jump_pressed = false;
    ice_pressed = false;
    ice_released = false;
    handicap_released = false;
    grab_pressed = false;
    grab_released = false;
	equip_pressed = false;
    equip_released = false;
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
			if(Input_player.inputs[DOWN_KEY]) down_pressed = 1;
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
				equip_pressed = true;
				equip_is_pressed = true;
            }
			
            else if (Input_player.inputs[RIGHTSELC_KEY] == KEY_RELEASED) {
                fire_released = true;
                fire_is_pressed = false;
				equip_released = true;
				equip_is_pressed = false;
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
			if (!ice_is_pressed and !fire_is_pressed) or has_jetpack{
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
			else dir = 0
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
	        if (!ice_is_pressed and !fire_is_pressed) or has_jetpack{
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
				else dir = 0
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
    if (crouch) image_index += crouch_frame;
	
	///Score
    //update y_score
    if (y < y_score) y_score = y;

    ///Jump
    if (jumps > 0) {
	    if (jump_pressed) {
			//Subtract mass from jump_height
			if instance_exists(Grab_object){
				var total_mass = mass + Grab_object.mass
			}
			
			else var total_mass = mass

	        vspeed = -(jump_height - total_mass / 12);
	        jumps -= 1;
	    }
    }

    ///Block collisions
    with(instance_place(x+sign(hspeed)*2,y,par_physics)){
		//Push blocks
        if (id != other.Grab_object and not frozen and !stuck) {
            x+=scr_contactx(other.hspeed);
        }
		
		//Climb blocks
		if (id != other.Grab_object) and (frozen or stuck){
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
	
	///Trampoline pushing
	with(instance_place(x + sign(hspeed)*2, y, obj_trampoline)){
        x += scr_contactx(other.hspeed);
    }

    ///Gravity
    if (vspeed < gravity_max) {
        //gravity increment
        vspeed += gravity_incr
        }
		
    //keep gravity in bounds
    if (vspeed > gravity_max) vspeed = gravity_max;

	///Platforms
	//Match speed of platforms
	with instance_place(x, y+vspeed, obj_platform){
		//Vertical
		if is_vertical{
			other.y += (vspeed + sign(vspeed)*other.gravity_incr)
			
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
	
    
    ///Collisions
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
            break;
        }
    }

    ///Fire
    if (fire_released) {
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
                if (Grab_object.hp > Grab_object.hp_normal-1 or Grab_object.hp < Grab_object.hp_normal+1) { //lasers subtract decimal points
                    Grab_object.ignite = true;
                    Grab_object.hp = Grab_object.hp_normal;
                }
				
				//Otherwise perform fire action on it
                else Grab_object.hp -= 1;
            }
			
			//Throw
            else {
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
                    
                    //Initialize fireball variables
                    sprite_index = spr_ballFire;
                    attack = 1;
                    Source = other.id;
					
					//if carrying a gun give the ball special stats
					scr_use_gun()
                    
                    //handicap
                    if (other.will_arc) arc = true;
                }

            energy -= energy_fire;
            }
        }
            /* 
			if online player, unpress key
            if (player_input == -1) Input_player.inputs[RIGHTSELC_KEY] = scr_toggleKey(Input_player.inputs[RIGHTSELC_KEY]); //unpress key
			*/
    }
	
	//Jetpack flying
	if fire_is_pressed and has_jetpack and Grab_object.working{
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
    if (ice_is_pressed) freeze_holding_buffer--;
	
    //freeze the block being held
    if (freeze_holding_buffer < 0) {
        // check if enough energy
        if (energy > energy_fire) {
            // if holding an block, set timer to freeze it
            if (instance_exists(Grab_object)) {
                if (Grab_object.hp > Grab_object.hp_normal-1 or Grab_object.hp < Grab_object.hp_normal+1) { //lasers subtract decimal points
                    Grab_object.will_freeze = true;
                    Grab_object.hp = Grab_object.hp_normal;
                }
				
                else Grab_object.hp += 1;
            }
        }
    }
    
	//Ice action
    if (ice_released) {
        if (freeze_holding_buffer >= 0) {
            //If not about to grab an object
            if !(place_meeting(x + sign(dir) * 4, y, par_physics)) {
				grab_pressed = false;
				
				//Throw
                if (energy > energy_fire) {
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
                        
                        //Initialize iceball stats
                        sprite_index = spr_ballIce;
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
            /*
			// if online player, unpress key
            if (player_input == -1) {
                Input_player.inputs[LEFTSELC_KEY] = scr_toggleKey(Input_player.inputs[LEFTSELC_KEY]); //unpress key
                }
			*/
            }
        }
		
		//If holding a block and trying to freeze it, do not throw
        else{
			grab_released = false;
		}
		
        //Reset freeze buffer
        freeze_holding_buffer = freeze_holding_buffer_max;
    }

    ///Grabbing
    if (grab_pressed) {
        //crouch
        crouch = true;
		
        //If not already holding something, attempt to grab close thing
        if (holding = 0) {
			Grab_object = (instance_place(x+sign(dir)*4,y,par_physics));
			
            if !instance_exists(Grab_object){
				Grab_object = (instance_place(x+sign(dir)*4,y,obj_character));
			}
			
			//Initialize has_jetpack if grabbing a jetpack
			if instance_exists(Grab_object){
				if Grab_object.object_index == obj_jetpack{
					has_jetpack = true
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
	
	//Move the grabbed object with the player
    if (instance_exists(Grab_object)) {
	    Grab_object.x = x+hspeed;
	    Grab_object.y = y-9+vspeed;
    }
	
	//If grabbing object, throw it
    if (grab_released) {
        if (instance_exists(Grab_object)) {
            if (holding > 1) {
                holding = 0;
                crouch = false;
				has_jetpack = false
				
                //throw
                with(Grab_object) {
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
    
                //remove Grab_object's Holder
                Grab_object.Holder = noone;
                Grab_object = noone;
				
            }
            else holding += 1;
        }
		
        else {
            crouch = false;
            holding = 0;
        }
    }
	
	///Equip
	if (equip_pressed){
        //Attempt to equip the item next to the player
        if instance_exists(instance_place(x + sign(dir)*4, y, par_item)){
			ds_list_add(Equipped_objects, instance_place(x + sign(dir)*4, y, par_item));

			//Remove the item from the game
			with Equipped_objects[| ds_list_size(Equipped_objects) - 1]{
				active = false
				x = 0
				y = 0
			}
        }
    }

    //Handicap
    if (handicap_released) {
        //toggle arcing
        if (will_arc) will_arc = false;
        else will_arc = true;
    }
}

///REMOVE? This is a duplicated if statment
if active{
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
	if (place_meeting(x, y, obj_rechargeStation)) {
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
            instance_create_layer(x, y-32, "lay_instances", prt_mooch);
            other.mooch_buffer = other.mooch_buffer_max;
        }
    }
}

else mooch_buffer--;
