var featureId = $("body").attr("data-featureid");
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
var startdate=$('#startDate').val(); 
var endDate=$('#endDate').val();

var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
$.i18n().locale = lang;
$.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
}).done(function() {
});

/*$('#langlist').on('change', function() {
	var selectedLanguage = document.getElementById('langlist').value;
    // Get selected language
    window.location.href ='?lang='+ selectedLanguage;
});*/
var documenttype,selectfile,selectDocumentType;
$(document).ready(function() {
  /*  $('#cc-cancel-btn').on('click', function(event) {
       	event.preventDefault(); // Prevent form submission if it's in a form
        //handleSubmit(); // Call your function
        $('#ccRequestID').val('');
        $('#ccContactNumber').val('');
        
    });*/
     $('#newContactNumber').focus(function() {
       // Clear the text box value
       $(this).val('');
       $("#errorInvalidNumber").hide();
    });
    $('#remarks').focus(function() {
       // Clear the text box value
       //$(this).val('');
       $("#errorRemarks").hide();
    });
    $('div#initialloader').fadeIn('fast');
	documenttype=$.i18n('documenttype');
	selectfile=$.i18n('selectfile');
	selectDocumentType=$.i18n('selectDocumentType');
	$("#ccRequestID").prop("readonly", false);
    $("#ccContactNumber").prop("readonly", false);
    $("#errorInvalidNumber").hide(); 
});

var role = currentRoleType == null ? roleType : currentRoleType;

//**************************************************Customere care Change Contact Number Device table**********************************************

function submitNewContactNumber() {
 	const requestId = $('#ccRequestID').val();
    const oldContactNumber = $('#ccContactNumber').val();
    
	  // Example verification logic (replace with actual logic)
    if (!requestId || !oldContactNumber) {
        alert('Please fill in all required fields.');
       return false;
    }
     const newContactNumber = $('#newContactNumber').val();
     const remarks = $('#remarks').val();
     
		/*if (!newContactNumber) {
            $("#errorInvalidNumber").show(); 
            return false;
        }*/
        if (!remarks) {
            $("#errorRemarks").show(); 
            return false;
        }
        // Example submission logic (replace with actual logic)
        if (!newContactNumber || !remarks) {
            alert('Please fill in all required fields.');
            return false;
        }
    // Prepare request object
    var lang = $('#langList').val();
    var request ={
			"requestNo": requestId,
        	"msisdn": newContactNumber,
        	"remarks": remarks,
        	"userId": parseInt(userId),
        	"featureId": parseInt(featureId),
        	"userTypeId": parseInt($("body").attr("data-userTypeID")),
        	"userType": $("body").attr("data-roleType"),
        	"userName": $("body").attr("data-selected-username"),
        	"lang": lang
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
				url: './cc-update-contact-number',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
					//alert("Success : "+data.errorCode);
					var statusCode = data.errorCode;
					if (statusCode === 200) {
                		$("#errorInvalidNumber").hide(); 
                		$("#old-number-verification-btn").hide(); 
                		$("#ccRequestID").prop("readonly", true);
                		$("#ccContactNumber").prop("readonly", true);
                		
                		$("#acceptedMsgModal").show();
                		$("#InvalidRecordNotFound").hide(); 
                		$("#main-content-container").hide();
                		return false;
                		
            		} else if (statusCode === 500) {
                		$("#errorInvalidNumber").show(); 
                		$("#ccRequestID").prop("readonly", true);
                		$("#ccContactNumber").prop("readonly", true);
                		return false;
                	} else if (statusCode === 201) {
						$("#main-content-container").hide();
                		$("#UnderProcessId").show(); 
                		
                		$("#ccRequestID").prop("readonly", true);
                		$("#ccContactNumber").prop("readonly", true);
                		return false;	
            		}else{
						$("#errorInvalidNumber").show(); 
                		$("#ccRequestID").prop("readonly", true);
                		$("#ccContactNumber").prop("readonly", true);
                		return false;
            		}
				
				},
				error: function (jqXHR, textStatus, errorThrown) {
					$("#errorInvalidNumber").show(); 
                	$("#ccRequestID").prop("readonly", true);
                	$("#ccContactNumber").prop("readonly", true);
                	return false;
				}
			});	
    return false;    
}
function verifyOldContactNumber() {
	
 	const requestId = $('#ccRequestID').val();
    const oldContactNumber = $('#ccContactNumber').val();
	  // Example verification logic (replace with actual logic)
    if (!requestId || !oldContactNumber) {
        alert('Please fill in all required fields.');
       return false;
    }
    
    // Prepare request object
    var lang = $('#langList').val();
    var request ={
			"requestNo": requestId,
        	"msisdn": oldContactNumber,
        	"userId": parseInt(userId),
        	"featureId": parseInt(featureId),
        	"userTypeId": parseInt($("body").attr("data-userTypeID")),
        	"userType": $("body").attr("data-roleType"),
        	"userName": $("body").attr("data-selected-username"),
        	"lang": lang
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
				url: './cc-verify-request-number',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
					//alert("Success : "+data);
					var statusCode = data.errorCode;
					if (statusCode === 200) {
                		$("#btn-view-success").show(); 
                		$("#old-number-verification-btn").hide(); 
                		$("#ccRequestID").prop("readonly", true);
                		$("#ccContactNumber").prop("readonly", true);
                		$("#new-number-form").show();
                		$("#RecordNotFound").hide(); 
                		return false;
                		
            		} else if (statusCode === 500) {
                		$("#new-number-form").hide();
                		$("#btn-view-success").hide(); 
                		$("#main-content-container").hide(); 
                		$("#RecordNotFound").show(); 
                		$("#ccRequestID").prop("readonly", false);
                		$("#ccContactNumber").prop("readonly", false);
                		return false;
                		
            		} else{
	
                		$("#new-number-form").hide(); 
                		$("#btn-view-success").hide(); 
                		$("#main-content-container").hide(); 
                		$("#RecordNotFound").show(); 
                		$("#ccRequestID").prop("readonly", false);
                		$("#ccContactNumber").prop("readonly", false);
                		return false;
                		
            		}
				
				},
				error: function (jqXHR, textStatus, errorThrown) {
					//alert(jqXHR.status);
					if(jqXHR.status  === 500){
						$("#main-content-container").hide(); 
						$("#InternalServerError").show();
					}else{
						$("#main-content-container").hide(); 
						$("#RecordNotFound").show();
					}
					
					return false; 
				}
			});	
    return false;    
}


