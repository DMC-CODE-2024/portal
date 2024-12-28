var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
//var featureId =12;
var nationalID = $("body").attr("session-value");
// iframe
var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

if(roleType=="Immigration")
	{
	
	//$("#nationalityLabelId").css("display", "none");
	//$("#chooseUserOption").css("display", "none");
	$("#priceDiv").css("display", "none");
//	$("#nationalityDiv").css("display", "block");
	//$("#entryCountryDiv").css("display", "block");
	$("#askVisaDetails").css("display", "block");
	$('#doc_type').val('0');
	//$("#taxStatusDiv").css("display", "none");
	$("#priceDiv").css("display", "none");
	//$('#nidLabelName').text('');
	//$('#nidLabelName').text($.i18n('Passport Number'));
 	//$('#uploadNidImage').text('');
 	//$('#uploadNidImage').text($.i18n('Upload Passport Image'));
 	//$("#nidLabelName").append('<span class="star">*</span>');
 	//$("#uploadNidImage").append('<span class="star">*</span>');
 	$("#taxStatus1").attr("required", false);
	}

// Internationalization
$.i18n().locale = lang;
var rejectedMsg,consignmentApproved,errorMsg,havingTxnID,updateMsg,hasBeenUpdated,consignmentDeleted,deleteInProgress;
$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
}).done( function() { 
});

$( document ).ready(function() {
	var userStatus = $("body").attr("data-userStatus");
	var In = $("body").attr("session-value");
	 var loggedUserType=$("body").attr("data-roleType");
	if((loggedUserType=='Custom' || loggedUserType=='Immigration') && $("body").attr("data-filterSource")!='dashboard' ){
				var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		var enterdNid = In.replace("#", "%23");
		$.ajax({
			url : "./paid-status/"+enterdNid,
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'GET',
			success : function(data) {
				sessionStorage.setItem("nationalId", In);
				localStorage.setItem("nationalId", In);
				
				if(data.data!=null || data.data==""){
				sessionStorage.setItem("nationality",data.data.nationality);
				}
				else if(data.data==null){
					
					sessionStorage.removeItem("nationality")
				}
				if (data.errorCode == 1) {
					pageRendering(lang);
					filter(lang,null);
					$("#user123").css("display", "none");
					$("#user456").css("display", "block");
					$("#addbutton").css("display", "block");
					$("#submitbtn").css("display", "none");
					$("#btnLink").css({display: "block"});
					sessionStorage.removeItem("ViewAll");
				} 
				else if (data.errorCode == 2) {
					pageRendering(lang);
					filter(lang,null);
					$("#user123").css("display", "none");
					$("#user456").css("display", "block");
					$("#addbutton").css("display", "block");
					$("#submitbtn").css("display", "none");
					$("#btnLink").css({display: "none"});
					sessionStorage.setItem("ViewAll","ViewAll");
				} 
				else if (data.errorCode == 0 && In == null) { 
						$("#user123").css("display", "none");
						$("#user456").css("display", "block");
						$("#addbutton").css("display", "block");
						$("#submitbtn").css("display", "none");
					
				} 
				else
					if(userStatus=="Disable" || userStatus=="Deactivate"){
						$("#user123").css("display", "block");
						$('div#initialloader').delay(300).fadeOut('slow');
						$('#userDisabledModel').openModal({dismissible:false});
					}
					else{
						$("#user123").css("display", "block");
						$("#user456").css("display", "none");
						$("#addbutton").css("display", "none");
						$("#submitbtn").css("display", "none");
						$("#btnLink").css({display: "none"});
						$('div#initialloader').delay(300).fadeOut('slow');
					}
				$('#nationalID').val(In);
				regularizedCount();
			},
			error : function() {
				//////console.log("Failed");
			}
		}); 
		


	}
	else if($("body").attr("data-filterSource")=='dashboard'){
		//alert("dashboard");
		$("#user123").css("display", "none");
		$("#user456").css("display", "block");
		$("#addbutton").css("display", "block");
		$("#submitbtn").css("display", "none");
		pageRendering(lang);
		filter(lang,null);
		$("#btnLink").css({display: "none"});
		}
	else{
		////alert("a")
		/*$.ajax({
			url : "./paid-status/"+In,
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'GET',
			success : function(data) {

				//	sessionStorage.removeItem('nationalId');

				if (data.errorCode == 1) {
					//alert("1");
					$("#user123").css("display", "none");
					$("#user456").css("display", "block");
					$("#addbutton").css("display", "block");
					$("#submitbtn").css("display", "none");
				} 
				else if (data.errorCode == 0 && In == 'null') {
					//alert("2");
					$("#user123").css("display", "none");
					$("#user456").css("display", "block");
					$("#addbutton").css("display", "block");
					$("#submitbtn").css("display", "none");
				} 
				else
				{
					//alert("3");
					$("#user123").css("display", "block");
					$("#user456").css("display", "none");
					$("#addbutton").css("display", "none");
					$("#submitbtn").css("display", "none");	
				}
				$('#nationalID').val(In);
				regularizedCount();
			},
			error : function() {
				//////console.log("Failed");
			}
		}); */
		/*pageRendering(lang);
		filter(lang);
*/	
		$("#user123").css("display", "none");
					$("#user456").css("display", "block");
					$("#addbutton").css("display", "block");
					$("#submitbtn").css("display", "none");
		pageRendering(lang);
        filter(lang,null);
		$("#btnLink").css({display: "none"});


	}



});


