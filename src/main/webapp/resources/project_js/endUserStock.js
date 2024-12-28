$('#langlist').on('change', function() {
	lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	var url_string = window.location.href;
	var url = new URL(url_string);
	var type = url.searchParams.get("reportType");

	window.location.assign("uploadAstock?reportType="+type+"&lang="+lang);			
	}); 
$('#langlistHeader').on('change', function() {
	lang=$('#langlistHeader').val() == 'km' ? 'km' : 'en';
	var url_string = window.location.href;
	var url = new URL(url_string);
	var type = url.searchParams.get("reportType");
	
	window.location.assign("uploadAstock?reportType="+type+"&lang="+lang);			
	}); 




$(document).ready(function () {
	$('#langlist').val(data_lang_param);
	$('#langlistHeader').val(data_lang_param);
	$.i18n().locale = data_lang_param;
	var successMsg;
	$.i18n().load( {
		'en': './resources/i18n/en.json',
		'km': './resources/i18n/km.json'
	} ).done( function() { 
	});

        if($('#pageTypeValue').val()==0)
        	{
        	$('#uploadPaidStatusDiv').css("display", "block");
        	$('#checkUploadStatusDiv').css("display", "none");
        	}
        else
        {
        	$('#uploadPaidStatusDiv').css("display", "none");
        	$('#checkUploadStatusDiv').css("display", "block");
        }

        });
    
function uploadEndUserStock()
{
	$('div#initialloader').fadeIn('fast');
	var formData= new FormData();
	 var endUsercsvUploadFile=$('#endUsercsvUploadFile').val();
	 var endUseremail=$('#endUseremail').val();
	 var endUserquantity=$('#endUserquantity').val();
	 var endUserDevicequantity= $('#endUserDevicequantity').val();
	 var request={
		  "quantity": endUserquantity,
		  "deviceQuantity":endUserDevicequantity,
		   "userType": "End User",
		   "user": {
		       "userProfile": {
		           "email": endUseremail
		          },
		 },
	
	 };
	    formData.append('file', $('#endUsercsvUploadFile')[0].files[0]);
		formData.append("request",JSON.stringify(request));
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: './ednUserStockUpload',
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function (data, textStatus, jqXHR) {
				$('div#initialloader').delay(300).fadeOut('slow');
				//////console.log("in suucess method");
				//////console.log(data);
				$('#endUserStockModal').openModal({
	    	    	   dismissible:false
	    	       });
				$("#endUserStock").prop('disabled', true);
				if(data.errorCode==0){
					$('#endUsertXnId').text(data.txnId);
				}
				else{
					$('#sucessMessageId').text('');
					$('#sucessMessageId').text(data.message);
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//////console.log("error in ajax")
				$('div#initialloader').delay(300).fadeOut('slow');
			}
		});
		return false;	
		
}

function validateTxnId()
{
	var txnId=$('#checktransactionID').val();
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./fetchUploadAstock?txnId="+txnId,
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		success : function(data) {
			//////console.log(data)
			setViewPopupData(data);
		},
		error : function() {
		$('#errorModal').openModal({
	    	   dismissible:false
	       });
		}
	});
    return false;
}



