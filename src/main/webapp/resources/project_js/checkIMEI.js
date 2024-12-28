$('#langlist').on('change', function() {
	lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	//var lang = window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	
	var url_string = window.location.href;
	var url = new URL(url_string);
	var type = url.searchParams.get("type");
	window.location.assign("./checkIMEIPortal?lang="+lang+"&utm_source="+$("#utm_source").val());			
});   

var leftPannelSideValue=$('#leftPannelSideValue').val();
/*  var leftPannelSideValue=$('#leftPannelSideValue').val();
  if(leftPannelSideValue=="yes"){
	   $("#leftPannelSide").css("display", "none");
	    $(".line-right").attr("style", "border-left :0px #bdbdbd solid !important")
	  
	       // border-left: 1px #bdbdbd solid;
	
}*/

	//alert("data_lang_param" +data_lang_param);
	$('#langlist').val(data_lang_param);
	
	var lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	$.i18n().locale = lang;		
	$.i18n().load( {
		'en': '../resources/i18n/en.json',
		'km': '../resources/i18n/km.json'
	} ).done( function() { 

	});
  var IMEIInvalidStatus=$('#IMEIStatus').val();
  var InvalidIMEIAutoFill=$('#InvalidIMEIAutoFill').val();
$(document).ready(function(){
  console.log(IMEIInvalidStatus);
  console.log(InvalidIMEIAutoFill);
  if(IMEIInvalidStatus=="invalidIMEI")
  {
	$("#DeviceID").val(InvalidIMEIAutoFill);
	$('#submitbutton').attr("disabled",false);
	$('div#count').text("15/15");
  }
});

