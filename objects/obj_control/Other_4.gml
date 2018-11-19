/// @description Level generator
///Initializatons
if (global.gameStart) {
    global.level = 0; //Set level number
    global.continue_game = true; //whether or not can continue
    global.water_delay = 1000;
    global.water_rate = .1;
    global.gameStart = false;
    }

global.win = false; //Start with player's not winning
gotoScore = true; //Next room will be score

/// Create room
//seed the random generator
if (global.continue_game) {
    //get seed
    seed = ds_list_find_value(ds_map_find_value(global.path, "seeds"), global.level);
    /*show_debug_message(string(global.level) + string(seed));*/
    if (is_undefined(seed)) {
        var nseed; //the seed for the path
		
        //Set the tutorial seed if first time
        if (global.tutorial) {
            nseed = 2435157115;
            instance_create_layer(0, 0, "lay_instances", obj_tutorial);
            global.water_delay = 2000;
            global.tutorial = false;
        }
		
		//Otherwise get a random seed
        else {
            randomize();
            nseed = random_get_seed();
        }
		
        // set seed
        random_set_seed(nseed);
		
        //save seed
        ds_list_insert(ds_map_find_value(global.path, "seeds"), global.level, nseed);  //global.level,
    }
	
    else {
        random_set_seed(seed);
    }
	
}

else {
    random_set_seed(random_get_seed());
    /*global.continue_game = true; //set after hearts generation*/
}

//Set the delay before the rain starts
alarm_set(2, global.water_delay-100)

//Set the delay before water rises
alarm_set(0, global.water_delay);


//If delay already at 0, signal to start raising the water
if (global.water_delay <= 0) water_buffer = false;

///Room Creation
gridSize = 32; //Set the grid size
maxY = room_height - gridSize*2; //max y platforms are allowed to generate at

//Finish platform
var dx = round(irandom_range(gridSize*3, room_width - gridSize*3)/gridSize)*gridSize;
var dy = gridSize*2;
var i = 0;
repeat(3) {
    instance_create_layer(dx+gridSize*i, dy, "lay_instances", obj_blockBig);
    i ++;
}

//create door in middle of finish platform
instance_create_layer(dx+gridSize+8, dy-gridSize+4, "lay_instances", obj_door);

//for each row in the room, create 1 of 6 platforms
for (i = 3; i < maxY/gridSize; i += 1) {
    for(j = 0; j < 1; j+=1) {
		//Create a platform in that row 75% of the time 
        if irandom(3){
            dx = round(irandom_range(gridSize, room_width - gridSize)/gridSize)*gridSize;
            dy = i*gridSize;
            scr_platformGenerate(dx, dy, irandom_range(0, 6));
        }
    }
}

//create additional platforms every 4 blocks with chance 1 in 5 (Mandatories)
for (i = 3; i < maxY/gridSize; i += 4) {
    for(j = 0; j < 1; j+=1) {
        dx = round(irandom_range(gridSize, room_width - gridSize)/gridSize)*gridSize;
        dy = i*gridSize;
        scr_platformGenerate(dx, dy, irandom_range(0, 5));
    }
}

//floor block generators - guarenteed 4 sticky block generators
repeat(4) {
    dx = round(irandom_range(gridSize*4, room_height - gridSize*4)/gridSize)*gridSize;
    dy = room_height-gridSize-16;
    if (place_free(dx, dy-16)) with instance_create_layer(dx, dy, "lay_instances", obj_blockStation) sticky = true;
}

//bottom trampoline creation - up to two with a 50% chance for each
repeat(2){
	if !irandom(1){
		dx = round(irandom_range(gridSize*3, room_height - gridSize*4)/gridSize)*gridSize
	    dy = room_height-gridSize-32
		
		if (place_free(dx, dy)){
			instance_create_layer(dx, dy+16, "lay_instances", obj_trampoline)
		}
	}
}

///Platform spawns
var gridSize = 32
var num_vertical = 2
var num_horizontal = 2
var tries = 100
var rx = 0
var ry = 0

//vertical Platforms
for (i=0; i<tries; i++){
	//set random coordinates
	rx = round(irandom_range(0, room_width)/gridSize)*gridSize
	ry = round(irandom_range(4 * gridSize, room_height - 2 * gridSize)/gridSize)*gridSize;
	var open = true
	
	//check if track is free
	for (j=-3; j<4; j++){
		if not place_free(rx, ry - j*gridSize){
			open = false
			break
		}
	}
	
	//create if open
	if open{
		instance_create_layer(rx,ry, "lay_instances", obj_platform)
		num_vertical -= 1
	}
	
	//stop creating if desired platform number is reached
	if num_vertical <= 0{
		break
	}
}

//horizontal Platforms
for (i=0; i<tries; i++){
	//set random coordinates
	rx = round(irandom_range(0, room_width)/gridSize)*gridSize
	ry = round(irandom_range(4 * gridSize, room_height - 2 * gridSize)/gridSize)*gridSize;
	var open = true
	
	//check if track is free
	for (j=-3; j<4; j++){
		if not place_free(rx + j*gridSize, ry){
			open = false
			break
		}
	}
	
	//check if above track is free
	for (j=-3; j<4; j++){
		if not place_free(rx + j*gridSize, ry - gridSize){
			open = false
		}
	}
	
	//create if open
	if open{
		with instance_create_layer(rx,ry, "lay_instances", obj_platform){
			is_vertical = false
			image_index = 4
			num_horizontal -= 1
		}
	}
	
	//stop creating if desired platform number is reached
	if num_horizontal <= 0{
		break
	}
}

///Generate heart token (extra life) if first time on level
if (global.continue_game) {
	//random x and y
	var gridSize = 32;
	var rx = 0;
	var ry = 0;
	var tries = 1; //amount of hearts
	var whileTries = 0;
	var whileTriesMax = 100; //limit amount of times loop can run
	
	//spawn at random location
	while(tries > 0) {
	    //set random coordinates
	    rx = round(irandom_range(0, room_width)/gridSize)*gridSize;
	    ry = round(irandom_range(0, room_height)/gridSize)*gridSize;
    
	    //check if can place
	    if (place_free(rx, ry)) {
	        if (place_meeting(rx, ry+gridSize, obj_blockBig)) {
	            instance_create_layer(rx+gridSize/2, ry+gridSize/2, "lay_instances", obj_health);
	            tries -= 1;
	        }
	    }
	    //limit amount of times loop can run
	    whileTries -= 1;
	    if (whileTries > whileTriesMax) tries = 0;
	}
}

else{
    global.continue_game = true;
}
