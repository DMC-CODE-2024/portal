//var featureId = 112;
var featureId = $("body").attr("data-featureId");
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType");
var transactionId = $("body").attr("data-transactionId");
var creationDate = $('#filterCreatedDate').val();
var updatedDate = $('#filterUpdatedDate').val();

$.i18n().locale = "en";
var documenttype,selectfile,selectDocumentType;

$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	Datatable();
	//PageRendering();
	documenttype=$.i18n('documenttype');
	selectfile=$.i18n('selectfile');
	selectDocumentType=$.i18n('selectDocumentType');
});

var role = currentRoleType == null ? roleType : currentRoleType;

 var otpVerifyLimit=3;
 var otpTry=1;
 var resendCount=1;
 var timeLeft;
 var elem;
 var timerId ;

var userName="system";
/*var roleType=23;
var userId = 2;//parseInt($("body").attr("data-userID"));*/
var request="bulkimei";

//**************************************** stolenIMEIStatus Device Table **********************************************

function Datatable(lang){
	$('div#initialloader').fadeIn('fast');
    var request ={
    				"transactionId" :  transactionId,
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
    				url: './viewStolenImeiDetail',
    				type: 'POST',
    				data : JSON.stringify(request),
    				dataType : 'json',
    				contentType : 'application/json; charset=utf-8',
    				success: function (data, textStatus, jqXHR) {
    						var result = data.data
    						////console.log(JSON.stringify(result));
    						//getRedmineDocs(ticketId);
                            initializeDataTable(result);

    			$('div#initialloader').delay(300).fadeOut('slow');

    				},
    				error: function (jqXHR, textStatus, errorThrown) {
    					////////console.log("error in ajax")
    				}
    			});


};


function initializeDataTable(data) {
    destroyDataTable("LibraryTable");

    //var transactionId  = data[0].transactionId;
    $('#LibraryTable').DataTable({
		"searching": false,
		"bPaginate": false,
		"bInfo" : false,
		"ordering": false,
		"language": {
                 "sEmptyTable": "No records found in the system",
                 "infoFiltered": ""
         },
          "data": data,
                 "columns": [
                     { "data": "requestId", "title": "Request ID" },
                     { "data": "contactNumber", "title": "Contact Number" },
                     { "data": "deviceOwnerName", "title": "Name" },
                     { "data": "count", "title": "Recovery IMEI Count" },
                     { "data": "requestMode",
                        "title": "Action",
                         "render": function(data, type, row) {
                                                         // Define action URLs or functions
                                                         var viewAction = "viewStolenDeviceByTransactionId('" + row.requestId + "', '" + row.contactNumber + "', '" + row.count + "')";
                                                         var initiateRecoveryAction = "initiateRecoveryMode('" + row.requestId + "','" + row.requestMode + "')";
                                                         var notificationAction = "sendNotification('" + row.requestId + "','" + row.requestMode + "','" + row.contactNumber + "')";
                                                         //var deleteAction = "confirmDelete('" + row.requestId + "')";


                                                         return '<div class="dropdown">' +
                                                             '<a class="nav-link dropdown-toggle text-center p-0" href="#" id="navbardrop" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v" aria-hidden="true"></i></a>' +
                                                             '<div class="dropdown-menu dropdown-menu-right">' +
                                                                 '<a onclick="' + viewAction + '" class="dropdown-item">' +
                                                                     '<img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid" style="width: auto;"> View' +
                                                                 '</a>' +
                                                                 '<a onclick="' + initiateRecoveryAction + '" class="dropdown-item" href="#">' +
                                                                     '<img src="./resources/assets/images/InitiateRecovery.svg" alt="icon" class="img-fluid"> Initiate Recovery' +
                                                                 '</a>' +
                                                                 '<a onclick="' + notificationAction + '" class="dropdown-item" href="#">' +
                                                                     '<img src="./resources/assets/images/RecoveryNotification.svg" alt="icon"> Send Recovery Notification' +
                                                                 '</a>' +
                                                                 /*'<a onclick="' + deleteAction + '" class="dropdown-item" href="#" data-toggle="modal" data-target="#deleteModal">' +
                                                                     '<img src="./resources/assets/images/delete-icon.svg" alt="icon" class="img-fluid"> Delete' +
                                                                 '</a>' +*/
                                                             '</div>' +
                                                         '</div>';
                                                     }
                                 }
                 ]
	});
};


