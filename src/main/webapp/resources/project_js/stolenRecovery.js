var roleType = $("body").attr("data-roletype");
var userId = $("body").attr("data-userid");
var currentRoleType = $("body").attr("data-stolenselected-roletype");  
var role = currentRoleType == null ? roleType : currentRoleType;

var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
var userType = $("body").attr("data-roletype");


/*window.parent.$('#langlist').on('change', function() {
	var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	window.location.assign("./stolenRecovery?lang="+lang);				
}); 
*/
$.i18n().locale = lang;	

$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
} ).done( function() { 
});




$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	////////console.log("featureId is---->" +featureId);
	filterStolen(lang,null,null);
	pageRendering();
});



function DeleteConsignmentRecord(txnId,id,reqType){
	$("#DeleteConsignment").openModal({dismissible:false});
	$("#transID").text(txnId);
	$("#setStolenRecoveyRowId").text(id);
	window.reqType=reqType;
}


function confirmantiondelete(){
	var txnId = $("#transID").text();
	var id= $("#setStolenRecoveyRowId").text();
	var roleType = $("body").attr("data-roletype");
	var userId = $("body").attr("data-userid");
	var currentRoleType = $("body").attr("data-stolenselected-roletype"); 
	var role = currentRoleType == null ? roleType : currentRoleType;
	var remarks = $("#textarea1").val();
	//////console.log("txnId===**"+txnId+" userId="+userId+" roleType== "+roleType+ " currentRoleType=="+currentRoleType);
	var obj ={
			"txnId" : txnId,
			"userType":role,
			"roleType":role,
			"userId":userId,
			"featureId":featureId,
			"id":id,
			"remark":remarks,
			"userTypeId": parseInt($("body").attr("data-usertypeid")),
			"requestType":window.reqType
			

	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url : "./stolenRecoveryDelete",
		data : JSON.stringify(obj),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data, textStatus, xhr) {
			////////console.log(data);
			if(data.errorCode == 200){
				$("#consignmentText").text(data.message);
			}else if(data.errorCode == 0){
				$("#consignmentText").text(data.message);
			}
			else if(data.errorCode == 5){
				$("#consignmentText").text('');
				$("#consignmentText").text($.i18n(data.tag));
			}
			else{
				$("#consignmentText").text('');
				$("#consignmentText").text($.i18n('errorMsg'));
			}
		},
		error : function() {
			//////console.log("Error");
		}
	});
	$("#DeleteConsignment").closeModal();
	$("#confirmDeleteConsignment").openModal({dismissible:false});
	return false;
}


function EditConsignmentDetails(txnId){ 	


	$("#fileStolenModal").openModal({dismissible:false});
}


function viewConsignmentDetails(txnId){

	$("#viewModal").openModal({dismissible:false});
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url : "./openRegisterConsignmentPopup?reqType=editPage&txnId="+txnId,
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		success : function(data) {
			//////console.log(data)
			setViewPopupData(data);
		},
		error : function() {
			////alert("Failed");
		}
	});
}


function setViewPopupData(data){
	//////console.log("_________________++++++++++"+data.organisationCountry)

	$("#supplierId").val(data.supplierId);
	$("#supplierName").val(data.supplierName);
	$("#consignmentNumber").val(data.consignmentNumber);
	$("#expectedDispatcheDate").val(data.expectedDispatcheDate);
	$("#countryview").val(data.organisationCountry);
	$("#expectedArrivaldate").val(data.expectedArrivaldate);
	$("#expectedArrivalPort").val(data.expectedArrivalPort);
	$("#Quantity").val(data.quantity);
	$("#TransactionId").val(data.txnId);
	$("#remark").val(data.remarks);
	$("#fileName").val(data.fileName); 


}

function setEditPopupData(data){
	//////console.log()
	$("#supplierIdEdit").val(data.supplierId);
	$("#supplierNameEdit").val(data.supplierName);
	$("#consignmentNumberEdit").val(data.consignmentNumber);
	$("#expectedDispatcheDateEdit").val(data.expectedDispatcheDate);
	$('#country').val(data.organisationCountry);
	$("#expectedArrivaldateEdit").val(data.expectedArrivaldate);
	$("#expectedArrivalPortEdit").val(data.expectedArrivalPort);
	$("#QuantityEdit").val(data.quantity);
	$("#TransactionIdEdit").val(data.txnId);
	$("#fileNameEdit").val(data.fileName); 


} 



//******************************************************************************************************************************************************************888888
//******************************************      ************************************************************************************************************************888888
//******************************************************************************************************************************************************************888888   

