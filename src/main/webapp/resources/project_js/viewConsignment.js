var cierRoletype =$("body").attr("data-roleType");	
var startdate=$('#startDate').val(); 
var endDate=$('#endDate').val();
var taxStatus=$('#taxPaidStatus').val();
var txnId=$('#transactionID').val();
var consignmentStatus=$('#filterConsignmentStatus').val();
var userId = $("body").attr("data-userID");
var userType=$("body").attr("data-roleType");
var featureId="3";
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
	filterConsignment(lang,null);
	sessionStorage.removeItem("session-value");
	pageRendering();
});





function DeleteConsignmentRecord(txnId){
	$("#DeleteConsignment").openModal({dismissible:false});
	$("#transID").text(txnId);
}


function confirmantiondelete(){
	var txnId = $("#transID").text();
	var remarks = $("#textarea1").val();
	var obj ={
			"txnId" : txnId,
			"remarks" : remarks,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName":$("body").attr("data-username"),
			"roleType":$("body").attr("data-roleType")

	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./deleteConsignment",
		data : JSON.stringify(obj),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data, textStatus, xhr) {
			if(data.errorCode == 200){
				$("#consignmentText").text('');
				$("#consignmentText").text($.i18n(deleteInProgress ));

			}else if(data.errorCode == 0){
				$("#consignmentText").text('');
				$("#consignmentText").text(consignmentDeleted);
			}
			else if(data.errorCode==5){
				$('#consignmentText').text('');
				$('#consignmentText').text($.i18n(data.tag));
			}
			else{
				$('#consignmentText').text('');
				$("#consignmentText").text(errorMsg);
			}
		},
		error : function() {

		}
	});
	$("#DeleteConsignment").closeModal();
	$("#confirmDeleteConsignment").openModal({
		dismissible:false
	});
	return false;
}
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
});
$.getJSON('./getDropdownList/CUSTOMS_PORT', function(data) {
	$("#expectedArrivalPortEdit").empty();
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#expectedArrivalPortEdit');

	}
});




function EditConsignmentDetails(txnId){ 
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

			/*	$("#expectedArrivalPortEdit").empty();*/

			ConsignmentCurrency();
			setEditPopupData(data) ;
		},
		error : function() {
			//alert("Failed");
		}
	});

	$("#updateModal").openModal({
		dismissible:false
	});
}

function ConsignmentCurrency()
{
	var currency="CURRENCY";
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './consignmentCurency?CURRENCY='+currency,
		type: 'GET',
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {


			$('#currency').empty();
			for (i = 0; i < data.length; i++){
				var html='<option value="'+data[i].value+'">'+data[i].interp+'</option>';
				//$('<option>').val(data[i]).channnelName.text(data[i]).channnelName.appendTo('#channelId');
				$('#currency').append(html);	
			}
			$('#currency').val($("#hideCurrency").val()); 

		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});
}

function viewConsignmentCurrency()
{
	var currency="CURRENCY";
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './consignmentCurency?CURRENCY='+currency,
		type: 'GET',
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {



			/*	$('#viewcurrency').empty();*/
			for (i = 0; i < data.length; i++){
				var html='<option value="'+data[i].value+'">'+data[i].interp+'</option>';
				//$('<option>').val(data[i]).channnelName.text(data[i]).channnelName.appendTo('#channelId');
				$('#viewcurrency').append(html);	
			}

			//$('#viewcurrency').val($("#viewhideCurrency").val()); 

		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});
}

function viewConsignmentDetails(txnId){

	$("#viewModal").openModal({
		dismissible:false
	});

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
			setViewPopupData(data);
			viewConsignmentCurrency();
		},
		error : function() {
			//alert("Failed");
		}
	});
}


