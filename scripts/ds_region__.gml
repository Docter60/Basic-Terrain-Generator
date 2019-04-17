#define ds_region__
/// ds_region__

/*
Region data structure.
*/

#define ds_region_create
/// ds_region_create()
/*
Creates a region data structure in the form of a ds_grid.
*/
var region = ds_grid_create(REGION_SIZE, REGION_SIZE);

ds_grid_clear(region, -1); // Fill with -1 flag

return region;

#define ds_region_read
/// ds_region_read(region, region_name)
/*
Reads a region file and stores the data into a given region data structure.
*/
var region = argument0;
var region_name = argument1;

var file_path = "Basic Terrain Generation\" + region_name + ".r";

if(file_exists(file_path)){
    var region_file = file_text_open_read(file_path);
    for(var j = 0; j < REGION_SIZE; ++j){
        for(var i = 0; i < REGION_SIZE; ++i){
            var line = file_text_readln(region_file);
            ds_subregion_read(region[# i, j], line);
        }
    }
    file_text_close(region_file);
}

#define ds_region_write
/// ds_region_write(region, region_name)
/*
Writes data from a region data structure into a region file.
*/
var region = argument0;
var region_name = argument1;

var region_file = file_text_open_write("Basic Terrain Generation\" + region_name + ".r");

for(var j = 0; j < REGION_SIZE; ++j){
    for(var i = 0; i < REGION_SIZE; ++i){
        var subregion = region[# i, j];
        file_text_write_string(region_file, ds_subregion_write(subregion));
        file_text_writeln(region_file);
    }
}

file_text_close(region_file);