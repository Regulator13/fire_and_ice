/// @description Rain generator

// Generate rain particle system
if obj_control.animations_on = true{
	rain = part_system_create()
	part_system_depth(rain, -50)

	// Create rain drop particle
	raindrop = part_type_create()
	part_type_shape(raindrop, pt_shape_line)
	part_type_color1(raindrop, c_aqua)
	part_type_alpha1(raindrop, 0.2)
	part_type_orientation(raindrop, 0, 0, 0, 0, 1)
	part_type_size(raindrop, 0.2, 0.2, 0, 0)
	part_type_speed(raindrop, 10, 10, 0, 0)
	part_type_direction(raindrop, 270, 270, 0, 0)
	
	// Create rain emitter
	rain_emitter = part_emitter_create(rain)
	part_emitter_region(rain, rain_emitter, 32, room_width - 32, 0, 0, ps_shape_line, ps_distr_linear)
	part_emitter_stream(rain, rain_emitter, raindrop, 12 - (global.water_delay / 100))
}

rain_active = true