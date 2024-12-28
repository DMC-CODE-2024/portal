var featureId = $("body").attr("data-featureId");
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
var startdate=$('#startDate').val(); 
var endDate=$('#endDate').val();
var lang='en';

$(document).ready(function(){

	TrcDataTable();
	TAPageRendering();
});

var role = currentRoleType == null ? roleType : currentRoleType;


function TrcDataTable(lang, action) {
  	Datatable('headers?type=ApprovedDeviceHeaders', 'trcData');
 };

function TAPageRendering(){
	pageRendering('typeApproved/pageRendering',null).then(() => setAllDropdown());	
		
}



//**************************************************Message Detail table**********************************************

function Datatable(Url, dataUrl){

	var payload={
			"fileName":$('#fileName').val()=="" ? null : $('#fileName').val(),
			"status" : $('#status').val()==""  ? null : $('#status').val(),
			"requestType" : "TA",
			"uploadedBy" :   $('#uploadedBy').val()==""  ? null : $('#uploadedBy').val(),
			"transactionId":$('#transactionID').val()=="" ? null : $('#transactionID').val(),
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
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		//url: 'headers?type=ApprovedDeviceHeaders',
		url: Url,
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
					//url : 'approvedDeviceData',
					url : dataUrl,
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


//**************************************************MessageManagement page buttons**********************************************

function pageRendering(URL,requestType){

	return new Promise((resolve, reject) => {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		//url: 'typeApproved/pageRendering',
		url: URL,
		type: 'POST',
		dataType: "json",
		success: function(data){
			var elem='<h1>'+data.pageTitle+'<h1>';
		    $("#pageHeaderTitle").append(elem);
		    $("#pageHeader").append("<button type='button' id='uploadTABtn' class='btn btn-outline-dark mr-2' onclick='uploadTAData()'> + TA Upload </button>")
       		  let html = "./view-typeApprove?FeatureId="+featureId;
                $("#pageHeader").append('<a href='+html+' target="mainArea"><button type="button"  id="btnLink"  class="btn btn-outline-dark">View TA Data</button></a>');

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
				//$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter'><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
				//$("#filterButtonDiv").append("<div><button type='button' class='btn btn-outline-dark' id='submitFilter'> <span><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></span>Apply Filter</button></div>");
				//$("#filterButtonDiv").append("<div><button type='button' class='btn btn-outline-dark' id='submitFilter' > <span><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></span>Apply Filter</button></div>");
				//$("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>"+$.i18n('Export')+"<img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
				
				$("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='TrcDataTable(null)'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
				$("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>"+$.i18n('Export')+" <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

			$('#clearFilter').attr("onclick", "filterReset('filterform',null)");
			

			resolve();
		}

	}); 
	});
};




function setAllDropdown(){
	var RequestData =  ["status"];
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./TRCDropdownList",
		data :	JSON.stringify(RequestData),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
		//const map = new Map(data);	
		////console.log("data-- " +JSON.stringify(data));
		const result = data;
		for (const status of result['status']){
			$('<option>').val(status).text(status).appendTo('#status');
		}
		
	},
		error : function() {
			//alert("Failed");
		}
	});


}


function uploadTAData(){
	$("#uploadTAfileModal").openModal({
        dismissible:false
    });
	
};

function addTAFile(){
	////console.log("Add function called");
	var formData = new FormData();
	var fileName= $("#fileInput").val().replace('C:\\fakepath\\', '');
	var remarks = $('#addRemark').val();
	formData.append('remarks', remarks);
	formData.append('requestType', 'TA');
	var temp = document.getElementById("fileInput").files.item(0);
	
	var multirequest = {
		"fileName": fileName,
		"remarks" : $('#addRemark').val(),
		"userId": userId
	};
 	
 	 formData.append('file', temp);
 	//formData.append('file', $('#fileInput').files[0]);
 	//formData.append('file', fileName);
	formData.append("multirequest",JSON.stringify(multirequest));
	////console.log("multiRequest" +JSON.stringify(multirequest));
	
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
   $.ajax({
    url: './uploadfile',
    type: 'POST',
    data: formData,
    mimeType: 'multipart/form-data',
    enctype: 'multipart/form-data',
    processData: false,
    contentType: false,
    async: false,
    
    
    success: function(response, textStatus, jqXHR) {

      //////console.log(JSON.stringify(response));
      $("#uploadTAfileModal").closeModal({
        dismissible:false
    });
    const jsonObject = JSON.parse(response);
      	  otpSuccessModal(' File uploaded successfully and your Txn ID is : '+ jsonObject.requestID);
  	//$("#addMobileDetailDiv").css("display", "none");
    //$("#datatableViewDiv").css("display", "block");
      filterReset('filterform',null);
  	  TrcDataTable(lang, null);
  	  ResetModel();

/*  	   $('#saveConfirmationMessage').openModal({
    	dismissible: false
  	  });
   setTimeout(function() {
   $('#saveConfirmationMessage').closeModal({
    	dismissible: false
  	  });
	}, 3000);*/
      //$("#mobileDetailEditDiv").css("display", "block");
      //alert("inside save success function" +JSON.stringify(response));
    },
    error: function(jqXHR, textStatus, errorThrown) {
      ////console.log("error in ajax")
    }
  });
   return false;
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
			"fileName":$('#fileName').val()=="" ? null : $('#fileName').val(),
			"status" : $('#status').val()==""  ? null : $('#status').val(),
			"requestType" : "TA",
			"transactionId":$('#transactionID').val()=="" ? null : $('#transactionID').val(),
			"uploadedBy" :   $('#uploadedBy').val()==""  ? null : $('#uploadedBy').val(),
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
    url: './export-table-details',
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
		TrcDataTable();
		$('#errorMsg').text('');

}

function ResetModel(){
	$("#addRemark").val("");
	$("#fileInput").val("");
	//$('#submitButton').addClass('disabled')
};

