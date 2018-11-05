/// @description  Set Physics
mass = 10;
//gravity
gravity_max = 10;
//gravityI - gravity icreasing increment
gravityI = 0.4;
fric = .4 //Set all objects friction


//active - whether or not to apply physics
active = true;
//frozen - whether or not can move
frozen = false;
//willFreeze - freeze while holding
willFreeze = false;
//freezeBuffer - countdown till freeze
freezeBufferMax = 3*30;
freezeBuffer = freezeBufferMax;

//ignite - used for explosions
ignite = false;

//sticky
sticky = false;
//stuck - whether thing is stuck
stuck = false;

//holder - who is holding self
holder = noone;

//team - team object
team = noone;

event_inherited();


