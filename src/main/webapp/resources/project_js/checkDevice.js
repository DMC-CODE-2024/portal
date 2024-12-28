$('#langlist').on('change', function() {
	lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	var url_string = window.location.href;
	var url = new URL(url_string);
	var type = url.searchParams.get("type");
	window.location.assign("checkDeviceslogin?lang="+lang);			
});   
$(document).ready(function () {
	$('#langlist').val(data_lang_param);
	var lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	$.i18n().locale = lang;		
	$.i18n().load( {
		'en': './resources/i18n/en.json',
		'km': './resources/i18n/km.json'
	} ).done( function() { 

	});

});

$('div#initialloader').fadeIn('fast');
function DeviceDetails(){
if($('#deviceIdType').val()==0){
		
		var luhnIMEI1=luhnCheck('DeviceID','deviceIdType');
		
		
		//alert("luhnIMEI1 "+luhnIMEI1+" luhnIMEI2 = "+luhnIMEI2+" luhnIMEI3 "+luhnIMEI3+" luhnIMEI4 = "+luhnIMEI4);
		if(luhnIMEI1==false)
		{
			//alert("failed");
			return false
		}
}
	
	$('div#initialloader').fadeIn('fast');
	
	var RequestData={
			"deviceIdType":parseInt($("#deviceIdType").val()),
			"deviceId":$("#DeviceID").val(),
			"userTypeId": 17,
			"usertypeId":17,
			"userName":"NA",
			"roleType":"End User",
			"userType":"End User",
			"identifierType":"IMEI",
			"imei": $("#DeviceID").val(),
			"userId":1147,
			"msisdn":""
			
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({

		url : "./checkDevice",
		data :	JSON.stringify(RequestData),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(response) {
			//////console.log(response);

			if (response.errorCode == 200) {
				$("#singleInput").css("display", "none");
				$("#validDetails").css("display", "block");
				setvalidData(response)
			}else{

				$("#singleInput").css("display", "none");
				$("#invalidDetails").css("display", "block");
				setInvalidData(response)
			}
			$('div#initialloader').delay(300).fadeOut('slow');
		},
		error : function() {
			$('div#initialloader').delay(300).fadeOut('slow');
			$('#errorModal').openModal({dismissible:false});
		}
	});
	return false;
}


function setvalidData(response){

	$("#validTac").val(response.data.deviceId);
	$("#validbrandName").val(response.data.bandName);
	$("#validModelName").val(response.data.modelName);

}


function setInvalidData(response){
	/*$.i18n('validationIMEI')*/
	$('#checkDevicesMsg').text($.i18n(response.tag));	
	//$("#InvalidImeiNumber").text(response.data.imei)
	$("#invalidTac").val(response.data.deviceId);
	$("#invalidRemark").val($.i18n(response.data.errorMessage));


}
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});
$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#deviceIdType');
	}
	$('div#initialloader').delay(300).fadeOut('slow');
});


$('#deviceIdType').on('change', function() {
	var value=parseInt($(this).val());

	switch (value) {
	case 0:
		$('#DeviceID').val('');
	//	$("#DeviceID").attr("pattern","[0-9]{15,16}");
		//$("#DeviceID").attr("maxlength","16");
		$("#DeviceID").removeAttr("onkeyup");
		//$("#DeviceID").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		//$("#DeviceID").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		$('div p#errorMsgOnModal').text($.i18n('IMEIMsg'));
		break;
	case 1:
		$("#DeviceID").attr("pattern","[A-F0-9]{15,16}");
		$("#DeviceID").attr("maxlength","16");
		$("#DeviceID").removeAttr("onkeyup");
		$("#DeviceID").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$("#DeviceID").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$('div p#errorMsgOnModal').text($.i18n('MEIDMsg'));
		break;
	case 2:
		$('#DeviceID').val('');
		$("#DeviceID").attr("pattern","[0-9]{8,11}");
		$("#DeviceID").attr("onkeyup","isLengthValid(this.value)");
		$("#DeviceID").attr("maxlength","11");	
		$("#DeviceID").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#DeviceID").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$('div p#errorMsgOnModal').text($.i18n('ESNMsg'));
		break;
	}

}); 

function isLengthValid(val){
	var deviceIDLength=val.length;
	if(!isNaN(val)){
		$("#DeviceID").attr("pattern","[0-9]{11,11}");
		$("#DeviceID").attr("maxlength","11");
		$("#DeviceID").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#DeviceID").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
	}
	else if(typeof val == 'string' || val instanceof String){
		$("#DeviceID").attr("maxlength","8");
		$("#DeviceID").attr("pattern","[A-F0-9]{8,8}");
		$("#DeviceID").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");
		$("#DeviceID").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");

	}
}