function destroyDataTable(tableId) {
	if ($.fn.DataTable.isDataTable('#'+tableId)) {
	$('#'+tableId).DataTable().destroy();
	}
}



let newRequestId;
let initiateRequestMode;

function initiateRecoveryMode(requestId,requestMode){
    if(requestMode.toLowerCase() === "single"){
          initiateRecovery(requestId,requestMode,'./initialRecovery-single');
    }else{
          initiateRecovery(requestId,requestMode,'./initialRecovery-bulk')
    }
}

function initiateRecovery(requestId,requestMode,URL){
    $('div#initialloader').fadeIn('fast');
    var stolenRequest ={
        				"requestType" :  requestMode,
        				"requestId" :  requestId,
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
        				url: URL,
        				type: 'POST',
        				data : JSON.stringify(stolenRequest),
        				dataType : 'json',
        				contentType : 'application/json; charset=utf-8',
        				success: function (data, textStatus, jqXHR) {
        						var result = data.data
        						////console.log(" requestId -- " +JSON.stringify(result.requestId));
        						////console.log(" result -- " +JSON.stringify(result));
        						newRequestId = result.requestId;
        						initiateRequestMode = result.requestMode;

        						 $("#contentBox").css("display", "none");
                                 $("#verifyOtpForm").css("display", "block");

                                 if(result.deviceOwnerNationality=="0"){
                                    var mobile=result.contactNumberForOtp.replace(/\d(?=\d{4})/g, "x");
                                    $('#phoneNumberOTP').append(mobile);
                                    $("#phoneNumberOTP").css("display", "block");
                                    $("#emailOTPMsg").css("display", "none");
                                 }else{
                                    var otpEmail=result.otpEmail;
                                         console.log("email=" + otpEmail);

                                        // Clear the content in #emailOTPMsg (if needed)
                                        $('#emailOTPMsg').append('');

                                        // Get the email from the data tag
                                        var userEMail = otpEmail;

                                        // Find the index of '@' and the next '.' after it
                                        var atIndex = userEMail.indexOf('@');
                                        var dotIndex = userEMail.indexOf('.', atIndex);

                                        // Mask the email, leaving the domain part visible
                                        var maskedEmail = 'xxxxx' + userEMail.substring(dotIndex);

                                        // Hide phone number element and show email message element
                                        $("#phoneNumberOTP").css("display", "none");
                                        $("#emailOTPMsg").css("display", "block");

                                        // Append the masked email to the #emailOTPMsg element
                                        $('#emailOTPMsg').append(maskedEmail);

                                        // Get the text content of the email element
                                        const element = document.getElementById("emailOTPMsg");
                                        const text = element.innerText;

                                        // Use regex to remove the repeated part after the email domain
                                        const cleanedText = text.replace(/(xxxxx\.com)(?=\1)/g, '');

                                        // Update the content with the cleaned text (removing the duplicate domain part)
                                        element.innerText = cleanedText;

                                 }

                                 ////console.log("mobile"+result.contactNumberForOtp);


                                  timeLeft = $("body").attr("data-timeout");
                                  elem = document.getElementById('countdown');
                                  timerId = setInterval(countdown, 1000);
                                  countdown();
                                  $('div#initialloader').delay(500).fadeOut('slow');
                                 $('div#initialloader').delay(300).fadeOut('slow');
                        },
        				error: function (jqXHR, textStatus, errorThrown) {
        					////////console.log("error in ajax")
        				}
        			});

};



