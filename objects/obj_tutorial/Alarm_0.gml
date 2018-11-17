/// @description Next message
//next message
currentMessage++;

//if last message, stop
if (currentMessage >= ds_list_size(messages)){
    instance_destroy();
}

// reset timer
alarm[0] = showTime;