function setViewPopupData(data){
	var totalPrice='';
	////////console.log(data.totalPrice);
	if(data.totalPrice==null){
		totalPrice="";
		$("#viewCurrencyDiv").css("display", "none");

	}
	else{
		totalPrice=(test(data.totalPrice));
		
		$("#viewCurrencyDiv").css("display", "block");
	}
	$("#supplierId").val(data.supplierId);
	if(data.supplierId=="" || data.supplierId==null)
		{
		$("#supplierId").val('NA');
		}
	$("#supplierName").val(data.supplierName);
	if(data.supplierName=="" || data.supplierName==null)
	{
	$("#supplierName").val('NA');
	}
	$("#consignmentNumber").val(data.consignmentNumber);
	if(data.consignmentNumber=="" || data.consignmentNumber==null)
	{
	$("#consignmentNumber").val('NA');
	}
	$("#expectedDispatcheDate").val(data.expectedDispatcheDate);
	$("#countryview").val(data.organisationCountry);
	$("#expectedArrivaldate").val(data.expectedArrivaldate);
	$("#expectedArrivalPort").val(data.expectedArrivalPortInterp);
	$("#Quantity").val(data.quantity);
	$("#TransactionId").val(data.txnId);
	$("#remark").val(data.remarks);
	if(data.remarks=="" || data.remarks==null)
	{
	$("#remark").val('NA');
	}
	
	$("#fileName").val(data.fileName); 
	//$("#viewcurrency").val(data.currency);
	$("#viewtotalPrice").val(totalPrice);
	if(totalPrice=="" || totalPrice==null)
	{
	$("#viewtotalPrice").val('NA');
	}
	$("#viewhideCurrency").val(data.currency);
	if(data.currency=="" || data.currency==null)
	{
	$("#viewhideCurrency").val('NA');
	}
	$("#portAddress").val(data.portAddressInterp);
	if(data.portAddressInterp=="" || data.portAddressInterp==null)
	{
	$("#portAddress").val('NA');
	}
	$("#viewcurrency").val(data.currencyInterp);
	if(data.currencyInterp=="" || data.currencyInterp==null)
	{
	$("#viewcurrency").val('NA');
	}
	$('#deviceQuantity').val(data.deviceQuantity);
	if(data.deviceQuantity=="" || data.deviceQuantity==null)
	{
	$("#deviceQuantity").val('NA');
	}
}

function setEditPopupData(data){

	var totalPrice='';
	////////console.log(data.totalPrice);
	if(data.totalPrice==null){
		totalPrice="";
		$("#currencyDiv").css("display", "none"); 
	}
	else{
		totalPrice=(parseInt(data.totalPrice));
		$("#currencyDiv").css("display", "block"); 

	}
	$("#supplierIdEdit").val(data.supplierId);
	$("#supplierNameEdit").val(data.supplierName);
	$("#consignmentNumberEdit").val(data.consignmentNumber);
	$("#expectedDispatcheDateEdit").val(data.expectedDispatcheDate);
	$('#country').val(data.organisationCountry);
	$("#expectedArrivaldateEdit").val(data.expectedArrivaldate);
	$("#expectedArrivalPortEdit").val(data.expectedArrivalPort).change();
	$("#QuantityEdit").val(data.quantity);
	$("#TransactionIdEdit").val(data.txnId);
	$("#fileNameEdit").val(data.fileName);
	$("#fileNameToBeSame").val(data.fileName);

	$("#editPortAddress").val(data.portAddress);

	$("#currency").val(data.currency);
	$("#totalPrice").val(totalPrice);
	$("#hideCurrency").val(data.currency);
	$('#editDeviceQuantity').val(data.deviceQuantity);

	$("label[for='editDeviceQuantity']").addClass('active');			

} 