var id=2;
var x = 1;
$(document).ready(function () {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	}); 
	$.getJSON('./addMoreFile/add_more_device_count', function(data) {
			//////console.log(data);
			
			localStorage.setItem("maxCount", data.value);
			
		});
	 
	 var max_fields =localStorage.getItem("maxCount");
	 if (max_fields==0){
		 //////console.log("1111");
		 $(".add_field_button").prop('disabled', true);
	 }		
			//////console.log("maximum fields for add more  from api="+max_fields);
	//var max_fields = 15; //maximum input boxes allowed
	var wrapper = $(".mainDeviceInformation"); //Fields wrapper
	var add_button = $(".add_field_button"); //Add button ID
	 //initlal text box count
	
	$(add_button).click(function (e) { //on add input button click
		e.preventDefault();
		var nationType= localStorage.getItem("nationType");
		
		if (x < max_fields) { //max input box allowed
			x++; //text box increment
//////console.log("nationType=="+nationType);
			if (nationType=='1')
			{
				
				if(roleType=="Immigration"){
					$(wrapper).append(
							
							
							/*  '<div style="margin-top:30px;"><div class="row"><div class="col s12 m6"><label for="deviceType">Device Type <spanclass="star">*</span></label><select class="browser-default" id='"deviceType"+id+"'><option value="" disabled selected>Device Type</option><option value='Handheld'>Handheld</option><option value='MobilePhone'>Mobile Phone/Feature phone</option><option value='Vehicle'>Vehicle</option><option value='Portable'>Portable(include PDA)</option><option value='Module'>Module</option><option value='Dongle'>Dongle</option><option value='WLAN'>WLAN Router</option><option value='Modem'>Modem</option><option value='Smartphone'>Smartphone</option><option value='Computer'>Connected Computer</option><option value='Tablet'>Tablet</option><option value='e-Book'>e-Book</option></select></div><div class='col s12 m6'><label for='deviceIdType'>Device ID Type <span class='star'>*</span></label><select class='browser-default' id='deviceIdType'><option value="" disabled selected>Select Device ID Type</option><option value='IMEI'>IMEI</option><option value='ESN'>ESN</option><option value='MEID'>MEID</option></select></div><div class='col s12 m6'><label for='deviceType'>Multiple Sim Status <span class='star'>*</span></label><select class='browser-default' id='deviceType'><option value="" disabled selected>Multiple Sim Status</option><option value='Yes'>Yes</option><option value='No'>No</option></select></div><div class='col s12 m6'><label for='country'>Country bought From <span class='star'>*</span></label><select id='country1' class='browser-default' class='mySelect' style='padding-left: 0;' required></select></div><div class='input-field col s12 m6' style='margin-top: 28px;'><input type='text' id='serialNumber1' name='serialNumber1' pattern='[0-9]' title='Please enter your device serial number first' maxlength='20'><label for='serialNumber1'>Device Serial Number <span class='star'>*</span></label></div><div class='col s12 m6'><label for='deviceType'>Tax paid Status <span class='star'>*</span></label><select class='browser-default' id='deviceType'><option value="" disabled selected>Tax paid Status</option><option value='Regularized'>Regularized</option><option value='Paid'>Paid</option><option value='NotPaid'>Not Paid</option></select></div></div><div class='row'><div class='col s12 m6' style='margin-top: -10px;'><label for='taxStatus'>Device Status <span class='star'>*</span></label><select class='browser-default' id='taxStatus'><option value='' disabled selected>Select Device Status</option><option value='New'>New</option><option value='Used'>Used</option><option value='Refurbished'>Refurbished</option></select></div><div class='input-field col s12 m6 l6'><input type='text' name='Price' id='Price' maxlength='30'><label for='Price'>Price <span class='star'>*</span></label></div><div class='col s12 m6'><label for='Currency'>Currency <span class='star'>*</span></label><select class='browser-default' id='Currency'><option value='' disabled selected>Select Currency</option><option value='Regularized'>$</option><option value='Paid'>$</option><option value="NotPaid">$</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEI1" name="IMEI1" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI1">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEI2" name="IMEI2" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI2">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEI3" name="IMEI3" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI3">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEI4" name="IMEI4[]" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI4">4</label></div></div><div style="cursor:pointer;background-color:red;' class='remove_field btn right btn-info'>Remove</div></div>'*/
							'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+'<spanclass="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required id="deviceIdType'+id+'" onchange="changeImeiEsnValidation(deviceIdType'+id+')"><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+' <span class="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry"> '+$.i18n('countryBoughtFrom')+'<span class="star"></span></label><select id="country'+id+'"  class="browser-default" class="mySelect" style="padding-left: 0;" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" name="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+' <span class="star"></span></label></div><div class="row"><div class="col s12 m6" style="margin-top:0px;"><label for="deviceStatus'+id+'"> '+$.i18n('deviceStatus')+'<span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');" required id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" id="IMEIA'+id+'" required name="IMEI1" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" name="IMEI2" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
		                  //'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default"  id="deviceIdType'+id+'" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required ><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+'</label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+' </label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');" id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry">'+$.i18n('country')+'</label><select id="country'+id+'" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  class="browser-default" class="mySelect" style="padding-left: 0;" ></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');" name="serialNumber'+id+'"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+'</label></div><div class="row"><div class="col s12 m6" ><label for="deviceStatus'+id+'">'+$.i18n('deviceStatus')+'</label><select class="browser-default" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceStatus')+'\');"  style="margin-top: 5px;" id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEIA'+id+'"  required name="IMEI1" pattern="[0-9]{15,16}"  maxlength="16" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" name="IMEI2" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title=""  oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
					); 
				}
				else if(nationType=='1'){
				$(wrapper).append(
						
						
						/*  '<div style="margin-top:30px;"><div class="row"><div class="col s12 m6"><label for="deviceType">Device Type <spanclass="star">*</span></label><select class="browser-default" id='"deviceType"+id+"'><option value="" disabled selected>Device Type</option><option value='Handheld'>Handheld</option><option value='MobilePhone'>Mobile Phone/Feature phone</option><option value='Vehicle'>Vehicle</option><option value='Portable'>Portable(include PDA)</option><option value='Module'>Module</option><option value='Dongle'>Dongle</option><option value='WLAN'>WLAN Router</option><option value='Modem'>Modem</option><option value='Smartphone'>Smartphone</option><option value='Computer'>Connected Computer</option><option value='Tablet'>Tablet</option><option value='e-Book'>e-Book</option></select></div><div class='col s12 m6'><label for='deviceIdType'>Device ID Type <span class='star'>*</span></label><select class='browser-default' id='deviceIdType'><option value="" disabled selected>Select Device ID Type</option><option value='IMEI'>IMEI</option><option value='ESN'>ESN</option><option value='MEID'>MEID</option></select></div><div class='col s12 m6'><label for='deviceType'>Multiple Sim Status <span class='star'>*</span></label><select class='browser-default' id='deviceType'><option value="" disabled selected>Multiple Sim Status</option><option value='Yes'>Yes</option><option value='No'>No</option></select></div><div class='col s12 m6'><label for='country'>Country bought From <span class='star'>*</span></label><select id='country1' class='browser-default' class='mySelect' style='padding-left: 0;' required></select></div><div class='input-field col s12 m6' style='margin-top: 28px;'><input type='text' id='serialNumber1' name='serialNumber1' pattern='[0-9]' title='Please enter your device serial number first' maxlength='20'><label for='serialNumber1'>Device Serial Number <span class='star'>*</span></label></div><div class='col s12 m6'><label for='deviceType'>Tax paid Status <span class='star'>*</span></label><select class='browser-default' id='deviceType'><option value="" disabled selected>Tax paid Status</option><option value='Regularized'>Regularized</option><option value='Paid'>Paid</option><option value='NotPaid'>Not Paid</option></select></div></div><div class='row'><div class='col s12 m6' style='margin-top: -10px;'><label for='taxStatus'>Device Status <span class='star'>*</span></label><select class='browser-default' id='taxStatus'><option value='' disabled selected>Select Device Status</option><option value='New'>New</option><option value='Used'>Used</option><option value='Refurbished'>Refurbished</option></select></div><div class='input-field col s12 m6 l6'><input type='text' name='Price' id='Price' maxlength='30'><label for='Price'>Price <span class='star'>*</span></label></div><div class='col s12 m6'><label for='Currency'>Currency <span class='star'>*</span></label><select class='browser-default' id='Currency'><option value='' disabled selected>Select Currency</option><option value='Regularized'>$</option><option value='Paid'>$</option><option value="NotPaid">$</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEI1" name="IMEI1" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI1">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEI2" name="IMEI2" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI2">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEI3" name="IMEI3" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI3">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEI4" name="IMEI4[]" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI4">4</label></div></div><div style="cursor:pointer;background-color:red;' class='remove_field btn right btn-info'>Remove</div></div>'*/
						'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+'<spanclass="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required id="deviceIdType'+id+'" onchange="changeImeiEsnValidation(deviceIdType'+id+')"><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+' <span class="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry"> '+$.i18n('countryBoughtFrom')+'<span class="star"></span></label><select id="country'+id+'"  class="browser-default" class="mySelect" style="padding-left: 0;" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" name="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+' <span class="star"></span></label></div><div class="col s12 m6"><label for="taxStatus'+id+'">'+$.i18n('taxPaidStatus')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('taxPaidStatus')+'\');"oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('taxPaidStatus')+'\');" required id="taxStatus'+id+'"><option value="" disabled selected>'+$.i18n('taxPaidStatus')+'</option></select></div></div><div class="row"><div class="col s12 m6" style="margin-top: -10px;"><label for="deviceStatus'+id+'"> '+$.i18n('deviceStatus')+'<span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');" required id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div><div class="input-field col s12 m6 l6"><input type="text" name="Price" id="Price'+id+'" onkeyup=showHideCurrency()  oninput="InvalidMsg(this,\'input\',\''+$.i18n('price')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('price')+'\');"  maxlength="30"><label for="Price'+id+'">'+$.i18n('price')+' <span class="star"></span></label></div><div id="CurrencyDiv'+id+'" style="display:none" class="col s12 m6"><label for="Currency'+id+'">'+$.i18n('currency')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'input\',\''+$.i18n('currency')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('currency')+'\');"  id="Currency'+id+'"><option value="" disabled selected>'+$.i18n('selectCurrency')+'</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" id="IMEIA'+id+'" required name="IMEI1" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" name="IMEI2" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
	                  //'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default"  id="deviceIdType'+id+'" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required ><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+'</label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+' </label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');" id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry">'+$.i18n('country')+'</label><select id="country'+id+'" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  class="browser-default" class="mySelect" style="padding-left: 0;" ></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');" name="serialNumber'+id+'"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+'</label></div><div class="row"><div class="col s12 m6" ><label for="deviceStatus'+id+'">'+$.i18n('deviceStatus')+'</label><select class="browser-default" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceStatus')+'\');"  style="margin-top: 5px;" id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEIA'+id+'"  required name="IMEI1" pattern="[0-9]{15,16}"  maxlength="16" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" name="IMEI2" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title=""  oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
				); 
				}
			}
		else if(nationType=='2'){
			if(roleType=="Immigration"){
				$(wrapper).append(
						
						
						/*  '<div style="margin-top:30px;"><div class="row"><div class="col s12 m6"><label for="deviceType">Device Type <spanclass="star">*</span></label><select class="browser-default" id='"deviceType"+id+"'><option value="" disabled selected>Device Type</option><option value='Handheld'>Handheld</option><option value='MobilePhone'>Mobile Phone/Feature phone</option><option value='Vehicle'>Vehicle</option><option value='Portable'>Portable(include PDA)</option><option value='Module'>Module</option><option value='Dongle'>Dongle</option><option value='WLAN'>WLAN Router</option><option value='Modem'>Modem</option><option value='Smartphone'>Smartphone</option><option value='Computer'>Connected Computer</option><option value='Tablet'>Tablet</option><option value='e-Book'>e-Book</option></select></div><div class='col s12 m6'><label for='deviceIdType'>Device ID Type <span class='star'>*</span></label><select class='browser-default' id='deviceIdType'><option value="" disabled selected>Select Device ID Type</option><option value='IMEI'>IMEI</option><option value='ESN'>ESN</option><option value='MEID'>MEID</option></select></div><div class='col s12 m6'><label for='deviceType'>Multiple Sim Status <span class='star'>*</span></label><select class='browser-default' id='deviceType'><option value="" disabled selected>Multiple Sim Status</option><option value='Yes'>Yes</option><option value='No'>No</option></select></div><div class='col s12 m6'><label for='country'>Country bought From <span class='star'>*</span></label><select id='country1' class='browser-default' class='mySelect' style='padding-left: 0;' required></select></div><div class='input-field col s12 m6' style='margin-top: 28px;'><input type='text' id='serialNumber1' name='serialNumber1' pattern='[0-9]' title='Please enter your device serial number first' maxlength='20'><label for='serialNumber1'>Device Serial Number <span class='star'>*</span></label></div><div class='col s12 m6'><label for='deviceType'>Tax paid Status <span class='star'>*</span></label><select class='browser-default' id='deviceType'><option value="" disabled selected>Tax paid Status</option><option value='Regularized'>Regularized</option><option value='Paid'>Paid</option><option value='NotPaid'>Not Paid</option></select></div></div><div class='row'><div class='col s12 m6' style='margin-top: -10px;'><label for='taxStatus'>Device Status <span class='star'>*</span></label><select class='browser-default' id='taxStatus'><option value='' disabled selected>Select Device Status</option><option value='New'>New</option><option value='Used'>Used</option><option value='Refurbished'>Refurbished</option></select></div><div class='input-field col s12 m6 l6'><input type='text' name='Price' id='Price' maxlength='30'><label for='Price'>Price <span class='star'>*</span></label></div><div class='col s12 m6'><label for='Currency'>Currency <span class='star'>*</span></label><select class='browser-default' id='Currency'><option value='' disabled selected>Select Currency</option><option value='Regularized'>$</option><option value='Paid'>$</option><option value="NotPaid">$</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEI1" name="IMEI1" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI1">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEI2" name="IMEI2" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI2">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEI3" name="IMEI3" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI3">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEI4" name="IMEI4[]" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI4">4</label></div></div><div style="cursor:pointer;background-color:red;' class='remove_field btn right btn-info'>Remove</div></div>'*/
						'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+'<spanclass="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required id="deviceIdType'+id+'" onchange="changeImeiEsnValidation(deviceIdType'+id+')"><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+' <span class="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry"> '+$.i18n('countryBoughtFrom')+'<span class="star"></span></label><select id="country'+id+'"  class="browser-default" class="mySelect" style="padding-left: 0;" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" name="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+' <span class="star"></span></label></div><div class="row"><div class="col s12 m6" style="margin-top: 0px;"><label for="deviceStatus'+id+'"> '+$.i18n('deviceStatus')+'<span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');" required id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" id="IMEIA'+id+'" required name="IMEI1" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" name="IMEI2" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
	                  //'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default"  id="deviceIdType'+id+'" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required ><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+'</label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+' </label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');" id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry">'+$.i18n('country')+'</label><select id="country'+id+'" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  class="browser-default" class="mySelect" style="padding-left: 0;" ></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');" name="serialNumber'+id+'"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+'</label></div><div class="row"><div class="col s12 m6" ><label for="deviceStatus'+id+'">'+$.i18n('deviceStatus')+'</label><select class="browser-default" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceStatus')+'\');"  style="margin-top: 5px;" id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEIA'+id+'"  required name="IMEI1" pattern="[0-9]{15,16}"  maxlength="16" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" name="IMEI2" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title=""  oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
				); 
			}
			else{
			$(wrapper).append(
					
					
					/*  '<div style="margin-top:30px;"><div class="row"><div class="col s12 m6"><label for="deviceType">Device Type <spanclass="star">*</span></label><select class="browser-default" id='"deviceType"+id+"'><option value="" disabled selected>Device Type</option><option value='Handheld'>Handheld</option><option value='MobilePhone'>Mobile Phone/Feature phone</option><option value='Vehicle'>Vehicle</option><option value='Portable'>Portable(include PDA)</option><option value='Module'>Module</option><option value='Dongle'>Dongle</option><option value='WLAN'>WLAN Router</option><option value='Modem'>Modem</option><option value='Smartphone'>Smartphone</option><option value='Computer'>Connected Computer</option><option value='Tablet'>Tablet</option><option value='e-Book'>e-Book</option></select></div><div class='col s12 m6'><label for='deviceIdType'>Device ID Type <span class='star'>*</span></label><select class='browser-default' id='deviceIdType'><option value="" disabled selected>Select Device ID Type</option><option value='IMEI'>IMEI</option><option value='ESN'>ESN</option><option value='MEID'>MEID</option></select></div><div class='col s12 m6'><label for='deviceType'>Multiple Sim Status <span class='star'>*</span></label><select class='browser-default' id='deviceType'><option value="" disabled selected>Multiple Sim Status</option><option value='Yes'>Yes</option><option value='No'>No</option></select></div><div class='col s12 m6'><label for='country'>Country bought From <span class='star'>*</span></label><select id='country1' class='browser-default' class='mySelect' style='padding-left: 0;' required></select></div><div class='input-field col s12 m6' style='margin-top: 28px;'><input type='text' id='serialNumber1' name='serialNumber1' pattern='[0-9]' title='Please enter your device serial number first' maxlength='20'><label for='serialNumber1'>Device Serial Number <span class='star'>*</span></label></div><div class='col s12 m6'><label for='deviceType'>Tax paid Status <span class='star'>*</span></label><select class='browser-default' id='deviceType'><option value="" disabled selected>Tax paid Status</option><option value='Regularized'>Regularized</option><option value='Paid'>Paid</option><option value='NotPaid'>Not Paid</option></select></div></div><div class='row'><div class='col s12 m6' style='margin-top: -10px;'><label for='taxStatus'>Device Status <span class='star'>*</span></label><select class='browser-default' id='taxStatus'><option value='' disabled selected>Select Device Status</option><option value='New'>New</option><option value='Used'>Used</option><option value='Refurbished'>Refurbished</option></select></div><div class='input-field col s12 m6 l6'><input type='text' name='Price' id='Price' maxlength='30'><label for='Price'>Price <span class='star'>*</span></label></div><div class='col s12 m6'><label for='Currency'>Currency <span class='star'>*</span></label><select class='browser-default' id='Currency'><option value='' disabled selected>Select Currency</option><option value='Regularized'>$</option><option value='Paid'>$</option><option value="NotPaid">$</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEI1" name="IMEI1" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI1">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEI2" name="IMEI2" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI2">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEI3" name="IMEI3" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI3">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEI4" name="IMEI4[]" pattern="[0-9]"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEI4">4</label></div></div><div style="cursor:pointer;background-color:red;' class='remove_field btn right btn-info'>Remove</div></div>'*/
	    				'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+'<spanclass="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required id="deviceIdType'+id+'" onchange="changeImeiEsnValidation(deviceIdType'+id+')"><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+' <span class="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry"> '+$.i18n('countryBoughtFrom')+'<span class="star"></span></label><select id="country'+id+'"  class="browser-default" class="mySelect" style="padding-left: 0;" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" name="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+' <span class="star"></span></label></div><div class="col s12 m6"><label for="taxStatus'+id+'">'+$.i18n('taxPaidStatus')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('taxPaidStatus')+'\');"oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('taxPaidStatus')+'\');" required id="taxStatus'+id+'"><option value="" disabled selected>'+$.i18n('taxPaidStatus')+'</option></select></div></div><div class="row"><div class="col s12 m6" style="margin-top: -10px;"><label for="deviceStatus'+id+'"> '+$.i18n('deviceStatus')+'<span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');" required id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" id="IMEIA'+id+'" required name="IMEI1" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" name="IMEI2" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
                  //'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default"  id="deviceIdType'+id+'" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required ><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+'</label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+' </label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');" id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry">'+$.i18n('country')+'</label><select id="country'+id+'" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  class="browser-default" class="mySelect" style="padding-left: 0;" ></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');" name="serialNumber'+id+'"  pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+'</label></div><div class="row"><div class="col s12 m6" ><label for="deviceStatus'+id+'">'+$.i18n('deviceStatus')+'</label><select class="browser-default" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceStatus')+'\');"  style="margin-top: 5px;" id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEIA'+id+'"  required name="IMEI1" pattern="[0-9]{15,16}"  maxlength="16" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" name="IMEI2" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title=""  oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
			); 
		}
		}
						 
			//add input box
			populateCountries("country"+id);
			
			var allowed =localStorage.getItem("allowed");
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
			});
			$.getJSON('./getDropdownList/CUSTOMS_TAX_STATUS', function(data) {
				var dropdownid=id-1;
				if(dropdownid <= allowed){

					$('#taxStatus'+dropdownid).prop('disabled', 'disabled');
					$('<option  selected>').val("2").text("Regularized").appendTo('#taxStatus'+dropdownid);
						
				}
				else{
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].value).text(data[i].interp)
						.appendTo('#taxStatus'+dropdownid);

					}
				}
			});

		

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

			$.getJSON('./getDropdownList/CURRENCY', function(data) {
				var dropdownid=id-1;
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#Currency'+dropdownid);

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


			id++;
		}
	});
	$(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
		////alert(id);
		var Iid=id-1;
		 /*//alert("@@@"+Iid)*/
		 $('#deviceInformation'+Iid).remove();
		e.preventDefault();
		$(this).parent('div').remove();
		x--;
		id--;
	})
});


