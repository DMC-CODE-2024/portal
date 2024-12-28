var featureId = 70;
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
var startdate=$('#startDate').val(); 
var endDate=$('#endDate').val();
var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	VIPLISTDatatable();
	pageRendering();
	
});

var role = currentRoleType == null ? roleType : currentRoleType;


//**************************************************Config Detail table**********************************************

function VIPLISTDatatable(){
	$('div#initialloader').fadeIn('fast');
	var ellipsis = "...";
	var featureName=$('#featureName').val();
	if(featureName ==""){
		featureName=null;
	}
	var filterRequest={
		
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"tag":$('#parametername').val(),
			"type" : parseInt($('#type').val()),
			"featureName" :featureName,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username"),
			"msisdn":$('#msisdnId').val(),
			"imei":$('#imeiId').val(),
			"sno":$('#snoId').val(),
			"imsi":$('#imsiId').val(),
			"userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType")
	}
	if(lang=='en'){
		var langFile='./resources/i18n/english_datatable.json';
	}
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'headers?type=blackListHeaders',
		type: 'POST',
		dataType: "json",
		success: function(result){
			/*console.log("Url-------" +url+"--------"+ "dataUrl-------" +dataUrl);*/
			var table=	$("#configLibraryTable").removeAttr('width').DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : true,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"bSearchable" : true,
				"oLanguage": {
			        "sEmptyTable": "No records found in the system"
			    },
			    "aaSorting": [],
				
				initComplete: function() {
			 		$('.dataTables_filter input')
   .off().on('keyup', function(event) {
	   if (event.keyCode === 13) {
			 table.search(this.value.trim(), false, false).draw();
		}
      
   });
   },
				ajax: {
					url : 'BLACKListData',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(filterRequest); 
						//console.log(JSON.stringify(filterRequest));
					}

				},
				"columns": result,
				fixedColumns: true,
				columnDefs: [
					{
					render: function ( data, type, row ) {
					    return data.length > 80 ?
					        data.substr( 0, 80 ) + ellipsis : data;
					},
					targets: 3,
				},
		            { width: 100, targets: result.length - 1 },
		            { orderable: false, targets: -1 }
		        ]
			});
			
		   
			$('div#initialloader').delay(300).fadeOut('slow');
			
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//console.log("error in ajax");
		}
	});
	
	
}



//**************************************************viewConfig page buttons**********************************************

function pageRendering(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'blacklist/pageRendering',
		type: 'POST',
		dataType: "json",
		success: function(data){
			
			var elem='<h1>'+data.pageTitle+'<h1>';		
			$("#pageHeader").append(elem);
			var button=data.buttonList;

			var date=data.inputTypeDateList;
				
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){  
								$("#vipListTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#vipListTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");
						
					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#vipListTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+date[i].id+">"+date[i].title+"</label>"+
										"<select id="+date[i].id+"  class='form-control'>"+
										"<option value='' selected>"+date[i].title+
										"</option>"+
										"</select>"+
										"</div>"+
								"</div>");	
					}
					
				}
				
			//$('#vipListTableDiv div:last').after("<p id='errorMsg' style='padding:5px;color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 57px;' class='left'></p>")	
				  
			$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")	  
			$("#vipListTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
			$("#vipListTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter'><span><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></span></button></div>");
			$("#vipListTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>"+$.i18n('Export')+"<img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
						
			
			//$("#vipListTableButtonDiv").append("<div class='filter_btn'><button class='btn primary botton' type='button' id='submitFilter'></button></div>");
			//$("#vipListTableButtonDiv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>Clear all filters</button></div>");
			//$("#vipListTableButtonDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportData()'>Export<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
			
			
			$('#clearFilter').attr("onclick", "filterResetVIPList('viewFilter')");
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);
			
			}
			
			
		}

	}); 
	
	//status-----------dropdown
	/*$.getJSON('./getDropdownList/CONFIG_TYPE', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interpretation)
			.appendTo('#type');
		}
	});
	$.getJSON('./getDistinctSystemParamFeatureName', function(data) {
		  for (i = 0; i < data.length; i++) {
                $('<option>').val(data[i]).text(data[i]).appendTo('#featureName');

            }

	});*/
};


$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});


function viewDetails(tag){
	$("#viewVIPListModel").openModal({
        dismissible:false
    });
	var RequestData = {
			"tag" : tag,
			"sno":tag,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username"),
			"userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType")
	} 
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./blacklist/viewTag",
		data :	JSON.stringify(RequestData),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			//console.log(data);
			setViewPopupData(data);
			$("label[class='center-align']").addClass('active');
		},
		error : function() {
			//alert("Failed");
		}
	});
}

