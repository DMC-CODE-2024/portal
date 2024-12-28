/**
 *
 */

$(document).ready(function() {
var protocol = window.location.protocol;
var domain = window.location.hostname;
var port = window.location.port;
window.urlWithProtocol = port == '' ? protocol + "//" + domain : protocol + "//" + domain +":" + port;
completeDomainName = port == '' ? protocol + "//" + domain : protocol + "//" + domain +":" + port;
});
$(document).ready(function() {

        var lang=$("body").attr("data-lang-param") == 'km' ? 'km' : 'en';
    $.i18n().locale = lang;
   // fetchCountries();

});


 var otpVerifyLimit=3;
 var otpTry=1;
 var resendCount=1;
 var timeLeft;
 	var elem;
 	var timerId ;

$.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
}).done(function() {
});


		 $.getJSON('./getDropdownList/nationality', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interpretation)
				.appendTo('#ownerNationality');
				//////console.log("...........");
			}
		});
		$.getJSON('./getDropdownList/device_type_tag', function(data) {
        			for (i = 0; i < data.length; i++) {
        				$('<option>').val(data[i].value).text(data[i].interpretation)
        				.appendTo('#deviceType');
        				//////console.log("...........");
        			}
        		});

        $.getJSON('./brandName', function(data) {
                			for (i = 0; i < data.length; i++) {
                				$('<option>').val(data[i].brandName).text(data[i].brandName)
                				.appendTo('#stolenDeviceBrand');

                				//////console.log("...........");
                			}
                		});

         $.getJSON('./getCountryCode', function(data) {
                         			for (i = 0; i < data.length; i++) {
                         				$('<option>').val(data[i].phoneCode).text(data[i].phoneCode)
                         				.appendTo('#contactCountryCode');
                         				$('#contactCountryCode').val("+855");
                         				//////console.log("...........");
                         			}
                         		});


