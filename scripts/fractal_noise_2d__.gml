#define fractal_noise_2d__
/// fractal_noise_2d__

/*
An implementation of 2-dimensional fractal noise.
*/

#define fractal_noise_get
/// fractal_noise_get(seed, x, y, octave, init_grid_scale)
/*
Calculates fractal noise at (x, y) given a seed, octave and scale.
*/
var seed = argument0;
var xx = argument1;
var yy = argument2;
var octave = argument3;
var scale = argument4;

var noise = 0;
var amp = 0.5;

for(var i = 0; i < octave; ++i)
{
    noise += amp * perlin_noise_2d_get(seed, xx, yy, scale);
    xx = xx << 1;
    yy = yy << 1;
    amp *= 0.5;
}

return noise;