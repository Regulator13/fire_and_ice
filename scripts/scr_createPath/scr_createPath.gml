//create path
name = argument0;

//check if already exists
while (ds_list_find_index(pathNames, name) != -1) {
    //if already exists, change name
    name = name + "-";
    }

//name = string(ds_list_size(pathNames)+1);

ds_list_add(pathNames, name);
ds_map_add(paths, name, ds_map_create());
path = ds_map_find_value(paths, name);
ds_map_add(path, "score", 0);
ds_map_add(path, "length", 0);
ds_map_add_list(path, "seeds", ds_list_create());

//set current path
pathSelected = ds_list_find_index(pathNames, name);
