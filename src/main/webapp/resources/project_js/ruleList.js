		var cierRoletype =$("body").attr("data-roleType");
		var startdate=$('#startDate').val();
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="29";
		var rejectedMsg,consignmentApproved,errorMsg,havingTxnID,updateMsg,hasBeenUpdated;
		var consignmentDeleted,deleteInProgress;
		var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
		/*$.i18n().locale = lang;

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
		});*/

       $(document).ready(function(){
         filter();
		pageButtons('./ruleList/pageRendering').then(() => filterDropdown());
		 });




         function filter()
 		{
 			table('./headers?type=ruleList','./ruleListData');
 			}

		//**************************************************filter table**********************************************

		function table(url,dataUrl){
			$('div#initialloader').fadeIn('fast');
			var state= $("#State").val() == '' ||  $("#State").val() == undefined ? null : $("#State").val();
			var name = $("#filterRule").val() =='' ||  $("#filterRule").val() == undefined ? null  : $("#filterRule").val();
			var description = $("#filterDescription").val() == '' ||  $("#filterDescription").val() == undefined ? null  : $("#filterDescription").val();

			//alert("state--"+state+"  name--"+name+"  description--"+description);
				var filterRequest={

							"endDate":$('#endDate').val(),
							"startDate":$('#startDate').val(),
							"type" : parseInt($('#type').val()),
						  	"state": state,
							"userId":parseInt($("body").attr("data-userID")),
							"featureId":'29',
							"userTypeId": parseInt($("body").attr("data-userTypeID")),
							"userName":$("body").attr("data-selected-username"),
							"roleType":$("body").attr("data-roleType"),
							"name" :  name,
							"description" : description,

				}
			//console.log($("body").attr("data-userID"),featureId,$("body").attr("data-userTypeID"),$("body").attr("data-selected-username"),$("body").attr("data-roleType"));
			if(lang=='km'){
				var langFile='./resources/i18n/khmer_datatable.json';
			}
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: url,
				/*	headers: {"Accept-Language": "en"},*/
				type: 'POST',
				dataType: "json",
				success: function(result){
					var table=	$("#table").DataTable({
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
							url : dataUrl,
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
						columnDefs: [{targets:[3], class:"columnwrap"}]
					});


					$('div#initialloader').delay(300).fadeOut('slow');

				},
				error: function (jqXHR, textStatus, errorThrown) {

				}
			});
		}



		function pageButtons(Url){
		return new Promise((resolve, reject) => {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: Url,
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
								$("#FieldTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#FieldTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");

					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#FieldTableDiv").append(
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

			//$('#FieldTableDiv div:last').after("<p id='errorMsg' style='padding:5px;color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 57px;' class='left'></p>")

			$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")
			$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>Reset All</button></div>");
			$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter' onclick='filter()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
			$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
            $('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");
						/*for(i=0; i<button.length; i++){
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



function filterDropdown(){
var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajaxSetup({
							headers:
							{ 'X-CSRF-TOKEN': token }
						});
						$.getJSON('./getDropdownList/RULE_STATE', function(data) {
							for (i = 0; i < data.length; i++) {
								$('<option>').val(data[i].interpretation).text(data[i].interpretation)
								.appendTo('#State,#editState');
							}
						});
						}


			function getDetailBy(id,output){

				window.xid=id;
				window.xoutput=output;
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url : "./viewRuleListAPI/"+id,
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					type : 'GET',
					success : function(data) {
						var result=JSON.stringify(data);
						$("#editModel").openModal({
					        dismissible:false
					    });
						setData(JSON.parse(result));
					},
					error : function() {
						////console.log("Failed");
					}
				});
			}


			function setData(result){
				$("label[class='center-align']").addClass('active');
				$("#editName").val(result.name);
				$("#editDescription").val(result.description);
				$("#editState").val(result.state);
				result.modifiedBy =="" || result.modifiedBy==null ?  $("#editModifiedBy").val('system'): $("#editModifiedBy").val(result.modifiedBy);
			}



			function update(){

				var name=$('#editName').val();
				var description=$('#editDescription').val();
				var state=$('#editState').val();
				var ruleListContent={
						"name":name,
						"description":description,
						"state":state,
						"id":window.xid,
						"output":window.xoutput,
						"userId":parseInt($("body").attr("data-userID")),
						"featureId":'29',
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userName":$("body").attr("data-selected-username"),
						"roleType":$("body").attr("data-roleType")

				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({

					url : "./updateRuleList",
					data : JSON.stringify(ruleListContent),
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					type : 'POST',
					success: function (data, textStatus, jqXHR) {
	/*		$('#editModel').closeModal();
			$("#updateFieldsSuccess").openModal({
				dismissible:false
			});
*/
			$.i18n().locale = window.parent.$('#langlist').val();

            			$.i18n().load({
            				'en' : './resources/i18n/en.json',
            				'km' : './resources/i18n/km.json'
            			}).done(function() {

            					sessionStorage.removeItem('newRule');
                        	/*			$('#updateFieldMessage').text('');
                                        $('#updateFieldMessage').text($.i18n('rule_list_update'));*/
                                              setTimeout(function() {location.reload();}, 100);
                                              window.parent.alertify.success($.i18n('rule_list_update'),4);


            			});




				/*		$('#editModel').closeModal();
						$("#updateFieldsSuccess").openModal({
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
                        					$('#updateFieldMessage').text($.i18n('rule_list_update'));
                        				}else if(data.errorCode==201){
                        					$('#updateFieldMessage').text('');
                        					$('#updateFieldMessage').text(data.message);
                        				}
                        			});*/
					},
					error: function (jqXHR, textStatus, errorThrown) {

					}
				});

				return false;
			}

			function exportData(){
				var table = $('#table').DataTable();
				var info = table.page.info();
				var pageNo=info.page;
				var pageSize =info.length;
				var state= $("#State").val() == '' ||  $("#State").val() == undefined ? null : $("#State").val();
				var name = $("#filterRule").val() =='' ||  $("#filterRule").val() == undefined ? null  : $("#filterRule").val();
				var description = $("#filterDescription").val() == '' ||  $("#filterDescription").val() == undefined ? null  : $("#filterDescription").val();

				var filterRequest={
							"endDate":$('#endDate').val(),
							"startDate":$('#startDate').val(),
						    "state": state,
							"userId":parseInt($("body").attr("data-userID")),
							"featureId":'29',
							"userTypeId": parseInt($("body").attr("data-userTypeID")),
							"userName":$("body").attr("data-selected-username"),
							"roleType":$("body").attr("data-roleType"),
							"userType":$("body").attr("data-roleType"),
							//"username" : $("body").attr("data-selected-username"),
							"name" :  name,
							"description" : description,
							"pageNo":parseInt(pageNo),
							"pageSize":parseInt(pageSize)

				}
				//console.log(JSON.stringify(filterRequest))
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});

				$.ajax({
					url: './exportRuleList',
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



			function viewByID(id,output){
				window.xid=id;
				window.xoutput=output;
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url : "./viewRuleListAPI/"+id,
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					type : 'GET',
					success : function(data) {
						var result=JSON.stringify(data);
						$("#viewModel").openModal({
					        dismissible:false
					    });


						view_data(JSON.parse(result));
					},
					error : function() {
						////console.log("Failed");
					}
				});
			}


			function view_data(result){
				$("label[class='center-align']").addClass('active');
				$("#viewName").val(result.name);
				$("#viewDescription").val(result.description);
				$("#viewState").val(result.state);
				result.modifiedBy =="" || result.modifiedBy==null ?  $("#viewModifiedBy").val('system'): $("#viewModifiedBy").val(result.modifiedBy);

			}
			 function Resetfilter(formID){
					$('#'+formID).trigger('reset');
					$("label").removeClass('active');
						$('#errorMsg').text('');
					filter(lang,null);
			 }
