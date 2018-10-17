/// @description start input
for (input = 0; input < 4; input += 1) {
    if (gamepad_button_check(input, gp_start)) {
        event_user(0);
        }
    }
    

