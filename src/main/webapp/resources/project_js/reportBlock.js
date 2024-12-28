/*	window.parent.$('#langlist').on('change', function() {
			var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

			window.location.assign("openBlockUnblockPage?pageType=block&lang="+lang);
		}); */

var langParam=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
$.i18n().locale = langParam;
var successMsg;
$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
} ).done( function() { 
	editUnblock=$.i18n('editStolenDevice');

});


$(document).ready(function () {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});


	$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {

		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#blockdeviceType');
			//////console.log('#blockdeviceType')
		}
	});

	$.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {

		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#blockmultipleSimStatus');
			////console.log('#blockmultipleSimStatus');
		}
	});
});

$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#blockdeviceIdType');
		////console.log('#blockdeviceIdType');
	}
});

var RequestData = {
		"tag" : "GREY_TO_BLACK_MOVE_PERIOD_IN_DAY"
}
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
});


$.ajax({
	url : "./system/viewTag",
	data :	JSON.stringify(RequestData),
	dataType : 'json',
	contentType : 'application/json; charset=utf-8',
	type : 'POST',
	success : function(data) {
		////console.log(data.value);
		$('#defaultPeriodId,#bulkblocktypeRadioId,#editbulkblocktypeRadioId').attr('title', data.value+' Days');
	},
	error : function() {
		////console.log("Failed");
	}
});

$.getJSON('./getTypeDropdownList/BLOCK_CATEGORY/'+$("body").attr("data-userTypeID"), function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#bulkBlockdeviceCategory');
		////console.log('#bulkBlockdeviceCategory');
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#singleDeviceCategory');
		////console.log('#singleDeviceCategory');
	}
});


function showSingleImeiBlock()
{
	$("#SingleImeiBlock").css("display", "block");
	$("#multipleImeiBlock").css("display", "none");

	$('#multipleImeiBlockform').trigger("reset");
	$('#SingleImeiBlockform').trigger("reset");


	/*$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {

		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#blockdeviceType');
			////console.log('#blockdeviceType')
		}
	});

	$.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {

		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#blockmultipleSimStatus');
			////console.log('#blockmultipleSimStatus');
		}
	});

	$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {

		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#blockdeviceIdType');
			////console.log('#blockdeviceIdType');
		}
	});


	 */
}



function showMultipleImeiBlock()
{
	$("#multipleImeiBlock").css("display", "block");
	$("#SingleImeiBlock").css("display", "none");
	$('#multipleImeiBlockform').trigger("reset");
	$('#SingleImeiBlockform').trigger("reset");

	/*	$.getJSON('./getDropdownList/GRIEVANCE_CATEGORY', function(data) {

		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#bulkBlockdeviceCategory');
			////console.log('#bulkBlockdeviceCategory');
		}
	});*/
}

function showSingleImeiUnBlock()
{
	$("#SingleImeiUnBlock").css("display", "block");
	$("#multipleImeiUnBlock").css("display", "none");

	$('#multipleImeiUnBlockform').trigger("reset");
	$('#SingleImeiUnBlockform').trigger("reset");


}



function showMultipleImeiUnBlock()
{
	$("#multipleImeiUnBlock").css("display", "block");
	$("#SingleImeiUnBlock").css("display", "none");

	$('#multipleImeiUnBlockform').trigger("reset");
	$('#SingleImeiUnBlockform').trigger("reset");

}



function submitBlockImei()
{
	$('div#initialloader').fadeIn('fast');
	//$('div#initialloader').delay(300).fadeOut('slow');
	var bulkBlockdeviceCategory = $('#bulkBlockdeviceCategory').val();
	var blockbulkquantity = $('#blockbulkquantity').val();
	//var blockBulkFile = $('#blockBulkFile').val();
	var blockbulkRemark = $('#blockbulkRemark').val();
	var ModeType='3';
	var requestType='2';
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var bulkBlockingTimePeriod=$('#stolenBulkDatePeriod').val();
	var bulkBlocktype =$('.bulkblocktypeRadio:checked').val();
	var deviceQuantity=$('#blockbulkDeviceQuantity').val();
	var bulkBlockingTimePeriod=$('#stolenBulkDatePeriod').val();
	var bulkBlocktype =$('.bulkblocktypeRadio:checked').val();
	var deviceQuantity=$('#blockbulkDeviceQuantity').val();
	//////console.log("bulkBlockdeviceCategory="+bulkBlockdeviceCategory+" blockbulkquantity=="+blockbulkquantity+" blockUnblockRemark="+blockbulkRemark)

	var formData = new FormData();
	formData.append('file', $('#blockBulkFile')[0].files[0]);
	formData.append('blockCategory', bulkBlockdeviceCategory);
	formData.append('qty', blockbulkquantity);
	formData.append('remark', blockbulkRemark);
	formData.append('sourceType', ModeType);
	formData.append('requestType', requestType);
	formData.append('userId',userId);
	formData.append('roleType',roleType);
	formData.append('blockingTimePeriod',bulkBlockingTimePeriod);
	formData.append('blockingType',bulkBlocktype);
	formData.append('deviceQuantity',deviceQuantity);

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});



	$.ajax({
		url: './reportblockBulkFile',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {
			$('div#initialloader').delay(300).fadeOut('slow');
			$("#blockBulkSubmitButton").prop('disabled', true);
			////console.log(data);
			//$('#fileStolenModal').closeModal();
			
			if(data.errorCode==0){
				$('#markBulkAsBlock').openModal({dismissible:false});
				$('#txnIdsingleImei').text(data.txnId);
			}
			else if(data.errorCode==5)
				{
				$('#markBulkAsBlock').openModal({dismissible:false});
				$('#blockBulkDeviceMsg').text('');
				$('#blockBulkDeviceMsg').text($.i18n(data.tag));
				}
			
			else{
				
				$('#markBulkAsBlock').openModal({dismissible:false});
				$('#blockBulkDeviceMsg').text('');
				$('#blockBulkDeviceMsg').text($.i18n('errorMsg'));
			}

		},
		error: function (jqXHR, textStatus, errorThrown) {
			$('div#initialloader').delay(300).fadeOut('slow');
			////console.log("error in ajax")
		}
	});

	return false;


}

