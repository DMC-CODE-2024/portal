var nationalID = sessionStorage.getItem("nationalId");
$('#langlist').on('change', function() {
	window.lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	var url_string = window.location.href;
	var url = new URL(url_string);
	var type = url.searchParams.get("type");
	$('#changedAddDeviceLangValue').val(window.lang);
	document.getElementById("changedLangAddDeviceForm").submit();
	//window.location.assign("selfRegisterDevicePage?lang="+window.lang);			
}); 

$('#langlist').val(data_lang_param);

//$('#langlist').val(data_lang_param);
$.i18n().locale = data_lang_param;
var successMsg;
$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
} ).done( function() { 
});



$('#ok,#redirectToPage').click(function(){
	
	$('#nationalIdForCancel').val(nationalID);
	 document.getElementById("cancelAddDeviceForm").submit();
	 /*window.location.replace("./selfRegisterDevicePage?NID="+nationalID);*/
	});

function redirectToPage(){
	 
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
	}}
	$('div#initialloader').fadeIn('fast');
	$("#uploadPaidStatusbutton").prop('disabled', true);
	 var formData= new FormData();	
	 var fieldId=1;	
	 var auditParameters={
			    
				"featureId":parseInt(12),
				"userTypeId": 17,
				"userType":"End User"
		}

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
				var multipleSimStatus1=$('#multipleSimStatus1'+fieldId).val();
			////console.log("serialNumber1="+serialNumber1+" deviceIdType1="+deviceIdType1+" taxStatus1="+taxStatus1+" deviceStatus1="+deviceStatus1+" Price1="+Price1+" Currency1="+Currency1)
			
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
				      "thirdImei": IMEI3,
				      "fourthImei": IMEI4,
				      "multiSimStatus": deviceStatus1,
				      "price": parseFloat(Price1),
				      "taxPaidStatus": parseInt(taxStatus1),
				      "nid":nationalID,
				      "txnId":"",
				  	"deviceRemark":singleDeviceRemark,
				      "origin":"End User"
			}
			regularizeDeviceDbs.push(deviceInfo);  
			fieldId++;
		});
		 var request={
				 "country": null,
				 "email": null,
				  "firstName": null,
				  "lastName": null,
				  "locality": null,
				  "middleName": null,
				  "nid": nationalID,
				  "phoneNo": null,
				  "propertyLocation": null,
				  "province": null,
				  "street": null,
				  "auditParameters":auditParameters,
				  "regularizeDeviceDbs":regularizeDeviceDbs,
				  
				}
		 formData.append("request",JSON.stringify(request));
		 var token = $("meta[name='_csrf']").attr("content");
		 var header = $("meta[name='_csrf_header']").attr("content");
		 $.ajaxSetup({
		 headers:
		 { 'X-CSRF-TOKEN': token }
		 });
		$.ajax({
			url: './endUseruploadPaidStatusForm',
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function (data, textStatus, jqXHR) {
				////console.log("in suucess method");
				////console.log(data);
				$('div#initialloader').delay(300).fadeOut('slow');
				// $('#updateConsignment').modal();
				if(data.errorCode==0){

				//	$('#sucessMessage').text('');
				    $('#regularisedDevice').openModal({dismissible:false});
					$('#dynamicTxnId').text(data.txnId);
				}
				
				else if(data.errorCode==5){

//					$('#sucessMessage').text('');
					$('#regularisedDevice').openModal({dismissible:false});;
					$('#sucessMessage').text('');
					$('#sucessMessage').text($.i18n(data.tag));
					
				}
				else{
					//$('#sucessMessage').text('');
					/*$('#regularisedDevice').openModal({dismissible:false});
					$('#sucessMessage').text();
					$('#sucessMessage').text(data.message);*/
					$('#endUserAddDeviceDuplicateImei').openModal({dismissible:false});;
					$('#dupliCateImeiMsg').text($.i18n(data.tag));
					
				}
				//sessionStorage.removeItem("nationalId");
			},
			error: function (jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			
			}
		});
		return false;

		 } 

	 populateCountries
(   
		"country1"
);


