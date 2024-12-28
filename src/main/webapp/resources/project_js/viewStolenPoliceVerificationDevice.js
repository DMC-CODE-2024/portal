var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';


var featureId = $("body").attr("data-featureid");

var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
var startdate=$('#startDate').val(); 
var endDate=$('#endDate').val();



//var lang = $("body").attr("data-lang");

$.i18n().locale = lang;
/*$.i18n().locale = "en";*/

$.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
}).done(function() {
});



function loadEnCSS() {  
  
    if(filesAdded.indexOf('../resources/asset/css/en.css') !== -1) 
        return
  
    var head = document.getElementsByTagName('head')[0] 
      
    // Creating link element 
    var style = document.createElement('link')  
    style.href = '../resources/asset/css/en.css'
    style.type = 'text/css'
    style.rel = 'stylesheet'
    head.append(style); 
      
    // Adding the name of the file to keep record 
    filesAdded += ' ../resources/asset/css/en.css' 
  }
  function loadKmCSS() {  
  
    if(filesAdded.indexOf('../resources/asset/css/en.css') !== -1) 
        return
  
    var head = document.getElementsByTagName('head')[0] 
      
    // Creating link element 
    var style = document.createElement('link')  
    style.href = '../resources/asset/css/en.css'
    style.type = 'text/css'
    style.rel = 'stylesheet'
    head.append(style); 
      
    // Adding the name of the file to keep record 
    filesAdded += ' ../resources/asset/css/en.css' 
  }
  
var documenttype,selectfile,selectDocumentType;

$(document).ready(function(){
	$('#langlist').on('change', function() {
		lang = document.getElementById('langlist').value;
    	// Get selected language
    	window.location.href ='?lang='+ lang;
	});
	$('div#initialloader').fadeIn('fast');
	Datatable();
	pageRendering();
	getAllDropDown();
	documenttype=$.i18n('documenttype');
	selectfile=$.i18n('selectfile');
	selectDocumentType=$.i18n('selectDocumentType');
});

var role = currentRoleType == null ? roleType : currentRoleType;



//**************************************************Duplicate Device table**********************************************

function Datatable(){
	$('div#initialloader').fadeIn('fast');
	lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	var payload={
			"startDate":$('#startDate').val()=="" ? null : $('#startDate').val(),
			"endDate":$('#endDate').val()=="" ? null : $('#endDate').val(),
			"requestNo" : $('#filterRequestNo').val()==""  ? null : $('#filterRequestNo').val(),
			"imei" : $('#filterImei').val()==""  ? null : $('#filterImei').val(),
			"msisdn" : $('#filterMsisdn').val()==""  ? null : $('#filterMsisdn').val(),
			"operator" : $('#filterupldatedBy').val()==""  ? null : $('#filterOperator').val(),
			"status" : $('#filterMOIStatus').val()==""  ? null : $('#filterMOIStatus').val(),
			"uploadedBy" : $('#filterUploadedBy').val()==""  ? null : $('#filterUploadedBy').val(),
			"requestMode" : $('#filterRequestMode').val()==""  ? null : $('#filterRequestMode').val(),
			"requestType" : $('#filterRequestType').val()==""  ? null : $('#filterRequestType').val(),
			"province" : $('#filterProvince').val()==""  ? null : $('#filterProvince').val(),
			"district" : $('#filterDistrict').val()==""  ? null : $('#filterDistrict').val(),
			"commune" : $('#filterCommune').val()==""  ? null : $('#filterCommune').val(),
			"deviceType" : $('#filterDeviceType').val()==""  ? null : $('#filterDeviceType').val(),
			"lang":lang,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"auditTrailModel":{
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"userName" : $("body").attr("data-selected-username"),
 			}
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'headers?type=policeTrackLostDeviceHeaders&lang='+ lang,
		type: 'POST',
		dataType: "json",
		success: function(result){
			/*//////console.log("Url-------" +url+"--------"+ "dataUrl-------" +dataUrl);*/
			var table=	$("#LibraryTable").removeAttr('width').DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : true,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"bSearchable" : true,
				"language": {
                               "sEmptyTable": "No records found in the system",
                               "infoFiltered": ""
                              },
			    "aaSorting": [],
				columnDefs: [{
          		orderable: false,
	 	        targets: -1,
        		}],
				initComplete: function() {
			 		$('.dataTables_filter input')
   .off().on('keyup', function(event) {
	   if (event.keyCode === 13) {
			 table.search(this.value.trim(), false, false).draw();
		}
      
   });
   },
				ajax: {
					url : 'policeTrackLostDeviceData?lang='+ lang+"&featureId="+featureId,
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(payload); 
						////////console.log(JSON.stringify(filterRequest));
					}

				},
				"columns": result,
				fixedColumns: true,
			});
			$('div#initialloader').delay(300).fadeOut('slow');
			
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////////console.log("error in ajax");
		}
	});
}




