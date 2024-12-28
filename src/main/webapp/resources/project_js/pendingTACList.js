
			var featureId = 38;
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
			});

			var userId = $("body").attr("data-userID");

			/*localStorage.setItem("grievancePageSource", "viaGriebva");*/




			//**************************************************Grievance table**********************************************

			function DataTable(lang,source){
				var source__val;
				if(source == 'filter' ) {
					source__val= source;
					$("body").attr("data-session-source","filter");
				}
				else{
					source__val= $("body").attr("data-session-source");
				}
				var featureName = $('#feature').val() == null ? null : $("#feature option:selected").text();
				
				var filterRequest={
						"endDate":$('#endDate').val(),
						"startDate":$('#startDate').val(),
						"tac" : $('#tac').val(),
						"txnId" :  $('#transactionID').val(),
						"feature" : featureName,
						"userId": parseInt($("body").attr("data-userID")),
						"userName":$("body").attr("data-username"),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						"featureId":parseInt(featureId),
						"roleType":$("body").attr("data-roleType")
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
					url: 'headers?type=pendingTACHeaders&lang='+lang,
					type: 'POST',
					dataType: "json",
					success: function(result){
						
						var table=	$("#pendingTACLibraryTable").DataTable({
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
								url : 'pendingTACdata?source='+source__val,
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
					url: 'pendingTAC/pageRendering',
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
								$( "#"+date[i].id ).datepicker({
									dateFormat: "yy-mm-dd",
									 maxDate: new Date()
						        });
								}
							else if(date[i].type === "text"){
								$("#pendingTacTableDiv").append("<div class='input-field'><input type="+date[i].type+" id="+date[i].id+" maxlength='19' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");

							}
							$("#tac").prop("maxLength", 8);
						} 

						// dynamic dropdown portion
					/*	var dropdown=data.dropdownList;
						for(i=0; i<dropdown.length; i++){
							var dropdownDiv=
								$("#pendingTacTableDiv").append("<div class='col s6 m2 l2 selectDropdwn'>"+
										
										"<div class='select-wrapper select2 form-control boxBorder boxHeight initialized'>"+
										"<span class='caret'>"+"</span>"+
										"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

										"<select id="+dropdown[i].id+"  class='select-wrapper select2  initialized'>"+
										"<option value='-1'>"+dropdown[i].title+
										"</option>"+
										"</select>"+
										"</div>"+
								"</div>");
						}
*/
						$("#pendingTacTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'></div>");
						$("#pendingTacTableDiv").append("<div class='filter_btn'><button type='button'   class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
						$("#pendingTacTableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						$('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");
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
				
				setAllDropdown();
			};
			
			
			function setAllDropdown(){
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.getJSON('./getAllfeatures', function(data) {
				for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].id).text(data[i].name).appendTo('#feature');
				}
			});
				
		}



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
						"userId" : parseInt($("body").attr("data-userID")),
						"userId": parseInt($("body").attr("data-userID")),
						"userName":$("body").attr("data-username"),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						"featureId":parseInt(featureId),
						"roleType":$("body").attr("data-roleType")
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
				var roleType = $("body").attr("data-roleType");
				var currentRoleType = $("body").attr("data-stolenselected-roleType");
				var table = $('#pendingTACLibraryTable').DataTable();
				var info = table.page.info(); 
				var featureName = $('#feature').val() == null ? null : $("#feature option:selected").text();
				var pageNo=info.page;
				var pageSize =info.length;
				var source__val = $("body").attr("data-session-source"); 
				var filterRequest={
						"endDate":$('#endDate').val(),
						"startDate":$('#startDate').val(),
						"tac" : $('#tac').val(),
						"txnId" :  $('#transactionID').val(),
						"feature" : featureName,
						"featureId":parseInt(featureId),
						"pageNo":parseInt(pageNo),
						"pageSize":parseInt(pageSize),
						"userId": parseInt($("body").attr("data-userID")),
						"userName":$("body").attr("data-username"),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						"featureId":parseInt(featureId),
						"roleType":$("body").attr("data-roleType")
				}
				//////console.log(JSON.stringify(filterRequest))
				$.ajax({
					url: './exportPendingTacData?source='+source__val,
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
				$('#endDate').css('border-color', '');
				$('#errorMsg').text('');
				$('#'+formID).trigger('reset');
				$("label").removeClass('active');
				DataTable(lang,null);
			}
			


			