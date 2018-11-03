/// @description create character
if (team.tLives > 0) {
    with (pos_character) {
        other.startX = x;
        other.startY = y;
        
        //create character
        other.gameCharacter = instance_create(other.startX, other.startY, obj_character);
        other.gameCharacter.playerInput = other.input; // negative one for client control
        other.gameCharacter.InputPlayer = other; // set network player for input
        other.gameCharacter.playerId = other.playerId;
        other.gameCharacter.team = other.team;
        other.gameCharacter.playerName = other.name;
        other.gameCharacter.inputType = other.inputs[KEY_TYPE];
        
        //get sprite
        other.gameCharacter.sprite_index = other.sprite_index;
		
		//Set player stats based on their sprite
		scr_set_character_stats(other.sprite_index)
        
        //destroy self, so other character will create elsewhere
        instance_destroy();
        
        //exit - only create one
        exit;
        }
    }

