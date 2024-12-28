
function deviceApprovalPopup(imei,date,txnId){
	$('#approveInformation').openModal({dismissible:false});
	window.imei=imei;
	window.date=date.replace("="," ");
	$('#approveTxnId').text(txnId);
}   


function aprroveDevice(){

	var approveRequest={
			"action" : 0,
			"imei1": window.imei,
			"featureId":parseInt(featureId),
			"remarks": "",
			"roleTypeUserId": parseInt($("body").attr("data-userTypeID")),
			"userId":parseInt($("body").attr("data-userID")),
			"userType": $("body").attr("data-roleType")	  	
	}

	$.ajax({
		url : './approveVisaUpdateRequest',
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		'async' : false,
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {

			if(data.errorCode==0){
				confirmApproveInformation(window.imei,window.date);

			}

		},
		error : function() {
			////console.log("Failed");

		}
	});
}

function confirmApproveInformation(imei,date){
	$('#approveInformation').closeModal(); 
	setTimeout(function(){ $('#confirmApproveInformation').openModal({dismissible:false});}, 200);
}



function userRejectPopup(imei,txnId){
	$('#rejectInformation').openModal({dismissible:false});
	$('#disapproveTxnId').text(txnId)
	window.imei=imei;
}



function rejectUser(){
	
	var rejectRequest={
			"action" : 1,
			"imei1": window.imei,
			"featureId":parseInt(featureId),
			"remarks": $("#Reason").val(),
			"roleTypeUserId": parseInt($("body").attr("data-userTypeID")),
			"txnId": "",
			"userId":parseInt(userId),
			"userType": $("body").attr("data-roleType")	  	
	}
	$.ajax({
		url : './approveVisaUpdateRequest',
		data : JSON.stringify(rejectRequest),
		dataType : 'json',
		'async' : false,
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {

			if(data.errorCode==0){
				confirmRejectInformation();

			}

		},
		error : function() {
			////console.log("Failed");
		}
	});
	return false;
}



function confirmRejectInformation(){
	$('#rejectInformation').closeModal();
	setTimeout(function(){$('#confirmRejectInformation').openModal({dismissible:false});},200);
}
