/// @description Set variables

active = true; //Accepting input
Team = noone; //Belongs to no team
player_id = 0; //player id for score
jumps = 0;
crouch = false;
Grab_object = noone;
holding = 0; //holding - 0 for let go next time, 2 to throw
Equipped_objects = ds_list_create(); //the items that are equipped
equipped = 0; //how many items are equipped
Holder = noone; //who is holding self
sticky = false; //for grabbing
has_jetpack = false
has_hang_glider = false
y_score = room_height; //The heighest y coordinate the player has reached
mouseX = 0; //temporary variable to check if there is any change in the mouse
player_name = "";
freeze_holding_buffer_max = 10; //buffer to activate freezing of grabbed object
freeze_holding_buffer = freeze_holding_buffer_max;
clinging = false //whether or not the player is clinging to the side of a block
climbing = false //whether or not the player is climbing up a block
climbing_cost = 0.2 //how much energy it costs per step of climbing
climb_dir = 0 //direction the player is facing while climbing

///Stats (Set in scr_set_character_stats)
hp = 100;
hp_max = 100;
energy = 100;
energy_max = 100;
strength = 90;
mass = 24;
jumps_max = 1
jump_height = 8.5
energy_fire = 5;  //energy cost per fireball

///Physics
gravity_max = 10; //maximum speed a player can fall
gravity_incr = 0.4; //gravity acceleration
fric = 2 //How quickly the player slows down on land
drag = 0.3 //Set how quickly player's can change directions in air
acceleration = 0.5 //Set how quickly the player starts moving
will_arc = true; //Will the fireball arc

///Animation
image_speed = 0; //stop animation
image_index = 4;
crouch_frame = 9; //start frames later when crouching
frame_step = 0; //frame_step - current frame for animation
frame_buffer = 0; //frame_buffer - slow animation
frame_buffer_max = 4;
dir = 0; //Direction the player is facing, left= -1, right =1
mooch_buffer_max = 120;
mooch_buffer = 0;

///Input
player_input = 0; //number of player input in input array
Input_player = noone; //player object where to get input from, local or network
input_buffer = 0; //buffer for joystick input
input_buffer_max = 10;
input_method = CONTROLS_KEYBOARD; //the type of input: keyboard, mouse, joystick
// initiate isPressed variable outside, so they don't automatically reset
grab_is_pressed = false;
equip_is_pressed = false;
ice_is_pressed = false;
fire_is_pressed = false;



/// Artifacts
frozen = false; //character checks frozen state of grabbed object, player throwing concern
hp_normal = 100;
