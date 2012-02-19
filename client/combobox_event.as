	combobox.addEventListener(Event.CHANGE,FocusInFunc2);
	
	function FocusInFunc2 (e:Event) 
	{
		switch(combobox.value)
		{
			case "0":
				load_dict();
				break;
			case "1":
//				load_dict2();
//				grobal_dict = grobal_dict2;
				break;
		}
	}