function editRegisterConsignment(){
	/*  $("#editRegisterConsignment").submit(); */

	var supplierId=$('#supplierIdEdit').val();
	var supplierName=$('#supplierNameEdit').val();
	var consignmentNumber=$('#consignmentNumberEdit').val();
	var expectedArrivalDate=$('#expectedArrivaldateEdit').val();
	var expectedDispatcheDate=$('#expectedDispatcheDateEdit').val();
	var expectedArrivalPort=$('#expectedArrivalPortEdit').val();
	var organisationcountry=$('#country').val();
	var filename=$('#fileNameEdit').val();
	var txnId=$('#TransactionIdEdit').val();

	var quantity=$('#QuantityEdit').val();
	//////console.log(supplierName,consignmentNumber,expectedArrivalDate,txnId,filename)


	var formData= new FormData();
	formData.append('file', $('#csvUploadFile')[0].files[0]);
	formData.append('supplierId',supplierId);
	formData.append('supplierName',supplierName);
	formData.append('consignmentNumber',consignmentNumber);
	formData.append('expectedArrivaldate',expectedArrivalDate);
	formData.append('expectedDispatcheDate',expectedDispatcheDate);
	formData.append('expectedArrivalPort',expectedArrivalPort);
	formData.append('organisationcountry',organisationcountry);
	formData.append('quantity',quantity);
	formData.append('txnId',txnId);
	formData.append('filename',filename);

	//////console.log(JSON.stringify(formData));
	//////console.log("*********");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({ 
		url: './Consignment/updateRegisterConsignment',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {

			//////console.log(data);
			$('#updateModal').closeModal();
			$('#updateConsignment').modal();
			if(data.errorCode==200){

				$('#sucessMessage').text('');
				$('#sucessMessage').text('Operation is not allowed');
			}
			else{
				$('#sucessMessage').text('');
				$('#sucessMessage').text('Your update on the form for transaction ID ('+data.txnId+') has been successfully updated.');
			}
			// $('#updateConsignment').modal('open'); 
			////alert("success");

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});

}



function openDeleteModal(transactionId)
{
	/*   $('#deletemodal').modal('open');
        	  backdrop: 'static' */
	$('#deletemodal').openModal({dismissible:false});
	//////console.log("transactionId value="+transactionId);
	$('#deleteTransactionId').val(transactionId);
}




function myFunction(message) {
	var x = document.getElementById("snackbar");
	x.className = "show";
	$('#errorMessage').html(message);
	setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}




$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});



function closeUpdateModal(){
	$("#DeleteConsignment").closeModal();
	$('#updateModal').closeModal();
	$(".lean-overlay").remove();
}

function closeViewModal()
{
	$('#viewModal').closeModal();
	$(".lean-overlay").remove();

}

populateCountries
(   
		"country"
);



var userType = $("body").attr("data-roletype");
var sourceType = localStorage.getItem("sourceType");
function filterStolen(language,sourceTypeFilter,source){
	var source__val;

	if(sourceTypeFilter == 'filter' ) {
		source__val= 'filter';
	}
	else{
		source__val= $("body").attr("data-session-source");

	}
	var sessionFlag;

	if(sourceType==null){
		sessionFlag=2;

	}
	else{
		sessionFlag=1;

	}
	var userTypeId = $("body").attr("data-usertypeid");
	if(userType=="Operator" || userType=="Operation" ){
		Datatable('./headers?type=blockUnblock','stolenData?featureId='+featureId+'&userTypeId='+userTypeId+'&source='+source__val,sourceTypeFilter)
	}else if(userType =="CEIRAdmin"){
		Datatable('./headers?type=BlockUnblockCEIRAdmin','stolenData?featureId='+featureId+'&userTypeId='+userTypeId+'&source='+source__val,sourceTypeFilter)
	}else if(sourceType !="viaExistingRecovery"){
		Datatable('./headers?type=stolen','stolenData',sourceTypeFilter)
	}else if(sourceType =="viaExistingRecovery" ){
		Datatable('./headers?type=stolenCheckHeaders', 'stolenData?sourceType=viaExistingRecovery',sourceTypeFilter)
	}
	localStorage.removeItem('sourceType');
}  


function Datatable(url,dataUrl,sourceTypeFiler){
	$('div#initialloader').fadeIn('fast');
	//////console.log(" == sourceType ="+sourceTypeFiler);
	var requestType='';
	var userType=$("body").attr("data-roletype");
	var txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;
	var  IMEIQuantityFilter=$('#IMEIQuantityFilter').val();
	var deviceQuantityFilter=$('#deviceQuantityFilter').val()
	if (sourceTypeFiler=="filter")
		{
		
		if($("body").attr("data-session-source")=='noti'){
			
			txn=$('#transactionID').val();
		}
		requestType = parseInt($('#requestType').val())
		}
	else{
		requestType = parseInt($("body").attr("data-requesttype"));
	  }
	//////console.log("=== requestType======"+requestType)
	//////console.log($("body").attr("data-operatorTypeId"))	
	
	
	var operatorTypeId;
	if(userType !="Operator"){
		operatorTypeId = $('#operator').val();
	}else{
		operatorTypeId = $('#operator').val() == undefined || $('#operator').val() == null ? $("body").attr("data-operatorTypeId"):$("body").attr("data-operatorTypeId")
	}
	
	if (sourceTypeFiler=="filter")
	{
	if($("body").attr("data-session-source")=='noti'){
		txn=$('#transactionID').val();
	}
	$("body").attr("data-session-source","filter");
	txn=$('#transactionID').val();
	}
	//////console.log("sent operatorTypeId is ---->" +operatorTypeId)		
	var filterRequest={
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"txnId": txn,
			"consignmentStatus":parseInt($('#status').val()),
			"requestType":requestType,
			"sourceType":parseInt($('#sourceStatus').val()),
			"roleType": role,
			"userId": userId,
			"featureId":featureId,
			"userTypeId": parseInt($("body").attr("data-usertypeid")),
			"userType":userType,
			"operatorTypeId" : parseInt(operatorTypeId),
			"userName" : $("body").attr("data-selected-username"),
			"quantity" :IMEIQuantityFilter,
			"deviceQuantity" : deviceQuantityFilter
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
			var table=	$("#stolenLibraryTable").DataTable({
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
					url: dataUrl,
					type: 'POST',
					data : function(d) {
						d.filter =JSON.stringify(filterRequest); 
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
				"columns": result,
				fixedColumns: true,
				columnDefs: [
		            { width: 246, targets: result.length - 1 },
		            { orderable: false, targets: -1 }
		        ]
			});
			$('div#initialloader').delay(300).fadeOut('slow');
				
		}
	}); 
}				

