/// @description  Set block type
image_speed = 0;

//inherited
event_inherited();

//hpNormal - normal hp of block
hpNormal = 3;
hpMax= 4;
hp = hpNormal;

//sticky - whether or not object is sticky
sticky = false;
stuck = false; //whether or not block is stuck to something

//from_water - Whether this block was made from a water droplet
from_water = false

// moochProof - last team to act on it for mooching
moochProof = -1;

