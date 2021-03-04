// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//function gather_ai(){
//	var all_ai = ds_map_create();
//	for(var i=0;i<instance_number(obj_ai);i++){
//		var ai = instance_find(obj_ai,i);
//		ds_map_add(all_ai,score_ai(ai),ai);
//	}
//	var array_order = ds_map_keys_to_array(all_ai);
//	array_sort(array_order,false);
	
//	return array_order;
//}
function clone_network(network_to_clone) {
    var cloned_network = ds_list_create();
       
    for (var i = 0; i < ds_list_size(network_to_clone); i++) {
		ds_list_add(cloned_network,clone_layer(network_to_clone[|i]));
    }
       
    return cloned_network;
}

function clone_layer(layer_to_clone) {
    var cloned_layer = [];
       
    for (var i = 0; i < array_length(layer_to_clone); i++) {
		array_push(cloned_layer,clone_weights(layer_to_clone[i]))
    }
       
    return cloned_layer;
}

function clone_weights(weights_to_clone) {
    var cloned_weights = [];
    
    array_copy(cloned_weights, 0, weights_to_clone, 0, array_length(weights_to_clone));
       
    return cloned_weights;
}

function ai_trainer() constructor{
	data = ds_map_create();
	
	function end_current_group(){
		for(var i=0; i<instance_number(obj_ai); i++){
			var ai = instance_find(obj_ai, i);
			var key = score_ai(ai);
			if(is_undefined(ds_map_find_value(data,key))){
				ds_map_add(data, key, clone_network(ai.neural_network.weights));
			}
		}
		instance_destroy(obj_ai);
	}
	
	function create_new_geration(number_of_best,number_of_bred,number_of_swaps,mutation_chance,number_of_weights) {
		var new_geration = [];
		var new_geration_keys = [];
		var array_order = ds_map_keys_to_array(data);
		array_sort(array_order,false);
		obj_ai_manager.best_score = array_order[0];
		
		for(var i=0;i<number_of_best;i++){
			array_push(new_geration,clone_network(ds_map_find_value(data,array_order[i])));
			array_push(new_geration_keys,array_order[i]);
		}
		for(var i=0;i<number_of_bred;i++){
			var parent_a = ds_map_find_value(data,new_geration_keys[irandom(array_length(new_geration_keys)-1)]);
			var parent_b = ds_map_find_value(data,new_geration_keys[irandom(array_length(new_geration_keys)-1)]);
			
			for(var j=0;j<number_of_swaps*number_of_weights;j++){
				var random_pos1 = irandom(ds_list_size(parent_a)-1);
				var random_pos2 = irandom(array_length(parent_a[|random_pos1])-1);
				var random_pos3 = irandom(array_length(parent_a[|random_pos1][random_pos2])-1);
				
				if(irandom(mutation_chance) == 0) {
					parent_a[|random_pos1][random_pos2][random_pos3] = random_range(-1, 1)
				} else {
					parent_a[|random_pos1][random_pos2][random_pos3] = parent_b[|random_pos1][random_pos2][random_pos3];
				}
			}
			array_push(new_geration,clone_network(parent_a));
		}
		
		var data_size = ds_map_size(data);
		for(var i=0; i < data_size; i++) {
			var key = ds_map_find_first(data);
			ds_list_destroy(ds_map_find_value(data, key));
			ds_map_delete(data, key);
		}
		return new_geration;
	}
	
	function clean_up() {
		var data_size = ds_map_size(data);
		for(var i=0; i < data_size; i++) {
			var key = ds_map_find_first(data);
			ds_list_destroy(ds_map_find_value(data, key));
			ds_map_delete(data, key);
		}
		ds_map_destroy(data);
	}
}

function score_ai(ai_obj) {
	return ai_obj.x//ai_obj.time_took;
}