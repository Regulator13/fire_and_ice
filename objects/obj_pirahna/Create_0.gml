event_inherited();

//playerId - player id for score
playerId = 0;

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

//playerInput
playerInput = 0;
// InputPlayer - input player local or network
InputPlayer = noone;

//inputBuffer - buffer for joystick input
inputBuffer = 0;
inputBufferMax = 10;

//stop animation
image_speed = 0;
image_index = 4;
//start frames later when biting
bitingFrame = 9;
//frameStep - current frame for animation
frameStep = 0;
//frameBuffer - slow animation
frameBuffer = 0;
frameBufferMax = 4;

//biting - whether or not character is biting
biting = false;

//grabing
grabObject = noone;

//holding - 0 for let go next time, 2 to throw
holding = 0;

//dir - direction of character
dir = 0;

//energyFire - energy it takes for a fireball
energyFire = 5;

//willArc - whether or not ball arcs for player
willArc = false;

//y_score - heighest y value reached
y_score = room_height;

/// initialize input variables

// inputType - the type of input, keyboard, mouse, joystick
inputType = CONTROLS_KEYBOARD;

// initiate isPressed variable outside, so they don't automatically reset
grabIsPressed = false;
iceIsPressed = false;
fireIsPressed = false;

// mouseX - x position of mouse if mouse input
mouseX = 0;

