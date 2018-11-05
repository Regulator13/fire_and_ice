/// @description  Set block type
image_speed = 0;

//inherited
event_inherited();

//hp_normal - normal hp of block
hp_normal = 3;
hp_max= 4;
hp = hp_normal;

//set mass
mass = 12

//Set friction
fric = 2.4

//sticky - whether or not object is sticky
sticky = false;
stuck = false; //whether or not block is stuck to something

//from_water - Whether this block was made from a water droplet
from_water = false

// moochProof - last team to act on it for mooching
moochProof = -1;

