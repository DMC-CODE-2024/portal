		var cierRoletype =$("body").attr("data-roleType");	
		var startdate=$('#startDate').val(); 
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="23";
		var rejectedMsg,consignmentApproved,errorMsg,havingTxnID,updateMsg,hasBeenUpdated;
		var consignmentDeleted,deleteInProgress;
		var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
		var action = $("body").attr("data-action"); 
		var url = new URL(window.location.href);
		url.searchParams.get("action")
		

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
			filterFieldTable(lang);
			sessionStorage.removeItem("session-value");
			pageRendering();
			
		 });
		

		$('.datepick').datepicker({
			dateFormat: "yy-mm-dd"
		});


		var sourceType =localStorage.getItem("sourceType");
		var TagId = sessionStorage.getItem("tagId");
		
		
		//**************************************************filter table**********************************************
		
		function filterFieldTable(lang){
			$('div#initialloader').fadeIn('fast');
			window.tag_val= $('#filterTagId').val() == undefined ? TagId : $('#filterTagId').val();
			if(window.tag_val=="" || window.tag_val==null){
				window.tag_val=TagId;
			}
			var displayName = $('#displayName').val() == "" ? "" : $('#displayName').val();
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"tag": window.tag_val,
					"userName" : $("body").attr("data-selected-username"),
					"displayName" : displayName,
					"description":$('#decriptionID').val(),
					"field":$('#fieldID').val()
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
				//url: 'headers?type=fieldManagement?lang='+lang+'&action='+action,
				url: 'headers?type=fieldManagement&lang='+lang+'&action='+action,
				/*	headers: {"Accept-Language": "en"},*/
				type: 'POST',
				dataType: "json",
				success: function(result){
					var table=	$("#fieldManagementLibraryTable").DataTable({
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
							url : 'fieldManagementData?action='+action,
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
						
					});
					/*if(url.searchParams.get("action") == 'viewAll'){
						$('#fieldManagementLibraryTable').DataTable().column(6).visible(false);
					}*/
					
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
				url: 'fieldManagement/pageRendering',
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
							$("#FieldTableDiv").append("<div class='input-field responsiveDiv'>"+
									"<div id='enddatepicker' class='input-group date'>"+
									"<label for='TotalPrice'>"+date[i].title
									+"</label>"+"<input class='form-control datepicker' type='text' id="+date[i].id+" autocomplete='off'>"+
									"<span	class='input-group-addon' style='color: #ff4081'>"+
									"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");
							$( "#"+date[i].id ).datepicker({
								dateFormat: "yy-mm-dd",
								 maxDate: new Date()
					        }); 	
						}
						 
						 else if(date[i].type === "text"){
								$("#FieldTableDiv").append("<div class='input-field'><input type="+date[i].type+" maxlength="+date[i].className+" id="+date[i].id+"><label for='parametername' class='center-align'>"+date[i].title+"</label></div>");
								
							}
							else if(date[i].type === "select"){

								var dropdownDiv=
									$("#FieldTableDiv").append("<div class='selectDropdwn'>"+
											
											"<div class='select-wrapper select2  initialized'>"+
											"<span class='caret'>"+"</span>"+
											"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

											"<select id="+date[i].id+" class='select2 initialized'>"+
											"<option value=''>"+date[i].title+"</option>"+
											"</select>"+
											"</div>"+
									"</div>");
							
							}
					} 
				
					// dynamic dropdown portion
				/*	var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#FieldTableDiv").append("<div class='col s6 m2 selectDropdwn'>"+
								
									"<div class='select-wrapper select2  initialized'>"+
									"<span class='caret'>"+"</span>"+
									"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

									"<select id="+dropdown[i].id+" class='select2 initialized'>"+
									"<option value ='-1' disabled selected>"+dropdown[i].title+
									"</option>"+
									"</select>"+
									"</div>"+
							"</div>");
					}*/

						$("#FieldTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
						$("#FieldTableDiv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>Clear all filters</button></div>");
						$("#FieldTableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportFieldData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						$('#clearFilter').attr("onclick", "filterResetFieldManagement('viewFilter')");
						for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							$('#'+button[i].id).attr("onclick", button[i].buttonURL);
						}
						
					/*	for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							if(button[i].type === "HeaderButton"){
								$('#'+button[i].id).attr("onclick", button[i].buttonURL);
							}
							
						}*/

				
					
				$('.datepicker').datepicker({
						dateFormat: "yy-mm-dd"
					});
				}
			}); 
			
			
			setDropdown();
			
			if(url.searchParams.get("action") == 'viewAll'){
				$("#btnLink").css("display", "none");
				
			}
			//$("#invoiceNumberDiv").css("display", "none");
	}


		
	function setDropdown(){
		var request ={
			  "userId" : parseInt($("body").attr("data-userID")),
			  "featureId":parseInt(featureId),
			  "userTypeId": parseInt($("body").attr("data-userTypeID")),
			  "userType":$("body").attr("data-roleType"),
			  "userName" : $("body").attr("data-selected-username")
		}
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: './getSystemTags',
			type: 'POST',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {
				var result = data.data;
				for (i = 0; i < result.length; i++){
					$('<option>').val(result[i].tag).text(result[i].displayName).appendTo('#tag,#filterTagId,#Edittag');
				}
				
			},
			error: function (jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			}
		});	
	}

		function AddField(){
			$('#addTags').openModal({
		        dismissible:false
		    });
			$('#tag').val(window.tag_val);	
			var tagDropDown =  document.getElementById("tag");
			var displayName = tagDropDown.options[tagDropDown.selectedIndex].text;
			$('#displayName').val(displayName);	
		}
		
	
	/*----------------------------------- Save Field ----------------------------------------- */
		
	function submitTag(){
		
		var request={
					  "displayName" : $('#displayName').val(),		
					  "interp": $('#addInterp').val(), 
					  "tag":   $('#tag').val(),
					  "tagId": $('#tagId').val(),
					  "value": $('#addValue').val(),
					  "description" : $('#description').val(),
					  "userId":parseInt(userId),
					  "featureId":parseInt(featureId),
					  "userTypeId": parseInt($("body").attr("data-userTypeID")),
					  "userType":$("body").attr("data-roleType"),
					  "username" : $("body").attr("data-selected-username")
				}
		
		//////console.log("request------------->" +JSON.stringify(request))
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : './add-Field',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data, textStatus, jqXHR) {
					////console.log(JSON.stringify(data));
					$("#confirmField").openModal({
				        dismissible:false
				    });
			},
			error : function(jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			}
		});
			
			return false
	}


  
	/*--------------------------------- Edit Model View -----------------------------------*/
	
	
	function FieldViewByID(tag,id){
			var Id = parseInt(id);
		
			var request ={
					  "id" : parseInt(Id),
					  "userId":parseInt(userId),
					  "userId":parseInt(userId),
					  "featureId":parseInt(featureId),
					  "userTypeId": parseInt($("body").attr("data-userTypeID")),
					  "userType":$("body").attr("data-roleType"),
					  "userName" : $("body").attr("data-selected-username")
				}
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.ajax({
				url: './fieldViewByID',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						var result = data.data
						$("#editTags").openModal({
					        dismissible:false
					    });
						FieldEditPopupData(result);
						////console.log(result)
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				}
			});	
		}
	
	
	function FieldEditPopupData(result){
		$("#editId").val(result.id);
		$("#Edittag").val(result.tag);
		$("#editdescription").val(result.description);
		$("#editInterp").val(result.interp);
		$("#editFieldId").val(result.tagId);
		$("#editdisplayName").val(result.displayName);
		result.modifiedBy =="" || result.modifiedBy==null ?  $("#editModifiedBy").val('NA'): $("#editModifiedBy").val(result.modifiedBy);
		//$("label[class='center-align']").addClass('active');
		$("label[for='editdescription']").addClass('active');
		$("label[for='editInterp']").addClass('active');
		$("label[for='editFieldId']").addClass('active');
		$("label[for='editModifiedBy']").addClass('active');
		
	}
	
	
	/*---------------------------------- Update Field-------------------------------------*/
	
	
	function updatedTag(){
	
		var request ={ 
		  "description": $("#editdescription").val(),
		  "displayName": $("#editdisplayName").val(),
		  "id": parseInt($("#editId").val()),
		  "interp": $("#editInterp").val(),
		  "tag": $("#Edittag").val(),
		  "tagId": $("#editFieldId").val(),
		  "userId":parseInt(userId),
		  "featureId":parseInt(featureId),
		  "userTypeId": parseInt($("body").attr("data-userTypeID")),
		  "userType":$("body").attr("data-roleType"),
		  "userName" : $("body").attr("data-selected-username"),
		  "username" : $("body").attr("data-selected-username")
           //"value":$("#editValue").val()
		}
		
		//////console.log("request--->" +JSON.stringify(request))
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: './updateSystemTags',
			type: 'PUT',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {
			
				////console.log("Updated data---->" +data)
				$("#editTags").closeModal();	
				$("#updateFieldsSuccess").openModal({
			        dismissible:false
			    });
				
			},
			error: function (jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			}
		});	
		
		return false
	}

	
	
  /*------------------------------------ Delete Field -----------------------------------*/
	
	
	function DeleteFieldRecord(id){
		$("#DeleteFieldModal").openModal({
	        dismissible:false
	    });
		$("#deleteFieldId").val(id);
		
	}	
	
	
	
	function confirmantiondelete(){
		var request ={
				"userId" : $("body").attr("data-userID"),
				"id"  : parseInt($("#deleteFieldId").val()),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"userName" : $("body").attr("data-selected-username")
		}
		//////console.log(JSON.stringify(request));
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		
		$.ajax({
			url : './deleteField',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'DELETE',
			success : function(data, textStatus, xhr) {
				////console.log(data);
				$("#DeleteFieldModal").closeModal();
				$("#closeDeleteModal").openModal({
			        dismissible:false
			    });
				
				$("#materialize-lean-overlay-3").css("display","none");
			},
			error : function() {
				////console.log("Error");
			}
		});
	}
	
	function resetFields(){
		$('#tagId').val("");
		$('#addInterp').val("");
		$('#description').val("");
		$("label[for='addFieldId']").removeClass('active');
		$("label[for='addInterp']").removeClass('active');
		$("label[for='description']").removeClass('active');
	}
	
	
	
	function exportFieldData(){
		var table = $('#fieldManagementLibraryTable').DataTable();
		var info = table.page.info(); 
		var pageNo=info.page;
		var pageSize =info.length;
		
		window.tag_val= $('#filterTagId').val() == undefined || $('#filterTagId').val() == '-1' ? TagId : $('#filterTagId').val();
		if(window.tag_val=="" || window.tag_val==null){
			window.tag_val=TagId;
		}
		var displayName = $('#displayName').val() == "" ? "" : $('#displayName').val();
		
	
		
		var filterRequest={
				"endDate":$('#endDate').val(),
				"startDate":$('#startDate').val(),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"tag": window.tag_val,
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userName" : $("body").attr("data-selected-username"),
				"pageNo":parseInt(pageNo),
				"pageSize":parseInt(pageSize),
				"displayName" : displayName,
				"description":$('#decriptionID').val(),
				"field":$('#fieldID').val()
		}
		
		//console.log(JSON.stringify(filterRequest))
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		
		$.ajax({
			url: './exportFieldData',
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
	
	
	 
	 /*$(document).on('change', '#filterTagId', function(){
		if($('#filterTagId').val() != '-1'){
			$("#submitFilter").prop('disabled', false);
		}else{
			$("#submitFilter").prop('disabled', true);
		}
	 });	*/
	
	function filterResetFieldManagement(formID){
		$('#'+formID).trigger('reset');
		$("label").removeClass('active');
		filterFieldTable();
	}