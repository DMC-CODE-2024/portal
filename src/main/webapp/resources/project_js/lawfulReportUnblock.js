/**
 * 
 */
function saveIndivisualRecoveryRequest()
{
	if($('#sigleRecoverydeviceIDType').val()==0){
		

		var luhnIMEI1=luhnCheck('sigleRecoveryimeiNumber1','sigleRecoverydeviceIDType');
		var luhnIMEI4="";
		var luhnIMEI3="";
		var luhnIMEI2='';
		if($('#sigleRecoveryimeiNumber2').val()!=null || $('#sigleRecoveryimeiNumber2').val()!=''){
			var luhnIMEI2 =luhnCheck('sigleRecoveryimeiNumber2','sigleRecoverydeviceIDType')	
		}
		 if($('#sigleRecoveryimeiNumber3').val()!=null || $('#sigleRecoveryimeiNumber3').val()!=''){
			var luhnIMEI3 = luhnCheck('sigleRecoveryimeiNumber3','sigleRecoverydeviceIDType')	
		}
		
		 if($('#sigleRecoveryimeiNumber4').val()!=null || $('#sigleRecoveryimeiNumber4').val()!=''){
			 luhnIMEI4= luhnCheck('sigleRecoveryimeiNumber4','sigleRecoverydeviceIDType')	
		}
		
		//alert("luhnIMEI1 "+luhnIMEI1+" luhnIMEI2 = "+luhnIMEI2+" luhnIMEI3 "+luhnIMEI3+" luhnIMEI4 = "+luhnIMEI4);
		if(luhnIMEI1==false || luhnIMEI2==false || luhnIMEI3==false || luhnIMEI4==false)
		{
			//alert("failed");
			return false
		}
		
		var checkIMEI=checkDuplicateImei($('#sigleRecoveryimeiNumber1').val(),$('#sigleRecoveryimeiNumber2').val(),$('#sigleRecoveryimeiNumber3').val(),$('#sigleRecoveryimeiNumber4').val());
		if(checkIMEI===true){
		$('#errorMsgOnModal').text('');
		$('#errorMsgOnModal').text($.i18n('duplicateImeiMessage'));
		return false;
	}
	}
var formData= new FormData();
$("#singleDeviceRecovery").prop('disabled', true);
$('div#initialloader').fadeIn('fast');
	var sigleRecoverydeviceBrandName=$('#sigleRecoverydeviceBrandName').val();
	
	var sigleRecoveryimeiNumber1=$('#sigleRecoveryimeiNumber1').val();
	var sigleRecoveryimeiNumber2=$('#sigleRecoveryimeiNumber2').val();
	var sigleRecoveryimeiNumber3=$('#sigleRecoveryimeiNumber3').val();
	var sigleRecoveryimeiNumber4=$('#sigleRecoveryimeiNumber4').val();
	var sigleRecoverydeviceIDType=$('#sigleRecoverydeviceIDType').val();
	var sigleRecoverydeviceType=$('#sigleRecoverydeviceType').val();
	
	if(sigleRecoverydeviceIDType==''){
		sigleRecoverydeviceIDType=null;
	}
	
	if(sigleRecoverydeviceType==''){
		sigleRecoverydeviceType=null;
	}
	
	var sigleRecoverydeviceSimStatus=$('#sigleRecoverydeviceSimStatus').val();
    var sigleRecoveryserialNumber=$('#sigleRecoveryserialNumber').val();
	
	var sigleRecoveryaddress=$('#sigleRecoveryaddress').val();
	var sigleRecoverystreetNumber=$('#sigleRecoverystreetNumber').val();
	var sigleRecoveryvillage=$('#sigleRecoveryvillage').val();
	var sigleRecoverylocality=$('#sigleRecoverylocality').val();
	var sigleRecoverydistrict=$('#sigleRecoverydistrict').val();
	var sigleRecoverycommune=$('#sigleRecoverycommune').val(); 
	var sigleRecoverypin=$('#sigleRecoverypin').val();
   /* var deviceRecoveryDate=$('#deviceRecoveryDevice').val();*/
	var sigleRecovery =$('#sigleRecovery').val();
	var country1=$('#country1').val();
	var state1=$('#state1').val();
	//var sigleRecoverydeviceStatus=$('#sigleRecoverydeviceStatus').val();
	var sigleRecoveryBlockPeriod=$('#singleRecoveryDatePeriod').val();
	var blockingType ='Immediate';
	var IndivisualRecoveryDevice=$('#IndivisualRecoveryDevice').val();
	var singleStolenmodalNumber=$('#singleRecoverymodalNumber').val();
	var singleStolendeviceBrandName=$('#sigleRecoverydeviceBrandName').val();

	if($('#sigleRecoverydeviceBrandName').val()==930){
		sigleRecoverydeviceBrandName= $('#OtherBrandName').val();
		
	}
	
	if(sigleRecoverypin==""){
		sigleRecoverypin=null;
	}
	var stolenIndividualUserDB={
			"deviceBrandName": sigleRecoverydeviceBrandName,
			"deviceIdType": sigleRecoverydeviceIDType,
			"deviceStolenCommune": sigleRecoverycommune,
			"deviceStolenDistrict": sigleRecoverydistrict,
			"deviceStolenLocality": sigleRecoverylocality,
			"deviceStolenPostalCode": sigleRecoverypin,
			"deviceStolenPropertyLocation": sigleRecoveryaddress,
			"deviceStolenStreet": sigleRecoverystreetNumber,
			"deviceStolenVillage": sigleRecoveryvillage,
			"deviceType":sigleRecoverydeviceType,
			"imeiEsnMeid1": parseInt(sigleRecoveryimeiNumber1),
			"imeiEsnMeid2": parseInt(sigleRecoveryimeiNumber2),
			"imeiEsnMeid3": parseInt(sigleRecoveryimeiNumber3),
			"imeiEsnMeid4": parseInt(sigleRecoveryimeiNumber4),
			"deviceStolenProvince": state1,
			"multiSimStatus":sigleRecoverydeviceSimStatus,
			"deviceStolenCountry":country1,
			"deviceSerialNumber":sigleRecoveryserialNumber,
			"modelNumber":singleStolenmodalNumber,
			
			
	}
	

	var request={
			"dateOfRecovery":IndivisualRecoveryDevice,
			"blockingType":blockingType,
			"deviceQuantity":1,
			"requestType":1,
			"sourceType":5,
			"remark": sigleRecovery,
			"stolenIndividualUserDB":stolenIndividualUserDB
	}

	formData.append("request",JSON.stringify(request));
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.ajax({
		url: './lawfulIndivisualRecovery',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (response, textStatus, jqXHR) {
			$('div#initialloader').delay(300).fadeOut('slow');
			if(response.errorCode=='0'){
				$("#indivisualStolenButton").prop('disabled', true);
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#IndivisualStolenTxnId').text(response.txnId)
			}
			else if(response.errorCode=='5'){
				
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#sucessMessage').text('');
				$('#sucessMessage').text($.i18n(response.tag));
			}
			else{
//				$('#sucessMessage').text('');
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#sucessMessage').text('');
				$('#sucessMessage').text(response.message);
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")
			$('div#initialloader').delay(300).fadeOut('slow');

		}
	});
	return false;


}

function saveCompanyRecoveryRequest(){
	$('div#initialloader').fadeIn('fast');
	$("#bulkRecoverySubmit").prop('disabled', true);
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
	var bulkDevicequantity=$('#recoveryDevicequantity').val();
	if(bulkRecoverypin=="")
		{
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
		url: './lawfulIndivisualRecovery',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (response, textStatus, jqXHR) {
			
			$('div#initialloader').delay(300).fadeOut('slow');
		////console.log(JSON.stringify(response));
		var resp= JSON.stringify(response);
		////console.log(resp.errorCode);
		////console.log(response.errorCode);
		if(response.errorCode=='0'){
				$("#indivisualStolenButton").prop('disabled', true);
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#IndivisualStolenTxnId').text(response.txnId)
			}
		else if(response.errorCode=='5'){
		
			$('#IndivisualStolenSucessPopup').openModal({
				dismissible:false
			});
			$('#sucessMessage').text('');
			$('#sucessMessage').text($.i18n(response.tag));
		}
			else{
//				$('#sucessMessage').text('');
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#sucessMessage').text('');
				$('#sucessMessage').text(response.message);
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax")
			$('div#initialloader').delay(300).fadeOut('slow');

		}
	});
	return false;

}
$("#bulkRecoverycountry").val("Cambodia").change();
/*$("#bulkRecoverycountry").attr("style", "pointer-events: none;");*/