function setViewPopupData(data){
	//////console.log("_________________++++++++++"+data)
   /* $("#viewStockModal").openModal();*/
	$('#singleInput').css("display", "none");
	$('#inputDetails').css("display", "block");
	$("#transactionID").val(data.txnId);
	$("#uploadDate").val(data.createdOn);
	$("#viewEndUserEmail").val(data.user.userProfile.email);
	if(data.user.userProfile.email=="" || data.user.userProfile.email==null){
		$("#viewEndUserEmail").val("NA");	
	}
	$("#viewEndUserquantity").val(data.quantity);
	$("#viewEdUserDevicequantity").val(data.deviceQuantity);
	$("#viewUploadFile").val(data.fileName);
	$("#errorFileStatus").val(data.stateInterp);
	$('#endUserStockFileLink').attr("onclick",'fileDownload("'+data.fileName+'","actual","'+data.txnId+'","DEFAULT")');
	$('#errorFileStock').attr("onclick",'fileDownload("blank","error","'+data.txnId+'","DEFAULT")');
	//////console.log(data.stockStatus);
	if(data.stockStatus=='2')
		{
		//////console.log("if condition");
		$('#errorFileStatusDiv').css("display", "block");
    	$("#errorFileName").val(data.txnId+'_error.csv');
    	$('#updateEndUserStockOK').css("display", "block");
    	$('#updateEndUserStock').css("display", "block");
    	}
	else if(data.stockStatus=='3'){
		//////console.log("else condition");
		$('#errorFileStatusDiv').css("display", "none");
		$('#updateEndUserStockOK').css("display", "block");
		$('#updateEndUserStock').css("display", "none");
	}
	else {
		//////console.log("else condition");
		$('#errorFileStatusDiv').css("display", "none");
		$('#updateEndUserStockOK').css("display", "block");
		$('#updateEndUserStock').css("display", "none");
	}
	
	if(data.stockStatus==7)
		{
		$('#stockRemarkDivId').css("display", "block");
		$("#stockRemark").val(data.remarks);
		}
}

function endUserStockFileDownload(){
	var fileName=$("#viewUploadFile").val();
	var txnId=$("#transactionID").val();
	window.location.href=contextpath+"/Consignment/dowloadFiles/actual/"+fileName+"/"+txnId+"/DEFAULT";
	
	//.//Consignment%20(18).csv/C20200121142445617/DEFAULT
}

function endUserStockErrorFileDownload(){
	var fileName=$("#errorFileName").val();
	var txnId=$("#transactionID").val();
	window.location.href=contextpath+"/Consignment/dowloadFiles/actual/"+fileName+"/"+txnId+"/DEFAULT";
	
	//.//Consignment%20(18).csv/C20200121142445617/DEFAULT
}

function updateFile()
{
	var txnId=$("#transactionID").val();
	
	var formData= new FormData();
	formData.append('file', $('#csvUploadFile')[0].files[0]);
	formData.append('txnId',txnId);
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'updateUploadedAstock',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {

			////////console.log(data);
			$('#fileUpdateSucessModal').openModal({
 	    	   dismissible:false
 	       });
			if(data.errorCode=='0')
				{
			$('#endUserStockSuceesMessage').text('');
			$('#endUserStockSuceesMessage').text('File Updated Successfully');
				}
			else{
				$('#endUserStockSuceesMessage').text('');
				$('#endUserStockSuceesMessage').text(data.message);
			}
			/*	if(data.errorCode==200){

				$('#stockSucessMessage').text('');
				$('#stockSucessMessage').text(operationNotAllowed);
			}
			else if (data.errorCode==0){
				$('#stockSucessMessage').text('');
				$('#stockSucessMessage').text(updateMsg+' '+(data.txnId)+' '+hasBeenUpdated);
			}
			else{
				$('#stockSucessMessage').text('');
				$('#stockSucessMessage').text(errorOccured);
			}*/
//			$('#updateConsignment').modal('open'); 
//			alert("success");

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});
return false;
}




function  openCancelPopUp()
{
	 $('#cancelStock').openModal({
  	   dismissible:false
     });
}

function  closeCancelPopUp()
{
	 $('#cancelStock').closeModal();
}



function fileTypeValueChanges(dd, ddd) {
	var uploadedFileName = $("#endUsercsvUploadFile").val();
	uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
	var ext = uploadedFileName.split('.').pop();
	
	var fileSize = ($("#endUsercsvUploadFile")[0].files[0].size);
	fileSize = (Math.round((fileSize / 1024) * 100) / 100)
   if (uploadedFileName.length > 30) {
       $('#fileFormateModal').openModal({
    	   dismissible:false
       });
      
   } 
	else if(ext!='csv')
		{
	
		  $('#fileFormateModal').openModal({
	    	   dismissible:false
	       });
		 
		}
	else if(fileSize>='10000'){
				$('#fileFormateModal').openModal({
	    	   dismissible:false
	       });
		
	}
	
	

}


function clearFileName() {
	$('#endUsersaveFileName').val('');
	$("#endUsercsvUploadFile").val('');
	$('#fileFormateModal').closeModal();
}