function pageRendering(){
	//////console.log("sourceType in render check" +sourceType);
	if(sourceType !="viaExistingRecovery" ){
		pageElements('./stolen/pageRendering');

	}else if(sourceType ==="viaExistingRecovery" ){
		pageElements('./stolen/pageRendering?sourceType=viaExistingRecovery');
	}
	localStorage.removeItem('sourceType');

}



function pageElements(url){
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
			/*if(window.parent.$("body").attr("data-roletype") == "CEIRAdmin"){*/
			
			for(i=0; i<date.length; i++){
				if(date[i].type === "date"){
					$("#consignmentTableDIv").append("<div class='input-field'>"+
							"<div id='enddatepicker' class='input-group'>"+
							"<input class='form-control datepicker' onchange='checkDate(startDate,endDate)'  type='text' id="+date[i].id+" autocomplete='off'>"+
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
								"<option value=''>"+date[i].title+
								"</option>"+
								"</select>"+
								"</div>"+
						"</div>");
				
				}
				 
			} 

			
			/*}
			else{
				
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){
						$("#consignmentTableDIv").append("<div class='input-field col s6 m2'>"+
								"<div id='enddatepicker' class='input-group'>"+
								"<input class='form-control datepicker' onchange='checkDate(startDate,endDate)'  type='text' id="+date[i].id+" autocomplete='off'>"+
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
			
				
			}*/

			
			
			
			/*// dynamic dropdown portion
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
			}*/
			if(sourceType=="viaExistingRecovery"){
				$("#btnLink").css({display: "none"});
				$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
				$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton'  id='clearStockFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$("#consignmentTableDIv").append("<div class='filter_btn'><a href='JavaScript:void(0)'  type='button' class='export-to-excel right' onclick='exportStolenRecoveryData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
				$('#clearStockFilter').attr("onclick", "filterResetBlockUnblock('stolenRecoveryFormDiv')");
				for(i=0; i<button.length; i++){
					$('#'+button[i].id).text(button[i].buttonTitle);
					if(button[i].type === "HeaderButton"){
						$('#'+button[i].id).attr("onclick", "openStolenRecoveryModal()");
					}
					else{
						$('#'+button[i].id).attr("onclick", button[i].buttonURL);
					}
				}

				$("#footerBtn").append("<div class='col s12 m2 l2'><button class='btn' id='markedRecovered' style='margin-left:38%;margin-top: 8px;'></button><button class='btn' id='cancel' style='margin-left: 22px;margin-top: 8px;'></button></div>");
				for(i=0; i<button.length; i++){
					$('#'+button[i].id).text(button[i].buttonTitle);
					if(button[i].type === "FooterButton"){
						$('#'+button[i].id).attr("onclick", button[i].buttonURL);
					}
					else{
						$('#'+button[i].id).attr("href", button[i].buttonURL);

					}
				}	

			}else{
				
				$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
				$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton'  id='clearStockFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$("#consignmentTableDIv").append("<div class='filter_btn'><a href='JavaScript:void(0)'  type='button' class='export-to-excel right' onclick='exportStolenRecoveryData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
				$('#clearStockFilter').attr("onclick", "filterResetBlockUnblock('stolenRecoveryFormDiv')");                   	
				for(i=0; i<button.length; i++){
					$('#'+button[i].id).text(button[i].buttonTitle);
					if(button[i].type === "HeaderButton" && userType != "Operator" ){
						$('#'+button[i].id).attr("href", button[i].buttonURL);
					}else if(button[i].type === "HeaderButton" && userType == "Operator"){
						$('#'+button[i].id).attr("href", button[i].buttonURL);
						
					}else{
						$('#'+button[i].id).attr("onclick", button[i].buttonURL);
					}
				}
			}
	
		}

	//$("#filterBtnDiv").append();
	}); 
	
	if($("body").attr("data-roletype")=="CEIRAdmin"){
		$("#btnLink").css({display: "none"});
	}
	
	setAllDropdowns();
	/*if(userType=="CEIRAdmin"){
		$("#btnLink").css({display: "none"});
		}*/

}	 

