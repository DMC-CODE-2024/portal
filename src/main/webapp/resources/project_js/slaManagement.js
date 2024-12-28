
			var featureId = 40;
			var cierRoletype = sessionStorage.getItem("cierRoletype");
			var startdate=$('#startDate').val(); 
			var endDate=$('#endDate').val();
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
				DataTable(lang);
				pageRendering();
			});

			var userId = $("body").attr("data-userID");

			/*localStorage.setItem("grievancePageSource", "viaGriebva");*/

			$('.datepick').datepicker({
				dateFormat: "yy-mm-dd"
			});
			

			//**************************************************Grievance table**********************************************

			function DataTable(lang){
				
				var featureName = $('#feature').val() == null ? null : $("#feature option:selected").text();
				var username = $("#username").val() != "" ? $("#username").val() : $("#username").val();
				//var usertype = $('#userType').val() == null ? null : $("#userType option:selected").text(); 
				
				var filterRequest={
						"endDate":$('#endDate').val(),
						"startDate":$('#startDate').val(),
						
						"filteredUsername": username,
						"txnId":$('#transactionid').val(),
						
						"feature" : parseInt($('#feature').val()),
						"usertype" : parseInt($('#userType').val()),
						
						"username" : $("body").attr("data-selected-username"),
						"featureId":parseInt(featureId),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						"userId" : parseInt($("body").attr("data-userID"))
						
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
					url: 'headers?type=slaTableHeaders&lang='+lang,
					type: 'POST',
					dataType: "json",
					success: function(result){
						
						var table=	$("#slaLibraryTable").DataTable({
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
								initComplete: function() {
							 		$('.dataTables_filter input')
			       .off().on('keyup', function(event) {
			    	   if (event.keyCode === 13) {
			    			 table.search(this.value.trim(), false, false).draw();
			    		}
			          
			       });
				   },
							ajax: {
								url : 'slaData',
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

			$('.datepicker').on('mousedown',function(event){
				event.preventDefault();
			});
			
			//**************************************************Grievance page buttons**********************************************

			function pageRendering(){
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: 'sla/pageRendering',
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
								$("#alertTableDiv").append("<div class='input-field'>"+
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
							$("#alertTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength="+date[i].className+" /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						}
						else if(date[i].type === "select"){

								var dropdownDiv=
									$("#alertTableDiv").append("<div class='selectDropdwn'>"+
											
											"<div class='select-wrapper select2  initialized'>"+
											"<span class='caret'>"+"</span>"+
											"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

											"<select id="+date[i].id+" class='select2 initialized'>"+
											"<option value='-1' selected>"+date[i].title+
											"</option>"+
											"</select>"+
											"</div>"+
									"</div>");
							
							}
						}
					
					
							var viewFilter="viewFilter";
							$("#alertTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
							$("#alertTableDiv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
							$("#alertTableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
							$('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");
							for(i=0; i<button.length; i++){
								$('#'+button[i].id).text(button[i].buttonTitle);
								$('#'+button[i].id).attr("onclick", button[i].buttonURL);
							}
							
							/*for(i=0; i<button.length; i++){
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
*/
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
				
				$.getJSON('./registrationUserType?type=2', function(data) {
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].id).text(data[i].usertypeName)
						.appendTo('#userType');
					}
				});
				
		}


			//**********************************************************Export Excel file************************************************************************
			function exportData()
			{
				var roleType = $("body").attr("data-roleType");
				var currentRoleType = $("body").attr("data-stolenselected-roleType");
				var table = $('#slaLibraryTable').DataTable();
				var info = table.page.info(); 
				var pageNo=info.page;
				var pageSize =info.length;
				var featureName = $('#feature').val() == null ? null : $("#feature option:selected").text();
				var username = $("#username").val() != "" ? $("#username").val() : $("#username").val();
				var filterRequest={
						"endDate":$('#endDate').val(),
						"startDate":$('#startDate').val(),
						"feature" : parseInt($('#feature').val()),
						"usertype" : $('#userType').val(),
						"username" : $("body").attr("data-selected-username"),
						"featureId":parseInt(featureId),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						"userId" : parseInt($("body").attr("data-userID")),
						"filteredUsername": username,
						"txnId":$('#transactionid').val(),
						"pageNo":parseInt(pageNo),
						"pageSize":parseInt(pageSize)
					
				}
				console.log(JSON.stringify(filterRequest))
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: './exportSlaData',
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
				DataTable(lang)
				
			}	


			