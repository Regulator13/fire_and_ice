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

//madatory
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

//left side lasers
repeat(3) {
    dx = gridSize;
    dy = round(irandom_range(gridSize, room_height - gridSize * 6) / gridSize) * gridSize;
    if (place_free(dx, dy)) with (instance_create(dx, dy, obj_laser)) {
        image_index = 0;
        dir = 1;
        }
    }
//right side lasers
repeat(3) {
    dx = room_width-gridSize-16;
    dy = round(irandom_range(gridSize, room_height - gridSize)/gridSize + 6)*gridSize;
    //move left more to accomadate for bigger checking sprite
    if (place_free(dx-16, dy)) with (instance_create(dx, dy, obj_laser)) {
        image_index = 1;
        dir = -1;
        }
    }
    
//finish platform
var dx = round(irandom_range(gridSize*3, room_width - gridSize*3)/gridSize)*gridSize;
var dy = gridSize*2;

//create bottom
var i = 0;
repeat(3) {
    instance_create(dx+gridSize*i, dy, obj_blockBig);
    i ++;
    }
//create door
instance_create(dx+gridSize+8, dy-gridSize+4, obj_door);
    

///generate health
if (global.continueGame) {
//random x and y
var gridSize = 32;
var rx = 0;
var ry = 0;
var tries = 1; //amount of healths
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

