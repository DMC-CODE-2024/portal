		var cierRoletype =$("body").attr("data-roleType");	
		var startdate=$('#startDate').val(); 
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="39";
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
			Datatable(lang);
			sessionStorage.removeItem("session-value");
			pageRendering();
			
		 });
		

		$('.datepick').datepicker({
			dateFormat: "yy-mm-dd"
		});


		var sourceType =localStorage.getItem("sourceType");
		var TagId = sessionStorage.getItem("tagId");
		
		var tableName = sessionStorage.getItem("tableName");
		var dbName = sessionStorage.getItem("databaseName");
		            // sessionStorage.removeAttribute("databaseName");
					
		
		//**************************************************filter table**********************************************
		
		function Datatable(lang){
			var filterRequest={
					"startDate" : $('#startDate').val(), 
					"endDate":$('#endDate').val(),
					"tableName": tableName,
					"dbName" : dbName,
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"username" : $("body").attr("data-selected-username"),
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
				url: "./dbtableHeaders?dbName="+dbName+"&tableName="+tableName,
				type: 'POST',
				dataType: "json",
				success: function(result){
					var table=	$("#DBManagementLibraryTable").DataTable({
						destroy:true,
						"serverSide": true,
						orderCellsTop : true,
						"ordering" : false,
						"bPaginate" : true,
						"bFilter" : true,
						"bInfo" : true,
						"bSearchable" : false,
						"scrollX": true,
						"scrolly": true,
						"searching": false,
						"oLanguage": {  
							"sUrl": langFile  
						},
						
						//dataSrc : result,
						ajax: {
							url : 'dbManagementData',
							type: 'POST',
							dataType: "json",
							data : function(d) {
								d.filter = JSON.stringify(filterRequest); 
								//////console.log(JSON.stringify(filterRequest));
							}
						},
						
						"columns": result,"defaultContent":"",
						fixedColumns: true,
						
					});
					
					$('div#initialloader').delay(300).fadeOut('slow');
					/*$('.dataTables_filter input')
				       .off().on('keyup', function(event) {
				    	   if(event.keyCode == 8 && !textBox.val() || event.keyCode == 46 && !textBox.val() || event.keyCode == 83 && !textBox.val()) {
					    
					            }
				    		if (event.keyCode === 13) {
				    			 table.search(this.value.trim(), false, false).draw();
				    		}
				          
				       });*/
					
				},
				error: function (jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax");
				}
			});
		}
		

		
		$('.datepicker').on('mousedown',function(event){
			event.preventDefault();
		});

	

		function pageRendering(){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: 'dbTable/pageRendering?tableName='+tableName,
				type: 'POST',
				dataType: "json",
				success: function(data){
					data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );
						
					/*var elem='<p class="PageHeading">'+data.pageTitle+'</p>';		
					$("#pageHeader").append(elem);
					var button=data.buttonList;
					var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
						if(date[i].type === "date"){
							$("#dbTableDiv").append("<div class='input-field col s6 m2'>"+
									"<div id='enddatepicker' class='input-group'>"+
									"<input class='form-control datepicker' type='text' id="+date[i].id+" autocomplete='off' onchange='checkDate(startDate,endDate)'>"+
									"<label for="+date[i].id+">"+date[i].title
									+"</label>"+
									"<span	class='input-group-addon' style='color: #ff4081'>"+
									"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");

						}else if(date[i].type === "text"){
							$("#dbTableDiv").append("<div class='input-field col s6 m2' ><input type="+date[i].type+" id="+date[i].id+" maxlength='19' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						}
					} 
			*/
				/*	// dynamic dropdown portion
					var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#dbTableDiv").append("<div class='col s6 m2 selectDropdwn'>"+
								
									"<div class='select-wrapper select2  initialized'>"+
									"<span class='caret'>"+"</span>"+
									"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

									"<select id="+dropdown[i].id+" class='select2 initialized'>"+
									"<option value='' selected Disabled>"+dropdown[i].title+
									"</option>"+
									"</select>"+
									"</div>"+
							"</div>");
					}*/

					/*	$("#dbTableDiv").append("<div class=' col s3 m2 l1'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
						$("#dbTableDiv").append("<div class=' col s3 m2 l7'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportDBTabletData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						*/
							var elem='<h1>'+data.pageTitle+'<h1>';	
				$("#pageHeader").append(elem);
				var button=data.buttonList;

				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){  
								$("#dbTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#dbTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");
						
					}
				
					
					
				} 
				
				
				var viewFilter="viewFilter";
				//$('#dbTableDiv div:last').after("<p id='errorMsg' style='padding:5px;color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 57px;' class='left'></p>")
			//	$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")	  
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter' onclick='Datatable()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportDBTabletData()'>"+$.i18n('Export')+" <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
                
				$('#clearFilter').attr("onclick", "filterResetDBtable('viewFilter')");		
						/*for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							$('#'+button[i].id).attr("onclick", button[i].buttonURL);
						}

						*/

				
					
				$('.datepicker').datepicker({
						dateFormat: "yy-mm-dd"
					});
				}
			}); 
			//alert("tableName-->" +tableName);
			
}

		function exportDBTabletData(){
			var table = $('#DBManagementLibraryTable').DataTable();
			var info = table.page.info(); 
			var pageNo=info.page;
			var pageSize =info.length;
			
			var filterRequest={
					"startDate" : $('#startDate').val(), 
					"endDate":$('#endDate').val(),
					"tableName": tableName,
					"dbName" : dbName,
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"username" : $("body").attr("data-selected-username"),
					"userId" : parseInt($("body").attr("data-userID")), 
					"pageNo":parseInt(pageNo),
					"pageSize":parseInt(pageSize)
			}
			
			
			////console.log(JSON.stringify(filterRequest))
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: './exportDbTablesData',
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
		

	function filterResetDBtable(formID){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	$('#errorMsg').text('');
	Datatable(lang,null);
}
