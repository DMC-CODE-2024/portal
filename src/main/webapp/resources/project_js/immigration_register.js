var input = document.querySelector("#phone");
window.intlTelInput(input, {
    utilsScript: "${context}/resources/js/utils.js",
});


$('#langlist').on('change', function() {
	window.lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	var url_string = window.location.href;
	var url = new URL(url_string);
	var type = url.searchParams.get("type");
	window.location.assign("immigration_register?lang="+window.lang);			
}); 


$('#langlist').val(data_lang_param);
$.i18n().locale = data_lang_param;
var successMsg;
$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
} ).done( function() { 
});



$('#datepicker,#datepicker1').datepicker({
	dateFormat: "yy-mm-dd"
});


populateCountries(
		"country",
		"state"
);
populateStates(
		"country",
		"state"
);

populateCountries(
		"country1"

);



function removeSelectVip()
{
	$("#vipUserDiv").css("display", "none");	
	$('#vipUserDiv').find('input:text').val('');
	$('#vipUserDiv').find('input:file').val('');

	$("#departmentName").removeAttr('required');
	$("#endUserdepartmentID").removeAttr('required');
	$("#endUserDepartmentId").removeAttr('required');
}

function  selectVip(){

	$("#vipUserDiv").css("display", "block");
	$("#departmentName").attr("required", true);
	$("#endUserdepartmentID").attr("required", true);
	$("#endUserDepartmentId").attr("required", true);

}

function showVisaDetails(){
	$("#visaDetails").css("display", "block");
	$("#datepicker").attr("required", true);
	//$("#visaNumber").attr("required", true);
	$("#visaImage").attr("required", true);
	$("#datepicker1").attr("required", true);
	$("#visaType").attr("required", true);

}

function showOtherUserForm()
{
	$('#endUserLabelNID').text($.i18n('Passport Number'));
	$('#nidType').text($.i18n('Upload Passport Image'));
	$("#askVisaDetails").css("display", "block");
	$("#nationalityDiv").css("display", "block");
	$("#onVisaNo").prop("checked", true);
	$("#nidPlaceHolder").attr("placeholder", $.i18n('Upload Passport Image ')).val("").focus().blur();

	$("#nationality").attr("required", true);
	$("#endUserLabelNID").append('<span class="star">*</span>');
	$("#nidType").append('<span class="star">*</span>');



}


$.getJSON('./getDropdownList/VISA_TYPE', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#visaType');

	}
});
$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#deviceType1');

	}
});
$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#deviceIdType1');

	}
});
$.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#multipleSimStatus1');

	}
});
$.getJSON('./getDropdownList/DEVICE_STATUS', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#deviceStatus1');

	}
});












$(document).ready(function () {

	$('#langlist').val(data_lang_param);
	var max_fields = 15; //maximum input boxes allowed
	var wrapper = $(".mainDeviceInformation"); //Fields wrapper
	var add_button = $(".add_field_button"); //Add button ID
	var x = 1; //initlal text box count
	var id=2;
	$(add_button).click(function (e) { //on add input button click
		e.preventDefault();
		if (x < max_fields) { //max input box allowed
			x++; //text box increment


			$(wrapper).append(
					
					'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default" required id="deviceIdType'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+'</label><select class="browser-default"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+' </label><select class="browser-default"  id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry">'+$.i18n('country')+'</label><select id="country'+id+'"  class="browser-default" class="mySelect" style="padding-left: 0;" ></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" name="serialNumber'+id+'"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+'</label></div><div class="row"><div class="col s12 m6" ><label for="deviceStatus'+id+'">'+$.i18n('deviceStatus')+'</label><select class="browser-default"  style="margin-top: 5px;" id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEIA'+id+'" required name="IMEI1" pattern="[0-9]{15,16}"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" name="IMEI2" pattern="[0-9]{15,16}"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'

			);  //add input box

			
			$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {
				var dropdownid=id-1;
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#deviceType'+dropdownid);

				}
			});
			$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
				var dropdownid=id-1;
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#deviceIdType'+dropdownid);

				}
			});
			$.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {
				var dropdownid=id-1;
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#multipleSimStatus'+dropdownid);

				}
			});
			$.getJSON('./getDropdownList/DEVICE_STATUS', function(data) {
				var dropdownid=id-1;
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#deviceStatus'+dropdownid);

				}
			});
			populateCountries
			(   
					"country"+id
			);
id++;
		}
	});
	$(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
		e.preventDefault();
		$(this).parent('div').remove();
		x--;
	})
});





