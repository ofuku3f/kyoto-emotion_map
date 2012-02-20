
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;
import flash.events.Event;

	if (Geolocation.isSupported)
	{
		var geo:Geolocation = new Geolocation();
		geo.addEventListener(GeolocationEvent.UPDATE, onGeoUpdate);
	}
	 
	function onGeoUpdate(evt:GeolocationEvent):void
	{
		location_now.x = evt.latitude;
		location_now.y = evt.longitude;
	}

	input_area.addEventListener(MouseEvent.MOUSE_MOVE,mouse_move);
	input_area.addEventListener(MouseEvent.MOUSE_DOWN,mouse_down);
	stage.addEventListener(MouseEvent.MOUSE_UP,mouse_up);
	
	submit_button.addEventListener(MouseEvent.MOUSE_DOWN,submit);

function mouse_move (e) 
{
	if (click_flag == true)
	{
		var mouse_pos = new Point( input_area.mouseX , input_area.mouseY);
		line_vect= mouse_pos .subtract( line[ line.length - 1 ]);
		
		if ( line_vect.length >=10)
		{
			set_line (g);
			draw_line (g);
			draw_mouse_pont (g);
			
			if (line.length - 1 == 1)
			{
				line_vect_curve = 
				line_vect_bk = line_vect;
				if (curve.length == 1)
					line_vect_head = line_vect;
			}

			if ((get_cos_theta( line_vect , line_vect_bk ) <=0.2) && (line.length >=3))		//edge
			{
				marker(1);	// square
				curve_point() ;
			}
			else if (get_cos_theta( line_vect , line_vect_curve )<=Math.cos(45*2*Math.PI/360))			//else if (get_cos_theta( line_vect , line_vect_curve )<=0 )
			{
				marker(0);
				curve_point();
			}
			line_vect_bk = line_vect;
		}
		move_flag = true;
	}
}
function mouse_up (e) 
{
	if (click_flag == true)
	{
		if (move_flag == true)
		{
			smooth_line();
			record_curve();
			record_stroke();
			
			input_dictionary ();
			recognition();
			curve_bk = curve;
		}
		click_flag = false;	
		line = [];
		curve = [];
		
		
		clear_flag = false;
	}
}
function mouse_down (e) 
{
	if (click_flag == false)
	{
		line = [];
		set_line (g);
		p_moveTo  ( g,line[0]);
		record_stroke();
		
		line_head = line[0];
		num_curve_point = 0;
		num_edge_point =0;
		click_flag = true;
		
		move_flag = false;
	}
}
function set_line (g :Graphics) 
{
		var mouse_pos = new Point( input_area.mouseX , input_area.mouseY);
		line.push(mouse_pos);
}
function draw_line (g :Graphics ) 
{
	var mouse_pos = new Point( input_area.mouseX , input_area.mouseY);
	g.lineStyle (5.0, 0x000000,1.0);
	p_lineTo  (  g,  mouse_pos );
}
function draw_mouse_pont  (g :Graphics )  {
	var mouse_pos = new Point( input_area.mouseX , input_area.mouseY);
	input_area.mouse_point.x = mouse_pos.x;
	input_area.mouse_point.y = mouse_pos.y;
}
function record_stroke() {
		stroke.push(line[ line.length - 1 ]);
		record_curve();
	}
function record_curve() {
	curve.push(line[ line.length - 1 ]);
}
function curve_point() 
{
	smooth_line();
	line.splice(0,line.length - 1);		//最後の点を最初の点にもってくる。
	record_curve();							//最後の点を記録
	p_moveTo( g,line[0]);
}

function submit(e:MouseEvent) {
	
	if (candidate_icon.currentFrame==1)return;
	
	submit_button.scaleX = 
	submit_button.scaleY = 0
	
	this.alpha = 0;
	
	var url:URLRequest = new URLRequest( "http://ec2-175-41-232-72.ap-northeast-1.compute.amazonaws.com:3000/set_user_status?x="+location_now.x+"&y="+location_now.y+"&faceId="+(candidate_icon.currentFrame - 2)+"&userId=1");
    navigateToURL( url );
	
	NativeApplication.nativeApplication.exit(0);
}

function completeHandler(evt:Event):void{
 
	//var re_variables:URLVariables = new URLVariables( evt.target.data);
}