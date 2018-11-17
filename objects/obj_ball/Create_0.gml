/// @description Set variables

event_inherited();

attack = 0; //attack to hp (-1 for ice, 1 for fire)
Source = noone; //who created it
arc = false; //whether or not ball will arc
alarm[0] = 6*30 //destroy the ball after 6 seconds
mass = 10;

///animations
// Particle System
if not global.online{
	if obj_control.animations_on{
		ps_spark = part_system_create()
		part_system_depth(ps_spark, 50)
	 	// Particle Sparks
		prt_spark = part_type_create()
		part_type_shape(prt_spark, pt_shape_pixel)
		part_type_life(prt_spark, 2, 3)
	 	// Particle Emitter
		emt_spark = part_emitter_create(ps_spark)
		part_emitter_stream (ps_spark, emt_spark, prt_spark, 40)
	}
}
