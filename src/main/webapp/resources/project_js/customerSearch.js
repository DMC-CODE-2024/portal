	$('#btnLink').css({"display":"none"});	
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var roleType = $("body").attr("data-roleType"); 
	var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	$.i18n().locale = lang;
	
	$.i18n().load( {
		'en': './resources/i18n/en.json',
		'km': './resources/i18n/km.json'
	}).done( function() { 
	});	
	
	function hide() {
		
		if($('#deviceType').val()==0){
			
			var luhnIMEI1=luhnCheck('imei','deviceType');
			
			
			//alert("luhnIMEI1 "+luhnIMEI1+" luhnIMEI2 = "+luhnIMEI2+" luhnIMEI3 "+luhnIMEI3+" luhnIMEI4 = "+luhnIMEI4);
			if(luhnIMEI1==false)
			{
				//alert("failed");
				return false
			}
	}
		//var deviceDropDown =  document.getElementById("deviceType");
		var deviceIdType =  $("#deviceType option:selected").text();
		var deviceIdvalue = $("#deviceType").val();
		var msisdn = $('#msisdn').val();
		var  res  =  $('#imei').val();
		  var imei = res.substring(0, 14);
		var deviceIdType =  deviceIdType;
		//sessionStorage.setItem("roleType",roleType);
		//sessionStorage.setItem("tagId", tagId);
		
		if(!msisdn==null || !msisdn==''){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: './checkMsisdnExist?imei='+imei+'&msisdn='+msisdn,
				type: 'POST',
				processData: false,
				'contentType': false,
				success: function (data, textStatus, jqXHR) {
					
					if(data=="No"){
						
						$("#InvalidMsisdn").openModal({
					        dismissible:false
					    });
					}
					else{
						window.location.replace("./search?via=other&msisdn="+msisdn+"&imei="+imei+"&deviceIdType="+deviceIdType+"&deviceIdvalue="+deviceIdvalue);	
					}
					
				}
			});
		}
		else{
			window.location.replace("./search?via=other&msisdn="+msisdn+"&imei="+imei+"&deviceIdType="+deviceIdType+"&deviceIdvalue="+deviceIdvalue);	
		}
		
		return false;
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interpretation)
			.appendTo('#deviceType');
		}
	});
	
	
	function clearFields(){
		$('#msisdn').val('');
		$('#imei').val('');
		$("#deviceType").val('');
	}
	
	

	$('#deviceType').on('change', function() {
		var value=parseInt($(this).val());
		var DeviceIdtype=$('#deviceType').val();
		if(DeviceIdtype=="" || DeviceIdtype==null || DeviceIdtype=="null"){
			$('#errorMsgOnModal').text('');
		}
		else{
		switch (value) {
		case 0:
			$('#imei').val('');
			$("#imei").attr("pattern","[0-9]{15,16}");
			$("#imei").attr("maxlength","16");
			$("#imei").removeAttr("onkeyup");
			$("#imei").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
			$("#imei").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
			$('#errorMsgOnModal').text($.i18n('IMEIMsg'));
			break;
		case 1:
			$("#imei").attr("pattern","[A-F0-9]{15,16}");
			$("#imei").attr("maxlength","16");
			$("#imei").removeAttr("onkeyup");
			$("#imei").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
			$("#imei").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
			$('#errorMsgOnModal').text($.i18n('MEIDMsg'));
			break;
		case 2:
			$('#imei').val('');
			$("#imei").attr("pattern","[0-9]{8,11}");
			$("#imei").attr("onkeyup","isLengthValid(this.value)");
			$("#imei").attr("maxlength","11");	
			$("#imei").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
			$("#imei").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
			$('#errorMsgOnModal').text($.i18n('ESNMsg'));
			break;
		}
		}

	}); 

	function isLengthValid(val){
		var deviceIDLength=val.length;
		if(!isNaN(val)){
			$("#imei").attr("pattern","[0-9]{11,11}");
			$("#imei").attr("maxlength","11");
			$("#imei").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
			$("#imei").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		}
		else if(typeof val == 'string' || val instanceof String){
			$("#imei").attr("maxlength","8");
			$("#imei").attr("pattern","[A-F0-9]{8,8}");
			$("#imei").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");
			$("#imei").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");

		}
	}