function submitUnBlockImei()
{
	$('div#initialloader').fadeIn('fast');
	var unblockbulkquantity = $('#unblockbulkquantity').val();
	//var blockBulkFile = $('#blockBulkFile').val();
	var bulkunBlockdeviceCategory=$('#bulkunBlockdeviceCategory').val();
	var unblockbulkRemark = $('#unblockbulkRemark').val();
	var ModeType='3';
	var requestType='3';
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var deviceQuantity=$('#unblockbulkDevicequantity').val();

	//////console.log("bulkBlockdeviceCategory="+bulkBlockdeviceCategory+" blockbulkquantity=="+blockbulkquantity+" blockUnblockRemark="+blockUnblockRemark)
	var formData = new FormData();
	formData.append('file', $('#unblockBulkFile')[0].files[0]);
	formData.append('qty', unblockbulkquantity);
	formData.append('blockCategory', bulkunBlockdeviceCategory);
	formData.append('remark', unblockbulkRemark);
	formData.append('sourceType', ModeType);
	formData.append('requestType', requestType);
	formData.append('userId',userId);
	formData.append('roleType',roleType);
	formData.append('deviceQuantity',deviceQuantity);

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './reportUnblockBulkFile',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {
			//////console.log(data);
			$('div#initialloader').delay(300).fadeOut('slow');
			$("#bulkUnblockSubmitButton").prop('disabled', true);
//			////console.log(data);
			
			if(data.errorCode==0){
				$('#markBulkAsUnblock').openModal({dismissible:false});
				$('#txnIdUnblocksingleDevice').text(data.txnId);
			}
			else if(data.errorCode==5)
				{
				$('#markBulkAsUnblock').openModal({dismissible:false});
				$('#bulkSaveSucessMsg').text('');
				$('#bulkSaveSucessMsg').text($.i18n(data.tag));
				}
			
			else{
				
				$('#markBulkAsBlock').openModal({dismissible:false});
				$('#bulkSaveSucessMsg').text('');
				$('#bulkSaveSucessMsg').text($.i18n('errorMsg'));
			}

		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")
			$('div#initialloader').delay(300).fadeOut('slow');
		}
	});

	return false;


}