//**************************************************Duplicate Device page buttons**********************************************

function pageRendering(){
	lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	return new Promise((resolve, reject) => {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'policeTrackLostDevice/pageRendering?lang='+ lang,
		//url: URL,
		type: 'POST',
		dataType: "json",
		success: function(data){
			var elem='<h1>'+data.pageTitle+'<h1>';
		    $("#pageHeaderTitle").append(elem);
		    //$("#pageHeader").append("<button type='button' id='uploadTABtn' class='btn btn-outline-dark mr-2' onclick='uploadTAData()'> + TA Upload </button>");
       		//$("#pageHeader").append("<button type='button' id='viewTABtn' class='btn btn-outline-dark' onclick='viewTAData()'> View TA Data </button>");
       		//$("#pageHeader").append("<button type='button' id='backBtn' class='btn btn-outline-dark' onclick='BackButton()' style='display: none'>Back</button>");
			var button=data.buttonList;
				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){  
								$("#dataTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#dataTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='"+$.i18n('EnterHere')+"' maxlength='19'/></div>");
						
					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#dataTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+date[i].id+">"+date[i].title+"</label>"+
										"<select id="+date[i].id+"  class='form-control'>"+
										"<option value='' selected>"+$.i18n('Select')+" </option>"+
										"</select>"+
										"</div>"+
								"</div>");	
					}
					
				} 
		
			
				var viewFilter="viewFilter";
				
				
				$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")
				$("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='clearFilter'  style='width:150px'>"+$.i18n('ResetAll')+"</button></div>");
				$("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='Datatable(null)'>"+$.i18n('ApplyFilter')+"<img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
				$("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>"+$.i18n('Export')+" <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

			$('#clearFilter').attr("onclick", "filterReset('filterform',null)");
			
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);
			
			}
			
			
			
			 resolve();
		}

	}); 
	});
	getAllDropDown();
};

function getAllDropDown(){
  
   $.getJSON('./getDistinctMOIDeviceType', function(data) {
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i]).text(data[i]).appendTo('#filterDeviceType');
    }
  });
  
  $.getJSON('./getPolistStatus', function(data) {
	//alert(data);
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i].value).text(data[i].name).appendTo('#filterMOIStatus');
    }
  });
   $.getJSON('./getDistinctRequestMode', function(data) {
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i]).text(data[i]).appendTo('#filterRequestMode');
    }
  });
  
   $.getJSON('./getDistinctRequestType', function(data) {
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i]).text(data[i]).appendTo('#filterRequestType');
    }
  });
  
  
  $.getJSON('./getDistinctCreatedBy', function(data) {
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i]).text(data[i]).appendTo('#filterUploadedBy');
    }
  });
  
 
  
  $.getJSON('./getMOIProvince', function(data) {
	//alert(data);
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i].id).text(data[i].province).appendTo('#filterProvince');
    }
  });
  
  $.getJSON('./getMOICommune', function(data) {
	//alert(data);
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i].id).text(data[i].commune).appendTo('#filterCommune');
    }
  });
  
  $.getJSON('./getMOIDistrict', function(data) {
	//alert(data);
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i].id).text(data[i].district).appendTo('#filterDistrict');
    }
  });
  
  $.getJSON('./getMOIPoliceStation', function(data) {
	//alert(data);
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i].id).text(data[i].police).appendTo('#filterPoliceStation');
    }
  });
}

function viewDevice(rowId){
	lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	 var tempId=rowId;
		if(tempId==null || tempId=="" || tempId==''){
			$("#noRecordMessage").openModal({
						 	   dismissible:false
						    });
			return false;
		}
		var request ={
				/*"id" :  rowId,*/
				"requestId" : rowId,
				"userId": parseInt(userId),
				"lang":lang,
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username")
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
				url: './tracklostbyid/view?lang='+lang,
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						var result = data
						console.log(JSON.stringify(result));
						$("#ViewTrackLostDeviceModel").openModal({
						 	   dismissible:false
						    });
						    setData(result);
				/*setApproveData(result);
				
				var table=	$("#viewApproveTable").removeAttr('width').DataTable({
				destroy:true,
				//"serverSide": true,
				data: result,
				//orderCellsTop : true,
				"ordering" : false,
				"bPaginate" : false,
				"bFilter" : false,
				"bInfo" : false,
				//"bSearchable" : true,
				"language": {
                            "sEmptyTable": "No records found in the system",
                            "infoFiltered": ""
                              },
			    "aaSorting": [],
				columns: [
                            { 'data': 'fileName' },
                            { 'data': 'documentType1' },
                            { 'data': 'operator' },
                            { 'data': '' },
                        ]
			});*/
			$('div#initialloader').delay(300).fadeOut('slow');
					//noRecordMessage	
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
					$("#noRecordMessage").openModal({
						 	   dismissible:false
						    });
				}
			});	
		}