var sourceType =localStorage.getItem("sourceType");
function filter(lang , filterSource)
{       
	var source__val;

	if(filterSource == 'filter' ) {
		source__val= filterSource;
	}
	else{
		source__val= $("body").attr("data-filterSource");

	}
	
	var sessionFlag=0;
	if(roleType=="Custom" || roleType=="Immigration"){
		table('./headers?type=userPaidStatus&lang='+lang,'./user-paid-status-data?sessionFlag='+sessionFlag+'&source='+source__val,filterSource);
	}else if(roleType=="DRT"){
		table('./headers?type=userPaidStatus&lang='+lang,'./user-paid-status-data?sessionFlag='+sessionFlag+'&source='+source__val,filterSource);
	}
	else if(roleType == "CEIRAdmin"){
		table('./headers?type=adminUserPaidStatus&lang='+lang,'./user-paid-status-data?sessionFlag='+sessionFlag+'&source='+source__val,filterSource);

	}
}


var nationalId =$("body").attr("session-value") =='null' ? null : $("body").attr("session-value");
function table(url,dataUrl,filterSource){
	var txnIdValue = $("body").attr("session-valueTxnID");
	var txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;
	var origin=$("body").attr("data-roleType");
	if($("body").attr("data-roleType")=='CEIRAdmin'){
		origin=$('#originFilter').val();
	}
	if (filterSource=="filter")
	{
		if($("body").attr("data-filterSource")=='noti'){
			
			txn=$('#transactionID').val();
			
		}
		$("body").attr("data-filterSource","filter");
		txn=$('#transactionID').val();
	}
	
	var request={
			"origin":$('#originFilter').val(),
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"taxPaidStatus":parseInt($('#taxPaidStatus').val()),
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"status":parseInt($('#recordStatus').val()),
			"txnId":txn,
			"consignmentStatus": null,
			"nid": nationalId == null ? $('#nId').val() : nationalId,
			"nationality":$('#filterNationality').val()	
	}


	if(lang=='km'){
		var langFile="./resources/i18n/khmer_datatable.json";
	}
	else if(lang=='en'){
		var langFile='./resources/i18n/english_datatable.json';
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: url,
		type: 'POST',
		dataType: "json",
		success: function(result){
			var table=	$("#data-table-simple").DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : true,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"bSearchable" : true,
				"oLanguage": {  
					"sUrl": langFile  
				},
				"aaSorting": [],
				columnDefs: [
					   { orderable: false, targets: -1 }
					],
				initComplete: function() {
			 		$('.dataTables_filter input')
   .off().on('keyup', function(event) {
	   if (event.keyCode === 13) {
			 table.search(this.value.trim(), false, false).draw();
		}
      
   });
   },
				ajax: {
					url : dataUrl,
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(request); 

					},
					error: function (jqXHR, textStatus, errorThrown,data) {
						
						 window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
						 // messageWindow(jqXHR['responseJSON']['message']);
						 window.parent.$('#500ErrorModal').openModal({
						 dismissible:false
						 });
						
					}

				},
				"columns": result
			});
			$('div#initialloader').delay(300).fadeOut('slow');

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax");
		}
	});
}


