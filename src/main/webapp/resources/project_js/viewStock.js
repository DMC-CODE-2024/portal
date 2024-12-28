var period= $("body").attr("data-period");	
var sourceParam="";
var selectedUserTypeId='';
var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

		$.i18n().locale = lang;
		var stockRejected,stockApproved,stockTxn,errorOccured,operationNotAllowed,stockDeleted,updateMsg,hasBeenUpdated;
	
		$.i18n().load( {
			'en': './resources/i18n/en.json',
			'km': './resources/i18n/km.json'
		}).done( function() { 
			updateMsg=$.i18n('updateMsg');
			hasBeenUpdated=$.i18n('hasBeenUpdated');
			stockRejected=$.i18n('stockRejected');
			stockApproved=$.i18n('stockUploadSuccess');
			stockTxn=$.i18n('stockhaveTxn');	
			errorOccured=$.i18n('errorMsg');
			operationNotAllowed=$.i18n('operationnotallowed');
			stockDeleted=$.i18n('stockDeleted');
			
		});


	$(document).ready(function(){
		$('div#initialloader').fadeIn('fast');
			filter(lang);
		
			sessionStorage.removeItem("session-value");
		pageRendering()
	});
	/* $('li .active a').attr("data-featureid") */
	$('.datepicker').on('mousedown',function(event){
		event.preventDefault();
	});


	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var currentRoleType = $("body").attr("data-selected-roleType"); 


	// *******************************************View Pop up data
	// *************************************************************************************************
	function viewUploadedStockDetails(txnId){

		var userType=$("body").attr("data-roleType");
		$('#viewStockModal').openModal({
	    	   dismissible:false
	       });
		var userTypeId = $("body").attr("data-selectedRoleTypeId");
		var role = currentRoleType == null ? roleType : currentRoleType;
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : "./openStockPopup?reqType=editPage&txnId="+txnId+'&role='+role+'&userType='+userType+"&userId="+userId+'&userTypeId='+userTypeId,
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'GET',
			success : function(data) {
				// ////console.log(data)
				setViewPopupData(data);
			},
			error : function() {
				// alert("Failed");
			}
		});
	}


	function setViewPopupData(data){
		var  assigneIdLabel=$.i18n('assigneIdLabel');
		 var assigneNameLabel=$.i18n('assigneNameLabel');
		
 var currentRoleTypeAssignei = $("body").attr("data-selected-roleType"); 
		if(currentRoleTypeAssignei=='Manufacturer')
			{
			
			$("#supplierIdDiv").css("display", "none"); 
			$("#supplierNameDiv").css("display", "none");
			$("#invoiceNumberDiv").css("display", "none");
			}
		else if(currentRoleTypeAssignei=='Custom'){
			$('#SupplierIdLabel').text('');
			$('#SupplierIdLabel').text(assigneIdLabel);
		
			$('#SupplierNameLabel').text('');
			$('#SupplierNameLabel').text(assigneNameLabel);
			
			$("#editSupplierIdDiv").css("display", "block"); 
			$("#editSupplierNameDiv").css("display", "block");
			$("#editSupplierNameDiv").css("display", "block");
		}
		else {
			$("#supplierIdDiv").css("display", "block"); 
			$("#supplierNameDiv").css("display", "block");
			$("#invoiceNumberDiv").css("display", "block");
		}
		$("#SupplierId").val(data.supplierId);
		if(data.supplierId=="" || data.supplierId==null)
			{
			$("#SupplierId").val("NA");
			}
		
		$("#SupplierName").val(data.suplierName);
		if(data.suplierName=="" || data.suplierName==null)
		{
		$("#SupplierName").val("NA");
		}
		
		$("#InvoiceNumber").val(data.invoiceNumber);
		if(data.invoiceNumber=="" || data.invoiceNumber==null)
		{
		$("#InvoiceNumber").val("NA");
		}
		$("#Quantity").val(data.quantity);
		$("#TransactionId").val(data.txnId);
		$("#csvUploadFileName").val(data.fileName);
		$("#withdrawnRemark").val(data.remarks);
		if(data.remarks=="" || data.remarks==null)
		{
		$("#withdrawnRemark").val("NA");
		}
		$("#viewdevicequantity").val(data.deviceQuantity);
		$("label[for='viewdevicequantity']").addClass('active');

	}


	// ***************************************** end View Pop up data
	// ***********************************************************************************************

	// ***************************************** start edit Pop up data
	// ***********************************************************************************************

	function EditUploadedStockDetails(txnId){ 
		var role = currentRoleType == null ? roleType : currentRoleType;
		var userType=$("body").attr("data-roleType");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : "./openStockPopup?reqType=editPage&txnId="+txnId+'&role='+role+'&userType='+userType+"&userId="+userId,
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'GET',
			success : function(data) {
				// ////console.log(data)
				setEditPopupData(data) 
				// ////console.log(url)
			},
			error : function() {
				// alert("Failed");
			}
		});

		 $('#editStockModal').openModal({
	    	   dismissible:false
	       });
	}


	function setEditPopupData(data){
		var  assigneIdLabel=$.i18n('assigneIdLabel');
		 var assigneNameLabel=$.i18n('assigneNameLabel');

		// ////console.log()
var currentRoleTypeAssignei = $("body").attr("data-selected-roleType"); 		
		if(currentRoleTypeAssignei=='Manufacturer')
			{
			
			$("#editSupplierIdDiv").css("display", "none"); 
			$("#editSupplierNameDiv").css("display", "none");
			$("#editInvoiceNumberDiv").css("display", "none");
			$("#editSupplierName").attr("required", false);
			}
		else if(currentRoleTypeAssignei=='Custom'){
			$('#editSupplierIdLabel').text('');
			$('#editSupplierIdLabel').text(assigneIdLabel);
		
			$('#editSupplierNameLabel').text('');
			$('#editSupplierNameLabel').text(assigneNameLabel);
			$("#editSupplierIdDiv").css("display", "block"); 
			$("#editSupplierNameDiv").css("display", "block");
			$("#editSupplierNameDiv").css("display", "block");
		}
		$("#editSupplierId").val(data.supplierId);
		$("#editSupplierName").val(data.suplierName);
		$("#editInvoiceNumber").val(data.invoiceNumber);
		$("#editQuantity").val(data.quantity);
		$("#editTransactionId").val(data.txnId);
		$("#editcsvUploadFileName").val(data.fileName);
		$("#existingFileName").val(data.fileName);
		$("#editdevicequantity").val(data.deviceQuantity);
		$("label[for='editdevicequantity']").addClass('active');

	} 


	// ********************************************************************************************************************************************************
	// ******************************************************* update Stock
	// function
	// **************************************************************************

	function editUploadStock(){

		$('div#initialloader').fadeIn('fast');
		var supplierId=$('#editSupplierId').val();
		var supplierName=$('#editSupplierName').val();
		var filename=$('#editcsvUploadFileName').val();
		var txnId=$('#editTransactionId').val();
		var quantity=$('#editQuantity').val();
		var InvoiceNumber=$('#editInvoiceNumber').val();
		var editdevicequantity=$('#editdevicequantity').val();
		
		// ////console.log(supplierName,supplierName,filename,txnId,quantity,InvoiceNumber);

		var formData= new FormData();
		formData.append('file', $('#editcsvUploadFile')[0].files[0]);
		formData.append('supplierId',supplierId);
		formData.append('supplierName',supplierName);
		formData.append('quantity',quantity);
		formData.append('txnId',txnId);
		formData.append('filename',filename);

		formData.append('invoiceNumber',InvoiceNumber);
		formData.append('deviceQuantity',editdevicequantity);
		
		// ////console.log(JSON.stringify(formData));
		// ////console.log("*********");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: 'updateUploadedStock',
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function (data, textStatus, jqXHR) {
				$('div#initialloader').delay(300).fadeOut('slow');
				// ////console.log(data);
				$('#editStockModal').closeModal();
				 $('#successUpdateStockModal').openModal({
			    	   dismissible:false
			       });
				if(data.errorCode==200){

					$('#stockSucessMessage').text('');
					$('#stockSucessMessage').text(operationNotAllowed);
				}
				else if (data.errorCode==0){
					$('#stockSucessMessage').text('');
					$('#stockSucessMessage').text(updateMsg+' '+(data.txnId)+' '+hasBeenUpdated);
				}
				else if(data.errorCode==5){
					$('#stockSucessMessage').text('');
					$('#stockSucessMessage').text($.i18n(data.tag));
				}
				else{
					$('#stockSucessMessage').text('');
					$('#stockSucessMessage').text(errorOccured);
				}
	// $('#updateConsignment').modal('open');
	// alert("success");

			},
			error: function (jqXHR, textStatus, errorThrown) {
				// ////console.log("error in ajax")
			}
		});
	return false;
	}



	// ************************************************************* End update
	// Stock function *******************************************************


	// **************************************************** Delete Stock Modal
	// *************************************************************************

	function DeleteStockRecord(txnId){
		
		$('#DeleteStockconfirmationModal').openModal({
	    	   dismissible:false
	       });
		$("#stockdeleteTxnId").text(txnId);
	}


	function confirmantiondelete(){
		var role = currentRoleType == null ? roleType : currentRoleType;
		var txnId= $("#stockdeleteTxnId").text();
		var stockRemark= $("#deleteStockremark").val();
		// ////console.log("roleType=="+role+" ==stockRemark=="+stockRemark);
		var obj ={
				"roleType":role,
				"txnId" : txnId,
				"userType":role,
				"remarks":stockRemark,
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"userName":$("body").attr("data-username")
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : "./stockDelete",
			data : JSON.stringify(obj),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data, textStatus, xhr) {
				// ////console.log(data);

				// $("#stockModalText").text(data.message);
				$("#DeleteStockconfirmationModal").closeModal();

				$('#closeDeleteModal').openModal({
			    	   dismissible:false
			       });
				if(data.errorCode == 0){
					$("#stockModalText").text(stockDeleted);
				}
				else if(data.errorCode==5){
					$('#stockModalText').text('');
					$('#stockModalText').text($.i18n(data.tag));
				}
				
				else{	$("#stockModalText").text(data.message);}
				$("#materialize-lean-overlay-3").css("display","none");
			},
			error : function() {
				// ////console.log("Error");
			}
		});
		return false;
		/*
		 * $(".lean-overlay").remove();
		 */ 

	}






	/*
	 * function closeDeleteModal(){
	 * $("#DeleteStockconfirmationModal").closeModal(); //
	 * $('#updateModal').closeModal(); $(".lean-overlay").remove(); }
	 */

	function closeViewModal()
	{
		$('#viewStockModal').closeModal();
		$(".lean-overlay").remove();

	}

	function closeEditModal()
	{
		$('#editStockModal').closeModal();
		$(".lean-overlay").remove();

	}