function submitSingleBlockDevicesRequest()
{
if($('#blockdeviceIdType').val()==0){
		var luhnIMEI1=luhnCheck('singleblockIMEI1','blockdeviceIdType');
		var luhnIMEI4=null;
		var luhnIMEI3=null;
		var luhnIMEI2=null;
		
		if($('#singleblockIMEI2').val()!=null || $('#singleblockIMEI2').val()!=''){
			
			var luhnIMEI2 =luhnCheck('singleblockIMEI2','blockdeviceIdType')	
		}
		else if($('#singleblockIMEI3').val()!=null || $('#singleblockIMEI3').val()!=''){
			var luhnIMEI3 = luhnCheck('singleblockIMEI3','blockdeviceIdType')	
		}
		
		else if($('#singleblockIMEI4').val()!=null || $('#singleblockIMEI4').val()!=''){
			 luhnIMEI4= luhnCheck('singleblockIMEI4','blockdeviceIdType')	
		}
		//alert("luhnIMEI1="+luhnIMEI1+" luhnIMEI2 ="+luhnIMEI2+" luhnIMEI3="+luhnIMEI3+" luhnIMEI4 ="+luhnIMEI4)
		//alert("luhnIMEI1 "+luhnIMEI1+" luhnIMEI2 = "+luhnIMEI2+" luhnIMEI3 "+luhnIMEI3+" luhnIMEI4 = "+luhnIMEI4);
		if(luhnIMEI1==false || luhnIMEI2==false || luhnIMEI3==false || luhnIMEI4==false)
		{
			//alert("failed");
			return false
		}
	
		
		var checkIMEI=checkDuplicateImei($('#singleblockIMEI1').val(),$('#singleblockIMEI2').val(),$('#singleblockIMEI3').val(),$('#singleblockIMEI14').val());
		if(checkIMEI===true){
		$('#errorMsgOnModal').text('');
		$('#errorMsgOnModal').text($.i18n('duplicateImeiMessage'));
		return false;
	}
	}
	$('div#initialloader').fadeIn('fast');
	var deviceType=$('#blockdeviceType').val();
	var blockdeviceIdType=$('#blockdeviceIdType').val();
	var multipleSimStatus=$('#blockmultipleSimStatus').val();
	var serialNumber=$('#singleblockserialNumber').val();
	var remark=$('#singleblockremark').val();
	var IMEI1=$('#singleblockIMEI1').val();
	var IMEI2=$('#singleblockIMEI2').val();
	var IMEI3=$('#singleblockIMEI3').val();
	var IMEI4=$('#singleblockIMEI4').val();
	var blockingTimePeriod=$('#stolenDatePeriod').val();
	var blockingType =$('.blocktypeRadio:checked').val();
	var category= $('#singleDeviceCategory').val();

	var requestType=2;

	////console.log("****"+blockingTimePeriod+"**"+blockingType);
	////console.log("sucess include deviceType="+deviceType+" multipleSimStatus="+multipleSimStatus+" serialNumber="+serialNumber+" remark="+remark+" IMEI1="+IMEI1 );

	var singleImeiBlockDetail={

			'deviceType':deviceType,
			'deviceIdType':blockdeviceIdType,
			'multipleSimStatus':multipleSimStatus,
			'deviceSerialNumber':serialNumber,
			'firstImei':IMEI1,
			'secondImei':IMEI2,
			'thirdImei':IMEI3,
			'fourthImei':IMEI4,
			'requestType':requestType,
			'remark':remark,
			'sourceType':4,
			'blockingTimePeriod':blockingTimePeriod,
			'blockingType':blockingType,
			'category':category,
			'deviceQuantity':1


	}

	////console.log(JSON.stringify(singleImeiBlockDetail));
	////console.log("*********");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './blockUnBlockSingleDevices',
		data : JSON.stringify(singleImeiBlockDetail),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success: function (data, textStatus, jqXHR) {
			$('div#initialloader').delay(300).fadeOut('slow');
			$("#singleblockSubmit").prop('disabled', true);
			////console.log(data);
			if(data.errorCode==0){
				$('#markAsBlock').openModal({dismissible:false});
				$('#txnIdblockBulkDevice').text(data.txnId);
			}
			else if(data.errorCode==5)
				{
				$('#markAsBlock').openModal({dismissible:false});
				$('#singleDeviceBlockMessage').text('');
				$('#singleDeviceBlockMessage').text($.i18n(data.tag));
				}
			else{
				$('#markAsBlock').openModal({dismissible:false});
				$('#singleDeviceBlockMessage').text('');
				$('#singleDeviceBlockMessage').text($.i18n('errorMsg'));
			}
			

		},
		error: function (jqXHR, textStatus, errorThrown) {
			$('div#initialloader').delay(300).fadeOut('slow');
			////console.log("error in ajax")
		}
	});
	return false;
}



function submitSingleUnBlockDevicesRequest()
{
	if($('#UnblockdeviceIdType').val()==0){
		
		var luhnIMEI1=luhnCheck('unbockSingleIMEI1','UnblockdeviceIdType');
		var luhnIMEI4=null;
		var luhnIMEI3=null;
		var luhnIMEI2=null;
		if($('#unbockSingleIMEI2').val()!=null || $('#unbockSingleIMEI2').val()!=''){
			var luhnIMEI2 =luhnCheck('unbockSingleIMEI2','UnblockdeviceIdType')	
		}
		else if($('#unbockSingleIMEI3').val()!=null || $('#unbockSingleIMEI3').val()!=''){
			var luhnIMEI3 = luhnCheck('unbockSingleIMEI3','UnblockdeviceIdType')	
		}
		
		else if($('#unbockSingleIMEI4').val()!=null || $('#unbockSingleIMEI4').val()!=''){
			 luhnIMEI4= luhnCheck('unbockSingleIMEI4','UnblockdeviceIdType')	
		}
		
		//alert("luhnIMEI1 "+luhnIMEI1+" luhnIMEI2 = "+luhnIMEI2+" luhnIMEI3 "+luhnIMEI3+" luhnIMEI4 = "+luhnIMEI4);
		if(luhnIMEI1==false || luhnIMEI2==false || luhnIMEI3==false || luhnIMEI4==false)
		{
			//alert("failed");
			return false
		}
	
		var checkIMEI=checkDuplicateImei($('#unbockSingleIMEI1').val(),$('#unbockSingleIMEI2').val(),$('#unbockSingleIMEI3').val(),$('#unbockSingleIMEI4').val());
		if(checkIMEI===true){
		$('#errorMsgOnModal').text('');
		$('#errorMsgOnModal').text($.i18n('duplicateImeiMessage'));
		return false;
	}
	}
	$('div#initialloader').fadeIn('fast');
	var deviceType=$('#unbockSingledeviceType').val();
	var blockdeviceIdType=$('#UnblockdeviceIdType').val();
	var multipleSimStatus=$('#unbockSingleMultipleSimStatus').val();
	var serialNumber=$('#unbockSingleSerialNumber').val();
	var remark=$('#unbockSingleRemark').val();
	var IMEI1=$('#unbockSingleIMEI1').val();
	var IMEI2=$('#unbockSingleIMEI2').val();
	var IMEI3=$('#unbockSingleIMEI3').val();
	var IMEI4=$('#unbockSingleIMEI4').val();
	var requestType=3;
	var roleType = $("body").attr("data-roleType");
	var blockingTimePeriod=$('#stolenDatePeriodUnblock').val();
	var blockingType =$('.blocktypeRadio:checked').val();
	var category= $('#singleDeviceUnblock').val();





	////console.log("sucess include deviceType="+deviceType+" multipleSimStatus="+multipleSimStatus+" serialNumber="+serialNumber+" remark="+remark+" IMEI1="+IMEI1 );

	var singleImeiBlockDetail={

			'deviceType':deviceType,
			'deviceIdType':blockdeviceIdType,
			'multipleSimStatus':multipleSimStatus,
			'deviceSerialNumber':serialNumber,
			'firstImei':IMEI1,
			'secondImei':IMEI2,
			'thirdImei':IMEI3,
			'fourthImei':IMEI4,
			'requestType':requestType,
			'remark':remark,
			'sourceType':4,
			'blockingTimePeriod':blockingTimePeriod,
			'blockingType':blockingType,
			'category':category,
			'deviceQuantity':1

	}

////	console.log(JSON.stringify(singleImeiBlockDetail));
////	console.log("*********");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './blockUnBlockSingleDevices',
		data : JSON.stringify(singleImeiBlockDetail),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success: function (data, textStatus, jqXHR) {
			$('div#initialloader').delay(300).fadeOut('slow');
			$("#singleUnblockSubmitButton").prop('disabled', true);
			////console.log(data);
			
			if(data.errorCode==0){
				$('#markAsUnblock').openModal({dismissible:false});
				$('#txnIdblocksingleDevice').text(data.txnId);
			}
			else if(data.errorCode==5)
				{
				$('#markAsUnblock').openModal({dismissible:false});
				$('#saveSingleMsg').text('');
				$('#saveSingleMsg').text($.i18n(data.tag));
				}
			
			else{
				
				$('#markAsUnblock').openModal({dismissible:false});
				$('#saveSingleMsg').text('');
				$('#saveSingleMsg').text($.i18n('errorMsg'));
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")
			$('div#initialloader').delay(300).fadeOut('slow');
		}
	});
	return false;
}








