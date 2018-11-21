/// @function  scr_create_button(x, y, action, title)
/// @description  Creates an button for the menu system, must be called from obj_menu
/// @param x int | button x coordinate
/// @param y int | button y coordinate
/// @param action string | action string used in button click, [event_user(0)]
/// @param title string | title shown on block [undercase]
/// @returns n/a

//Arguments
var _x = argument0
var _y = argument1
var action = argument2
var title = argument3

button = instance_create_layer(_x, _y, "lay_instances", obj_button)
button.action = action
button.title = title
ds_list_add(buttons, button)