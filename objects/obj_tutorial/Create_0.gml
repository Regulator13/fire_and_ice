/// @description Initiate tutorial
///Set variables
messages = ds_list_create(); //tutorial messages
showTime = 30*8; //time each message shows
currentMessage = 0; //current message to show

//start tutorial
alarm[0] = showTime;

//set up message
var control = global.Menu.local_controls[| 0];

//set which controls to display in message
var left = scr_getInputName(global.controls[control, LEFT_KEY], LEFT_KEY, global.controls[control, KEY_TYPE]);
var right = scr_getInputName(global.controls[control, RIGHT_KEY], RIGHT_KEY, global.controls[control, KEY_TYPE]);
var jump = scr_getInputName(global.controls[control, ACTION_KEY], ACTION_KEY, global.controls[control, KEY_TYPE]);
var ice = scr_getInputName(global.controls[control, LEFTSELC_KEY], LEFTSELC_KEY, global.controls[control, KEY_TYPE]);
var fire = scr_getInputName(global.controls[control, RIGHTSELC_KEY], RIGHTSELC_KEY, global.controls[control, KEY_TYPE]);
var aim;
switch (global.controls[control, KEY_TYPE]) {
    case CONTROLS_MOUSE:
        aim = "the mouse";
        break
		
    case CONTROLS_KEYBOARD:
        var up = scr_getInputName(global.controls[control, UP_KEY], UP_KEY, global.controls[control, KEY_TYPE]);
        var down = scr_getInputName(global.controls[control, DOWN_KEY], DOWN_KEY, global.controls[control, KEY_TYPE]);
        aim = up + " and " + down;
}

//TODO Update tutorial
//add message in order
ds_list_add(messages, "Welcome to Dust: Fire and Ice Tutorial!#Developed by: Gabriel Frey");
ds_list_add(messages, "The object of the game is to get to the PURPLE DOOR at the top,#before the water gets to you.");
ds_list_add(messages, "Press " + left + " and " + right + " to move, and press " + jump + " to jump.");
ds_list_add(messages, "Press " + ice + " to grab blocks when close enough, or shoot a ball of ice.#Press " + ice + " again to throw.");
ds_list_add(messages, "Press " + fire + " to create a fire ball.#Use " + aim + " to aim.");
ds_list_add(messages, "You can freeze blocks in mid air, or hold " + ice + " while#holding a block to begin a freezing countdown.");
ds_list_add(messages, "If you press " + fire + " while holding a block, it will#begin an explosion countdown timer, that can be used to#destroy big blocks.");
ds_list_add(messages, "Collect hearts to get more lives, and stand in the blue recharge stations# to get energy. Shooting an ice or fire ball uses energy.");
ds_list_add(messages, "Good luck!");
