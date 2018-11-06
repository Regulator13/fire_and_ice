/// @description Draw buttons
//draw set up
draw_set_font(fnt_buttons);
draw_set_color(c_white);
draw_set_valign(fa_middle);
var bw = 77; //half button width
var bh = 16; //half button height
var ss = 48; //space for selector
    
//draw buttons
for (var i=0; i<ds_list_size(buttons); i++){
    var button = ds_list_find_value(buttons, i);
	///REMOVE? This seems like it should be a switch-case
	//draw value button
    if (button.action == "value" or button.action == "valueAction") {
        draw_set_halign(fa_right);
        draw_text(button.x-bw-ss, button.y, string_hash_to_newline(button.title));
        draw_set_halign(fa_left);
        draw_text(button.x+bw+ss, button.y, string_hash_to_newline(string(ds_list_find_value(button.values, button.value))));
        draw_set_color(c_dkgray);
        draw_rectangle(button.x-bw, button.y-bh, button.x+bw, button.y+bh, true);
        draw_set_color(c_gray);
        var sliderWidth = (bw*2/ds_list_size(button.values))
        draw_rectangle(button.x-bw+1+button.value*sliderWidth, button.y-bh+1, button.x-bw+1+button.value*sliderWidth+sliderWidth, button.y+bh-1, false);
        draw_set_color(c_white);
    }
	
	//Draw control button
    else if (button.action == "controlButton") {
        // draw contol button
        draw_sprite(button.sprite_index, button.image_index, button.x, button.y)
        draw_set_halign(fa_center);
        draw_text(button.x, button.y, string_hash_to_newline(button.title));
        draw_set_halign(fa_right);
        draw_text(button.x-77-48, button.y, string_hash_to_newline(scr_keyToTitle(button.key)));
    }
	
	//Draw defualt button
    else {
        draw_sprite(button.sprite_index, button.image_index, button.x, button.y)
        draw_set_halign(fa_center);
        if (button.title == "Default"){
			draw_text(button.x, button.y, string_hash_to_newline(button.action));
		}
		
        else{
			draw_text(button.x, button.y, string_hash_to_newline(button.title));
		}
    }
}

//draw selector
if (ds_list_size(buttons) > 0) {
    var button = ds_list_find_value(buttons, selected);
    if !(is_undefined(button)) {
	    if (instance_exists(button)) {
	        var woffset = button.sprite_width/2;
	        var dx = button.x - woffset - 32;
	        if (dx < 0) {
	            //draw selector on the other side
	            draw_sprite_ext(spr_selector, -1, button.x+woffset+32, button.y, 1, 1, 180, c_white, 1);
	            }
	        else {
	            draw_sprite(spr_selector, -1, button.x-woffset - 32, button.y);
	        }
	    }
    }
}