function sendNotification(requestId,requestMode,contactNumber){
    $('div#initialloader').fadeIn('fast');
        var request ={
        				"transactionId" :  transactionId,
        				"requestId" : requestId,
        				"requestMode" : requestMode,
        				"contactNumber" : contactNumber,
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
        				url: './sendNotification',
        				type: 'POST',
        				data : JSON.stringify(request),
        				dataType : 'json',
        				contentType : 'application/json; charset=utf-8',
        				success: function (data, textStatus, jqXHR) {
        				        var result = data.data
        						////console.log(JSON.stringify(result));
        						//getRedmineDocs(ticketId);
        						$("#notificationSuccessModel").openModal();
                                $('div#initialloader').delay(300).fadeOut('slow');
                        },
        				error: function (jqXHR, textStatus, errorThrown) {
        					$("#notificationFailedModel").openModal();
        				}
        			});
};

function submitOTPRequest(){
            lang=$('#langList').val();
			$.i18n().locale = lang;
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
				  $('#otpExpiredMsgModal3Attempt').openModal({dismissible:false});
				  $("#RequestFormVeriOTP").css("display", "none");
				  $("#verifyotpform").css("display", "none");

				  $('#emailId').val('');
    			  $('#contactnumber').val('');
    			  $('#bulkimeiuploadfine').val('');
    			  $('#reffrenceIdByCirs').val('');
    			  $('#RequestFormVeriOTPButton').prop('disabled', false);
    			  $('#OtpBox1').val('');
				  $('#OtpBox2').val('');
				  $('#OtpBox3').val('');
				  $('#OtpBox4').val('');
				  $('#OtpBox5').val('');
				  $('#OtpBox6').val('');

				  return false;
			}
			$('div#initialloader').fadeIn('fast');
			var otpBox1=$('#OtpBox1').val();
			var otpBox2=$('#OtpBox2').val();
			var otpBox3=$('#OtpBox3').val();
			var otpBox4=$('#OtpBox4').val();
			var otpBox5=$('#OtpBox5').val();
			var otpBox6=$('#OtpBox6').val();
			var otpRequestID=newRequestId;
			var request={
				"otpBox1":otpBox1,
				"otpBox2":otpBox2,
				"otpBox3":otpBox3,
				"otpBox4":otpBox4,
				"otpBox5":otpBox5,
				"otpBox6":otpBox6,
				"requestID":otpRequestID,
				"lang":lang,
				"requestType":initiateRequestMode
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
				//url: './verifyOTPRequest',
				url: './initialVerifyOTPRequest',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function (data, textStatus, jqXHR) {
					//var data = JSON.parse(data);
					////console.log("submitOTPRequest Response"+ JSON.stringify(data));
					//alert(data.toString());
					var statusCode=data.errorCode;
					if(statusCode=="200")
					{
						    ////console.log("--data.txnId---" +data.txnId);
						    $("#unblockRequestId").text(data.txnId);
						    $("#initiateRecoveryModel").openModal();

                            $('div#initialloader').delay(500).fadeOut('slow');

						    //$("#RequestFormVeriOTP").css("display", "block");
						   // $("#RequestFormVeriOTP").css("display", "none");
				  		    //$("#verifyotpform").css("display", "none");
				  		    //$('#RequestFormVeriOTPButton').prop('disabled', false);
					}
					else if (statusCode=="201"){
						//$("#invalidOTP").css("display", "block");
						 var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						// modalBackdrop.style.display = "block";
						 $('#invalidOTP').openModal({dismissible:false});
						  $('div#initialloader').delay(500).fadeOut('slow');
						  	$('#OtpBox1').val('');
				  		  	$('#OtpBox2').val('');
				  			$('#OtpBox3').val('');
				 			$('#OtpBox4').val('');
				  			$('#OtpBox5').val('');
				  			$('#OtpBox6').val('');
						  return false;
					}
					else if (statusCode=="410"){
							/*$('#RequestExpiredOTP').openModal({dismissible:false});
							sleep(7000);
							//location.reload();*/
						   $('#otpExpiredMsgModal').show();
						   $("#RequestFormVeriOTP").css("display", "none");
				  		   $("#verifyotpform").css("display", "none");
						  /* $("#RequestFormVeriOTP").css("display", "block");
				  		   $("#verifyotpform").css("display", "none");*/
				  		    $('#emailId').val('');
    						$('#contactnumber').val('');
    						$('#bulkimeiuploadfine').val('');
    						$('#reffrenceIdByCirs').val('');
    						$('#RequestFormVeriOTPButton').prop('disabled', false);
    						return false;
					}
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////////console.log("error in ajax")

				}
			});
			otpTry++;
			return false;

};


