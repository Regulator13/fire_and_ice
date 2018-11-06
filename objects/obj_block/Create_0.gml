/// @description  Set block type
event_inherited();

sticky = false; //whether or not object is sticky
stuck = false; //whether or not block is stuck to something 
from_water = false //whether this block was made from a water droplet
mooch_proof = -1; //last team to act on it for mooching

///Hp
hp_normal = 3;
hp_max= 4;
hp = hp_normal;

///Physics
mass = 12
fric = 2 //friction

///Animation
image_speed = 0;