///main menu
if (state == STATE_MAIN) {
    //draw title
    draw_sprite(spr_title, -1, room_width/2, room_height/6);
    
    //set up drawing
    draw_set_font(fnt_command);
    draw_set_colour(c_yellow);
    
    //tag line
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_ext_transformed(room_width/2+88+48, room_height/6+32, string_hash_to_newline(tagLine), 14, 300, 1, 1, 45);
    
    draw_set_colour(c_white);
    //draw
    draw_text(room_width/2+70, room_height/6+48, string_hash_to_newline("V: " + string(version)));
    draw_text(room_width/2, room_height-32, string_hash_to_newline("Developed by: Gabriel Frey"));
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


///lobby menu
if (state == STATE_LOBBY) {
    //draw background
    //draw_sprite(spr_menu, 0, room_width/2, room_height-200);
    
    //set up drawing
    draw_set_font(fnt_command);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    
    var bh = 64;
    var sw = 32;
    
    // if online draw info from server
    if (global.online) {
        var attributes = 4; // attributes per player
        var playerAmount = ds_list_size(server_data); // amount of players * attributes
        // attribute order: team, ready, name, character
        var bh = 32;
        
        draw_set_halign(fa_left);
        // loop through and draw each player
        for (var i = 0; i < playerAmount; i += attributes) {
            draw_rectangle(32, 32 + bh*i / attributes, room_width-32, 32+bh+bh*i / attributes, true);
            draw_text(48+sw, 40 + bh*i / attributes, string_hash_to_newline("Team " + string(ds_list_find_value(server_data, i))));
            draw_text(128+sw, 40 + bh*i / attributes, string_hash_to_newline("Ready: " + string(ds_list_find_value(server_data, i + 1))));
            draw_text(240+sw, 40 + bh*i / attributes, string_hash_to_newline("Name: " + string(ds_list_find_value(server_data, i + 2))));
            draw_text(400+2*sw, 40 + bh*i / attributes, string_hash_to_newline("Character: " + ds_list_find_value(server_data, i + 3)));
            draw_sprite(spr_lobby, 0, 48, 46 + bh*i / attributes);
            draw_sprite(spr_lobby, 1, 426, 46 + bh*i / attributes);
        }
        
        // draw prompt
        draw_set_halign(fa_center);
        draw_set_font(fnt_buttons);
        var controls = 0;
        var prompt = scr_getInputName(global.controls[controls, LEFTSELC_KEY], LEFTSELC_KEY, global.controls[controls, KEY_TYPE]);
        draw_text(room_width/2, room_height-80, string_hash_to_newline("Press " + prompt + " to ready up!"));
    }
	
    else {
        var di = 0; //draw index
        
        draw_set_color(c_white)
        // iterate through each local player
        for (var i = 0; i < ds_list_size(players); i ++) {
            draw_rectangle(32, 32 + bh*di, room_width-32, 32+bh+bh*i, true);
            draw_set_halign(fa_left);
            draw_text(48+sw, 40 + bh*di, string_hash_to_newline("Team " + string(ds_list_find_value(teams, i))));
            draw_text(128+sw, 40 + bh*di, string_hash_to_newline("Ready: " + string(ds_list_find_value(readys, i))));
            draw_text(240+sw*2, 40 + bh*di, string_hash_to_newline("Character: " + ds_list_find_value(classes, i)));
            draw_sprite(spr_lobby, 0, 48, 46 + bh*i);
            draw_sprite(spr_lobby, 1, 264, 46 + bh*i);
            draw_set_halign(fa_center);
            var controls = local_controls[| i];
            var prompt = scr_getInputName(global.controls[controls, LEFTSELC_KEY], LEFTSELC_KEY, global.controls[controls, KEY_TYPE]);
            draw_text(room_width/2, 40 + bh*di+bh/2, string_hash_to_newline("Press " + prompt + " to ready up!"));
            // increment draw index
            di++
        }
		
        draw_set_color(c_gray)
        // iterate throuch each non joined local player
        for (var i = 0; i < controlsMax; i++) {
            if (ds_list_find_index(local_controls, i) == -1) {
                // if player is not yet in print prompt.
                draw_rectangle(32, 33 + bh*di, room_width-32, 33+bh+bh*di, true);
                var controls = i;
                var prompt = scr_getInputName(global.controls[controls, ACTION2_KEY], ACTION2_KEY, global.controls[controls, KEY_TYPE]);
                draw_text(room_width/2, 40-16+ bh*di+bh/2, string_hash_to_newline("Press " + prompt + " to ready up!"));
                // increment draw index
                di++
            }
        }
    }
}


///options menu

///paths menu
if (state == STATE_PATHS) {
    //set up drawing
    draw_set_font(fnt_command);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    //draw title
    //draw_sprite(spr_menu, 1, room_width/2, room_height-200);
    
    // if online draw info from server
    if (global.online) {
        var attributes = 3; // attributes per path
        var offset = 1; // non-attribute list server data
        var pathAmount = ds_list_size(server_data); // amount of players * attributes
        // attribute order: name, score, length
        var drawOffset = 0;
        // loop through and draw each player
        for (var i = offset; i < pathAmount; i += attributes) {
            draw_rectangle(32, 32 + 32*drawOffset, room_width-32, 64+32*drawOffset, true);
            draw_text(48, 40 + 32*drawOffset, string_hash_to_newline(ds_list_find_value(server_data, i)));
            draw_text(304, 40 + 32*drawOffset, string_hash_to_newline("High Score: " + string(ds_list_find_value(server_data, i + 1))));
            draw_text(480, 40 + 32*drawOffset, string_hash_to_newline("Length: " + string(ds_list_find_value(server_data, i + 2))));
            drawOffset++;
        }
        
        //draw selected
        draw_sprite(spr_selector, -1, 16, 48 + 32*ds_list_find_value(server_data, 0));
        //draw_sprite(spr_selector, -1, 16, 48 + 32*path_selected);
    }
	
    else {
        //draw selected room list
        for (var i = 0; i < ds_list_size(path_names); i ++) {
            draw_rectangle(32, 32 + 32*i, room_width-32, 64+32*i, true);
            name = ds_list_find_value(path_names, i)
            path = ds_map_find_value(paths, name);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text(48, 40 + 32*i, string_hash_to_newline(name));
            draw_text(304, 40 + 32*i, string_hash_to_newline("High Score: " + string(round(ds_map_find_value(path, "score")))));
            draw_text(480, 40 + 32*i, string_hash_to_newline("Length: " + string(ds_map_find_value(path, "length"))));
        }
    
        //draw selected
        draw_sprite(spr_selector, -1, 16, 48 + 32*path_selected);
    }
}


///game HUD
if (state == STATE_GAME) {
	if (view_current == 1) {
	    cx = camera_get_view_x(view_camera[0]); //current x
	    cy = 0; //current y
	    HUDwidth = 128; //width of HUD
	    HUDheight = 96; //height of HUD
	    cSize = 32; //size of character
    
	    if (global.online) {
	        var index = 0; //current index in list
	        var team_amount = ds_list_find_value(server_data, index++); //iterate through teams
        
	        for (var i = 1; i < team_amount; i++){
	            var team_exists = ds_list_find_value(server_data, index++); // get team_exists
	            if (team_exists) {
	                var team_players = ds_list_find_value(server_data, index++); // get amount of players
	                //draw background
	                var size = team_players-1;
	                yscale = 1+size*.5;
	                draw_sprite_ext(spr_HUD, -1, cx, cy, 1, yscale, 0, c_white, 1);
	                //setup drawing
	                draw_set_font(fnt_command);
	                draw_set_colour(c_white);
	                draw_set_halign(fa_center);
	                draw_set_valign(fa_top);
	                //draw nickname
	                tb = 2 //text buffer
	                draw_text(cx+HUDwidth/2, cy+tb, string_hash_to_newline(ds_list_find_value(server_data, index++))); // get nickname
	                //draw score and lives
	                draw_set_halign(fa_left);
                
	                draw_text(cx+tb, cy+tb*3+12, string_hash_to_newline("SC: " + ds_list_find_value(server_data, index++))); // get score
	                draw_text(cx+tb+72, cy+tb*3+12, string_hash_to_newline("LV: " + ds_list_find_value(server_data, index++))); // get level
	                draw_set_halign(fa_center);
	                draw_text(cx+HUDwidth/2+tb, cy+tb*3+24, string_hash_to_newline("Lives: " + ds_list_find_value(server_data, index++))); // get lives
                
	                //players
	                for (cp = 0; cp < team_players; cp++) {
	                    //draw sprite
	                    var sb = 8;
	                    draw_sprite_ext(ds_list_find_value(server_data, index++), 0, cx+sb, cy+HUDheight/2+sb+cp*(cSize+sb*2), 2, 2, 0, c_white, 1);
	                    if (ds_list_find_value(server_data, index++)) {
	                        //draw health
	                        bx = cx+sb*2+cSize;
	                        by = cy+HUDheight/2+sb+cp*(cSize+sb*2)+sb;
	                        bh = cSize/2-sb/2;
	                        draw_healthbar(bx, by, bx+(HUDwidth/2), by+bh, ds_list_find_value(server_data, index++), c_dkgray, c_red, c_green, 0, true, true);
	                        by += bh;
	                        draw_healthbar(bx, by, bx+(HUDwidth/2), by+bh, ds_list_find_value(server_data, index++), c_dkgray, c_fuchsia, c_navy, 0, true, true);
	                    }
	                }
	                //add to cy
	                cy += yscale*HUDheight;
	                }
	            }
	        }
	    else {
	        //iterate through teams
	        for (var i = 0; i < teamMax; i++){
	            var Team = ds_map_find_value(gameTeams, i);
	            if !(is_undefined(Team)) {
	                //draw background
	                var size = ds_list_size(Team.players)-1;
	                yscale = 1+size*.5;
	                draw_sprite_ext(spr_HUD, -1, cx, cy, 1, yscale, 0, c_white, 1);
	                //setup drawing
	                draw_set_font(fnt_command);
	                draw_set_colour(c_white);
	                draw_set_halign(fa_center);
	                draw_set_valign(fa_top);
	                //draw nickname
	                tb = 2 //text buffer
	                draw_text(cx+HUDwidth/2, cy+tb, string_hash_to_newline(Team.nickname));
	                //draw score and lives
	                draw_set_halign(fa_left);
	                draw_text(cx+tb, cy+tb*3+12, string_hash_to_newline("SC: " + string(round(Team.tScore))));
	                draw_text(cx+tb+72, cy+tb*3+12, string_hash_to_newline("LV: " + string(round(Team.LVL))));
	                draw_set_halign(fa_center);
	                draw_text(cx+HUDwidth/2+tb, cy+tb*3+24, string_hash_to_newline("Lives: " + string(Team.tLives)));
                
	                //players
	                for (cp = 0; cp < ds_list_size(Team.players); cp ++) {
	                    //player
	                    var player = ds_list_find_value(Team.players, cp);
                    
	                    //draw sprite
	                    var sb = 8;
	                    draw_sprite_ext(player.sprite_index, 0, cx+sb, cy+HUDheight/2+sb+cp*(cSize+sb*2), 2, 2, 0, c_white, 1);
	                    if (instance_exists(player.gameCharacter)) {
	                        //draw health
	                        bx = cx+sb*2+cSize;
	                        by = cy+HUDheight/2+sb+cp*(cSize+sb*2)+sb;
	                        bh = cSize/2-sb/2;
	                        draw_healthbar(bx, by, bx+(HUDwidth/2), by+bh, player.gameCharacter.hp, c_dkgray, c_red, c_green, 0, true, true);
	                        by += bh;
	                        draw_healthbar(bx, by, bx+(HUDwidth/2), by+bh, player.gameCharacter.energy, c_dkgray, c_fuchsia, c_navy, 0, true, true);
	                        }
	                    }
	                //add to cy
	                cy += yscale*HUDheight;
	            }
	        }
	    }
	}
}


/// score menu ONLINE ONLY!
if (global.online) {
    if (state == STATE_SCORE) {
        // setup drawing
        draw_set_font(fnt_score);
        draw_set_halign(fa_center);
        draw_set_colour(c_white);
        
        // draw title
        draw_text(room_width/2, 160, string_hash_to_newline("Scores!"));
        
        //display variables
        cx = room_width-128; //current x
        cy = 0; //current y
        var sy = 0; // score y
        HUDwidth = 128; //width of HUD
        HUDheight = 96; //height of HUD
        cSize = 32; //size of character
        
        // index - current index in list
        var index = 0;
        // get message, continue or restart
        scoreMessage = ds_list_find_value(server_data, index++);
        var seed = ds_list_find_value(server_data, index++);
        var water_delay = ds_list_find_value(server_data, index++);
        
        //iterate through teams
        var team_amount = ds_list_find_value(server_data, index++);
        
        for (var i = 1; i < team_amount; i++){
            var team_exists = ds_list_find_value(server_data, index++); // get team_exists
            if (team_exists) {
                // get variables
                var team_players = ds_list_find_value(server_data, index++); // get amount of players
                var nickname = ds_list_find_value(server_data, index++);
                var team_score = ds_list_find_value(server_data, index++);
                var team_level = ds_list_find_value(server_data, index++);
                var team_lives = ds_list_find_value(server_data, index++);
                
                // draw score
                draw_set_font(fnt_score);
                draw_text(room_width/2, 200 + 26*sy++, string_hash_to_newline(nickname + " Score: " + team_score + " Lives: " + team_lives));
                
                //draw background
                var size = team_players-1;
                yscale = 1+size*.5;
                draw_sprite_ext(spr_HUD, -1, cx, cy, 1, yscale, 0, c_white, 1);
				
                //setup drawing
                draw_set_font(fnt_command);
                draw_set_colour(c_white);
                draw_set_halign(fa_center);
                draw_set_valign(fa_top);
				
                //draw nickname
                tb = 2 //text buffer
                draw_text(cx+HUDwidth/2, cy+tb, string_hash_to_newline(nickname)); // get nickname
				
                //draw score and lives
                draw_set_halign(fa_left);
                draw_text(cx+tb, cy+tb*3+12, string_hash_to_newline("SC: " + team_score)); // get score
                draw_text(cx+tb+72, cy+tb*3+12, string_hash_to_newline("LV: " + team_level)); // get level
                draw_set_halign(fa_center);
                draw_text(cx+HUDwidth/2+tb, cy+tb*3+24, string_hash_to_newline("Lives: " + team_lives)); // get lives
                
                //players
                for (cp = 0; cp < team_players; cp++) {
                    //draw sprite
                    var sb = 8;
                    draw_sprite_ext(ds_list_find_value(server_data, index++), 0, cx+sb, cy+HUDheight/2+sb+cp*(cSize+sb*2), 2, 2, 0, c_white, 1);
                    if (ds_list_find_value(server_data, index++)) {
                        //draw health
                        bx = cx+sb*2+cSize;
                        by = cy+HUDheight/2+sb+cp*(cSize+sb*2)+sb;
                        bh = cSize/2-sb/2;
                        draw_healthbar(bx, by, bx+(HUDwidth/2), by+bh, ds_list_find_value(server_data, index++), c_dkgray, c_red, c_green, 0, true, true);
                        by += bh;
                        draw_healthbar(bx, by, bx+(HUDwidth/2), by+bh, ds_list_find_value(server_data, index++), c_dkgray, c_fuchsia, c_navy, 0, true, true);
                    }
                }
                //add to cy
                cy += yscale*HUDheight;
            }
        }
        
        //message
        draw_text(room_width/2, 160 + 26*i + 100, string_hash_to_newline("Press SPACE to " + string(scoreMessage)));
        draw_text(room_width/2, 160 + 26*i + 132, string_hash_to_newline("Your room seed was: " + string(seed)));
        draw_text(room_width/2, 160 + 26*i + 160, string_hash_to_newline("Water Delay: " + string(water_delay)));
    }
}