function pageRendering(lang){
	pageButtons('./upload-paid-status/pageRendering?type=userPaidStatus&lang='+lang);

	localStorage.removeItem('sourceType');

}


function pageButtons(url){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: url,
		type: 'POST',
		dataType: "json",
		success: function(data){
			data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );

			var elem='<p class="PageHeading">'+data.pageTitle+'</p>';		
			$("#pageHeader").append(elem);
			var button=data.buttonList;



			var date=data.inputTypeDateList;
			/*if(window.parent.$("body").attr("data-roletype") == "CEIRAdmin"){*/
			for(i=0; i<date.length; i++){
				if(date[i].type === "date"){
					$("#tableDiv").append("<div class='input-field'>"+
							"<div id='enddatepicker' class='input-group'>"+
							"<input class='form-control datepicker' type='text' id="+date[i].id+" autocomplete='off' onchange='checkDate(startDate,endDate)'>"+
							"<label for="+date[i].id+">"+date[i].title
							+"</label>"+
							"<span	class='input-group-addon' style='color: #ff4081'>"+
							"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");
					$( "#"+date[i].id ).datepicker({
						dateFormat: "yy-mm-dd",
						 maxDate: new Date()
			        }); 
				}else if(date[i].type === "text"){
					$("#tableDiv").append("<div class='input-field'><input type="+date[i].type+" maxlength="+date[i].className+" id="+date[i].id+" /><label for="+date[i].id+" id="+date[i].id+">"+date[i].title+"</label></div>");
				}
				else if(date[i].type === "select"){

					var dropdownDiv=
						$("#tableDiv").append("<div class='selectDropdwn'>"+
								
								"<div class='select-wrapper select2  initialized'>"+
								"<span class='caret'>"+"</span>"+
								"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

								"<select id="+date[i].id+" class='select2 initialized'>"+
								"<option value=''>"+date[i].title+
								"</option>"+
								"</select>"+
								"</div>"+
						"</div>");
				
				}
				
			} 
			

			/*}
			else{
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){
						$("#tableDiv").append("<div class='input-field col s6 m2'>"+
								"<div id='enddatepicker' class='input-group'>"+
								"<input class='form-control datepicker' type='text' id="+date[i].id+" autocomplete='off' onchange='checkDate(startDate,endDate)'>"+
								"<label for="+date[i].id+">"+date[i].title
								+"</label>"+
								"<span	class='input-group-addon' style='color: #ff4081'>"+
								"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");
						$( "#"+date[i].id ).datepicker({
							dateFormat: "yy-mm-dd",
							 maxDate: new Date()
				        }); 
					}else if(date[i].type === "text"){
						$("#tableDiv").append("<div class='input-field col s6 m2'><input type="+date[i].type+" maxlength="+date[i].className+" id="+date[i].id+" /><label for="+date[i].id+" id="+date[i].id+">"+date[i].title+"</label></div>");
					}
					
				} 
				
			// dynamic dropdown portion
			var dropdown=data.dropdownList;
			for(i=0; i<dropdown.length; i++){
				var dropdownDiv=
					$("#tableDiv").append("<div class='col s6 m2 selectDropdwn'>"+

							"<div class='select-wrapper select2  initialized'>"+
							"<span class='caret'>"+"</span>"+
							"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

							"<select id="+dropdown[i].id+" class='select-wrapper select2  initialized' style='height: 2.4rem;'>"+
							"<option value=''>"+dropdown[i].title+
							"</option>"+
							"</select>"+
							"</div>"+
					"</div>");
			}
			}*/


		/*	// dynamic dropdown portion
			var dropdown=data.dropdownList;
			for(i=0; i<dropdown.length; i++){
				var dropdownDiv=
					$("#tableDiv").append("<div class='col s6 m2 selectDropdwn'>"+

							"<div class='select-wrapper select2  initialized'>"+
							"<span class='caret'>"+"</span>"+
							"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

							"<select id="+dropdown[i].id+" class='select-wrapper select2  initialized' style='height: 2.4rem;'>"+
							"<option value=''>"+dropdown[i].title+
							"</option>"+
							"</select>"+
							"</div>"+
					"</div>");
			}*/



			$("#tableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton'  id='submitFilter' /></div></div></div>");
			$("#tableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton'  id='clearRegisterDeviceFilter'>"+$.i18n('clearFilter')+"</button></div>");
			$("#tableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' onclick='exportpaidStatus()'  type='button' class='export-to-excel right'>"+$.i18n('Export')+" <i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
		
			$('#clearRegisterDeviceFilter').attr("onclick", "filterResetregisterDevice('viewRegisterDeviceFilter')");
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				if(button[i].type === "HeaderButton"){
					$('#'+button[i].id).attr("href", button[i].buttonURL);
					$('#'+button[i].id).attr("href", "./add-device-information?NID="+$("body").attr("session-value")+"");
				}
				else{
					$('#'+button[i].id).attr("onclick", button[i].buttonURL);
				}
			}

			//Tax paid status-----------dropdown
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
			});
			$.getJSON('./getDropdownList/CUSTOMS_TAX_STATUS', function(data) {
				for (i = 0; i < data.length; i++) {
					////////console.log(data[i].value);
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#taxPaidStatus');
				}
			});
			
			//Stolen Status-----------dropdown
			$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-userTypeID"), function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].state).text(data[i].interp)
					.appendTo('#recordStatus'); 
				}
			});


			$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#deviceTypeFilter');
				}
			});


			$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#deviceIDType');
				}
			});
			$.getJSON('./getDropdownList/ORIGIN', function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#originFilter');
				}
			});
			nationalitySelect();
		}
	}); 	

	if(sessionStorage.getItem("admin")=="CEIRAdmin"){
		$("#btnLink").css({display: "none"});
	}
}


