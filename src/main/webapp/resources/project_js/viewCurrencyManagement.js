		var cierRoletype =$("body").attr("data-roleType");	
		var startdate=$('#startDate').val(); 
		var endDate=$('#endDate').val();
		var taxStatus=$('#taxPaidStatus').val();
		var txnId=$('#transactionID').val();
		var consignmentStatus=$('#filterConsignmentStatus').val();
		var userId = $("body").attr("data-userID");
		var userType=$("body").attr("data-roleType");
		var featureId="25";
		var rejectedMsg,consignmentApproved,errorMsg,havingTxnID,updateMsg,hasBeenUpdated;
		var consignmentDeleted,deleteInProgress;
		var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';


		
		
		

         $(window).load(function(){
			$('div#initialloader').fadeIn('fast');
			currencyFieldTable(lang,null);
			sessionStorage.removeItem("session-value");
			pageRendering();
			
		 });
		

		$('.datepick').datepicker({
			dateFormat: "yy-mm-dd"
		});


		var sourceType =localStorage.getItem("sourceType");
		var TagId = sessionStorage.getItem("tagId");
		
		
		//**************************************************filter table**********************************************
		
		function currencyFieldTable(lang,source){
			$('div#initialloader').fadeIn('fast');
			var source__val;
			if(source == 'filter') {
				source__val= source;
				$("body").attr("data-session-source","filter");
			}
			else{
				source__val = $("body").attr("data-session-source");
				
			}
			var filterRequest={
					"endDate":$('#endDate').val(),
					"startDate":$('#startDate').val(),
					"currency" : parseInt($("#currencyType").val()),
					"year" : parseInt($('#year').val()),
					"userId":parseInt(userId),
					"featureId":parseInt(featureId),
					"userTypeId": parseInt($("body").attr("data-userTypeID")),
					"userType":$("body").attr("data-roleType"),
					"username" : $("body").attr("data-selected-username"),
					"month" : parseInt($('#filterMonth').val()),
					"riel" :  parseFloat($('#filterCambodian').val()),
					"dollar" :	parseFloat($('#filterdoller').val())
					
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
				url: 'headers?type=currencyHeaders&lang='+lang,
				/*	headers: {"Accept-Language": "en"},*/
				type: 'POST',
				dataType: "json",
				success: function(result){
					var table=	$("#currencyManagementLibraryTable").DataTable({
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
							url : 'currencyManagementData?source='+source__val,
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
				url: 'currencyManagement/pageRendering',
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
							$("#CurrencyTableDiv").append("<div class='input-field'>"+
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
							$("#CurrencyTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='19' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						}
						 
					} 
				
				// dynamic dropdown portion
					var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#CurrencyTableDiv").append("<div class='selectDropdwn'>"+
								
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
						var viewFilter="viewFilter";
						$("#CurrencyTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
						$("#CurrencyTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
						$("#CurrencyTableDiv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportCurrencyData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
						$('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");
						for(i=0; i<button.length; i++){
							$('#'+button[i].id).text(button[i].buttonTitle);
							$('#'+button[i].id).attr("onclick", button[i].buttonURL);
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
		$.getJSON('./getDropdownList/CURRENCY', function(data) {
				/ $("#expectedArrivalPort").empty(); /
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp).appendTo('#currencyType,#currency,#editCurrency');
				}
			});
	
		$.getJSON('./getDropdownList/Year', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interp).appendTo('#year,#addYear,#editYear');
			}
		});
		
		$.getJSON('./getDropdownList/Month', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interp).appendTo('#addMonth,#editMonth,#filterMonth');
			}
		});
	}

		function AddCurrencyAddress(){
			$('#addCurrency').openModal({
		        dismissible:false
		    });
			
			//var tagDropDown =  document.getElementById("tag");
			//var displayName = tagDropDown.options[tagDropDown.selectedIndex].text;
		}
		
		$(document).on('change', '#currency', function(){
			 $('#currency').val()== 0 ? $("#currencyDiv").css("display", "none") && $("#dollar").attr("required", false) : $("#currencyDiv").css("display", "block") && $("#dollar").attr("required", true);
		});	
	
	/*----------------------------------- Save Field ----------------------------------------- */
		
	function submitPort(){
		
		var request={
				
				"month" : $('#addMonth').val(),
				"year" : $('#addYear').val(),
				"currency": $('#currency').val(),
				"riel":   parseFloat($('#cambodianRiel').val()),
				"dollar": parseFloat($('#dollar').val()),
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
			url : './add-currency',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data, textStatus, jqXHR) {
					$("#confirmField").openModal({
				        dismissible:false
				    });
					$.i18n().locale = lang;	
					$.i18n().load( {
						'en': './resources/i18n/en.json',
						'km': './resources/i18n/km.json'
					} ).done( function() { 
						if(data.errorCode==200){
							$('#sucessMessage').text('');
							$('#sucessMessage').text($.i18n('Curr_Save_Sucess'));
						}else if(data.errorCode==3){
							$('#sucessMessage').text('');
							$('#sucessMessage').text($.i18n('Curr_Already_Exist'));
						}else if(data.errorCode==1){
							$('#sucessMessage').text('');
							$('#sucessMessage').text($.i18n('Curr_Year_Null'));
						}else if(data.errorCode==2){
							$('#sucessMessage').text('');
							$('#sucessMessage').text($.i18n('Curr_Month_Null'));
						}else if(data.errorCode==500){
							$('#sucessMessage').text('');
							$('#sucessMessage').text($.i18n('Curr_Save_Fail'));
						}
					});
					
				
			},
			error : function(jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			}
		});
			
			return false
	}


  
	/*--------------------------------- Edit Model View -----------------------------------*/
	
	
	function currencyViewByID(id){
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
				url: './currencyViewByID',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data, textStatus, jqXHR) {
						var result = data.data
						$("#editCurrencyModal").openModal({
					        dismissible:false
					    });
						currencyEditPopupData(result);
						//////console.log(JSON.stringify(result));
				},
				error: function (jqXHR, textStatus, errorThrown) {
					////console.log("error in ajax")
				}
			});	
		}
	
	
	function currencyEditPopupData(result){
		$("#editId").val(result.id);
		$("#editMonth").val(result.month);
		$("#editYear").val(result.year);
		$("#editCurrency").val(result.currency);
		$("#editCambodianRiel").val(result.riel);
		$("#editDollar").val(result.dollar);
		result.modifiedBy =="" || result.modifiedBy==null ?  $("#editmodifiedBy").val('NA'): $("#editmodifiedBy").val(result.modifiedBy);
		
		$('#editCurrency').val()== "0" ? $("#editcurrencyDiv").css("display", "none") && $("#editDollar").attr("required", false) : $("#editcurrencyDiv").css("display", "block") && $("#editDollar").attr("required", true);
		 
		$("label[for='editMonth']").addClass('active');
		$("label[for='editYear']").addClass('active');
		$("label[for='editCurrency']").addClass('active');
		$("label[for='editCambodianRiel']").addClass('active');
		$("label[for='editDollar']").addClass('active');
		$("label[for='editmodifiedBy']").addClass('active');
		
		$("#currency").val() == "0"
	}
	
	
	/*---------------------------------- Update Field-------------------------------------*/
	
	
	function updateCurrency(){
		
		var request ={ 
				"id" : parseInt($("#editId").val()),
				"month" : $('#editMonth').val(),
				"year" : $('#editYear').val(),
				"currency": $('#editCurrency').val(),
				"riel":   parseFloat($('#editCambodianRiel').val()),
				"dollar": parseFloat($('#editDollar').val()),
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
		//////console.log("request--->" +JSON.stringify(request))
		$.ajax({
			url: './updateCurrency',
			type: 'POST',
			data : JSON.stringify(request),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {
				$("#editCurrencyModal").closeModal();	
				$("#updateFieldsSuccess").openModal({
			        dismissible:false
			    });
				$.i18n().locale = lang;	
				$.i18n().load( {
					'en': './resources/i18n/en.json',
					'km': './resources/i18n/km.json'
				} ).done( function() { 
					if(data.errorCode==200){
						$('#updateFieldMessage').text('');
						$('#updateFieldMessage').text($.i18n('Curr_Update_Sucess'));
					}else if(data.errorCode==1){
						$('#updateFieldMessage').text('');
						$('#updateFieldMessage').text($.i18n('Curr_Year_Null'));
					}else if(data.errorCode==2){
						$('#updateFieldMessage').text('');
						$('#updateFieldMessage').text($.i18n('Curr_Month_Null'));
					}else if(data.errorCode==3){
						$('#updateFieldMessage').text('');
						$('#updateFieldMessage').text($.i18n('Curr_Already_Exist'));
					}else if(data.errorCode==500){
						$('#updateFieldMessage').text('');
						$('#updateFieldMessage').text($.i18n('Curr_Update_Fail'));
					}

				});
			},
			error: function (jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			}
		});	
		
		return false
	}


	function resetFields(){
		$('#addMonth').val("");
		$('#addYear').val("");
		$('#currency').val("");
		$('#cambodianRiel').val("");
		$('#dollar').val("");
		$("label[for='number']").removeClass('active');
		$("label[for='cambodianRiel']").removeClass('active');
	}
	
	function exportCurrencyData(){
		var table = $('#currencyManagementLibraryTable').DataTable();
		var info = table.page.info(); 
		var pageNo=info.page;
		var pageSize =info.length;
		
		var filterRequest={
				"endDate":$('#endDate').val(),
				"startDate":$('#startDate').val(),
				"currency" : parseInt($("#currencyType").val()),
				"year" : parseInt($('#year').val()),
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username"),
				"pageNo":parseInt(pageNo),
				"pageSize":parseInt(pageSize),
				"month" : parseInt($('#filterMonth').val()),
				"riel" :  parseFloat($('#filterCambodian').val()),
				"dollar" :	parseFloat($('#filterdoller').val())
		}
		
		//console.log(JSON.stringify(filterRequest))
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		
		$.ajax({
			url: './exportCurrencyData?source=ViewExport',
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
		currencyFieldTable(lang,null);
	}