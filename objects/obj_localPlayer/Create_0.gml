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
inputs = array_create(array_length_2d(global.controls, controls));

// mouse input
mouseX = 0;
mouseY = 0;
 
input_buffer = 0; //small buffer to slow down gamepad input
input_buffer_max = 4;

///Join lobby
scr_joinLobby(other);

