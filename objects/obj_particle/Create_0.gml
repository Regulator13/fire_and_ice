/// @description Create particles
/// Create mandatory particle systems
// countdown particle system
ps_countdown = part_system_create()
part_system_depth(ps_countdown, -50)
	
// explosion particle system
ps_explosion = part_system_create()
part_system_depth(ps_explosion, 50)

/// Create particles
// countdown1 particle
prt_countdown1 = part_type_create()
part_type_sprite(prt_countdown1, spr_countdown1, 0, 0, 0)
part_type_speed(prt_countdown1, 0.4, 0.4, 0, 0)
part_type_direction(prt_countdown1, 90, 90, 0, 0)
part_type_life(prt_countdown1, 20, 20)
// countdown2 particle
prt_countdown2 = part_type_create()
part_type_sprite(prt_countdown2, spr_countdown2, 0, 0, 0)
part_type_speed(prt_countdown2, 0.4, 0.4, 0, 0)
part_type_direction(prt_countdown2, 90, 90, 0, 0)
part_type_life(prt_countdown2, 20, 20)
// countdown3 particle
prt_countdown3 = part_type_create()
part_type_sprite(prt_countdown3, spr_countdown3, 0, 0, 0)
part_type_speed(prt_countdown3, 0.4, 0.4, 0, 0)
part_type_direction(prt_countdown3, 90, 90, 0, 0)
part_type_life(prt_countdown3, 20, 20)
	
// explosion particle
prt_explosion = part_type_create()
part_type_sprite(prt_explosion, spr_explosion, 1, 1, 0)
part_type_life(prt_explosion, 14, 14)

ps_mooch = noone
if global.Menu.animations_on = true{
	// mooch particle system
	ps_mooch = part_system_create()
	part_system_depth(ps_mooch, 50)
	
	// mooch particle
	prt_mooch = part_type_create()
	part_type_sprite(prt_mooch, spr_mooch, 0, 0, 0)
	part_type_speed(prt_mooch, 0.2, 0.2, 0, 0)
	part_type_direction(prt_mooch, 90, 90, 0, 0)
	part_type_life(prt_mooch, 20, 20)
}
 