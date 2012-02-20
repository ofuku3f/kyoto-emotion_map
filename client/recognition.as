var line_data:Array = new Array();

var icon_code:Array = [
					   "笑顔",
					   "怒り",
					   "がっかり",
					   "泣き",
					   "ハート"];

function recognition() 
{
	
	var search_max = global_dict.length;
	var candidates:Array = [];
	var hiscore = 0;
	var output = "";
	
	databox_reset ();

	if ( dict.length == 1 )	search_reset ();

	for ( var n = 0;n<search_list.length;n++)			//文字の数
	{
		var i = 	search_list[n];

		if ( dict.length > global_dict[i][1].length )			//文字の画数が少ない
		{
			search_list.splice(n,1);	n--;
			continue;
		}
		if ( dict.length != global_dict[i][1].length )			//文字の画数が多い
		{
			continue;
		}

		var score = 0;
		var skip_flag = false;
		
		convert_data (i);			// データを読み込み
		
		var angle_dist = angle_check();		// 角度が正しいか？
		if (angle_dist < 0) continue;		//スコアが低すぎる
		
		var curve_dist = curve_check (i);			//曲線チェック
		
		var shape_dist = shape_check (i);			//形状チェック
		
		var cross_dist = past_cross_check(i);		//交差チェック
		if (cross_dist < 0.5) continue;					//スコアが低すぎる
		
		score = ( curve_dist +  cross_dist + angle_dist/* + shape_dist */) / 3;
		
		score = Math.round( score * 1000000 ) / 1000000;
		candidates.push({Candidates:global_dict[i][0] , Accuracy: score});		//候補に追加
		if (score > hiscore)
		{
			hiscore = score;
			output = global_dict[i][0];
		}
	}
	
	candidates.sortOn("Accuracy", Array.DESCENDING | Array.NUMERIC);
	var add_item_max = candidates.length;
	if (add_item_max > 50) add_item_max = 50;
	for ( i = 0; i < candidates.length; i++)
	{
		databox_Candidate.addItem(candidates[i]);
	}

	trace(output);


	for (i = 0;i < icon_code.length;i++)
		if (output == icon_code[i])
		{
			if (candidate_icon.currentFrame != i+2){
				candidate_icon.scaleX = candidate_icon.scaleY = 3;
				candidate_icon.alpha = 1;
			}
			candidate_icon.gotoAndStop(i + 2);
		}
}

// 角度が正しいか？
function angle_check ()
{
	var angle_dist = 0;
	for ( var k = 0;k<dict.length;k++)
	{		
		var 	cos_0 =  get_cos_theta(dict[k][0] , to_angle( line_data[k][0] ) ) ;
		var 	cos_1 =  get_cos_theta(dict[k][1] , to_angle( line_data[k][1] ) );
		
		angle_dist += cos_0 + cos_1;
	}
	angle_dist /= dict.length ;
	angle_dist /= 2;

	return angle_dist;
}

function  curve_check( i:int ) 
{
	var curve_dist = 0;
	for ( var k = 0;k<dict.length;k++)
	{
		curve_dist += Math.abs (dict[k][4] - line_data[k][4] );
	}
	curve_dist /= dict.length;
	//curve_dist = ;
	return 1 / (curve_dist+1);
}

function  shape_check(j:int) 
{
	var shape_check = 0;
	for ( var k = 0;k<dict.length;k++)
	{		
		shape_check += Math.abs(line_data[k][6] - dict[k][6])
	}
	shape_check /= dict.length;

	return 1 / (shape_check+1);
}

function  past_cross_check(j:int) 
{
	var past_cross_check = 0;
	for ( var k = 0;k<dict.length;k++)
	{		
		past_cross_check += Math.abs(line_data[k][2] - dict[k][2])
	}
	for ( k = 1;k<dict.length;k++)
	{		
		past_cross_check += Math.abs(line_data[k][3] - dict[k][3])
	}
	return 1 / (1+past_cross_check);
}

// データを読み込み
function  convert_data(j:int) {
	for ( var k = 0;k<dict.length;k++)
	{
				var color:uint = global_dict[j][1][k];
				line_data[k] = [
										(color >> 	21)	& 7,
										(color >> 	18)	& 7,
										(color >>	15)	& 7,
										(color >> 	12)	& 7,
										(color >> 	9)	& 15,
										(color >> 	5)	& 15,
										(color >> 	0)	& 31
										];
		}
}
