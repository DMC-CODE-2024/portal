	var cierRoletype = sessionStorage.getItem("cierRoletype");
	var featureId = 8;
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var currentRoleType = $("body").attr("data-selected-roleType"); 
	var startdate=$('#startDate').val(); 
	var endDate=$('#endDate').val();

	var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';


	$.i18n().locale = lang;	

	$.i18n().load( {
		'en': './resources/i18n/en.json',
		'km': './resources/i18n/km.json'
	} ).done( function() {
		
	});

	$(document).ready(function(){
		$('div#initialloader').fadeIn('fast');
		registrationDatatable(lang,null);
		pageRendering();
		
	});

	var role = currentRoleType == null ? roleType : currentRoleType;


	//**************************************************Registration table**********************************************

	function registrationDatatable(lang,source){
		$('div#initialloader').fadeIn('fast');
		var source__val;
		
		var filteredUsername = $("body").attr("session-valuetxnid") == "null" ? $('#userName').val() : $("body").attr("session-valuetxnid");
		
		if($('#endDate').val()=='' && $('#startDate').val()=='' && $('#userName').val()=='' && $('#emailID').val()=='' && $('#phone').val()=='' && $('#asType').val()=='-1' && $('#role').val()=='-1' && $('#recentStatus').val()=='-1'){
			source__val= "menu";
			//alert("4");
		}
		else if(source == 'filter' ) {
			source__val= source;
			$("body").attr("data-session-source","filter");
			//alert("1");
		}else if((source=='clearAll') && ($("body").attr("data-session-source")=='noti')){
			filteredUsername = $('#userName').val();
			source__val= "menu";
			//alert("2" +$("body").attr("data-session-source"));
		}
		else if(source=='clearAll'){
			source__val= "menu";
			//alert("3" +$("body").attr("data-session-source"));
		} 
		else{
			source__val= "menu";
			//alert("5");
			//alert("4" +$("body").attr("data-session-source"));
}
		
		var asType = $('#asType').val();
		var userRoleTypeId = $("#role").val();
		var status =  $('#recentStatus').val();
		var userID= (txnIdValue == 'null' && transactionIDValue == undefined)? transactionIDValue : transactionIDValue;
			
		
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"asType": parseInt(asType),
					"userRoleTypeId" : parseInt(userRoleTypeId),
					"status" : parseInt(status),
					"userId":parseInt(userID),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"email" : $('#emailID').val(),
					"phoneNo" : $('#phone').val(),
					//"username" : $('#userName').val() == "" || $('#userName').val() == undefined ? $("body").attr("data-selected-username") : $('#userName').val()
					"username" :  $("body").attr("data-selected-username"),
					"filteredUsername" : filteredUsername
				}

		console.log("Request"+JSON.stringify(filterRequest));

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
		
		////console.log("source__val in filter request------>" +source__val);
		$.ajax({
			url: 'headers?type=adminRegistration&lang='+lang,
			type: 'POST',
			dataType: "json",
			success: function(result){
				/*////console.log("Url-------" +url+"--------"+ "dataUrl-------" +dataUrl);*/
				var table=	$("#registrationLibraryTable").DataTable({
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
						url : 'registrationData?source='+source__val,
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



	//**************************************************Registration page buttons**********************************************

	function pageRendering(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: 'registration/pageRendering',
			type: 'POST',
			dataType: "json",
			success: function(data){
				data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );


				//var elem='<p class="PageHeading">'+data.pageTitle+'</p>';		
				var elem='<h1>'+data.pageTitle+'<h1>';	
				$("#pageHeader").append(elem);
				var button=data.buttonList;

				var date=data.inputTypeDateList;
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){  
								$("#registrationTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#registrationTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");
						
					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#registrationTableDiv").append(
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
				$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportButton()'>"+$.i18n('Export')+"<img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
				
				//$("#registrationTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
				//$("#registrationTableDiv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
				//$("#registrationTableDiv").append("<div class='filter_btn'><a onclick='exportButton()' type='button' class='export-to-excel right'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
				$('#clearFilter').attr("onclick", "Resetfilter('registrationfilterform')");
				
				for(i=0; i<button.length; i++){
					$('#'+button[i].id).text(button[i].buttonTitle);
					$('#'+button[i].id).attr("onclick", button[i].buttonURL);
				
				}
				
			
			
				cierRoletype=="CEIRAdmin"? $("#btnLink").css({display: "none"}) : $("#btnLink").css({display: "block"});
				/*sourceType=="viaStolen" ? $("#btnLink").css({display: "none"}) : $("#btnLink").css({display: "none"});*/
			
				
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
		$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-userTypeID"), function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].state).text(data[i].interp)
				.appendTo('#recentStatus,#userStatus');
			}
		});
		

		$.getJSON('./registrationUserType?type=1', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].id).text(data[i].usertypeName)
				.appendTo('#role');
			}
		});
		
		
		$.getJSON('./getSourceTypeDropdown/AS_TYPE/'+featureId+'', function(data) {
			for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#asType');
			}
		});
		
	}


	function myFunction(message) {
		var x = document.getElementById("snackbar");
		x.className = "show";
		$('#errorMessage').html(message);
		setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}

	function dispatchDateValidation(){
		var currentDate;
		var dispatcDate=  $('#expectedDispatcheDate').val();
		var now=new Date();
		if(now.getDate().toString().charAt(0) != '0'){
			currentDate='0'+now.getDate();

			/* //alert("only date="+currentDate); */
		}
		else{
			currentDate=now.getDate();
		}
		var today = now.getFullYear()+ '-' + (now.getMonth()+1)+ '-' +currentDate ;
		////alert("today"+today);
		//////console.log("dispatche="+dispatcDate);
		//////console.log("todays parse date"+Date.parse(today));
		//////console.log("dispatche parse date"+Date.parse(dispatcDate));


		if(Date.parse(today)>Date.parse(dispatcDate))
		{
			myFunction("dispatche date should be greater then or equals to today");
			$('#expectedDispatcheDate').val("");
		}

		////alert("current date="+today+" dispatche date="+dispatcDate)
	}

	function arrivalDateValidation(){
		var currentDate;
		var dispatcDate=  $('#expectedArrivalDate').val();
		var now=new Date();
		if(now.getDate().toString().charAt(0) != '0'){
			currentDate='0'+now.getDate();

			/* //alert("only date="+currentDate); */
		}
		else{
			currentDate=now.getDate();
		}
		var today = now.getFullYear()+ '-' + (now.getMonth()+1)+ '-' +currentDate ;
		////alert("today"+today);
		//////console.log("dispatche="+dispatcDate);
		//////console.log("todays parse date"+Date.parse(today));
		//////console.log("dispatche parse date"+Date.parse(dispatcDate));


		if(Date.parse(today)>Date.parse(dispatcDate))
		{
			myFunction("Arrival date should be greater then or equals to today");
			$('#expectedArrivalDate').val("");
		}
		////alert("current date="+today+" dispatche date="+dispatcDate)
	}

	$('.datepicker').on('mousedown',function(event){
		event.preventDefault();
	});



	function userApprovalPopup(Id,date,username,sessionUserName){
		$("#registrationTxnId").text(username);
		$("#sessionUserName").val(sessionUserName);
		$('#approveInformation').openModal({
		 	   dismissible:false
	    });
		$("#userId").text(Id);
		window.ID=Id;
		window.userName = username
		window.date=date.replace("="," ");
	}




	function aprroveUser(){
		var id= $("#userId").text();
	
		var approveRequest={
				"id": parseInt(id),
				"status" : "Approved",
				"remark": $("#Reason").val(),	
				"featureId" : parseInt(featureId),
				"statusValue" : 3,
				"username" : $("#sessionUserName").val(),
				"userId" : parseInt(userId),
				"registeredUserId":window.userName
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : './adminApproval',
			data : JSON.stringify(approveRequest),
			dataType : 'json',
			'async' : false,
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data) {
				//////console.log("approveRequest----->"+JSON.stringify(approveRequest));
				confirmApproveInformation(window.ID,window.date);
			},
			error : function() {
				////alert("Failed");
			}
		});
	}

	function confirmApproveInformation(ID,date){
		$('#approveInformation').closeModal(); 
		setTimeout(function(){ $('#confirmApproveInformation').openModal({
		 	   dismissible:false
	    });}, 200);
		$("#registrationDate").text(date);
		$("#RegistrationId").text(window.userName);
	}

	function userRejectPopup(Id,sessionUserName,username){
		window.registeredUserReject=username;
		$('#rejectInformation').openModal({
		 	   dismissible:false
	    });
		//console.log("Reject userId is---->"+Id);
		$("#userId").text(Id)
		$("#rejectUserName").val(sessionUserName);
		$('#Reason').val("");
		$("label").removeClass('active');
	}


	function rejectUser(userId){
		var id= $("#userId").text();
		var rejectRequest={
				"id": parseInt(id),
				"status" : "Rejected",
				"remark": $("#Reason").val(),
				"featureId" : parseInt(featureId),
				"statusValue" : 4,
				"username" : $("#rejectUserName").val(),
				"userId" : parseInt($("body").attr("data-userID")),
				"registeredUserId":window.registeredUserReject
				
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : './adminApproval',
			data : JSON.stringify(rejectRequest),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data) {
			   //////console.log("rejectRequest----->"+JSON.stringify(rejectRequest));
				confirmRejectInformation();
			},
			error : function() {
				//alert("Failed");
			}
		});
		
		return false;
		
	}

	function confirmRejectInformation(){
		$('#rejectInformation').closeModal();
		$('#confirmRejectInformation').openModal({
		 	   dismissible:false
	    });
	}

	function exportButton(){
		var startdate=$('#startDate').val(); 
		var endDate=$('#endDate').val();
		var emailId = $('#emailID').val();
		var phone = $('#phone').val();
		var filteredUsername = $("body").attr("session-valuetxnid") == "null" ? $('#userName').val() : $("body").attr("session-valuetxnid");
		var asType =  $('#asType').val();
		var userRoleTypeId =  $("#role").val();
		var status =  $('#recentStatus').val();
		var featureId = 8;
		var usertypeId= parseInt($("body").attr("data-usertypeid"));
		var userId = $("body").attr("data-userID");
		var table = $('#registrationLibraryTable').DataTable();
		var info = table.page.info(); 
		var pageNo=info.page;
		var pageSize =info.length;
		var username = $("body").attr("data-selected-username");
		
		
		var userID= (txnIdValue == 'null' && transactionIDValue == undefined)? -1 : -1;
		
		var source;
		if(startdate != "" || endDate != "" || emailId !="" || phone != '' || filteredUsername != "" || asType != "-1" ||  userRoleTypeId != "-1" || status != "-1"  ){
			source = "filter"
			window.location.href="./exportAdminRegistration?RegistrationStartDate="+startdate+"&RegistrationEndDate="+endDate+"&email="+emailId+"&phoneNo="+phone+"&username="+username+"&filteredUsername="+filteredUsername+"&asType="+asType+"&userRoleTypeId="+userRoleTypeId+"&featureId="+featureId+"&status="+status+"&source="+source+"&pageSize="+pageSize+"&pageNo="+pageNo+"&userTypeId="+usertypeId+"&userId="+userID+"";	
		}else{
			source =$("body").attr("data-session-source");
			//var username =  $("body").attr("data-selected-username");
			//var username =  $("body").attr("session-valuetxnid") == "null" ? $('#userName').val() : $("body").attr("session-valuetxnid")
			window.location.href="./exportAdminRegistration?RegistrationStartDate="+startdate+"&RegistrationEndDate="+endDate+"&email="+emailId+"&phoneNo="+phone+"&username="+username+"&filteredUsername="+filteredUsername+"&asType="+asType+"&userRoleTypeId="+userRoleTypeId+"&featureId="+featureId+"&status="+status+"&source="+source+"&pageSize="+pageSize+"&pageNo="+pageNo+"&userTypeId="+usertypeId+"&userId="+userID+"";
			
		}
		
		
	
		////console.log ("source--->" +source);
		
		
	}


	function previewFile(srcFilePath,srcFileName){

		window.filePath = srcFilePath;
		window.fileName = srcFileName;
		window.fileExtension = fileName.replace(/^.*\./, '');
		window.FinalLink = filePath.concat(fileName);

		if(filePath == null || filePath == "" || filePath == undefined && fileName == null || fileName == "" || fileName == undefined ){
			//////console.log("File is not Avialable")
		}else if(fileExtension=="jpg" || fileExtension=="jpeg" || fileExtension=="png" || fileExtension=="gif" ){
			$("#fileSource").attr("src",FinalLink);
			$("#viewuplodedModel").openModal();
		}else{
			window.open(FinalLink);
		}
	}
	

