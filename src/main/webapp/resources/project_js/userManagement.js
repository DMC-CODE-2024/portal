		var cierRoletype =$("body").attr("data-roleType");	
		var startdate=$('#startDate').val(); 
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="41";
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
			DataTable(lang);
			sessionStorage.removeItem("session-value");
			pageRendering();
			
		 });
		

		$('.datepick').datepicker({
			dateFormat: "yy-mm-dd"
		});


		var sourceType =localStorage.getItem("sourceType");
		var TagId = sessionStorage.getItem("tagId");
		
		
		//**************************************************filter table**********************************************
		
		function DataTable(lang){
			$('div#initialloader').fadeIn('fast');
			if(sourceType='menu'){
				var filterRequest={
						"endDate":$('#endDate').val(),
						"startDate":$('#startDate').val(),
						"userId":parseInt(userId),
						"featureId":parseInt(featureId),
						"usertypeId" : parseInt($('#userType').val()),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						//"username" : $("body").attr("data-selected-username"),
						"email" : $('#emailID').val(),
						"phoneNo" : $('#phone').val(),
						"username" :  $("body").attr("data-selected-username"),
						"filteredUsername" : $('#userName').val()
				}		
			}else{
				var filterRequest={
						"endDate":$('#endDate').val(),
						"startDate":$('#startDate').val(),
						"userId":parseInt(userId),
						"featureId":parseInt(featureId),
						"usertypeId" : parseInt($('#userType').val()),
						"userTypeId": parseInt($("body").attr("data-userTypeID")),
						"userType":$("body").attr("data-roleType"),
						//"username" : $("body").attr("data-selected-username"),
						"email" : $('#emailID').val(),
						"phoneNo" : $('#phone').val(),
						"username" :  $("body").attr("data-selected-username"),
								
				}		
			}
			
			
			if(lang=='km'){
				var langFile="./resources/i18n/khmer_datatable.json";
			}
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: 'headers?type=userTableHeaders&lang='+lang,
				/*	headers: {"Accept-Language": "en"},*/
				type: 'POST',
				dataType: "json",
				success: function(result){
					var table=	$("#userLibrarayTableDiv").DataTable({
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
						initComplete: function() {
					 		$('.dataTables_filter input')
	       .off().on('keyup', function(event) {
	    	   if (event.keyCode === 13) {
	    			 table.search(this.value.trim(), false, false).draw();
	    		}
	          
	       });
		   },
						ajax: {
							url : 'UserManagementData',
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
						columnDefs : [
							{ orderable: false, targets: -1 }
							]
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
				url: 'systemUser/pageRendering',
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
							$("#userTableDiv").append("<div class='input-field'>"+
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
							$("#userTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='50' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						}
						 
					} */
				
				// dynamic dropdown portion
				/*	var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#userTableDiv").append("<div class='selectDropdwn'>"+
								
									"<div class='select-wrapper select2  initialized'>"+
									"<span class='caret'>"+"</span>"+
									"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

									"<select id="+dropdown[i].id+" class='select2 initialized'>"+
									"<option value='' selected >"+dropdown[i].title+
									"</option>"+
									"</select>"+
									"</div>"+
							"</div>");
					}
						var viewFilter="viewFilter";
						$("#userTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
						$("#userTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
						$("#userTableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportUserManagementData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						*/
						
						var elem='<h1>'+data.pageTitle+'<h1>';	
				$("#pageHeader").append(elem);
				var button=data.buttonList;

				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){  
								$("#userTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#userTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");
						
					}
				
					// dynamic dropdown portion
					
					
				} 
				var dropdown=data.dropdownList;
					var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#userTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+dropdown[i].id+">"+dropdown[i].title+"</label>"+
										"<select id="+dropdown[i].id+"  class='form-control'>"+
										"<option value='-1' selected>"+dropdown[i].title+
										"</option>"+
										"</select>"+
										"</div>"+
								"</div>");
					}
				
				var viewFilter="viewFilter";
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter'><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportUserManagementData()'>"+$.i18n('Export')+"<img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

						
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

				}
			}); 
			
			
			setDropdown();
	}



		
	function setDropdown(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.getJSON('./registrationUserType?type=0', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].id).text(data[i].usertypeName)
				.appendTo('#userType');
			}
		});
		
		$.getJSON('./getDropdownList/UserType_Status', function(data) {
			for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#userStatus,#viewStatus');
		 }
		});
	}

	
	function viewDetails(id,action){
	
	var request = {	
		"dataId":parseInt(id), 
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
			url: './viewUser',
			type: 'POST',
		    data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {
					var result = data.data;
					if(action == "View"){
						$("#ViewModel").openModal({
					        dismissible:false
					    });
						viewPopupData(result);
						
					}else{
						$("#editModel").openModal({
					        dismissible:false
					    });
						editPopupData(result);
						
					}
					
					////console.log(JSON.stringify(result));
			},
			error: function (jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			}
		});	
	}
	 
	 
	function viewPopupData(result){
		result.firstName=="" || result.firstName==null ? $("#viewfirstName").val('NA') : $("#viewfirstName").val(result.firstName);
		result.middleName=="" || result.middleName==null ? $("#viewmiddleName").val('NA') : $("#viewmiddleName").val(result.middleName);
		result.lastName=="" || result.lastName==null ? $("#viewlastName").val('NA') : $("#viewlastName").val(result.lastName);
		result.phoneNo=="" || result.phoneNo==null ? $("#viewcontactNumber").val('NA') : $("#viewcontactNumber").val(result.phoneNo);
		result.email=="" || result.email==null ? $("#viewemailID").val('NA') : $("#viewemailID").val(result.email);
		result.password=="" || result.password==null ? $("#viewPassword").val('NA') : $("#viewPassword").val(result.password);
		result.password=="" || result.password==null ? $("#viewconfirmPassword").val('NA') : $("#viewconfirmPassword").val(result.password);
		result.viewUserType=="" || result.viewUserType==null ? $("#viewuserType").val('NA') : $("#viewuserType").val(result.viewUserType);
		result.userName=="" || result.userName==null ? $("#viewuserName").val('NA') : $("#viewuserName").val(result.userName);
		result.remarks=="" || result.remarks==null ? $("#viewuserRemark").val('NA') : $("#viewuserRemark").val(result.remarks);
		result.approvedBy =="" || result.approvedBy==null ?  $("#viewModifiedBy").val('NA'): $("#viewModifiedBy").val(result.approvedBy);
		result.currentStatus == 5 ? $("#viewStatus").val(0) : $("#viewStatus").val(1);
		$("label[for='viewStatus']").addClass('active');
		$("label[for='viewfirstName']").addClass('active');
		$("label[for='viewmiddleName']").addClass('active');
		$("label[for='viewlastName']").addClass('active');
		$("label[for='viewcontactNumber']").addClass('active');
		$("label[for='viewemailID']").addClass('active');
		$("label[for='viewPassword']").addClass('active');
		$("label[for='viewconfirmPassword']").addClass('active');
		$("label[for='viewuserType']").addClass('active');
		$("label[for='viewuserRemark']").addClass('active');
		$("label[for='viewuserName']").addClass('active');
		$("label[for='viewModifiedBy']").addClass('active');
		
		
	}
	
	
	function editPopupData(result){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.getJSON('./registrationUserType?type=0', function(data) {
			$('#edituserType').empty();
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].id).text(data[i].usertypeName)
				.appendTo('#edituserType');
			}
			$("#edituserType").val(result.usertypeId);
		});
		
		$("#editId").val(result.id);
		$("#editfirstName").val(result.firstName);
		$("#editmiddleName").val(result.middleName);
		$("#editlastName").val(result.lastName);
		$("#editcontactNumber").val(result.phoneNo);
		$("#editemailID").val(result.email);
		$("#editPassword").val(result.password);
		$("#EditconfirmPassword").val(result.password);
		$("#edituserName").val(result.userName);
		$("#edituserRemark").val(result.remarks);
		result.currentStatus == 5 ? $("#userStatus").val(0) : $("#userStatus").val(1)  
		//$("#editModifiedBy").val(result.approvedBy);
		result.approvedBy =="" || result.approvedBy==null ?  $("#editModifiedBy").val('NA'): $("#editModifiedBy").val(result.approvedBy);
		
		
		$("label[for='editfirstName']").addClass('active');
		$("label[for='editmiddleName']").addClass('active');
		$("label[for='editlastName']").addClass('active');
		$("label[for='editcontactNumber']").addClass('active');
		$("label[for='editemailID']").addClass('active');
		$("label[for='editPassword']").addClass('active');
		$("label[for='EditconfirmPassword']").addClass('active');
		$("label[for='edituserName']").addClass('active');
		$("label[for='edituserType']").addClass('active');
		$("label[for='edituserRemark']").addClass('active');
		$("label[for='editModifiedBy']").addClass('active');
		
	}

	/*---------------------------------- Update Field-------------------------------------*/
	
	
	function update(){
		
		var request ={ 
				"id" : parseInt($("#editId").val()),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"usertypeId" :  parseInt($("#edituserType").val()),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username"),
				"phoneNo": $('#editcontactNumber').val(),
				"email": $('#editemailID').val(),
				"remarks": $('#edituserRemark').val(),
				"currentStatus" : parseInt($('#userStatus').val())
		}
		
		//////console.log("request--->" +JSON.stringify(request))
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: './updateUser',
			type: 'POST',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {
				if(data.errorCode == 200){
				////console.log("Updated data---->" +data)
				
				$("#editCurrencyModal").closeModal();	
				$("#updateFieldsSuccess").openModal({
			        dismissible:false
			    });
				$.i18n().locale = window.parent.$('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					$('#updateFieldMessage').text($.i18n(data.tag));
				});
			}else{
				$.i18n().locale = window.parent.$('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					// $("#registrationForm #msg").text($.i18n(respData.tag));
					errorModal($.i18n(data.tag));
				});
			}	
			},
		});	
		
		return false
	}

	
	
  /*------------------------------------ Delete Field -----------------------------------*/
	
	

	function DeleteByID(id){
		
		window.id=parseInt(id);
		
		
		
		$("#DeleteFieldModal").openModal({
	        dismissible:false
	    });
		
	}
	
	function deleteModal(){
		
		var request ={ 
				"dataId" : parseInt(window.id),
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
			url: './deleteSystemUserType',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data, textStatus, xhr) {
				$("#DeleteFieldModal").closeModal();
				$("#closeDeleteModal").openModal({
			        dismissible:false
			    });
				$('#deleteModalText').text(data.message);
			},
			error : function() {
				
			}
		});
	
		return false;
	}
	
	function errorModal(message){
		fadetime=2000;
		$("#modalMessageBodyReg").empty();
		$("#modalMessageBodyReg").append(' <label id="success" style="color: red;font-size:14px;">'+message+'</label>');
		$('#error_Modal_reg').openModal();

		$('#error_Modal_reg').fadeIn().delay(fadetime).fadeOut();
		setTimeout(function() {
			$('#error_Modal_reg').closeModal();
		}, fadetime);
		
	}
	
	function exportUserManagementData(){
		var table = $('#userLibrarayTableDiv').DataTable();
		var info = table.page.info(); 
		var pageNo=info.page;
		var pageSize =info.length;
		
		if(sourceType='menu'){
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"usertypeId" : parseInt($('#userType').val()),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					//"username" : $("body").attr("data-selected-username"),
					"email" : $('#emailID').val(),
					"phoneNo" : $('#phone').val(),
					"username" :  $("body").attr("data-selected-username"),
					"filteredUsername" : $('#userName').val(),
					"pageNo":parseInt(pageNo),
					"pageSize":parseInt(pageSize)
			}		
		}else{
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"usertypeId" : parseInt($('#userType').val()),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					//"username" : $("body").attr("data-selected-username"),
					"email" : $('#emailID').val(),
					"phoneNo" : $('#phone').val(),
					"username" :  $("body").attr("data-selected-username"),
					"pageNo":parseInt(pageNo),
					"pageSize":parseInt(pageSize)
							
			}		
		}
		
		
		
		/*var filterRequest={
				"endDate":$('#endDate').val(),
				"startDate":$('#startDate').val(),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"usertypeId" : parseInt($('#userType').val()),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username"),
				"pageNo":parseInt(pageNo),
				"pageSize":parseInt(pageSize),
				"email" : $('#emailID').val(),
				"phoneNo" : $('#phone').val(),
				"username" :  $('#userName').val()==undefined || $('#userName').val()==null ? $("body").attr("data-selected-username") : $('#userName').val()
		}
		*/
		//console.log(JSON.stringify(filterRequest))
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		
		$.ajax({
			url: './exportUserManagementData',
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
			DataTable(lang,null);
	 }