function fileStolenReport(){

	var roleType = $("body").attr("data-roletype");
	var userId = $("body").attr("data-userid");
	var currentRoleType = $("body").attr("data-stolenselected-roletype"); 
	var sourceType='2';
	var requestType='0';
	var role = currentRoleType == null ? roleType : currentRoleType;
	var blockType=$('input[name=stolenBlockPeriod]:checked').val();
	var blockingTimePeriod=$('#stolenDatePeriod').val();
	var qty = $('#stolenQuantity').val();
	//////console.log("roleType=="+roleType+" userId="+userId+" currentRoleType =="+currentRoleType+"  blockType=="+blockType);
	var formData= new FormData();

	formData.append('file', $('#stolenCsvUploadFile')[0].files[0]);
	formData.append('blockingType',blockType);
	formData.append('blockingTimePeriod',blockingTimePeriod);
	formData.append('requestType',requestType);
	formData.append('roleType',role);
	formData.append('sourceType',sourceType);
	formData.append('userId',userId);
	formData.append('qty',qty);
	//////console.log(JSON.stringify(formData));
	//////console.log("*********");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './fileTypeStolen',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {

			//////console.log(data);
			$('#fileStolenModal').closeModal();
			$('#markAsStolen').openModal({dismissible:false});
			//if(data.errorCode==200){
			/* 
   						 $('#stockSucessMessage').text('');
   						 $('#stockSucessMessage').text('Operation is not allowed');
   							 }
   						 else{
   							 $('#stockSucessMessage').text('');
   			 				 $('#stockSucessMessage').text('Your update on the form for transaction ID ('+data.txnId+') has been successfully updated.');
   						 } */ 
			// $('#updateConsignment').modal('open'); 
			////alert("success");

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});

}



function fileRecoveryReport(){

	var roleType = $("body").attr("data-roletype");
	var userId = $("body").attr("data-userid");
	var currentRoleType = $("body").attr("data-stolenselected-roletype"); 


	var sourceType='2';
	var requestType='1';
	var role = currentRoleType == null ? roleType : currentRoleType;
	var qty = $('#recoverQuantity').val();
	var blockType=$('input[name=stolenBlockPeriod]:checked').val();
	//////console.log("roleType=="+roleType+" userId="+userId+" currentRoleType =="+currentRoleType);

	var formData= new FormData();

	formData.append('file', $('#recoveryCsvUploadFile')[0].files[0]);
	formData.append('requestType',requestType);
	formData.append('roleType',role);
	formData.append('sourceType',sourceType);
	formData.append('userId',userId);
	formData.append('qty',qty);
	//////console.log(JSON.stringify(formData));
	//////console.log("*********");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './fileTypeRecovery',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {
			//////console.log(data);
			$('#recoveryFileModal').closeModal();
			$('#markAsRecoverDone').openModal({dismissible:false});
			/*  $('#editStockModal').closeModal();
   						 $('#successUpdateStockModal').modal();
   						  if(data.errorCode==200){

   						$('#stockSucessMessage').text('');
   						 $('#stockSucessMessage').text('Operation is not allowed');
   							 }
   						 else{
   							 $('#stockSucessMessage').text('');
   			 				 $('#stockSucessMessage').text('Your update on the form for transaction ID ('+data.txnId+') has been successfully updated.');
   						 } */
			// $('#updateConsignment').modal('open'); 
			////alert("success");

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});

}





function openStolenRecoveryModal(){
	//////console.log("openStolenRecoveryModal===");
	$('#stoleRecoveryModal').openModal({dismissible:false});
}

function openFileStolenModal(){
	//////console.log("openfileStolenModal===");
	//  $("#materialize-lean-overlay-3").css("display","none");

	$('#stoleRecoveryModal').closeModal();
	setTimeout(function(){

		$('#fileStolenModal').openModal({dismissible:false});
	}, 200);
	//$("#materialize-lean-overlay-3").css("display","none");

}


function openRecoveryModal(){
	//////console.log("openfileStolenModal===");
	//  $("#materialize-lean-overlay-3").css("display","none");

	$('#editRecoveryFileModal').closeModal();
	setTimeout(function(){

		$('#recoveryFileModal').openModal({dismissible:false});
	}, 200);
	//$("#materialize-lean-overlay-3").css("display","none");

}
function closeStolenModalModal()
{
	$('#fileStolenModal').closeModal();
	$(".lean-overlay").remove();
}

function closeRecoveryModalModal()
{
	$('#recoveryFileModal').closeModal();
	$(".lean-overlay").remove();
}

function openFileStolenUpdate(txnId,requestType,id,qty)
{
	//////console.log("requestType="+requestType+" txnId="+txnId+" id= "+id);
	if(requestType=='1'){
		$('#editRecoveryFileModal').openModal({dismissible:false}); 
		$('#editFileRecoveryTxnId').text(txnId)
		$('#editFileRecoveryId').val(id);
		$('#editRecoveryQuantity').val(qty);
		
	}
	else{
		$('#editFileStolenModal').openModal({dismissible:false}); 
		$('#editFileStolenTxnId').text(txnId)
		$('#editFileStolenId').val(id);
		$('#editStolenQuantity').val(qty);
	}


	$('#editFileStolenRequestType').val(requestType);


}


