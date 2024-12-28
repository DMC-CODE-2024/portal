var featureId = 15;
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType");
var startdate=$('#startDate').val();
var endDate=$('#endDate').val();

$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	messageManagementDatatable();
	pageRendering();

});

var role = currentRoleType == null ? roleType : currentRoleType;


//**************************************************Message Detail table**********************************************

function messageManagementDatatable(){
	$('div#initialloader').fadeIn('fast');
	var Feature=  $("#feature").val() == '' || $("#feature").val() == undefined ? null : $("#feature").val();
	if(Feature=="Feature")
		{
		Feature=null;
		}

	var filterRequest={
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"tag":$('#parametername').val(),
			"channel" : parseInt($('#channel').val()),
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
			"username" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType"),
			"featureName" : Feature,
			"description":$('#descriptionID').val(),
			"value":$('#valueID').val(),
			"subject":$('#subjectID').val()
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'headers?type=adminSystemMessage',
		type: 'POST',
		dataType: "json",
		success: function(result){
			/*////console.log("Url-------" +url+"--------"+ "dataUrl-------" +dataUrl);*/
			var table=	$("#messageLibraryTable").removeAttr('width').DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : true,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"bSearchable" : true,
				"scrollX": true,
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
					url : 'adminMessageData',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(filterRequest);
						//////console.log(JSON.stringify(filterRequest));
					}

				},
				"columns": result,
				fixedColumns: true,
                columnDefs: [{targets:[2,3,4], class:"columnwrap"}]
			});
			$('div#initialloader').delay(300).fadeOut('slow');

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax");
		}
	});
}



//**************************************************MessageManagement page buttons**********************************************

function pageRendering(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'messageManagement/pageRendering',
		type: 'POST',
		dataType: "json",
		success: function(data){
		/*	var elem='<p class="PageHeading">'+data.pageTitle+'</p>';
			$("#pageHeader").append(elem);
			var button=data.buttonList;

			var date=data.inputTypeDateList;
			for(i=0; i<date.length; i++){
				if(date[i].type === "date"){
					$("#messageTableDiv").append("<div class='input-field'>"+
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

					$("#messageTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength="+date[i].className+" /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
				}
				else if(date[i].type === "select"){

						var dropdownDiv=
							$("#messageTableDiv").append("<div class='selectDropdwn'>"+

									"<div class='select-wrapper select2  initialized'>"+
									"<span class='caret'>"+"</span>"+
									"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

									"<select id="+date[i].id+" class='select2 initialized'>"+
									"<option>"+date[i].title+
									"</option>"+
									"</select>"+
									"</div>"+
							"</div>");

					}

			}
			*/
			/*// dynamic dropdown portion
			var dropdown=data.dropdownList;
			for(i=0; i<dropdown.length; i++){
				var dropdownDiv=
					$("#messageTableDiv").append("<div class='col s6 m2 l2 selectDropdwn'>"+
							"<div class='select-wrapper select2 form-control boxBorder boxHeight initialized'>"+
							"<span class='caret'>"+"</span>"+
							"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

							"<select id="+dropdown[i].id+" class='select2 form-control boxBorder boxHeight initialized'>"+
							"<option value='' selected>"+dropdown[i].title+
							"</option>"+
							"</select>"+
							"</div>"+
					"</div>");
			}


			$("#messageTableDiv").append("<div class='filter_btn'><button class='btn primary botton' type='button' id='submitFilter'></button></div>");
			$("#messageTableDiv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>Clear all filters</button></div>");
			$("#messageTableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportData()'>Export<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
			*/

			var elem='<h1>'+data.pageTitle+'<h1>';
				$("#pageHeader").append(elem);
				var button=data.buttonList;

				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){
								$("#messageTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#messageTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");

					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#messageTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+date[i].id+">"+date[i].title+"</label>"+
										"<select id="+date[i].id+"  class='form-control'>"+
										"<option value='' selected>Select</option>"+
										"</select>"+
										"</div>"+
								"</div>");
					}

					// dynamic dropdown portion



				}
				/*var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#messageTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+dropdown[i].id+">"+dropdown[i].title+"</label>"+
										"<select id="+dropdown[i].id+"  class='form-control'>"+
										"<option value='null' selected>"+dropdown[i].title+
										"</option>"+
										"</select>"+
										"</div>"+
								"</div>");
					}*/

				var viewFilter="viewFilter";
				$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")
                			//$('#messageTableDiv div:last').after("<p id='errorMsg' style='color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 57px;' class='left'></p>")
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter'><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>"+$.i18n('Export')+"<img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

			$('#clearFilter').attr("onclick", "filterResetMessageManageement('viewFilter')");
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);

			}

			$('.datepicker').datepicker({
				dateFormat: "yy-mm-dd"
				});
		}

	});
	setAllDropdown();
};

function setAllDropdown(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	//status-----------dropdown
	$.getJSON('./getDropdownList/CHANNEL', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interpretation)
			.appendTo('#channel');
		}
	});

	$.getJSON('./getDistinctFeatureNameList', function(data) {
		for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i]).text(data[i]).appendTo('#feature');
		}
	});
}


$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});