function setViewPopupData(data){
	data.creationDate=="" || data.creationDate==null ? $("#viewCreatedDate").val('NA') : $("#viewCreatedDate").val(data.creationDate);
	data.imei=="" || data.imei==null ? $("#viewImei").val('NA') : $("#viewImei").val(data.imei);
	data.imsi=="" || data.imsi==null ? $("#viewImsi").val('NA') : $("#viewImsi").val(data.imsi); 
	data.msisdn=="" || data.msisdn==null ? $("#viewMsisdn").val('NA') : $("#viewMsisdn").val(data.msisdn); 
	
}


function updateDetails(tag){
	$("#editVIPListModel").openModal({
        dismissible:false
    });
	var RequestData = {
			"tag" : tag,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username"),
			"userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType")
	} 
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./blacklist/viewTag",
		data :	JSON.stringify(RequestData),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			//console.log(data);
			setEditPopupData(data);
			$("label[class='center-align']").addClass('active');
		},
		error : function() {
			//alert("Failed");
		}
	});
}


function setEditPopupData(data){
	$("#EditId").val(data.id);
	$("#editTag").val(data.tag);
	$("#editValue").val(data.value);
	$("#edittype").val(data.typeInterp);
	$("#editdescription").val(data.description);
	$("#editremarks").val(data.remark);
	data.modifiedBy =="" || data.modifiedBy==null ?  $("#editModifiedBy").val('NA'): $("#editModifiedBy").val(data.modifiedBy);
	data.featureName =="" || data.featureName==null ?  $("#editfeatureName").val('NA'): $("#editfeatureName").val(data.featureName);
}

function updateSystem(){
var updateRequest = {
		"id" :  parseInt($("#EditId").val()),
 		"tag" : $("#editTag").val(),
		"description": $("#editdescription").val(),
		"remark": $("#editremarks").val(),
		"featureName": $("#editfeatureName").val(),
		"value": $("#editValue").val(),
		"type" : parseInt($("#edittype").val()),
		"userId":parseInt(userId),
		"featureId":parseInt(featureId),
		"msisdn":$('#editMsisdn').val(),
		"imei":$('#editImei').val(),
		"imsi":$('#editImsi').val(),
		"userTypeId": parseInt($("body").attr("data-userTypeID")),
		"userType":$("body").attr("data-roleType"),
		"username" : $("body").attr("data-selected-username"),
		"userName" : $("body").attr("data-selected-username"),
		"roleType":$("body").attr("data-roleType"),
		
}
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
});

$.ajax({
	url : "./blacklist/update",
	data :	JSON.stringify(updateRequest),
	dataType : 'json',
	contentType : 'application/json; charset=utf-8',
	type : 'PUT',
	success : function(data) {
			//console.log("Updated data---->" +JSON.stringify(data));
			
			$("#editVIPListModel").closeModal();	
			$("#confirmedUpdatedSystem").openModal({
		        dismissible:false
		    });
			$.i18n().locale = window.parent.$('#langlist').val();
			
			$.i18n().load({
				'en' : './resources/i18n/en.json',
				'km' : './resources/i18n/km.json'
			}).done(function() {
				//$('#updateFieldMessage').text($.i18n(data.tag));
				if(data.errorCode==200){
					//alert($.i18n('System_configuration_update'));
					$('#updateFieldMessage').text('');
					$('#updateFieldMessage').text($.i18n('System_configuration_update'));
				}else if(data.errorCode==201){
					$('#updateFieldMessage').text('');
					$('#updateFieldMessage').text(data.message);
				}
			});
			
		
		
		//console.log("updateRequest---------->" +JSON.stringify(updateRequest));
		
	},
	error : function() {
		//alert("Failed");
	}
});

return false;
	
}

function confirmModel(){
$("#editVIPListModel").closeModal();
setTimeout(function(){$('#confirmedUpdatedSystem').openModal({
    dismissible:false
});},200);
}


function exportData(){
	var roleType = $("body").attr("data-roleType");
	var currentRoleType = $("body").attr("data-stolenselected-roleType");
	var table = $('#configLibraryTable').DataTable();
	var info = table.page.info(); 
	var pageNo=info.page;
	var pageSize =info.length;
	var featureName=$('#featureName').val();
	if(featureName ==""){
		featureName=null;
	}
	var filterRequest={
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"tag":$('#parametername').val(),
			"type" : parseInt($('#type').val()),
			"userId":parseInt(userId),
			"featureName" :featureName,
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username"),
			"pageNo":parseInt(pageNo),
			"pageSize":parseInt(pageSize),
			"msisdn":$('#msisdnId').val(),
			"imei":$('#imeiId').val(),
			"imsi":$('#imsiId').val(),
			"userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType"),
			"description":$('#descriptionID').val(),
			"value":$('#valueID').val(),
			
	}
	//console.log(JSON.stringify(filterRequest))
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './exportBlackListData',
		type: 'POST',
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(filterRequest),
		success: function (data, textStatus, jqXHR) {
			finalURL(data.url);

		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});

}


function filterResetVIPList(formID){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	$('#errorMsg').text('');
	VIPLISTDatatable();
}




