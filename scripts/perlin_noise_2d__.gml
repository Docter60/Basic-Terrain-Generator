#define perlin_noise_2d__
/// perlin_noise_2d__

/*
An implementation of 2-dimensional perlin noise.
*/

#define perlin_noise_2d_get
/// perlin_noise_2d_get(seed, x, y, perlin_grid_scale)
/*
Calculates perlin noise at (x, y) given a seed and scale.
*/
var seed = argument0;
var xx = argument1;
var yy = argument2;
var scale = argument3 - 1;

var inv_scale = 1 / argument3;

var node_x = floor(xx * inv_scale);
var node_y = floor(yy * inv_scale);

var d_x = (xx & scale) * inv_scale;
var d_y = (yy & scale) * inv_scale;

var n_00 = perlin_noise_2d_get_node(seed, node_x,     node_y); // <-- update bottleneck
var n_01 = perlin_noise_2d_get_node(seed, node_x,     node_y + 1);
var n_10 = perlin_noise_2d_get_node(seed, node_x + 1, node_y);
var n_11 = perlin_noise_2d_get_node(seed, node_x + 1, node_y + 1);

var px_0 = lerp(n_00, n_01, d_y);
var px_1 = lerp(n_10, n_11, d_y);

return lerp(px_0, px_1, d_x);

#define perlin_noise_2d_get_node
/// perlin_noise_2d_get_node(seed, x, y)
/*
Calculates the magnitude of a node at (x, y) given a seed.
*/
var seed = argument0;
var xx = argument1;
var yy = argument2 << 16;

random_set_seed(seed + xx + yy);

return random(1);
#define perlin_noise_subregion
/// perlin_noise_subregion()
/*
Should theoretically cut calculation time by a factor of ~3-4 by calculating
all necessary nodes before determining the perlin noise factor.
*/