function dot(array1, array2){
	var total = 0;
	for(var i=0;i<array_length(array1);i++){
		total += array1[i]*array2[i];
	}
	return total;
}

//function sigmoid(input_x){
//	return 1/(1 + power(2.71828182846,-input_x));
//}

function activation(input_number){
	if(input_number >= 0.5){
		return 1;
	}else{
		return 0;
	}
}

function create_network(number_of_inputs, number_of_hidden, number_of_hidden_layers, number_of_outputs) constructor {
	network = [];
	weights = ds_list_create();
	
	var i,j;
	var input_n = [];
	var hidden_l = [];
	var output_n = [];

	for(i=0;i<number_of_inputs;i++){
		array_push(input_n, 0);
	}
	array_push(input_n, 1);
	for(i=0;i<number_of_hidden_layers;i++){
		var new_layer = [];
		for(j=0;j<number_of_hidden;j++){
			array_push(new_layer, 0);
		}
		array_push(new_layer, 1);
		array_push(hidden_l, new_layer);
	}
	
	for(i=0;i<number_of_outputs;i++){
		array_push(output_n, 0);
	}

	array_copy(network,0,[input_n],0,array_length(input_n));
	array_copy(network,array_length(network),hidden_l,0,array_length(hidden_l));
	array_copy(network,array_length(network),[output_n],0,array_length(output_n));
	
	function create_weights(low_range, high_range) {
		var i,j,k;
		for(i=1;i<array_length(network);i++) {
			var current_groups = [];
			for(j=0;j<array_length(network[i]);j++) {
				var current_group = [];
				for(k=0;k<array_length(network[i-1]);k++){
					array_push(current_group, random_range(low_range,high_range));
				}
				array_push(current_groups,current_group);
			}
			ds_list_add(weights, current_groups);
		}
	}
	
	function think() {
		var i,j;
		for(i=1;i<array_length(network);i++) {
			for(j=0;j<array_length(network[i]);j++) {
				if(j < array_length(network[i])-1 || i == array_length(network)-1) {
					network[i][j] = activation(dot(weights[|i-1][j],network[i-1]));
				}
			}
		}
		return network[array_length(network)-1];
	}
	
	function clean_up(){
		ds_list_destroy(weights);
	}
}



