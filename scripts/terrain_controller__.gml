#define terrain_controller__
/// terrain_controller__

/*
The terrain controller manages, generates, and renders terrain
utilizing the three-layer terrain data structure.
*/

#define terrain_controller_create
/// terrain_controller_create()

/*
Initialize members
*/

// Stores regions loaded by the user into memory
// Used only when loading and saving terrain
// key = string
// value = file
regions = ds_map_create();

// Stores surfaces for subregion drawing
// key = string
// value = surface
subregion_surfaces = ds_map_create();

//
view_map = ds_map_create();

world_seed = 0;

random_set_seed(world_seed);

// Seed for defining ocean levels
sea_seed = irandom(1000000000);
sea_scale = 64; // 64 looks good for normal generation
sea_octave = 6; // 6 seems detailed enough

// Seed used for terrain generation of biomes
temperature_seed = irandom(1000000000);
temperature_scale = 64;
temperature_octave = 4;

// Seed used for terrain generation of biomes
rainfall_seed = irandom(1000000000);
rainfall_scale = 64;
rainfall_octave = 4;

#define terrain_controller_update
/// terrain_controller_step()
/*
Jobs of this script:
- Generates/loads subregions when needed
- Set what needs to be rendered for the next draw
- Allocate subregion surfaces for more efficient loading after first load.
*/
ds_map_clear(view_map);

// Calculate the bounds for the current view in subregion space
var left = (view_xview - 100) >> 9;
var top = (view_yview - 100) >> 9;
var right = 1 + ((view_xview + view_wview + 100) >> 9);
var bottom = 1 + ((view_yview + view_hview + 100) >> 9);

// Iterate through checking to make sure each subregion is generated and
// drawn to a surface.
for(var j = top; j != bottom; ++j){
    for(var i = left; i != right; ++i){
        // THIS NEEDS TO BE REVISED
        var surface_key = string(i) + "." + string(j);
        var surface = ds_map_find_value(subregion_surfaces, surface_key);
        if(is_undefined(surface) || !surface_exists(surface)){
            var region_x = i >> 4;
            var region_y = j >> 4;
            var region_name = string(region_x) + "." + string(region_y);
            var region = ds_region_create();
            ds_region_read(region, region_name);
            ds_map_add(regions, region_name, region);
            
            var region_sub_x = i & 0xF;
            var region_sub_y = j & 0xF;
            
            var subregion = region[# region_sub_x, region_sub_y];
            
            // Generate if subregion is entirely new
            if(subregion == -1){
                subregion = ds_subregion_create();
                terrain_controller_generate(subregion, i, j);
                region[# region_sub_x, region_sub_y] = subregion;
            }
            surface = terrain_controller_generate_surface(subregion);
            ds_map_add(subregion_surfaces, surface_key, surface);
        }
        ds_map_add(view_map, surface_key, surface);
    }
}

#define terrain_controller_draw
/// terrain_controller_draw()
/*
Draw all subregions calculated to be currently shown on the screen.
*/
var key = ds_map_find_first(view_map);
var size = ds_map_size(view_map);

for(var i = 0; i < size; ++i){
    var surface = view_map[? key];
    var arr = string_split(key, "."); // <-- Render bottleneck
    var xx = real(arr[| 0]) << 9;
    var yy = real(arr[| 1]) << 9;
    
    draw_surface(surface, xx, yy);
    key = ds_map_find_next(view_map, key);
}

#define terrain_controller_save
/// terrain_controller_save()

/*
Saves all created regions.
UNIMPLEMENTED
*/

#define terrain_controller_generate_surface
/// terrain_controller_generate_surface(subregion)

/*
Creates a surface based on subregional data.
param subregion - the subregion to convert
return surface - the finished surface
*/

var subregion = argument0;

var surface = surface_create(512, 512);
surface_set_target(surface);

for(var j = 0; j < ds_grid_height(subregion); ++j){
    var top = j << 5;
    for(var i = 0; i < ds_grid_width(subregion); ++i){
        var left = i << 5;
        var tile_id = subregion[# i, j];
        draw_background_part(bkg_tile_set,
                             (tile_id mod 3) << 5,
                             (tile_id div 3) << 5,
                             32, 32,
                             left, top);
    }
}

surface_reset_target();

return surface;

#define terrain_controller_generate
/// terrain_controller_generate(subregion, x, y)
/*
Generates a subregion utilizing nature scripts and a biome color
wrapping script.
*/
var subregion = argument0;
var subregion_x = argument1;
var subregion_y = argument2;

var left = subregion_x << 4;
var top = subregion_y << 4;

for(var j = 0; j < SUBREGION_SIZE; ++j){
    var yy = top + j;
    for(var i = 0; i < SUBREGION_SIZE; ++i){
        var tile_id = 0;
        var xx = left + i;
        var sea_level = nature_get_sea_level(xx, yy);
        if(sea_level < 0.4){
            subregion[# i, j] = 7;
            continue;
        }
        var temperature = round(100 * nature_get_temperature(xx, yy));
        var rainfall = round(100 * nature_get_rainfall(xx, yy));
        var climate = 100 * temperature + rainfall;
        subregion[# i, j] = biome_get_color(climate);
    }
}