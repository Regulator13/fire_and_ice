/// @description create character
if (Team.tLives > 0) {
    with (pos_character) {
		//Initialize pos_character variables
        other.startX = x;
        other.startY = y;
        
        //create character
        other.gameCharacter = instance_create_layer(other.startX, other.startY, "lay_instances", obj_character);
        other.gameCharacter.player_input = other.input; // negative one for client control
        other.gameCharacter.Input_player = other; // set network player for input
        other.gameCharacter.player_id = other.player_id;
        other.gameCharacter.Team = other.Team;
        other.gameCharacter.player_name = other.name;
        other.gameCharacter.input_method = global.controls[other.controls, KEY_TYPE];
        
        //get sprite
        other.gameCharacter.sprite_index = other.sprite_index;
		
		//Set player stats based on their sprite
		scr_set_character_stats(other.sprite_index)
        
        //destroy self, so other character will create elsewhere
        instance_destroy();
        
		//REMOVE? This exit statement is located at the end of an event
        //exit - only create one
        exit;
    }
}

