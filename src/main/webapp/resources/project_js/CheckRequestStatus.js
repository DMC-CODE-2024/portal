/**
 * 
 */
  var otpVerifyLimit=3;
 var otpTry=1;
 var timeLeft;
 	var elem;
 	var timerId ;
$.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
}).done(function() {
});

	
	document.getElementById("resendOTPclick").addEventListener('click',function ()
{
	
    resendOTP();
   }  ); 
   
   
   function closeModal(id){
	$('#'+id).closeModal();
}
$('div#initialloader').delay(500).fadeOut('slow');




	
function countdown() {


    if (timeLeft == -1) {
        clearTimeout(timerId);
        doSomething();
    } else {
        elem.innerHTML = timeLeft;
        timeLeft--;
    }
}

function doSomething() {
    document.getElementById("resendOTPclick").style.pointerEvents = "auto";
    $('#resendOTPclick').css('color', 'blue');
    	$("#checkStatusFoundButton").prop('disabled', true);
}


		
	function resendOTP(){
	$('div#initialloader').fadeIn('fast');
		var formData;
	var otpRequestID=$('#OTPRequestId').val();
	var request={
				
				"requestID":otpRequestID
			}
	formData = new FormData();		
					formData.append('request', JSON.stringify(request));
			 var token = $("meta[name='_csrf']").attr("content");
			 var header = $("meta[name='_csrf_header']").attr("content");
			 $.ajaxSetup({
			 headers:
			 { 'X-CSRF-TOKEN': token }
			 });
			 $.ajax({
				url: './resendOTPRequest',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function (data, textStatus, jqXHR) {
					console.log("sucess"+data);
					var statusCode=data.statusCode;
					if(statusCode=="200")
					{
						$('#OtpBox1').val('');
						$('#OtpBox2').val('');
						$('#OtpBox3').val('');
						$('#OtpBox4').val('');
						 timeLeft = 15;
						   elem = document.getElementById('recoverycountdown');
						   timerId = setInterval(countdown, 1000);
						   countdown();
						    document.getElementById("resendOTPclick").style.pointerEvents = "none";
    						  $('#resendOTPclick').css('color', 'black');
						}
						
					 $('div#initialloader').delay(500).fadeOut('slow');
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				
				}
			});
			return false;
	}		
	
		
 function submitCheckDeviceRequest(){

	var recaptcha=$("#g-recaptcha-response").val();
		if(recaptcha===""){
			
 		   $("#errorMsgOnModal").css("display", "block");
 		   return false;
 		}
		$('div#initialloader').fadeIn('fast');
		$("#checkStatusFoundButton").prop('disabled', true);
		var recoveryRequestID=$('#recoveryRequestID').val();
		var request={
			"requestId":recoveryRequestID,
		
			}
			
	var formData;
	
	formData = new FormData();
	formData.append('request', JSON.stringify(request));		
	
		
		
			 var token = $("meta[name='_csrf']").attr("content");
			 var header = $("meta[name='_csrf_header']").attr("content");
			 $.ajaxSetup({
			 headers:
			 { 'X-CSRF-TOKEN': token }
			 });
			 $.ajax({
				url: './checkRequestStatus',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function (data, textStatus, jqXHR) {
					
					var statusCode=data.statusCode;
					if(statusCode=="200")
					{
						  $("#checkStatusFormBlock").css("display", "none");
						  $("#verifyRecoveryOtpForm").css("display", "block");
						  $('#OTPRequestId').val(data.data.requestId);
						   var mobile=data.data.contactNumberForOtp.replace(/\d(?=\d{4})/g, "x");
						  $('#phoneNumberOTP').append(mobile); 
						  document.getElementById("resendOTPclick").style.pointerEvents = "none";
						  timeLeft = 15;
						  elem = document.getElementById('recoverycountdown');
						  timerId = setInterval(countdown, 1000);
						  countdown();
						  $('div#initialloader').delay(500).fadeOut('slow');
					}
					else if(statusCode=="201"){
						
						 //$("#invalidPairBlock").css("display", "block");
						 var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						// modalBackdrop.style.display = "block";
						 $('#invalidPairBlock').openModal({dismissible:false});
						 $("#checkStatusFoundButton").prop('disabled', false);
						 
						 
						  $('div#initialloader').delay(500).fadeOut('slow');
					}
					//sessionStorage.removeItem("nationalId");
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				
				}
			});
			return false;

			 } 
			 
function submitOTPRequest(){
			
			if(otpTry>otpVerifyLimit){
				  $("#invalidOTP").css("display", "none");
				  $("#otplimitExceed").css("display", "block");
				  $("#verifyRecoveryOtpForm").css("display", "none");
				  
			}
			$('div#initialloader').fadeIn('fast');
			var otpBox1=$('#OtpBox1').val();
			var otpBox2=$('#OtpBox2').val();
			var otpBox3=$('#OtpBox3').val();
			var otpBox4=$('#OtpBox4').val();
			var otpRequestID=$('#OTPRequestId').val();
			var oldRequestId= $('#OTPRequestIdPrevious').val();
			var request={
				"otpBox1":otpBox1,
				"otpBox2":otpBox2,
				"otpBox3":otpBox3,
				"otpBox4":otpBox4,
				"requestID":otpRequestID,
				"requestType":"checkstatus"
			}
			var formData;
	
	formData = new FormData();		
					formData.append('request', JSON.stringify(request));
			 var token = $("meta[name='_csrf']").attr("content");
			 var header = $("meta[name='_csrf_header']").attr("content");
			 $.ajaxSetup({
			 headers:
			 { 'X-CSRF-TOKEN': token }
			 });
			 $.ajax({
				url: './verifyOTPRequest',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function (data, textStatus, jqXHR) {
					console.log("sucess"+data);
					
					var statusCode=data.statusCode;
					if(statusCode=="200")
					{
						console.log("-----");
						  $("#checkStatusFormBlock").css("display", "none");
						  $("#verifyRecoveryOtpForm").css("display", "none");
						  
						  if(data.tag=="Stolen"){
							 $("#blockModelID").css("display", "block");
							  $('#blockRequestID').append(" "+data.requestID); 
						}
						else if(data.tag=="Recovery"){
							 $("#UnblockModelID").css("display", "block");
							 $('#unblockRequestID').append(" "+data.requestID);
						}
							$('div#initialloader').delay(500).fadeOut('slow');
						   
					}
					else if (statusCode=="201"){
						//$("#invalidOTP").css("display", "block");
						 var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						// modalBackdrop.style.display = "block";
						 $('#invalidOTP').openModal({dismissible:false});
						  $('div#initialloader').delay(500).fadeOut('slow');
					}
					
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				
				}
			});
			otpTry++;
			return false;
			
			}
			
			
			
			