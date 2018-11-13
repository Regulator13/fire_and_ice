/// @description  Set Physics
event_inherited();

active = true; //whether or not to apply physics
frozen = false; //whether or not can move
will_freeze = false; //freeze while holding
freeze_buffer_max = 3*30; //countdown till freeze
freeze_buffer = freeze_buffer_max;
ignite = false; //used for explosions
sticky = false;
stuck = false;
Holder = noone; //who is holding self
Team = noone;
on_body = false //whether the item is carried above the player or on their body.

///Physics
mass = 10;
gravity_max = 10;
gravity_incr = 0.4; //downward acceleration
fric = .4 //friction
