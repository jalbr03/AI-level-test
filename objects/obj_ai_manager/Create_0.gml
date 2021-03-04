//neural_network = new create_network(1,1,1,5);
//neural_network.create_weights(0, 1);

//neural_network.network[0][0] = 1;
////neural_network.network[0][1] = 1;
////neural_network.network[0][2] = 1;

//show_debug_message("-----------------start-------------");

////for(var i=1;i<array_length(neural_network.network);i++){
////	for(var j=0;j<array_length(neural_network.network[i])-1;j++){
////		show_debug_message(neural_network.weights[|i-1][j]);
////	}
////}
//show_debug_message(neural_network.think());
randomize();
trainer = new ai_trainer();
current_group = 1;

current_weights_being_tested = 0;
current_weights_array = [];

current_gen = 1;
best_score = 0;

global.screen_width = 42;
global.screen_height = 24;
global.cell_size = 32;

var hcells = room_width div global.cell_size;
var vcells = room_height div global.cell_size;

global.grid = mp_grid_create(0,0,hcells,vcells,global.cell_size,global.cell_size);

mp_grid_add_instances(global.grid,obj_static,0);
mp_grid_add_instances(global.grid,obj_killer,0);

number_of_input_neurons = global.screen_width*global.screen_height;
number_of_hidden_neurons = 16;
number_of_hidden_layers = 3;
number_of_output_neurons = 3;

total_weights = (number_of_input_neurons+1)*(number_of_hidden_neurons+1) + power(number_of_hidden_neurons+1,number_of_hidden_layers) + (number_of_hidden_neurons+1)*number_of_output_neurons;

show_debug_message(total_weights);

for(var i=0;i<population;i++){
	var ai = instance_create_layer(x,y,layer,obj_ai);
	ai.neural_network = new create_network(number_of_input_neurons,number_of_hidden_neurons,number_of_hidden_layers,number_of_output_neurons);
	ai.neural_network.create_weights(-1, 1);
}