var sourceType =localStorage.getItem("sourceType");
function filterConsignment(lang,source)
{       	
	var source__val;

	if(source == 'filter' ) {
		source__val= source;
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

	if(cierRoletype=="Importer" && sourceType !="viaStolen" ){
		table(true,'./headers?lang='+lang+'&type=consignment','./consignmentData?sessionFlag='+sessionFlag+'&source='+source__val);
	}

	else if((cierRoletype=="Custom" || cierRoletype=="DRT") && sourceType !="viaStolen"){
		table(true,'./headers?lang='+lang+'&type=customConsignment','./consignmentData?sessionFlag='+sessionFlag+'&source='+source__val);
	}

	else if(cierRoletype=="CEIRAdmin"  && sourceType !="viaStolen"){
		table(true,'./headers?lang='+lang+'&type=adminConsignment','./consignmentData?sessionFlag='+sessionFlag+'&source='+source__val);
	}  

	else if(cierRoletype=="Importer" && sourceType ==="viaStolen" ){

		table(true,'./headers?lang='+lang+'&type=stolenconsignment','./consignmentData?sourceType=viaStolen&sessionFlag='+sessionFlag+'&source='+source__val);
	}


	localStorage.removeItem('sourceType');

}



//**************************************************filter table**********************************************

function table(isSort,url,dataUrl){
	
	
	var txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;

	var filterRequest={
			"consignmentStatus":parseInt($('#filterConsignmentStatus').val()),
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"taxPaidStatus":parseInt($('#taxPaidStatus').val()),
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName":$("body").attr("data-username"),
			"txnId": $('#transactionID').val() == null ? txn : $('#transactionID').val(),
			"roleType":$("body").attr("data-roleType"),
			"displayName" : $('#name').val(),
			"quantity" : $('#IMEIQuantityFilter').val(),
			"deviceQuantity" : $('#deviceQuantityFilter').val(),
			"supplierName" : $('#supplierNameFilter').val()
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
		/*	headers: {"Accept-Language": "en"},*/
		type: 'POST',
		dataType: "json",
		success: function(result){
			var table=	$("#consignmentLibraryTable").DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : isSort,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"bSearchable" : true,
				"oLanguage": {  
					"sUrl": langFile  
				},/*
				"aaSorting": [[ 0, "desc" ]],*/
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
					url : dataUrl,
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



//******************************************************************************************************************************************************************888888
//******************************************************************************************************************************************************************888888
//******************************************************************************************************************************************************************888888   

function editRegisterConsignment(){
	$('div#initialloader').fadeIn('fast');
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
	var currency=$('#currency').val();
	var totalPrice=$('#totalPrice').val();
	currency=parseInt(currency);
	if ( isNaN(currency))
	{
		currency='';
	}
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
	formData.append('currency',currency);
	formData.append('totalPrice',totalPrice);
	formData.append('featureId', parseInt(featureId));
	formData.append('userTypeId', parseInt($("body").attr("data-userTypeID")));
	formData.append('userType', $("body").attr("data-roleType"));
	formData.append('userName', $("body").attr("data-username"));
	formData.append('portAddress', parseInt($('#editPortAddress').val()));
	formData.append('deviceQuantity', parseInt($('#editDeviceQuantity').val()));
	formData.append('roleType', $("body").attr("data-roleType"));

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './updateRegisterConsignment',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR) {
			$('div#initialloader').delay(300).fadeOut('slow');
			$('#updateModal').closeModal();

			$('#updateConsignment').openModal({
				dismissible:false
			});
			if(data.errorCode==200){


				$('#sucessMessage').text('');
				$('#sucessMessage').text(data.message);
			}

			else if (data.errorCode==0){

				$('#sucessMessage').text('');
				$('#sucessMessage').text(updateMsg+" "+ (data.txnId) +" "+hasBeenUpdated);
			}
			else if(data.errorCode==5){
				$('#sucessMessage').text('');
				$('#sucessMessage').text($.i18n(data.tag));
			}
			else 
			{
				$('#sucessMessage').text('');
				$('#sucessMessage').text(data.message);
			}

		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});

	return false;
}



function openDeleteModal(transactionId)
{
	$('#deletemodal').openModal({
		dismissible:false
	});
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
	$("#deleteFormID").trigger("reset");
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

function pageRendering(){
	if(sourceType !="viaStolen" ){
		pageButtons('./consignment/pageRendering');

	}else if(sourceType ==="viaStolen" ){
		pageButtons('./consignment/pageRendering?sourceType=viaStolen');

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
			/*	if(window.parent.$("body").attr("data-usertype") == "CEIRAdmin"){*/
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


			if(sourceType=="viaStolen"){
				$("#btnLink").css({display: "none"});

				$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
				$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$("#consignmentTableDIv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right' onclick='exportConsignmentData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
			
				$('#clearFilter').attr("onclick", "filterResetConsignment('viewFilter')");	
				for(i=0; i<button.length; i++){
					$('#'+button[i].id).text(button[i].buttonTitle);
					if(button[i].type === "HeaderButton"){
						$('#'+button[i].id).attr("href", button[i].buttonURL);
					}
					else{
						$('#'+button[i].id).attr("onclick", button[i].buttonURL);
					}
				}

				$("#footerBtn").append("<div class='col s12 m2 l2'><button class='btn' id='markedstolen' style='margin-left:38%;margin-top: 8px;'></button><button class='btn' id='cancel' style='margin-left: 22px;margin-top: 8px;'></button></div>");
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
				var viewFilter="viewFilter";
			
				$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
				$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
				$("#consignmentTableDIv").append("<div class='filter_btn'><a href='JavaScript:void(0)' type='button' class='export-to-excel right'  onclick='exportConsignmentData()'>"+$.i18n('Export')+"<i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
				
				$('#clearFilter').attr("onclick", "filterResetConsignment('viewFilter')");	
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
			sourceType=="viaStolen"? $("#btnLink").css({display: "none"}) : $("#btnLink").css({display: "block"});

			if(cierRoletype=="CEIRAdmin" || cierRoletype=="Custom" || cierRoletype=="DRT" ){ 
				$("#btnLink").css({display: "none"}); 
			}
			//Consignment status-----------dropdown
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
			});
			$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-userTypeID"), function(data) {

				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].state).text(data[i].interp)
					.appendTo('#filterConsignmentStatus');
				}
				var consignmentStatus= $("body").attr("data-selected-consignmentStatus");

				if(consignmentStatus=="")
				{


				}
				else{

					$("#filterConsignmentStatus").val(consignmentStatus).change();
				}
			});



			//Tax paid status-----------dropdown
			$.getJSON('./getTypeDropdownList/CUSTOMS_TAX_STATUS/'+$("body").attr("data-userTypeID"), function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#taxPaidStatus');
				}
			});

			var txnid = $("body").attr("data-selected-consignmentTxnId");

			/* 	$('#transactionID').val('');
					$('#transactionID').val(txnid); */
			//$('#transactionID').attr("placeholder","" );
			if(txnid=="")
			{

			}
			else{

				$('label[for=TransactionID]').remove();
			}

			/*$('.datepicker').datepicker({
						dateFormat: "yy-mm-dd",
						 maxDate: new Date()
					});*/
		}
	}); 
	//	$("#consignmentTableDIv").append("<span id='errorMsg'></span>");

}






