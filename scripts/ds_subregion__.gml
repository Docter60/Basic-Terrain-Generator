#define ds_subregion__
/// ds_subregion__

/*
Subregion data structure
*/

#define ds_subregion_create
/// ds_subregion_create()
/*
Creates a subregion data structure in the form of a ds_grid.
*/
var subregion = ds_grid_create(SUBREGION_SIZE, SUBREGION_SIZE);

ds_grid_clear(subregion, -1);

return subregion;

#define ds_subregion_read
/// ds_subregion_read(subregion, string)
/*
Reads a string containing subregion data and stores the data in a given
subregion data structure.
*/
var subregion = argument0;
var str = argument1;

var list = string_split(str, " ");

if(ds_list_find_value(list, 0) == -1)
{
    return -1;
}

if(subregion == -1){
    subregion = ds_subregion_create();
}

for(var j = 0; j < SUBREGION_SIZE; ++j){
    for(var i = 0; i < SUBREGION_SIZE; ++i){
        subregion[# i, j] = real(list[| (j << 4) + i]);
    }
}

#define ds_subregion_write
/// ds_subregion_write(subregion)
/*
Writes a subregion data structure's data into a string.
*/
var subregion = argument0;
var str;

if(subregion == -1)
{
    return "-1";
}

for(var j = 0; j < SUBREGION_SIZE; ++j){
    for(var i = 0; i < SUBREGION_SIZE; ++i){
        str += string(subregion[# i, j]) + " ";
    }
}

return str;