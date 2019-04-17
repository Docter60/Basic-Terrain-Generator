#define camera__
/// camera__

/*
A basic camera implementation.
*/

#define camera_create
/// camera_create()
/*
Initialize members
*/
view_zoom = 1;

#define camera_step
/// camera_step()
/*
Updating the camera
1. Move to new spot
2. Zoom
3. Correct for movement and zoom
*/
// Movement code
d_key = keyboard_check(ord('D'));
a_key = keyboard_check(ord('A'));
s_key = keyboard_check(ord('S'));
w_key = keyboard_check(ord('W'));

hspeed = 0;
vspeed = 0;

if(d_key && hspeed < 4) hspeed += 2;
if(a_key && hspeed > -4) hspeed -= 2;

if(s_key && vspeed < 4) vspeed += 2;
if(w_key && vspeed > -4) vspeed -= 2;

// Zoom code
if(keyboard_check(vk_control)){
    view_zoom += mouse_wheel_up() * 0.1;
    view_zoom -= mouse_wheel_down() * 0.1;
    
    view_zoom = clamp(view_zoom, 0.05, 10);
}

// Move code

view_wview = 960 / view_zoom;
view_hview = 540 / view_zoom;

view_xview = lerp(view_xview, x - view_wview / 2, 0.1);
view_yview = lerp(view_yview, y - view_hview / 2, 0.1);

view_xview = x - view_wview / 2;
view_yview = y - view_hview / 2;