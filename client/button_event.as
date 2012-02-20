
	clear_button.addEventListener(MouseEvent.MOUSE_DOWN,clear_func);
	teach_button.addEventListener(MouseEvent.MOUSE_DOWN,teach_func);
	
	function teach_func(e) {
		export_func();
	}
	
	function clear_func(e) {
		dict = [];
		search_reset ();
		num_curve_point = 0;
		num_edge_point =0;
		output = "";
		message_label.text ="";
		databox_Candidate.removeAll();
		g2.clear();
		g.clear();
		
		clear_flag = true;
		
		candidate_icon.gotoAndStop(1);
		candidate_icon.alpha = 0.4;
	}
	
	function search_reset () {
		for (var i=0;i<global_dict.length;i++)	search_list[i] = i;
	}