function setData(stolenData){
		console.log(" stolenData=="+stolenData.imei1);
		var stolenDate=stolenData.deviceLostDdateTime.substring(0,10);
		var stolentime=stolenData.deviceLostDdateTime.substring(11);
		var OtpContactNumber=stolenData.contactNumberForOtp.substring(3,13);
		$('#stolenMgmtid').val(stolenData.id);
		$('#stolenMgmtRequestid').val(stolenData.requestId);
		 $('#stolenMobile1').val(stolenData.contactNumber);
		 $('#stolenIMEI1').val(stolenData.imei1);
		 $('#stolenIMEI2').val(stolenData.imei2);
		 $('#stolenIMEI3').val(stolenData.imei3);
		 $('#stolenIMEI4').val(stolenData.imei4);
		 $('#stolenDate').val(stolenData.deviceLostDdateTime);
		 $('#stolenDeviceBrand').val(stolenData.deviceBrand);
		 $('#stolenDeviceModel').val(stolenData.deviceModel);
		 $('#stolenDate').val(stolenDate);
		 $('#stolenTime').val(stolentime);
		 $('#stolenOwner').val(stolenData.deviceOwnerName);
		 $('#stolenEmail').val(stolenData.deviceOwnerEmail);
		 $('#stolenOwnerAddress1').val(stolenData.deviceOwnerAddress);
		 $('#stolenOwnerAddress2').val(stolenData.deviceOwnerAddress2);
		 $('#stolenOwnerNID').val(stolenData.deviceOwnerNationalID);
		 $('#stolenOwnerOTPContact').val(OtpContactNumber);
		 $('#ownerNationality').val(stolenData.deviceOwnerNationality);
		 $('#provinceCity').val(stolenData.province);
		 $('#district').val(stolenData.district);
		 $('#commune').val(stolenData.commune);
		 $('#ownerDOB').val(stolenData.ownerDOB);
		 $('#stolenOtpEmail').val(stolenData.otpEmail);
		 $('#stolenOwnerPassport').val(stolenData.passportNumber);
		 $('#category').val(stolenData.category);
		 $('#fileNameEdit').val(stolenData.mobileInvoiceBill);
		 $('#fileNameEdit2').val(stolenData.deviceOwnerNationalIdUrl);
		 $('#stolenPreviewID').attr("onclick",'previewStolenFile1("'+stolenData.firCopyUrl+'","'+stolenData.mobileInvoiceBill+'","'+stolenData.requestId+'")');
		 $('#stolenPreviewID2').attr("onclick",'previewStolenFile2("'+stolenData.firCopyUrl+'","'+stolenData.deviceOwnerNationalIdUrl+'","'+stolenData.requestId+'")');
}

function setApproveData(result){
	$('#viewDetectionDate').val(result.edrTime);
	$('#viewIMEI').val(result.imei);
	$('#viewPhoneNumber').val(result.msisdn);
	$('#viewUpdatedBy').val(result.updatedBy);
	$('#viewStatus').val(result.status);
	
	
}


$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});




