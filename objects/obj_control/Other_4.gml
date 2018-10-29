/// @description level generator
if (global.gameStart) {
    //set level
    global.level = 0;
    
    //whether or not can continue
    global.continueGame = true;
    
    if (global.cooperativeMode) {
        //water delay
        global.waterDelay = 1600;
        //water rate
        global.water_rate = .05;
        }
    else {
        //water delay
        global.waterDelay = 1000;
        //water rate
        global.water_rate = .1;
        }
    global.gameStart = false;
    }

///win
global.win = false;
gotoScore = true;

/// Create room

//seed the random generator
if (global.continueGame) {
    //get seed
    seed = ds_list_find_value(ds_map_find_value(global.path, "seeds"), global.level);
    //show_debug_message(string(global.level) + string(seed));
    if (is_undefined(seed)) {
        // nseed - the seed for the path
        var nseed;
        // check if tutorial
        if (global.tutorial) {
            nseed = 2435157115;
            instance_create(0, 0, obj_tutorial);
            global.waterDelay = 2000;
            global.tutorial = false;
            }
        else {
            //get random seed
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
    //global.continueGame = true; //set after hearts generation
    }
    
alarm_set(0,global.waterDelay);//Set the delay before water rises
if (global.waterDelay <= 0) water_buffer = false;

gridSize = 32;//Set the grid size
maxY = room_height - gridSize*2; //max y platforms are allowed to generate at

//For each row in the room, create a platform with 1 in x chance
for (i = 3; i < maxY/gridSize; i += 1) {
    for(j = 0; j < 1; j+=1) {
        if (irandom_range(0, 1) = 0) {
            dx = round(irandom_range(gridSize, room_width - gridSize)/gridSize)*gridSize;
            dy = i*gridSize;
            scr_platformGenerate(dx, dy, irandom_range(0, 6));
            }
        }
    }

//mandatory
for (i = 3; i < maxY/gridSize; i += 4) {
    for(j = 0; j < 1; j+=1) {
        dx = round(irandom_range(gridSize, room_width - gridSize)/gridSize)*gridSize;
        dy = i*gridSize;
        scr_platformGenerate(dx, dy, irandom_range(0, 5));
        }
    }

//floor block generators
repeat(4) {
    dx = round(irandom_range(gridSize*4, room_height - gridSize*4)/gridSize)*gridSize;
    dy = room_height-gridSize-16;
    if (place_free(dx, dy-16)) with instance_create(dx, dy, obj_blockStation) sticky = true;
    }

//Bottom Trampoline
repeat(2){
	if irandom(1){
		dx = round(irandom_range(gridSize*3, room_height - gridSize*4)/gridSize)*gridSize
	    dy = room_height-gridSize-32
		
		if (place_free(dx, dy)){
			instance_create_layer(dx, dy+16, "Instances", obj_trampoline)
		}
	}
}
	
//left side lasers
repeat(3) {
    dx = gridSize;
    dy = round(irandom_range(gridSize, room_height - gridSize * 6) / gridSize) * gridSize;
    if (place_free(dx, dy)) and not place_meeting(dx,dy,obj_laser){
		with (instance_create(dx, dy, obj_laser)) {
	        image_index = 0;
	        dir = 1;
		}
    }
}

//right side lasers
repeat(3) {
    dx = room_width-gridSize-16;
    dy = round(irandom_range(gridSize, room_height - gridSize * 6) / gridSize) * gridSize;
    //move left more to accomadate for bigger checking sprite
    if ((place_free(dx-16, dy)) and not place_meeting(dx,dy,obj_laser)){
		with (instance_create(dx, dy, obj_laser)) {
			image_index = 1;
			dir = -1;
		}
    }
}
    
//finish platform
var dx = round(irandom_range(gridSize*3, room_width - gridSize*3)/gridSize)*gridSize;
var dy = gridSize*2;

//create bottom of top platform
var i = 0;
repeat(3) {
    instance_create(dx+gridSize*i, dy, obj_blockBig);
    i ++;
}

//create door in middle of top platform
instance_create(dx+gridSize+8, dy-gridSize+4, obj_door);

//Platform spawns
var gridSize = 32
var num_vertical = 2
var num_horizontal = 2
var tries = 100
var rx = 0
var ry = 0

//Vertical Platforms
for (i=0; i<tries; i++){
	//Set random coordinates
	rx = round(irandom_range(0, room_width)/gridSize)*gridSize
	ry = round(irandom_range(0, room_height)/gridSize)*gridSize;
	var open = true
	
	//Check if track is free
	for (j=0; j<8; j++){
		if not place_free(rx, ry - j*gridSize){
			open = false
			break
		}
	}
	
	//Create if open
	if open{
		instance_create_layer(rx,ry, "Instances", obj_platform)
		num_vertical -= 1
	}
	
	//Stop creating if desired platform number is reached
	if num_vertical <= 0{
		break
	}
}

//Horizontal Platforms
for (i=0; i<tries; i++){
	//Set random coordinates
	rx = round(irandom_range(0, room_width)/gridSize)*gridSize
	ry = round(irandom_range(0, room_height)/gridSize)*gridSize;
	var open = true
	
	//Check if track is free
	for (j=-3; j<4; j++){
		if not place_free(rx + j*gridSize, ry){
			open = false
			break
		}
	}
	
	//Check if above track is free
	for (j=-3; j<4; j++){
		if not place_free(rx + j*gridSize, ry - gridSize){
			open = false
		}
	}
	
	//Create if open
	if open{
		with instance_create_layer(rx,ry, "Instances", obj_platform){
			is_vertical = false
			image_index = 4
			num_horizontal -= 1
		}
	}
	
	//Stop creating if desired platform number is reached
	if num_horizontal <= 0{
		break
	}
}

//Destroy water spawns overlapped by blocks
with obj_water_spawn{
	if not place_free(x,y){
		instance_destroy()
	}
}

///generate health
if (global.continueGame) {
	//random x and y
	var gridSize = 32;
	var rx = 0;
	var ry = 0;
	var tries = 1; //amount of hearts
	var whileTries = 0;
	var whileTriesMax = 100; //limit amount of times loop can run
	
	while(tries > 0) {
	    //set random coordinates
	    rx = round(irandom_range(0, room_width)/gridSize)*gridSize;
	    ry = round(irandom_range(0, room_height)/gridSize)*gridSize;
    
	    //check if can place
	    if (place_free(rx, ry)) {
	        if (place_meeting(rx, ry+gridSize, obj_blockBig)) {
	            instance_create(rx+gridSize/2, ry+gridSize/2, obj_health);
	            tries -= 1;
	            }
	        }
	    //limit amount of times loop can run
	    whileTries -= 1;
	    if (whileTries > whileTriesMax) tries = 0;
	    }
	}
	
else {
    global.continueGame = true;
}