function viewDetails(){
	const requestId = $('#ccRequestID').val();
    const oldContactNumber = $('#ccContactNumber').val();
    // Display the details based on the entered Request ID and Old Contact Number
    //alert(`Request ID: ${requestId}\nOld Contact Number: ${oldContactNumber}`);
    // You can replace the alert with actual logic to display details.
	 /*var tempId=requestId;*/
		if(requestId==null || requestId=="" || requestId==''){
			$("#noRecordMessage").openModal({
						 	   dismissible:false
						    });
			return false;
		}
		var request ={
				"requestId" : requestId,
				"userId": parseInt(userId),
				"featureId":parseInt(featureId),
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
				url: './change-contact-no-view',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						/*var result = data
						console.log(JSON.stringify(result));
						$("#ViewTrackLostDeviceModel").openModal({
						 	   dismissible:false
						    });
						    setData(result);*/
						 var result = data
						console.log(JSON.stringify(result));
						if(result.requestMode=="Bulk"){
							$("#ViewBulkLostDeviceModel").openModal({
						 	   dismissible:false
						    });
						    setBulkData(result);
						    $('#requestNo1').val(tempId);
							
						}else{
							$("#ViewTrackLostDeviceModel").openModal({
						 	   dismissible:false
						    });
						     setData(result);
						    $('#requestNo1').val(tempId);
						}
				
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

function setBulkData(stolenData){
		console.log(" stolenData=="+stolenData.imei1);
		var stolenDate=stolenData.deviceLostDdateTime.substring(0,10);
		var stolentime=stolenData.deviceLostDdateTime.substring(11);
		var OtpContactNumber=stolenData.contactNumberForOtp.substring(3,13);
		
		chooseNationalityBulk(stolenData.deviceOwnerNationality);
		document.getElementById('fileNameBulksEdit').textContent = stolenData.fileName;
		document.getElementById('fileNameBulkEdit').setAttribute('href', stolenData.firCopyUrl+stolenData.requestId+"/"+stolenData.fileName);
		document.getElementById('fileBulkName').textContent = stolenData.mobileInvoiceBill;
		
		$('#stolenMgmtidBulk').val(stolenData.id);
		$('#stolenMgmtRequestidBulk').val(stolenData.requestId);
		
		 $('#stolenDateBulk').val(stolenData.deviceLostDdateTime);
		 $('#stolenDeviceBrandBulk').val(stolenData.deviceBrand);
		 $('#stolenDeviceModelBulk').val(stolenData.deviceModel);
		 $('#stolenDateBulk').val(stolenDate);
		 $('#stolenTimeBulk').val(stolentime);
		 $('#stolenOwnerBulk').val(stolenData.deviceOwnerName);
		 $('#stolenEmailBulk').val(stolenData.deviceOwnerEmail);
		 $('#stolenOwnerAddress1Bulk').val(stolenData.deviceOwnerAddress);
		 $('#stolenOwnerAddress2Bulk').val(stolenData.deviceOwnerAddress2);
		 $('#stolenOwnerNIDBulk').val(stolenData.deviceOwnerNationalID);
		 $('#stolenOwnerOTPContactBulk').val(OtpContactNumber);
		 $('#ownerNationalityBulk').val(stolenData.deviceOwnerNationality);
		 $('#provinceCityBulk').val(stolenData.province);
		 $('#districtBulk').val(stolenData.district);
		 $('#communeBulk').val(stolenData.commune);
		 $('#ownerDOBBulk').val(stolenData.ownerDOB);
		 $('#stolenOtpEmailBulk').val(stolenData.otpEmail);
		 $('#stolenOwnerPassportBulk').val(stolenData.passportNumber);
		 $('#categoryBulk').val(stolenData.category);
		 $('#policeStationBulk').val(stolenData.policeStation);
		 $('#stolenDeviceTypeBulk').val(stolenData.deviceType);
		 $('#stolenSerialNumberBulk').val(stolenData.serialNumber);
		 $('#stolenIncidentBulk').val(stolenData.incidentDetail);
		 $('#requestNo1Bulk').val(stolenData.requestId);
		 $('#fileNameEditBulk').val(stolenData.mobileInvoiceBill);
		 $('#fileNameEdit2Bulk').val(stolenData.deviceOwnerNationalIdUrl);
		 $('#stolenPreviewIDBulk').attr("onclick",'previewStolenFile1("'+stolenData.firCopyUrl+'","'+stolenData.mobileInvoiceBill+'","'+stolenData.requestId+'")');
		 $('#stolenPreviewID2Bulk').attr("onclick",'previewStolenFile2("'+stolenData.firCopyUrl+'","'+stolenData.deviceOwnerNationalIdUrl+'","'+stolenData.requestId+'")');		
		
}
function setData(stolenData){
		console.log(" stolenData=="+stolenData.imei1);
		var stolenDate=stolenData.deviceLostDdateTime.substring(0,10);
		var stolentime=stolenData.deviceLostDdateTime.substring(11);
		var OtpContactNumber=stolenData.contactNumberForOtp.substring(3,13);
		chooseNationality(stolenData.deviceOwnerNationality);
		if(stolenData.requestMode=="Bulk"){
			document.getElementById('fileNameBulksEdit').textContent = stolenData.fileName;
			document.getElementById('fileNameBulkEdit').setAttribute('href', stolenData.firCopyUrl+stolenData.requestId+"/"+stolenData.fileName);
			document.getElementById('fileBulkName').textContent = stolenData.mobileInvoiceBill;
		}
		$('#stolenMgmtid').val(stolenData.id);
		$('#stolenMgmtRequestid').val(stolenData.requestId);
		 $('#stolenMobile1').val(stolenData.contactNumber);
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
		 $('#stolenOwnerOTPContact').val(OtpContactNumber);
		 $('#ownerNationality').val(stolenData.deviceOwnerNationality);
		 $('#provinceCity').val(stolenData.province);
		 $('#district').val(stolenData.district);
		 $('#commune').val(stolenData.commune);
		 $('#ownerDOB').val(stolenData.ownerDOB);
		 $('#stolenOtpEmail').val(stolenData.otpEmail);

		 $('#stolenOwnerPassport').val(stolenData.passportNumber);
		 if(stolenData.category===1){$('#category').val("Lost");}
		 else{$('#category').val("Stolen");}

		 $('#policeStation').val(stolenData.policeStation);
		 
		 $('#stolenDeviceType').val(stolenData.deviceType);
		 $('#stolenSerialNumber').val(stolenData.serialNumber);
		 $('#stolenIncident').val(stolenData.incidentDetail);
		 $('#requestNo1').val(stolenData.requestId);
		 
		 $('#fileNameEdit').val(stolenData.mobileInvoiceBill);
		 $('#fileNameEdit2').val(stolenData.deviceOwnerNationalIdUrl);
		 $('#stolenPreviewID').attr("onclick",'previewStolenFile2("'+stolenData.firCopyUrl+'","'+stolenData.mobileInvoiceBill+'","'+stolenData.requestId+'")');
		 $('#stolenPreviewID2').attr("onclick",'previewStolenFile2("'+stolenData.firCopyUrl+'","'+stolenData.deviceOwnerNationalIdUrl+'","'+stolenData.requestId+'")');
}

function setApproveData(result){
	$('#viewDetectionDate').val(result.edrTime);
	$('#viewIMEI').val(result.imei);
	$('#viewPhoneNumber').val(result.msisdn);
	$('#viewUpdatedBy').val(result.updatedBy);
	$('#viewStatus').val(result.status);
	
	
}


$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});


