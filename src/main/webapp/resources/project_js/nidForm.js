/*
		window.parent.$('#langlist').on('change', function() {
			var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
			window.location.assign("./uploadPaidStatus?lang="+lang);
		}); */
		
		$('#langlist').on('change', function() {
	lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	var url_string = window.location.href;
	var url = new URL(url_string);
	
	window.location.assign("selfRegisterDevice?lang="+lang);			
	}); 


	$('#langlist').val(data_lang_param);
	$('#btnLink').css({"display":"none"});	
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var roleType = $("body").attr("data-roleType"); 
	var userStatus = $("body").attr("data-userStatus");
	var featureId =12;
   
   
  

	function hide() {
		
			var In = $('#Search').val();
			sessionStorage.setItem("roleType",roleType);
			sessionStorage.setItem("nationalId", In);
			/*if(roleType=='')
	    	{*/
	    /*	//alert("1");
	
			
			if(In.length == 0){
				////////console.log("please field input");
			}else{
				
				$.ajax({
					url: './selfRegisterDevicePage?NID='+In,
					type: 'POST',
					processData: false,
					contentType: false,
					success: function (data, textStatus, jqXHR) {
						//////console.log("111111111");
					},
					error: function (jqXHR, textStatus, errorThrown) {
						//////console.log("error in ajax")

					}
				});
				window.location.replace("./selfRegisterDevicePage?NID="+In);
			}
	    	
	    	}
		 else if(roleType=='Custom'){
	    	
	    	//alert("2");
			if(In.length == 0){
				//////console.log("please field input");
			}else{
			
			
			//	document.getElementById("registerDeviceForm").submit();
				$.ajax({
					url : './uploadPaidStatus?via=other&NID='+In,
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					type : 'GET',
					success : function(data) {
						
	                alert("hii");
					},
					error : function() {
						//////console.log("Failed");
						alert("helo");
					}
				}); 
				
				
				$.getJSON('./uploadPaidStatus?via=other&NID='+In, function(data) {

				});
				return false;
			//window.location.replace("./uploadPaidStatus?via=other&NID="+In);
			}
	    	
		 }
		 else if(roleType=='Immigration')
			 {
			// alert("3");
			 if(In.length == 0){
					//////console.log("please field input");
				}else{
					
				window.location.replace("./uploadPaidStatus?via=other&NID="+In);
				}
			 }
*/
	
	}
	
	function viewAll(){
		In=null;
		window.location.replace("./uploadPaidStatus?via=other&NID="+In);
	}