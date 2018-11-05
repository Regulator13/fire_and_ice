/// @description Initialize variables
event_inherited();

player_id = 0; //for score
player_input = 0;
Input_player = noone; //input player local or network
jumps = 0;
biting = false; //whether or not character is biting
grab_object = noone;
holding = 0;
will_arc = false; //whether or not ball arcs for player
y_score = room_height; //Heighest y-coordinate the player has reached

///Stats
hp = 100;
hp_max = 100;
energy = 100;
energy_max = 100;
strength = 60;
jumps_max = 1;
jump_height = 6;
energy_fire = 5; //energy it takes for a fireball

///Physics
gravity_max = 10; 
gravityI = 0.4; //Acceleration while falling
fric = .4 //friction

///Input
input_buffer = 0; //buffer for joystick input
input_buffer_max = 10;
input_method = CONTROLS_KEYBOARD; //input: keyboard, mouse, joystick

//Animation
image_speed = 0;
image_index = 4;
mouseX = 0; //x position of mouse if mouse input
dir = 0; //Direction the character is facing
//start frames later when biting
bitingFrame = 9;
//frame_step - current frame for animation
frame_step = 0;
//frame_buffer - slow animation
frame_buffer = 0;
frame_buffer_max = 4;

// initiate isPressed variable outside, so they don't automatically reset
grab_is_pressed = false;
ice_is_pressed = false;
fire_is_pressed = false;