function resendInitiateOTP(){
 //$('div#initialloader').fadeIn('fast');
 //$('#RequestFormVeriOTPButton').prop('disabled', false);
 var formData;
 var otpRequestID=newRequestId;
 lang= "en";
//alert("resendCount in resendInitiateOTP() " +resendCount);

 if(resendCount<4){
    $('#saveConfirmationMessage').openModal({dismissible:false});
    setTimeout(function() {
    $('#saveConfirmationMessage').closeModal({
    dismissible: false
  });
 }, 3000);
}

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
 headers:           { 'X-CSRF-TOKEN': token }
 });
 $.ajax({
 url: './resendOTPRequest',
 type: 'POST',
 data: formData,
 processData: false,
 contentType: false,
 success: function (data, textStatus, jqXHR) {
 //var data = JSON.parse(data);
 ////console.log("sucess"+data);
 var statusCode=data.statusCode;
 if(statusCode=="200")
 {
 ////console.log("++++++++");
 $('#OtpBox1').val('');
 $('#OtpBox2').val('');
 $('#OtpBox3').val('');
 $('#OtpBox4').val('');
 $('#OtpBox5').val('');
 $('#OtpBox6').val('');
 timeLeft = $("body").attr("data-timeout");
 elem = document.getElementById('countdown');
 ////console.log("---"+elem);
 elem.innerHTML = timeLeft;
 timerId = setInterval(countdown, 1000);
 countdown();
 }
 // $('div#initialloader').delay(500).fadeOut('slow');
 },
 error: function (jqXHR, textStatus, errorThrown) {
 //////console.log("error in ajax")
 }
 });

 resendCount++;
 if(resendCount>4){
 $('#otplimitExceedUpdated').openModal({dismissible:false});
 $('#resendOTPclick').css("display", "none");
 $('#resendOTPclick_time').css("display", "none");
 }
 return false;
 }

 document.getElementById("resendOTPclick").addEventListener('click',function (){
 resendInitiateOTP();
 });

/*function digitValidate (input) {
    input.value = input.value.replace(/[^0-9]/g,'');
    };

const inputs = document.getElementById("inputs");inputs.addEventListener("input", function (e) {const target = e.target;const val = target.value;if (isNaN(val)) {target.value = "";return;}if (val != "") {const next = target.nextElementSibling;if (next) {next.focus();}}});*/




