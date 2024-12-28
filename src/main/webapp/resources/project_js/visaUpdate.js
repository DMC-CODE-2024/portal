
			var featureId = 43;
			var cierRoletype = sessionStorage.getItem("cierRoletype");

			var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
		/*		window.parent.$('#langlist').on('change', function() {
					var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
				window.location.assign("./grievanceManagement?lang="+lang);
			
				});*/ 


				$.i18n().locale = lang;
				var documenttype,selectfile,selectDocumentType;
				$.i18n().load( {
					'en': './resources/i18n/en.json',
					'km': './resources/i18n/km.json'
				} ).done( function() { 
						documenttype=$.i18n('documenttype');
						selectfile=$.i18n('selectfile');
						selectDocumentType=$.i18n('selectDocumentType');
				
				});

					
			$(document).ready(function(){
				$('div#initialloader').fadeIn('fast');
				DataTable(lang,null);
				pageRendering();
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-userTypeID"), function(data) {
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].state).text(data[i].interp)
						.appendTo('#status'); 
					
					}
			
				});
				$.getJSON('./getDropdownList/VISA_TYPE', function(data) {
					for (i = 0; i < data.length; i++) {
						
						$('<option>').val(data[i].value).text(data[i].interp)
						.appendTo('#visaTypeFilter');

					}
				});
			});

			var userId = $("body").attr("data-userID");

			/*localStorage.setItem("grievancePageSource", "viaGriebva");*/




			//**************************************************Grievance table**********************************************

			function DataTable(lang,source){
				var source__val;
					//////console.log("1=="+source);
				var status =$('#status').val();
				if(status=="" || status==null){
					status=null;
				}
				if(source == 'filter' ) {
					source__val= source;
				}
				else{
					source__val= $("body").attr("data-session-source");

				}
				//////console.log("2=="+source__val);

				//var featureName = $('#feature').val() == null ? null : $("#feature option:selected").text();
				var txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#visaTxnId').val() : transactionIDValue;
				
				if (source=="filter")
				{
				if($("body").attr("data-session-source")=='noti'){
					
					txn=$('#visaTxnId').val();
				}
				$("body").attr("data-session-source","filter")
				txn=$('#visaTxnId').val();
				}
			
				var filterRequest={
						"endDate":$('#endDate').val(),
						"startDate":$('#startDate').val(),
						"txnId":txn,
						"status":status,
						"startDate":$('#startDate').val(),
						"userId": parseInt($("body").attr("data-userID")),
						"featureId":parseInt(featureId),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						"featureId":parseInt(featureId),
						"nid":$('#passportNumberFilter').val(),
						"visaType":$('#visaTypeFilter').val(),
						"visaNumber":$('#visaNumberFilter').val(),
						"visaExpiryDate":$('#expiryDateFilter').val(),
						"fileName":$('#fileNameFilter').val(),
						
						//"status" : parseInt($('#status').val())
				}
				
				if(lang=='km'){
						var langFile="./resources/i18n/khmer_datatable.json";
					}
				else if(lang=='en'){
					var langFile='./resources/i18n/english_datatable.json';
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: 'headers?type=adminVisaHeaders&lang='+lang,
					type: 'POST',
					dataType: "json",
					success: function(result){
						
						var table=	$("#pendingTACLibraryTable").DataTable({
							destroy:true,
							"serverSide": true,
							"ordering" : true,
							orderCellsTop : true,
						   "bPaginate" : true,
							"bFilter" : false,
							"bInfo" : true,
							"bSearchable" : true,
							"oLanguage": {  
									"sUrl": langFile  
								},
								"aaSorting": [],
								columnDefs: [
									   { orderable: false, targets: -1 }
									],
								initComplete: function() {
							 		$('.dataTables_filter input')
			       .off().on('keyup', function(event) {
			    	   if (event.keyCode === 13) {
			    			 table.search(this.value.trim(), false, false).draw();
			    		}
			          
			       });
				   },
							ajax: {
								url : 'visaUpdatedata?source='+source__val,
								type: 'POST',
								dataType: "json",
								data : function(d) {
									d.filter = JSON.stringify(filterRequest); 
									//////console.log(JSON.stringify(filterRequest));
								},
								error: function (jqXHR, textStatus, errorThrown,data) {
									
									 window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
									 // messageWindow(jqXHR['responseJSON']['message']);
									 window.parent.$('#500ErrorModal').openModal({
									 dismissible:false
									 });
									
								}

							},
							"columns": result
						});
						$('div#initialloader').delay(300).fadeOut('slow');
					
					},
					error: function (jqXHR, textStatus, errorThrown) {
						//////console.log("error in ajax");
					}
				});
			}



			//**************************************************Grievance page buttons**********************************************

			function pageRendering(){
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: 'visaUpdatedata/pageRendering',
					type: 'POST',
					dataType: "json",
					success: function(data){
						data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );


						var elem='<p class="PageHeading">'+data.pageTitle+'</p>';		
						$("#pageHeader").append(elem);
						var button=data.buttonList;

						var date=data.inputTypeDateList;
						for(i=0; i<date.length; i++){
							if(date[i].type === "date"){
								$("#pendingTacTableDiv").append("<div class='input-field'>"+
										"<div id='enddatepicker' class='input-group date'>"+
										"<input class='form-control datepicker' type='text' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"+
										"<label for="+date[i].id+">"+date[i].title
										+"</label>"+
										"<span	class='input-group-addon' style='color: #ff4081'>"+
										"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");
								if(date[i].id=="expiryDateFilter")
									{
									$( "#"+date[i].id ).datepicker({
										dateFormat: "yy-mm-dd",
										
							        });
									}
								else{
									$( "#"+date[i].id ).datepicker({
										dateFormat: "yy-mm-dd",
										 maxDate: new Date()
							        });
								}
								
								}
							else if(date[i].type === "text"){
								$("#pendingTacTableDiv").append("<div class='input-field'><input type="+date[i].type+" id="+date[i].id+" maxlength="+date[i].className+" /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");

							}
							else if(date[i].type === "select"){

								var dropdownDiv=
									$("#pendingTacTableDiv").append("<div class='selectDropdwn'>"+
											
											"<div class='select-wrapper select2  initialized'>"+
											"<span class='caret'>"+"</span>"+
											"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

											"<select id="+date[i].id+" class='select2 initialized'>"+
											"<option value=''>"+date[i].title+
											"</option>"+
											"</select>"+
											"</div>"+
									"</div>");
							
							}
						} 

						// dynamic dropdown portion
					/*	var dropdown=data.dropdownList;
						for(i=0; i<dropdown.length; i++){
							var dropdownDiv=
								$("#pendingTacTableDiv").append("<div class='col s6 m2 l2 selectDropdwn'>"+
										
										"<div class='select-wrapper select2 form-control boxBorder boxHeight initialized'>"+
										"<span class='caret'>"+"</span>"+
										"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

										"<select id="+'statusvisa'+"  class='select-wrapper select2  initialized'>"+
										"<option value='-1'>"+dropdown[i].title+
										"</option>"+
										"</select>"+
										"</div>"+
								"</div>");
						}*/

						$("#pendingTacTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'></div>");
						$("#pendingTacTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='clearVisaFilter'>"+$.i18n('clearFilter')+"</button></div>");
						$("#pendingTacTableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)'  type='button' class='export-to-excel right'  onclick='exportData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						$('#clearVisaFilter').attr("onclick", "visafilterReset('visaViewTable')");	
						for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							if(button[i].type === "HeaderButton"){
								$('#'+button[i].id).attr("href", button[i].buttonURL);
							}
							else{
								$('#'+button[i].id).attr("onclick", button[i].buttonURL);
							}
						}

						if(cierRoletype=="CEIRAdmin"){
							$("#btnLink").css({display: "none"});
						}

						
						
						$('.datepicker').datepicker({
							dateFormat: "yy-mm-dd"
						});
					}

				}); 
				
				
			};
			
			
			/*function setAllDropdown(){
				$.getJSON('./getAllfeatures', function(data) {
				for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].id).text(data[i].name).appendTo('#feature');
				}
			});
				
		}*/



			function  DeleteByID(txnId,id){
				
				$("#DeleteTacConfirmationModal").openModal({
			        dismissible:false
			    });
				$("#tacdeleteTxnId").text(txnId);
				$("#deleteTacId").val(id);
			} 
			
			function confirmantiondelete(){
				var id  = parseInt($("#deleteTacId").val());
				var deleteRequest = {
						"id" : id,
						"txnId" : $("#tacdeleteTxnId").text(),
						"remark" : $("#deleteTacRemark").val(),
						"userId" : parseInt($("body").attr("data-userID"))
				}
				//////console.log(JSON.stringify(deleteRequest));
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url : './pending-tac-approved',
					data : JSON.stringify(deleteRequest),
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					type : 'DELETE',
					success : function(data, textStatus, xhr) {
						//////console.log(data);
						$("#DeleteTacConfirmationModal").closeModal();
						$("#closeDeleteModal").openModal({
					        dismissible:false
					    });
						
						$("#materialize-lean-overlay-3").css("display","none");
					},
					error : function() {
						//////console.log("Error");
					}
				});
				
				return false;
			}
			
			
			//**********************************************************Export Excel file************************************************************************
			
			function exportData()
			{
				var txn="";
				var roleType = $("body").attr("data-roleType");
				var currentRoleType = $("body").attr("data-stolenselected-roleType");
				var table = $('#pendingTACLibraryTable').DataTable();
				var info = table.page.info(); 
				var featureName = $('#feature').val() == null ? null : $("#feature option:selected").text();
				var pageNo=info.page;
				var pageSize =info.length;
				if( $("body").attr("data-session-source")=='noti'){
					 txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#visaTxnId').val() : transactionIDValue;	
				}
				else{
					txn=$('#visaTxnId').val();
				}
				//alert
				var filterRequest={
						"endDate":$('#endDate').val(),
						"startDate":$('#startDate').val(),
						"txnId":txn,
						"status":$('#status').val(),
						"userId": parseInt($("body").attr("data-userID")),
						"featureId":parseInt(featureId),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						"featureId":parseInt(featureId),
						"pageNo":parseInt(pageNo),
						"pageSize":parseInt(pageSize),
						"nid":$('#passportNumberFilter').val(),
						"visaType":$('#visaTypeFilter').val(),
						"visaNumber":$('#visaNumberFilter').val(),
						"visaExpiryDate":$('#expiryDateFilter').val(),
						"fileName":$('#fileNameFilter').val(),
						"source":$("body").attr("data-session-source"),
						"userName":$("body").attr("data-selected-username")
				}
				//////console.log(JSON.stringify(filterRequest))
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: './exportVisaData',
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
			


			function deviceApprovalPopup(visaId,endUserId,txnId){
				$('#approveInformation').openModal({dismissible:false});
				window.visaId=visaId;
				window.endUserId=endUserId;
				$('#approveTxnId').text(txnId);
			}   


			function aprroveDevice(){

				var approveRequest={
						"action" : 0,
						"remarks": "",
						"id":window.visaId,
						"userId":window.endUserId,
						"userType": $("body").attr("data-roleType")	  	
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url : './approveVisaUpdateRequest',
					data : JSON.stringify(approveRequest),
					dataType : 'json',
					'async' : false,
					contentType : 'application/json; charset=utf-8',
					type : 'POST',
					success : function(data) {

						if(data.errorCode==0){
							confirmApproveInformation();

						}

					},
					error : function() {
						//////console.log("Failed");

					}
				});
			}

			function confirmApproveInformation(){
				$('#approveInformation').closeModal(); 
				setTimeout(function(){ $('#confirmApproveInformation').openModal({dismissible:false});}, 200);
			}



			function userRejectPopup(visaId,endUserId,txnId){
				$('#rejectInformation').openModal({dismissible:false});
				$('#disapproveTxnId').text(txnId)
				window.visaId=visaId;
				window.endUserId=endUserId;
			}



			function rejectUser(){
				
				var rejectRequest={
						"action" : 1,
						"remarks": $("#Reason").val(),
						"id":window.visaId,
						"userId":parseInt(endUserId),
						"userType": $("body").attr("data-roleType")	  	
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url : './approveVisaUpdateRequest',
					data : JSON.stringify(rejectRequest),
					dataType : 'json',
					'async' : false,
					contentType : 'application/json; charset=utf-8',
					type : 'POST',
					success : function(data) {

						if(data.errorCode==0){
							confirmRejectInformation();

						}

					},
					error : function() {
						//////console.log("Failed");
					}
				});
				return false;
			}



			function confirmRejectInformation(){
				$('#rejectInformation').closeModal();
				setTimeout(function(){$('#confirmRejectInformation').openModal({dismissible:false});},200);
			}



			
			
			
			function viewDetails(visaId,endUserId,source,txnId){ 
				
				window.location.href="./view-visa-information/"+visaId+"/"+endUserId+"?source="+source+"&txnId="+txnId;


			}
			
			
			
			function historyRecord(txnID){
				//////console.log("txn id=="+txnID)
				$("#tableOnModal").openModal({dismissible:false});
				 var filter =[];
				 var formData= new FormData();
				 var filterRequest={
						 "columns": [
							    "created_on","modified_on","txn_id","status","nid","visa_type","visa_number","visa_expiry_date","visa_file_name","entry_date_in_country","remark","user_id","approved_by"
							    
							    ],
						"tableName": "visa_update_db_aud",
						"dbName" : "ceirconfig",
						"txnId":txnID,
						"featureId":43
				}
				formData.append("filter",JSON.stringify(filterRequest));	
				if(lang=='km'){
					var langFile='./resources/i18n/khmer_datatable.json';
				}
				else if(lang=='en'){
					var langFile='./resources/i18n/english_datatable.json';
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: 'Consignment/consignment-history',
					type: 'POST',
					data: formData,
					processData: false,
					contentType: false,
					success: function(result){
						var dataObject = eval(result);
						$('#data-table-history').dataTable({
							 "order" : [[1, "asc"]],
							 destroy:true,
							"serverSide": false,
							 orderCellsTop : true,
							"ordering" : false,
							"bPaginate" : true,
							"bFilter" : false,
							"scrollX": true,
							"bInfo" : true,
							"oLanguage": {  
								"sUrl": langFile  
							},
							"bSearchable" : true,
							pageLength : 3,
							 "data": dataObject.data,
							 "columns": dataObject.columns
						
					    });
						$('div#initialloader').delay(300).fadeOut('slow');
				}
					
		});
			
				$('.datepicker').on('mousedown',function(event){
				event.preventDefault();
			});
		}

			function visafilterReset(formID){
				$('#endDate').css('border-color', '');
				$('#errorMsg').text('');
				$('#'+formID).trigger('reset');
				$("label").removeClass('active');
				$('div#initialloader').fadeIn('fast');
				DataTable(lang,null);
			}
			
		