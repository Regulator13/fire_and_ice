/// @description  spectate
if (global.online) {
  if (keyboard_check_pressed(vk_up)) vspeed = -1;
  else if (keyboard_check_pressed(vk_down)) vspeed = 1;
  else vspeed = 0;
  }

