/// @description Input

///Local initializations
var moveSpeed;
var gravity_max;
var biting;

///Reset inputs
haxis1 = 0;
vaxis1 = 0;
jump_pressed = false;
ice_pressed = false;
ice_released = false;
handicap_released = false;
grab_pressed = false;
grab_released = false;
right_action_pressed = false;
right_action_released = false;
axis_buffer = 0.4; //buffer till push starts counting

//For joystick input
if (input_buffer > 0){
	input_buffer -= 1;
}

///Input
switch(player_input) {
    case -1:
	
    case 1:
        // online input
        if(Input_player.inputs[LEFT_KEY]) haxis1 = -1;
        if(Input_player.inputs[RIGHT_KEY]) haxis1 = 1;
        if(Input_player.inputs[UP_KEY] == KEY_PRESSED) vaxis1 = -1;
        if(Input_player.inputs[DOWN_KEY] == KEY_PRESSED) vaxis1 = 1;
		
        if(Input_player.inputs[ACTION_KEY] == KEY_PRESSED) {
            jump_pressed = true;
            //unpress key //REMOVE? This is commented out in obj_character
            Input_player.inputs[ACTION_KEY] = KEY_RELEASED;
        }
		
        if(Input_player.inputs[LEFTSELC_KEY] == KEY_PRESSED) {
            ice_pressed = true;
            ice_is_pressed = true;
            grab_pressed = true;
            grab_is_pressed = true;
        }
		
        if(Input_player.inputs[LEFTSELC_KEY] == KEY_RELEASED) {
            ice_released = true;
            ice_is_pressed = false;
            grab_released = true;
            grab_is_pressed = false;
        }
		
        if (Input_player.inputs[RIGHTSELC_KEY] == KEY_PRESSED) {
            right_action_pressed = true;
            right_action_is_pressed = true;
        }
		
        if (Input_player.inputs[RIGHTSELC_KEY] == KEY_RELEASED) {
            right_action_released = true;
            right_action_is_pressed = false;
        }
		
        break;
	
	///Computer player input
    case 0:
        if (alarm[0] <= 0) {
            haxis1 = choose(1, 0, -1);
            haxis1 = choose(1, 0, -1);
            action = choose(false, true);
            alarm[0] = irandom_range(10, 20);
        }
		
        break;
}
    
//Variable changes if player is underwater
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
    
///Hspeed
if !(haxis1 > -axis_buffer and haxis1 < axis_buffer and vaxis1 > -axis_buffer and vaxis1 < axis_buffer) {
    hspeed = haxis1*move_speed;
	
    //direction
    if (hspeed != 0) dir = sign(hspeed);
	else dir = 0
}

//Stop at obstacles
else{
    if (!place_free(x+hspeed,y+1)) hspeed = 0;
    }

//If mouse controls, set direction based on mouse
if (input_method == CONTROLS_MOUSE){
    if (Input_player.mouseX != mouseX){
        if (Input_player.mouseX > x) dir = 1;
		
        else dir = -1;
		
        mouseX = Input_player.mouseX;
    }
}
             
//image
switch (dir){
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
    
///Animation
if (hspeed != 0) {
    if (frame_buffer < 0) {
        frame_step += 1;
        frame_buffer = frame_buffer_max;
    }
	
    else frame_buffer --;
}

//keep animation in bounds
if (frame_step > 3) frame_step = 0;

//biting image
if (biting) image_index += bitingFrame;

//------------------------------------------------------------------
//Main Code
//------------------------------------------------------------------
    
//update y_score
if (y < y_score){
	y_score = y;
}

//Jump
if (jumps > 0) {
    if (jump_pressed) {
        vspeed = -jump_height;
        jumps -= 1;
    }
}

//Push blocks
with(instance_place(x+sign(hspeed)*2,y,par_physics))
    {
    if (id != other.Grab_object and not frozen and not stuck) {
        x+=scr_contactx(other.hspeed);
    }
}

///Physics
if (vspeed < gravity_max) {
    vspeed += gravity_incr
}

//keep gravity in bounds
if (vspeed > gravity_max) vspeed = gravity_max;
    
//Collisions
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

//Destory blocks if stuck in them
if (right_action_pressed) {
    with (instance_place(x, y, obj_block)) instance_destroy();
    with (instance_place(x, y, obj_corpse)) instance_destroy();
}

//Reset jumps the player if is below water
if(y > room_height-obj_wall.sprite_height-obj_control.water_height){
    jumps = jumps_max;
}

//Pick up coins
with (instance_place(x, y, obj_score)) {
    //add score
    with (other) Team.tScore += round(global.score_object/ds_list_size(Team.players));
	
    //destroy self
    instance_destroy();
}
