	
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	databox_Candidate.addEventListener(Event.CHANGE,FocusInFunc);
	
	function FocusInFunc (e:Event) 
	{
		input_words.text = databox_Candidate.selectedItem.Candidates;
		load_dict();
	}
	
	function databox_reset () {
		databox_Candidate.removeAllColumns () ;
		databox_Candidate.removeAll ();

		databox_Candidate.addColumn(new DataGridColumn("Candidates"));
		databox_Candidate.addColumn(new DataGridColumn("Accuracy"));
	}