populateCountries("country");




function deleteByImei(imei,txnId){
	$('#deleteMsg').openModal({dismissible:false});
	window.imei=imei;
	window.txnId=txnId;
	
}

function accept(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./delete/"+window.imei+"/"+window.txnId,
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'DELETE',
		success : function(data, textStatus, xhr) {

			//$('#confirmDeleteMsg').openModal({dismissible:false});
			//$('#deleteMsg').closeModal();
			if(data.errorCode == 0){
				$('#confirmDeleteMsg').openModal({dismissible:false});
				$('#deleteMsg').closeModal();
				}
			else if(data.errorCode == 5){
				    $('#confirmDeleteMsg').openModal({dismissible:false});
					$("#responseMsg").text('');
					$("#responseMsg").text($.i18n(data.tag));
					$('#deleteMsg').closeModal();
			}
			else{
				     $('#confirmDeleteMsg').openModal({dismissible:false});
					$("#responseMsg").text('');
					$("#responseMsg").text($.i18n('errorMsg'));
					$('#deleteMsg').closeModal();
			}
			/*if(data.errorCode == 200){
					$("#responseMsg").text(data.message);
				}else if(data.errorCode == 0){
					$("#responseMsg").text(data.message);
				}*/
		},
		error : function() {
			//////console.log("Error");
		}
	});
}


	function viewDetails(imei,txnId,source){ 
	/*$('#viewDeviceInformation').openModal({dismissible:false});
	$.ajax({
		url : "./deviceInfo/"+imei,
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		success : function(data) {
			setViewPopupData(data);
		},
		error : function() {
			//////console.log("Failed");
		}
	});*/
		
		window.location.href="./view-device-information/"+imei+"/"+txnId+"?source="+source+"&transactionID="+txnId;


}




function setViewPopupData(data){

	$("#viewdeviceType").val(data.deviceTypeInterp);
	$("#viewdeviceIdType").val(data.deviceIdTypeInterp);
	$("#viewsimStatus").val(data.multiSimStatusInterp);
	$("#viewcountryBought").val(data.country);
	$("#viewserialNumber").val(data.deviceSerialNumber);
	$("#viewtaxStatus").val(data.taxPaidStatusInterp);
	$("#viewdeviceStatus").val(data.deviceStatusInterp);
	$("#viewPrice").val(data.price);
	$("#viewcurrency").val(data.currencyInterp);
	$("#viewIMEI1").val(data.firstImei);
	$("#viewIMEI2").val(data.secondImei); 
	$("#IMEI3").val(data.thirdImei);
	$("#viewIMEI4").val(data.fourthImei);



}

function viewDeviceHistory() {
	historytable("./headers?type=userPaidStatus","./user-paid-status-data");
};



function historytable(url,dataUrl){

	if(lang=='km'){
		var langFile="./resources/i18n/khmer_datatable.json";
	}
	else if(lang=='en'){
		var langFile='./resources/i18n/english_datatable.json';
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: url,
		type: 'POST',
		dataType: "json",
		success: function(result){
			var table=	$("#data-table-history").DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : false,
				"bPaginate" : true,
				"bFilter" : true,
				"bInfo" : true,
				"bSearchable" : true,
				"oLanguage": {  
					"sUrl": langFile  
				},
				ajax: {
					url : dataUrl,
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify({						
							"nid": nationalId,
							"taxPaidStatus":3,
								"featureId":featureId
						}); 
					}

				},
				"columns": result
			});
			$('#viewBlockDevices').openModal({dismissible:false});
			$('div#initialloader').delay(300).fadeOut('slow');
			
			
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax");
		}
	});
}

function taxPaid(imei,txnId){
	$('#payTaxModal').openModal({dismissible:false});
	window.taxIMEI=imei;
	window.taxTxnId=txnId;

}


function exportpaidStatus(){
	var txnId = $('#transactionID').val();
	var startDate = $('#startDate').val();
	var endDate = $('#endDate').val();
	var taxPaidStatus = $('#taxPaidStatus').val();
    var nid = nationalId == null ? $('#nId').val() : nationalId
	var table = $('#data-table-simple').DataTable();
    var status=$('#recordStatus').val();
    var origin = $("body").attr("data-roleType");
 
    if($("body").attr("data-roleType")=='CEIRAdmin'){
		origin=$('#originFilter').val();
	}
    else{
    	origin="";
    }
  
    var nationality =$('#filterNationality').val();
    
    if(nationality=="undefined" || nationality==undefined){
    	nationality="";	
    }
    if( $("body").attr("data-filterSource")=='noti'){
    	txnId= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;	
	}
	else{
		txnId=$('#transactionID').val();
	}
	var info = table.page.info(); 
	var pageNo=info.page;
	var pageSize =info.length;

		if(typeof nid==="undefined"){ 
                 nid="";
    		}


	window.location.href="./exportPaidStatus?startDate="+startDate+"&endDate="+endDate+"&taxPaidStatus="+taxPaidStatus+"&nid="+nid+"&txnId="+txnId+"&pageSize="+pageSize+"&pageNo="+pageNo+"&status="+status+"&origin="+origin+"&nationality="+nationality;
}



