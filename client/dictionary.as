
function input_dictionary ()
{
		
	
		var data_shape:int, data_curve:int, data_edge:int, data_head:int , data_end:int;
	
		data_shape		=  0;
		data_curve      =  num_curve_point; if (data_curve>8)	data_curve = 8;
		data_edge       =  num_edge_point; if (data_edge>8)	data_edge = 8;

		var self_cross  = cross_check_2 ( 0 );
		var past_cross = cross_check_2 ( 1 );
	
		var dict_now:Array =  [ line_vect_head , 
							   line_vect , 
							   self_cross , 
							   past_cross , 
							   data_curve , data_edge, data_shape];
		dict.push(dict_now);
	
}