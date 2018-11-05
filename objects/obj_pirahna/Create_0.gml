event_inherited();

//player_id - player id for score
player_id = 0;

//Set player variables
hp = 100;
hp_max = 100;
energy = 100;
energy_max = 100;
strength = 60;

//jumps - amount of jumps character has
jumps_max = 1;
jumps = 0;
//jump_height - inital vspeed of jump
jump_height = 6;

//gravity
gravity_max = 10;
//gravityI - gravity icreasing increment
gravityI = 0.4;
fric = .4 //Set all objects friction

//player_input
player_input = 0;
// Input_player - input player local or network
Input_player = noone;

//input_buffer - buffer for joystick input
input_buffer = 0;
input_buffer_max = 10;

//stop animation
image_speed = 0;
image_index = 4;
//start frames later when biting
bitingFrame = 9;
//frame_step - current frame for animation
frame_step = 0;
//frame_buffer - slow animation
frame_buffer = 0;
frame_buffer_max = 4;

//biting - whether or not character is biting
biting = false;

//grabing
grab_object = noone;

//holding - 0 for let go next time, 2 to throw
holding = 0;

//dir - direction of character
dir = 0;

//energy_fire - energy it takes for a fireball
energy_fire = 5;

//will_arc - whether or not ball arcs for player
will_arc = false;

//y_score - heighest y value reached
y_score = room_height;

/// initialize input variables

// input_method - the type of input, keyboard, mouse, joystick
input_method = CONTROLS_KEYBOARD;

// initiate isPressed variable outside, so they don't automatically reset
grab_is_pressed = false;
ice_is_pressed = false;
fire_is_pressed = false;

// mouseX - x position of mouse if mouse input
mouseX = 0;

