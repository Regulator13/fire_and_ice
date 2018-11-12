/// @description Set variables
event_inherited();

///Stats
dmg = 0;
dir = choose(-1, 1)
can_attack = true
attack_delay = 5

///Animation
image_speed = 0;
//face right if facing right (default left)
if dir = 1{
	image_index = 1
}
