#define utility__
/// utility__

/*
Various handy scripts
*/

#define string_split
/// string_split(:string, delimiter:string, ?list<string>):list<string>
/*
Split string by delimiter into a ds_list
*/
var s = argument[0], d = argument[1], r;
if (argument_count >= 3) {
    r = argument[2];
    ds_list_clear(r);
} else r = ds_list_create();
var p = string_pos(d, s);
var dl = string_length(d);
if (dl) while (p) {
    p -= 1;
    ds_list_add(r, string_copy(s, 1, p));
    s = string_delete(s, 1, p + dl);
    p = string_pos(d, s);
}
ds_list_add(r, s);
return r;

#define biome_get_color
/// biome_get_color(climate_factor)
/*
A mapper script using data from nature scripts and giving back an index in the
tile set corresponding to an appropriate biome.
*/
var xx = argument0 div 100;
var yy = argument0 mod 100;

var r = 0;
var g = 0;
var b = 0;

if(xx > 66){
    // Desert
    return 5;
} else if(xx > 33){
    if(yy > 33){
        // Forest
        return 2;
    } else {
        // Plains
        return 1;
    }
} else {
    if(yy > 66){
        // Arctic
        return 6;
    } else if(yy > 33){
        // Taiga
        return 8;
    } else {
        // Tundra
        return 4;
    }
}