function openApprovePopUp(txnId)
{
	var userType=$("body").attr("data-roleType");
	//displayName=displayName.replaceAll("+20"," " );
	$('#ApproveConsignment').openModal({dismissible:false});
	if(userType=='Custom'){
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
				//////console.log(data.pendingTacApprovedByCustom);
				//////console.log(data.pendingTacApprovedByCustom);

				if(data.pendingTacApprovedByCustomInterp=='N')
				{
					$('#tacSatusForCustom').css("display", "none");
					$('#approveButton').prop('disabled', false);

				}

				else{
					$('#tacSatusForCustom').css("display", "block"); 
					$('#tacStatucMessage').text('');
					$('#tacStatucMessage').text($.i18n('tacStatucMessage'));
					$('#approveButton').prop('disabled', true);
				}
			},

			error : function() {
				//alert("Failed");
			}
		});

		$('#ApproveConsignmentTxnid').text(txnId);
		$('#setApproveConsignmentTxnId').val(txnId);
		//$('#displayname').text(displayName);

	}
	else{
		$('#approveConsignmnetHeading').text('');
		$('#approveConsignmnetHeading').text(havingTxnID+txnId+'?');
		$('#confirmationMessage').text('');
		$('#setApproveConsignmentTxnId').val(txnId);
		//$('#displayname').text(displayName);
		$('#approveButton').attr('disabled', false); 

	}



}

function approveSubmit(actiontype){
	var txnId=$('#setApproveConsignmentTxnId').val();

	var approveRequest={
			"action": actiontype,
			"txnId":txnId,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"roleTypeUserId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName":$("body").attr("data-username"),
			"roleType":$("body").attr("data-roleType"),
			"userTypeId":parseInt($("body").attr("data-userTypeID"))
			
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./updateConsignmentStatus",
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			$('#confirmApproveConsignment').openModal({
				dismissible:false
			});
			if(data.errorCode==0){

				$('#approveSuccessMessage').text('');
				$('#approveSuccessMessage').text(consignmentApproved);
			}
			else if(data.errorCode==5){
				$('#approveSuccessMessage').text('');
				$('#approveSuccessMessage').text($.i18n(data.tag));
			}
			else{
				$('#approveSuccessMessage').text('');
				$('#approveSuccessMessage').text(errorMsg);
			}
		},
		error : function() {

		}
	});
}

