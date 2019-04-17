#define nature__
/// nature__k

/*
Nature scripts for calculating weather or climate data at a point (x, y)
*/

#define nature_get_sea_level
/// nature_get_sea_level(x, y)
/*
Returns data based on the sea level seed's perlin noise map.
param x - the x position desired on the map
param y - the y position desired on the map
return (real) a sea level between 0 and 1
*/

return fractal_noise_get(obj_terrain_controller.sea_seed,
                         argument0,
                         argument1,
                         obj_terrain_controller.sea_octave,
                         obj_terrain_controller.sea_scale);

#define nature_get_temperature
/// nature_get_temperature(x, y)
/*
Returns data based on the temperature seed's perlin noise map.
param x - the x position desired on the map
param y - the y position desired on the map
return (real) a temperature between 0 and 1
*/

return fractal_noise_get(obj_terrain_controller.temperature_seed, 
                         argument0, 
                         argument1,
                         obj_terrain_controller.temperature_octave, 
                         obj_terrain_controller.temperature_scale);

#define nature_get_rainfall
/// nature_get_rainfall(x, y)
/*
Returns data based on the rainfall seed's perlin noise map.
param x - the x position desired on the map
param y - the y position desired on the map
return (real) a rainfall between 0 and 1
*/

return fractal_noise_get(obj_terrain_controller.rainfall_seed, 
                         argument0, 
                         argument1,
                         obj_terrain_controller.rainfall_octave, 
                         obj_terrain_controller.rainfall_scale);