function submitDeviceInfo(){
	if($('#deviceIdType1').val()==0){
		
		var luhnIMEI1=luhnCheck('IMEIA1','deviceIdType1');
		var luhnIMEI4="";
		var luhnIMEI3="";
		var luhnIMEI2='';
		if($('#IMEIB1').val()!=null || $('#IMEIB1').val()!=''){
			var luhnIMEI2 =luhnCheck('IMEIB1','deviceIdType1')	
		}
		if($('#IMEIC1').val()!=null || $('#IMEIC1').val()!=''){
			var luhnIMEI3 = luhnCheck('IMEIC1','deviceIdType1')	
		}
		
		if($('#IMEID1').val()!=null || $('#IMEID1').val()!=''){
			 luhnIMEI4= luhnCheck('IMEID1','deviceIdType1')	
		}
		
		//alert("luhnIMEI1 "+luhnIMEI1+" luhnIMEI2 = "+luhnIMEI2+" luhnIMEI3 "+luhnIMEI3+" luhnIMEI4 = "+luhnIMEI4);
		if(luhnIMEI1==false || luhnIMEI2==false || luhnIMEI3==false || luhnIMEI4==false)
		{
			//alert("failed");
			return false
		}
		var checkIMEI=checkDuplicateImei($('#IMEIA1').val(),$('#IMEIB1').val(),$('#IMEIC1').val(),$('#IMEID1').val());
		if(checkIMEI===true){
		$('#errorMsgOnModal').text('');
		$('#errorMsgOnModal').text($.i18n('duplicateImeiMessage'));
		return false;
	}
	}
	$('div#initialloader').fadeIn('fast');
	$("#uploadPaidStatusbutton").prop('disabled', true);
	var formData= new FormData();


	//var nationalID=$('#nationalID').val();
	var csvUploadFile=$('#csvUploadFile').val();
	var firstName=$('#firstName').val();
	var middleName=$('#middleName').val();
	var lastName=$('#lastName').val();
	var address=$('#address').val();
	var streetNumber=$('#streetNumber').val();
	var locality=$('#locality').val();
	var country=$('#country').val();
	var state=$('#state').val();
	var email=$('#email').val();
	var phone=$('#phone').val();
	var state=$('#state').val();
	var docType=$('#doc_type').val();
	var doc_type_numeric=$("#doc_type option:selected").attr("docValue");
	
	var village=$('#village').val();
	var district=$('#district').val();
	var commune=$('#commune').val();
	var postalcode=$('#postalcode').val();
	var passportFileName=$('#csvUploadFile').val()
	    passportFileName=passportFileName.replace(/^.*[\\\/]/, '');



//***************************************************************************************************************************************************************
		var nationality=$('#nationality').val();
		var departmentName=$('#departmentName').val();
		var departmentFileID=$('#endUserDepartmentId').val();
		var departmentID=$('#endUserdepartmentID').val();
		
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
 
		var auditParameters={
			    "username":$("body").attr("data-username"),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType")
		}


	//************************************************************************************************************************************
		var fieldId=1;
		var regularizeDeviceDbs =[];
		$('.deviceInformation').each(function() {
			var deviceType1=$('#deviceType'+fieldId).val();
			var serialNumber1=$('#serialNumber'+fieldId).val();
			var deviceIdType1=$('#deviceIdType'+fieldId).val();
			var taxStatus1=$('#taxStatus'+fieldId).val();
			var deviceStatus1=$('#deviceStatus'+fieldId).val();
			var Price1=$('#Price'+fieldId).val();
			var Currency1=$('#Currency'+fieldId).val();
			var IMEI1=$('#IMEIA'+fieldId).val();
			var IMEI2=$('#IMEIB'+fieldId).val();
			var IMEI3=$('#IMEIC'+fieldId).val();
			var IMEI4=$('#IMEID'+fieldId).val();
			var deviceCountry=$('#country'+fieldId).val();
			var multipleSimStatus1=$('#multipleSimStatus'+fieldId).val();
			var singleDeviceRemark=$('#singleDeviceRemark').val();	

		var deviceInfo=
		{
				"country": deviceCountry,
				"currency": parseInt(Currency1),
				"deviceIdType": parseInt(deviceIdType1),
				"deviceSerialNumber": serialNumber1,
				"deviceStatus": parseInt(deviceStatus1),
				"deviceType": parseInt(deviceType1),
				"firstImei": IMEI1,
				"secondImei": IMEI2,
				"thirdImei":IMEI3,
				"fourthImei": IMEI4,
				"multiSimStatus": multipleSimStatus1,
				"price": parseFloat(Price1),
				"taxPaidStatus": parseInt(taxStatus1),
				"nid":nationalId,
				"deviceRemark":singleDeviceRemark,
				"origin":roleType

		}
		regularizeDeviceDbs.push(deviceInfo);
		fieldId++;


	});

if(postalcode=="")
	{
	postalcode=null;
	}

	var request={
			"country": country,
			"email": email,
			"firstName": firstName,
			"lastName": lastName,
			"locality": locality,
			"middleName": middleName,
			"nid": nationalId,
			"phoneNo": phone,
			"propertyLocation": address,
			"province": state,
			"street": streetNumber,
			"auditParameters":auditParameters,
			"regularizeDeviceDbs":regularizeDeviceDbs,
			"isVip":isVip,
			"onVisa":onVisa,
			"userDepartment":departmentDetails,
			"visaDb":visaDb,
			"entryDateInCountry":visaDate,
			"nationality":nationality,
			"district":district,
			"commune":commune,
			"village":village,
			"postalCode":postalcode,
			"docType":doc_type_numeric,
			"passportFileName":passportFileName

	}
	formData.append('uploadnationalID', $('#csvUploadFile')[0].files[0]);
	formData.append("sourceType",roleType);
	formData.append("request",JSON.stringify(request));
	formData.append("docType",docType);
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './registerEndUserDevice',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {
			$('div#initialloader').delay(300).fadeOut('slow');
			$("#uploadPaidStatusbutton").prop('disabled', true);
//			$('#updateConsignment').modal();
			if(data.errorCode==0){
					//////console.log("error code"+data.errorCode)
//				$('#sucessMessage').text('');
				$('#regularisedDevice').openModal({dismissible:false});
				$('#dynamicTxnId').text(data.txnId);
			}
			else if(data.errorCode==5)
				{
				$('#regularisedDevice').openModal({dismissible:false});
				$('#sucessMessage').text('');
				$('#sucessMessage').text($.i18n(data.tag));
				}
			else{
				$("#uploadPaidStatusbutton").prop('disabled', false);
				$('#customRegisterDeviceDuplicateImei').openModal({dismissible:false});
				$('#dupliCateImeiMsg').text($.i18n(data.tag));
				//$("#uploadPaidStatusbutton").prop('disabled', true);
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")

		}
	});
	return false;
}



populateCountries
(   
		"country1"
);


populateCountries
(   
		"country"
);



function taxPaidStatus(){

	var regularizeDeviceDbs={
			"firstImei": window.taxIMEI,			
			"taxPaidStatus":0,
			"txnId":	window.taxTxnId
	}
	//////console.log("--");
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './tax-paid/status',
		type: 'PUT',
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		'data' : JSON.stringify(regularizeDeviceDbs),
		success: function (data, textStatus, jqXHR) {

			var msg="The device status has been successfully updated";
			$('#payTaxModal').closeModal();
			
			if(data.errorCode==0){
				$('#payNowTaxPayment').openModal({dismissible:false});

				}
			else if(data.errorCode == 5){
				$('#payNowTaxPayment').openModal({dismissible:false});
				$("#taxPaidMsg").text('');
				$("#taxPaidMsg").text($.i18n(data.tag));
				
		}
				else{
					$("#taxPaidMsg").text('');
					$("#taxPaidMsg").text($.i18n('errorMsg'));
				}

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});
}
populateCountries
(   
		"country1"
);

/*populateCountries
		(   
				"country"
		);*/


populateCountries(
		"country",	"");

$(document).ready(function () {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	/*$.getJSON('./getDropdownList/CUSTOMS_TAX_STATUS', function(data) {
		var checkAllowedCount =localStorage.getItem("allowed");	
		////alert("222222"+checkAllowedCount);
		if(checkAllowedCount==0)
			{
		
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interp)
				.appendTo('#taxStatus1');

			}
			}
		else{
		
	//	$('#taxStatus1').prop('disabled', 'disabled');
		//$('<option  selected>').val("2").text("Regularized").appendTo('#taxStatus1');
		}
	});*/


	$.getJSON('./getDropdownList/CUSTOMS_TAX_STATUS', function(data) {
	for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interp)
				.appendTo('#taxStatus1');
              }
	if(parseInt($("body").attr("data-userTypeID"))==18){
 		$('#taxStatus1').prop('disabled', 'disabled');
 		 
 		$('#taxStatus1').val("1");
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

	$.getJSON('./getDropdownList/CURRENCY', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#Currency1');

		}
	});

	$.getJSON('./getDropdownList/LAWFULL_SIM_STATUS', function(data) {
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



	setDropdownProviance('state');


	$(document).ready(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.getJSON('./getSourceTypeDropdown/DOC_TYPE/'+featureId, function(data) {

			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].tagId).text(data[i].interp).attr("docValue",data[i].value).appendTo('#doc_type');

			}
		});
	});

});



function regularizedCount(nationType){
	//////console.log("----"+nationType+"  roleType=="+roleType)
	var allowed='';
	
	sessionStorage.getItem("nationality");
	
	if(nationType==undefined && roleType=='Custom')
		{
		//////console.log("if condition for regulaised");
		nationType=1;
		var nid= nationalId == 'null' ? null : nationalId;
		}
	else if(nationType==undefined && roleType=='Immigration'){
		//////console.log("else  condition for regulaised");
		nationType=1;
		
		var nid= nationalId == 'null' ? null : nationalId;
	}
	else if(nationType==2)
		{
		//////console.log("hit for foreigner.");
		nationType==2;
		}
	else{
		//////console.log("else  condition for CEIR admin");
		nationType=1;
		var nid= '';
	}
	
	if(sessionStorage.getItem("nationality")!="Cambodian" && sessionStorage.getItem("nationality")!=null){
		
		nationType=2;
	}
	 
	else if( sessionStorage.getItem("nationality")==null && nationType!=2 ){
		
		nationType=1;
	}
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	var enterdNid = nationalID.replace("#", "%23");
	$.ajax({
		url: './countByNid?nid='+enterdNid+"&nationType="+nationType,
		type: 'GET',
		processData: false,
		contentType: false,
		async: false,
		success: function (data, textStatus, jqXHR) {

			 allowed=data.data.allowed;
			var current=data.data.current;
			
			localStorage.setItem("allowed", allowed);
			localStorage.setItem("current", current);
			localStorage.setItem("nationType", nationType);
			
			
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")

		}
	});
	
	return allowed;
}



function refreshContent(){
	$('#payNowTaxPayment,#confirmDeleteMsg,#regularisedDevice').closeModal();
	window.location.reload(true);
}


function deviceApprovalPopup(imei,date,txnId){
	$('#approveInformation').openModal({dismissible:false});
	window.imei=imei;
	window.txnId=txnId;
	window.date=date.replace("="," ");
	$('#approveTxnId').text(txnId);
}   