function roleStatusChange(Id,sessionUserName, userTypeId, tableId,username){
		
	    window.Id = Id,
	    window.sessionUserName = sessionUserName,
	    window.userTypeId = userTypeId, 
	    window.tableId = tableId,
	    window.registeredUser=username;
	    
	   
	   //usertypeData2(userTypeId);
	    
	    $("#statusRoleChange").openModal({
	    	dismissible:false
	    });

	    if(userTypeId == "4" || userTypeId == "5" || userTypeId == "6"){
	    	$('input[name=group2]').attr("disabled", false);
	    }else{
	    	$('input[name=group2]').attr("disabled",true);
	    }
	}
	 	




function userChangeStatus(entity){
	if (entity == "status"){
		 $("#statusChangemodal").openModal({
		 	   dismissible:false
		    });
	}else{
		$("#roleTypeChangemodal").openModal({
		 	   dismissible:false
		    });
	}
}

 function resetButtons(){
	 $('input[name=group1]').attr('checked',false);
	 $('input[name=group2]').attr('checked',false);
 }
	
 $('#addDeleteRole').on(
		 'change',
		 function() {
			 	var request = {
							"action" : parseInt($('#addDeleteRole').val()),
							"dataId" : parseInt(window.Id),
							"featureId" : parseInt(featureId),
							"userId" : parseInt(userId),
							"userType" : $("body").attr("data-roleType"),
							"userTypeId" : parseInt($("body").attr("data-userTypeID")),
							"username" : $("body").attr("data-selected-username")
						}
			 		//////console.log(JSON.stringify(request));	
			 	var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
			 		$.ajax({
							url : './getAddDeleteRoles',
							type : 'POST',
							data : JSON.stringify(request),
							dataType : 'json',
							contentType : 'application/json; charset=utf-8',
							success : function(data, textStatus, jqXHR) {
								if(data.errorCode == 200){
								$.i18n().locale = lang;	
								$.i18n().load( {
									'en': './resources/i18n/en.json',
									'km': './resources/i18n/km.json'
								}).done( function() {
									var result = data.data;
									////console.log("result---> " + JSON.stringify(result));
									$("#usertypes").empty();
									for (i = 0; i < result.length; i++) {
										$('<option>').val(result[i].id).text(
												result[i].usertypeName).appendTo(
												'#usertypes');
									}
								});
								}else{
									$("#ErrorModel").openModal({
									 	   dismissible:false
								    });
									$('#ErrorFieldMessage').text($.i18n(data.tag));
								}
								

							},
							error : function(jqXHR, textStatus, errorThrown) {
								//////console.log("error in ajax")
							}
						});
		});

	
 function chanegeRole(){
	 	if($('#addDeleteRole').val() == 1){
	 		action = 1;
	 	}else if($('#addDeleteRole').val() == 2){
	 		action = 2;
	 	}
	 	//var fileData = [];
	 	//var selectedRoleType = $('#usertypes').val();
	 	//var RoleType=fileData.push(selectedRoleType);
	 	
	 	var RoleType = $('#usertypes').val();
	 	var status= $("#userStatus").val();
	 	
	 	var Request={
				"action" : action,
				"id": parseInt(window.Id),
				"username" : $("body").attr("data-selected-username"),
				"referenceId" : $("#RoleRefererenceId").val(),
				"remark" : $("#changeRoleRemark").val(),
				"userId" : parseInt(userId),
				"role"  : parseInt(RoleType),
				"usertype": parseInt(window.userTypeId),
				"registeredUserId":window.registeredUser
	 		}
				
		
		//////console.log("Request-->"+JSON.stringify(Request));
	 	var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : './adminChangeRequest',
			data : JSON.stringify(Request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data) {
				$("#confirmUserStatus").openModal({
				 	   dismissible:false
			    });
				if(data.errorCode == 200){
					$.i18n().locale = lang;	
					$.i18n().load( {
						'en': './resources/i18n/en.json',
						'km': './resources/i18n/km.json'
					}).done( function() {
						$('#statusChangedMessage').text($.i18n(data.tag));
					});
					}else{
						$('#statusChangedMessage').text($.i18n(data.tag));
					}
				
				
			},
			error : function() {
				//alert("Failed");
			}
		});
	 return false
 }
 
 function chanegeUserStatus(){
	 	var action = 0;
	 	
	 	//var fileData = [];
	 	//var selectedRoleType = $('#usertypes').val();
	 	//var RoleType=fileData.push(selectedRoleType);
	 	
	 	var RoleType = $('#usertypes').val();
	 	var status= $("#userStatus").val();
	 	
	 	var Request={
				"action" : action,
				"status" : parseInt(status),
				"id": parseInt(window.Id),
				"username" : $("body").attr("data-selected-username"),
				"referenceId" : $("#statusrefererenceId").val(),
				"remark" : $("#changeStatusRemark").val(),
				"userId" : parseInt(userId),
				"usertype": parseInt(window.userTypeId),
				"registeredUserId":window.registeredUser
	 		}
				
		
		//////console.log("Request-->"+JSON.stringify(Request));
	 	var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : './adminChangeRequest',
			data : JSON.stringify(Request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data) {
				$("#confirmUserStatus").openModal({
				 	   dismissible:false
			    });
				if(data.errorCode == 200){
					$.i18n().locale = lang;	
					$.i18n().load( {
						'en': './resources/i18n/en.json',
						'km': './resources/i18n/km.json'
					}).done( function() {
						$('#statusChangedMessage').text($.i18n(data.tag));
					});
					}else{
						$('#statusChangedMessage').text($.i18n(data.tag));
					}
				
				
			},
			error : function() {
				//alert("Failed");
			}
		});
	 return false
}	
 
 
 
 
 
 function chngeView(id,role,type,source,username){
	
	 var UserID=$("body").attr("session-valuetxnid");
	 window.location.href="trcInformation?id="+id+"&roles="+role+"&type="+type+"&source="+source+"&username="+username+"";

 }
 
 
  
 var registraionHistoryTable;
 function historyRecord(txnID,userType,username){
	  
		$("#tableOnModal").openModal({dismissible:false});
		var filter =[];
		var formData= new FormData();
		var ceirAdmin='';
		var userTypeValue=$("body").attr("data-roleType");
		
		
		
		
			var filterRequest={

					"columns": [
						"created_on","modified_on","first_name","last_name","email","phone_no","username","current_status"
						],
						"tableName": "users_aud_user_profile",
						"dbName" : "ceir",
						"userid":txnID,
						"txnId":txnID,
						"featureId":8,
						"newTxnID":username
			}
			
		
			/*var filterRequest={

					"columns": [
						"CREATED_ON","MODIFIED_ON","FIRST_NAME","MIDDLE_NAME","LAST_NAME","TYPE","EMAIL","PHONE_NO","PROPERTY_LOCATION","STREET",
						"VILLAGE","LOCALITY","DISTRICT","COMMUNE","POSTAL_CODE","COUNTRY","PROVINCE",
						"VAT_NO","VAT_FILENAME","VAT_STATUS","PORT_ADDRESS","ARRIVAL_PORT","PASSPORT_NO",
						"NID_FILENAME","COMPANY_NAME","NATURE_OF_EMPLOYMENT","EMPLOYEE_ID","AUTHORITY_EMAIL","AUTHORITY_NAME","AUTHORITY_PHONE_NO",
						"OPERATOR_TYPE_ID","OPERATOR_TYPE_NAME","DISPLAY_NAME"
						],
						"tableName": "user_profile_aud",
						"dbName" : "ceirconfig",
						"userid":txnID,
						"txnId":txnID
			}*/
		
			

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
		
		
		if( registraionHistoryTable !== null && registraionHistoryTable !== undefined ){
			//console.log('Going to destroy history table');
			registraionHistoryTable.destroy();
			$('#registration-data-table-history').empty();
		}
		$.ajax({
			url: './Consignment/consignment-history',
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function(result){
				var dataObject = eval(result);
				////alert(JSON.stringify(dataObject.data))
				registraionHistoryTable = $('#registration-data-table-history').DataTable({
					"order" : [[1, "asc"]],
					destroy:true,
					"serverSide": false,
					orderCellsTop : true,
					"ordering" : false,
					"bPaginate" : true,
					"bFilter" : false,
					"bInfo" : true,
					"scrollX": true,
					"oLanguage": {  
						"sUrl": langFile  
					},
					"scrolly": true,
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
 
 function Resetfilter(formID){
	 $('#endDate').css('border-color', '');
	 $('#errorMsg').text('');
		$('#'+formID).trigger('reset');
		$("label").removeClass('active');
		registrationDatatable(lang,'clearAll');
	}