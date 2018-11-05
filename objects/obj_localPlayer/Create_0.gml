/// @description initialize variables

//character
character = "";
//team
team = 0;
// ready - whether player is ready to move to next menu
ready = false;
// name - player name
name = "Player";
//player_id - accumulative global number to identify player
player_id = 0;
//input - input character is using
input = 0;
//gameCharacter - character in game
gameCharacter = noone;
//startX and startY - starting coordinates
startX = 0;
startY = 0;

/// input

// connectID - order in which player connected, used in lobby code
connectID = global.player_total++;

// controls - input index in controls array
controls = 0;

// inputs - array holding the current state of each input
inputs = array_create(array_length_2d(global.controls, controls));
// mouse input
mouseX = 0;
mouseY = 0;

//input_buffer - small buffer to slow down gamepad input
input_buffer = 0;
//input_buffer_max
input_buffer_max = 4;

/// join lobby

// join the client into the lobby
scr_joinLobby(other);

