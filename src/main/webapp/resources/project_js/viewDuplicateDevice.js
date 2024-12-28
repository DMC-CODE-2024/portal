//var featureId = 91;
var featureId = $("body").attr("data-featureId");
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
var startdate=$('#filterDetectionDate').val(); 
var endDate=$('#endDate').val();

$.i18n().locale = "en";
var documenttype,selectfile,selectDocumentType;

$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	Datatable();
	TAPageRendering();
	documenttype=$.i18n('documenttype');
	selectfile=$.i18n('selectfile');
	selectDocumentType=$.i18n('selectDocumentType');
});

var role = currentRoleType == null ? roleType : currentRoleType;


function TAPageRendering(){
	pageRendering('typeApproved/pageRendering',null).then(() => setAllDropdown());	
		
}



//**************************************************Duplicate Device table**********************************************

function Datatable(){
	$('div#initialloader').fadeIn('fast');
	var payload={
			"edrTime":$('#filterDetectionDate').val()=="" ? null : $('#filterDetectionDate').val(),
			"imei" : $('#filterImei').val()==""  ? null : $('#filterImei').val(),
			"msisdn" : $('#filterMsisdn').val()==""  ? null : $('#filterMsisdn').val(),
			"updatedBy" : $('#filterupldatedBy').val()==""  ? null : $('#filterupldatedBy').val(),
			"redmineTktId": $('#redmineTktId').val()==""  ? null : $('#redmineTktId').val(),
			"status" : $('#filterStatus').val()==""  ? null : $('#filterStatus').val(),
			"featureId":parseInt(featureId),
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username")
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'headers?type=duplicateDeviceHeaders',
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
					url : 'getDuplicateDeviceDetails',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(payload); 
						//console.log(JSON.stringify(filterRequest));
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

	return new Promise((resolve, reject) => {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'duplicateDevice/pageRendering',
		//url: URL,
		type: 'POST',
		dataType: "json",
		success: function(data){
			var elem='<h1>'+data.pageTitle+'<h1>';
		    $("#pageHeaderTitle").append(elem);
		    var button=data.buttonList;
				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){  
								$("#dataTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDetactionDate(filterDetectionDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						$("#dataTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");
						
					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#dataTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+date[i].id+">"+date[i].title+"</label>"+
										"<select id="+date[i].id+"  class='form-control'>"+
										"<option value='' selected>Select</option>"+
										"</select>"+
										"</div>"+
								"</div>");	
					}
					
				} 
		
			
				var viewFilter="viewFilter";
				
				
				$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")
				$("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='clearFilter'>Reset All</button></div>");
				$("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='Datatable(null)'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
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
};


function setAllDropdown(){
	
	$.getJSON('./getDropdownList/DUPLICATE_IMEI', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interpretation)
				.appendTo('#filterStatus');
		}
	});
	
	$.getJSON('./getDropdownList/DUPLICATE_DOCUMENT_TYPE', function(data) {
 		for (var i = 0; i < data.length; i++) {
            // Create and append options to the current select element
            $('<option>').val(data[i].value).text(data[i].interpretation).appendTo("#docTypetag1");
        }
    });
	
}






function viewDevice(rowId,ticketId){
		var request ={
				"id" :  parseInt(rowId),
				"redmineTktId" : ticketId,
				"userId": parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username"),
				"featureId":parseInt(featureId),
				"userId":parseInt(userId),
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
				url: './view',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						var result = data.data
						//console.log(JSON.stringify(result));
						$("#ViewApprovedModel").openModal({
						 	   dismissible:false
						    });
				setApproveData(result);
				//getRedmineDocs(ticketId);
				
				
			$('div#initialloader').delay(300).fadeOut('slow');
						
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				}
			});	
		}



function setApproveData(result){
	$('#viewDetectionDate').val(result.edrTime);
	$('#viewIMEI').val(result.imei);
	$('#viewPhoneNumber').val(result.msisdn);
	$('#viewUpdatedBy').val(result.updatedBy);
	$('#viewStatus').val(result.status);
	
	
        var responseData = {
            "documentName": result.documentName,
            "documentType": result.documentType,
            "documentPaths": result.documentPaths
        };
 		
function destroyDataTable() {            
	if ($.fn.DataTable.isDataTable('#viewApproveTable')) {                 
	$('#viewApproveTable').DataTable().destroy(); 
	} 
}

function initializeDataTable() {
	$('#viewApproveTable').DataTable({
		"searching": false,
		"bPaginate": false,
		"bInfo" : false,
		"ordering": false,
		"language": {
                 "sEmptyTable": "No records found in the system",
                 "infoFiltered": ""
         }
	}); 
}
		destroyDataTable(); 
		var table = $('#viewApproveTable tbody');
    	table.empty();				 
        // Loop through the arrays and populate the table
        for (var i = 0; i < responseData.documentPaths.length; i++) {
                table.append('<tr><td>' + responseData.documentName[i] + '</td><td>' + responseData.documentType[i] + '</td><td><a onclick="viewUploadedFile(\'' + responseData.documentName[i] + '\',\'' + responseData.documentPaths[i] + '\')" title="View" id="previewImage"><img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid"></a></td></tr>');
         }
 		
 		initializeDataTable();
	
        
    	
}

function resetImage(){
	$("#viewApprovedDocument img").attr("src", "");
}

function viewUploadedFile(documentName,uploadedFilePath){
    var fileExtension = documentName.split('.').pop().toLowerCase();
    var imageExtensions = ["png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "svg", "heif", "heic"];
	if (imageExtensions.includes(fileExtension)) {
        $("#viewApprovedDocument").openModal({
                dismissible:false
            });
        $("#viewApprovedDocument img").attr("src", uploadedFilePath);
    }else{
        window.open(finalLink);
    };


};


$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});




