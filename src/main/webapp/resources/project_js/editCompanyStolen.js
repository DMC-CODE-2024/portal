
$(document).ready(function() {
 // executes when HTML-Document is loaded and DOM is ready

 viewIndivisualStolen()
 
});


function viewIndivisualStolen()
{


var txnid=$('#existingStolenTxnId').val();
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});

	$.ajax({
		url: './openStolenAndRecoveryPage?txnId='+txnid+"&requestType=0",
		type: 'POST',
		processData: false,
		contentType: false,
		success: function (response, textStatus, jqXHR) {
		//////console.log(response)
		
		$('#bulkStolencompanyName').val(response.stolenOrganizationUserDB.companyName);
		$('#bulkStolenaddress').val(response.stolenOrganizationUserDB.propertyLocation);
		$('#bulkStolenstreetNumber').val(response.stolenOrganizationUserDB.street);
		$('#country2').val(response.stolenOrganizationUserDB.country).change();
		$('#state2').val(response.stolenOrganizationUserDB.province).change();
		$('#bulkStolendistrict').val(response.stolenOrganizationUserDB.district).change();
		$('#bulkStolencommune').val(response.stolenOrganizationUserDB.commune).change();;
		$('#bulkStolenvillage').val(response.stolenOrganizationUserDB.village);
		if(response.stolenOrganizationUserDB.village=="" || response.stolenOrganizationUserDB.village==null){
			$('#bulkStolenvillage').val("NA");
		}
		$('#bulkStolenlocality').val(response.stolenOrganizationUserDB.locality);
		if(response.stolenOrganizationUserDB.locality=="" || response.stolenOrganizationUserDB.locality==null){
			//$('#bulkStolenlocality').val("NA");
		}
		
		$('#bulkStolenpin').val(response.stolenOrganizationUserDB.postalCode);
		
		
		$('#firstName').val(response.stolenOrganizationUserDB.personnelFirstName);
		$('#bulkStolenmiddleName').val(response.stolenOrganizationUserDB.personnelMiddleName);
		if(response.stolenOrganizationUserDB.personnelMiddleName=="" || response.stolenOrganizationUserDB.personnelMiddleName==null){
			$('#bulkStolenmiddleName').val("NA");
		}
		$('#bulkStolenlastName').val(response.stolenOrganizationUserDB.personnelLastName);
		$('#deviceBulkStolenaddress').val(response.stolenOrganizationUserDB.incidentPropertyLocation);
		$('#deviceBulkStolenstreetNumber').val(response.stolenOrganizationUserDB.incidentStreet);
		
		if(response.stolenOrganizationUserDB.incidentVillage=="" || response.stolenOrganizationUserDB.incidentVillage==null){
			$('#deviceBulkStolenvillage').val("NA");
		}
		$('#deviceBulkStolenlocality').val(response.stolenOrganizationUserDB.incidentLocality);
		if(response.stolenOrganizationUserDB.incidentLocality=="" || response.stolenOrganizationUserDB.incidentLocality==null){
			//$('#deviceBulkStolenlocality').val("NA");
		}
		$('#country3').val(response.stolenOrganizationUserDB.incidentCountry).change();
		$('#state3').val(response.stolenOrganizationUserDB.incidentProvince).change();
		$('#deviceBulkStolendistrict').val(response.stolenOrganizationUserDB.incidentDistrict).change();
		$('#deviceBulkStolencommune').val(response.stolenOrganizationUserDB.incidentCommune).change();
		$('#deviceBulkStolenvillage').val(response.stolenOrganizationUserDB.incidentVillage);
		$('#deviceBulkStolenpin').val(response.stolenOrganizationUserDB.incidentPostalCode);
		
		$('#deviceBulkStolenComplaint').val(response.complaintType);
		$('#bulkStolenofficeEmail').val(response.stolenOrganizationUserDB.email);
		if(response.stolenOrganizationUserDB.email=="" || response.stolenOrganizationUserDB.email==null){
			$('#bulkStolenofficeEmail').val("NA");
		}
		$('#bulkStolenContact').val(response.stolenOrganizationUserDB.phoneNo);
		if(response.stolenOrganizationUserDB.phoneNo=="" || response.stolenOrganizationUserDB.phoneNo==null){
			$('#bulkStolenContact').val("NA");
		}
		
		$('#singleStolenComplaintType').val(response.complaintType);
		$('#deviceBulkStolenquantity').val(response.qty);
		$('#devicequantity').val(response.deviceQuantity);
		
		$('#deviceBulkStolenRemark').val(response.remark);
		if(response.remark=="" || response.remark==null){
			$('#deviceBulkStolenRemark').val("NA");
		}
		$('#stolenFileName').val(response.fileName);
		
		$('#IndivisualStolenDate').val(response.dateOfStolen);
		$('#uploadFirSingleName').val(response.firFileName);
		
		$('#firFilePreview').attr("onclick",'previewFile("'+response.fileLink+'","'+response.firFileName+'","'+response.txnId+'")');
		if(response.firFileName=="" || response.firFileName==null){
			$('#uploadFirSingleName').val("NA");
			 $("#firFilePreview").removeAttr('onclick');
			 $("#firFilePreview").removeAttr('href');
		}
		$('#bulkDeviceRejectRemark').val(response.rejectedRemark);
		if(response.rejectedRemark=="" || response.rejectedRemark==null){
			$('#bulkDeviceRejectRemark').val("NA");
		}
		$("label[for='IndivisualStolenDate']").addClass('active');
		
		$('input[name=stolenBulkBlockPeriod][value='+response.blockingType+']').attr('checked', true); 
		
		if(response.blockingType=='tilldate')
			{
			$("#stolenCalender").css("display", "block"); 
			
			$("#stolenBulkDatePeriod").val(response.blockingTimePeriod);
			}
		else{
			$("#calender").css("display", "none"); 
		}
		
		if ($('#pageViewType').val() == 'edit') {
			if(response.stolenOrganizationUserDB.phoneNo=="" || response.stolenOrganizationUserDB.phoneNo==null){
				$('#bulkStolenContact').val("");
			}
			if(response.stolenOrganizationUserDB.email=="" || response.stolenOrganizationUserDB.email==null){
				$('#bulkStolenofficeEmail').val("");
			}
		}
		else{
			
		if(response.stolenOrganizationUserDB.incidentVillage=="" || response.stolenOrganizationUserDB.incidentVillage==null){
			$('#deviceBulkStolenvillage').empty();
			$('#deviceBulkStolenvillage').append('<option value="" selected="">NA</option>');
		}
		
		if(response.stolenOrganizationUserDB.village=="" || response.stolenOrganizationUserDB.village==null){
			$('#bulkStolenvillage').empty();
			$('#bulkStolenvillage').append('<option value="" selected="">NA</option>');
		}
	
		 
		}
		//$('#deviceListlink').attr("onclick",'previewFile("'+response.fileLink+'","'+response.fileName+'","'+response.txnId+'")');
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")

		}
	});
}



