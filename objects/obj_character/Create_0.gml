/// @description Initializations

active = true; //Accepting input
team = noone; //Belongs to no team
playerId = 0; //player id for score
jumps = 0;
crouch = false;
grabObject = noone;
holder = noone; //who is holding self
sticky = false; //for grabbing
has_jetpack = false
y_score = room_height; //The heighest y coordinate the player has reached
mouseX = 0; //temporary variable to check if there is any change in the mouse
playerName = "";
freezeHoldingBufferMax = 10; //buffer to activate freezing of grabbed object
freezeHoldingBuffer = freezeHoldingBufferMax;

//Stats (Set in scr_set_character_stats)
hp = 100;
hp_max = 100;
energy = 100;
energy_max = 100;
strength = 90;
mass = 24;
jumps_max = 1
jump_height = 8.5
energyFire = 5;  //energy cost per fireball

//Physics
gravity_max = 10; //maximum speed a player can fall
gravityI = 0.4; //gravity acceleration
fric = 2.4 //How quickly the player slows down on land
drag = 0.3 //Set how quickly player's can change directions in air
acceleration = 0.5 //Set how quickly the player starts moving
willArc = true; //Will the fireball arc

//Animation
image_speed = 0; //stop animation
image_index = 4;
crouchFrame = 9; //start frames later when crouching
frameStep = 0; //frameStep - current frame for animation
frameBuffer = 0; //frameBuffer - slow animation
frameBufferMax = 4;
dir = 0; //Direction the player is facing, left= -1, right =1
moochBufferMax = 120;
moochBuffer = 0;

///Input
playerInput = 0; //number of player input in input array
InputPlayer = noone; //player object where to get input from, local or network
inputBuffer = 0; //buffer for joystick input
inputBufferMax = 10;
inputType = CONTROLS_KEYBOARD; //the type of input: keyboard, mouse, joystick
// initiate isPressed variable outside, so they don't automatically reset
grabIsPressed = false;
iceIsPressed = false;
fireIsPressed = false;



/// Artifacts
frozen = false; //character checks frozen state of grabbed object, player throwing concern
hpNormal = 100;
holding = 0; //holding - 0 for let go next time, 2 to throw
//jump_height - inital vspeed of jump
if (global.cooperative_mode) {
    jumps_max = 1;
    jump_height = 6;
    }
else {
    jumps_max = 2;
    jump_height = 8.5;
    }