function updatefileStolenReport(){

	var roleType = $("body").attr("data-roletype");
	var userId = $("body").attr("data-userid");
	var currentRoleType = $("body").attr("data-stolenselected-roletype"); 
	var sourceType=2;
	var requestType=$('#editFileStolenRequestType').val();
	var role = currentRoleType == null ? roleType : currentRoleType;
	var blockType=$('input[name=editStolenBlockPeriod]:checked').val();
	var blockingTimePeriod=$('#editStolenDatePeriod').val();
	var txnId=$('#editFileStolenTxnId').text();
	//////console.log("roleType=="+roleType+" userId="+userId+" currentRoleType =="+currentRoleType+"  blockType=="+blockType+" txnId ="+txnId);
	var formData= new FormData();
	if(requestType=='1'){
		formData.append('file', $('#editRecoveryCsvUploadFile')[0].files[0]);
		formData.append('blockingType','');
		formData.append('blockingTimePeriod','');
		formData.append('id',$('#editFileRecoveryId').val());
		formData.append('txnId',$('#editFileRecoveryTxnId').text());
	}
	else{
		formData.append('file', $('#editStolenCsvUploadFile')[0].files[0]);
		formData.append('blockingType',blockType);
		formData.append('blockingTimePeriod',blockingTimePeriod);
		formData.append('id',$('#editFileStolenId').val());
		formData.append('txnId',$('#editFileStolenTxnId').text());
	}


	formData.append('requestType',requestType);
	formData.append('roleType',role);
	formData.append('sourceType',sourceType);
	formData.append('userId',userId);
	//////console.log(JSON.stringify(formData));
	//////console.log("*********");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './updateFileTypeStolenRecovery',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {

			//////console.log(data);
			if(requestType=='1'){
				//////console.log("close recovery model.");
				$('#editFileStolenModal').closeModal();
			}
			else{
				//////console.log("close stolen model.");
				$('#editRecoveryFileModal').closeModal();
			}
			$('#updateMarkAsStolen').openModal({dismissible:false});
			if(data.errorCode==0){

				$('#editMessageTextStoleRecovery').text('');
				$('#editMessageTextStoleRecovery').text(data.message);
			}
			else{
				$('#editMessageTextStoleRecovery').text('');
				$('#editMessageTextStoleRecovery').text(data.message);
			}  
			// $('#updateConsignment').modal('open'); 
			////alert("success");

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});

}

function closeEditRecoveryModal()
{
	$('#editRecoveryFileModal').closeModal();
	$(".lean-overlay").remove();
}
function closeEditStolenRecoveryModal()
{
	$('#editFileStolenModal').closeModal();
	$(".lean-overlay").remove();
}

function pickConsignment(){
	if($("input[name='chooseconsignment']:checked")){
		var url="./Consignment/viewConsignment";
		localStorage.setItem("sourceType", "viaStolen");
		//////console.log(url);
		window.location.href=url;

	}
}


var roleType = $("body").attr("data-stolenselected-roletype");
function pickstock(){
	localStorage.setItem("sourceType", "viaStock");
	var url="./assignDistributor?userTypeId="+roleType;
	window.location.href = url;
	//////console.log(url);
}

function pickExistingRecovery(){
	localStorage.setItem("sourceType", "viaExistingRecovery");
	var url =  "./stolenRecovery?userTypeId="+roleType;
	window.location.href = url;
	//////console.log(url);
}

function valuesPush(){
	var multipleMarkedRequest=[];
	var roleType = $("body").attr("data-roletype");
	var currentRoleType = $("body").attr("data-stolenselected-roletype"); 
	var role = currentRoleType == null ? roleType : currentRoleType;
	var requestType="1";
	//////console.log("role++++"+role+"requestType++"+requestType+"currentRoleType="+currentRoleType);
	
	 
	//////console.log("role++++"+role+"requestType++"+requestType+"currentRoleType="+currentRoleType);
	$('#stolenLibraryTable tr td input:checkbox:checked').each(function() {
		var sourceInterp=$(this).closest('tr').find('td:eq(5)').text();
		 var sourceType;
		 if(sourceInterp=='Consignment')
			 {
			 sourceType=0;
			 }
		 else if(sourceInterp=='File')
			 {
			 sourceType=2;
			 }
		 else if(sourceInterp=='Stock')
			 {
			 sourceType=1;
			 }
		 
		var json={"txnId":$(this).closest('tr').find('td:eq(2)').text(),
				"userId":userId,
				"sourceType":sourceType,
				"roleType":role,
				"requestType":requestType
		};

		multipleMarkedRequest.push(json);
	});
	//////console.log(multipleMarkedRequest)
	return multipleMarkedRequest;
}



function markedRecovered(){
	$('#markAsMultipleRecovery').openModal({dismissible:false});

}

function openMulipleStolenPopUp()
{

	var stolenRecoverydata=JSON.stringify(valuesPush());
	//////console.log("release-------"+stolenRecoverydata);
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

			//////console.log(data);
			$('#markAsRecoveryDone').openModal({dismissible:false});
			/*  $('#editStockModal').closeModal();
					 $('#successUpdateStockModal').modal();
					  if(data.errorCode==200){

					$('#stockSucessMessage').text('');
					 $('#stockSucessMessage').text('Operation is not allowed');
						 }
					 else{
						 $('#stockSucessMessage').text('');
		 				 $('#stockSucessMessage').text('Your update on the form for transaction ID ('+data.txnId+') has been successfully updated.');
					 } */
			// $('#updateConsignment').modal('open'); 
			////alert("success");

		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});

}