function aprroveDevice(){
    var approveRequest={
			"action" : 0,
			"imei1": window.imei,
			"featureId":parseInt(featureId),
			"remarks": "",
			"username":$("body").attr("data-username"),
			"roleTypeUserId": parseInt($("body").attr("data-userTypeID")),
			"txnId": window.txnId,
			"userId":parseInt(userId),
			"userType": $("body").attr("data-roleType")	  	
	}
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
	$.ajax({
		url : './approveRejectDevice',
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		'async' : false,
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {

			if(data.errorCode==0){
				confirmApproveInformation(window.imei,window.date);

			}
			else if(data.errorCode == 5){
				$('#confirmApproveInformation').openModal({dismissible:false});
				$("#approveSucessMessage").text('');
				$("#approveSucessMessage").text($.i18n(data.tag));
				
		}
			else{
				$('#confirmApproveInformation').openModal({dismissible:false});
				$("#approveSucessMessage").text('');
				$("#approveSucessMessage").text($.i18n('errorMsg'));
			}

		},
		error : function() {
			//////console.log("Failed");

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
	window.txnId=txnId;
}



function rejectUser(){
	
	var rejectRequest={
			"action" : 1,
			"imei1": window.imei,
			"featureId":parseInt(featureId),
			"remarks": $("#Reason").val(),
			"username":$("body").attr("data-username"),
			"roleTypeUserId": parseInt($("body").attr("data-userTypeID")),
			"txnId": window.txnId,
			"userId":parseInt(userId),
			"userType": $("body").attr("data-roleType")	  	
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : './approveRejectDevice',
		data : JSON.stringify(rejectRequest),
		dataType : 'json',
		'async' : false,
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {

			if(data.errorCode==0){
				confirmRejectInformation();

			}
			else if(data.errorCode == 5){
				$('#confirmRejectInformation').openModal({dismissible:false});
				$("#deviceRejectPopUp").text('');
				$("#deviceRejectPopUp").text($.i18n(data.tag));
				
		}
			else{
				$('#confirmRejectInformation').openModal({dismissible:false});
				$("#deviceRejectPopUp").text('');
				$("#deviceRejectPopUp").text($.i18n('errorMsg'));
			}
		},
		error : function() {
			//////console.log("Failed");
		}
	});
	return false;
}



function confirmRejectInformation(){
	$('#rejectInformation').closeModal();
	setTimeout(function(){$('#confirmRejectInformation').openModal({dismissible:false});},200);
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
	//$('#FilefieldId').val(id);
	////alert(uploadedFileName+"----------"+ext+"----"+fileSize)
	var fileExtension =ext.toLowerCase();
	//////console.log("file type: "+fileExtension);
	var extArray = ["png", "jpg","jpeg","gif","bmp","gif"];
	var isInArray =extArray.includes(fileExtension);
	//////console.log("isInArray: "+isInArray)
	if (uploadedFileName.length > 30) {
		$('#fileFormateModal').openModal();
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageMessage'));
	}
	else if(isInArray ==false)
	{
		$('#fileFormateModal').openModal({
			dismissible:false
		});
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageMessage'));

	}
	else if(fileSize>=5000){
		$('#fileFormateModal').openModal({
			dismissible:false
		});
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageSize'));
	}
}



function clearFileName() {
	$('#csvUploadFile').val('');
	$("#csvUploadFileName").val('');
	$('#fileFormateModal').closeModal();
}

$(document).on("keyup", "#Price1", function(e) {
	var totalPrice=$('#Price1').val();
	if(totalPrice.length<'1' )
	{
		$("#Currency1").attr("required", false);
		/*$('#currency').attr("disabled",true);*/
		$('#CurrencyDiv').hide();

		$("#Currency1")[0].selectedIndex = 0;

	}
	else
	{
		$('#Currency1').prop('required',true);
		//$("#currency").attr("required", true);
		/*$('#currency').attr("disabled",false);*/
		$('#CurrencyDiv').show();

	}
});

 function showHideCurrency() {
	////alert(id-1);
	 var cuurecyId=id-1;
	 ////alert(ssss);
	var totalPriceaaa=$('#Price'+cuurecyId).val();
	/*$('#country'+fieldId).val();*/
	////alert(totalPriceaaa)
	if(totalPriceaaa.length<'1' )
	{
		$("#Currency"+cuurecyId).attr("required", false);
		/*$('#currency').attr("disabled",true);*/
		$('#CurrencyDiv'+cuurecyId).hide();

		$("#Currency"+cuurecyId)[0].selectedIndex = 0;

	}
	else
	{
		$('#Currency'+cuurecyId).prop('required',true);
		//$("#currency").attr("required", true);
		/*$('#currency').attr("disabled",false);*/
		$('#CurrencyDiv'+cuurecyId).show();

	}
}
 
 
 
 function showOtherUserForm()
 {
	 $('#nidLabelName').text('');
 	$('#nidLabelName').text($.i18n('Passport Number'));
 	
 	/*$('#uploadNidImage').text('');
 	$('#uploadNidImage').text($.i18n('Upload Passport Image'));*/
 	$("#nidLabelName").append('<span class="star">*</span>');
 	/*$("#uploadNidImage").append('<span class="star">*</span>');
 	*/
 	$("#askVisaDetails").css("display", "block");
 	$("#nationalityDiv").css("display", "block");
 	$("#onVisaNo").prop("checked", true);
 	$("#nidPlaceHolder").attr("placeholder", $.i18n('Upload Passport Image')).val("").focus().blur();

 	$("#nationality").attr("required", true);
 	$("#endUserLabelNID").append('<span class="star">*</span>');
 	$("#nidType").append('<span class="star">*</span>');
 	$("#datepicker").attr("required", true);
 	
 	$("#entryCountryDiv").css("display", "block");
 	localStorage.removeItem('allowed');
    var allowedCount=	regularizedCount(2);
 	if(allowedCount>0)
 		{
 		$('#taxStatus1').prop('disabled', 'disabled');
		$('#taxStatus1').val("2");
		}
 	else{
 		$('#taxStatus1').prop('disabled', false);
 		$('#taxStatus1').val("1");
 	}
 	
 	$("#priceDiv").css("display", "none");
 	$("#CurrencyDiv").css("display", "none");
 	
	var removeBulkDiv;
 	$('.deviceInformation').each(function(){
 		removeBulkDiv=id-1;
 		if(removeBulkDiv>1)
 		{
 			$('#deviceInformation'+removeBulkDiv).remove();
 	 		id--;
 	 		x--;
 			}
 		else{
 			
 		}
 	  });
 	/*$("#departmentName").attr("required", true);
 	 $("#endUserdepartmentID").attr("required", true);
 	 $("#endUserDepartmentId").attr("required", true);
 	 $("#visaType").attr("required", true);
 	 $("#datepicker").attr("required", true);
 	 $("#datepicker1").attr("required", true);
 	 $("#visaImage").attr("required", true);*/

 }

 function showVisaDetails(){
 	$("#visaDetails").css("display", "block");
 	
 	$("#visaNumber").attr("required", true);
 	$("#visaImage").attr("required", true);
 	$("#datepicker1").attr("required", true);
 	$("#visaType").attr("required", true);

 }
 function hideVisaDetails(){
 	$("#visaDetails").css("display", "none");
 	$('#visaDetails').find('input:text').val('');
 	$('#visaDetails').find('input:file').val('');

 	//$("#datepicker").attr("required", false);
 	$("#visaNumber").attr("required", false);
 	$("#visaImage").attr("required", false);
 	$("#datepicker1").attr("required", false);
 	$("#visaType").attr("required", false);
 }
 function showCambodianUserForm()
 {
	 
	    $('#nidLabelName').text('');
	 	$('#nidLabelName').text($.i18n('National ID'));
	 	/*$('#uploadNidImage').text('');
	 	$('#uploadNidImage').text($.i18n('Upload ID Image'));*/
	 	
 	$("#askVisaDetails").css("display", "none"); 
 	$("#visaDetails").css("display", "none"); 
 	$("#nationalityDiv").css("display", "none"); 
 	$('#endUserLabelNID').text($.i18n('National ID'));
 	$('#nidType').text($.i18n('Upload ID Image'));
 	$("#datepicker").attr("required", false);
 	$("#nidPlaceHolder").attr("placeholder", $.i18n('Upload ID Image')).val("").focus().blur();
 	$('#visaDetails').find('input:text').val('');
 	$('#visaDetails').find('input:file').val('');
 	$('input[name="onVisa"]').prop('checked', false);

 	$("#datepicker").attr("required", false);
 	$("#visaNumber").attr("required", false);
 	$("#visaImage").attr("required", false);
 	$("#datepicker1").attr("required", false);
 	$("#visaType").attr("required", false);

 	$("#nationality").attr("required", false);
 	$("#departmentName").attr("required", false);
 	$("#endUserdepartmentID").attr("required", false);
 	$("#endUserDepartmentId").attr("required", false);
 	$("#visaType").attr("required", false);
 	$("#datepicker").attr("required", false);
 	$("#datepicker1").attr("required", false);
 	$("#visaImage").attr("required", false);
 	$("#visaNumber").attr("required", false);

 	$("#entryCountryDiv").css("display", "none");

 	$("#nidLabelName").append('<span class="star">*</span>');
 //$("#uploadNidImage").append('<span class="star">*</span>');

 	allowedCount = regularizedCount(1);
 	if(allowedCount>0)
		{
		$('#taxStatus1').prop('disabled', 'disabled');
		$('#taxStatus1').val("2");
	}
	else{
		$('#taxStatus1').prop('disabled', false);
		$('#taxStatus1').val("1");
	}
 	
 	$("#priceDiv").css("display", "block");
 	if(parseInt($("body").attr("data-userTypeID"))==18){
 		$('#taxStatus1').prop('disabled', 'disabled');
 		$("#priceDiv").css("display", "none");
 		$('#taxStatus1').val("1");
 	}
 	var removeBulkDiv;
 	$('.deviceInformation').each(function(){
 		removeBulkDiv=id-1;
 		if(removeBulkDiv>1)
 		{
 			$('#deviceInformation'+removeBulkDiv).remove();
 	 		id--;
 	 		x--;
 			}
 		else{
 			
 		}
 	  });
 }

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
 
function deptImageValidation() {
		var uploadedFileName = $("#endUserDepartmentId").val();
		uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
		////alert("file extension=="+uploadedFileName)
		var ext = uploadedFileName.split('.').pop();

		var fileSize = ($("#endUserDepartmentId")[0].files[0].size);
		/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
		//alert("----"+fileSize);*/
		fileSize = Math.floor(fileSize/1000);
		//$('#FilefieldId').val(id);
		////alert(uploadedFileName+"----------"+ext+"----"+fileSize)
		var fileExtension =ext.toLowerCase();
		////console.log("file type: "+fileExtension);
		var extArray = ["png", "jpg","jpeg","gif","bmp","gif"];
		var isInArray =extArray.includes(fileExtension);
		////console.log("isInArray: "+isInArray)
		if (uploadedFileName.length > 30) {
			$('#fileFormateModal').openModal();
			$('#fileErrormessage').text('');
			$('#fileErrormessage').text($.i18n('imageMessage'));
		}
		else if(isInArray ==false)
		{
			$('#fileFormateModal').openModal({
				dismissible:false
			});
			$('#fileErrormessage').text('');
			$('#fileErrormessage').text($.i18n('imageMessage'));

		}
		else if(fileSize>=5000){
			$('#fileFormateModal').openModal({
				dismissible:false
			});
			$('#fileErrormessage').text('');
			$('#fileErrormessage').text($.i18n('imageSize'));
		}
	}function visaImageValidation() {
		var uploadedFileName = $("#visaImage").val();
		uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
		////alert("file extension=="+uploadedFileName)
		var ext = uploadedFileName.split('.').pop();

		var fileSize = ($("#visaImage")[0].files[0].size);
		/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
		//alert("----"+fileSize);*/
		fileSize = Math.floor(fileSize/1000);
		//$('#FilefieldId').val(id);
		////alert(uploadedFileName+"----------"+ext+"----"+fileSize)
		var fileExtension =ext.toLowerCase();
		////console.log("file type: "+fileExtension);
		var extArray = ["png", "jpg","jpeg","gif","bmp","gif"];
		var isInArray =extArray.includes(fileExtension);
		////console.log("isInArray: "+isInArray)
		if (uploadedFileName.length > 30) {
			$('#fileFormateModal').openModal();
			$('#fileErrormessage').text('');
			$('#fileErrormessage').text($.i18n('imageMessage'));
		}
		else if(isInArray ==false)
		{
			$('#fileFormateModal').openModal({
				dismissible:false
			});
			$('#fileErrormessage').text('');
			$('#fileErrormessage').text($.i18n('imageMessage'));

		}
		else if(fileSize>=5000){
			$('#fileFormateModal').openModal({
				dismissible:false
			});
			$('#fileErrormessage').text('');
			$('#fileErrormessage').text($.i18n('imageSize'));
		}
	}

 var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajaxSetup({
     headers:
     { 'X-CSRF-TOKEN': token }
 	});
 $.getJSON('./getDropdownList/VISA_TYPE', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#visaType');

		}
	});
 
 $('#datepicker,#datepicker1').datepicker({
		dateFormat: "yy-mm-dd"
	});
 function clearDeptName() {
		$('#endUserDepartmentId').val('');
		$("#endUSerNidaPlaceholder").val('');
		$('#visafileFormateModal').closeModal();
	}
 
 function clearVisaName() {
		$('#visaImage').val('');
		$("#ensUserVisaPlaceHolder").val('');
		$('#visafileFormateModal').closeModal();
	}
 
 function historyRecord(txnID){
		//////console.log("txn id=="+txnID)
		$("#tableOnModal").openModal({dismissible:false});
		 var filter =[];
		 var formData= new FormData();
		 
			 var filterRequest={
					 
					 "columns": [
						    "created_on","modified_on","txn_id","status","nid","device_type","device_id_type","multi_sim_status","country","device_serial_number","tax_paid_status","device_status","price",
						    "currency","first_imei","second_imei","third_imei","fourth_imei","origin","remark",
						     "user_id","approved_by","tax_collected_by",
						    ],
					"tableName": "regularize_device_db_aud",
					"dbName" : "ceirconfig",
					"txnId":txnID,
					"featureId":12
			} 
		 
		
		formData.append("filter",JSON.stringify(filterRequest));	
		if(lang=='km'){
			var langFile='./resources/i18n/khmer_datatable.json';
		}
		else if(lang=='en'){
			var langFile='./resources/i18n/english_datatable.json';
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: 'Consignment/consignment-history',
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function(result){
				var dataObject = eval(result);
				$('#data-table-history2').dataTable({
					 "order" : [[1, "asc"]],
					 destroy:true,
					"serverSide": false,
					 orderCellsTop : true,
					"ordering" : false,
					"bPaginate" : true,
					"bFilter" : false,
					"scrollX": true,
					"bInfo" : true,
					"oLanguage": {  
						"sUrl": langFile  
					},	
					"bSearchable" : true,
					pageLength : 3,
					 "data": dataObject.data,
					 "columns": dataObject.columns
				
			    });
				$('div#initialloader').delay(300).fadeOut('slow');
		}
			
});
	
		$('.datepicker').on('mousedown',function(event){
		event.preventDefault();
	});
}
 
 
 
 
 $('#deviceIdType1').on('change', function() {
		var value=parseInt($(this).val());

		switch (value) {
		case 0:
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").val('');	
			/*$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("pattern","[0-9]{15,16}");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("maxlength","16");
			*/
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").removeAttr("onkeyup");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
			
			$('#errorMsgOnModal').text($.i18n('IMEIMsg'));
			
			break;
		case 1:
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("pattern","[A-F0-9]{15,16}");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("maxlength","16");
			
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").removeAttr("onkeyup");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
			$('#errorMsgOnModal').text($.i18n('MEIDMsg'));
			break;
		case 2:
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").val('');
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("pattern","[0-9]{8,11}");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("onkeyup","isLengthValid(this.value)");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("maxlength","11");	
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
			$("#errorMsgOnModal").text($.i18n('ESNMsg'));
			break;
		}

	}); 

	function isLengthValid(val){
		var deviceIDLength=val.length;
		if(!isNaN(val)){
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("pattern","[0-9]{11,11}");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("maxlength","11");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		}
		else if(typeof val == 'string' || val instanceof String){
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("maxlength","8");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("pattern","[A-F0-9]{8,8}");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");
			$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");

		}
	}
	$("#country").val("Cambodia").change();
//	$("#country").attr("style", "pointer-events: none;");
	/*
	 $('#doc_type').on('change', function() {
		 var doctype = $('#doc_type').val();
		 if($('option:selected').attr('docvalue')==4){
			 
			 $("#docSpanee").css("display", "none");
			 $('#uploadNidImage').text('');
			 $('#uploadNidImage').text($.i18n('meesageForOtherDoc'));
		 }
	 });*/
	
	

	function filterResetregisterDevice(formID){
		$('#endDate').css('border-color', '');
		$('#errorMsg').text('');
		$('#'+formID).trigger('reset');
		$("label").removeClass('active');
		filter(lang,null);
	}