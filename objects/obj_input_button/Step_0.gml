/// @description Input

if string_length(keyboard_string) > 15{
    keyboard_string = string_copy(keyboard_string, 1, 15);
}

input = keyboard_string;

//If the user hits the enter key, perform an action
if (keyboard_check(vk_enter)) {
    switch(action) {
        case"addNickname":
            ds_list_add(obj_menu.nicknameIdeas, input);
            break;
			
        case"delNickname":
            var index = ds_list_find_index(obj_menu.nicknameIdeas, input);
            if (index >= 0) ds_list_delete(obj_menu.nicknameIdeas, index);
            break;
			
        case"createPath":
            with(obj_menu) {
                scr_create_path(other.input);
                event_user(2);
            }
            break;
    }

    instance_destroy();
}

//Exit the input button
if (keyboard_check(vk_escape)) {
    instance_destroy();
}