function redirectToViewStolenPage()
{

	var roleType = $("body").attr("data-roletype");
	var userId = $("body").attr("data-userid");
	var currentRoleType = $("body").attr("data-stolenselected-roletype"); 
	var role = currentRoleType == null ? roleType : currentRoleType;
	//////console.log(" userId="+userId+" role="+role);
	//////console.log("./stolenRecovery?userTypeId="+role);
	window.location.href = "./stolenRecovery?userTypeId="+role;


}


function setAllDropdowns(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	//Source Operator-----------dropdown
	$.getJSON('./getDropdownList/OPERATION_OPERATOR', function(data) {
			for (i = 0; i < data.length; i++) {
				$('<option>').val(data[i].value).text(data[i].interp)
				.appendTo('#operator');
			}
			/*$('<option>').val("-1").text("Operation")
			.appendTo('#operator');*/
		});
	
	//Request Type status-----------dropdown
$.getJSON('./getSourceTypeDropdown/REQ_TYPE/'+featureId+'', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#requestType');
		}
	});

	//Source Type-----------dropdown
$.getJSON('./getSourceTypeDropdown/SOURCE_TYPE/'+featureId+'', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#sourceStatus');
		}
	});


	//Stolen Status-----------dropdown
	$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-usertypeid"), function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].state).text(data[i].interp)
			.appendTo('#status'); 
		}
	});
	
	
}


