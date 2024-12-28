var featureId = $("body").attr("data-featureid");
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType");
var startdate=$('#startDate').val();
var endDate=$('#endDate').val();



var documenttype,selectfile,selectDocumentType;

$(document).ready(function(){
    var lang=$("body").attr("data-lang-param") == 'km' ? 'km' : 'en';
        $.i18n().locale = lang;
	$('div#initialloader').fadeIn('fast');
	var requestIdToFetchDetail=$("#requestIdToFetchDetail").val()
	openSingleStolenViewForm(requestIdToFetchDetail)
});
$.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
}).done(function() {
});
var role = currentRoleType == null ? roleType : currentRoleType;

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
$.getJSON('./getCountryCode', function(data) {
                         			for (i = 0; i < data.length; i++) {
                         				$('<option>').val(data[i].phoneCode).text(data[i].phoneCode)
                         				.appendTo('#contactCountryCode');

                         				//////console.log("...........");
                         			}
                         		});

function openSingleStolenViewForm(rowId){
	 var tempId=rowId;
		if(tempId==null || tempId=="" || tempId==''){
			$("#noRecordMessage").openModal({
						 	   dismissible:false
						    });
			return false;
		}
		var request ={
				"requestId" : rowId,
				"userId": parseInt(userId),
				"featureId":parseInt($("body").attr("data-featureid")),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username")
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
				url: './bulkStolen/view',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						var result = data
						console.log(JSON.stringify(result));
						setData(result);

			$('div#initialloader').delay(300).fadeOut('slow');
					//noRecordMessage
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
					$("#noRecordMessage").openModal({
						 	   dismissible:false
						    });
				}
			});
		}

function setData(stolenData){
		var stolenDate=stolenData.deviceLostDdateTime.substring(0,10);
		var stolentime=stolenData.deviceLostDdateTime.substring(11);
		console.log("++"+stolenData.contactNumberForOtp);
		var OtpContactNumber=stolenData.contactNumberForOtp.substring(3,13);
        var selectedCountryCode =stolenData.contactNumber.replace(/(\d{9})$/, '');
        var countrycodesign="+";
        console.log(" country code==="+countrycodesign+selectedCountryCode)

        if (stolenData.status !== "INIT") {
            console.log("status  is not init");
                	$("#firDetailBlock").css("display", "block");
                	$('#fileNameEdit4').val(stolenData.devicePurchaseInvoiceUrl);
                    $('#stolenPreviewID4').attr("onclick",'previewStolenFile("'+stolenData.firCopyUrl+'","'+stolenData.devicePurchaseInvoiceUrl+'","'+stolenData.requestId+'")');
                    $('#addRemark').val(stolenData.remarks);
                    disableForm();
            }
            else{
            	$("#firUploadBlock").css("display", "block");
            }

		$('#stolenMgmtid').val(stolenData.id);
		$('#stolenMgmtRequestid').val(stolenData.requestId);
		 $('#stolenMobile1').val(stolenData.contactNumber.slice(-9));
		 $('#stolenIMEI1').val(stolenData.imei1);
		 $('#stolenIMEI2').val(stolenData.imei2);
		 $('#stolenIMEI3').val(stolenData.imei3);
		 $('#stolenIMEI4').val(stolenData.imei4);
		 $('#stolenDate').val(stolenData.deviceLostDdateTime);
		 $('#stolenDeviceBrand').val(stolenData.deviceBrand);
		 $('#stolenDeviceModel').val(stolenData.deviceModel);
		 $('#stolenDate').val(stolenDate);
		 $('#stolenTime').val(stolentime);
		 $('#stolenOwner').val(stolenData.deviceOwnerName);
		 $('#stolenEmail').val(stolenData.deviceOwnerEmail);
		 $('#stolenOwnerAddress1').val(stolenData.deviceOwnerAddress);
		 $('#stolenOwnerAddress2').val(stolenData.deviceOwnerAddress2);
		 $('#stolenOwnerNID').val(stolenData.deviceOwnerNationalID);
		 console.log("--++--"+stolenData.contactNumberForOtp.slice(-9));

		 $('#stolenOwnerOTPContact').val(stolenData.contactNumberForOtp.slice(-9));
		 $('#ownerNationality').val(stolenData.deviceOwnerNationality).change();
		 $('#provinceCity').val(stolenData.province).change();
		 $('#district').val(stolenData.district).change();
		 $('#commune').val(stolenData.commune).change();
		 $('#policeStation').val(stolenData.commune).change();
		 $('#ownerDOB').val(stolenData.ownerDOB);
		 $('#stolenOtpEmail').val(stolenData.otpEmail);
		 $('#stolenOwnerPassport').val(stolenData.passportNumber);
		 $('#category').val(stolenData.category);
         $('#deviceType').val(stolenData.deviceType);
		 $('#stolenSerialNumber').val(stolenData.serialNumber);
		 $('#stolenIncident').val(stolenData.incidentDetail);
		 $('#requestNo1').val(stolenData.requestId);

		 $('#fileNameEdit').val(stolenData.mobileInvoiceBill);
		 var domainLink=domainURL(stolenData.firCopyUrl);
		 $('#stolenPreviewID').attr("onclick",'previewStolenFile("'+domainLink+'","'+stolenData.mobileInvoiceBill+'","'+stolenData.requestId+'")');
		 $('#fileNameEdit2').val(stolenData.deviceOwnerNationalIdUrl);
         $('#stolenPreviewID2').attr("onclick",'previewStolenFile("'+domainLink+'","'+stolenData.deviceOwnerNationalIdUrl+'","'+stolenData.requestId+'")');
         $('#fileNameEdit3').val(stolenData.otherDocument);
         $('#stolenPreviewID3').attr("onclick",'previewStolenFile("'+domainLink+'","'+stolenData.otherDocument+'","'+stolenData.requestId+'")');
         if(stolenData.status!=="INIT")
         {
         $('#submitButton').prop('disabled', true);
         }
          $('#contactCountryCode').val(countrycodesign+selectedCountryCode);
}


