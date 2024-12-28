		var cierRoletype =$("body").attr("data-roleType");	
		var startdate=$('#startDate').val(); 
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="24";
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
			filterFieldTable(lang);
			sessionStorage.removeItem("session-value");
			pageRendering();
			
		 });
		

		var sourceType =localStorage.getItem("sourceType");
		var TagId = sessionStorage.getItem("tagId");
		
		
		//**************************************************filter table**********************************************
		
		function filterFieldTable(lang){
			$('div#initialloader').fadeIn('fast');
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"port" : parseInt($("#portType").val()),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"username" : $("body").attr("data-selected-username"),
					"address" : $('#portAdress').val()
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
				url: 'headers?type=portManagement&lang='+lang,
				/*	headers: {"Accept-Language": "en"},*/
				type: 'POST',
				dataType: "json",
				success: function(result){
					var table=	$("#portManagementLibraryTable").DataTable({
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
							url : 'portManagementData',
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
				url: 'portManagement/pageRendering',
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
								$("#PortTableDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#PortTableDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");
						
					}
					
					
				} 
				
				var dropdown=data.dropdownList;
						for(i=0; i<dropdown.length; i++){
							var dropdownDiv=
								$("#PortTableDiv").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+dropdown[i].id+">"+dropdown[i].title+"</label>"+
										"<select id="+dropdown[i].id+"  class='form-control'>"+
										"<option value='' selected>"+dropdown[i].title+
										"</option>"+
										"</select>"+
										"</div>"+
								"</div>");
						} 
			
			var viewFilter="viewFilter";
			$("#PortTableDiv").append("<div class='form-group'><button type='button' class='btn btn-light' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
			$("#PortTableDiv").append("<div class='form-group'><button type='button' class='btn btn-primary' id='submitFilter'><span><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></span></button></div>");
			$("#PortTableDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportCustomPortData()'>"+$.i18n('Export')+"<img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
					    
			//$("#PortTableDiv").append("<div class=' col s3 m2 l1'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
			//$("#PortTableDiv").append("<div class=' col s3 m2 l2'><button type='button' class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
			//$("#PortTableDiv").append("<div class=' col s3 m2 l1'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportCustomPortData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						$('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");
						for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							$('#'+button[i].id).attr("onclick", button[i].buttonURL);
						}

	
				}
			}); 
			
			
			setDropdown();
	}

	
		function exportCustomPortData(){
			var table = $('#portManagementLibraryTable').DataTable();
			var info = table.page.info(); 
			var pageNo=info.page;
			var pageSize =info.length;
			
			
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"port" : parseInt($("#portType").val()),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"username" : $("body").attr("data-selected-username"),
					"pageNo":parseInt(pageNo),
					"pageSize":parseInt(pageSize),
					"address" : $('#portAdress').val()
			}
			
			console.log(JSON.stringify(filterRequest))
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			
			$.ajax({
				url: './exportCustom',
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

		
	function setDropdown(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.getJSON('./getDropdownList/CUSTOMS_PORT', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interp)
				.appendTo('#port,#portType,#editport');
			}
		});
	}

		function AddPortAddress(){
			$('#addPort').openModal({
		        dismissible:false
		    });
			//var tagDropDown =  document.getElementById("tag");
			//var displayName = tagDropDown.options[tagDropDown.selectedIndex].text;
		}
		
	
	/*----------------------------------- Save Field ----------------------------------------- */
		
	function submitPort(){
		
		var request={
				"port":   $('#port').val(),
				"address": $('#portAddress').val(),
				"userId": parseInt(userId),
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
			url : './add-Port',
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
	
	
	function PortViewByID(id){
		$("#editId").val(id);
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
				url: './portViewByID',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						var result = data.data
						$("#editPortAddressModal").openModal({
					        dismissible:false
					    });
						PortEditPopupData(result);
						//////console.log(result)
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				}
			});	
		}
	
	
	function PortEditPopupData(result){
		$("#editport").val(result.port);
		$("#editId").val(result.id);
		$("#editportAddress").val(result.address);
		result.approvedBy =="" || result.approvedBy==null ?  $("#editmodifiedBy").val('NA'): $("#editmodifiedBy").val(result.approvedBy);
		$("label[for='editportAddress']").addClass('active');
		$("label[for='editmodifiedBy']").addClass('active');
		
		
	}
	
	
	/*---------------------------------- Update Field-------------------------------------*/
	
	
	function updatedPort(){

		var request ={ 
				"id" : parseInt($("#editId").val()),
				"port":   $('#editport').val(),
				"address": $('#editportAddress').val(),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username")
		}

		//////console.log("request--->" +JSON.stringify(request))
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: './updatePortAddress', 
			type: 'POST',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {

				////console.log("Updated data---->" +data)
				$("#editPortAddressModal").closeModal();	
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
	
	
	function DeletePortRecord(id){
		$("#DeleteFieldModal").openModal({
			dismissible:false
		});
		$("#deletePortId").val(id);

	}	
	
	
	
	function confirmantiondelete(){
		var request ={ 
				"dataId" : parseInt($("#deletePortId").val()),
				"port":   $('#editport').val(),
				"address": $('#editportAddress').val(),
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
			url : './deletePort',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
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
	 $('#port').val('');
	 $('#portAddress').val('');
	 $("label[for='portAddress']").removeClass('active');
	 
 }	

 function Resetfilter(formID){
		$('#'+formID).trigger('reset');
		$("label").removeClass('active');
		filterFieldTable(lang,null);
 }