//*******************************************View Pop up data *************************************************************************************************
function viewDeviceDetails(txnId,popUpType,requestType){
////	console.log("requestType=="+requestType)

	var role = currentRoleType == null ? roleType : currentRoleType;
	////console.log("popUpType=="+popUpType);
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url : "./openbulkView?reqType="+requestType+"&txnId="+txnId+'&modeType=singleDeivce',
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		async :false,
		success : function(data) {
			////console.log(data);
			setViewBulkPopUp(data,popUpType,requestType);
		},
		error : function() {

		}
	});
}
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
});


$.getJSON('./getTypeDropdownList/BLOCK_CATEGORY/'+$("body").attr("data-userTypeID"), function(data) {
	$('#editBulkBlockCategory').empty();
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#editBulkBlockCategory');

	}
});
function setViewBulkPopUp(data,popUpType,requestType){




	if(popUpType=='view'){	
			if(requestType=="3")
		{
           $("#bulkblockingTypeId").css("display", "none");
			$('#viewModalHeader').text($.i18n('viewBulkUnblock'));
		}
		else{
			$("#bulkblockingTypeId").css("display", "block");
			$('#viewModalHeader').text($.i18n('viewBlockDevice'));
		}

		$("#viewBulkBlockDeviceModal").openModal({dismissible:false});
		$("#viewBulkBlockCategory").val(data.blockCategoryInterp);
		$("#viewBulkBlockRemark").val(data.remark);
		$("#viewBulkBlockuploadFile").val(data.fileName);
		$("#viewBulkBlockquantity").val(data.qty);
		$("#viewBulkBlockDevicequantity").val(data.deviceQuantity);
		$("#viewBulkBlockTxnId").val(data.txnId);
		$("#viewBulkBlockRemarkReject").val(data.rejectedRemark);
		if(data.rejectedRemark=="" || data.rejectedRemark==null)
			{
			$("#viewBulkBlockRemarkReject").val("NA");
			}
		$("#viewBulkBlockRemarkRejectDiv").css("display", "block");
		if(data.blockingType=='tilldate')
		{

			$("#viewbulkblockingType").val("Later ( Block time period : " +data.blockingTimePeriod+" )");
		}
		else{
			$("#viewbulkblockingType").val(data.blockingType);
		}
	}
	else
	{
		if(requestType=="3")
		{
			$("#editBulkBlockDiv").css("display", "none"); 
			$('#editblockHeading').text(editUnblock);
		}
		else{
			$("#editBulkBlockDiv").css("display", "block"); 
			$('#editblockHeading').text($.i18n('editBlockDevice'));
		}

		////console.log("++++++++++"+popUpType+" requestType="+requestType);
		$("#editBulkBlockDeviceModal").openModal({dismissible:false});
		$("#editBulkBlockRemark").val(data.remark);
		$("#editBulkBlockuploadFile").val(data.fileName);
		$("#editBulkBlockquantity").val(data.qty);
		$("#editBulkBlockDevicequantity").val(data.deviceQuantity);
		$("#editBulkBlockTxnId").val(data.txnId);
		$("#editBulkBlockrequestType").val(data.requestType);
		$("#editBulkBlockCategory").val(data.blockCategory);
		$('input[name=editbulkblocktypeName][value='+data.blockingType+']').attr('checked', true);
		if(data.blockingType=='tilldate')
		{
			$("#bulkeditcalender").css("display", "block"); 

			$("#editstolenBulkDatePeriod").val(data.blockingTimePeriod);
		}
		else{
			$("#bulkeditcalender").css("display", "none"); 
		}

	}
}