function previewStolenFile1(srcFilePath,srcFileName,txnId,doctype){
	////console.log("doctype=="+doctype)
	window.filePath = srcFilePath;
	window.fileName = srcFileName;
	window.fileExtension = fileName.replace(/^.*\./, '');
	if(doctype=='')
	{
		window.FinalLink = filePath.concat(txnId).concat('/'+fileName);
	}
	else if(doctype==undefined)
	{
		window.FinalLink = filePath.concat(txnId).concat('/'+fileName);
	}else{
		window.FinalLink = filePath.concat(txnId).concat('/'+doctype).concat('/'+fileName);
	}
 
	//////console.log(FinalLink);
	if(filePath == null || filePath == "" || filePath == undefined && fileName == null || fileName == "" || fileName == undefined ){
		////console.log("File is not Avialable")
	}else if(fileExtension=="jpg" || fileExtension=="jpeg" || fileExtension=="png" || fileExtension=="gif" || fileExtension=="PNG" ){
		$("#fileSource").attr("src",FinalLink);
		$("#viewuplodedModel").openModal({dismissible:false});
	}else{
		window.open(FinalLink);
	}
}
 
 
function previewStolenFile2(srcFilePath,srcFileName,txnId,doctype){
	////console.log("doctype=="+doctype)
	window.filePath = srcFilePath;
	window.fileName = srcFileName;
	window.fileExtension = fileName.replace(/^.*\./, '');
	if(doctype=='')
	{
		window.FinalLink = filePath.concat(txnId).concat('/'+fileName);
	}
	else if(doctype==undefined)
	{
		window.FinalLink = filePath.concat(txnId).concat('/'+fileName);
	}else{
		window.FinalLink = filePath.concat(txnId).concat('/'+doctype).concat('/'+fileName);
	}
 
	//////console.log(FinalLink);
	if(filePath == null || filePath == "" || filePath == undefined && fileName == null || fileName == "" || fileName == undefined ){
		////console.log("File is not Avialable")
	}else if(fileExtension=="jpg" || fileExtension=="jpeg" || fileExtension=="png" || fileExtension=="gif" || fileExtension=="PNG" ){
		$("#fileSource").attr("src",FinalLink);
		$("#viewuplodedModel").openModal({dismissible:false});
	}else{
		window.open(FinalLink);
	}
}

