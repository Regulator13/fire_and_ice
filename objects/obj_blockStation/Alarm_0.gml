/// @description Create stations block
if (sticky) {
with (instance_create(x, y, obj_block)) sticky = true;
}
else instance_create(x, y, obj_block);