function submitImmigrationForm(){
	var formData= new FormData();
	var nationalID=$('#endUserNID').val();
	var endUserNID=$('#endUserNID').val();
	var firstName=$('#endUserfirstName').val();
	var middleName=$('#endUsermiddleName').val();
	var lastName=$('#endUserlastName').val();
	var address=$('#address').val();
	var streetNumber=$('#streetNumber').val();
	var locality=$('#locality').val();
	var village=$('#village').val();
	var country=$('#country').val();
	var state=$('#state').val();
	var email=$('#endUseremailID').val();
	var phone=$('#phone').val();
	var state=$('#state').val();
	var docType=$('#doc_type').val();
	var doc_type_numeric=$("#doc_type option:selected").attr("docValue");
	var district=$('#endUserdistrict').val();
	var commune=$('#commune').val();
	var postalcode=$('#pin').val();
	var nationality=$('#nationality').val();

	var departmentName=$('#departmentName').val();
	var departmentFileID=$('#endUserDepartmentId').val();
	var departmentID=$('#endUserdepartmentID').val();
	var postalcode=$('#pin').val();

	var isVip=$('input[name="selectvip"]:checked').val();
	var onVisa=$('input[name="onVisa"]:checked').val();

	if(onVisa==undefined){
		onVisa='N';
	}
	var visaType=$('#visaType').val();
	var visaDate=$('#datepicker').val();
	var visaNumber=$('#visaNumber').val();
	var visaExpirydate=$('#datepicker1').val();
	var visaImage=$('#visaImage').val();

	if(visaNumber=="")
	{
		visaNumber=null;
	}

	if(visaImage==""){
		visaImage="";

	}
	else if(visaImage==undefined){
		visaImage="";

	}
	else{
		visaImage=$('#visaImage').val().replace('C:\\fakepath\\','');
		formData.append('visaImage', $('#visaImage')[0].files[0]);

	}


	var visaDb=[];
	var visa={
			"visaType":visaType,
			"visaExpiryDate":visaExpirydate,
			"entryDateInCountry":visaDate,
			"visaFileName": visaImage,
			"visaNumber": visaNumber,
			"visaType": visaType
	}
	visaDb.push(visa);
	if(departmentFileID=="")
	{
		departmentFileID="";


	}
	else if(departmentFileID==undefined){
		departmentFileID="";

	}
	else{
		departmentFileID=$('#endUserDepartmentId').val().replace('C:\\fakepath\\','');
		formData.append('endUserDepartmentFile', $('#endUserDepartmentId')[0].files[0]); 

	}
	var departmentDetails={

			"departmentId": departmentID,
			"name": departmentName,
			"departmentFilename":departmentFileID
	}



	var fieldId=1;
	var regularizeDeviceDbs =[];
	$('.deviceInformation').each(function() {
		var deviceType1=$('#deviceType'+fieldId).val();
		var serialNumber1=$('#serialNumber'+fieldId).val();
		var deviceIdType1=$('#deviceIdType'+fieldId).val();
		var deviceStatus1=$('#deviceStatus'+fieldId).val();
		var IMEI1=$('#IMEIA'+fieldId).val();
		var IMEI2=$('#IMEIB'+fieldId).val();
		var IMEI3=$('#IMEIC'+fieldId).val();
		var IMEI4=$('#IMEID'+fieldId).val();
		var deviceCountry=$('#country'+fieldId).val();
		var multipleSimStatus1=$('#multipleSimStatus'+fieldId).val();




		var deviceInfo=
		{
				"country": deviceCountry,

				"deviceIdType": parseInt(deviceIdType1),
				"deviceSerialNumber": serialNumber1,
				"deviceStatus": parseInt(deviceStatus1),
				"deviceType": parseInt(deviceType1),
				"firstImei": IMEI1,
				"secondImei": IMEI2,
				"thirdImei": IMEI3,
				"fourthImei": IMEI4,
				"multiSimStatus": deviceStatus1,
				"nid":nationalID,
				"origin":"Immigration"

		}
		regularizeDeviceDbs.push(deviceInfo);
		fieldId++;


	});



	var request={
			"country": country,
			"email": email,
			"firstName": firstName,
			"lastName": lastName,
			"locality": locality,
			"middleName": middleName,
			"nid": nationalID,
			"phoneNo": phone,
			"propertyLocation": address,
			"province": state,
			"street": streetNumber,
			"regularizeDeviceDbs":regularizeDeviceDbs,
			"visaDb":visaDb,
			"nationality":nationality,
			"userDepartment":departmentDetails,
			"district":district,
			"isVip":isVip,
			"onVisa":onVisa,
			"commune":commune,
			"village":village,
			"postalCode":postalcode,
			"doc_type_numeric":docType,
			"docType":doc_type_numeric
	}
	formData.append('uploadnationalID', $('#uploadnationalID')[0].files[0]);
	formData.append("request",JSON.stringify(request));
	$.ajax({
		url: './registerEndUserDevice',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {

			////console.log(data);


			if(data.errorCode==0){

//				$('#sucessMessage').text('');
				$('#endUserRegisterDeviceModal').openModal();
				$('#endUsertXnId').text(data.txnId);
				$("#endUserRegisterButton").prop('disabled', true);
			}
			else{
//				$('#sucessMessage').text('');
				$('#endUserRegisterDeviceModal').openModal();
				$('#sucessMessageId').text('');
				$('#sucessMessageId').text(data.message);
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")

		}
	});
	return false;
}


$(document).on("keyup", "#visaNumber", function(e) {
	var visaNumber=$('#visaNumber').val();
	if(visaNumber.length<'1' )
	{
		$("#datepicker1").attr("required", false);
		/*$('#currency').attr("disabled",true);*/
		$('#visaExpiryDateDiv').hide();

	}
	else
	{
		$("#datepicker1").attr("required", true);
		/*$('#currency').attr("disabled",false);*/
		$('#visaExpiryDateDiv').show();

	}
});


function fileTypeValueChanges(id) {

	var uploadedFileName = $("#"+id).val();
	uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
	////alert("file extension=="+uploadedFileName)
	var ext = uploadedFileName.split('.').pop();

	var fileSize = ($("#"+id)[0].files[0].size);
	/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
	//alert("----"+fileSize);*/
	fileSize = Math.floor(fileSize/1000) + 'KB';

	////alert(uploadedFileName+"----------"+ext+"----"+fileSize)

	if (uploadedFileName.length > 30) {
		$('#fileFormateModal').openModal();
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageMessage'));
	} 
	else if(ext !='png')
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
	$('#nidPlaceHolder').val('');
	$("#uploadnationalID").val('');
	$('#fileFormateModal').closeModal();
}


function visaImageValidation() {
	var uploadedFileName = $("#visaImage").val();
	uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
	////alert("file extension=="+uploadedFileName)
	var ext = uploadedFileName.split('.').pop();

	var fileSize = ($("#visaImage")[0].files[0].size);
	/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
	//alert("----"+fileSize);*/
	fileSize = Math.floor(fileSize/1000);



	if (uploadedFileName.length > 30) {
		$('#visafileFormateModal').openModal({dismissible:false});
		$('#visafileErrormessage').text('');
		$('#visafileErrormessage').text($.i18n('imageMessage'));
	} 
	else if(ext!='png')
	{
		$('#visafileFormateModal').openModal({
			dismissible:false
		});
		$('#visafileErrormessage').text('');
		$('#visafileErrormessage').text($.i18n('imageMessage'));

	}
	else if(fileSize>='100'){
		$('#visafileFormateModal').openModal({
			dismissible:false
		});
		$('#visafileErrormessage').text('');
		$('#visafileErrormessage').text($.i18n('imageSize'));	
	}



}


function clearVisaName() {
	$('#visaImage').val('');
	$("#ensUserVisaPlaceHolder").val('');
	$('#visafileFormateModal').closeModal();
}



function deptImageValidation() {
	var uploadedFileName = $("#endUserDepartmentId").val();
	uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
	////alert("file extension=="+uploadedFileName)
	var ext = uploadedFileName.split('.').pop();

	var fileSize = ($("#endUserDepartmentId")[0].files[0].size);
	/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
	//alert("----"+fileSize);*/
	fileSize = Math.floor(fileSize/1000);



	if (uploadedFileName.length > 30) {
		$('#DeptfileFormateModal').openModal({dismissible:false});
		$('#DeptfileErrormessage').text('');
		$('#DeptfileErrormessage').text($.i18n('imageMessage'));
	} 
	else if(ext!='png')
	{
		$('#DeptfileFormateModal').openModal({
			dismissible:false
		});
		$('#DeptfileErrormessage').text('');
		$('#DeptfileErrormessage').text($.i18n('imageMessage'));

	}
	else if(fileSize>='100'){
		$('#DeptfileFormateModal').openModal({
			dismissible:false
		});
		$('#DeptfileErrormessage').text('');
		$('#DeptfileErrormessage').text($.i18n('imageSize'));	
	}



}


function clearDeptName() {
	$('#endUserDepartmentId').val('');
	$("#endUSerNidaPlaceholder").val('');
	$('#visafileFormateModal').closeModal();
}
