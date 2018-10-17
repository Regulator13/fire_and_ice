/// @description  Set block type
// You can write your code in this editor
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

// moochProof - last team to act on it for mooching
moochProof = -1;

