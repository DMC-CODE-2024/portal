

$(document).ready(function() {
 // executes when HTML-Document is loaded and DOM is ready

 viewIndivisualStolen()
 
});


function viewIndivisualStolen()
{

	 $('div#initialloader').fadeIn('fast');
var txnid=$('#existingStolenTxnId').val();
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});

	$.ajax({
		url: './openStolenAndRecoveryPage?txnId='+txnid+"&requestType=1",
		type: 'POST',
		processData: false,
		contentType: false,
		success: function (response, textStatus, jqXHR) {
		//////console.log(response)
		$('#bulkRecoveryquantity').val(response.qty);
		$('#devicequantity').val(response.deviceQuantity);
		$('#bulkRecoveryRemark').val(response.remark);
		if(response.remark=='' || response.remark==null){
			$('#bulkRecoveryRemark').val("NA");	
		}
		$('#bulkRecoveryFileName').val(response.fileName);
		$('#bulkRecoveryDate').val(response.dateOfRecovery);
		$('#bulkRecoveryaddress').val(response.stolenOrganizationUserDB.incidentPropertyLocation);
		$('#bulkRecoverystreetNumber').val(response.stolenOrganizationUserDB.incidentStreet);
		$('#bulkRecoverycountry').val(response.stolenOrganizationUserDB.incidentCountry).change();
		$('#bulkRecoverystate').val(response.stolenOrganizationUserDB.incidentProvince).change();
		$('#bulkRecoverydistrict').val(response.stolenOrganizationUserDB.incidentDistrict).change();
		$('#bulkRecoverycommune').val(response.stolenOrganizationUserDB.incidentCommune).change();
		$('#bulkRecoveryvillage').val(response.stolenOrganizationUserDB.incidentVillage);
		if(response.stolenOrganizationUserDB.incidentVillage=='' || response.stolenOrganizationUserDB.incidentVillage==null){
			$('#bulkRecoveryvillage').val("NA");	
		}
		$('#bulkRecoverylocality').val(response.stolenOrganizationUserDB.incidentLocality);
		if(response.stolenOrganizationUserDB.incidentLocality=='' || response.stolenOrganizationUserDB.incidentLocality==null){
			//$('#bulkRecoverylocality').val("NA");	
		}
		
		$('#bulkRecoverypin').val(response.stolenOrganizationUserDB.incidentPostalCode);
		
		$('#bulkRecoveryRemarkReject').val(response.rejectedRemark);
		if(response.rejectedRemark=='' || response.rejectedRemark==null){
			$('#bulkRecoveryRemarkReject').val("NA");	
		}
		if ($('#pageViewType').val() == 'view') {
		if(response.stolenOrganizationUserDB.incidentVillage=="" || response.stolenOrganizationUserDB.incidentVillage==null){
			$('#bulkRecoveryvillage').empty();
			$('#bulkRecoveryvillage').append('<option value="" selected="">NA</option>');
		}
		}
		$('div#initialloader').delay(300).fadeOut('slow');
		//$('#bulkRecoveryFileLink').attr("onclick",'previewFile("'+response.fileLink+'","'+response.fileName+'","'+response.txnId+'")');
		
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")

		}
	});
}