document.querySelector('.firCopy').addEventListener('click', function() {
               document.getElementById('deviceFirCopy').click();
});

document.getElementById('deviceFirCopy').addEventListener('change', function() {
               var fileNameFir = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
               document.getElementById('file-nameFir').textContent = fileNameFir;
});


 function verifyDevice(){
    var stolenIMEI1=$('#stolenIMEI1').val();
    var request={
    				"imei1":stolenIMEI1
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
    				url: './verifyDevice',
    				type: 'POST',
    				data: formData,
    				processData: false,
    				contentType: false,
    				success: function (data, textStatus, jqXHR) {
    					console.log("success"+data);
    					if(data.data!=null){
                        var stolenDeviceBrand=$('#stolenDeviceBrand').val();
                        var stolenDeviceModel=$('#stolenDeviceModel').val();
                        var stolenDeviceType=$('#deviceType').val();
                       var isValidBrand= stolenDeviceBrand==data.data.brandName ? true:false
                       var isValidModel= stolenDeviceModel==data.data.modelName ? true:false
                       var isValidDeviceType= stolenDeviceType==data.data.deviceType ? true:false

                        if(!isValidBrand) {
                         errorModalForInvalidExtension($.i18n('invalidBrand'));
                          setTimeout(function() {
                          $('#InvalidExtension').hide();
                          }, 3000);
                          return false;
                         }
                        if(!isValidModel) {
                         errorModalForInvalidExtension($.i18n('invalidModel'));
                          setTimeout(function() {
                          $('#InvalidExtension').hide();
                          }, 3000);
                          return false;
                         }
                        if(!isValidDeviceType) {

                           errorModalForInvalidExtension($.i18n('invalidDeviceType'));
                            setTimeout(function() {
                            $('#InvalidExtension').hide();
                            }, 3000);
                            return false;
                           }
                           if(isValidDeviceType && isValidModel && isValidBrand){
                           errorModalForInvalidExtension($.i18n('validDevice'));
                           setTimeout(function() {
                           $('#InvalidExtension').hide();
                           }, 3000);
                           $('#submitButton').prop('disabled', false);
                           }
    					}

    					else{
    					errorModalForInvalidExtension($.i18n('verificationFail'));
    					setTimeout(function() {
                        $('#InvalidExtension').hide();
                        }, 3000);

    					}
                    },
    				error: function (jqXHR, textStatus, errorThrown) {
    					////console.log("error in ajax")
    				}
    			});
    			 }

