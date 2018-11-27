/// @description Destroy particles
if part_system_exists(ps_spark){
	part_system_destroy(ps_spark)
	part_emitter_destroy_all(ps_spark)
}