function defaultDeviceForm(){
	var allowed =parseInt(localStorage.getItem("allowed"));
	var current =parseInt(localStorage.getItem("current"));
	////console.log("allowed="+allowed+"& current="+current)

	var incrementedCurrent='';
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.getJSON('./getDropdownList/CUSTOMS_TAX_STATUS', function(data) {
		/* for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#taxStatus1');
			////console.log("...........");} */
						if(allowed>current)
				{
				//////console.log("-------------------");
	                $('#taxStatus1').prop('disabled', 'disabled');
	                $('<option  selected>').val("2").text("Regularized").appendTo('#taxStatus1');
				}
			else{
				//////console.log("++++++++++++=");
				 for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interp)
				.appendTo('#taxStatus1');
				//////console.log("...........");} 
			    }
			
		}
			 incrementedCurrent=current+1;
				////console.log("set increment cuurent value="+incrementedCurrent);
				localStorage.removeItem('incrementedCurrent');
				localStorage.setItem("incrementedCurrent", incrementedCurrent);
			var www =parseInt(localStorage.getItem("incrementedCurrent"));
			
					});
	

	$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#deviceType1');
			//////console.log("...........");
		}
	});


	
	$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#deviceIdType1');
			//////console.log("...........");
		}
	});
	
	$.getJSON('./getDropdownList/CURRENCY', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#Currency1');
			//////console.log("...........");
		}
	});
	
	$.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#multipleSimStatus1');
			//////console.log("...........");
		}
	});
	
	$.getJSON('./getDropdownList/DEVICE_STATUS', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#deviceStatus1');
			//////console.log("...........");
		}
	});
	
	
	 }





      var id=2;
	  function RegularisedDeviceForm(){
		  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  $.ajaxSetup({
		  headers:
		  { 'X-CSRF-TOKEN': token }
		  });
		 $.getJSON('./addMoreFile/add_more_device_count', function(data) {
			////console.log(data);
			
			localStorage.setItem("maxCount", data.value);
			
		});
	 
			//var max_fields = 2; //maximum input boxes allowed
			var max_fields =localStorage.getItem("maxCount");
			if (max_fields==0){
				
				 $(".add_field_button").prop('disabled', true);
			 }
			////console.log("max_fields from api="+max_fields);
		  
  // var max_fields = 15; //maximum input boxes allowed
   var wrapper = $(".mainDeviceInformation"); //Fields wrapper
   var add_button = $(".add_field_button"); //Add button ID
   var x = 1; //initlal text box count
   
   
 
   var allowed =parseInt(localStorage.getItem("allowed")); 
   
   $(add_button).click(function (e) { //on add input button click
       e.preventDefault();
       var incrementedCurrent =parseInt(localStorage.getItem("incrementedCurrent"));
       
       ////console.log("&&&&&&&&&&&"+incrementedCurrent);
      
       if (x < max_fields) { //max input box allowed
           x++; //text box increment
          
           ////console.log("incremented value="+id)
           $(wrapper).append(
           //'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceType">Device Type <spanclass="star">*</span></label><select class="browser-default" required id="deviceType'+id+'"><option value="" disabled selected>Device Type</option></select></div><div class="col s12 m6"><label for="deviceIdType'+id+'">Device ID Type <span class="star">*</span></label><select class="browser-default" required id="deviceIdType'+id+'"><option value="" disabled selected>Select Device ID Type</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">Multiple Sim Status <span class="star">*</span></label><select class="browser-default" required id="multipleSimStatus'+id+'"><option value="" disabled selected>Multiple Sim Status</option></select></div><div class="col s12 m6"><label for="deviceCountry">Country bought From <span class="star">*</span></label><select id="country'+id+'" class="browser-default" required class="mySelect" style="padding-left: 0;" required></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" required name="serialNumber'+id+'" pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">Device Serial Number <span class="star">*</span></label></div><div class="col s12 m6"><label for="taxStatus'+id+'">Tax paid Status <span class="star">*</span></label><select class="browser-default" required id="taxStatus'+id+'"><option value="" disabled selected>Tax paid Status</option></select></div></div><div class="row"><div class="col s12 m6" style="margin-top: -10px;"><label for="deviceStatus'+id+'">Device Status <span class="star">*</span></label><select class="browser-default" required id="deviceStatus'+id+'"><option value="" disabled selected>Select Device Status</option></select></div><div class="input-field col s12 m6 l6"><input type="text" name="Price" id="Price'+id+'" required maxlength="30"><label for="Price'+id+'">Price <span class="star">*</span></label></div><div class="col s12 m6"><label for="Currency'+id+'">Currency <span class="star">*</span></label><select class="browser-default" required id="Currency'+id+'"><option value="" disabled selected>Select Currency</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEIA'+id+'" required name="IMEI1" pattern="[0-9]{15,16}"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text"  id="IMEIB'+id+'" name="IMEI2" pattern="[0-9]{15,16}"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'"  name="IMEI3" pattern="[0-9]{15,16}"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'"  name="IMEI4[]" pattern="[0-9]{15,16}"title="Please enter minimum 15 and maximum 16 digit only"maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">Remove</div></div>'
           '<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+'<spanclass="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required id="deviceIdType'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+' <span class="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry"> '+$.i18n('countryBoughtFrom')+'<span class="star"></span></label><select id="country'+id+'"  class="browser-default" class="mySelect" style="padding-left: 0;" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');" ></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" name="serialNumber'+id+'"  oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');" pattern="[A-Za-z0-9]{0,15}" title="" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+' <span class="star"></span></label></div><div class="row"><div class="col s12 m6" style="margin-top: -10px;"><label for="deviceStatus'+id+'"> '+$.i18n('deviceStatus')+'<span class="star"></span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');"  id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text" id="IMEIA'+id+'" required name="IMEI1" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" name="IMEI2" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
         //'<div id="deviceInformation'+id+'" class="deviceInformation"><div class="row"><div class="col s12 m6"><label for="deviceType">'+$.i18n('deviceType')+'<spanclass="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceType')+'\');" required id="deviceType'+id+'"><option value="" disabled selected>'+$.i18n('deviceType')+'</option></select></div><div class="col s12 m6"><label for="deviceIdType'+id+'">'+$.i18n('deviceIDType')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceIDType')+'\');" required id="deviceIdType'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceIDType')+'</option></select></div><div class="col s12 m6"><label for="multipleSimStatus'+id+'">'+$.i18n('multipleSimStatus')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('multipleSimStatus')+'\');" required id="multipleSimStatus'+id+'"><option value="" disabled selected>'+$.i18n('multipleSimStatus')+'</option></select></div><div class="col s12 m6"><label for="deviceCountry"> '+$.i18n('countryBoughtFrom')+'<span class="star">*</span></label><select id="country'+id+'"  class="browser-default" class="mySelect" style="padding-left: 0;" oninput="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('countryBoughtFrom')+'\');" required></select></div><div class="input-field col s12 m6" style="margin-top: 28px;"><input type="text" id="serialNumber'+id+'" name="serialNumber'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');"  oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('deviceSerialNumber')+'\');" required pattern="[A-Za-z0-9]{0,15}" title="Please enter your device serial number first" maxlength="15"><label for="serialNumber'+id+'">'+$.i18n('deviceSerialNumber')+' <span class="star">*</span></label></div><div class="col s12 m6"><label for="taxStatus'+id+'">'+$.i18n('taxPaidStatus')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('taxPaidStatus')+'\');"oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('taxPaidStatus')+'\');" required id="taxStatus'+id+'"><option value="" disabled selected>'+$.i18n('taxPaidStatus')+'</option></select></div></div><div class="row"><div class="col s12 m6" style="margin-top: -10px;"><label for="deviceStatus'+id+'"> '+$.i18n('deviceStatus')+'<span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');"  oninvalid="InvalidMsg(this,\'select\',\''+$.i18n('deviceStatus')+'\');" required id="deviceStatus'+id+'"><option value="" disabled selected>'+$.i18n('selectDeviceStatus')+'</option></select></div><div class="input-field col s12 m6 l6"><input type="text" name="Price" id="Price'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('price')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('price')+'\');" required maxlength="30"><label for="Price'+id+'">'+$.i18n('price')+' <span class="star">*</span></label></div><div class="col s12 m6"><label for="Currency'+id+'">'+$.i18n('currency')+' <span class="star">*</span></label><select class="browser-default" oninput="InvalidMsg(this,\'input\',\''+$.i18n('currency')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('currency')+'\');" required id="Currency'+id+'"><option value="" disabled selected>'+$.i18n('selectCurrency')+'</option></select></div></div><div class="row"><div class="col s12 m12"><p>IMEI/MEID/ESN</p></div><div class="input-field col s12 m6"><input type="text"   id="IMEIA'+id+'" required name="IMEI1" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIA'+id+'">1 <span class="star">*</span></label></div><div class="input-field col s12 m6"><input type="text" id="IMEIB'+id+'" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" name="IMEI2" pattern="[0-9]{15,16}"title="" maxlength="16"><label for="IMEIB'+id+'">2</label></div><div class="input-field col s12 m6"><input type="text" id="IMEIC'+id+'" name="IMEI3" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEIC'+id+'">3</label></div><div class="input-field col s12 m6"><input type="text" id="IMEID'+id+'" name="IMEI4[]" pattern="[0-9]{15,16}"title="" oninput="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');"oninvalid="InvalidMsg(this,\'input\',\''+$.i18n('IMEIValidationMSg')+'\');" maxlength="16"><label for="IMEID'+id+'">4</label></div></div><div style="cursor:pointer;background-color:red;" class="remove_field btn right btn-info">'+$.i18n('remove')+'</div></div>'
           );  //add input box
         
           populateCountries
        	(   
        			"country"+id
        	);
    
          
           var regularised=incrementedCurrent+1;
           incrementedCurrent=regularised;
          
           var token = $("meta[name='_csrf']").attr("content");
           var header = $("meta[name='_csrf_header']").attr("content");
           $.ajaxSetup({
           headers:
           { 'X-CSRF-TOKEN': token }
           });
           $.getJSON('./getDropdownList/CUSTOMS_TAX_STATUS', function(data) {
           	var dropdownid=id-1;
           	if(regularised <= allowed){
           		
          	$('#taxStatus'+dropdownid).prop('disabled', 'disabled');
      		$('<option  selected>').val("2").text("Regularized").appendTo('#taxStatus'+dropdownid);
      			//////console.log("+++++taxStatus"+dropdownid);
      		//alert("Regularised");
      		}
          	else{
          		for (i = 0; i < data.length; i++) {
          			$('<option>').val(data[i].value).text(data[i].interp)
          			.appendTo('#taxStatus'+dropdownid);
          			//alert("NonRegularised");
          			// $('#taxStatus'+dropdownid).prop('disabled', 'false');
          			//////console.log("+++++taxStatus"+dropdownid);
          		}
          	}
       	});




     

       	$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {
       		var dropdownid=id-1;
       		for (i = 0; i < data.length; i++) {
       			$('<option>').val(data[i].value).text(data[i].interp)
       			.appendTo('#deviceType'+dropdownid);
       			////console.log('#deviceType'+dropdownid)
       		}
       	});


       	
       	$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
       		var dropdownid=id-1;
       		for (i = 0; i < data.length; i++) {
       			$('<option>').val(data[i].value).text(data[i].interp)
       			.appendTo('#deviceIdType'+dropdownid);
       			////console.log('#deviceIdType'+dropdownid);
       		}
       	});
       	
       	$.getJSON('./getDropdownList/currency', function(data) {
       		var dropdownid=id-1;
       		for (i = 0; i < data.length; i++) {
       			$('<option>').val(data[i].value).text(data[i].interp)
       			.appendTo('#Currency'+dropdownid);
       			////console.log('#Currency'+dropdownid);
       		}
       	});
       	
       	$.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {
       		var dropdownid=id-1;
       		for (i = 0; i < data.length; i++) {
       			$('<option>').val(data[i].value).text(data[i].interp)
       			.appendTo('#multipleSimStatus'+dropdownid);
       			////console.log('#multipleSimStatus'+dropdownid);
       		}
       	});
       	
       	$.getJSON('./getDropdownList/DEVICE_STATUS', function(data) {
       		var dropdownid=id-1;
       		for (i = 0; i < data.length; i++) {
       			$('<option>').val(data[i].value).text(data[i].interp)
       			.appendTo('#deviceStatus'+dropdownid);
       			////console.log('#deviceStatus'+dropdownid);
       		}
       	});
           
       	
       	id++;
       	 ////console.log("regularised before set session=="+regularised);
            localStorage.removeItem('incrementedCurrent');
        	localStorage.setItem("incrementedCurrent", regularised);
       }
      
   });
   $(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
   	var Iid=id-1;
		 /*alert("@@@"+Iid)*/
		 $('#deviceInformation'+Iid).remove();
   	
   	e.preventDefault();
       $(this).parent('div').remove();
       x--;
       id--;
   })
}


 $(document).ready(function () {
	  	
	   
	   defaultDeviceForm()
   
   }); 
  RegularisedDeviceForm()



  
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
//alert(id-1);
var cuurecyId=id-1;
//alert(ssss);
var totalPriceaaa=$('#Price'+cuurecyId).val();
/*$('#country'+fieldId).val();*/
//alert(totalPriceaaa)
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





$('#deviceIdType1').on('change', function() {
	var value=parseInt($(this).val());

	switch (value) {
	case 0:
		$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").val('');
		/*$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("pattern","[0-9]{15,16}");
		*/$("#IMEIA1,#IMEIB1,#IMEIC1,#IMEID1").attr("maxlength","16");
		
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