function filterReset(formID,action){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	Datatable();
	$('#errorMsg').text('');
}





$("#fileInput").change(function(){
	if($("#fileInput").val()!=""){
		$('#submitButton').removeClass('disabled');
	}
	
});	


function approveDevice(rowId){
	$("#approvefileModal").openModal({
        dismissible:false
    });	
    $('#rowId').text(rowId);
}


function remove_field(fieldId ){
				$('#filediv' + fieldId).remove();
};

function chooseNationality(userNationality){
        console.log("Nationality="+userNationality)
	    if(userNationality==="Non-Cambodian"){
	      console.log("Nationality in if else ="+userNationality)
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


function chooseNationalityBulk(userNationality){
        console.log("Nationality="+userNationality)
	    if(userNationality==="Non-Cambodian"){
	      console.log("Nationality in if else ="+userNationality)
		  $("#ownerDOBlDivBulk").css("display", "block");
		  $("#ownerEmailDivBulk").css("display", "none");
		  $("#ownerPassportDivBulk").css("display", "block");
		  $("#ownerNIDdivBulk").css("display", "none");
		  $("#otpEmailDivBulk").css("display", "block");
		  $("#otpContactDivBulk").css("display", "none");
		  $("#NIDblockLabelDiv").css("display", "none");
		  $("#PassportblockLabelDiv").css("display", "block");
		  document.getElementById("stolenOtpEmail").required = true;
		  document.getElementById("stolenOwnerOTPContact").required = false;
		  document.getElementById("stolenEmailBulk").required = false;
		  document.getElementById("stolenOwnerNID").required = false;
        }
		else{
			$("#ownerDOBlDivBulk").css("display", "none");
		  $("#ownerEmailDivBulk").css("display", "block");
		  $("#ownerPassportDivBulk").css("display", "none");
		  $("#ownerNIDdivBulk").css("display", "block");
		  $("#otpEmailDivBulk").css("display", "none");
		  $("#otpContactDivBulk").css("display", "block");
		  $("#PassportblockLabelDiv").css("display", "none");
		  $("#NIDblockLabelDiv").css("display", "block");
		  document.getElementById("stolenOtpEmail").required = false;
		  document.getElementById("stolenOwnerOTPContact").required = true;
		  document.getElementById("stolenEmailBulk").required = true;
		}
}

 function closeModalReferenc(id){
	
}

