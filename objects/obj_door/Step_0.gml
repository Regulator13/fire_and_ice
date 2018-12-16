/// @description Open and Close
if not is_locked{
	//open if player is close
	if (distance_to_object(obj_character) < 64) {
	    if (image_index < imageOpen) image_speed = imageSpeed;
	    else if (image_index > imageOpen) image_speed = -imageSpeed;
	    else image_speed = 0;
	}

	//othewise close
	else {
	    if (image_index > 0 and image_index <= imageOpen) image_speed = -imageSpeed;
	    else if (image_index < imageMax and image_index > imageOpen) image_speed = imageSpeed;
	    else image_speed = 0;
	}
}