var onloadCallback = function() {
    
    $('.recaptchaForm').on('submit',function(event){
    	var recaptcha=$("#g-recaptcha-response").val();
 	   //alert("&&&"+recaptcha); 
 	   if(recaptcha===""){
 		   $("#errorMsgOnModal").css("display", "block");
 		   return false;
 		}
 	   else{
 		  //alert("captcha is checked");
 		  
		  $("#errorMsgOnModal").css("display", "none");
		   $("#loaderDiv").css("display", "block");
		var utm_source=$("#utm_source").val();
 		   const utmSource = utm_source.split("_");
		   
		    var operator=utmSource[0];
		    var channel=utmSource[1];
			
		    if(channel=='' || channel=='null' || channel==undefined){
		
			operator='';
			channel='web';
			}
		
 		  var language= $('#langlist').val() == 'km' ? 'kh' : 'en';
		  var RequestData={
			//"captcha": $("#captcha").val(),
			"imei": $("#DeviceID").val(),
			"channel": channel,
			"language":language,
			"medium":channel,
			"msisdn":"",
			"operator":operator,
			
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajaxSetup({
	headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "../checkDevice",
		data :	JSON.stringify(RequestData),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(response) {
			console.log(response);
			 if(response.tag=="Wrong_captcha"){
				//$('div p#errorMsgOnModal').text($.i18n('IMEIMsg'));
				//$("#errorMsgOnModal").text($.i18n('Wrong_captcha'));
				$("#errorMsgOnModal").css("display", "block");
			}else if(response.result.validImei==true) {
				//alert("1" +response.result.validImei);
				$(".langdiv").css("display", "none");
				$("#imeiBox").css("display", "none");
				$("#validbox").css("display", "block");
				setvalidData(response);
			}else if(response.result.validImei==false){
				//alert("2" + response.result.validImei);
				$(".langdiv").css("display", "none");
				$("#imeiBox").css("display", "none");
				$("#invalidbox").css("display", "block");
				setInvalidData(response)
			}else {
				//alert("3")
				$(".langdiv").css("display", "none");
				$("#imeiBox").css("display", "none");
				$("#errormsgbox").css("display", "block");
			}
			 $("#loaderDiv").css("display", "none");
			//$('div#initialloader').delay(300).fadeOut('slow');
		},
		error : function() {
			//$('div#initialloader').delay(300).fadeOut('slow');
			$("#imeiBox").css("display", "none");
			$("#errormsgbox").css("display", "block");
		}
	});
	return false;
 	   }
 	});
};



	
	
	
	/*function setvalidData(response){
		$("#validimei").text($("#DeviceID").val());
		$("#brandname").text(response.result.deviceDetails["Brand Name"]);
		$("#modelname").text(response.result.deviceDetails["Model Name"]);
		$("#manufacturer").text(response.result.deviceDetails["Manufacturer"]);
		$("#devicetype").text(response.result.deviceDetails["Device Type"]);
		$("#marketingname").text(response.result.deviceDetails["Marketing Name"]);
	}*/
	
	function setvalidData(response){
		$("#validimei").text($("#DeviceID").val());
		var data = response.result.deviceDetails;
		var result = [];
   		var keys = Object.keys(data);
    		 keys.forEach(function(key){
       			 result.push(data[key]);
    	});
 		
 		//console.log("result---"+JSON.stringify(result)+" and length ------" +JSON.stringify(result.length));
		
		 if(response.result.symbol_color=='##219653'){
			//green 
			$("#greenImg").css("display", "block");
		}
		else if(response.result.symbol_color=='#FFCC02'){
			//yellow 
			$("#yellowImg").css("display", "block");
		}
		
		$("#brandname").text(result[0]);
		$("#modelname").text(result[1]);
		$("#manufacturer").text(result[2]);
		$("#marketingname").text(result[3]);
		$("#devicetype").text(result[4]);
		//$("#validIMEIHeading").text(response.result.complianceStatus).innerHTML;
		 document.getElementById("validIMEIHeading").innerHTML = response.result.complianceStatus;
	
		//$("#validIMEIMessage").text(response.result.message);
	    document.getElementById("validIMEIMessage").innerHTML = response.result.message;
	    
	   IMEIInvalidStatus='default';
		console.log("&&"+IMEIInvalidStatus);
		
	};
	
	
	function setInvalidData(response){
		var data = response.result;
		var result = [];
   		var keys = Object.keys(data);
    		 keys.forEach(function(key){
       			 result.push(data[key]);
    	});
		if(response.result.symbol_color=='#eb5757'){
			//yellow 
			$("#redIMG").css("display", "block");
		}
		$("#invalidimei").text($("#DeviceID").val());
		//$("#invalidMsg").text(response.result.message);
		 document.getElementById("invalidMsg").innerHTML = response.result.message;
		//$("#invalidIMEIHeading").text(result[2]);
		 document.getElementById("invalidIMEIHeading").innerHTML = result[2];
		IMEIInvalidStatus='invalidIMEI';
		console.log("&&"+IMEIInvalidStatus);
		
	}
	
	$('input#DeviceID').on("change keyup input",function() { 
    // handle events here
    var input = $('#DeviceID');
    count = $('div#count').text((input.val().length)+"/15");
    if($(this).val().length == 0){
    		$('#submitbutton').attr("disabled",true);
		}else{
			$('#submitbutton').attr("disabled",false);
		}
    });
	


function RedirectTOMainPortal(){
	//window.location.assign("./checkIMEIPortal?lang="+lang+"&utm_source="+$("#utm_source").val());
if(IMEIInvalidStatus  ==="invalidIMEI")
  {
	 var invalidIMEIValue=$("#DeviceID").val();
    console.log("./checkIMEIPortal?lang="+lang+"&utm_source="+$("#utm_source").val()+"&IMEI="+invalidIMEIValue);
    window.location.href = "./checkIMEIPortal?lang="+lang+"&utm_source="+$("#utm_source").val()+"&IMEI="+invalidIMEIValue+"&rightPanel="+leftPannelSideValue;
    
  }
  else{
	 window.location.href = "./checkIMEIPortal?lang="+lang+"&utm_source="+$("#utm_source").val()+"&rightPanel="+leftPannelSideValue;
}	

}
	
	 
    
           document.addEventListener("DOMContentLoaded", function() {
            const numberInput = document.getElementById("DeviceID");

            numberInput.addEventListener("keydown", function(event) {
                // Allow only numerical key codes (0-9) and some special keys like backspace, delete, etc.
               var key = event.which || event.keyCode; // Detecting keyCode
               var ctrl = event.ctrlKey ? event.ctrlKey : ((key === 17)? true : false);
             
                if (
                    (event.key >= "0" && event.key <= "9") ||
                    event.key === "Backspace" ||
                    event.key === "Delete" ||
                    event.key === "ArrowLeft" ||
                    event.key === "ArrowRight" ||
                    event.key === "Tab" ||
                    event.key === "Enter" ||  key== 86 && ctrl
                ) {
                    // Do nothing special, allow the key event
                } else {
                    // Prevent the default behavior of the key event
                    event.preventDefault();
                }
            });
        })
        
        function recaptchaCallback(){
	
	 $("#errorMsgOnModal").css("display", "none");
}
   
  