function updateBulkDevice(){
	$('div#initialloader').fadeIn('fast');
	var categoryInterp=	$("#editBulkBlockCategory").val();
	var remark=	$("#editBulkBlockRemark").val();
	var fileName=$("#editBulkBlockuploadFile").val();
	var qty=$("#editBulkBlockquantity").val();
	var txnId=$("#editBulkBlockTxnId").val();
	var requestType=$("#editBulkBlockrequestType").val();
	var ModeType=3
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var formData = new FormData();
	var editbulkBlockingTimePeriod=$('#editstolenBulkDatePeriod').val();
	var editbulkBlocktype =$('.editbulkblocktypeRadio:checked').val();
	var devicequantity = $("#editBulkBlockDevicequantity").val();
	formData.append('file', $('#editselectBulkBlockuploadFile')[0].files[0]);
	formData.append('qty', qty);
	formData.append('deviceQuantity',devicequantity);
	formData.append('blockCategory', categoryInterp);
	formData.append('remark', remark);
	formData.append('sourceType', ModeType);
	formData.append('requestType', requestType);
	formData.append('userId',userId);
	formData.append('roleType',roleType);
	formData.append('txnId',txnId);
	formData.append('fileName',fileName);
	formData.append('blockingTimePeriod',editbulkBlockingTimePeriod);
	formData.append('blockingType',editbulkBlocktype);
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './updateFileTypeStolenRecovery',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {
			////console.log(data);
//			////console.log(data);
			$('div#initialloader').delay(300).fadeOut('slow');


			if(data.errorCode==0){

				$('#confirmEditBlockUnblock').openModal({dismissible:false});
			}
			else if(data.errorCode==5){
				$('#confirmEditBlockUnblock').openModal({dismissible:false});
				$('#stockupdateSucessMessage').text('');
				$('#stockupdateSucessMessage').text($.i18n(data.tag));

			}
			else{
				$('#confirmEditBlockUnblock').openModal({dismissible:false});
				$('#stockupdateSucessMessage').text('');
				$('#stockupdateSucessMessage').text($.i18n('errorMsg'));
			}
			// $('#updateConsignment').modal('open'); 
			//alert("success");

		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")
			$('div#initialloader').delay(300).fadeOut('slow');
		}
	});
	return false;

}



function viewblockImeiDevice(txnId,popUpType,requestType)
{

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});



	$.ajax({
		/*url : "./openSingleImeiForm?reqType=editPage&txnId="+txnId+'&modeType=singleDeivce',*/
		url : "./openbulkView?reqType="+requestType+"&txnId="+txnId+'&modeType=singleDeivce',
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		async :false,
		success : function(data) {
			////console.log(data);
			setSingleDeviceViewPopUp(data,popUpType,requestType);
		},
		error : function() {

		}
	});


}



var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
});


$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {
	$("#editblockdeviceType").empty();
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#editblockdeviceType');

	}
});

$.getJSON('./getTypeDropdownList/BLOCK_CATEGORY/'+$("body").attr("data-userTypeID"), function(data) {
	$("#editbulkBlockdeviceCategory").empty();
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#editbulkBlockdeviceCategory');
		////console.log('#editbulkBlockdeviceCategory');
	}
});

$.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {
	$("#editblockmultipleSimStatus").empty();
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#editblockmultipleSimStatus');

	}
});

$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
	$("#editblockdeviceIdType").empty();
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#editblockdeviceIdType');

	}
});




