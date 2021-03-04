move_spd = 10;
grv = 0.4;
jump_height = 10;
jump_held = 0;
max_jump_held = 40;
vsp = 0;
hsp = 0;

left = 0;
right = 0;
jump = false;
can_jump = false;
max_jump_buffer = room_speed*0.1;
jump_buffer = 0;

is_alive = true;
//neural_network = noone;
time_took = 0;

farthest_x = 0;
time_still = 0;
max_time_still = room_speed*3;

show_debug_message("ai created: "+string(delta_time));