$('#deviceIdType').on('change', function() {
	var value=$(this).val();
	switch (value) {
	  case 0:
		  $("#DeviceID").attr("pattern","{[0-9]{0,9}}");
		  $("#DeviceID").attr("maxlength","10");

	    break;
	  case 1:
		  $("#DeviceID").attr("pattern","{[A-Za-z0-9]{0,16}}");
		  $("#DeviceID").attr("maxlength","16");

	    break;
	  case 2:
		  $("#DeviceID").attr("pattern","{[A-Za-z0-9]{8,11}}");
		  $("#DeviceID").attr("maxlength","11");

	    break;
	}
	
}); 