function setSingleDeviceViewPopUp(data,popUpType,requestType){
////	console.log(data.rejectedRemark);
////	console.log(data.singleImeiDetails.firstImei);

	if(popUpType=='view'){
		$("#viewsingleblockremarkDiv").css("display", "block"); 
		if(requestType=="3")
		{

			$("#blockingTypeId").css("display", "none"); 
			$("#editBlockTimePeriod").css("display", "none"); 
			$('#singleBlockUnblockHeading').text($.i18n('viewBulkUnblock'));
		}
		else{
			$("#blockingTypeId").css("display", "block"); 
			$("#editBlockTimePeriod").css("display", "block"); 

			$('#singleBlockUnblockHeading').text($.i18n('viewBlockDevice'));
		}
		$('#viewblockImeiDevice').openModal({dismissible:false});
		////console.log("++++++++++"+popUpType+"requestType="+requestType);




		if(data.singleImeiDetails.secondImei==null && data.singleImeiDetails.thirdImei==null && data.singleImeiDetails.fourthImei==null  )
		{
			$("#viewsingleblockIMEI2").val("NA");
			$("#viewsingleblockIMEI3").val("NA");
			$("#viewsingleblockIMEI4").val("NA");
		}
		else if(data.singleImeiDetails.secondImei==null && data.singleImeiDetails.thirdImei==null && data.singleImeiDetails.fourthImei!=null )
		{
			$("#viewsingleblockIMEI2").val("NA");
			$("#viewsingleblockIMEI3").val("NA");
			$("#viewsingleblockIMEI4").val(data.singleImeiDetails.fourthImei);
		}
		else if(data.singleImeiDetails.secondImei!=null && data.singleImeiDetails.thirdImei==null && data.singleImeiDetails.fourthImei==null)
		{
			$("#viewsingleblockIMEI2").val(data.singleImeiDetails.secondImei);
			$("#viewsingleblockIMEI3").val("NA");
			$("#viewsingleblockIMEI4").val("NA");
		}
		else if(data.singleImeiDetails.secondImei==null && data.singleImeiDetails.thirdImei!=null && data.singleImeiDetails.fourthImei==null)
		{
			$("#viewsingleblockIMEI2").val("NA");
			$("#viewsingleblockIMEI3").val(data.singleImeiDetails.thirdImei);
			$("#viewsingleblockIMEI4").val("NA");
		}
		else if(data.singleImeiDetails.secondImei!=null && data.singleImeiDetails.thirdImei!=null && data.singleImeiDetails.fourthImei!=null)
		{
			$("#viewsingleblockIMEI2").val(data.singleImeiDetails.secondImei);
			$("#viewsingleblockIMEI3").val(data.singleImeiDetails.thirdImei);
			$("#viewsingleblockIMEI4").val(data.singleImeiDetails.fourthImei);
		}
		else{
			////console.log("else############")
		}
		
		if(data.singleImeiDetails.secondImei==null){
			$("#viewsingleblockIMEI2").val("NA");
		}
		if(data.singleImeiDetails.thirdImei==null){
			$("#viewsingleblockIMEI3").val("NA");
		}
		if(data.singleImeiDetails.fourthImei==null){
			$("#viewsingleblockIMEI4").val("NA");
		}
		
		$("#viewblockdeviceType").val(data.singleImeiDetails.deviceTypeInterp);
		if(data.singleImeiDetails.deviceTypeInterp=='' || data.singleImeiDetails.deviceTypeInterp==null){
			$("#viewblockdeviceType").val('NA')
		}
		$("#viewblockdeviceIdType").val(data.singleImeiDetails.deviceIdTypeInterp);
		
		$("#viewblockmultipleSimStatus").val(data.singleImeiDetails.multipleSimStatusInterp);
		if(data.singleImeiDetails.multipleSimStatusInterp=='' || data.singleImeiDetails.multipleSimStatusInterp==null){
			$("#viewblockmultipleSimStatus").val('NA')
		}
		$("#viewsingleblockserialNumber").val(data.singleImeiDetails.deviceSerialNumber);
		if(data.singleImeiDetails.deviceSerialNumber=='' || data.singleImeiDetails.deviceSerialNumber==null){
			$("#viewsingleblockserialNumber").val('NA')
		}
		$("#viewsingleblockremark").val(data.singleImeiDetails.remark);
		$("#viewsingleblockIMEI1").val(data.singleImeiDetails.firstImei);
		$("#viewsingleblocTxnid").val(data.singleImeiDetails.txnId);
		$("#viewsingleblockCategory").val(data.singleImeiDetails.categoryInterp);
		$("#viewsingleblockremark").val(data.singleImeiDetails.remark);
		$("#viewsingleblockremarkReject").val(data.rejectedRemark);
		if(data.rejectedRemark=='' || data.rejectedRemark==null){
			$("#viewsingleblockremarkReject").val('NA')
		}	

		if(data.blockingType=='tilldate')
		{

			$("#viewsingleblockingType").val("Later ( Block time period : " +data.blockingTimePeriod+" )");
		}
		else{
			$("#viewsingleblockingType").val(data.blockingType);
		}

	}
	else
	{if(requestType=="3")
		{
         	$('#singleBlockDeviceHeading').text(editUnblock);
		}
		else{
           $('#singleBlockDeviceHeading').text($.i18n('editBlockDevice'));
		}
 		$("#editblockImeiDevice").openModal({dismissible:false});
 		$("#editblockdeviceIdType").val(data.singleImeiDetails.deviceIdType).change();
		if(data.singleImeiDetails.secondImei==null && data.singleImeiDetails.thirdImei==null && data.singleImeiDetails.fourthImei==null  )
		{
			
			$("#editsingleblockIMEI2").val("");
			$("#editsingleblockIMEI3").val("");
			$("#editsingleblockIMEI4").val("");
		}
		else if(data.singleImeiDetails.secondImei==null && data.singleImeiDetails.thirdImei==null && data.singleImeiDetails.fourthImei!=null )
		{
			
			$("#editsingleblockIMEI2").val("");
			$("#editsingleblockIMEI3").val("");
			$("#editsingleblockIMEI4").val(data.singleImeiDetails.fourthImei);
		}
		else if(data.singleImeiDetails.secondImei!=null && data.singleImeiDetails.thirdImei==null && data.singleImeiDetails.fourthImei==null)
		{
			$("#editsingleblockIMEI2").val(data.singleImeiDetails.secondImei);
			$("#editsingleblockIMEI3").val("");
			$("#editsingleblockIMEI4").val("");
		}
		else if(data.singleImeiDetails.secondImei==null && data.singleImeiDetails.thirdImei!=null && data.singleImeiDetails.fourthImei==null)
		{
			
			$("#editsingleblockIMEI2").val("");
			$("#editsingleblockIMEI3").val(data.singleImeiDetails.thirdImei);
			$("#editsingleblockIMEI4").val("");
		}
		else if(data.singleImeiDetails.secondImei!=null && data.singleImeiDetails.thirdImei!=null && data.singleImeiDetails.fourthImei!=null)
		{
			
			$("#editsingleblockIMEI2").val(data.singleImeiDetails.secondImei);
			$("#editsingleblockIMEI3").val(data.singleImeiDetails.thirdImei);
			$("#editsingleblockIMEI4").val(data.singleImeiDetails.fourthImei);
		}
		else{
			////console.log("else############");
		}
		////console.log("device id type="+data.singleImeiDetails.deviceIdType);
		$("#editblockdeviceType").val(data.singleImeiDetails.deviceType).change();
	
		$("#editblockmultipleSimStatus").val(data.singleImeiDetails.multipleSimStatus).change();
		$("#editsingleblockserialNumber").val(data.singleImeiDetails.deviceSerialNumber);
		$("#editsingleblockremark").val(data.singleImeiDetails.remark);
		$("#editsingleblockIMEI1").val(data.singleImeiDetails.firstImei);
		$("#editsingleblockTxnid").val(data.singleImeiDetails.txnId);
		$("#editbulkBlockdeviceCategory").val(data.singleImeiDetails.category);

		$('input[name=editbulkBlockdeviceradio][value='+data.blockingType+']').attr('checked', true); 

		if(data.blockingType=='tilldate')
		{
			$("#calender").css("display", "block"); 

			$("#stolenDatePeriodedit").val(data.blockingTimePeriod);
		}
		else{
			$("#calender").css("display", "none"); 
		}
		//$('input[name=editbulkBlockdeviceradio][value='+data[i].blockingTimePeriod+']').attr('checked', true); 
		$("#editsingleblocRequestType").val(requestType);
	}

}




