		var cierRoletype =$("body").attr("data-roleType");	
		var startdate=$('#startDate').val(); 
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="27";
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

         $(window).load(function(){
			$('div#initialloader').fadeIn('fast');
			userManangementTable(lang);
			sessionStorage.removeItem("session-value");
			pageRendering();
			
		 });
		

		$('.datepick').datepicker({
			dateFormat: "yy-mm-dd"
		});


		var sourceType =localStorage.getItem("sourceType");
		var TagId = sessionStorage.getItem("tagId");
		
		
		//**************************************************filter table**********************************************
		
		function userManangementTable(lang){
			$('div#initialloader').fadeIn('fast');
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"id" : parseInt($("#userType").val()),
					"username" : $("body").attr("data-selected-username"),
					"status":$('#statusID').val()
					
					
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
				url: 'headers?type=userManagementHeaders&lang='+lang,
				/*	headers: {"Accept-Language": "en"},*/
				type: 'POST',
				dataType: "json",
				success: function(result){
					var table=	$("#userManagementLibraryTable").DataTable({
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
							url : 'systemUserManagementData',
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
						"columns": result
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
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: 'systemUserManagement/pageRendering',
				type: 'POST',
				dataType: "json",
				success: function(data){
					data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );
					
				/*	var elem='<p class="PageHeading">'+data.pageTitle+'</p>';		
					$("#pageHeader").append(elem);
					var button=data.buttonList;
					var date=data.inputTypeDateList;
					for(i=0; i<date.length; i++){
						if(date[i].type === "date"){
							$("#userManagementTableDiv").append("<div class='input-field responsiveDiv'>"+
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
							$("#userManagementTableDiv").append("<div class='input-field'><input type="+date[i].type+" maxlength="+date[i].className+" id="+date[i].id+"><label for='parametername' class='center-align'>"+date[i].title+"</label></div>");
							
						}
						else if(date[i].type === "select"){

							var dropdownDiv=
								$("#userManagementTableDiv").append("<div class='selectDropdwn'>"+
										
										"<div class='select-wrapper select2  initialized'>"+
										"<span class='caret'>"+"</span>"+
										"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

										"<select id="+date[i].id+" class='select2 initialized'>"+
										"<option value='-1'>"+date[i].title+"</option>"+
										"</select>"+
										"</div>"+
								"</div>");
						
						}
						 
					} 
				
				// dynamic dropdown portion
		/*			var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#userManagementTableDiv").append("<div class='col s6 m2 selectDropdwn'>"+
								
									"<div class='select-wrapper select2  initialized'>"+
									"<span class='caret'>"+"</span>"+
									"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

									"<select id="+dropdown[i].id+" class='select2 initialized'>"+
									"<option value='' selected>"+dropdown[i].title+
									"</option>"+
									"</select>"+
									"</div>"+
							"</div>");
					}

						$("#userManagementTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
						$("#userManagementTableDiv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>Clear all filters</button></div>");
						$("#userManagementTableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportUserTypeData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						*/
						var elem='<h1>'+data.pageTitle+'<h1>';	
				$("#pageHeader").append(elem);
				var button=data.buttonList;

				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){  
								$("#userManagementTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#userManagementTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");
						
					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#userManagementTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+date[i].id+">"+date[i].title+"</label>"+
										"<select id="+date[i].id+"  class='form-control'>"+
										"<option value='-1' selected>"+date[i].title+
										"</option>"+
										"</select>"+
										"</div>"+
								"</div>");
					
					}
				} 
				
				var viewFilter="viewFilter";
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter'><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportUserTypeData()'>"+$.i18n('Export')+"<img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
						$('#clearFilter').attr("onclick", "filterResetUserTypeManagement('viewFilter')");
						for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							$('#'+button[i].id).attr("onclick", button[i].buttonURL);
						}

				}
			}); 
			
			
			setAllDropdown();
	}



		
		function setAllDropdown(){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.getJSON('./registrationUserType?type=2', function(data) {
			for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].id).text(data[i].usertypeName).appendTo('#userType');
			}
		});
			
		$.getJSON('./getDropdownList/UserType_Status', function(data) {
				for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interpretation)
				.appendTo('#userStatus,#statusID');
			 }
		});
		}


	/*--------------------------------- Edit Model View -----------------------------------*/
	
	
	function userChangeStatus(id){
		window.userId = id 
		var request ={
				"dataId" :  parseInt(id),
				"userId": parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username")
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
				url: './userTypeViewByID',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						var result = data.data
						$("#statusChangemodal").openModal({
						 	   dismissible:false
						 });
						result.modifiedBy =="" || result.modifiedBy==null ?  $("#editmodifiedBy").val('NA'): $("#editmodifiedBy").val(result.modifiedBy);
						$('#userStatus').val(result.status);
						$("label[for='editmodifiedBy']").addClass('active')
						//////console.log(JSON.stringify(result));
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				}
			});	
		}
	
	function chanegeUserStatus(){
		var Request={
				"status" : parseInt($("#userStatus").val()),
				"usertypeId": parseInt(window.userId),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username")
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : './updateSystemUserTypeStatus',
			data : JSON.stringify(Request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data) {
				////console.log("Request----->"+JSON.stringify(Request));
				$("#confirmUserStatus").openModal({
				 	   dismissible:false
			    });
			},
			error : function() {
				alert("Failed");
			}
		});
		return false;
	}
	
	function exportUserTypeData(){
		var table = $('#userManagementLibraryTable').DataTable();
		var info = table.page.info(); 
		var pageNo=info.page;
		var pageSize =info.length;
		
		
		var filterRequest={
				"endDate":$('#endDate').val(),
				"startDate":$('#startDate').val(),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"id" : parseInt($("#userType").val()),
				"username" : $("body").attr("data-selected-username"),
				"pageNo":parseInt(pageNo),
				"pageSize":parseInt(pageSize),
				"status":$('#statusID').val()
				
		}
		//console.log(JSON.stringify(filterRequest))
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		
		$.ajax({
			url: './exportUserTypeData',
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
	
	
	function filterResetUserTypeManagement(formID){
		$('#'+formID).trigger('reset');
		$("label").removeClass('active');
		userManangementTable(lang);
	}