let isEmpty = (x)=>{
if(x == undefined || x == ''){return null};
return x;
};


function requestApproved() {
	var stolenIMEI1=$('#stolenIMEI1').val();
	var stolenMobile1=$('#contactCountryCode').val()+$('#stolenMobile1').val();
            stolenMobile1 = stolenMobile1.replace(/[\+\s]/g, '');
     		var stolenIMEI2=isEmpty($('#stolenIMEI2').val());
     		var stolenIMEI3=isEmpty($('#stolenIMEI3').val());
     		var stolenIMEI4=isEmpty($('#stolenIMEI4').val());
     		var stolenDeviceBrand=$('#stolenDeviceBrand').val();
     		var stolenDeviceModel=$('#stolenDeviceModel').val();
     		var stolenDate=$('#stolenDate').val()+" "+$('#stolenTime').val();
     		var stolenTime=$('#stolenTime').val();
     		var stolenOwner=$('#stolenOwner').val();
     		var stolenEmail=$('#stolenEmail').val();
     		var stolenOwnerAddress1=$('#stolenOwnerAddress1').val();
     		var stolenOwnerAddress2=$('#stolenOwnerAddress2').val();
     		var stolenOwnerNID=$('#stolenOwnerNID').val();
     		var stolenOwnerOTPContact="855"+$('#stolenOwnerOTPContact').val();
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
     		var incidentDetail=$('#stolenIncident').val();
     		var stolenRemark=$('#stolenRemark').val();

             var res=validationTAC(stolenIMEI1,stolenIMEI2,stolenIMEI3,stolenIMEI4);
                     if(res===false){
                      $('#invalidPairBlock').openModal({dismissible:false});
                      return false;
                     }

     	   	const imeis = [stolenIMEI1];
     	    if(stolenIMEI2!=="" && stolenIMEI2!==null){
     		imeis.push(stolenIMEI2);
     	    }
     	    if(stolenIMEI3!=="" && stolenIMEI3!==null){
     		imeis.push(stolenIMEI3);
     	    }
     	    if(stolenIMEI4!=="" && stolenIMEI4!==null){
     		imeis.push(stolenIMEI4);
     	    }

         	var resultimei= areValuesUnique(imeis);
         	if(resultimei==false){
     		$('#duplicateIMEIBlock').openModal({dismissible:false});
     				   $("#stolenLostButton").prop('disabled', false);
     				   $('div#initialloader').delay(500).fadeOut('slow');
     			       return false;
              }
             var mobilecheck1=	allZeroes(stolenMobile1);
     		if(mobilecheck1==true){
     			 $('#invalidMobileNumber').openModal({dismissible:false});
     			 $("#stolenLostButton").prop('disabled', false);
     			 $('div#initialloader').delay(500).fadeOut('slow');
     			 return false
     		}
            	var requestNo = $('#requestNo1').val();

     		var remarks = $('#addRemark').val();
            	var firCopyUrl = $('#fileNameEdit4').val();
            	var requestNo = $('#requestNo1').val();
            	if(remarks==="" || remarks===null)
            	{

            	return false;
            	}
      if(deviceOwnerNationality===0){
		stolenOwnerOTPContact
		}
		else{
		stolenOwnerOTPContact="";
		}
     		var request={
     			"imei1":stolenIMEI1,
     			"contactNumber":stolenMobile1,
     			"imei2":stolenIMEI2,
     			"imei3":stolenIMEI3,
     			"imei4":stolenIMEI4,
     			"deviceBrand":stolenDeviceBrand,
     			"deviceModel":stolenDeviceModel,
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
     		    "remarks": $('#addRemark').val(),
     		    "username":$("body").attr("data-selected-username"),
     		    "userType":$("body").attr("data-roletype"),
     		    "userId":$("body").attr("data-userid"),
     		    "firCopyUrl":firCopyUrl,
     		    "requestId" : requestNo,
     		    "previousFile":$('#fileNameEdit').val(),
     		    "previousNidFileName":$('#fileNameEdit2').val(),
     		    "previousOtherDocument":$('#fileNameEdit3').val(),
     		    }
    console.log("data to approve==="+JSON.stringify(request));
     	var formData;
        formData = new FormData();
        formData.append('request', JSON.stringify(request));
        formData.append('file', $('#stolenMobileInvoice')[0].files[0]);
        formData.append('nidFileName', $('#stolenOwnerNIDfile')[0].files[0]);
        formData.append('firCopy', $('#deviceFirCopy')[0].files[0]);
        formData.append('otherDocument', $('#stolenOwnerOtherDoc')[0].files[0]);
        var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': token
		}
	});
	$.ajax({
		url: './approvePoliceRequest',
		type: 'POST',
		data: formData,
        processData: false,
        contentType: false,
		async: false,
		success: function(response, textStatus, jqXHR) {
			console.log(JSON.stringify(response));

              if(response.statusCode==='200'){
              $('#approveMOIAdminModal').openModal({
                                  dismissible: false
                                });
              }
            },
		error: function(jqXHR, textStatus, errorThrown) {
			//console.log("error in ajax")
		}
	});

	return false;

};


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
		}
}