function updateSingleBlockDevicesRequest()
{
		if($('#editblockdeviceIdType').val()==0){
		var luhnIMEI1=luhnCheck('editsingleblockIMEI1','editblockdeviceIdType');
		var luhnIMEI4=null;
		var luhnIMEI3=null;
		var luhnIMEI2=null;
		if($('#editsingleblockIMEI2').val()!=null || $('#editsingleblockIMEI2').val()!=''){
			var luhnIMEI2 =luhnCheck('editsingleblockIMEI2','editblockdeviceIdType')	
		}
		else if($('#editsingleblockIMEI3').val()!=null || $('#editsingleblockIMEI3').val()!=''){
			var luhnIMEI3 = luhnCheck('editsingleblockIMEI3','editblockdeviceIdType')	
		}
		
		else if($('#editsingleblockIMEI4').val()!=null || $('#editsingleblockIMEI4').val()!=''){
			 luhnIMEI4= luhnCheck('editsingleblockIMEI4','editblockdeviceIdType')	
		}
		
		//alert("luhnIMEI1 "+luhnIMEI1+" luhnIMEI2 = "+luhnIMEI2+" luhnIMEI3 "+luhnIMEI3+" luhnIMEI4 = "+luhnIMEI4);
		if(luhnIMEI1==false || luhnIMEI2==false || luhnIMEI3==false || luhnIMEI4==false)
		{
			//alert("failed");
			return false
		}
	
		var checkIMEI=checkDuplicateImei($('#editsingleblockIMEI1').val(),$('#editsingleblockIMEI2').val(),$('#editsingleblockIMEI3').val(),$('#editsingleblockIMEI4').val());
		if(checkIMEI===true){
		$('#errorMsgOnModal').text('');
		$('#errorMsgOnModal').text($.i18n('duplicateImeiMessage'));
		return false;
	}
	}
	$('div#initialloader').fadeIn('fast');
	var deviceType=$('#editblockdeviceType').val();
	var blockdeviceIdType=$('#editblockdeviceIdType').val();
	var multipleSimStatus=$('#editblockmultipleSimStatus').val();
	var serialNumber=$('#editsingleblockserialNumber').val();
	var remark=$('#editsingleblockremark').val();
	var IMEI1=$('#editsingleblockIMEI1').val();
	var IMEI2=$('#editsingleblockIMEI2').val();
	var IMEI3=$('#editsingleblockIMEI3').val();
	var IMEI4=$('#editsingleblockIMEI4').val();
	var txnId=$('#editsingleblockTxnid').val();
	var requestType=$('#editsingleblocRequestType').val();
	var blockingTimePeriod=$('#stolenDatePeriodedit').val();
	var blockingType =$('.blocktypeRadio:checked').val();
	var category=$('#editbulkBlockdeviceCategory').val();


	////console.log("****");
	//////console.log("sucess include deviceType="+deviceType+" multipleSimStatus="+multipleSimStatus+" serialNumber="+serialNumber+" remark="+remark+" IMEI1="+IMEI1 );

	var singleImeiBlockDetail={

			'deviceType':deviceType,
			'deviceIdType':blockdeviceIdType,
			'multipleSimStatus':multipleSimStatus,
			'deviceSerialNumber':serialNumber,
			'firstImei':IMEI1,
			'secondImei':IMEI2,
			'thirdImei':IMEI3,
			'fourthImei':IMEI4,
			'requestType':requestType,
			'remark':remark,
			'txnId':txnId,
			'sourceType': 4,
			'blockingTimePeriod':blockingTimePeriod,
			'blockingType':blockingType,
			'category':category,
			'deviceQuantity':1
	}

	////console.log(JSON.stringify(singleImeiBlockDetail));
	////console.log("*********");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './updateBlockUnBlockSingleDevices',
		data : JSON.stringify(singleImeiBlockDetail),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success: function (data, textStatus, jqXHR) {

			$('div#initialloader').delay(300).fadeOut('slow');
			////console.log(data);

			if(data.errorCode==5){
				$('#confirmEditBlockUnblock').openModal({dismissible:false});
				$("#stockupdateSucessMessage").text('');
				$("#stockupdateSucessMessage").text($.i18n(data.tag));
			}
			else if(data.errorCode==1){
				$('#confirmEditBlockUnblock').openModal({dismissible:false});
			}
			else if(data.errorCode==0){
				$('#confirmEditBlockUnblock').openModal({dismissible:false});
			}
			else{
				$('#confirmEditBlockUnblock').openModal({dismissible:false});
				$("#stockupdateSucessMessage").text('');
				$("#stockupdateSucessMessage").text($.i18n('errorMsg'));
			}
			/*		 if(data.errorCode==200){

		     $('#singleDeviceBlockMessage').text('');
			 $('#singleDeviceBlockMessage').text(data.message);
				 }
			 else{
				 $('#singleDeviceBlockMessage').text('');
 				 $('#singleDeviceBlockMessage').text(data.message);
			 }*/
			// $('#updateConsignment').modal('open'); 
			//alert("success");

		},
		error: function (jqXHR, textStatus, errorThrown) {
			$('div#initialloader').delay(300).fadeOut('slow');
			////console.log("error in ajax")
		}
	});
	return false;
}




