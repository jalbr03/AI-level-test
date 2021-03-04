var target_x = 0;
for(var i=0;i<instance_number(obj_ai);i++){
	var obj = instance_find(obj_ai,i);
	if(obj.x > target_x){
		target_x = obj.x;
	}
}
x = target_x;