function exportData() {
  var table = $('#LibraryTable').DataTable();
  var info = table.page.info();
  var pageNo = info.page;
  var pageSize = info.length;
  
  var payload={
			"startDate":$('#startDate').val()=="" ? null : $('#startDate').val(),
			"endDate":$('#endDate').val()=="" ? null : $('#endDate').val(),
			"requestNo" : $('#filterRequestNo').val()==""  ? null : $('#filterRequestNo').val(),
			"imei" : $('#filterImei').val()==""  ? null : $('#filterImei').val(),
			"msisdn" : $('#filterMsisdn').val()==""  ? null : $('#filterMsisdn').val(),
			"operator" : $('#filterupldatedBy').val()==""  ? null : $('#filterOperator').val(),
			"status" : $('#filterMOIStatus').val()==""  ? null : $('#filterMOIStatus').val(),
			"uploadedBy" : $('#filterUploadedBy').val()==""  ? null : $('#filterUploadedBy').val(),
			"requestMode" : $('#filterRequestMode').val()==""  ? null : $('#filterRequestMode').val(),
			"requestType" : $('#filterRequestType').val()==""  ? null : $('#filterRequestType').val(),
			"province" : $('#filterProvince').val()==""  ? null : $('#filterProvince').val(),
			"district" : $('#filterDistrict').val()==""  ? null : $('#filterDistrict').val(),
			"commune" : $('#filterCommune').val()==""  ? null : $('#filterCommune').val(),
			"deviceType" : $('#filterDeviceType').val()==""  ? null : $('#filterDeviceType').val(),
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"pageNo": parseInt(pageNo),
			"pageSize": parseInt(pageSize),
			"auditTrailModel":{
				"startDate":$('#startDate').val()==""  ? null : $('#startDate').val(),
				"endDate":$('#endDate').val()==""  ? null : $('#endDate').val(),
 				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"userName" : $("body").attr("data-selected-username"),
			}
	}
	
  ////console.log(JSON.stringify(filterRequest))
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: './export-police-trackLost-details',
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(payload),
    success: function(data, textStatus, jqXHR) {
      window.location.href = data.url;
    },
    error: function(jqXHR, textStatus, errorThrown) {}
  });
}


function previewStolenFile1(srcFilePath,srcFileName,txnId,doctype){
	////console.log("doctype=="+doctype)
	window.filePath = srcFilePath;
	window.fileName = srcFileName;
	window.fileExtension = fileName.replace(/^.*\./, '');
	if(doctype=='')
	{
		window.FinalLink = filePath.concat(txnId).concat('/'+fileName);
	}
	else if(doctype==undefined)
	{
		window.FinalLink = filePath.concat(txnId).concat('/'+fileName);
	}else{
		window.FinalLink = filePath.concat(txnId).concat('/'+doctype).concat('/'+fileName);
	}
 
	//////console.log(FinalLink);
	if(filePath == null || filePath == "" || filePath == undefined && fileName == null || fileName == "" || fileName == undefined ){
		////console.log("File is not Avialable")
	}else if(fileExtension=="jpg" || fileExtension=="jpeg" || fileExtension=="png" || fileExtension=="gif" || fileExtension=="PNG" ){
		$("#fileSource").attr("src",FinalLink);
		$("#viewuplodedModel").openModal({dismissible:false});
	}else{
		window.open(FinalLink);
	}
}
 
 
function previewStolenFile2(srcFilePath,srcFileName,txnId,doctype){
	////console.log("doctype=="+doctype)
	window.filePath = srcFilePath;
	window.fileName = srcFileName;
	window.fileExtension = fileName.replace(/^.*\./, '');
	if(doctype=='')
	{
		window.FinalLink = filePath.concat(txnId).concat('/'+fileName);
	}
	else if(doctype==undefined)
	{
		window.FinalLink = filePath.concat(txnId).concat('/'+fileName);
	}else{
		window.FinalLink = filePath.concat(txnId).concat('/'+doctype).concat('/'+fileName);
	}
 
	//////console.log(FinalLink);
	if(filePath == null || filePath == "" || filePath == undefined && fileName == null || fileName == "" || fileName == undefined ){
		////console.log("File is not Avialable")
	}else if(fileExtension=="jpg" || fileExtension=="jpeg" || fileExtension=="png" || fileExtension=="gif" || fileExtension=="PNG" ){
		$("#fileSource").attr("src",FinalLink);
		$("#viewuplodedModel").openModal({dismissible:false});
	}else{
		window.open(FinalLink);
	}
}

function filterReset(formID,action){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	Datatable();
	$('#errorMsg').text('');
}





$("#fileInput").change(function(){
	if($("#fileInput").val()!=""){
		$('#submitButton').removeClass('disabled');
	}
	
});	


function approveDevice(rowId){
	$("#approvefileModal").openModal({
        dismissible:false
    });	
    $('#rowId').text(rowId);
}


function remove_field(fieldId ){
				$('#filediv' + fieldId).remove();
};

function policeFIRUpload(tid) {
	$('#requestNo').val(tid);
	$("#uploadTAfileModal").openModal({
		dismissible: false
	});

};


function openApprovePopUp(tid) {
	$('#requestNo').val(tid);
	$("#approveMOIAdminModal").openModal({
		dismissible: false
	});

};
function openDisapprovePopup(tid) {
	$('#requestNo1').val(tid);
	$("#rejectedMOIAdminModal").openModal({
		dismissible: false
	});

};