function openDisapprovePopup(txnId)
{
	//displayName=displayName.replace(/20/g," " );
	$('#RejectConsignment').openModal({
		dismissible:false
	});
	$('#disaproveTxnId').text(txnId);
	$('#setDisapproveConsignmentTxnId').val(txnId);
	//$('#disapprovedDisplayname').text(displayName);


}

function disapproveSubmit(actiontype){
	var txnId=$('#setDisapproveConsignmentTxnId').val();
	var Remark=$('#dispproveRemarks').val();

	var approveRequest={
			"action": actiontype,
			"txnId":txnId,
			"remarks":Remark,
			"userId":parseInt(userId),
			"featureId":parseInt(featureId),
			"roleTypeUserId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"userName":$("body").attr("data-username"),
			"roleType":$("body").attr("data-roleType")
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./updateConsignmentStatus",
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			setTimeout(function(){ $('#confirmRejectConsignment').openModal({
				dismissible:false
			});}, 200);

			if(data.errorCode==0){

				$('#disapproveSuccessMessage').text('');
				$('#disapproveSuccessMessage').text(rejectedMsg);
			}
			else if(data.errorCode==5){
				$('#disapproveSuccessMessage').text('');
				$('#disapproveSuccessMessage').text($.i18n(data.tag));
			}
			else{
				$('#disapproveSuccessMessage').text('');
				$('#disapproveSuccessMessage').text(errorMsg);
			}
		},
		error : function() {

		}
	});
	return false;
}	


function valuesPush(){
	var selectedMultipleConsignment=[];
	var roleType = $("body").attr("data-roleType");
	var currentRoleType = $("body").attr("data-stolenselected-roleType"); 
	var role = currentRoleType == null ? roleType : currentRoleType;
	var requestType=0;
	$('#consignmentLibraryTable tr td input:checkbox:checked').each(function() {

		var json={
				"txnId":$(this).closest('tr').find('td:eq(2)').text(),
				"userId":userId,
				"sourceType":'0',
				"roleType":role,
				"requestType":requestType
		}
		selectedMultipleConsignment.push(json);
	});
	return selectedMultipleConsignment;
}



function markedstolen(){
	$('#markAsMultipleStolen').openModal({
		dismissible:false
	});

}

function openMulipleStolenPopUp()
{

	var stolenRecoverydata=JSON.stringify(valuesPush());
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
			$('#markAsStolenDone').openModal({
				dismissible:false
			});
		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});

}
function redirectToViewPage()
{
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var currentRoleType = $("body").attr("data-stolenselected-roleType"); 
	var role = currentRoleType == null ? roleType : currentRoleType;
	window.location.href = "./stolenRecovery?userTypeId="+role;

}