function areValuesUnique(inputs) {

   // var inputs = document.querySelectorAll('input[type="text"]');
    for (var i = 0; i < inputs.length; i++) {

        for (var j = i + 1; j < inputs.length; j++) {

            if (inputs[i] === inputs[j]) {
              return false; // Found a duplicate value

            }

        }

    }

    return true; // All values are unique

}
let isEmpty = (x)=>{
if(x == undefined || x == ''){return null};
return x;
};

 function submitStolenDeviceRequest(){

    var countrycode=+855;
	var recaptcha=$("#g-recaptcha-response").val();
		if(recaptcha===""){

 		   $("#errorMsgOnModal").css("display", "block");
 		   return false;
 		}


		$('div#initialloader').fadeIn('fast');
		$("#stolenLostButton").prop('disabled', true);
		var stolenDate=$('#stolenDate').val()+" "+$('#stolenTime').val();
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
		var language=$("body").attr("data-lang-param");
		var serialNumber=$('#serialNumber').val();
		var deviceType=$('#deviceType').val();
		var incidentDetail=$('#incidentDetail').val();
		var stolenRemark=$('#stolenRemark').val();


		if (stolenOwnerOTPContact.startsWith('0')) {
                 // Remove the leading '0'
               stolenOwnerOTPContact = stolenOwnerOTPContact.slice(1);
                 }
		if(stolenOwnerOTPContact=="" ||stolenOwnerOTPContact==null){
		stolenOwnerOTPContact="";
		}
		else{
		if(deviceOwnerNationality===0){
        		stolenOwnerOTPContact=countrycode+stolenOwnerOTPContact;
        		}
        		else{
        		stolenOwnerOTPContact=stolenOwnerOTPContact;
        		}
		}

		var request={
			"deviceLostDdateTime":stolenDate,
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
			"category":category,
			"language":language,
			"serialNumber":serialNumber,
			"deviceType":deviceType,
		    "incidentDetail":incidentDetail,
		    "remarks":stolenRemark,
		    "username":$("body").attr("data-selected-username"),
		    "userType":$("body").attr("data-roletype"),
		    "userId":$("body").attr("data-userid")
			}

	var formData;

	formData = new FormData();
	formData.append('file', $('#stolenMobileInvoice')[0].files[0]);
	formData.append('firCopy', $('#deviceFirCopy')[0].files[0]);
	formData.append('nidFileName', $('#stolenOwnerNIDfile')[0].files[0]);
	formData.append('otherDocument', $('#stolenOtherdocument')[0].files[0]);
	formData.append('bulkFile', $('#stolenMobileFile')[0].files[0]);
	formData.append('request', JSON.stringify(request));



			 var token = $("meta[name='_csrf']").attr("content");
			 var header = $("meta[name='_csrf_header']").attr("content");
			 $.ajaxSetup({
			 headers:
			 { 'X-CSRF-TOKEN': token }
			 });
			 $.ajax({
				url: './lostStolenSaveBulk',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function (data, textStatus, jqXHR) {
					console.log("sucess"+data);
					var statusCode=data.statusCode;
					if(statusCode=="200")
					{
						  $("#stolenFormBlock").hide();
						  $("#verifyOtpForm").css("display", "block");
						  $('.content-box .content-container').scrollTop(0);
						  $('#OTPRequestId').val(data.requestID);
						  document.getElementById("resendOTPclick").style.pointerEvents = "none";
						  console.log("nationality"+data.txnId);
						  if(data.txnId==0){
						  var mobile=data.tag.replace(/\d(?=\d{4})/g, "x");
						    $('#phoneNumberOTP').append(mobile);
						    console.log("mobile"+data.tag);
						    }
						    else if (data.txnId==1){
							console.log("email="+data.tag);
							var userEMail=data.tag;
							var atIndex = userEMail.indexOf('@');
                                    var dotIndex = userEMail.indexOf('.', atIndex);

							   var maskedEmail = 'xxxxx' + userEMail.substring(dotIndex);
							 $("#phoneNumberOTP").css("display", "none");
							  $("#emailOTPMsg").css("display", "block");
						    $('#emailOTPMsg').append(maskedEmail);
						}
						   timeLeft = $("body").attr("data-timeout");
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
					else if(statusCode=="503"){

                    						 var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
                    						 $('#invalidPairBlock').openModal({dismissible:false});
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

			/*if(otpTry>otpVerifyLimit){
				  $("#invalidOTP").css("display", "none");
				  $("#otplimitExceed").css("display", "block");
				  $("#verifyOtpForm").css("display", "none");
				  $('#invalidOTP').closeModal();

			}*/
			var t1=$('#OtpBox1').val();
			var t2=$('#OtpBox2').val();
			var t3=$('#OtpBox3').val();
			var t4=$('#OtpBox4').val();
			var t5=$('#OtpBox5').val();
			var t6=$('#OtpBox6').val();
			if(t1== null || t1==""){
				$('#OtpBox1').focus();
				//$('#OtpBox1').css("border", "1px solid #ced4da");
				return false;
			}
			if(t2== null || t2==""){
				$('#OtpBox2').focus();
				//$('#OtpBox2').css("border", "1px solid #ced4da");
				return false;
			}
			if(t3== null || t3==""){
				$('#OtpBox3').focus();
				//$('#OtpBox3').css("border", "1px solid #ced4da");
				return false;
			}
			if(t4== null || t4==""){
				$('#OtpBox4').focus();
				//$('#OtpBox4').css("border", "1px solid #ced4da");
				return false;
			}
			if(t5== null || t5==""){
				$('#OtpBox5').focus();
				//$('#OtpBox5').css("border", "1px solid #ced4da");
				return false;
			}
			if(t6== null || t6==""){
				$('#OtpBox6').focus();
				//$('#OtpBox6').css("border", "1px solid #ced4da");
				return false;
			}
			if(otpTry>otpVerifyLimit){
				  /*("#RequestFormVeriOTP").show();
					$("#verifyotpform").hide();*/
				  $('#otplimitExceed').openModal({dismissible:false});
				  $("#verifyOtpForm").css("display", "none");
				 // $('#RequestFormVeriOTPButton').prop('disabled', false);
    			  $('#OtpBox1').val('');
				  $('#OtpBox2').val('');
				  $('#OtpBox3').val('');
				  $('#OtpBox4').val('');
				  $('#OtpBox5').val('');
				  $('#OtpBox6').val('');
				  otpTry=1;
				  return false;
			}
			$('div#initialloader').fadeIn('fast');
			var otpBox1=$('#OtpBox1').val();
			var otpBox2=$('#OtpBox2').val();
			var otpBox3=$('#OtpBox3').val();
			var otpBox4=$('#OtpBox4').val();
			var otpBox5=$('#OtpBox5').val();
			var otpBox6=$('#OtpBox6').val();
			var otpRequestID=$('#OTPRequestId').val();
			var request={
				"otpBox1":otpBox1,
				"otpBox2":otpBox2,
				"otpBox3":otpBox3,
				"otpBox4":otpBox4,
				"otpBox5":otpBox5,
				"otpBox6":otpBox6,
				"requestID":otpRequestID,
				"requestType":"Stolen",
				"username":$("body").attr("data-selected-username"),
                "userType":$("body").attr("data-roletype"),
                "userId":$("body").attr("data-userid")
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
					else if (statusCode=="202"){
						//$("#invalidOTP").css("display", "block");
						 var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						// modalBackdrop.style.display = "block";
						 $('#expireOTP').openModal({dismissible:false});
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


	/*function resendOTP(){
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
	}*/

function resendOTP(){
	//$('div#initialloader').fadeIn('fast');
	$('#RequestFormVeriOTPButton').prop('disabled', false);
	var formData;
	var otpRequestID=$('#OTPRequestId').val();
	lang= $('#langList').val();
	$('#saveConfirmationMessage').openModal({dismissible:false});
	setTimeout(function() {
  		$('#saveConfirmationMessage').closeModal({
    	dismissible: false
      	});
	 }, 3000);
	 document.getElementById("resendOTPclick").style.pointerEvents = "none";
	 $('#resendOTPclick').css("color","#807a8759");
	var request={
				"requestID":otpRequestID,
				"lang":lang
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
					 //var data = JSON.parse(data);
					console.log("sucess"+data);
					var statusCode=data.statusCode;
					if(statusCode=="200")
					{
						console.log("++++++++");
						$('#OtpBox1').val('');
						$('#OtpBox2').val('');
						$('#OtpBox3').val('');
						$('#OtpBox4').val('');
						$('#OtpBox5').val('');
						$('#OtpBox6').val('');
						timeLeft=$("body").attr("data-timeout");
    					elem = document.getElementById('countdown');
    					console.log("---"+elem);
    					elem.innerHTML = timeLeft;
						timerId = setInterval(countdown, 1000);
						countdown();
					}
					// $('div#initialloader').delay(500).fadeOut('slow');
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				}
			});
			resendCount++;
			/*if(resendCount>3){
							$('#resendOTPclick').css("display", "none");
							$('#resendOTPclick_time').css("display", "none");
						}*/
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





/*function countdown() {


    if (timeLeft == -1) {
        clearTimeout(timerId);
        doSomething();
    } else {
        elem.innerHTML = timeLeft;
        timeLeft--;
    }
}*/

function countdown() {

    if (timeLeft == -1) {
        clearTimeout(timerId);
        doSomething();
        if(resendCount>3){
			$('#expiredOtpConfirmationMessage').openModal({dismissible:false});
			setTimeout(function() {
  				$('#expiredOtpConfirmationMessage').closeModal({
    			dismissible: false
      		});
	 		}, 4000);
			$('#resendOTPclick').css("display", "none");
			$('#resendOTPclick_time').css("display", "none");
			resendCount=1;
		}
    	} else {
        	elem.innerHTML = timeLeft;
        	timeLeft--;
    	}
}
function doSomething() {
    document.getElementById("resendOTPclick").style.pointerEvents = "auto";
    $('#resendOTPclick').css('color', 'blue');
}



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
		  $("#NIDblockLabel").css("display", "none");
		  $("#PassportblockLabel").css("display", "block");
		  document.getElementById("stolenOtpEmail").required = true;
		  document.getElementById("stolenOwnerOTPContact").required = false;
		  document.getElementById("stolenEmail").required = false;
		  document.getElementById("stolenOwnerNID").required = false;
         $("#file-nameNid").text('');

		}
		else{
			$("#ownerDOBlDiv").css("display", "none");
		  $("#ownerEmailDiv").css("display", "block");
		  $("#ownerPassportDiv").css("display", "none");
		  $("#ownerNIDdiv").css("display", "block");
		  $("#otpEmailDiv").css("display", "none");
		  $("#otpContactDiv").css("display", "block");
		  $("#PassportblockLabel").css("display", "none");
		  $("#NIDblockLabel").css("display", "block");
		  document.getElementById("stolenOtpEmail").required = false;
		  document.getElementById("stolenOwnerOTPContact").required = true;
		  document.getElementById("stolenEmail").required = true;
		  $("#file-nameNid").text('');
		}
}

// Function to check if all digits are 0
function allZeroes(input) {
   console.log("new function==");
    return /^0+$/.test(input);
}

function findDuplicateIMEI(imeis) {
  let duplicates = {};
  let result = [];

  for (let i = 0; i < imeis.length; i++) {
    if (duplicates[imeis[i]] === undefined) {
      // If the IMEI is encountered for the first time, store its index
      duplicates[imeis[i]] = i;
    } else {
      // If the IMEI is encountered again, it's a duplicate
      if (duplicates[imeis[i]] !== -1) {
        result.push(imeis[i]);
        // Mark the duplicate as found to avoid adding it multiple times
        duplicates[imeis[i]] = -1;
      }
    }
  }

  return result;
}

	function isEmptyString(str) {
  return str.length === 0;
}


// Function to fetch countries and populate dropdown and list

// Call the function to fetch countries and populate dropdown and list
// -----Country Code Selection

function fetchCountries() {
    try {
        const response = "";
        const countries = CountryPhoneCodeWithName();
console.log(countries)
        // Populate dropdown
        const dropdown = document.getElementById("countryCodesDropdown");
        countries.forEach(country => {
            const option = document.createElement("option");
            option.text = `${country.name} (${country.phone_code})`;
            option.value = country.callingCodes;
            dropdown.appendChild(option);
        });

        // Populate country list
        const countryList = document.getElementById("countryList");
        countries.forEach(country => {
            const listItem = document.createElement("li");
            listItem.textContent = `${country.name} - ${country.phone_code}`;
            countryList.appendChild(listItem);
        });
    } catch (error) {
        console.error("Error fetching countries:", error);
    }
}


function clearForm(formID){
	document.getElementById(formID).reset();
}


document.querySelector('.custom-file-button').addEventListener('click', function() {
               document.getElementById('stolenMobileInvoice').click();
});
document.querySelector('.NidFile').addEventListener('click', function() {
               document.getElementById('stolenOwnerNIDfile').click();
});
document.querySelector('.firCopy').addEventListener('click', function() {
               document.getElementById('deviceFirCopy').click();
});
document.querySelector('.otherdocument').addEventListener('click', function() {
               document.getElementById('stolenOtherdocument').click();
});
document.querySelector('.file-nameStolen').addEventListener('click', function() {
               document.getElementById('stolenMobileFile').click();
});

           // Update custom button text when a file is selected
document.getElementById('stolenMobileInvoice').addEventListener('change', function() {
               var fileName = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
               document.getElementById('file-name').textContent = fileName;
});
document.getElementById('stolenOwnerNIDfile').addEventListener('change', function() {
               var fileNameNID = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
               document.getElementById('file-nameNid').textContent = fileNameNID;

});
document.getElementById('deviceFirCopy').addEventListener('change', function() {
               var fileNameFir = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
               document.getElementById('file-nameFir').textContent = fileNameFir;
});
document.getElementById('stolenOtherdocument').addEventListener('change', function() {
               var fileNameOtherDoc = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
               document.getElementById('file-nameOtherDoc').textContent = fileNameOtherDoc;

});
document.getElementById('stolenMobileFile').addEventListener('change', function() {
               var bulkFileName = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
               document.getElementById('bulkFile').textContent = bulkFileName;

});

 // Adding form submit event to handle custom validation
    document.getElementById('fromStolenId').addEventListener('submit', function(event) {
        const textarea = document.getElementById('incidentDetail');
        validateTextarea(textarea,'stolenLostButton','error-message');

        if (!textarea.checkValidity()) {
            event.preventDefault(); // Prevent form submission if textarea is invalid
        }
    });


 /*sampleFileDownloadById*/
 function sampleFileDownloadByIdBulk(id){
 var sampeFileRequest = {
 "type":"sample_st"
 }
 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $.ajaxSetup({
 headers:
 { 'X-CSRF-TOKEN': token }
 });
 $.ajax({
 url : "./Consignment/downloadSampleFileBulk",
 data : JSON.stringify(sampeFileRequest),
 dataType : 'json',
 async: false,
 contentType : 'application/json; charset=utf-8',
 type : 'POST',
 success: function (data, textStatus, jqXHR) {
 console.log("data=="+JSON.stringify(data));
window.location.href = data.url;
 }
 });
 }