function viewDetails(tag){
	$("#viewMessageModel").openModal({
        dismissible:false
    });
	var RequestData = {
			"tag" : tag,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),

	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./message/viewTag",
		data :	JSON.stringify(RequestData),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			//////console.log(data);
			setViewPopupData(data);
		},
		error : function() {
			//alert("Failed");
		}
	});
}

function setViewPopupData(data){
	data.tag=="" || data.tag==null ? $("#viewTag").val('NA') : $("#viewTag").val(data.tag);
	data.value=="" || data.value==null ? $("#viewValue").val('NA') : $("#viewValue").val(data.value);
	data.description=="" || data.description==null ? $("#description").val('NA') : $("#description").val(data.description);
	data.channelInterp=="" || data.channelInterp==null ? $("#viewChannel").val('NA') : $('#viewChannel').val(data.channelInterp);
	data.featureName=="" || data.featureName==null ? $("#viewFeature").val('NA') : $('#viewFeature').val(data.featureName);
	data.subject=="" || data.subject==null ? $("#viewSubject").val('NA') : $('#viewSubject').val(data.subject);
	data.modifiedBy ==undefined || data.modifiedBy==null ?  $("#viewMessageModifiedBy").val('NA'): $("#viewMessageModifiedBy").val(data.modifiedBy);
	//$("label[class='center-align']").addClass('active');
	$("label[for='viewChannel']").addClass('active');
	$("label[for='viewFeature']").addClass('active');
	$("label[for='viewValue']").addClass('active');
	$("label[for='description']").addClass('active');
	$("label[for='viewModifiedBy']").addClass('active');
	$("label[for='viewSubject']").addClass('active');
}

function updateDetails(tag){
	$("#editMessageModel").openModal({
        dismissible:false
    });

	var RequestData = {
			"tag" : tag,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
			"username" : $("body").attr("data-selected-username")
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./message/viewTag",
		data :	JSON.stringify(RequestData),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			//////console.log(data);
			setEditData(data);
		},
		error : function() {
			//alert("Failed");
		}
	});
}

function setEditData(data){
	$("#Edittag").val(data.tag);
	$("#EditId").val(data.id);
	$("#editValue").val(data.value);
	$("#editdescription").val(data.description);
	$("#editChannel").val(data.channelInterp);
	data.featureName=="" || data.featureName==null ? $("#editFeature").val('NA') : $('#editFeature').val(data.featureName);
	data.subject=="" || data.subject==null ? $("#editSubject").val('NA') : $('#editSubject').val(data.subject);
	data.modifiedBy =="" || data.modifiedBy==null ?  $("#editMessageModifiedBy").val('NA'): $("#editMessageModifiedBy").val(data.modifiedBy);
	$("label[for='editChannel']").addClass('active');
	$("label[for='editFeature']").addClass('active');
	$("label[for='editValue']").addClass('active');
	$("label[for='editdescription']").addClass('active');
	$("label[for='editModifiedBy']").addClass('active');
	$("label[for='editSubject']").addClass('active');
	//$("label[class='center-align']").addClass('active');
}


function updateMessage(){
	 var updateRequest = {
			 "id" :  parseInt($("#EditId").val()),
		 	 "tag" : $("#Edittag").val(),
			 "value" : $("#editValue").val(),
			 "description" : $("#editdescription").val(),
			 "channel" : parseInt($("#editChannel").val()),
			 "userId":parseInt(userId),
			 "featureId":parseInt(featureId),
			 "userTypeId": parseInt($("body").attr("data-userTypeID")),
			 "userType":$("body").attr("data-roleType"),
			 "userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username"),
			"subject" : $("#editSubject").val()
	}
	 var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
	 $.ajax({
			url : "./message/update",
			data :	JSON.stringify(updateRequest),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'PUT',
			success : function(data) {
				//////console.log("updateRequest---------->" +JSON.stringify(updateRequest));
				confirmModel()
			},
			error : function() {
				//alert("Failed");
			}
		});
	 return false;
}


function confirmModel(){
	$("#editMessageModel").closeModal();
	setTimeout(function(){$('#confirmedUpdatedMessage').openModal({
        dismissible:false
    });},200);
}

function exportData(){
	var roleType = $("body").attr("data-roleType");
	var currentRoleType = $("body").attr("data-stolenselected-roleType");
	var table = $('#messageLibraryTable').DataTable();
	var info = table.page.info();
	var pageNo=info.page;
	var pageSize =info.length;
	var Feature=  $("#feature").val() == '' || $("#feature").val() == undefined ? null : $("#feature").val();
	if(Feature=="Feature")
	{
	Feature=null;
	}

	var filterRequest={
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"tag":$('#parametername').val(),
			"channel" : parseInt($('#channel').val()),
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
			"featureName" : Feature,
			"pageNo":parseInt(pageNo),
			"pageSize":parseInt(pageSize),
			"description":$('#descriptionID').val(),
			"value":$('#valueID').val(),
			"subject":$('#subjectID').val()

	}
	//////console.log(JSON.stringify(filterRequest))
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './exportMessageConfigData',
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


function filterResetMessageManageement(formID){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	$('#errorMsg').text('');
	messageManagementDatatable();
}


