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

       $(document).ready(function(){
         alertFieldTable(lang,null);
	     pageRendering().then(() => setAllDropdown());

		 });

			sessionStorage.removeItem("session-value");
		$('.datepick').datepicker({
			dateFormat: "yy-mm-dd"
		});


		var sourceType =localStorage.getItem("sourceType");
		var TagId = sessionStorage.getItem("tagId");


		//**************************************************filter table**********************************************

		function alertFieldTable(lang,source){
			var source__val;
			if(source == 'filter' ) {
				source__val= source;
				$("body").attr("data-session-source","filter");
			}
			else{
				source__val= $("body").attr("data-session-source");
			}

			var alertId = $("#alertId").val() == "-1" || $("#alertId").val() == undefined ? "" : $("#alertId option:selected").text();
			var description = $("#description").val() == "" || $("#description").val() == undefined ? null : $("#description").val();
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"alertId" : alertId,
					"username" : $("body").attr("data-selected-username"),
					"description" : description,
					"status" : parseInt($('#status').val()),
					"featureName": $('#filterfeature').val()

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
				url: 'headers?type=runningAlertManagementHeaders&lang='+lang,
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
						"scrollX": false,
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
							url : 'runningAlertManagementData?source='+source__val,
							type: 'POST',
							dataType: "json",
							data : function(d) {
								d.filter = JSON.stringify(filterRequest);

							},
							error: function (jqXHR, textStatus, errorThrown,data) {

								 window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
								 // messageWindow(jqXHR['responseJSON']['message']);
								 window.parent.$('#500ErrorModal').openModal({
								 dismissible:false
								 });

							}
						},

						"columns": result,
						fixedColumns: true,
						columnDefs: [{targets:[0,1,2,3], class:"columnwrap"}]
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
				url: 'runningAlertManagement/pageRendering',
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

				var viewFilter="viewFilter";
				$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")
				//$('#alertTableDiv div:last').after("<p id='errorMsg' style='color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 57px;' class='left'></p>")
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>Reset All</button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter' onclick='alertFieldTable()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportRunningAlertData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

			$('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");

/*
						for(i=0; i<button.length; i++){
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
			$.getJSON('./getAllAlerts', function(data) {
			for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].alertId).text(data[i].alertId).appendTo('#alertId');
			}
		});

			$.getJSON('./getDropdownList/ALERT_STATE', function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#status');
				}
			});

			$.getJSON('./getRunningAlertfeatures', function(data) {
			for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i]).text(data[i]).appendTo('#filterfeature');
			}
		});

		}




		//**********************************************************Export Excel file************************************************************************
		function exportRunningAlertData()
		{
			var roleType = $("body").attr("data-roleType");
			var currentRoleType = $("body").attr("data-stolenselected-roleType");
			var table = $('#alertManagementLibraryTable').DataTable();
			var info = table.page.info();
			var pageNo=info.page;
			var pageSize =info.length;

			var alertId = $("#alertId").val() == "-1" || $("#alertId").val() == undefined ? "" : $("#alertId option:selected").text();
			var description = $("#description").val() == "" || $("#description").val() == undefined ? null : $("#description").val();

			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"pageNo":parseInt(pageNo),
					"pageSize":parseInt(pageSize),
					"userType":$("body").attr("data-roleType"),
					"userId" : parseInt($("body").attr("data-userID")),
					"alertId" : alertId,
					"username" : $("body").attr("data-selected-username"),
					"description" : description,
					"status" : $('#status').val(),
					"featureName": $('#filterfeature').val()


			}
			//////console.log(JSON.stringify(filterRequest))
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: './exportRunningAlertData?source=ViewExport',
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

		function Resetfilter(formID){
			$('#'+formID).trigger('reset');
			$("label").removeClass('active');
			$('#errorMsg').text('');
			alertFieldTable(lang)
		}