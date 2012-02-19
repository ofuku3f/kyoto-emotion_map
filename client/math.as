function cross_hit (a:Point, b:Point, c:Point, d:Point) 
{
	var ab:Point = b.subtract(a);
	var ac:Point = c.subtract(a);
	var ad:Point = d.subtract(a);
	
	var cd:Point = d.subtract(c);
	var ca:Point = a.subtract(c);
	var cb:Point = b.subtract(c);

	return ( ( cross ( ab , ac ) * cross ( ab , ad ) < 0 ) &&
			     ( cross ( cd , ca ) * cross ( cd , cb ) < 0 ) );
}
	
	function cross_check_2 ( past:int )
	{
		var cross_pattern = 0 , k, l, j = 0;
		
		if ((past==1)&&(stroke.length/2 == 1)) return 0;

			for ( k=0 ; k+1 < curve.length ;k++)
			{
				if (past == 0)
				{				
					for ( l=k+2 ; l+1 < curve.length ;l++)
					{
								if (cross_hit (
											curve[k],
											curve[k+1],
											curve[l],
											curve[l+1]
											))
								{
									cross_pattern ++;
								}
					}
				}
				else
				{
					for ( l=0 ; l+1 < curve_bk.length ;l++)
					{
								if (cross_hit (
											curve[k],
											curve[k+1],
											curve_bk[l],
											curve_bk[l+1]
											))
								{
									cross_pattern ++;
								}
					}
				}
			}
			
		return cross_pattern;
	}
	
	function dot(a:Point,b:Point)
{
	return a.x * b.x + a.y * b.y;
}
function cross(a:Point,b:Point)
{
	return a.x * b.y - a.y * b.x;
}
function get_cos_theta2 (a:Point,b:Point) {
	return Math.floor( 15 *  dot(a,b) / (a.length * b.length  )) + 16;
}
function get_sin_theta2 (a:Point,b:Point) {
	return Math.floor( 15 *  cross(a,b) / (a.length * b.length )) + 16;
}
function get_cos_theta (a:Point,b:Point) {	
	return dot(a,b) / (a.length * b.length);
}
function get_sin_theta (a:Point,b:Point) {
	return cross(a,b) / (a.length * b.length);
}
function p_moveTo (g:Graphics,p:Point) {
	g.moveTo(p.x,p.y)
}
function p_curveTo (g:Graphics,p:Point,q:Point) {
	g.curveTo(p.x,p.y,q.x,q.y)
}
function p_lineTo (g:Graphics,p:Point) {
	g.lineTo(p.x,p.y)
}
function scale (a:Point, scale:Number) {
	return new Point( a.x * scale , a.y * scale );
}
function to_angle ( angle:int ) {
	var vect:Point = new Point();
	
	switch (angle) {
		case 0:		vect.x = 1;	 vect.y = -1;	break;
		case 1:		vect.x = 0;	 vect.y = -1;	break;
		case 2:		vect.x = -1;	 vect.y = -1;	break;
		case 3:		vect.x = -1;	 vect.y = 0;		break;
		case 4:		vect.x = -1;	 vect.y = 1;		break;
		case 5:		vect.x = 0;	 vect.y = 1;		break;
		case 6:		vect.x = 1;	 vect.y = 1;		break;
		case 7:		vect.x = 1;	 vect.y = 0;		break;
	}
	return vect;
}
//http://www.antigrain.com/research/bezier_interpolation/
