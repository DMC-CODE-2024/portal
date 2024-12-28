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

 $.getJSON('./getDropdownList/category', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interpretation)
				.appendTo('#category');
				//////console.log("...........");
			}
		});
		 $.getJSON('./getDropdownList/nationality', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interpretation)
				.appendTo('#ownerNationality');
				//////console.log("...........");
			}
		});
 function submitStolenDeviceRequest(){

	var recaptcha=$("#g-recaptcha-response").val();
		if(recaptcha===""){
			
 		   $("#errorMsgOnModal").css("display", "block");
 		   return false;
 		}
 	
 		
		$('div#initialloader').fadeIn('fast');
		$("#stolenLostButton").prop('disabled', true);
		var stolenIMEI1=$('#stolenIMEI1').val();
		var stolenMobile1=$('#stolenMobile1').val();
		var stolenIMEI2=$('#stolenIMEI2').val();
		var stolenIMEI3=$('#stolenIMEI3').val();
		var stolenIMEI4=$('#stolenIMEI4').val();
		var stolenDeviceBrand=$('#stolenDeviceBrand').val();
		var stolenDeviceModel=$('#stolenDeviceModel').val();
		var stolenDate=$('#stolenDate').val();
		var stolenTime=$('#stolenTime').val();
		var stolenOwner=$('#stolenOwner').val();
		var stolenEmail=$('#stolenEmail').val();
		var stolenOwnerAddress1=$('#stolenOwnerAddress1').val();
		var stolenOwnerAddress2=$('#stolenOwnerAddress2').val();
		var stolenOwnerNID=$('#stolenOwnerNID').val();
		var stolenOwnerOTPContact=$('#stolenOwnerOTPContact').val();
		var deviceOwnerNationality=$('#ownerNationality').val();
		var province=$('#provinceCity').val();
		var district=$('#district').val();
		var commune=$('#commune').val();
		var policeStation=$('#policeStation').val();
		var ownerDOB=$('#ownerDOB').val();
		var otpEmail=$('#stolenOtpEmail').val();
		var passportNumber=$('#stolenOwnerPassport').val();
		var category=$('#category').val();
		console.log(" stolenIMEI1 ="+stolenIMEI1+" stolenIMEI2="+stolenIMEI2+" stolenIMEI3 ="+stolenIMEI3+" stolenIMEI4="+stolenIMEI4)		
		if(stolenIMEI1===stolenIMEI2 || stolenIMEI1===stolenIMEI3 || stolenIMEI1===stolenIMEI4 ){
			
			 $('#duplicateIMEIBlock').openModal({dismissible:false});
						 $("#stolenLostButton").prop('disabled', false);
						   $('div#initialloader').delay(500).fadeOut('slow');
			 return false;
		}
		else if(stolenIMEI2===stolenIMEI1 || stolenIMEI2===stolenIMEI3 || stolenIMEI2===stolenIMEI4 ){
			
			 $('#duplicateIMEIBlock').openModal({dismissible:false});
						 $("#stolenLostButton").prop('disabled', false);
						   $('div#initialloader').delay(500).fadeOut('slow');
			 return false;
		}
		else if(stolenIMEI3===stolenIMEI1 || stolenIMEI3===stolenIMEI2 || stolenIMEI3===stolenIMEI4 ){
			
			 $('#duplicateIMEIBlock').openModal({dismissible:false});
						 $("#stolenLostButton").prop('disabled', false);
						   $('div#initialloader').delay(500).fadeOut('slow');
			 return false;
		}
		else if(stolenIMEI4===stolenIMEI1 || stolenIMEI4===stolenIMEI2 || stolenIMEI4===stolenIMEI3 ){
			
			 $('#duplicateIMEIBlock').openModal({dismissible:false});
						 $("#stolenLostButton").prop('disabled', false);
						   $('div#initialloader').delay(500).fadeOut('slow');
			 return false;
		}
		ownerDOB="";
		otpEmail="";
		passportNumber="";
		var res=validationTAC(stolenIMEI1,stolenIMEI2,stolenIMEI3,stolenIMEI4);
		
		if(res==false){
			 $('#"invalidTACBlock"').openModal({dismissible:false});
						 $("#stolenLostButton").prop('disabled', false);
						   $('div#initialloader').delay(500).fadeOut('slow');
			 return false;
		}
		console.log(" stolenIMEI1 ="+stolenIMEI1+" stolenIMEI2="+stolenIMEI2+" stolenIMEI3 ="+stolenIMEI3+" stolenIMEI4="+stolenIMEI4+" stolenMobile1= "+stolenMobile1
		+" stolenDeviceBrand ="+stolenDeviceBrand +" stolenDeviceModel="+stolenDeviceModel +" stolenDate="+stolenDate+" stolenOwner="+stolenOwner+" stolenEmail="+stolenEmail
		+" stolenOwnerAddress1="+stolenOwnerAddress1+" stolenOwnerAddress2="+stolenOwnerAddress2+" stolenOwnerNID="+stolenOwnerNID+" stolenOwnerOTPContact="+stolenOwnerOTPContact
		+" deviceOwnerNationality="+deviceOwnerNationality +" province="+province+" district="+district+" commune="+commune+" policeStation="+policeStation
		+"ownerDOB="+ownerDOB+" otpEmail="+otpEmail+" passportNumber="+passportNumber);
		
		
		var request={
			"imei1":stolenIMEI1,
			"contactNumber":stolenMobile1,
			"imei2":stolenIMEI2,
			"imei3":stolenIMEI3,
			"imei4":stolenIMEI4,
			"deviceBrand":stolenDeviceBrand,
			"deviceModel":stolenDeviceModel,
			"deviceLostDdateTime":stolenDate,
			"deviceLostDdateTime":stolenTime,
			"deviceOwnerName":stolenOwner,
			"deviceOwnerEmail":stolenEmail,
			"deviceOwnerAddress":stolenOwnerAddress1,
			"deviceOwnerAddress2":stolenOwnerAddress2,
			"deviceOwnerNationalID":stolenOwnerNID,
			"contactNumberForOtp":stolenOwnerOTPContact,
			"deviceOwnerNationality":deviceOwnerNationality,
			"province":province,
			"district":district,
			"commune":commune,
			"policeStation":policeStation,
			"ownerDOB":ownerDOB,
			"otpEmail":otpEmail,
			"passportNumber":passportNumber,
			"category":category
			}
			
	var formData;
	
	formData = new FormData();
	formData.append('file', $('#stolenMobileInvoice')[0].files[0]);
	/*formData.append('firFileName', $('#stolenComplaintCopy')[0].files[0]);*/
	formData.append('nidFileName', $('#stolenOwnerNIDfile')[0].files[0]);
	formData.append('request', JSON.stringify(request));		
	
		
		
			 var token = $("meta[name='_csrf']").attr("content");
			 var header = $("meta[name='_csrf_header']").attr("content");
			 $.ajaxSetup({
			 headers:
			 { 'X-CSRF-TOKEN': token }
			 });
			 $.ajax({
				url: './lostStolenSave',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function (data, textStatus, jqXHR) {
					console.log("sucess"+data);
					var statusCode=data.statusCode;
					if(statusCode=="200")
					{
						console.log("-----++"+data.requestID);
						  $("#stolenFormBlock").css("display", "none");
						  $("#verifyOtpForm").css("display", "block");
						  $('#OTPRequestId').val(data.requestID);
						  document.getElementById("resendOTPclick").style.pointerEvents = "none";
						  var mobile=data.tag.replace(/\d(?=\d{4})/g, "x");
						    $('#phoneNumberOTP').append(mobile);
						   timeLeft = 15;
						   elem = document.getElementById('countdown');
						   timerId = setInterval(countdown, 1000);
						   countdown();
						   $('div#initialloader').delay(500).fadeOut('slow');
					}
					else if(statusCode=="201"){
						
						 //$("#invalidPairBlock").css("display", "block");
						 var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						// modalBackdrop.style.display = "block";
						 $('#invalidPairBlock').openModal({dismissible:false});
						 $("#stolenLostButton").prop('disabled', false);
						 
						 
						  $('div#initialloader').delay(500).fadeOut('slow');
					}
					else if(statusCode=="502"){
						
						  $('#duplicateIMEIBlock').openModal({dismissible:false});
						 $("#stolenLostButton").prop('disabled', false);
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
				  $("#verifyOtpForm").css("display", "none");
				  $('#invalidOTP').closeModal();
				  
			}
			$('div#initialloader').fadeIn('fast');
			var otpBox1=$('#OtpBox1').val();
			var otpBox2=$('#OtpBox2').val();
			var otpBox3=$('#OtpBox3').val();
			var otpBox4=$('#OtpBox4').val();
			var otpRequestID=$('#OTPRequestId').val();
			var request={
				"otpBox1":otpBox1,
				"otpBox2":otpBox2,
				"otpBox3":otpBox3,
				"otpBox4":otpBox4,
				"requestID":otpRequestID,
				"requestType":"Stolen"
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
						  $("#stolenFormBlock").css("display", "none");
						  $("#verifyOtpForm").css("display", "none");
						  $("#successOTPScreen").css("display", "block");
						  $('#verifyOTPrequestid').append(data.requestID);
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
						   elem = document.getElementById('countdown');
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
}

$(function(){
    var dtToday = new Date();
    
    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();
    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();
    
    var maxDate = year + '-' + month + '-' + day;

    $('#stolenDate,#ownerDOB').attr('max', maxDate);
});

function validationTAC(imei1,imei2,imei3,imei4){
	
	imei1=imei1.slice(0, -7);
	imei2=imei2.slice(0, -7);
	imei3=imei3.slice(0, -7);
	imei4=imei4.slice(0, -7);
	console.log("tac number="+imei1);
	if(imei1===imei2 && imei1==imei3 && imei1==imei4){
		
		return true;
	}
	else{

		return false
		}
		
	
}

function chooseNationality(){
	
		var nationality=$('#ownerNationality').val();
		if(nationality==="1"){
		 $("#ownerDOBlDiv").css("display", "block");
		  $("#ownerEmailDiv").css("display", "none");	
		  $("#ownerPassportDiv").css("display", "block");
		  $("#ownerNIDdiv").css("display", "none");
		  $("#otpEmailDiv").css("display", "block");
		  $("#otpContactDiv").css("display", "none");
		  document.getElementById("stolenOtpEmail").required = true;
		  document.getElementById("stolenOwnerOTPContact").required = false;
		  document.getElementById("stolenEmail").required = false;
		  document.getElementById("stolenOwnerNID").required = false;
		  
		  	
		}
		else{
			$("#ownerDOBlDiv").css("display", "none");
		  $("#ownerEmailDiv").css("display", "block");	
		  $("#ownerPassportDiv").css("display", "none");
		  $("#ownerNIDdiv").css("display", "block");
		  $("#otpEmailDiv").css("display", "none");
		  $("#otpContactDiv").css("display", "block");	
		  document.getElementById("stolenOtpEmail").required = false;
		  document.getElementById("stolenOwnerOTPContact").required = true;
		  document.getElementById("stolenEmail").required = true;
		}
}