/* var sourceParam=$("body").attr("data-Source"); */
	var sourceType =localStorage.getItem("sourceType");
	var currentRoleType = $("body").attr("data-selected-roleType"); 
	// alert("sourceType<><><><>"+sourceType);
	
	function filter(lang,sourceParam){
		var filterSource= $("body").attr("data-filterSource");
	    if(filterSource=='noti')
			{
			// //console.log('1');
			selectedUserTypeId=null;
			}
		else{
			// //console.log('2');
			selectedUserTypeId=$("body").attr("data-selectedRoleTypeId");
		}
		
		if(sourceParam == 'filter' ) {
			sourceParam= 'filter';
			if(selectedUserTypeId=="" || selectedUserTypeId==null){
				selectedUserTypeId=$("body").attr("data-userTypeID");
				$("body").attr("data-filterSource","filter");
			}
		}
		else{
			sourceParam= $("body").attr("data-filterSource");

		}
	// //console.log("sourceParam= "+sourceParam);
		if((roleType=="Importer" || roleType=="Retailer" || roleType=="Distributor" || roleType=="Manufacturer") && sourceType !="viaStock" ){
		Datatable('headers?lang='+lang+'&type=stockHeaders','stockData?source='+sourceParam,sourceParam);
		// alert("roleType 1-->" +roleType);
		}else if(roleType=="Custom" && sourceType !="viaStock"){
		Datatable('./headers?lang='+lang+'&type=customStockHeaders','stockData?source='+sourceParam,sourceParam)
		// alert("roleType 2-->" +roleType);
		}else if(roleType=="CEIRAdmin" && sourceType !="viaStock"){
		Datatable('./headers?lang='+lang+'&type=adminStockHeaders','stockData?source='+sourceParam,sourceParam)
		// alert("roleType 3-->" +roleType);
		}else if((roleType=="Importer"|| roleType=="Retailer" || roleType=="Distributor" || roleType=="Custom") && sourceType =="viaStock"){
		Datatable('./headers?lang='+lang+'&type=stockcheckHeaders','stockData?sourceType=viaStock&source='+sourceParam,sourceParam)
		// alert("roleType 4-->" +roleType);
		}
		localStorage.removeItem('sourceType');
	}



	var role = currentRoleType == null ? roleType : currentRoleType;
	var featureId="4";
	var userTypeId = $("body").attr("data-userTypeID");




	function Datatable(url,dataUrl,sourceParam) {
		var txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;
		
		if(sourceParam=='filter' && $('#transactionID').val()=='' )
			{
	
			txn='';
			}
		var filereduserType =  $('#userType').val() =='null' || $('#userType').val()==undefined ? null : $("#userType option:selected").text();
		if(filereduserType=="Role type"){
			filereduserType=null;
		}
		//var filereduserType =  $('#userType').val() =='null' || $('#userType').val()==undefined ? null : $("#userType option:selected").text();
				var filterUserName=$('#name').val() == 'null' || 'undefined' ?null:$('#name').val();
				/*
				 * var filterRedirect=$("body").attr("data-filterSource"); var
				 * selectedUserTypeId=''; if(filterRedirect=='noti') {
				 * ////console.log('1'); selectedUserTypeId=null; } else{
				 * ////console.log('2');
				 * selectedUserTypeId=$("body").attr("data-selectedRoleTypeId"); }
				 */
		
		var jsonObj = {
				"endDate":$('#endDate').val(),
				"startDate":$('#startDate').val(),
				"roleType": role,
				"userId": userId,
				"userType" : $("body").attr("data-roleType"),
				"featureId":featureId,
				"userTypeId":selectedUserTypeId,
				"txnId":txn,
				"consignmentStatus":parseInt($('#StockStatus').val()),
				"displayName" : $('#name').val(),
				"filteredUserType" : filereduserType,
				"filterUserName":$('#name').val(),
				"source":$("body").attr("data-Source"),
				"quantity" : $('#IMEIQuantityFilter').val(),
				"deviceQuantity" : $('#deviceQuantityFilter').val(),
				"fileName":$('#fileNameFilter').val()
		}
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
			url: url,
			type: 'POST',
			dataType: "json",
			success: function(result){
				
				var table=	$("#stockTable").removeAttr('width').DataTable({
					bAutoWidth: false,
					destroy:true,
					"serverSide": true,
					orderCellsTop : true,
					"ordering": true,
					"bPaginate" : true,
					"bFilter" : false,
					"bInfo" : true,
					"bSearchable" : true,
					scrollCollapse: true,
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
						type: 'POST',
						url: dataUrl, 
						data : function(d) {
							
							d.filter = JSON.stringify(jsonObj); 
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
					fixedColumns: true,
					columnDefs: [
						{ width: 240, targets: result.length - 1},
						 { orderable: false, targets: -1 }
					]
			
				});
				
				$('div#initialloader').delay(300).fadeOut('slow');
				// alert("122")
				$.fn.dataTableExt.sErrMode = 'none'
				// table.ext.errMode = 'throw';
				
			}
		}); 
	}	


	function pageRendering(){
		// ////console.log("sourceType in render check" +sourceType);
		if(sourceType !="viaStock" ){
			pageButtons('./stock/pageRendering');

		}else if(sourceType ==="viaStock" ){
			pageButtons('./stock/pageRendering?sourceType=viaStock');
		}
		localStorage.removeItem('sourceType');

	}


	function pageButtons(url){ 
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: url,
			type: 'POST',
			dataType: "json",
			success: function(data){
				data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );
				var elem='<p class="PageHeading">'+data.pageTitle+'</p>';
				$("#pageHeader").append(elem);
				var button=data.buttonList;

				var date=data.inputTypeDateList;
				/*if(window.parent.$("body").attr("data-usertype") == "CEIRAdmin"){*/
					for(i=0; i<date.length; i++){
				
					if(date[i].type === "date"){
					$("#consignmentTableDIv").append("<div class='input-field'>"+
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
					
					$("#consignmentTableDIv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength="+date[i].className+" /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
				}
				else if(date[i].type === "select"){

						var dropdownDiv=
							$("#consignmentTableDIv").append("<div class='selectDropdwn'>"+
									
									"<div class='select-wrapper select2  initialized'>"+
									"<span class='caret'>"+"</span>"+
									"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

									"<select id="+date[i].id+" class='select2 initialized'>"+
									"<option>"+date[i].title+
									"</option>"+
									"</select>"+
									"</div>"+
							"</div>");
					
					}
				}/*}
				else{
					for(i=0; i<date.length; i++){
						if(date[i].type === "date"){
							$("#consignmentTableDIv").append("<div class='input-field col s6 m2'>"+
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
							$("#consignmentTableDIv").append("<div class='input-field col s6 m2' ><input type="+date[i].type+" id="+date[i].id+" maxlength="+date[i].className+" /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						}

					} 

					// dynamic dropdown portion
					var dropdown=data.dropdownList;
					for(i=0; i<dropdown.length; i++){
						var dropdownDiv=
							$("#consignmentTableDIv").append("<div class='col s6 m2 selectDropdwn'>"+

									"<div class='select-wrapper select2  initialized'>"+
									"<span class='caret'>"+"</span>"+
									"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

									"<select id="+dropdown[i].id+" class='select2 initialized'>"+
									"<option>"+dropdown[i].title+
									"</option>"+
									"</select>"+
									"</div>"+
							"</div>");
					}

				} 
*/			
				if(sourceType=="viaStock"){
					$("#btnLink").css({display: "none"});
					$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter' /></div>");
					$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton'  id='clearStockFilter'>"+$.i18n('clearFilter')+"</button></div>");
					$("#consignmentTableDIv").append("<div class='filter_btn'><a href='JavaScript:void(0)'  type='button' class='export-to-excel right' onclick='exportStockData()'>"+$.i18n('Export')+" <i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
					
					$('#clearStockFilter').attr("onclick", "filterReset('viewStockFilter')");	
					for(i=0; i<button.length; i++){
						$('#'+button[i].id).text(button[i].buttonTitle);
						$('#'+button[i].id).attr("href", button[i].buttonURL);
					}
					
					$("#footerBtn").append("<div class='col s12 m2 l2'><button class='btn' id='markedstolen' style='margin-left:38%;margin-top: 8px;'></button><button class='btn' id='cancel' style='margin-left: 22px;margin-top: 8px;'></button></div>");
					for(i=0; i<button.length; i++){
						$('#'+button[i].id).text(button[i].buttonTitle);
						$('#'+button[i].id).attr("onclick", button[i].buttonURL);
					}

				}else{

					$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter' /></div>");
					$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton'  id='clearStockFilter'>"+$.i18n('clearFilter')+"</button></div>");
					$("#consignmentTableDIv").append("<div class='filter_btn'><a href='JavaScript:void(0)'  type='button' class='export-to-excel right' onclick='exportStockData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
					
					$('#clearStockFilter').attr("onclick", "filterResetStock('viewStockFilter')");	
					for(i=0; i<button.length; i++){
						$('#'+button[i].id).text(button[i].buttonTitle);
						/*
						 * $('#'+button[i].id).attr("onclick",
						 * button[i].buttonURL);
						 */

						if(button[i].type === "HeaderButton"){
							$('#'+button[i].id).attr("href", button[i].buttonURL);
						}
						else{
							$('#'+button[i].id).attr("onclick", button[i].buttonURL);
						}
					}
				}

				sourceType=="viaStock"? $("#btnLink").css({display: "none"}) : $("#btnLink").css({display: "block"});
			
				if(roleType=="CEIRAdmin" || (period == 'POST_GRACE' && role=='Importer')){
					$("#btnLink").css({display: "none"});
				}
				
			
				
			}

	// $("#filterBtnDiv").append();
		});
		setAllDropdowns(); 
	}


	function valuesPush(){
		var multipleMarkedRequest=[];
		var roleType = $("body").attr("data-roleType");
		var currentRoleType = $("body").attr("data-stolenselected-roleType"); 
		var role = currentRoleType == null ? roleType : currentRoleType;
		var requestType="0";
		// ////console.log("role++++"+role+"requestType++"+requestType+"currentRoleType="+currentRoleType);
		$('#stockTable tr td input:checkbox:checked').each(function() {

			var json={"txnId":$(this).closest('tr').find('td:eq(2)').text(),
					"userId":userId,
					"sourceType":'1',
					"roleType":role,
					"requestType":requestType
			};

			multipleMarkedRequest.push(json);
		});
		// ////console.log(multipleMarkedRequest)
		return multipleMarkedRequest;
	}



	function markedstolen(){
		// $('#markAsMultipleStolen').openModal();
		$('#markAsMultipleStolen').openModal({
	    	   dismissible:false
	       });

	}

	function openMulipleStolenPopUp()
	{

		var stolenRecoverydata=JSON.stringify(valuesPush());
		// ////console.log("release-------"+stolenRecoverydata);
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url: './multipleStolenRecovery',
			type: 'POST',
			data: stolenRecoverydata,
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			success: function (data, textStatus, jqXHR) {

				// ////console.log(data);
				$('#markAsStolenDone').openModal();
			},
			error: function (jqXHR, textStatus, errorThrown) {
				// ////console.log("error in ajax");
			}
		});

	}

	function redirectToViewPage()
	{

		var roleType = $("body").attr("data-roleType");
		var userId = $("body").attr("data-userID");
		var currentRoleType = $("body").attr("data-selected-roleType"); 
		var role = currentRoleType == null ? roleType : currentRoleType;
		// ////console.log(" userId="+userId+" role="+role);
		// ////console.log("./stolenRecovery?userTypeId=="+role);
		window.location.href = "./stolenRecovery?userTypeId="+role;


	}

	function setAllDropdowns(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-userTypeID"), function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].state).text(data[i].interp)
				.appendTo('#StockStatus');

			}
		});
		
		/*$.getJSON('./registrationUserType', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].id).text(data[i].usertypeName)
				.appendTo('#userType');
			}
		});*/
		
		$.getJSON('./getusertypefeature/4/8', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].id).text(data[i].usertypeInterp)
				.appendTo('#userType');
			}
		});
	}

	function ApproveStock(txnId)
	{
		var userType=$("body").attr("data-roleType");
		if(userType=='Custom')
			{
			// $('#ApproveStock').openModal();
			$('#ApproveStock').openModal({
		    	   dismissible:false
		       });

			$('#approveStockTxnId').text(txnId);
			
			}
		else {
			// $('#ApproveStock').openModal();
			$('#ApproveStock').openModal({
		    	   dismissible:false
		       });
			$('#stockApproveMessage').text('');
			$('#stockApproveMessage').text(stockTxn+" "+txnId);
			$('#stockAppapprove').text('');
		
		}
		
		$('#approveStockTransactionId').val(txnId);
		
	}

	function approveStockSubmit(actiontype){
		var txnId=$('#approveStockTransactionId').val();
		// ////console.log("txnId==="+txnId);
		var approveRequest={
				"action": actiontype,
				"txnId":txnId,
				"featureId":4
		}
		// ////console.log(JSON.stringify(approveRequest))
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : "./acceptRejectStockController",
			data : JSON.stringify(approveRequest),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data) {
				$('#ApproveStock').closeModal();
				// $('#confirmApproveStockModal').openModal();
				$('#confirmApproveStockModal').openModal({
			    	   dismissible:false
			       });
				// ////console.log(data);
				if(data.errorCode==0){

					$('#stockApproveSucessMessage').text('');
					$('#stockApproveSucessMessage').text(stockApproved);
				}
				else if(data.errorCode==5){
					$('#stockApproveSucessMessage').text('');
					$('#stockApproveSucessMessage').text($.i18n(data.tag));
				}
				else{
					$('#stockApproveSucessMessage').text('');
					$('#stockApproveSucessMessage').text(data.message);
				}
			},
			error : function() {
				
			}
		});
	}

	function disApproveStock(txnId)
	{

		// $('#RejectStockModal').openModal();
		$('#RejectStockModal').openModal({
	    	   dismissible:false
	       });
		$('#disaproveTxnId').text(txnId);
		


	}

	function disApproveStockSubmit(actiontype){
		var txnId=$('#disaproveTxnId').text();
		var Remark=$('#stockDispproveRemarks').val();
	// ////console.log("txnId =="+txnId+" Remark="+Remark );
		var approveRequest={
				"action": actiontype,
				"txnId":txnId,
				"remarks":Remark,
				"featureId":4
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
			url : "./acceptRejectStockController",
			data : JSON.stringify(approveRequest),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(data) {
				
				// setTimeout(function(){ $('#confirmRejectStock').openModal()},
				// 200);
				$('#RejectStockModal').closeModal();
				// $('#confirmRejectStock').openModal();
				$('#confirmRejectStock').openModal({
			    	   dismissible:false
			       });
				if(data.errorCode==0){

					$('#stockDisapproveSucessMessage').text('');
					$('#stockDisapproveSucessMessage').text(stockRejected);
				}
				else if(data.errorCode==5){
					$('#stockDisapproveSucessMessage').text('');
					$('#stockDisapproveSucessMessage').text($.i18n(data.tag));
				}
				else{
					$('#stockDisapproveSucessMessage').text('');
					$('#stockDisapproveSucessMessage').text(data.message);
				}
			},
			error : function() {
				
			}
		});
		return false;
	}



	var role = currentRoleType == null ? roleType : currentRoleType;

	// **********************************************************Export Excel
	// file************************************************************************
	function exportStockData()
	{
		
		var stockStartDate=$('#startDate').val();
		var stockEndDate=$('#endDate').val();
		var quantity= $('#IMEIQuantityFilter').val();
		var deviceQuantity= $('#deviceQuantityFilter').val();
		var fileName=$('#fileNameFilter').val();
		var stockTxnId="";
		if($("body").attr("data-filterSource")=='noti'){
			 stockTxnId= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;	
		}
		else{
			stockTxnId=$('#transactionID').val();
		}
		
		var StockStatus=parseInt($('#StockStatus').val());
		var roleType = role;
		var currentRoleType = $("body").attr("data-stolenselected-roleType");	
		var userType = role;
		var sourceParam=$("body").attr("data-Source");
		
		var selectedRoleTypeId=$("body").attr("data-selectedRoleTypeId");
		
	var filteredUserType =  $('#userType').val() =='null' || $('#userType').val()==undefined ? null : $("#userType option:selected").text();
	
		var filterUserName=$('#name').val();
		if(filterUserName==undefined || filterUserName=="undefined"){
			filterUserName="";
		}
		if(isNaN(StockStatus))
		{
		StockStatus='';
		
		}
		if(filteredUserType=="Role type"){
			filteredUserType=null;
		}
	
		if(stockStartDate!="" ||stockEndDate!="" || stockTxnId!="" || StockStatus!="" || filteredUserType!=undefined || filterUserName!=undefined || quantity!=undefined || deviceQuantity!=undefined || fileName!=undefined ){
		  sourceParam="filter";
	  }
		var table = $('#stockTable').DataTable();
		var info = table.page.info(); 
		var pageNo=info.page;
		var pageSize =info.length;
		
		window.location.href="./exportStock?stockStartDate="+stockStartDate+"&stockEndDate="+stockEndDate+"&stockTxnId="+stockTxnId+"&StockStatus="+StockStatus+"&userType="+userType+"&userTypeId="+selectedRoleTypeId+"&pageSize="+pageSize+"&pageNo="+pageNo+"&roleType="+roleType+'&source='+sourceParam+'&filterUserName='+filterUserName+'&filteredUserType='+filteredUserType+"&quantity="+quantity+"&deviceQuantity="+deviceQuantity+"&fileName="+fileName;
	}
	
	function fileTypeValueChanges() {
		var uploadedFileName = $("#editcsvUploadFile").val();
		uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
		var ext = uploadedFileName.split('.').pop();
	
		var fileSize = ($("#editcsvUploadFile")[0].files[0].size);
		fileSize = (Math.round((fileSize / 1024) * 100) / 100)
	   if (uploadedFileName.length > 30) {
	     // $('#fileFormateModal').openModal();
	       $('#fileFormateModal').openModal({
	    	   dismissible:false
	       });
	      
	   } 
		else if(ext!='csv')
			{
			  $('#fileFormateModal').openModal({
		    	   dismissible:false
		       }); 
			}
		else if(fileSize>='10000'){
			  $('#fileFormateModal').openModal({
		    	   dismissible:false
		       });
		}
		else {
			// ////console.log("file formate is correct")
			
		}
	}

	function clearFileName() {
		var existingfile=$("#existingFileName").val();
		// $('#fileNameEdit').val('');
		$("#editcsvUploadFile").val('');
		$('#fileFormateModal').closeModal();
		
		$("#editcsvUploadFileName").val(existingfile);
	}

	$("input[type=file]").keypress(function(ev) {
	    return false;
	    // ev.preventDefault(); //works as well

	});

	
	function historyRecord(txnID){
			// ////console.log("txn id=="+txnID)
			$("#tableOnModal").openModal({dismissible:false});
			 var filter =[];
			 var formData= new FormData();
			 var ceirAdmin='';
			 var userTypeValue=$("body").attr("data-roleType");
			 if(userTypeValue=='CEIRAdmin')
			 {
			 var filterRequest={
			 "columns":["created_on","modified_on","txn_id","user_type","role_type","stock_status","supplier_id","suplier_name",
			 "quantity","device_quantity","remarks","assigner_id",
			 "user_id","ceir_admin_id" 
			 ],
			 "tableName": "stock_mgmt_aud",
			 "dbName" : "ceirconfig",
			 "txnId":txnID,
			 "featureId":4
			 }
			 }else if(userTypeValue=='Manufacturer' || userTypeValue=='Custom'){
				 var filterRequest={
						 "columns":["created_on","modified_on","txn_id","user_type","role_type","stock_status",
						 "quantity","device_quantity","remarks","assigner_id",
						 "user_id"
						 ],
						 "tableName": "stock_mgmt_aud",
						 "dbName" : "ceirconfig",
						 "txnId":txnID,
						 "featureId":4
						 }
			}
			 else{
			 var filterRequest={
			 "columns":["created_on","modified_on","txn_id","user_type","role_type","stock_status","supplier_id","suplier_name",
			 "quantity","device_quantity","remarks","assigner_id",
			 "user_id"
			 ],
			 "tableName": "stock_mgmt_aud",
			 "dbName" : "ceirconfig",
			 "txnId":txnID,
			 "featureId":4
			 }
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
						"oLanguage": {  
							"sUrl": langFile  
						},
						"bInfo" : true,
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
	
	function filterResetStock(formID){
		$('#endDate').css('border-color', '');
		$('#errorMsg').text('');
		$('#'+formID).trigger('reset');
		$("label").removeClass('active');
		filter(lang,null);
	}