	
	//graphic
	var shape : Shape = new Shape();
	var g : Graphics = shape.graphics;
	input_area.addChild(shape);
	
	var shape2 : Shape = new Shape();
	var g2 : Graphics = shape2.graphics;
	input_area.addChild(shape2);

function smooth_line ()
{
	/*
	if (line[0] == undefined)			//bag回避
	{
		return;
	}*/
	
	var  vect_bd:Point,	vect_fb:Point,	vect_fd:Point;

	var point_e = line.length - 1;
	var point_h = Math.floor(point_e/2);
	var point_q = Math.floor(point_e/4);
	var point_q2 = Math.floor(point_e*3/4);

	if ( point_e != 0 )
	{
		var a = line[0];
		var c = line[point_h];
		var e = line[point_e];
		var b = line[point_q];
		var d = line[point_q2];
	
		var l_1 = Point.distance( a, c);
		var l_2 = Point.distance( e, c);
		
		var rate_1 = -l_1 /( l_1 + l_2 );
		var rate_2 = l_2 /( l_1 + l_2 );
		
		vect_bd = d.subtract(b);
	
		var ctrl_1:Point =  c.add( scale ( vect_bd , rate_1 ) );
		var ctrl_2:Point =  c.add( scale ( vect_bd , rate_2 ) );

		g.clear();
		
		g2.lineStyle (5.0, 0x000000,1.0);
	
		g2.moveTo( a.x,a.y);
		g2.curveTo( ctrl_1.x,ctrl_1.y,c.x,c.y);
		g2.moveTo( c.x,c.y);
		g2.curveTo( ctrl_2.x,ctrl_2.y,e.x,e.y);
	}
	else
	{
		//g.clear();
	}
}

function marker (type:Number)
{
	/*
	var mark_t = line.length - 1; 
	switch(type)
	{
		case 0:
			g2.lineStyle (2.0, 0xFF0000,0.5);
			g2.drawCircle(line[mark_t].x, line[mark_t].y,3);
			num_curve_point ++;
			break;
		case 1:
			g2.lineStyle (2.0, 0x0000FF,0.5);
			g2.drawRect( line[mark_t].x, line[mark_t].y,5,3);
			num_edge_point ++;
			break;
	}
	*/
}

