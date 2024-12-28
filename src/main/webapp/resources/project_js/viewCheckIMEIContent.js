var featureId = 68;
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
var startdate=$('#startDate').val(); 
var endDate=$('#endDate').val();
var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

$(document).ready(function(){
 checkIMEIContentDatatable();
 pageRendering().then(() => filterDropdown());
});

var role = currentRoleType == null ? roleType : currentRoleType;


//**************************************************Config Detail table**********************************************

function checkIMEIContentDatatable(){
	$('div#initialloader').fadeIn('fast');
	var ellipsis = "...";
	var featureName=$('#featureName').val();
	if(featureName ==""){
		featureName=null;
	}
	var filterRequest={
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"featureName" :featureName,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username"),
			"description":$('#descriptionID').val(),
			"label":$('#label').val(),
			"englishName":$('#english_name').val(),
			"khmerName":$('#khmer_name').val(),
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
		url: 'headers?type=checkIMEIContent',
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
				"scrollX": true,
				initComplete: function() {
			 		$('.dataTables_filter input')
   .off().on('keyup', function(event) {
	   if (event.keyCode === 13) {
			 table.search(this.value.trim(), false, false).draw();
		}
      
   });
   },
				ajax: {
					url : 'checkimeiContentData',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(filterRequest); 
						//console.log(JSON.stringify(filterRequest));
					}

				},
				"columns": result,
				fixedColumns: true,
				columnDefs: [{targets:[3,5], class:"columnwrap"}]
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

return new Promise((resolve, reject) => {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'checkimeicontent/pageRendering',
		type: 'POST',
		dataType: "json",
		success: function(data){
			
			var elem='<h1>'+data.pageTitle+'<h1>';		
			$("#pageHeader").append(elem);
			var button=data.buttonList;

			var date=data.inputTypeDateList;
			
			
				
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){  
								$("#configTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#configTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");
						
					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#configTableDiv").append(
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
				
			//$('#configTableDiv div:last').after("<p id='errorMsg' style='padding:5px;color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 57px;' class='left'></p>")	
				  
			$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")	  
			$("#configTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>Reset All</button></div>");
			$("#configTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter' onclick='checkIMEIContentDatatable()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
			$("#configTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
						
			
			//$("#configTableButtonDiv").append("<div class='filter_btn'><button class='btn primary botton' type='button' id='submitFilter'></button></div>");
			//$("#configTableButtonDiv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>Clear all filters</button></div>");
			//$("#configTableButtonDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportData()'>Export<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
			
			
			$('#clearFilter').attr("onclick", "filterResetCheckIMEIContent('viewFilter')");
			/*for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);
			
			}*/
			
			resolve();
		}

	}); 
		});
}
function filterDropdown(){
	//status-----------dropdown
	/*$.getJSON('./getDropdownList/CONFIG_TYPE', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interpretation)
			.appendTo('#type');
		}
	});*/
	/*$.getJSON('./getDistinctTypeName', function(data) {
		  for (i = 0; i < data.length; i++) {
                $('<option>').val(data[i]).text(data[i]).appendTo('#type');

            }

	});*/
	$.getJSON('./getDistinctIMEIContentFeatureName', function(data) {

		  for (i = 0; i < data.length; i++) {
                $('<option>').val(data[i]).text(data[i]).appendTo('#featureName');

            }

	});
	}


$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});


function viewDetails(tag){
	$("#viewAdminSystemModel").openModal({
        dismissible:false
    });
	var RequestData = {
			"tag" : tag,
			"id" : tag,
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
		url : "./imeiContent/viewTag",
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
	data.tag=="" || data.tag==null ? $("#viewTag").val('NA') : $("#viewTag").val(data.tag);
	data.label=="" || data.label==null ? $("#viewlabel").val('NA') : $("#viewlabel").val(data.label);
	data.englishName=="" || data.englishName==null ? $("#viewenglish_name").val('NA') : $("#viewenglish_name").val(data.englishName);
	data.khmerName=="" || data.khmerName==null ? $("#viewkhmer_name").val('NA') : $("#viewkhmer_name").val(data.khmerName); 
	data.remarks=="" || data.remarks==null ? $("#remarks").val('NA') : $("#remarks").val(data.remarks); 
	data.createdOn =="" || data.createdOn==null ?  $("#viewModifiedBy").val('NA'): $("#viewModifiedBy").val(data.createdOn);
	data.featureName =="" || data.featureName==null ?  $("#viewfeatureName").val('NA'): $("#viewfeatureName").val(data.featureName);
	
}


function updateDetails(tag){
	$("#editCheckIMEIContent").openModal({
        dismissible:false
    });
	var RequestData = {
			"tag" : tag,
			"id" : tag,
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
		url : "./imeiContent/viewTag",
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
	$("#editenglish_name").val(data.englishName);
	$("#editlabel").val(data.label);
	$("#editkhmer_name").val(data.khmerName);
	$("#editremarks").val(data.remarks);
	data.createdOn =="" || data.createdOn==null ?  $("#editModifiedBy").val('NA'): $("#editModifiedBy").val(data.createdOn);
	data.featureName =="" || data.featureName==null ?  $("#editfeatureName").val('NA'): $("#editfeatureName").val(data.featureName);
}

function updateSystem(){
var updateRequest = {
		"id" :  parseInt($("#EditId").val()),
 		"tag" : $("#editTag").val(),
		"label": $("#editlabel").val(),
		"remarks": $("#editremarks").val(),
		"featureName": $("#editfeatureName").val(),
		"englishName": $("#editenglish_name").val(),
		"khmerName" : $("#editkhmer_name").val(),
		"userId":parseInt(userId),
		"featureId":parseInt(featureId),
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
	url : "./imeiContent/update",
	data :	JSON.stringify(updateRequest),
	dataType : 'json',
	contentType : 'application/json; charset=utf-8',
	type : 'PUT',
	success : function(data) {
			//console.log("Updated data---->" +JSON.stringify(data));
			
		/*	$("#editCheckIMEIContent").closeModal();
			$("#confirmedUpdatedSystem").openModal({
		        dismissible:false
		    });*/
			$.i18n().locale = window.parent.$('#langlist').val();
			
			$.i18n().load({
				'en' : './resources/i18n/en.json',
				'km' : './resources/i18n/km.json'
			}).done(function() {
				//$('#updateFieldMessage').text($.i18n(data.tag));
				/*$('#updateFieldMessage').text('');
                $('#updateFieldMessage').text(data.message);*/
                	 setTimeout(function() {location.reload();}, 100);
                                     window.parent.alertify.success(data.message,4);
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
$("#editCheckIMEIContent").closeModal();
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
			"userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType"),
			"label":$('#label').val(),
			"englishName":$('#english_name').val(),
			"khmerName":$('#khmer_name').val(),
			
	}
	//console.log(JSON.stringify(filterRequest))
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './exportCheckIMEIContentData',
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


function filterResetCheckIMEIContent(formID){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	$('#errorMsg').text('');
	checkIMEIContentDatatable();
}




