//show_debug_message(mp_grid_get_cell(global.grid, mouse_x div global.cell_size, mouse_y div global.cell_size))
var any_alive = false;
for(var i=0;i<instance_number(obj_ai);i++){
	var ai = instance_find(obj_ai,i);
	if(ai.is_alive){
		any_alive = true;
	}
}
if(!any_alive){
	trainer.end_current_group();
	current_group ++;
	if(current_group >= max_groups) {
		current_gen+=1;
		current_group = 1;
		current_weights_being_tested = 0;
		
		for(var i=0; i<array_length(current_weights_array); i++){
			ds_list_destroy(current_weights_array[i]);
		}
		current_weights_array = trainer.create_new_geration(2, 3, 0.2,500,total_weights);
	}
	
	for(var i=0;i<population;i++){
		var ai = instance_create_layer(x,y,layer,obj_ai);
		ai.neural_network = new create_network(number_of_input_neurons,number_of_hidden_neurons,number_of_hidden_layers,number_of_output_neurons);
		if(current_weights_being_tested < array_length(current_weights_array)){
			ai.neural_network.weights = current_weights_array[current_weights_being_tested];
			current_weights_being_tested++;
		}else{
			ai.neural_network.create_weights(-1, 1);
		}
	}
}
