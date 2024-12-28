var featureId = 13;
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
var startdate=$('#startDate').val(); 
var endDate=$('#endDate').val();

$(document).ready(function(){
	configManagementDatatable();
	pageRendering();
	
});

var role = currentRoleType == null ? roleType : currentRoleType;


//**************************************************Config Detail table**********************************************

function configManagementDatatable(){
	
	var filterRequest={
			"tag":$('#parametername').val(),
			"status":parseInt($('#status').val()),
			"type": parseInt($("#type").val()),
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username")
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'headers?type=adminPolicyManagement',
		type: 'POST',
		dataType: "json",
		success: function(result){
			/*////console.log("Url-------" +url+"--------"+ "dataUrl-------" +dataUrl);*/
			var table=	$("#configLibraryTable").removeAttr('width').DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : false,
				"bPaginate" : true,
				"bFilter" : true,
				"bInfo" : true,
				"bSearchable" : true,
				"oLanguage": {
					"sEmptyTable": "No records found in the system"
			    },
				initComplete: function() {
			 		$('.dataTables_filter input')
   .off().on('keyup', function(event) {
	   if (event.keyCode === 13) {
			 table.search(this.value.trim(), false, false).draw();
		}
      
   });
   },
				ajax: {
					url : 'policyConfigData',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(filterRequest); 
						//////console.log(JSON.stringify(filterRequest));
					}

				},
				"columns": result,
				fixedColumns: true,
				columnDefs: [
		            { width: 100, targets: result.length - 1 },
		            { width: 125, targets: 0 },
		            { width: 125, targets: 1 }
		        ]
			});
			$('div#initialloader').delay(300).fadeOut('slow');
			
			
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax");
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
		url: 'policyConfig/pageRendering',
		type: 'POST',
		dataType: "json",
		success: function(data){
			var elem='<p class="PageHeading">'+data.pageTitle+'</p>';		
			$("#pageHeader").append(elem);
			var button=data.buttonList;

			var date=data.inputTypeDateList;
			
			for(i=0; i<date.length; i++){
				if(date[i].type === "date"){
					$("#configTableDiv").append("<div class='col s6 m2 l2 responsiveDiv'>"+
							"<div id='enddatepicker' class='input-group date'>"+
							"<label for='TotalPrice'>"+date[i].title
							+"</label>"+"<input class='form-control datepicker' type='text' id="+date[i].id+" autocomplete='off'>"+
							"<span	class='input-group-addon' style='color: #ff4081'>"+
							"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");
					$( "#"+date[i].id ).datepicker({
						dateFormat: "yy-mm-dd",
						 maxDate: new Date()
			        });	
				}
					else if(date[i].type === "text"){
						$("#configTableDiv").append("<div class='input-field col s6 m2' style='margin-top: 22px;'><input type="+date[i].type+" id="+date[i].id+"><label for='parametername' class='center-align'>"+date[i].title+"</label></div>");
						
					}
				 
				} 
			
			// dynamic dropdown portion
			var dropdown=data.dropdownList;
			for(i=0; i<dropdown.length; i++){
				var dropdownDiv=
					$("#configTableDiv").append("<div class='col s6 m2 l2 selectDropdwn'>"+
					
							"<div class='select-wrapper select2 form-control boxBorder boxHeight initialized'>"+
							"<span class='caret'>"+"</span>"+
							"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

							"<select id="+dropdown[i].id+" class='select2 form-control boxBorder boxHeight initialized'>"+
							"<option value='null' selected>"+dropdown[i].title+
							"</option>"+
							"</select>"+
							"</div>"+
					"</div>");
			}

			
			
			$("#configTableDiv").append("<div class='col s12 m2 l2'><button class='btn primary botton' type='button' id='submitFilter'></button></div>");
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);
			
			}

		}

	}); 
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	//Request Type status-----------dropdown
	$.getJSON('./getDropdownList/CONFIG_TYPE', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#type');
		}
	});
	
	$.getJSON('./getDropdownList/IS_ACTIVE', function(data) {
		for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#status');
		}
		});
	
	$.getJSON('./getDropdownList/Period', function(data) {
		for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].interp).text(data[i].interp)
		.appendTo('#editPeriod');
	 }
	});
	
	
}


$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});



function viewDetails(tag){
	$("#viewPolicyConfigModel").openModal({
        dismissible:false
    });
	var RequestData = {
			"tag" : tag,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username")
	} 
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./policy/viewTag",
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
	data.period=="" || data.period==null ? $("#viewPeriod").val('NA') : $("#viewPeriod").val(data.period);
	data.statusInterp=="" || data.statusInterp==null ? $("#viewstatus").val('NA') : $("#viewstatus").val(data.statusInterp);
	data.description=="" || data.description==null ? $("#description").val('NA') : $("#description").val(data.description);
	data.value=="" || data.value==null ? $("#viewValue").val('NA') : $("#viewValue").val(data.value);
	$("#viewTag").val(data.tag);
	$("#remarks").val(data.remark);
	$("#viewpolicyOrder").val(data.policyOrder);
}

function updateDetails(tag,status){
	$("#editPolicyConfigModel").openModal({
        dismissible:false
    });
	
	$("#EditStatusValue").val(status)
	
	var RequestData = {
			"tag" : tag,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName" : $("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType"),
			"username" : $("body").attr("data-selected-username")
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./policy/viewTag",
		data :	JSON.stringify(RequestData),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			//////console.log(data);
			setEditPopupData(data);
		},
		error : function() {
			//alert("Failed");
		}
	});
}

function setEditPopupData(data){
	$.getJSON('./getDropdownList/IS_ACTIVE', function(data) {
		$('#editstatus').empty();
		for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#editstatus');
		}
		});
	$("#editTag").val(data.tag);
	$("#EditId").val(data.id);
	$("#editValue").val(data.value);
	$("#editPeriod").val(data.period);
	$("#editdescription").val(data.description);
	$("#editstatus").val(data.status);
	$("#editremarks").val(data.remark);
	$("#editpolicyOrder").val(data.policyOrder);
	$("#EditStatusValue").val(data.status)
	
}


function updatePolicy(){
	
	 var updateRequest = {
			 "id" : parseInt($("#EditId").val()),
			 "tag" : $("#editTag").val(),
			 "value" : $("#editValue").val(),
			 "period" :   $("#editPeriod option:selected").text(),
			 "description" : $("#editdescription").val(),
			 "status" : parseInt($("#editstatus").val()),
			 "remark" : $("#editremarks").val(),
			 "policyOrder": $("#editviewpolicyOrder").val(),
			 "userId":parseInt(userId),
			 "featureId":parseInt(featureId),
			 "userTypeId": parseInt($("body").attr("data-userTypeID")),
			 "userType":$("body").attr("data-roleType"),
			 "userName" : $("body").attr("data-selected-username"),
				"roleType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username")
	}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
	//////console.log("updateRequest-->" +updateRequest);
	$.ajax({
		url : "./policy/update",
		data :	JSON.stringify(updateRequest),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'PUT',
		success : function(data) {
			//////console.log(data);
			confirmModel()
			/* window.location = "./policyManagement";*/
		},
		error : function() {
			//alert("Failed");
		}
	});
	
	return false;
}

function confirmModel(){
	$("#editPolicyConfigModel").closeModal();
	setTimeout(function(){$('#confirmedUpdatedPolicy').openModal({
        dismissible:false
    });},200);
}
