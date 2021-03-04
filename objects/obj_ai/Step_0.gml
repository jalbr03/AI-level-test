if(!is_alive) exit;
if(x <= farthest_x){
	time_still++;
	if(time_still >= max_time_still){
		is_alive = false;
	}
}else{
	time_still = 0;
}
if(x > farthest_x) farthest_x = x;
time_took ++;
//show_debug_message("start----------------------------------------")
if(neural_network != noone){
	var network_index = 0;
	for(var i=0;i<global.screen_height;i++){
		//var test_l = [];
		for(var j=-global.screen_width/2;j<global.screen_width/2;j++){
			//array_push(test_l,-1*mp_grid_get_cell(global.grid, x div global.cell_size + j, i));
			neural_network.network[0][network_index] = -1*mp_grid_get_cell(global.grid, x div global.cell_size + j, i);
			
			network_index ++;
		}
		//show_debug_message(test_l);
	}
}
//show_debug_message("end---------------------------------------")
var output = neural_network.think();
//show_debug_message(output)
left = output[0];
right = output[1];
jump = output[2];

hsp = (right-left)*move_spd;
vsp += grv;

if(collision_rectangle(x+3,y,x+sprite_width-3,y+sprite_height+16,obj_static,0,1)){
	can_jump = true;
	jump_buffer = max_jump_buffer;
}else if(jump_buffer <= 0){
	can_jump = false;
}else{
	jump_buffer -= 1;
}

if(jump && can_jump){
	if(jump_held < max_jump_held){
		jump_held += 1;
		vsp = -jump_height;
	}else{
		can_jump = false;
		jump_held = 0;
	}
}

if(place_meeting(x,y+vsp,obj_static)){
	while(!place_meeting(x,y+sign(vsp),obj_static)){
		y += sign(vsp);
	}
	vsp = 0;
}
y+=vsp;

if(place_meeting(x+hsp,y,obj_static)){
	while(!place_meeting(x+sign(hsp),y,obj_static)){
		x += sign(hsp);
	}
	hsp = 0;
}
x+=hsp;
