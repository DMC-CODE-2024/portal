		var cierRoletype =$("body").attr("data-roleType");
		var startdate=$('#startDate').val();
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="31";
		var rejectedMsg,consignmentApproved,errorMsg,havingTxnID,updateMsg,hasBeenUpdated;
		var consignmentDeleted,deleteInProgress;
		var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

$(document).ready(function(){
         sessionStorage.removeItem("session-value");
         pageRendering().then(() => setAllDropdown());
         alertFieldTable(lang);


		 });


/*
		$('.datepick').datepicker({
			dateFormat: "yy-mm-dd"
		});

*/

		$.i18n().locale = lang;

		$.i18n().load( {
			'en': './resources/i18n/en.json',
			'km': './resources/i18n/km.json'
		} ).done( function() {
			rejectedMsg=$.i18n('rejectedMsg');
			consignmentApproved=$.i18n('consignmentApproved');
			errorMsg=$.i18n('errorMsg');
			havingTxnID=$.i18n('havingTxnID');
			updateMsg=$.i18n('updateMsg');
			hasBeenUpdated=$.i18n('hasBeenUpdated');
			consignmentDeleted=$.i18n('consignmentDeleted');
			deleteInProgress=$.i18n('deleteInProgress');
		});

		var sourceType =localStorage.getItem("sourceType");
		var TagId = sessionStorage.getItem("tagId");


		//**************************************************filter table**********************************************

		function alertFieldTable(lang,source){
			var source__val;
			if(source == 'filter') {
				source__val= source;
				$("body").attr("data-session-source","filter");
			}
			else{
				source__val = $("body").attr("data-session-source");

			}
			var alertId = $("#alertId").val() == "-1" || $("#alertId").val() == undefined ? "" : $("#alertId").val();
			var feature = $("#filterfeature").val() == "-1" || $("#filterfeature").val() == undefined ? null : $("#filterfeature").val();
			var description = $("#description").val() == "" || $("#description").val() == undefined ? null : $("#description").val();
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"username" : $("body").attr("data-selected-username"),
					"alertId" : alertId,
					"feature" : feature,
					"description" : description


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
			$.ajax({
				url: 'headers?type=alertManagementHeaders&lang='+lang,
				/*	headers: {"Accept-Language": "en"},*/
				type: 'POST',
				dataType: "json",
				success: function(result){
					   var table=	$("#alertManagementLibraryTable").DataTable({
						destroy:true,
						"serverSide": true,
						orderCellsTop : true,
						"ordering" : true,
						"bPaginate" : true,
						"bFilter" : false,
						"bInfo" : true,
						"bSearchable" : true,
						"oLanguage": {
							"sUrl": langFile
						},
						"scrollX": true,
						"aaSorting": [],
					/*	columnDefs: [
							   { orderable: false, targets: -1 }
							],*/
						initComplete: function() {
					 		$('.dataTables_filter input')
	       .off().on('keyup', function(event) {
	    	   if (event.keyCode === 13) {
	    			 table.search(this.value.trim(), false, false).draw();
	    		}

	       });
		   },
						ajax: {
							url : 'alertManagementData?source='+source__val,
							type: 'POST',
							dataType: "json",
							data : function(d) {
								d.filter = JSON.stringify(filterRequest);

							},error: function (jqXHR, textStatus, errorThrown,data) {

								 window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
								 // messageWindow(jqXHR['responseJSON']['message']);
								 window.parent.$('#500ErrorModal').openModal({
								 dismissible:false
								 });

							}
						},
						"columns": result,
						fixedColumns: true,
						columnDefs: [{targets:[4], class:"columnwrap"}]
					});

					$('div#initialloader').delay(300).fadeOut('slow');

				},
				error: function (jqXHR, textStatus, errorThrown) {

				}
			});


		}

		$('.datepicker').on('mousedown',function(event){
			event.preventDefault();
		});



		function pageRendering(){
		return new Promise((resolve, reject) => {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: 'alertManagement/pageRendering',
				type: 'POST',
				dataType: "json",
				success: function(data){
					data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" )

						var elem='<h1>'+data.pageTitle+'<h1>';
				$("#pageHeader").append(elem);
				var button=data.buttonList;

				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){
								$("#alertTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#alertTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");

					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#alertTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+date[i].id+">"+date[i].title+"</label>"+
										"<select id="+date[i].id+"  class='form-control'>"+
										"<option value='-1' selected>Select</option>"+
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
				//$('#alertTableDiv div:last').after("<p id='errorMsg' style='color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 57px;padding:5px' class='left'></p>")
				var viewFilter="viewFilter";
				$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>Reset All</button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter' onclick='alertFieldTable()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportAlertData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

						$('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");
	/*		for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);

			}


						for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							$('#'+button[i].id).attr("onclick", button[i].buttonURL);
						}*/
                resolve();
				},
                		error:
                        		function (jqXHR, textStatus, errorThrown) {
                                       throw new Error('Failed to get response from [API] ');
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
			$.getJSON('./getAllAlerts', function(data) {
			for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i]).text(data[i]).appendTo('#alertId');
			}
		});

			$.getJSON('./getAlertAllfeatures', function(data) {

				for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i]).text(data[i]).appendTo('#filterfeature');
				}
			});

		}







		//**********************************************************Export Excel file************************************************************************
		function exportAlertData()
		{
			var alertId = $("#alertId").val() == "-1" || $("#alertId").val() == undefined ? "" : $("#alertId option:selected").text();
			var feature = $("#filterfeature").val() == "-1" || $("#filterfeature").val() == undefined ? null : $("#filterfeature option:selected").text();
			var description = $("#description").val() == "" || $("#description").val() == undefined ? null : $("#description").val();


			var roleType = $("body").attr("data-roleType");
			var currentRoleType = $("body").attr("data-stolenselected-roleType");
			var table = $('#alertManagementLibraryTable').DataTable();
			var info = table.page.info();
			var pageNo=info.page;
			var pageSize =info.length;

			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"pageNo":parseInt(pageNo),
					"pageSize":parseInt(pageSize),
					"userId" : parseInt($("body").attr("data-userID")),
					"alertId" : alertId,
					"username" : $("body").attr("data-selected-username"),
					"feature" : feature,
					"description" : description


			}
			//////console.log(JSON.stringify(filterRequest))
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: './exportAlertData?source=ViewExport',
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


		function alertViewByID(id){

			var request = {
				"dataId" :  parseInt(id),
				"featureId":parseInt(featureId),
				"userId" :  parseInt($("body").attr("data-userID")),
			   "userType":  $("body").attr("data-roleType"),
			 "userTypeId" : parseInt($("body").attr("data-userTypeID")),
			   "username" : $("body").attr("data-selected-username"),
			}

			//////console.log("request--------->" +JSON.stringify(request));
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
					url: './alertViewByID',
					type: 'POST',
					data : JSON.stringify(request),
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					success: function (data, textStatus, jqXHR) {
							var result = data.data
							$("#editAlertModal").openModal({
						        dismissible:false
						    });
							AlertEditPopupData(result);
							//////console.log(result)
					},
					error: function (jqXHR, textStatus, errorThrown) {
						//////console.log("error in ajax")
					}
				});
			}

		function AlertEditPopupData(result){
			$("#editAlertId").val(result.alertId);
			$("#editfeature").val(result.feature);
			$("#editdescription").val(result.description);
			$("#editId").val(result.id);

			$("label[for='editAlertId']").addClass('active');
			$("label[for='editfeature']").addClass('active');
			$("label[for='editdescription']").addClass('active');

		}


		/*---------------------------------- Update Field-------------------------------------*/


		function updatedAlert(){

			var request ={
					 "id" : parseInt($("#editId").val()),
					 "alertId":  $('#editAlertId').val(),
					 "description": $('#editdescription').val(),
					 "featureId": parseInt(featureId),
					 "userId" : parseInt($("body").attr("data-userID")),
					 "userType":$("body").attr("data-roleType"),
					 "userTypeId": parseInt($("body").attr("data-userTypeID")),
					 "username" : $("body").attr("data-selected-username"),

			}

			//////console.log("request--->" +JSON.stringify(request))
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: './updateAlert',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {

				//console.log("Updated data---->" +data)
				/*	$("#editAlertModal").closeModal();
					$("#updateAlertSuccess").openModal({
				        dismissible:false
				    });*/
	                 setTimeout(function() {location.reload();}, 100);
                     window.parent.alertify.success("Alert ID updated successfully",4);
				},
				error: function (jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});

			return false
		}

		function Resetfilter(formID){
			$('#'+formID).trigger('reset');
			$("label").removeClass('active');
			$('#errorMsg').text('');
			alertFieldTable(lang)


		}


		function saveIPLog() {
		var obj = {
		username : $("body").attr("data-selected-username"),
		password : "",
		captcha : ""
		}

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		if(sessionStorage.getItem("isSessionActive") == "Y"){
		$.ajaxSetup({
		headers : {
		'X-CSRF-TOKEN' : token
		}
		});

		$.ajax({
		type : 'POST',
		url : contextpath + '/ipLogInfo',
		contentType : "application/json",
		data : JSON.stringify(obj),
		success : function(data) {
		// console.log("successfully saved");

		},
		error : function(xhr, ajaxOptions, thrownError) {

		}
		});
		}

		sessionStorage.removeItem("isSessionActive");
		}



	function viewDetailBy(id){
			var request = {
				"dataId" :  parseInt(id),
				"featureId":parseInt(featureId),
				"userId" :  parseInt($("body").attr("data-userID")),
			   "userType":  $("body").attr("data-roleType"),
			 "userTypeId" : parseInt($("body").attr("data-userTypeID")),
			   "username" : $("body").attr("data-selected-username"),
			}

			//////console.log("request--------->" +JSON.stringify(request));
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
					url: './alertViewByID',
					type: 'POST',
					data : JSON.stringify(request),
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					success: function (data, textStatus, jqXHR) {
							var result = data.data
							$("#viewAlertModal").openModal({dismissible:false});

							view(result);
							//////console.log(result)
					},
					error: function (jqXHR, textStatus, errorThrown) {
						//////console.log("error in ajax")
					}
				});
			}
function view(result){
			$("#viewAlertId").val(result.alertId);
			$("#viewfeature").val(result.feature);
			$("#viewdescription").val(result.description);
}