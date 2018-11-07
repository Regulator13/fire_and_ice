/// @description Draw score
if (!global.online) {
	//Set font variables
	draw_set_font(fnt_score);
	draw_set_halign(fa_center);
	draw_set_colour(c_white);

	draw_text(room_width/2, 160, string_hash_to_newline("Scores!"));
	
	//iterate through teams
	var cy = 0;
	for (var i = 0; i < obj_menu.team_max; i++){
	    var Team = ds_map_find_value(obj_menu.game_teams, i);
	    if !(is_undefined(Team)) {
	        draw_text(room_width/2, 200 + 26*cy, string_hash_to_newline(Team.nickname + " Score: " + string(round(Team.tScore)) + " Lives:" + string(Team.tLives)));
	        cy ++;
	    }
	}

	//set message to display for what space does
	if (global.continue_game) message = "continue!";
	else message = "restart!";
	
	//Print score screen messages
	draw_text(room_width/2, 160 + 26*i + 100, string_hash_to_newline("Press SPACE to " + message));
	draw_text(room_width/2, 160 + 26*i + 132, string_hash_to_newline("Your room seed was: " + string(random_get_seed())));
	draw_text(room_width/2, 160 + 26*i + 160, string_hash_to_newline("Water Delay: " + string(global.water_delay)));
}

