	
	function  export_func()
	{
		
		var output = "[";
		output += "\"" + input_words.text + "\",[";
		
		for (var i=0; i<dict.length; i++)
		{
			output += "[";
			
			/*
			
			for (var j=0;j<dict[i].length; j++) 
			{
				if (j==0||j==1)
				{
					output += get_angle(dict[i][j].x,dict[i][j].y);
				}
				else
				{
					output += dict[i][j];
				}
				
				if ( j != dict[i].length - 1)
				{
					output += ",";
				}
			}
			
			*/
			
				var color  : uint;
					color  = ( 
							  	   get_angle(dict[i][0].x,dict[i][0].y)	<< 21)		//8
								|( get_angle(dict[i][1].x,dict[i][1].y)		<< 18)		//8
								|( dict[i][2]	<< 15)		//8
								|( dict[i][3]	<< 12)		//8
								|( dict[i][4]	<< 9)		//16
								|( dict[i][5]	<< 5)		//16
								|( dict[i][6]	<< 0);		//32
					
				output += color;
				
				output += "]";

				if ( i!=dict.length - 1)	output += ",";
					
		}
		output += "]";
		
		output += "],";

		System.setClipboard(output);

	}
	
	
	function get_angle (a_x:Number,a_y:Number) {
	
		var	out = Math.round(
						   Math.atan2(a_y ,  -a_x)*8/(2*Math.PI)
						   );
				
				if (out == -4) out =4;
						out += 3;
		return out;
	
	}
	
	

