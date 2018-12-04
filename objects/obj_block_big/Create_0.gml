/// @description Set variables
//Keep in bounds
if (x > room_width-sprite_width) instance_destroy();
climbable = true //this object can be climbed

///Animation
image_speed = 0;

//HP
hp_normal = 3;
hp_max = 6;
hp = hp_normal;

///Physics
gravity_max = 10;
gravity_incr = 0.4; //gravity icreasing increment
