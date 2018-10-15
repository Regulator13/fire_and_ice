///scr_platform generate

sx = argument0;
sy = argument1;
dx = sx;
dy = sy;
gridSize = 32;

//create score
instance_create(dx+gridSize, dy-gridSize+16,  obj_score);

switch(argument2) {
    case 0: //five long platform
        for (k = 0; k < 5; k += 1) {
            dx += gridSize;
            if (place_free(dx,dy)) {
                instance_create(dx, dy,  obj_blockBig);
                }
            }
        //patrol
        if (place_free(dx-gridSize,dy-gridSize)) instance_create(dx-gridSize, dy-gridSize+16,  obj_patrol);
        break;
case 6: //three long platform
for (k = 0; k < 3; k += 1) {
dx += gridSize;
if (place_free(dx,dy)) {
instance_create(dx, dy,  obj_blockBig);
}
}
//recharge station
if (place_free(dx-gridSize,dy-gridSize)) instance_create(dx-gridSize, dy-gridSize,  obj_rechargeStation);
break;
case 1: //five long 'u'
if (place_free(dx,dy-gridSize)) instance_create(dx, dy-gridSize,  obj_blockBig);
for (k = 0; k < 5; k += 1) {
dx = sx+gridSize*k;
if (place_free(dx,dy)) instance_create(dx, dy,  obj_blockBig);
}
if (place_free(dx,dy-gridSize)) instance_create(dx, dy-gridSize,  obj_blockBig);
//recharge station
if (place_free(dx-gridSize*2,dy-gridSize)) instance_create(dx-gridSize*2, dy-gridSize,  obj_rechargeStation);
break;
    case 2: //five long right side 'L'
        //if (place_free(dx,dy-gridSize)) instance_create(dx, dy-gridSize,  obj_blockBig);
        for (k = 0; k < 5; k += 1) {
            dx = sx+gridSize*k;
            if (place_free(dx,dy)) instance_create(dx, dy,  obj_blockBig);
            }
        if (place_free(dx,dy-gridSize)) instance_create(dx, dy-gridSize,  obj_blockBig);
        break;
case 3: //five long left side 'L'
if (place_free(dx,dy-gridSize)) instance_create(dx, dy-gridSize,  obj_blockBig);
for (k = 0; k < 5; k += 1) {
dx = sx+gridSize*k;
if (place_free(dx,dy)) instance_create(dx, dy,  obj_blockBig);
}
//if (place_free(dx,dy-gridSize)) instance_create(dx, dy-gridSize,  obj_blockBig);
break;
case 4: //five long 'u'
if (place_free(dx,dy-gridSize)) instance_create(dx, dy-gridSize/2,  obj_blockStation);
for (k = 0; k < 5; k += 1) {
dx = sx+gridSize*k;
if (place_free(dx,dy)) instance_create(dx, dy,  obj_blockBig);
}
if (place_free(dx,dy-gridSize)) instance_create(dx, dy-gridSize/2,  obj_blockStation);
//patrol
        if (place_free(dx-gridSize*2,dy-gridSize)) instance_create(dx-gridSize, dy-gridSize+16,  obj_patrol);
break;
case 5: //three long with block
for (k = 0; k < 3; k += 1) {
dx = sx+gridSize*k;
if (place_free(dx,dy)) instance_create(dx, dy,  obj_blockBig);
}
//sticky block station
if (place_free(dx,dy-gridSize)) with(instance_create(dx, dy-gridSize/2,  obj_blockStation)) sticky = true;
break;
default:
if (place_free(dx,dy)) {
instance_create(dx, dy,  obj_blockBig);
}
break;
}