function exportData() {
  var table = $('#LibraryTable').DataTable();
  var info = table.page.info();
  var pageNo = info.page;
  var pageSize = info.length;
  
  var payload={
			"edrTime":$('#filterDetectionDate').val()=="" ? null : $('#filterDetectionDate').val(),
			"imei" : $('#filterImei').val()==""  ? null : $('#filterImei').val(),
			"msisdn" : $('#filterMsisdn').val()==""  ? null : $('#filterMsisdn').val(),
			"redmineTktId": $('#redmineTktId').val()==""  ? null : $('#redmineTktId').val(),
			"updatedBy" :   $('#filterupldatedBy').val()==""  ? null : $('#filterupldatedBy').val(),
			"status" : $('#filterStatus').val()==""  ? null : $('#filterStatus').val(),
			"featureId":parseInt(featureId),
			"pageNo": parseInt(pageNo),
			"pageSize": parseInt(pageSize),
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
			
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
    url: './export-duplicate-details',
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(payload),
    success: function(data, textStatus, jqXHR) {
     finalURL(data.url);
    },
    error: function(jqXHR, textStatus, errorThrown) {}
  });
}



function filterReset(formID,action){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	Datatable();
	$('#errorMsgDiv').text('');
}





$("#docTypeFile1").change(function(){
	if($("#docTypeFile1").val()!=""){
		$('#submitButton').removeClass('disabled');
		$('#submitButton').prop('disabled', false);
		$('#approveRemark').prop('disabled', false);
		
	}
	
});	

function resetApproveModel(){
	$('#duplicateApproveForm').trigger('reset');
	$('.form-row.document-row:not(:first)').hide().find('select, input').val('');
	$('#rowId').text('');
	
	//$('#submitButton').prop('disabled', true);
    //$('#submitButton').addClass('disabled');
    //$('#docTypeFile1').prop('disabled', true);
    //$('#approveRemark').prop('disabled', true);
    
};

function approveDevice(rowId){
	$("#approvefileModal").openModal({
        dismissible:false
    });	
    $('#rowId').text(rowId);
}



function add_field_button() {
    var rowId = $('.document-row').length + 1;
    if(rowId<=4){
	var newRow = `
        <div class="form-row document-row" id="filediv${rowId}">
            <div class="form-group col-md-5">
                <label for="">Document Type</label>
                <select class="form-control" id="docTypetag${rowId}">
                    <option>Select Document Type</option>
                </select>
            </div>
            <div class="form-group col-md-5">
                <label for="">Browse File</label>
                <input class="input-file mb-1" id="docTypeFile${rowId}" type="file" name="files${rowId}" accept=".png, .jpg, .jpeg, .pdf"
                size="2097152">
            </div>
            <div class="form-group col-md-2">
            	<label for="" class="mt-38"><a href="#" onclick="remove_field('${rowId}')" class="addImei">- Remove</a></label>
            </div>
        </div>
`;  
    $('#imeiContainer').append(newRow);
     
 	}
 	$.getJSON('./getDropdownList/DUPLICATE_DOCUMENT_TYPE', function(data) {
 	$("#docTypetag" + rowId).each(function() {
        // Iterate over the data array
        for (var i = 0; i < data.length; i++) {
            // Create and append options to the current select element
            $('<option>').val(data[i].value).text(data[i].interpretation).appendTo(this);
        }
    });
    });
}; 	




function remove_field(fieldId ){
	
    $('#filediv' + fieldId).remove();
		
};

function approveDuplicate(){
	
	var formData;
    formData = new FormData();
	var requestData  = {}; 
	var id = parseInt($("#rowId").text());
	requestData['id'] = id;
	 $('.document-row').each(function(index) {
        var documentType = $(this).find('select').val(); 
        var fileInput = $(this).find('input[type=file]')[0]; 

        if (fileInput.files.length > 0) {
            var file = fileInput.files[0]; 
            var fileName = file.name; 

            // Set document type and file name for each document
            requestData['documentType' + (index + 1)] = documentType;
            requestData['documentFileName' + (index + 1)] = fileName;
            formData.append("file" + (index + 1), file);
        } else {
            // Handle case where no file is selected for this row, if needed
            //('No file selected for document row ' + (index + 1));
        }
    });
    var approveRemark = $("#approveRemark").val();
    requestData['approveRemark'] = approveRemark;
    
    formData.append("id", id);  
    formData.append("multirequest",JSON.stringify(requestData));
     //console.log("requestData"+JSON.stringify(requestData));
    $.ajax({
        url: 'approveDevice',
        type: 'POST',
        data: formData,
    	processData: false,  // Don't process the data
    	contentType: false,
    	async: false,
        success: function(response) {
           //console.log("response" +JSON.stringify(response));
            resetApproveModel();
            $("#approvefileModal").closeModal({
       			 dismissible:false
    		});	
            Datatable();
            $('#saveConfirmationMessage').openModal({
    		dismissible: false
  	  		});
   			setTimeout(function() {
   		$('#saveConfirmationMessage').closeModal({
    	dismissible: false
  	  });
	}, 3000);
        },
        error: function(xhr, status, error) {
            // Handle error
        }
    });
    return false;
}

function enableFileInput() {
        var selectValue = document.getElementById('docTypetag1').value;
        var fileInput = document.getElementById('docTypeFile1');
        if (selectValue !== 'Select Document Type') {
            fileInput.disabled = false;
        } else {
        	fileInput.disabled = true;
            resetApproveModel();
        }
    }

