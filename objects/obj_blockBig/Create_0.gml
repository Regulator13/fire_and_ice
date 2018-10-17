/// @description keep in bounds
if (x > room_width-sprite_width) instance_destroy();

/// Stop animation
image_speed = 0;

//hpNormal - normal hp of block
hpNormal = 3;
hpMax= 6;
hp = hpNormal;

//gravity
gravityMax = 10;
//gravityI - gravity icreasing increment
gravityI = 0.4;

//destroy score
with (instance_place(x, y, obj_score)) instance_destroy();


///destroy overlaping coins
with(instance_place(x, y, obj_score)) instance_destroy();