function redirectToPolice(){
window.location.href="./policeTrackLostDevice";
}

function validationTAC(imei1, imei2, imei3, imei4) {
    // Filter out empty or null IMEI values and ensure that the remaining IMEIs are at least 8 characters long
    const imeis = [imei1, imei2, imei3, imei4].filter(imei => imei && imei.length >= 8);

    // If the array has no valid IMEIs, return false
    if (imeis.length === 0) return false;

    // Extract the first 8 digits of the first valid IMEI
    const first8Digits = imeis[0].substring(0, 8);

    // Check if all remaining IMEIs start with the same 8 digits
    const allMatch = imeis.every(imei => imei.substring(0, 8) === first8Digits);

    return allMatch;
}

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


// Function to check if all digits are 0
function allZeroes(input) {
   console.log("new function==");
    return /^0+$/.test(input);
}


document.querySelector('.custom-file-button').addEventListener('click', function() {
               document.getElementById('stolenMobileInvoice').click();
});
document.querySelector('.NidFile').addEventListener('click', function() {
               document.getElementById('stolenOwnerNIDfile').click();
});
document.querySelector('.OtherDoc').addEventListener('click', function() {
               document.getElementById('stolenOwnerOtherDoc').click();
});

           // Update custom button text when a file is selected
document.getElementById('stolenMobileInvoice').addEventListener('change', function() {
               var fileName = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
               document.getElementById('file-name').textContent = fileName;
});
document.getElementById('stolenOwnerNIDfile').addEventListener('change', function() {
               var fileName1 = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
              document.getElementById('file-nameNid').textContent = fileName1;

});
document.getElementById('stolenOwnerOtherDoc').addEventListener('change', function() {
               var fileName2 = this.files[0] ? this.files[0].name : ''; // If file selected, show name; else, show "Choose File" in Khmer
               document.getElementById('file-nameNidOther').textContent = fileName2;

});


function disableForm() {
    const form = document.getElementById("stolenFormID");
    const elements = form.elements; // Get all elements in the form

    for (let i = 0; i < elements.length; i++) {
        elements[i].disabled = true; // Disable each element
    }
}

// Call disableForm() when you need to disable the form
