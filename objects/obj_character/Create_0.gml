/// @description Set variables

///General initializations
active = true; //Accepting input
Team = noone; //Belongs to no team
player_id = 0; //player id for score
jumps = 0;
crouch = false;
Holder = noone; //who is holding self
sticky = false; //for grabbing
y_score = room_height; //The heighest y coordinate the player has reached
mouseX = 0; //temporary variable to check if there is any change in the mouse
player_name = "";
freeze_holding_buffer_max = 10; //buffer to activate freezing of grabbed object
freeze_holding_buffer = freeze_holding_buffer_max;
can_throw = true
gamepad_drop_delay = 5 //Number of steps to wait before allowing the player to drop from hanging after dropping off an edge
gamepad_can_drop = true //Whether the player can drop down from a ledge when using the gamepad

///Item initializations
Grab_object = noone;
holding = 0; //holding - 0 for let go next time, 2 to throw
Equipped_objects = ds_list_create(); //the items that are equipped
has_jetpack = false
has_hang_glider = false

///Climbing intializations
climbing = false //whether the player is climbing to the side of a block (Pick only)
hanging = false //whether a player is hanging on an edge
y_diff = 0 //number of pixels in y direction the current state is from the standing state (for crouching)
climbing_cost = 0.4 //how much energy it costs per step of climbing
climb_dir = 0 //direction the player is facing while climbing

///Stats (Set in scr_set_character_stats)
hp = 100;
hp_max = 100;
energy = 100;
energy_max = 100;
strength = 90;
mass = 24;
jumps_max = 1
jump_height_max = 8.5
jump_height = jump_height_max
jump_timer_max = 10 //Max number of steps a player can hold for jump height
jump_timer = jump_timer_max //The number of steps the player has jumped
energy_fire = 5;  //energy cost per fireball

///Physics
is_jumping = false //whether the player is currently jumping or not
can_change_dir = true //initialize the player to be on the ground
air_dir = 0 //initialize the direction the player is traveling to be straight down
gravity_max = 10; //maximum speed a player can fall
gravity_incr = 0.4; //gravity acceleration
fric = 2 //How quickly the player slows down on land
drag = 0.15 //Set how quickly player's can change directions in air
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
//keyboard aiming variable
aim_direction = 0

// initiate isPressed variable outside, so they don't automatically reset
right_action_is_pressed = false;
left_action_is_pressed = false;
right_action_is_pressed = false;
jump_is_pressed = false;



/// Artifacts
frozen = false; //character checks frozen state of grabbed object, player throwing concern
hp_normal = 100;
