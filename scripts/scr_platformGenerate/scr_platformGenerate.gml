/// @function scr_platformGenerate(dx, dy, range)
/// @description scr_platform generate

var sx = argument0;
var sy = argument1;
var dx = sx;
var dy = sy;
var gridSize = 32;

switch(argument2) {
	
    case 0: //five long platform
        for (k = 0; k < 5; k += 1) {
            dx += gridSize;
            if (place_empty(dx,dy)) {
                instance_create_layer(dx, dy, "lay_instances", obj_blockBig);
                }
            }
			
        //patrol right side
        if (place_empty(dx-gridSize,dy-gridSize)) instance_create_layer(dx-gridSize * 0.75, dy-gridSize+16, "lay_instances", obj_patrol);
		
		//gun second block from left 1/4 chance
		if !irandom(3){
			if (place_empty(dx - gridSize*3, dy - gridSize)) instance_create_layer(dx - gridSize*3, dy-gridSize/2, "lay_instances", obj_gun);
		}
		
		break;
		
	case 6: //three long platform
		for (k = 0; k < 3; k += 1) {
			dx += gridSize;
			if (place_empty(dx,dy)) {
				instance_create_layer(dx, dy, "lay_instances", obj_blockBig);
			}
		}

		//recharge station above middle block (If there is a middle block)
		if (place_empty(dx-gridSize,dy-gridSize) and place_meeting(dx - gridSize, dy, obj_blockBig)) instance_create_layer(dx-gridSize, dy-gridSize, "lay_instances", obj_rechargeStation);
		
		//1 in 3 chance of jetpack on right if in second quater from bottom of room
		if (dy > (room_height / 2)) and (dy < (3 * room_height / 4)){
			if !irandom(2){
				if (place_empty(dx + gridSize/2, dy-gridSize)) instance_create_layer(dx + gridSize/2, dy-gridSize/2, "lay_instances", obj_jetpack);
			}
		}
		
		break;

	case 1: //five long 'u'
		if (place_empty(dx,dy-gridSize)){
			instance_create_layer(dx, dy-gridSize, "lay_instances", obj_blockBig);
		
			//Sentry on top of left side block
			if place_empty(dx, dy - gridSize*2){
				instance_create_layer(dx + 8, dy - gridSize - 16, "lay_instances", obj_sentry)
			}
		}
		
		for (k = 0; k < 5; k += 1) {
			dx = sx+gridSize*k;
			if (place_empty(dx,dy)) instance_create_layer(dx, dy, "lay_instances", obj_blockBig);
		}
			
		if (place_empty(dx,dy-gridSize)) instance_create_layer(dx, dy-gridSize, "lay_instances", obj_blockBig);
		
		//1 in 3 chance of trampoline on second from left side
		if !irandom(2){
			if (place_empty(dx - gridSize*3, dy - gridSize/2)) instance_create_layer(dx - gridSize*3, dy-gridSize/2, "lay_instances", obj_trampoline);
		}
		
		//recharge station above middle block (if there is a middle block)
		if (place_empty(dx-gridSize*2,dy-gridSize) and place_meeting(dx - gridSize * 2, dy, obj_blockBig)) instance_create_layer(dx-gridSize*2, dy-gridSize, "lay_instances", obj_rechargeStation);
		
		//hang glider second from right side 1/4 chance
		if !irandom(3){
			if (place_empty(dx - gridSize, dy-gridSize)) instance_create_layer(dx - gridSize, dy-gridSize/2, "lay_instances", obj_hang_glider);
		}
		
		break;
		
    case 2: //five long right side 'L'
        for (k = 0; k < 5; k += 1) {
            dx = sx+gridSize*k;
            if (place_empty(dx,dy)) instance_create_layer(dx, dy, "lay_instances", obj_blockBig);
            }
			
        if (place_empty(dx,dy-gridSize)){
			instance_create_layer(dx, dy-gridSize, "lay_instances", obj_blockBig);
			
			//Sentry on top of right side block
			if place_empty(dx, dy - gridSize*2){
				instance_create_layer(dx + 8, dy - gridSize - 16, "lay_instances", obj_sentry)
			}
		}
		
		//1 in 3 chance of jetpack on right if in second quater from bottom of room
		if (dy > (room_height / 2)) and (dy < (3 * room_height / 4)){
			if !irandom(2){
				if (place_empty(dx - gridSize, dy-gridSize)) instance_create_layer(dx - gridSize , dy-gridSize/2, "lay_instances", obj_jetpack);
			}
		}
		
		//pick axe middle 1/4 chance
		if !irandom(3){
			if (place_empty(dx - gridSize*2, dy-gridSize)) instance_create_layer(dx - gridSize*2, dy-gridSize/2, "lay_instances", obj_climbing_pick);
		}
        
		break;
		
	case 3: //five long left side 'L'
		if (place_empty(dx,dy-gridSize)) instance_create_layer(dx, dy-gridSize, "lay_instances", obj_blockBig);
		
		for (k = 0; k < 5; k += 1) {
			dx = sx+gridSize*k;
			if (place_empty(dx,dy)) instance_create_layer(dx, dy, "lay_instances", obj_blockBig);
		}
		
		//1 in 2 chance of trampoline on right side
		if !irandom(1){
			if (place_empty(dx, dy-gridSize)) instance_create_layer(dx, dy-gridSize/2, "lay_instances", obj_trampoline);
		}
		
		//Create a water spawn below the second block from right (if there is a block) (50% chance)
		if place_empty(dx - gridSize, dy + gridSize) and place_meeting(dx - gridSize, dy, obj_blockBig){
			if !irandom(1){
				instance_create_layer(dx - gridSize, dy + gridSize, "lay_instances", obj_water_spawn)
			}
		}
		
		//gun in middle 1/4 chance
		if !irandom(3){
			if (place_empty(dx - gridSize*3, dy - gridSize)) instance_create_layer(dx - gridSize*3, dy-gridSize/2, "lay_instances", obj_gun);
		}
	
		break;
	
	case 4: //five long 'u'
		if (place_empty(dx,dy-gridSize)) instance_create_layer(dx, dy-gridSize/2, "lay_instances", obj_blockStation);
		
		for (k = 0; k < 5; k += 1) {
			dx = sx+gridSize*k;
			if (place_empty(dx,dy)) instance_create_layer(dx, dy, "lay_instances", obj_blockBig);
		}
		
		if (place_empty(dx,dy-gridSize)) instance_create_layer(dx, dy-gridSize/2, "lay_instances", obj_blockStation);
		
		//patrol
        if (place_empty(dx-gridSize*2,dy-gridSize)) instance_create_layer(dx-gridSize * 1.75, dy-gridSize+16, "lay_instances", obj_patrol);
		
		//hang glider second from right side 1/4 chance
		if !irandom(3){
			if (place_empty(dx - gridSize, dy-gridSize)) instance_create_layer(dx - gridSize, dy-gridSize/2, "lay_instances", obj_hang_glider);
		}
		
		break;
		
	case 5: //three long with block
		for (k = 0; k < 3; k += 1) {
			dx = sx+gridSize*k;
			if (place_empty(dx,dy)) instance_create_layer(dx, dy, "lay_instances", obj_blockBig);
		}
		
		//sticky block station right side
		if (place_empty(dx,dy-gridSize)) with(instance_create_layer(dx, dy-gridSize/2, "lay_instances", obj_blockStation)) sticky = true;
		
		//pick axe middle 1/4 chance
		if !irandom(3){
			if (place_empty(dx - gridSize, dy-gridSize)) instance_create_layer(dx - gridSize, dy-gridSize/2, "lay_instances", obj_climbing_pick);
		}
		
		//Create a water spawn below the middle block (if there is a middle block) (50% chance)
		if place_empty(dx - gridSize, dy + gridSize) and place_meeting(dx - gridSize, dy, obj_blockBig){
			if !irandom(1){
				instance_create_layer(dx - gridSize, dy + gridSize, "lay_instances", obj_water_spawn)
			}
		}
		
		break;
		
	default:
		if (place_empty(dx,dy)) {
		instance_create_layer(dx, dy, "lay_instances",  obj_blockBig);
		}
		
	break;
}

//create score
if place_empty(sx + gridSize, sy - gridSize){
	instance_create_layer(sx + gridSize, sy - gridSize + 16, "lay_instances", obj_score);
}