$('#stolenDatePeriod').datepicker({
	dateFormat: "yy-mm-dd",
	minDate: "0"

});

$('#stolenDatePeriodedit').datepicker({
	dateFormat: "yy-mm-dd",
	minDate: "0"
});

$('#stolenDatePeriodUnblock').datepicker({
	dateFormat: "yy-mm-dd"
});


function singleImeiFormClear(){
	$('#editSingleImeiform').trigger("reset");
	//$('input[name=editbulkBlockdeviceradio]').attr('checked', false);
}



function fileTypeValueChanges(formType) {

	if(formType=='2')
	{
		var uploadedFileName = $("#editselectBulkBlockuploadFile").val();
		uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
		var ext = uploadedFileName.split('.').pop();

		var fileSize = ($("#editselectBulkBlockuploadFile")[0].files[0].size);
		fileSize = (Math.round((fileSize / 1024) * 100) / 100)
		if (uploadedFileName.length > 30) {
			$('#fileFormateModal').openModal({dismissible:false});

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
	else 
	{

		var uploadedFileName = $("#blockBulkFile").val();
		uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
		var ext = uploadedFileName.split('.').pop();

		var fileSize = ($("#blockBulkFile")[0].files[0].size);
		fileSize = (Math.round((fileSize / 1024) * 100) / 100)
		if (uploadedFileName.length > 30) {
			$('#fileFormateModal').openModal({dismissible:false});

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


}


function clearFileName() {
	$('#unblockFileName').val('');
	$("#blockBulkFile").val('');
	$('#unblockFileName').val('');
	$("#editselectBulkBlockuploadFile").val('');
	$("#editBulkBlockuploadFile").val('');
	$('#fileFormateModal').closeModal();
}


$("input[type=file]").keypress(function(ev) {
	return false;
	//ev.preventDefault(); //works as well

});


$('#blockdeviceIdType').on('change', function() {
	var value=parseInt($(this).val());

	switch (value) {
	case 0:
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").val('');
		/*$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("pattern","[0-9]{15,16}");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("maxlength","16");
*/
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").removeAttr("onkeyup");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");

		$('#errorMsgOnModal').text($.i18n('IMEIMsg'));

		break;
	case 1:
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("pattern","[A-F0-9]{15,16}");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("maxlength","16");

		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").removeAttr("onkeyup");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$('#errorMsgOnModal').text($.i18n('MEIDMsg'));
		break;
	case 2:
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").val('');
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("pattern","[0-9]{8,11}");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("onkeyup","isLengthValid(this.value)");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("maxlength","11");	
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#errorMsgOnModal").text($.i18n('ESNMsg'));
		break;
	}

}); 

function isLengthValid(val){
	var deviceIDLength=val.length;
	if(!isNaN(val)){
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("pattern","[0-9]{11,11}");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("maxlength","11");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
	}
	else if(typeof val == 'string' || val instanceof String){
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("maxlength","8");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("pattern","[A-F0-9]{8,8}");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");
		$("#singleblockIMEI1,#singleblockIMEI2,#singleblockIMEI3,#singleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");

	}
}






$('#UnblockdeviceIdType').on('change', function() {
	var value=parseInt($(this).val());

	switch (value) {
	case 0:
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").val('');
	/*	$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("pattern","[0-9]{15,16}");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("maxlength","16");
*/
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").removeAttr("onkeyup");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");

		$('#errorMsgOnModal').text($.i18n('IMEIMsg'));

		break;
	case 1:
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("pattern","[A-F0-9]{15,16}");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("maxlength","16");

		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").removeAttr("onkeyup");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$('#errorMsgOnModal').text($.i18n('MEIDMsg'));
		break;
	case 2:
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").val('');
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("pattern","[0-9]{8,11}");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("onkeyup","isLengthValid(this.value)");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("maxlength","11");	
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#errorMsgOnModal").text($.i18n('ESNMsg'));
		break;
	}

}); 

function isLengthValid(val){
	var deviceIDLength=val.length;
	if(!isNaN(val)){
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("pattern","[0-9]{11,11}");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("maxlength","11");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
	}
	else if(typeof val == 'string' || val instanceof String){
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("maxlength","8");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("pattern","[A-F0-9]{8,8}");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");
		$("#unbockSingleIMEI1,#unbockSingleIMEI2,#unbockSingleIMEI3,#unbockSingleIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");

	}
}