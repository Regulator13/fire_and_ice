/// @function set_character_stats(sprite_index)
/// @description Set the intial stats for the character
/// @param sprite_index int | The index of the character's sprite
/// @return none

//Assign parameters
var index = argument0


/*
Assignments:
	grinch - 5
	yeti - 7
	reindeer - 9
	nutcracker - 10
	santa - 11
*/

//Give stats
switch index{
	
	//grinch
	case 5:
		other.gameCharacter.hp = 100
		other.gameCharacter.hp_max = 100
		other.gameCharacter.energy = 100
		other.gameCharacter.energy_max = 100
		other.gameCharacter.energy_fire = 5
		other.gameCharacter.mass = 13
		other.gameCharacter.strength = 60
		other.gameCharacter.jump_height = 7.1
		other.gameCharacter.jumps_max = 1

		break
	
	//yeti
	case 7:
		other.gameCharacter.hp = 120
		other.gameCharacter.hp_max = 120
		other.gameCharacter.energy = 90
		other.gameCharacter.energy_max = 90
		other.gameCharacter.energy_fire = 5
		other.gameCharacter.mass = 16
		other.gameCharacter.strength = 80
		other.gameCharacter.jump_height = 6.8
		other.gameCharacter.jumps_max = 1
		
		break
	
	//reindeer
	case 9:
		other.gameCharacter.hp = 80
		other.gameCharacter.hp_max = 80
		other.gameCharacter.energy = 95
		other.gameCharacter.energy_max = 95
		other.gameCharacter.energy_fire = 5
		other.gameCharacter.mass = 12
		other.gameCharacter.strength = 60
		other.gameCharacter.jump_height = 7.5
		other.gameCharacter.jumps_max = 1
		
		break
	
	//nutcracker
	case 10:
		other.gameCharacter.hp = 100
		other.gameCharacter.hp_max = 100
		other.gameCharacter.energy = 105
		other.gameCharacter.energy_max = 105
		other.gameCharacter.energy_fire = 5
		other.gameCharacter.mass = 13
		other.gameCharacter.strength = 40
		other.gameCharacter.jump_height = 7.3
		other.gameCharacter.jumps_max = 1
		
		break
		
	//santa
	case 11:
		other.gameCharacter.hp = 95
		other.gameCharacter.hp_max = 95
		other.gameCharacter.energy = 115
		other.gameCharacter.energy_max = 115
		other.gameCharacter.energy_fire = 5
		other.gameCharacter.mass = 15
		other.gameCharacter.strength = 45
		other.gameCharacter.jump_height = 7.0
		other.gameCharacter.jumps_max = 1
		
		break
		
	default:
		other.gameCharacter.hp = 100
		other.gameCharacter.hp_max = 100
		other.gameCharacter.energy = 100
		other.gameCharacter.energy_max = 100
		other.gameCharacter.energy_fire = 5
		other.gameCharacter.mass = 15
		other.gameCharacter.strength = 60
		other.gameCharacter.jump_height = 7.1
		other.gameCharacter.jumps_max = 1
		
		break
}