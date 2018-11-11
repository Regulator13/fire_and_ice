/// @description Animate
event_inherited();

///Animate
image_index = 0
if instance_exists(Holder){
	switch Holder.dir{
		//player traveling left
		default:
		
		case -1:
			image_index = 1
			if falling{
				image_index += drop_frame
			}
			break
		
		case 1:
			image_index = 2
			if falling{
				image_index += drop_frame
			}
			break
	}
}