function updateCompanyRecoveryRequest(){
	$('div#initialloader').fadeIn('fast');
	var formData= new FormData();
	var bulkRecoveryquantity=$('#bulkRecoveryquantity').val();
	var bulkRecoveryRemark=$('#bulkRecoveryRemark').val();
	var bulkRecoveryaddress=$('#bulkRecoveryaddress').val();
	var bulkRecoverystreetNumber=$('#bulkRecoverystreetNumber').val();
	var bulkRecoveryvillage=$('#bulkRecoveryvillage').val();
    var bulkRecoverylocality=$('#bulkRecoverylocality').val();
	
	var bulkRecoverydistrict=$('#bulkRecoverydistrict').val();
	var bulkRecoverycommune=$('#bulkRecoverycommune').val();
	var bulkRecoverypin=$('#bulkRecoverypin').val();
	var bulkRecoverycountry=$('#bulkRecoverycountry').val();
	var bulkRecoverystate=$('#bulkRecoverystate').val();
	
	var bulkRecoveryDate =$('#bulkRecoveryDate').val();
   /* var deviceRecoveryDate=$('#deviceRecoveryDevice').val();*/

	var sigleRecoveryBlockPeriod=$('#stolenDatePeriod').val();
	var blockingType ='Immediate';
	var fileName=$('#bulkRecoveryFileName').val();
	var txnid=$('#existingStolenTxnId').val();
	var bulkDevicequantity=$('#devicequantity').val();
	if(bulkRecoverypin==""){
		bulkRecoverypin=null;
	}
	
	var stolenOrganizationUserDB= {
		   
		    "incidentCommune": bulkRecoverycommune,
		    "incidentCountry": bulkRecoverycountry,
		    "incidentDistrict": bulkRecoverydistrict,
		    "incidentLocality": bulkRecoverylocality,
		    "incidentPostalCode": bulkRecoverypin,
		    "incidentProvince": bulkRecoverystate,
		    "incidentStreet": bulkRecoverystreetNumber,
		    "incidentVillage": bulkRecoveryvillage,
		    "incidentPropertyLocation": bulkRecoveryaddress,
		    
		  }
	
	var request={
			"txnId":txnid,
			"fileName":fileName,
			"dateOfRecovery":bulkRecoveryDate,
			"qty":bulkRecoveryquantity,
			"deviceQuantity":bulkDevicequantity,
			"blockingType":blockingType,
			"requestType":1,
			"sourceType":6,
			"remark":bulkRecoveryRemark,
			"stolenOrganizationUserDB":stolenOrganizationUserDB
	}

	formData.append('file', $('#bulkRecoveryFile')[0].files[0]);
	formData.append("request",JSON.stringify(request));
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});

	$.ajax({
		url: './lawfulIndivisualStolenUpdate',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (response, textStatus, jqXHR) {
		//////console.log(JSON.stringify(response));
			$('div#initialloader').delay(300).fadeOut('slow');
		var resp= JSON.stringify(response);
		//////console.log(resp.errorCode);
		//////console.log(response.errorCode);

		if(response.errorCode==0){
			$("#IndivisualUpdateStolen").prop('disabled', true);
			$('#stolenSucessPopUp').openModal({dismissible:false});;
			}
		else{
			$('#stolenSucessPopUp').openModal({dismissible:false});;
			$('#dynamicMessage').text('');
			$('#dynamicMessage').text(response.message);
		}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")

		}
	});
	return false;

}


function isImageValid(id) {
	var uploadedFileName = $("#"+id).val();
	uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
	////alert("file extension=="+uploadedFileName)
	var ext = uploadedFileName.split('.').pop();

	var fileSize = ($("#"+id)[0].files[0].size);
	/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
	//alert("----"+fileSize);*/
	fileSize = Math.floor(fileSize/1000);
   
	////alert(uploadedFileName+"----------"+ext+"----"+fileSize)
	var areEqual =ext.toLowerCase()=='png';
	////alert(areEqual);
	if(areEqual==true)
		{
		ext='PNG';
		}
	
	if (uploadedFileName.length > 30) {
		$('#fileFormateModal').openModal({dismissible:false});;
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageMessage'));
	} 
	else if(ext !='PNG')
	{
		
		$('#fileFormateModal').openModal({
			dismissible:false
		});
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageMessage'));

	}
	else if(fileSize>=100){
		$('#fileFormateModal').openModal({
			dismissible:false
		});
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageSize'));	
	}
}


function clearFileName() {
	$('#bulkRecoveryFile,#uploadFirSingle').val('');
	$("#bulkRecoveryFileName,#uploadFirSingleName").val('');
	$('#fileFormateModal').closeModal();
}