function submitRecovery(){
   var {
      requestId,
      recoveryReason,
      remarks,
      deviceLostDateTime,
      province,
      district,
      commune
} = {
      requestId: isEmpty($('#unblockRequestId').text()),
      recoveryReason: isEmpty($('#recoveryReason').val()),
      remarks: isEmpty($('#recoveryRemark').val()),
      deviceLostDateTime: isEmpty($('#recoveryStolenDate').val()),
      province: isEmpty($('#recoveryProvinceCity').val()),
      district: isEmpty($('#recoveryDistrict').val()),
      commune: isEmpty($('#recoveryCommune').val()),
   };

   var stolenRequest = {
      "requestId": requestId,
      "recoveryReason": recoveryReason,
      "remarks": remarks,
      "deviceLostDateTime": deviceLostDateTime,
      "province": province,
      "district": district,
      "commune": commune,
      "requestMode": initiateRequestMode,
      "auditTrailModel": {
         "featureId": parseInt(featureId),
         userTypeId: parseInt($("body").attr("data-userTypeID")),
         "userType": roleType,
         "userName": $("body").attr("data-selected-username"),
         "userId": parseInt($("body").attr("data-userID"))
      }
   };

   var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");
   $.ajaxSetup({
      headers: {
         'X-CSRF-TOKEN': token
      }
   });

   $.ajax({
      url: "./initiateRecoveryForm-single",
      data: JSON.stringify(stolenRequest),
      dataType: 'json',
      contentType: 'application/json; charset=utf-8',
      type: 'POST',
      success: function(data, textStatus, jqXHR) {
         $('#initiateRecoveryModel').closeModal();
         $("#verifyOtpForm").css("display", "none");
         $("#successScreen").css("display", "block");
         //$('#verifyOTPrequestid').append(data.requestID);
         //console.log("data.data.requestId--- " +JSON.stringify(data.data.requestId));
         $("#referenceRequestid").append(data.data.requestId);


      }
   });
   return false;
};



let isEmpty = (x) => {
   if (x == undefined || x == '') {
      return null
   };
   return x;
};


function viewStolenDeviceByTransactionId(requestId,contactNumber,count){
    //console.log("requestId " +requestId+ " with contactNumber " +contactNumber);
    	$('div#initialloader').fadeIn('fast');
        var request ={
        				"requestId" :  requestId,
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
        				url: './viewRecoveredDeviceImeiDetail',
        				type: 'POST',
        				data : JSON.stringify(request),
        				dataType : 'json',
        				contentType : 'application/json; charset=utf-8',
        				success: function (data, textStatus, jqXHR) {
        						var result = data.data
        						//console.log(JSON.stringify(result));
        						$("#viewStolenModal").openModal();
        						setViewData(result,count);

        			      $('div#initialloader').delay(300).fadeOut('slow');

        				},
        				error: function (jqXHR, textStatus, errorThrown) {
        					//////console.log("error in ajax")
        				}
        			});
};


function setViewData(result,count){
    //console.log("inside setViewData result" +JSON.stringify(result));
    $("#viewRecoveryRequestId").val(result[0].requestId);
    $("#viewRecoveryContactNumber").val(result[0].contactNumber);
    $("#viewRecoveryName").val(result[0].deviceOwnerName);
    $("#viewRecoveryAddress").val(result[0].deviceOwnerAddress);
    $("#viewRecoveryCommune").val(result[0].deviceLostCommune);
    $("#viewRecoveryPoliceStation").val(result[0].deviceLostPoliceStation);
    $("#viewRecoveryRequestMode").val(result[0].requestMode);
    $("#viewRecoveryRecordCount").val(count);
    $("#viewRecoveryImeiFoundCount").val(result[0].matchedIMEICount);

    initializeViewDataTable(result);
};


function initializeViewDataTable(responseData) {
   destroyDataTable("viewStolenTable");
       //console.log("map content data " + JSON.stringify(responseData));

       // Extract the map from the response data
       const mapData = responseData[0].map;

       // Prepare the data for DataTable
       const tableData = [];

       // Push the IMEI and its corresponding values to tableData
       for (const [key, value] of Object.entries(mapData)) {
           tableData.push({
               lostImei: key,
               matchedImei: value || 'NA' // Display 'NA' for null values
           });
       }

       $('#viewStolenTable').DataTable({
           "searching": false,
           "bPaginate": false,
           "bInfo": false,
           "ordering": false,
           "language": {
               "sEmptyTable": "No records found in the system",
               "infoFiltered": ""
           },
           "data": tableData,
           "columns": [
               { "data": "lostImei", "title": "Lost/Stolen IMEI List" },
               { "data": "matchedImei", "title": "Matched IMEI List" }
           ]
       });
};

function closeModel(modelId){
    $('#'+modelId).closeModal();
}