//**********************************************************Export Excel file************************************************************************
function exportConsignmentData()
{
	var consignmentStartDate=$('#startDate').val();
	var consignmentEndDate=$('#endDate').val();
	var consignmentTxnId=$('#transactionID').val();
	var filterConsignmentStatus=parseInt($('#filterConsignmentStatus').val());
	var consignmentTaxPaidStatus=parseInt($('#taxPaidStatus').val());
	var displayName = $('#name').val();
	var deviceQuantity= $('#deviceQuantityFilter').val();
	var IMEIQuantity= $('#IMEIQuantityFilter').val();
	var supplierName=$('#supplierNameFilter').val();
	if(displayName==undefined || displayName=="undefined"){
		displayName=null;
	}
	if(supplierName==undefined || supplierName=="undefined"){
		supplierName="";
	}
	
	//var source__val = consignmentStartDate != ''|| consignmentEndDate != ''|| consignmentTxnId != ''|| filterConsignmentStatus != 'NaN'|| consignmentTaxPaidStatus != 'NaN'|| consignmentName != undefined ? 'filter' : $("body").attr("data-session-source");

	var source__val;
	if(isNaN(consignmentTaxPaidStatus) && isNaN(filterConsignmentStatus) )
	{
		consignmentTaxPaidStatus="";
		filterConsignmentStatus='';

	}
	else if(isNaN(consignmentTaxPaidStatus))
	{
		consignmentTaxPaidStatus="";

	}
	else if(isNaN(filterConsignmentStatus))
	{
		filterConsignmentStatus='';

	}
	var consignmentSource= $("body").attr("data-session-source");
	if(consignmentSource=='noti')
	{
		consignmentTxnId=$("body").attr("session-valueTxnID");
		//////console.log("  consignmentTxnId  ==="+consignmentTxnId);
	}

	////console.log("2------>"+"consignmentStartDate---" +consignmentStartDate+  "consignmentEndDate---" +consignmentEndDate +  "consignmentTxnId---" +consignmentTxnId+  "filterConsignmentStatus---" +filterConsignmentStatus+  "consignmentTaxPaidStatus---" +consignmentTaxPaidStatus);
	if(consignmentStartDate != ''  || consignmentEndDate != ''  || consignmentTxnId != ''  || filterConsignmentStatus != ''  || consignmentTaxPaidStatus != ''  || displayName!=undefined || deviceQuantity!=undefined || IMEIQuantity!=undefined || supplierName!=undefined){
		source__val = 'filter';
	}else{
		source__val = $("body").attr("data-session-source");
	}
	//////console.log("source__val-->"+ source__val);
	var table = $('#consignmentLibraryTable').DataTable();
	var info = table.page.info(); 
	var pageNo=info.page;
	var pageSize =info.length;
	window.location.href="./exportConsignmnet?consignmentStartDate="+consignmentStartDate+"&consignmentEndDate="+consignmentEndDate+"&consignmentTxnId="+consignmentTxnId+"&filterConsignmentStatus="+filterConsignmentStatus+"&consignmentTaxPaidStatus="+consignmentTaxPaidStatus+"&source="+source__val+"&displayName="+displayName+"&pageSize="+pageSize+"&pageNo="+pageNo+"&deviceQuantity="+deviceQuantity+"&quantity="+IMEIQuantity+"&supplierName="+supplierName;
}



function clearFileName() {
	var existingfile=$("#fileNameToBeSame").val();
	//$('#fileNameEdit').val('');
	$("#csvUploadFile").val('');
	$('#fileFormateModal').closeModal();

	$("#fileNameEdit").val(existingfile);
}



$(document).on("keyup", "#totalPrice", function(e) {
	var totalPrice=$('#totalPrice').val();
	if(totalPrice.length<'1' )
	{
		$("#currency").attr("required", false);
		/*$('#currency').attr("disabled",true);*/
		$('#currencyDiv').hide();

		//$("#currency")[0].selectedIndex = 0;

	}
	else
	{
		$("#currency").attr("required", true);
		/*$('#currency').attr("disabled",false);*/
		$('#currencyDiv').show();

	}
});	



function clearFileName() {
	var existingfile=$("#fileNameToBeSame").val();
	//$('#fileNameEdit').val('');
	$("#csvUploadFile").val('');
	$('#fileFormateModal').closeModal();

	$("#fileNameEdit").val(existingfile);
}



$(document).on("keyup", "#totalPrice", function(e) {
	var totalPrice=$('#totalPrice').val();
	if(totalPrice.length<'1' )
	{
		$("#currency").attr("required", false);
		/*$('#currency').attr("disabled",true);*/
		$('#currencyDiv').hide();

		//$("#currency")[0].selectedIndex = 0;

	}
	else
	{
		$("#currency").attr("required", true);
		/*$('#currency').attr("disabled",false);*/
		$('#currencyDiv').show();

	}
});


$('#tacStatusChecKbox').click(function () {
	//check if checkbox is checked
	if ($(this).is(':checked')) {

		$('#approveButton').removeAttr('disabled'); //enable input

	}
	else {
		$('#approveButton').attr('disabled', true); //disable input
	}
});



function consignmentFileDownload(fileName,fileType,txnId,doc_TypeTag)
{
	fileName=fileName.split("%20").join(" ");
	//////console.log(" fileName "+fileName+" fileType  "+fileType+" txnId "+txnId+"  doc_TypeTag "+doc_TypeTag)
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./Consignment/dowloadFiles/"+fileType+'/'+fileName+'/'+txnId+'/'+doc_TypeTag,
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		success : function(data) {
			//////console.log(data);
			if(data.url=='Not Found')
			{

				$('#fileFormateModal').openModal({
					dismissible:false
				});
				$('#fileErrormessage').text('')
				$('#fileErrormessage').text($.i18n('fileNotFound'));
			}
			else{
				//////console.log("file is found");
				window.location.href=data.url;

			}

		},
		error : function() {

		}
	});
}

