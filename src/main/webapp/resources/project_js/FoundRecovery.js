/**
 * 
 */
 
  var otpVerifyLimit=3;
 var otpTry=1;
 var timeLeft;
 var requestIDtime=0;
 var contactNotime=0;
 	var elem;
 	var timerId ;
 $.getJSON('./getDropdownList/recovery_reason', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interpretation)
				.appendTo('#recoveryReason');
				//////console.log("...........");
			}
		});
		
		
		$('div#initialloader').delay(500).fadeOut('slow');
		
		
 function submitRecoveryDeviceRequest(){

	var recaptcha=$("#g-recaptcha-response").val();
		if(recaptcha===""){
			
 		   $("#errorMsgOnModal").css("display", "block");
 		   return false;
 		}
		$('div#initialloader').fadeIn('fast');
		$("#recoveryFoundButton").prop('disabled', true);
		var recoveryRequestID=$('#recoveryRequestID').val();
		var recoverycontactNumber=$('#recoverycontactNumber').val();
		var request={
			"requestId":recoveryRequestID,
			"contactNumber":recoverycontactNumber,
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
				url: './recoveryFoundSave',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function (data, textStatus, jqXHR) {
					console.log("sucess------&&&&--"+JSON.stringify(data.data));
					var statusCode=data.statusCode;
					
					if(statusCode=="200")
					{
						console.log("going to call datatable code");
					
						$('div#initialloader').delay(500).fadeOut('slow');
						$("#RecoveryFormBlock").css("display", "none");
						$("#blockedDatatable").css("display", "block");
					
						 var table = $('#data-table').DataTable({
                          data: data.data,
           					 columns: [
                				{ data: 'id' },
                				{ data: 'createdOn' },
               					{ data: 'requestId' },
             				    { data: 'contactNumber' },
                                { data: 'requestType' },
                                { data: 'status' },
                                {
                				    // Action column for unblock icon
                  				  data: 'requestId',
                  				  render: function(data, type, row) {
                   			      return '<button class="unblock-btn"  data-id="' + row.id + '">Unblock</button>';
                   						 }
                				}
             	                 
                // Add more columns as needed
            ]
        });
					}
					else if(statusCode=="201"){
						
						 //$("#invalidPairBlock").css("display", "block");
						 var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						// modalBackdrop.style.display = "block";
						 $('#invalidPairBlock').openModal({dismissible:false});
						 $("#recoveryFoundButton").prop('disabled', false);
						 
						 
						  $('div#initialloader').delay(500).fadeOut('slow');
					}
					else if(statusCode=="202"){
						
						var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						// modalBackdrop.style.display = "block";
						 $('#alreadyUnBlocked').openModal({dismissible:false});
						 $("#recoveryFoundButton").prop('disabled', false);
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
				"oldRequestID":oldRequestId,
				"requestType":"Recovery"
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
						  $("#RecoveryFormBlock").css("display", "none");
						  $("#verifyRecoveryOtpForm").css("display", "none");
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
	
	
	document.getElementById("resendOTPclick").addEventListener('click',function ()
{
	
    resendOTP();
   }  ); 
   
   
   function closeModal(id){
	$('#'+id).closeModal();
}
			 
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

function enterRequestID(){
	
		  $('#recoverycontactNumber').val('');
		  $("#contactNumberLabel").css("display", "none");
		  document.getElementById("recoverycontactNumber").required = false;
		  
}
function enterContactNumber(){
	      $('#recoveryRequestID').val('');
		  $("#requestIDLabel").css("display", "none");
		  document.getElementById("recoveryRequestID").required = false;	
		  $("#contactNumberLabel").css("display", "block");		  
}

 $('#data-table tbody').on('click', '.unblock-btn', function() {
            var rowData = $(this).closest('tr').find('td').map(function() {
                return $(this).text();
            }).get();
            // Populate form fields with row data
           setRecoverPageData(rowData[2],rowData[3]);
            // Populate more form fields with other row data as needed
        });
function  setRecoverPageData(unblockRequestId,unblockContactNumber){
	 $("#blockedDatatable").css("display", "none");
	 $("#RecoveryFormBlock2").css("display", "block");
	 $('#unblockContactNumber').val(unblockContactNumber);
     $('#unblockRequestId').val(unblockRequestId);
     
       $("#unblockContactNumber").prop('disabled', true);
       $("#unblockRequestId").prop('disabled', true);
       
	}
	
	function getOTP(){

		$('div#initialloader').fadeIn('fast');
		$("#recoveryFoundButton").prop('disabled', true);
		var recoveryRequestID=$('#recoveryRequestID').val();
		var recoverycontactNumber=$('#recoverycontactNumber').val();
		var request={
			"requestId":recoveryRequestID,
			"contactNumber":recoverycontactNumber,
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
				url: './getOTPRequest',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function (data, textStatus, jqXHR) {
					console.log("sucess------&&&&--"+JSON.stringify(data.data));
					var statusCode=data.statusCode;
					
					if(statusCode=="200")
					{
						console.log("open otp verification screen");
					
					}
					else if(statusCode=="201"){
						console.log("unblock request is already  registered");
						 var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						 $('#invalidPairBlock').openModal({dismissible:false});
						 $("#recoveryFoundButton").prop('disabled', false);
						 $('div#initialloader').delay(500).fadeOut('slow');
					}
					else if(statusCode=="202"){
						
						var modalBackdrop = document.getElementsByClassName("modalBackdrop")[0];
						// modalBackdrop.style.display = "block";
						 $('#alreadyUnBlocked').openModal({dismissible:false});
						 $("#recoveryFoundButton").prop('disabled', false);
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