function updateCompanyStolenDetails(){
	$('div#initialloader').fadeIn('fast');
	var formData= new FormData();
	
	var bulkStolencompanyName=$('#bulkStolencompanyName').val();
	var bulkStolenaddress=$('#bulkStolenaddress').val();
	var bulkStolenstreetNumber=$('#bulkStolenstreetNumber').val();
	var bulkStolenvillage=$('#bulkStolenvillage').val();
	var bulkStolenlocality=$('#bulkStolenlocality').val();
	var bulkStolendistrict=$('#bulkStolendistrict').val();
	var bulkStolencommune=$('#bulkStolencommune').val();
	var bulkStolenpin=$('#bulkStolenpin').val();
	var country2=$('#country2').val();
	var state2=$('#state2').val();

	var txnid=$('#existingStolenTxnId').val();
	var blockingTimePeriod=$('#stolenBulkDatePeriod').val();
	var blockingType =$('.blocktypeRadio:checked').val();
	var fileName=$('#stolenFileName').val();
	
	var firstName=$('#firstName').val();
	var bulkStolenmiddleName=$('#bulkStolenmiddleName').val();
	var bulkStolenlastName=$('#bulkStolenlastName').val();
	var bulkStolenofficeEmail=$('#bulkStolenofficeEmail').val();
	var trimContactNumber=$('#bulkStolenContact').val();
	var bulkStolenContact =trimContactNumber.replace(/[^A-Z0-9]/ig, "");

	
	var deviceBulkStolenaddress=$('#deviceBulkStolenaddress').val();
	var deviceBulkStolenstreetNumber=$('#deviceBulkStolenstreetNumber').val();
	var deviceBulkStolenvillage=$('#deviceBulkStolenvillage').val();
	var deviceBulkStolenlocality=$('#deviceBulkStolenlocality').val();
	var deviceBulkStolendistrict=$('#deviceBulkStolendistrict').val();
	var deviceBulkStolencommune=$('#deviceBulkStolencommune').val();
	var deviceBulkStolenpin=$('#deviceBulkStolenpin').val();
	var country3 = $('#country3').val();
	var state3= $('#state3').val();
	var deviceBulkStolenComplaint=$('#deviceBulkStolenComplaint').val();
	var deviceBulkStolenquantity=$('#deviceBulkStolenquantity').val();
	var deviceBulkStolenRemark=$('#deviceBulkStolenRemark').val();
	var bulkStolenDate=$('#IndivisualStolenDate').val();
	var uploadFirSingle=$('#uploadFirSingleName').val();
	var bulkDevicequantity=$('#devicequantity').val();
	
	if(bulkStolenpin==""){
		bulkStolenpin=null;
	}
	if(deviceBulkStolenpin==""){
		deviceBulkStolenpin=null;
	}
	
	var stolenOrganizationUserDB= {
    "commune": bulkStolencommune,
    "companyName": bulkStolencompanyName,
    "country": country2,
    "district": bulkStolendistrict,
    "email": bulkStolenofficeEmail,
    "incidentCommune": deviceBulkStolencommune,
    "incidentCountry": country3,
    "incidentDistrict": deviceBulkStolendistrict,
    "incidentLocality": deviceBulkStolenlocality,
    "incidentPostalCode": deviceBulkStolenpin,
    "incidentPropertyLocation":deviceBulkStolenaddress,
    "incidentProvince": state3,
    "incidentStreet": deviceBulkStolenstreetNumber,
    "incidentVillage": deviceBulkStolenvillage,
    "locality": deviceBulkStolenlocality ,
    "personnelFirstName": firstName,
    "personnelLastName":bulkStolenlastName ,
    "personnelMiddleName":bulkStolenmiddleName ,
    "phoneNo": bulkStolenContact,
    "postalCode": bulkStolenpin,
    "propertyLocation": bulkStolenaddress,
    "province": state2,
    "street": bulkStolenstreetNumber,
    "village": bulkStolenvillage
  }
	
	
	var request={
			"txnId":txnid,
			"fileName":fileName,
			"deviceQuantity":bulkDevicequantity,
			"firFileName":uploadFirSingle,
			"remark":deviceBulkStolenRemark,
			"qty":deviceBulkStolenquantity,
			"dateOfStolen":bulkStolenDate,
			"complaintType":deviceBulkStolenComplaint,
			"blockingTimePeriod":blockingTimePeriod,
			"blockingType":blockingType,
			"requestType":0,
			"sourceType":6,
			"stolenOrganizationUserDB":stolenOrganizationUserDB
	}
	formData.append('file', $('#deviceBulkStolenFile')[0].files[0]);
	formData.append('firFileName',$('#uploadFirSingle')[0].files[0]);
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
		//////console.log(response)
			$('div#initialloader').delay(300).fadeOut('slow');
		if(response.errorCode==0){
			$("#companyStolenButton").prop('disabled', true);
			$('#stolenSucessPopUp').openModal({dismissible:false});;
			}
		else{
			$('#stolenSucessPopUp').openModal({dismissible:false});;
			$('#dynamicMessage').text('');
			$('#dynamicMessage').text(response.message);
		}
		/*	if(response.errorCode==0){
				$("#bulkStolenButton").prop('disabled', true);
				$('#IndivisualStolenSucessPopup').openModal();
				$('#IndivisualStolenTxnId').text(response.txnId)
			}
			else{
//				$('#sucessMessage').text('');
				$('#regularisedDevice').openModal();
				$('#dynamicTxnId').text(data.txnId);
			}*/
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax");

		}
	});
	return false;
}

function clearFileName() {
	var fieldId=$('#FilefieldId').val();
	
	 if(fieldId=='deviceBulkStolenFile')
		{
		$('#'+fieldId).val('');
		$('#stolenFileName').val('');
		}
	else if(fieldId=='uploadFirSingle')
	{
		$('#'+fieldId).val('');
	$('#uploadFirSingleName').val('');
	}
	
	$('#fileFormateModal').closeModal();
	$('#FilefieldId').val('');
}