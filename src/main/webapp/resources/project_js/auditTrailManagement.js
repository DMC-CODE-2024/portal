		var cierRoletype =$("body").attr("data-roleType");
		var startdate=$('#startDate').val();
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="77";
		var rejectedMsg,consignmentApproved,errorMsg,havingTxnID,updateMsg,hasBeenUpdated;
		var consignmentDeleted,deleteInProgress;
		var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';


$(document).ready(function(){
 auditManagementDatatable();
 pageRendering().then(() => setAllDropdown());
});

/*
var role = currentRoleType == null ? roleType : currentRoleType;
*/


//**************************************************Audit Management table**********************************************

function auditManagementDatatable(){
	$('div#initialloader').fadeIn('fast');
	var userType = $('#userType').val() == 'null' ? null : $("#userType").val();
	var featureName = $('#feature').val() == 'null' ? null : $("#feature").val();
	var moduleName = $('#Module').val() == 'null' ? null : $("#Module").val();
	var status = $('#status').val() == 'null' ? null : $("#status").val();
	var subFeature = $('#subfeatureFilter').val() == 'null' ? null : $("#subfeatureFilter").val();
	var roleType = $('#roleType').val() == 'null' ? null : $("#roleType").val();
	var actionName = $("#action").val() == '' ? null : $("#action").val();
	var filterRequest={

			"userId":parseInt(userId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType": userType,
			"featureId": parseInt(featureId),
			"startDate" : $("#startDate").val(),
			"endDate" : $("#endDate").val(),
			"txnId" : $("#transactionID").val(),
			"featureName" : featureName,
			"moduleName" : moduleName,
			"moduleStatus" : status,
			"userName" : $("#userName").val(),
			"roleType" : roleType,
			"actionName": actionName




	}
	if(lang=='km'){
		var langFile="./resources/i18n/khmer_datatable.json";
	}else if(lang=='en'){
		var langFile='./resources/i18n/english_datatable.json';
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});

	//////console.log("filterRequest-->" +JSON.stringify(filterRequest));
	$.ajax({
		url: 'headers?type=moduleAuditTrailHeader',
		type: 'POST',
		dataType: "json",
		success: function(result){
			var table=	$("#auditLibraryTable").removeAttr('width').DataTable({
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
					url : 'auditTrailManagementData',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(filterRequest);
					//	////console.log(JSON.stringify(filterRequest));
					}

				},
				"columns": result,
				fixedColumns: true,
				columnDefs: [{targets:[0,1,2,3,5,9], class:"columnwrap"}]
				/*columnDefs: [
		            { width: 50, targets: result.length - 1 },
		            { width: 125, targets: 0 },
		            { width: 150, targets: 1 },
		            { orderable: false, targets: -1 }
		        ]*/
			});
			$('div#initialloader').delay(300).fadeOut('slow');
/*$('#auditLibraryTable tbody').on('click', '#viewById' , function(){
        var row_tr = $(this).closest('tr');
        var row_data = table.row( row_tr ).data() ;
         console.log(row_data);
});*/

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax");
		}
	});
}



//**************************************************viewAudit page buttons**********************************************

function pageRendering(){
return new Promise((resolve, reject) => {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});

	$.ajax({
		url: 'audit/trail/pageRendering',
		type: 'POST',
		dataType: "json",
		success: function(data){
			data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );
			var elem='<h1>'+data.pageTitle+'<h1>';
				$("#pageHeader").append(elem);
				var button=data.buttonList;

				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){
								$("#auditTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#auditTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");

					}

					// dynamic dropdown portion
				else if(date[i].type === "select"){
					var dropdownDiv=
							$("#auditTableDiv").append(
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

				//$('#auditTableDiv div:last').after("<p id='errorMsg' style='padding:5px;color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 57px;' class='left'></p>")

				var viewFilter="viewFilter";
				$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>Reset All</button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter' onclick='auditManagementDatatable()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportAuditData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

				$('#clearFilter').attr("onclick", "filterResetAudit('viewFilter')");
				/*for(i=0; i<button.length; i++){
					$('#'+button[i].id).text(button[i].buttonTitle);
					$('#'+button[i].id).attr("onclick", button[i].buttonURL);
				}*/
				resolve();
		}
	});
});
}