function uploadFile() {
	//console.log("Add function called");
	var formData = new FormData();
	var fileName = $("#fileInput").val().replace('C:\\fakepath\\', '');
	var remarks = $('#addRemark').val();
	var requestNo = $('#requestNo').val();
	formData.append('remarks', remarks);
	formData.append('requestType', 'QA');
	var temp = document.getElementById("fileInput").files.item(0);
	
	var multirequest = {
		"fileName": fileName,
		"remarks": $('#addRemark').val(),
		"userId": userId,
		"requestNo" : requestNo,
		"status" : "VERIFY_MOI",
		"auditTrailModel":{
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
 		}
	};

	formData.append('file', temp);
	formData.append("multirequest", JSON.stringify(multirequest));
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': token
		}
	});
	$.ajax({
		url: './firUploadFile',
		type: 'POST',
		data: formData,
		mimeType: 'multipart/form-data',
		enctype: 'multipart/form-data',
		processData: false,
		contentType: false,
		async: false,


		success: function(response, textStatus, jqXHR) {
			//console.log(JSON.stringify(response));
			$("#uploadTAfileModal").closeModal({
				dismissible: false
			});
			$('#addRemark').val('');
			$('#saveConfirmationMessage').openModal({
				dismissible: false
			});
			setTimeout(function() {
				$('#saveConfirmationMessage').closeModal({
					dismissible: false
				});
			}, 3000);
			filterReset('filterform', null);
			Datatable(lang, null);
			ResetModel();
		},
		error: function(jqXHR, textStatus, errorThrown) {
			//console.log("error in ajax")
		}
	});
	return false;
};

function requestReject(status) {
	var formData = new FormData();
	var remarks = $('#addRemark1').val();
	var requestNo = $('#requestNo1').val();
	formData.append('remarks', remarks);
	formData.append('requestType', 'QA');
	var temp = document.getElementById("fileInput").files.item(0);
	var multirequest = {
		"remarks": $('#addRemark1').val(),
		"userId": userId,
		"requestNo" : requestNo,
		"status" : status,
		"auditTrailModel":{
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
 		}
	};
	formData.append("multirequest", JSON.stringify(multirequest));
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': token
		}
	});
	$.ajax({
		url: './approvedRejectMOIAdmin',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		async: false,
		success: function(response, textStatus, jqXHR) {
			//console.log(JSON.stringify(response));
			
			$('#rejectedMOIAdminModal #addRemark1').val('');
			$('#approveMOIAdminModal #addRemark').val('');
			$("#rejectedMOIAdminModal").closeModal({
				dismissible: false
			});
			
			$('#approveRejectConfirmationMessage').openModal({
				dismissible: false
			});
			setTimeout(function() {
				$('#approveRejectConfirmationMessage').closeModal({
					dismissible: false
				});
			}, 3000);
			
			
			filterReset('filterform', null);
			Datatable(lang, null);
			
		},
		error: function(jqXHR, textStatus, errorThrown) {
			//console.log("error in ajax")
			$('#rejectedMOIAdminModal').openModal({
				dismissible: false
			});
		}
	});
	return false;
};
function requestApproved(status) {
	var formData = new FormData();
	var remarks = $('#addRemark').val();
	var requestNo = $('#requestNo').val();
	formData.append('remarks', remarks);
	formData.append('requestType', 'QA');
	var temp = document.getElementById("fileInput").files.item(0);
	var multirequest = {
		"remarks": $('#addRemark').val(),
		"userId": userId,
		"requestNo" : requestNo,
		"status" : status,
		"auditTrailModel":{
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
 		}
	};
	formData.append("multirequest", JSON.stringify(multirequest));
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': token
		}
	});
	$.ajax({
		url: './approvedRejectMOIAdmin',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		async: false,
		success: function(response, textStatus, jqXHR) {
			console.log(JSON.stringify(response));
			
			$('#rejectedMOIAdminModal #addRemark1').val('');
			$('#approveMOIAdminModal #addRemark').val('');
			$("#approveMOIAdminModal").closeModal({
					dismissible: false
			});
			
			$('#approveRejectConfirmationMessage').openModal({
				dismissible: false
			});
			setTimeout(function() {
				$('#approveRejectConfirmationMessage').closeModal({
					dismissible: false
				});
			}, 3000);
			
			filterReset('filterform', null);
			Datatable(lang, null);
			//ResetModel();
		},
		error: function(jqXHR, textStatus, errorThrown) {
			//console.log("error in ajax")
		}
	});
	return false;
};