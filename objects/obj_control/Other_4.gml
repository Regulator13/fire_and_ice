/// @description Level generator
///Initializatons
if (global.gameStart) {
    global.level = 0; //Set level number
    global.continue_game = true; //whether or not can continue
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
var dy = gridSize*3;
var i = 0;
repeat(3) {
    instance_create_layer(dx+gridSize*i, dy, "lay_instances", obj_block_big);
    i ++;
}

//create door in middle of finish platform
instance_create_layer(dx+gridSize+8, dy-gridSize+4, "lay_instances", obj_door);

//for each row in the room, create 1 of 6 platforms
for (i = 4; i < maxY/gridSize; i += 1) {
	//Up to 2 platforms per row
    for(j = 0; j < 1; j+=1) {
		//Create a platform in that row depending on difficulty: Beginner-Expert (100%, 87.5%, 75%, 62.5%, 50%)  
        if irandom(7) >= global.Menu.difficulty{
            dx = round(irandom_range(gridSize, room_width - gridSize)/gridSize)*gridSize;
            dy = i*gridSize;
            scr_platform_generate(dx, dy, irandom_range(0, 6));
        }
    }
}

//create additional platforms every X blocks depending on difficulty (2, 3, 4, 5, 6) (Mandatories)
for (i = 4; i < maxY/gridSize; i += (global.Menu.difficulty + 2)) {
    for(j = 0; j < 1; j+=1) {
        dx = round(irandom_range(gridSize, room_width - gridSize)/gridSize)*gridSize;
        dy = i*gridSize;
        scr_platform_generate(dx, dy, irandom_range(0, 5));
    }
}

//floor block generators - guarenteed 4 sticky block generators
var tries = 100
for (var i=0; i<4; i++){
    dx = round(irandom_range(gridSize*4, room_height - gridSize*4)/gridSize)*gridSize;
    dy = room_height-gridSize-16;
    if (place_empty(dx, dy-16)) with instance_create_layer(dx, dy, "lay_instances", obj_block_station) sticky = true;
	
	//If not yet out of tries, attempt to spawn the block again
	else if tries > 0{
		i -= 1
	}
	tries -= 1
}

//bottom trampoline creation - up to two with a 50% chance for each
var tries = 100
for (var i=0; i<2; i++){
	if !irandom(1){
		dx = round(irandom_range(gridSize*3, room_height - gridSize*4)/gridSize)*gridSize
	    dy = room_height-gridSize-32
		
		if (place_empty(dx, dy)){
			instance_create_layer(dx, dy + 16, "lay_instances", obj_trampoline)
		}
		
		//If not yet out of tries, attempt to spawn the block again
		else if tries > 0{
			i -= 1
		}
		tries -= 1
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
	for (var j=-3; j<4; j++){
		if not place_empty(rx, ry - j*gridSize){
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
		if not place_empty(rx + j*gridSize, ry){
			open = false
			break
		}
	}
	
	//check if above track is free
	for (j=-3; j<4; j++){
		if not place_empty(rx + j*gridSize, ry - gridSize){
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

///Key spawn
var grid_size = 32
var tries = 1000
var rx = 0
var ry = 0

//If locked_door_on is on, find a place to spawn a key the first time a room is entered
if global.Menu.locked_door_on{
	///Key placement
	for (i=0; i<tries; i++){
		//set random coordinates
		rx = round(irandom_range(0, room_width - grid_size*3)/gridSize)*gridSize
		ry = round(irandom_range(6 * gridSize, room_height - 12 * gridSize)/gridSize)*gridSize;
		var open = true
	
		//check if place is free
		for (j=0; j<3; j++){
			for (var k=0; k<3; k++){
				if not place_empty(rx + j*grid_size, ry + k*grid_size){
					open = false
					break
				}
			}
		}
	
		//create cage and key if open
		if open{
			//Create top layer
			instance_create_layer(rx + grid_size, ry, "lay_instances", obj_block_big)
			//Create middle layer with key
			instance_create_layer(rx, ry + grid_size, "lay_instances", obj_block_big)
			instance_create_layer(rx + grid_size  + 8, ry + grid_size + 8, "lay_instances", obj_key)
			instance_create_layer(rx + grid_size * 2, ry + grid_size, "lay_instances", obj_block_big)
			//Create bottom layer
			instance_create_layer(rx + grid_size, ry + grid_size * 2, "lay_instances", obj_block_big)
				
			break
		}
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
	    if (place_empty(rx, ry)) {
	        if (place_meeting(rx, ry+gridSize, obj_block_big)) {
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

///If items are off, remove them from the map AFTER level spawn to presever random order
if not global.Menu.jetpack_on{
	instance_destroy(obj_jetpack)
}