//**********************************************************Export Excel file************************************************************************
function exportStolenRecoveryData()
{
	var source__val;
	var stolenRecoveryStartDate=$('#startDate').val();
	var stolenRecoveryEndDate=$('#endDate').val();
	var stolenRecoveryTxnId=$('#transactionID').val();
	var stolenRecoveryFileStatus=parseInt($('#status').val());
	var stolenRecoverySourceStatus=parseInt($('#sourceStatus').val());
	var stolenRecoveryRequestType=parseInt($('#requestType').val());

	
	var roleType = $("body").attr("data-roletype");
	var currentRoleType = $("body").attr("data-stolenselected-roletype");
	
	var source__val = stolenRecoveryStartDate != ''|| stolenRecoveryEndDate != ''|| stolenRecoveryTxnId != ''|| stolenRecoveryFileStatus != "Status"|| stolenRecoverySourceStatus != "Mode"|| stolenRecoveryRequestType != "Request Type" ? 'filter' : $("body").attr("data-session-source");
	var blockUnblcksource= $("body").attr("data-session-source");
	if(blockUnblcksource=='noti')
		{
		//////console.log("export noti data=="+$("body").attr("data-notificationTxnID"));
		stolenRecoveryTxnId=$("body").attr("data-notificationtxnid");
		source__val=$("body").attr("data-session-source");
		}
	else if(blockUnblcksource=='dashboard'){
		source__val=$("body").attr("data-session-source");
	}
	var role = currentRoleType == null ? roleType : currentRoleType;
	//////console.log("roleType=="+roleType+" currentRoleType="+currentRoleType+" role="+role);
    
	//////console.log("stolenRecoveryFileStatus=="+stolenRecoveryFileStatus+" stolenRecoverySourceStatus=="+stolenRecoverySourceStatus+" stolenRecoveryRequestType="+stolenRecoveryRequestType)
      if(isNaN(stolenRecoveryFileStatus) && isNaN(stolenRecoverySourceStatus) && isNaN(stolenRecoveryRequestType))
	   {
    	  stolenRecoveryFileStatus='';
    	  stolenRecoverySourceStatus='';
    	  stolenRecoveryRequestType=parseInt($("body").attr("data-requesttype"));
    	  //////console.log(" 11111111stolenRecoveryFileStatus && stolenRecoverySourceStatus && stolenRecoveryRequestType is empty =="+stolenRecoveryFileStatus+stolenRecoverySourceStatus);
	   }
      else if(isNaN(stolenRecoveryFileStatus) && isNaN(stolenRecoverySourceStatus))
	   {
    	  stolenRecoveryFileStatus='';
    	  stolenRecoverySourceStatus='';
    	  //////console.log(" 2222stolenRecoveryFileStatus && stolenRecoverySourceStatus is empty=="+stolenRecoveryFileStatus+stolenRecoverySourceStatus);
	   }
      else if(isNaN(stolenRecoverySourceStatus) && isNaN(stolenRecoveryRequestType))
	   {
    	  stolenRecoverySourceStatus='';
    	  stolenRecoveryRequestType=parseInt($("body").attr("data-requesttype"));
    	  //////console.log(" 333333stolenRecoverySourceStatus && stolenRecoveryRequestType is empty="+stolenRecoverySourceStatus+stolenRecoveryRequestType);
	   }
      else if(isNaN(stolenRecoveryRequestType) && isNaN(stolenRecoveryFileStatus))
    	  {
    	   stolenRecoveryRequestType=parseInt($("body").attr("data-requesttype"));
    	   stolenRecoveryFileStatus='';
    	   //////console.log(" 44444stolenRecoveryRequestType && stolenRecoveryFileStatus is empty "+stolenRecoveryRequestType+stolenRecoveryFileStatus);
    	  }
      else if(isNaN(stolenRecoveryFileStatus))
    	  {
    	  stolenRecoveryFileStatus='';
    	  //////console.log("stolenRecoveryFileStatus is blank="+stolenRecoveryFileStatus);
    	  }
      else if(isNaN(stolenRecoverySourceStatus))
	  {
    	  stolenRecoverySourceStatus='';
    	  //////console.log("stolenRecoverySourceStatus is blank="+stolenRecoverySourceStatus);
	  }
      else if(isNaN(stolenRecoveryRequestType))
	  {
    	  stolenRecoveryRequestType=parseInt($("body").attr("data-requesttype"));
    	  //////console.log("stolenRecoveryRequestType is blank="+stolenRecoveryRequestType);
	  }

	var table = $('#stolenLibraryTable').DataTable();
	var info = table.page.info(); 
	var pageNo=info.page;
	var pageSize =info.length;
	var operatorId;
	if(userType=="Operator"){
		 operatorId = parseInt($("body").attr("data-operatorTypeId"));
	}else{
		 operatorId = parseInt($('#operator').val());
	}
	
	var filterRequest={
			"endDate":stolenRecoveryEndDate,
			"startDate":stolenRecoveryStartDate,
			"txnId":stolenRecoveryTxnId,
			"consignmentStatus":stolenRecoveryFileStatus, 
			"sourceType":stolenRecoverySourceStatus,
			"requestType":stolenRecoveryRequestType,
			"featureId":featureId,
			"roleType":roleType,
			"operatorTypeId" : operatorId,
			"pageNo":parseInt(pageNo),
			"pageSize":parseInt(pageSize),
			"userTypeId": parseInt($("body").attr("data-usertypeid")),
			"userType":$("body").attr("data-roletype"),
			"userId" : $("body").attr("data-userid"),
			"quantity" : $('#IMEIQuantityFilter').val(),
			"deviceQuantity" : $('#deviceQuantityFilter').val()
			
			
	}
	//////console.log(JSON.stringify(filterRequest))
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url: './exportStolenRecovery?source='+source__val,
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


function deviceApprovalPopup(transactionId,requestType){
	$('#approveInformation').openModal({dismissible:false});
	$('#blockApproveTxnId').text(transactionId);
	window.transactionId=transactionId;
	window.requestType=requestType;
}

function aprroveDevice(){
	var approveRequest={
			"action" : 0,
			"featureId":parseInt(featureId),
			"requestType":parseInt(window.requestType),
			"roleType": $("body").attr("data-roletype"),
			"roleTypeUserId": parseInt($("body").attr("data-usertypeid")),
			"txnId": window.transactionId,
			"userId":parseInt($("body").attr("data-userid")),
			"userName" : $("body").attr("data-selected-username"),
			"userTypeId": parseInt($("body").attr("data-usertypeid")),
			"userType":$("body").attr("data-roletype")
			
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url : './blockUnblockApproveReject',
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		'async' : false,
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			//////console.log("approveRequest----->"+JSON.stringify(approveRequest));
			if(data.errorCode==0){
				confirmApproveInformation();
				//////console.log("inside Approve Success")
			}
else if(data.errorCode==5){
				$('#approveInformation').closeModal(); 
				$('#confirmApproveInformation').openModal({dismissible:false});
				$('#lawfulStolenDeleteSucessMsg').text('');
				$('#lawfulStolenDeleteSucessMsg').text($.i18n(data.tag));
				
			}
			else{
				$('#approveInformation').closeModal(); 
				$('#confirmApproveInformation').openModal({dismissible:false});
				$('#lawfulStolenDeleteSucessMsg').text('');
				$('#lawfulStolenDeleteSucessMsg').text($.i18n('errorMsg'));
			}
		},
		error : function() {
			$('#approveInformation').closeModal(); 
			$('#confirmApproveInformation').openModal({dismissible:false});
			$('#lawfulStolenDeleteSucessMsg').text('');
			$('#lawfulStolenDeleteSucessMsg').text($.i18n('errorMsg'));
		}
	});
}

function confirmApproveInformation(){
	$('#approveInformation').closeModal(); 
	setTimeout(function(){ $('#confirmApproveInformation').openModal({dismissible:false});}, 200);
}

function userRejectPopup(transactionId,requestType){
	$('#rejectInformation').openModal({dismissible:false});
	$('#rejectTxnId').text(transactionId);
	window.transactionId=transactionId;
	window.requestType=requestType;
} 	