function setAllDropdown(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});

	$.getJSON('./getDistinctModuleFeatureName', function(data) {

		  for (i = 0; i < data.length; i++) {
                $('<option>').val(data[i]).text(data[i]).appendTo('#feature');

            }

	});
	$.getJSON('./getDistinctModulesName', function(data) {

		  for (i = 0; i < data.length; i++) {
                $('<option>').val(data[i]).text(data[i]).appendTo('#Module');

            }

	});
	$.getJSON('./getDistinctModuleStatus', function(data) {

		  for (i = 0; i < data.length; i++) {
                $('<option>').val(data[i]).text(data[i]).appendTo('#status');

            }

	});
		$.getJSON('./getDistinctActionName', function(data) {

    		  for (i = 0; i < data.length; i++) {
                    $('<option>').val(data[i]).text(data[i]).appendTo('#action');

                }

    	});
	/*$.getJSON('./getAuditAllfeatures', function(data) {
		for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i]).text(data[i]).appendTo('#feature');
		}
	});*/


}

$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});


function view(id){
/*	$("#viewModal").openModal({
        dismissible:false
    });*/
	 var id = parseInt(id);
	 var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});



	$.ajax({
		url : './audit-trail/'+id,
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		success : function(data) {
		setViewPopupData(data);
		$("#viewModal").openModal({
        					        dismissible:false
        					    });

			},
		error : function() {
			//alert("Failed");
		}
	});
}


function setViewPopupData(data){
            $('#moduleName').val(data.moduleName);
            $("#featureName").val(data.featureName);
            $("#executionTime").val(data.executionTime);
            $("#count").val(data.count);
            $("#count2").val(data.count2);
            $("#failureCount").val(data.failureCount);
            $("#modal-status").val(data.status);
            $("#info").val(data.info);
            $("#viewaction").val(data.action);

	/*data.userId=="" || data.userId==null ? $("#viewUserId").val('NA') : $("#viewUserId").val(data.userId);
	data.txnId=="" || data.txnId==null ? $("#viewTxnId").val('NA') : $("#viewTxnId").val(data.txnId);
	data.userName=="" || data.userName==null ? $("#viewUserName").val('NA') : $("#viewUserName").val(data.userName);
	data.userType=="" || data.userType==null ? $("#viewUserType").val('NA') : $("#viewUserType").val(data.userType);
	data.roleType=="" || data.roleType==null ? $("#viewRoleType").val('NA') : $("#viewRoleType").val(data.roleType);
	data.featureName=="" || data.featureName==null ? $("#viewFeature").val('NA') : $("#viewFeature").val(data.featureName);
	data.subFeature=="" || data.subFeature==null ? $("#viewSubFeature").val('NA') : $("#viewSubFeature").val(data.subFeature);
	data.publicIp=="" || data.publicIp==null ? $("#viewPublicIp").val('NA') : $("#viewPublicIp").val(data.publicIp);
	data.browser=="" || data.browser==null ? $("#viewBrowser").val('NA') : $("#viewBrowser").val(data.browser);
*/



/*function exportAuditData(){
	var table = $('#auditLibraryTable').DataTable();
	var info = table.page.info();
	var pageNo=info.page;
	var pageSize =info.length;
	window.location.href="./exportAuditData?pageSize="+pageSize+"&pageNo="+pageNo;

}*/
}


function exportAuditData()
{
	var table = $('#auditLibraryTable').DataTable();
	var info = table.page.info();
	var pageNo=info.page;
	var pageSize =info.length;
	var userType = $('#userType').val() == 'null' ? null : $("#userType").val();
	var featureName = $('#feature').val() == 'null' ? null : $("#feature").val();
	var subFeature = $('#subfeatureFilter').val() == 'null' ? null : $("#subfeatureFilter").val();
	var roleType = $('#roleType').val() == 'null' ? null : $("#roleType").val();
	var actionName = $("#action").val() == '' ? null : $("#action").val();
	var filterRequest={

			"userId":parseInt(userId),
			//"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType": userType,
			"featureId": parseInt(featureId),
			"startDate" : $("#startDate").val(),
			"endDate" : $("#endDate").val(),
			"txnId" : $("#transactionID").val(),
			"featureName" : featureName,
			"subFeatureName" : subFeature,
			"userName" : $("#userName").val(),
			"roleType" : roleType,
			"pageNo":parseInt(pageNo),
			"pageSize":parseInt(pageSize),
			"publicIp" : $("#publicIpFilter").val(),
			"browser" : $("#browserFilter").val(),
			"moduleName" : $('#Module').val(),
			"moduleStatus" : $('#status').val(),
			"actionName": actionName


	}


	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});

	$.ajax({
		url: './exportAuditTrailData',
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

function filterResetAudit(formID){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	$('#errorMsg').text('');
	auditManagementDatatable(lang,null);
}