$("input[type=file]").keypress(function(ev) {
	return false;
	//ev.preventDefault(); //works as well

});


function openDRTPopUp(recordId){
	var userType=$("body").attr("data-roleType");
	window.recordId = recordId;
	$('#PayDRTtaxPopup').openModal({dismissible:false});
	$('#amount').val('');
}

function payTaxDRT(){

	var request ={ 
			"amount" : parseFloat($("#amount").val()),
			"userId" : parseInt(window.recordId)

	}

	//////console.log("request--->" +JSON.stringify(request))
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './payTax',
		type: 'POST',
		data : JSON.stringify(request),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		success: function (data, textStatus, jqXHR) {
			//////console.log("Updated data---->" +data)
			$("#PayDRTtaxPopup").closeModal();	
			if(data.errorCode == 200){
				window.open(data.data.url);
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});	

	return false

}







function getByPort(port) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'GET',
		url : './byArrivalPort/' + port,
		contentType : "application/json",
		dataType : 'html',
		async : false,
		success : function(data) {
			var response = JSON.parse(data);
			var asTypeDropdown = $("#editPortAddress");
			asTypeDropdown.empty();
			var header = "<option value='' disabled selected>Select address</option>";
			asTypeDropdown.append(header);
			for (var i = 0; i < response.length; i++) {
				var data2 = '<option value="' + response[i].id + '">'
				+ response[i].address + '</option>';
				asTypeDropdown.append(data2);
			}
		},
		error : function(xhr, ajaxOptions, thrownError) {
		}
	});
}






function historyRecord(txnID){

	$("#tableOnModal").openModal({dismissible:false});
	var filter =[];
	var formData= new FormData();
	var ceirAdmin='';
	var userTypeValue=$("body").attr("data-roleType");
	if(userTypeValue=='CEIRAdmin')
	{

		var filterRequest={

				"columns": [
					"created_on","modified_on","txn_id","consignment_status","supplier_id","supplier_name","consignment_number","expected_dispatche_date","expected_arrivaldate","organisation_country",
					"expected_arrival_port","port_address","quantity","device_quantity","remarks","total_price","currency",
					"tax_paid_status","user_id","ceir_admin_id","custom_id"
					],
					"tableName": "consignment_mgmt_aud",
					"dbName" : "ceirconfig",
					"txnId":txnID,
					"featureId":3
		}

	}
	else if(userTypeValue=='Custom'){
		ceirAdmin="custom_id";
		var filterRequest={

				"columns": [
					"created_on","modified_on","txn_id","consignment_status","supplier_id","supplier_name","consignment_number","expected_dispatche_date","expected_arrivaldate","organisation_country",
					"expected_arrival_port","port_address","quantity","device_quantity","remarks","total_price","currency",
					"tax_paid_status","user_id","custom_id"
					],
					"tableName": "consignment_mgmt_aud",
					"dbName" : "ceirconfig",
					"txnId":txnID,
					"featureId":3
		}
	}
	else{
		ceirAdmin="'ceir_admin_id'"+','+"'custom_id'";
		var filterRequest={

				"columns": [
					"created_on","modified_on","txn_id","consignment_status","supplier_id","supplier_name","consignment_number","expected_dispatche_date","expected_arrivaldate","organisation_country",
					"expected_arrival_port","port_address","quantity","device_quantity","remarks","total_price","currency",
					"tax_paid_status","user_id"
					],
					"tableName": "consignment_mgmt_aud",
					"dbName" : "ceirconfig",
					"txnId":txnID,
					"featureId":3
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
		url: './Consignment/consignment-history',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function(result){
			var dataObject = eval(result);
			////alert(JSON.stringify(dataObject.data))
			$('#data-table-history').dataTable({
				"order" : [[1, "asc"]],
				destroy:true,
				"serverSide": false,
				orderCellsTop : true,
				"ordering" : false,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"scrollX": true,
				"scrolly": true,
				"oLanguage": {  
					"sUrl": langFile  
				},
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


function filterResetConsignment(formID){
	$('#endDate').css('border-color', '');
	$('#errorMsg').text('');
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	filterConsignment(lang,null);
}

