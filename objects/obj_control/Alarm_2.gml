/// @description Rain generator

// Generate rain particle system
if animations_on = true{
	ps_rain = part_system_create()
	part_system_depth(ps_rain, -50)

	// Create rain drop particle
	prt_rain = part_type_create()
	part_type_shape(prt_rain, pt_shape_line)
	part_type_color1(prt_rain, c_aqua)
	part_type_alpha1(prt_rain, 0.2)
	part_type_orientation(prt_rain, 0, 0, 0, 0, 1)
	part_type_size(prt_rain, 0.2, 0.2, 0, 0)
	part_type_speed(prt_rain, 10, 10, 0, 0)
	part_type_direction(prt_rain, 270, 270, 0, 0)
	
	// Create rain emitter
	emt_rain = part_emitter_create(ps_rain)
	part_emitter_region(ps_rain, emt_rain, 32, room_width - 32, 0, 0, ps_shape_line, ps_distr_linear)
	part_emitter_stream(ps_rain, emt_rain, prt_rain, 12 - (global.water_delay / 100))
}

rain_active = true