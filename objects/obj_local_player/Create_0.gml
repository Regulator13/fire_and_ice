/// @description Set variables

character = ""; //NAME? DESCR?
Team = 0; //What team the player is on 
ready = false; //whether player is ready to move to next menu
name = "Player"; //The player's name
player_id = 0; //accumulative global number to identify player
input = 0; //input type the character is using
gameCharacter = noone; //DESCR?
startX = 0;
startY = 0;

///Input
connectID = global.player_total++; //order in which player connected, used in lobby code
controls = 0; //input index in controls array

// inputs - array holding the current state of each input
inputs_length = array_length_2d(global.controls, controls)
inputs = array_create(inputs_length);

// mouse input
mouseX = 0;
mouseY = 0;
//gamepad aiming
gamepad_aimx = 0//value -1 to 1, right joystick
gamepad_aimy = 0//value -1 to 1, right joystick
 
input_buffer = 0; //small buffer to slow down gamepad input
input_buffer_max = 4;

///Join lobby
scr_join_lobby(other);

