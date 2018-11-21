/// @description Apply gravity
// Apply gravity
if (arc) {
    if (vspeed < gravity_max) {
        vspeed += gravity_incr;
		
        //keep gravity in bounds
        if (vspeed > gravity_max) vspeed = gravity_max;
    }
}

//Change the particle color
if part_system_exists(ps_spark){
	if attack == -1{
		part_type_color2(prt_spark, $FFF568, $F78E56)
	}
	
	if attack == 1{
		part_type_color2(prt_spark, c_yellow, $B2FFB)
	}
}
	
// Move the emitter dynamically
if part_emitter_exists(ps_spark, emt_spark){
	part_emitter_region(ps_spark, emt_spark, x, x + 10, y, y + 10, ps_shape_ellipse, ps_distr_gaussian)
}