function rejectUser(){
	var rejectRequest={
			"action" : 1,
			"featureId":parseInt(featureId),
			"remarks": $("#Reason").val(),
			"requestType":parseInt(window.requestType),
			"roleType": $("body").attr("data-roletype"),
			"roleTypeUserId": parseInt($("body").attr("data-usertypeid")),
			"txnId": window.transactionId,
			"userId":parseInt($("body").attr("data-userid")),
			"userName" : $("body").attr("data-selected-username"),
			"userTypeId": parseInt($("body").attr("data-usertypeid")),
			"userType":$("body").attr("data-roletype")
			
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	$.ajax({
		url : './blockUnblockApproveReject',
		data : JSON.stringify(rejectRequest),
		dataType : 'json',
		'async' : false,
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			//////console.log("approveRequest----->"+JSON.stringify(rejectRequest));
			if(data.errorCode==0){
				confirmRejectInformation();
				//////console.log("inside Reject Success")
			}

else if(data.errorCode==5){
				$('#rejectInformation').closeModal(); 
				$('#confirmRejectInformation').openModal({dismissible:false});
				$('#deviceRejectedMessage').text('');
				$('#deviceRejectedMessage').text($.i18n(data.tag));
			}
			else{
				$('#rejectInformation').closeModal(); 
				$('#confirmRejectInformation').openModal({dismissible:false});
				$('#deviceRejectedMessage').text('');
				$('#deviceRejectedMessage').text($.i18n('error'));
			}
		},
		error : function() {
			$('#rejectInformation').closeModal(); 
			$('#confirmRejectInformation').openModal({dismissible:false});
			$('#deviceRejectedMessage').text('');
			$('#deviceRejectedMessage').text($.i18n('error'));
		}
	});
	return false;
}

function confirmRejectInformation(){
	$('#rejectInformation').closeModal();
	setTimeout(function(){$('#confirmRejectInformation').openModal({dismissible:false});},200);
}




$("input[type=file]").keypress(function(ev) {
    return false;
    //ev.preventDefault(); //works as well

});

var stolenHistoryTable;
function historyRecord(txnID,sourceType){
	//////console.log("txn id=="+txnID)
	$("#tableOnModal").openModal({dismissible:false});
	 var filter =[];
	 var formData= new FormData();
	 
	 var userTypeValue=$("body").attr("data-roletype");
	 if(userTypeValue=='CEIRAdmin' && sourceType=='3'){
		 var filterRequest={
				 
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","operator_type_id","request_type","source_type","file_status","file_name",
					    "block_category","blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark",
					     "user_id","ceir_admin_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":7
		} 
		 
	 }
	 else if(userTypeValue=='CEIRAdmin' && sourceType=='4'){
		 var filterRequest={
				 
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","operator_type_id","request_type","source_type","file_status",
					    "block_category","blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark",
					     "user_id","ceir_admin_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":7
		} 
		
	 }
	 else if ((userTypeValue=='Operator' || userTypeValue=='Operation') && (sourceType=='4')){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","operator_type_id","request_type","source_type","file_status",
					    "block_category","blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark",
					     "user_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":7
		}
		 
	 }else{
		 var filterRequest={
				 
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","operator_type_id","request_type","source_type","file_status","file_name",
					    "block_category","blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark",
					     "user_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":7
		}
		 
	 }
	
	formData.append("filter",JSON.stringify(filterRequest));	
	if(lang=='km'){
		var langFile='./resources/i18n/khmer_datatable.json';
	}
	else if(lang=='en'){
		var langFile='./resources/i18n/english_datatable.json';
	}
	//////console.log("22");
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	if( stolenHistoryTable !== null && stolenHistoryTable !== undefined ){
		//console.log('Going to destroy history table');
		stolenHistoryTable.destroy();
		$('#data-table-history2').empty();
	}
	
	$.ajax({
		url: 'Consignment/consignment-history',
		type: 'POST',
		data: formData,
		async : false,
		processData: false,
		contentType: false,
		success: function(result){
			
			var dataObject = eval(result);
			//console.log(JSON.stringify(dataObject.data))
			stolenHistoryTable = $('#data-table-history2').DataTable({
				"destroy":true,
				"order" : [[1, "asc"]],
				"serverSide": false,
				 orderCellsTop : true,
				"ordering" : false,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"oLanguage": {  
					"sUrl": langFile  
				},	
				"scrollX": true,
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






$('#editblockdeviceIdType').on('change', function() {
	var value=parseInt($(this).val());

	switch (value) {
	case 0:
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").val('');
		//$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("pattern","[0-9]{15,16}");
		//$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("maxlength","16");
		
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").removeAttr("onkeyup");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		
		$('#errorMsgOnModal').text($.i18n('IMEIMsg'));
		
		break;
	case 1:
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("pattern","[A-F0-9]{15,16}");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("maxlength","16");
		
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").removeAttr("onkeyup");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$('#errorMsgOnModal').text($.i18n('MEIDMsg'));
		break;
	case 2:
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").val('');
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("pattern","[0-9]{8,11}");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("onkeyup","isLengthValid(this.value)");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("maxlength","11");	
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#errorMsgOnModal").text($.i18n('ESNMsg'));
		break;
	}

}); 

function isLengthValid(val){
	var deviceIDLength=val.length;
	if(!isNaN(val)){
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("pattern","[0-9]{11,11}");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("maxlength","11");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
	}
	else if(typeof val == 'string' || val instanceof String){
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("maxlength","8");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("pattern","[A-F0-9]{8,8}");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");
		$("#editsingleblockIMEI1,#editsingleblockIMEI2,#editsingleblockIMEI3,#editsingleblockIMEI4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");

	}
}


/*function resetDatatable(){
	//alert('called');
	$('#data-table-history2').DataTable().state.clear();
	//$('#data-table-history2').DataTable().clear().draw();
}*/

function filterResetBlockUnblock(formID){
	$('#endDate').css('border-color', '');
	$('#errorMsg').text('');
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	filterStolen(lang);
}