/// @description input

if string_length(keyboard_string) > 15
    {
    keyboard_string = string_copy(keyboard_string, 1, 15);
    }
input = keyboard_string;

//enter
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
                scr_createPath(other.input);
                event_user(2);
                }
            break;
        }
    //destroy self
    instance_destroy();
}
//escape
if (keyboard_check(vk_escape)) {
    instance_destroy();
    }

