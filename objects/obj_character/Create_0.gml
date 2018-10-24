/// @description  initialize variables
event_inherited();

//physics
active = true;
frozen = false;
mass = 8;
hpNormal = 100;

//team - team object
team = noone;

//playerId - player id for score
playerId = 0;

//Set player variables
hp = 100;
hp_max = 100;
energy = 100;
energy_max = 100;
strength = 90;

//jumps - amount of jumps character has
jumps = 0;

//jumpHeight - inital vspeed of jump
if (global.cooperativeMode) {
    jumpsMax = 1;
    jumpHeight = 6;
    }
else {
    jumpsMax = 2;
    jumpHeight = 6;
    }

//gravity
gravityMax = 10;
//gravityI - gravity icreasing increment
gravityI = 0.4;
fric = 2.4 //Set all objects friction

//playerInput
playerInput = 0;
// InputPlayer - player object where to get input from, local or network
InputPlayer = noone;

//inputBuffer - buffer for joystick input
inputBuffer = 0;
inputBufferMax = 10;

//stop animation
image_speed = 0;
image_index = 4;
//start frames later when crouching
crouchFrame = 9;
//frameStep - current frame for animation
frameStep = 0;
//frameBuffer - slow animation
frameBuffer = 0;
frameBufferMax = 4;

//crouch - whether or not character is crouching
crouch = false;

//grabing
grabObject = noone;
//holding - 0 for let go next time, 2 to throw
holding = 0;
//holder - who is holding self
holder = noone;
//sticky - for grabbing
sticky = false;
//jetpack
has_jetpack = false

//dir - direction of character
dir = 0;

//energyFire - energy it takes for a fireball
energyFire = 5;

//willArc - whether or not ball arcs for player
willArc = true;

//yMin - heighest y value reached
yMin = room_height;

// mouseX - temporary variable to check if there is any change in the mouse
mouseX = 0;

// moochBuffer
moochBufferMax = 120;
moochBuffer = 0;

// playerName
playerName = "";

/// initialize input variables

// inputType - the type of input, keyboard, mouse, joystick
inputType = CONTROLS_KEYBOARD;

// initiate isPressed variable outside, so they don't automatically reset
grabIsPressed = false;
iceIsPressed = false;
fireIsPressed = false;

// freezeHoldingBuffer - buffer to activate freezing of grabbed object
freezeHoldingBufferMax = 10;
freezeHoldingBuffer = freezeHoldingBufferMax;

