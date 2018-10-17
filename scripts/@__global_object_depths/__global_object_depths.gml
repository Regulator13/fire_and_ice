// Initialise the global array that allows the lookup of the depth of a given object
// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
// NOTE: MacroExpansion is used to insert the array initialisation at import time
gml_pragma( "global", "__global_object_depths()");

// insert the generated arrays here
global.__objectDepths[0] = 0; // obj_character
global.__objectDepths[1] = 0; // obj_pirahna
global.__objectDepths[2] = 0; // obj_scoreBoard
global.__objectDepths[3] = 0; // obj_wall
global.__objectDepths[4] = 0; // obj_blockBig
global.__objectDepths[5] = 0; // obj_control
global.__objectDepths[6] = 0; // par_physics
global.__objectDepths[7] = 0; // obj_corpse
global.__objectDepths[8] = 0; // pos_character
global.__objectDepths[9] = 0; // obj_block
global.__objectDepths[10] = 0; // obj_patrol
global.__objectDepths[11] = 0; // par_enemy
global.__objectDepths[12] = 0; // obj_ball
global.__objectDepths[13] = 0; // obj_score
global.__objectDepths[14] = 0; // par_block
global.__objectDepths[15] = 0; // obj_rechargeStation
global.__objectDepths[16] = 0; // obj_blockStation
global.__objectDepths[17] = 0; // obj_laser
global.__objectDepths[18] = 0; // obj_menu
global.__objectDepths[19] = 0; // obj_button
global.__objectDepths[20] = 0; // obj_controlButton
global.__objectDepths[21] = 0; // obj_inputButton
global.__objectDepths[22] = 0; // obj_inputControl
global.__objectDepths[23] = 0; // obj_inputMessage
global.__objectDepths[24] = 0; // obj_explosion
global.__objectDepths[25] = 0; // obj_health
global.__objectDepths[26] = 0; // obj_door
global.__objectDepths[27] = 0; // obj_team
global.__objectDepths[28] = 0; // obj_logo
global.__objectDepths[29] = 0; // obj_online
global.__objectDepths[30] = 0; // obj_textBox
global.__objectDepths[31] = 0; // obj_client
global.__objectDepths[32] = 0; // obj_server
global.__objectDepths[33] = 0; // obj_networkPlayer
global.__objectDepths[34] = 0; // obj_localPlayer
global.__objectDepths[35] = 0; // obj_camera
global.__objectDepths[36] = 0; // srv_basic
global.__objectDepths[37] = 0; // prt_mooch
global.__objectDepths[38] = 0; // prt_countdown
global.__objectDepths[39] = 0; // obj_tutorial


global.__objectNames[0] = "obj_character";
global.__objectNames[1] = "obj_pirahna";
global.__objectNames[2] = "obj_scoreBoard";
global.__objectNames[3] = "obj_wall";
global.__objectNames[4] = "obj_blockBig";
global.__objectNames[5] = "obj_control";
global.__objectNames[6] = "par_physics";
global.__objectNames[7] = "obj_corpse";
global.__objectNames[8] = "pos_character";
global.__objectNames[9] = "obj_block";
global.__objectNames[10] = "obj_patrol";
global.__objectNames[11] = "par_enemy";
global.__objectNames[12] = "obj_ball";
global.__objectNames[13] = "obj_score";
global.__objectNames[14] = "par_block";
global.__objectNames[15] = "obj_rechargeStation";
global.__objectNames[16] = "obj_blockStation";
global.__objectNames[17] = "obj_laser";
global.__objectNames[18] = "obj_menu";
global.__objectNames[19] = "obj_button";
global.__objectNames[20] = "obj_controlButton";
global.__objectNames[21] = "obj_inputButton";
global.__objectNames[22] = "obj_inputControl";
global.__objectNames[23] = "obj_inputMessage";
global.__objectNames[24] = "obj_explosion";
global.__objectNames[25] = "obj_health";
global.__objectNames[26] = "obj_door";
global.__objectNames[27] = "obj_team";
global.__objectNames[28] = "obj_logo";
global.__objectNames[29] = "obj_online";
global.__objectNames[30] = "obj_textBox";
global.__objectNames[31] = "obj_client";
global.__objectNames[32] = "obj_server";
global.__objectNames[33] = "obj_networkPlayer";
global.__objectNames[34] = "obj_localPlayer";
global.__objectNames[35] = "obj_camera";
global.__objectNames[36] = "srv_basic";
global.__objectNames[37] = "prt_mooch";
global.__objectNames[38] = "prt_countdown";
global.__objectNames[39] = "obj_tutorial";


// create another array that has the correct entries
var len = array_length_1d(global.__objectDepths);
global.__objectID2Depth = [];
for( var i=0; i<len; ++i ) {
	var objID = asset_get_index( global.__objectNames[i] );
	if (objID >= 0) {
		global.__objectID2Depth[ objID ] = global.__objectDepths[i];
	} // end if
} // end for