/// @description  @description Draw score
if (!global.online) {
draw_set_font(fnt_score);
draw_set_halign(fa_center);
draw_set_colour(c_white);

draw_text(room_width/2, 160, string_hash_to_newline("Scores!"));
//iterate through teams
var cy = 0;
for (var i = 0; i < obj_menu.teamMax; i++){
    var team = ds_map_find_value(obj_menu.gameTeams, i);
    if !(is_undefined(team)) {
        draw_text(room_width/2, 200 + 26*cy, string_hash_to_newline(team.nickname + " Score: " + string(round(team.tScore)) + " Lives:" + string(team.tLives)));
        cy ++;
        }
    }

//message
if (global.continueGame) message = "continue!";
else message = "restart!";
draw_text(room_width/2, 160 + 26*i + 100, string_hash_to_newline("Press SPACE to " + message));
draw_text(room_width/2, 160 + 26*i + 132, string_hash_to_newline("Your room seed was: " + string(random_get_seed())));
draw_text(room_width/2, 160 + 26*i + 160, string_hash_to_newline("Water Delay: " + string(global.waterDelay)));
}

