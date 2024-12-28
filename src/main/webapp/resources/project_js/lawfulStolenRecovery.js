

var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-stolenselected-roleType");  
var role = currentRoleType == null ? roleType : currentRoleType;
var userType = $("body").attr("data-roleType");
var featureId = window.parent.$('.navData li.active a').attr('data-featureid');
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
	$('div#initialloader').fadeIn('fast');
	filterStolen(lang,null);
	pageRendering();

});

$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});

var userType = $("body").attr("data-roleType");
var sourceType = localStorage.getItem("sourceType");

function filterStolen(sourceTypeFiler,source){
	
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
	//////console.log(" ****** sourceType ="+sourceTypeFiler);
	var userTypeId = $("body").attr("data-userTypeID");
	if(userType=="Lawful Agency"){
		Datatable('./headers?type=lawfulStolenHeaders','./stolenData?featureId='+featureId+'&userTypeId='+userTypeId+'&source='+source__val,source__val)
	}else if(userType =="CEIRAdmin"){
		Datatable('./headers?type=lawfulStolenHeaders','./stolenData?featureId='+featureId+'&userTypeId='+userTypeId+'&source='+source__val,source__val)
	}
	localStorage.removeItem('sourceType');
}




function Datatable(url,DataUrl,sourceTypeFiler){
	//////console.log(" == sourceType ="+sourceTypeFiler);
	$('div#initialloader').fadeIn('fast');
	var requestType='';
	var userType=$("body").attr("data-roleType");
	if (sourceTypeFiler=="filter")
		{
		
		requestType = parseInt($('#requestType').val())
		}
	else{
		requestType = parseInt($("body").attr("data-requestType"));
	  }
	//////console.log("=== requestType======"+requestType)
	var txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;
	
	if (sourceTypeFiler=="filter")
	{
		if($("body").attr("data-session-source")=='noti'){
			
			txn=$('#transactionID').val();
		}
		$("body").attr("data-session-source","filter");
		txn=$('#transactionID').val();
	}
	
	var filterRequest={
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"txnId":txn,
			"consignmentStatus":parseInt($('#status').val()),
			"requestType":requestType ,
			"sourceType":parseInt($('#sourceStatus').val()),
			"roleType": roleType,
			"userId": userId,
			"featureId":featureId,
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":userType ,
			"userName" : $("body").attr("data-username"),
			"quantity" : $('#IMEIQuantityFilter').val(),
			"deviceQuantity" : $('#deviceQuantityFilter').val(),
			"blockingTypeFilter" : $('#blockingTypeFilter').val()
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
				"oLanguage": {  
					"sUrl": langFile  
				},
				scrollCollapse: true,
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
					url: DataUrl,
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
					{ width: 245, targets: result.length - 1 },
					 { orderable: false, targets: -1 }
					]
			});
			$('div#initialloader').delay(300).fadeOut('slow');
			
		}
	}); 
}				

function pageRendering(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});

	$.ajax({
		url: './stolen/pageRendering?featureId='+featureId,
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
			
			

			$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
			$("#consignmentTableDIv").append("<div class='filter_btn'><button type='button' class='btn primary botton'  id='clearLawfullFilter'>"+$.i18n('clearFilter')+"</button></div>");
			$("#consignmentTableDIv").append("<div class='filter_btn'><a href='JavaScript:void(0);' onclick='exportStolenRecoveryData()'  class='export-to-excel right'>"+$.i18n('Export')+" <i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
			$('#clearLawfullFilter').attr("onclick", "filterResetLawfull('LawfullStolenFilterForm')");	
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);
			}

			$('.datepicker').datepicker({
				dateFormat: "yy-mm-dd"
			});
		}


	}); 

	setAllDropdowns();
	if(userType=="CEIRAdmin"){
		$("#btnLink").css({display: "none"});
	}

}	 

function setAllDropdowns(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});


	//Request Type status-----------dropdown
	$.getJSON('./getTypeDropdownList/REQ_TYPE/'+$("body").attr("data-userTypeID")+'', function(data) {
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
	$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-userTypeID"), function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].state).text(data[i].interp)
			.appendTo('#status'); 
		}
	});


	$.getJSON('./getDropdownList/BLOCKINGTYPE', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#blockingTypeFilter');
		}
		/*$('<option>').val("-1").text("Operation")
		.appendTo('#operator');*/
	});
}

function openStolenRecoveryModal(){
	//////console.log("openStolenRecoveryModal===");
	$('#stoleRecoveryModal').openModal({
		dismissible:false
	});
}

//**********************************************************Export Excel file************************************************************************
function exportStolenRecoveryData()
{
	var source__val;	
	var startDate = $('#startDate').val(); 
	var endDate = $('#endDate').val();
	var transactionId = $('#transactionID').val();
	var status  = $('#status').val();
	var mode = $('#sourceStatus').val();
	var requestType =  $('#requestType').val(); 
	 
	 
	var source__val = startDate != ''|| endDate != ''|| transactionId != ''|| status != "Status"|| mode != "Mode"|| requestType != "Request Type" ? 'filter' : $("body").attr("data-session-source");
	
	//////console.log("startDate---" +startDate+  "endDate---" +endDate +  "transactionId---" +transactionId+  "status---" +status+  "mode---" +mode+  "requestType---" +requestType); 
	//////console.log("source__val--->" +source__val);
	var stolenRecoveryStartDate=$('#startDate').val();
	var stolenRecoveryEndDate=$('#endDate').val();
	var stolenRecoveryTxnId=$('#transactionID').val();
	var stolenRecoveryFileStatus=parseInt($('#status').val());
	var stolenRecoverySourceStatus=parseInt($('#sourceStatus').val());
	var stolenRecoveryRequestType=parseInt($('#requestType').val());
	

	var roleType = $("body").attr("data-roleType");
	var currentRoleType = $("body").attr("data-stolenselected-roleType");

	var role = currentRoleType == null ? roleType : currentRoleType;
	//////console.log("roleType=="+roleType+" currentRoleType="+currentRoleType+" role="+role);
	var blockUnblcksource= $("body").attr("data-session-source");
	
	if(blockUnblcksource=='noti')
		{
		//////console.log("export noti data=="+$("body").attr("data-notificationTxnID"));
		stolenRecoveryTxnId=$("body").attr("data-notificationTxnID");
		source__val=$("body").attr("data-session-source");
		}
	else if(blockUnblcksource=='dashboard')
	{
	//////console.log("export noti data=="+$("body").attr("data-notificationTxnID"));
	stolenRecoveryTxnId=$("body").attr("data-notificationTxnID");
	source__val=$("body").attr("data-session-source");
	}
	//////console.log("stolenRecoveryFileStatus=="+stolenRecoveryFileStatus+" stolenRecoverySourceStatus=="+stolenRecoverySourceStatus+" stolenRecoveryRequestType="+stolenRecoveryRequestType)
	if(isNaN(stolenRecoveryFileStatus) && isNaN(stolenRecoverySourceStatus) && isNaN(stolenRecoveryRequestType) && blockUnblcksource=='dashboard')
	{
		stolenRecoveryFileStatus='';
		stolenRecoverySourceStatus='';
		stolenRecoveryRequestType=parseInt($("body").attr("data-requestType"));
		
		//////console.log(" 11111111stolenRecoveryFileStatus && stolenRecoverySourceStatus && stolenRecoveryRequestType is empty =="+stolenRecoveryFileStatus+stolenRecoverySourceStatus);
	}
	else if(isNaN(stolenRecoveryFileStatus) && isNaN(stolenRecoverySourceStatus) && isNaN(stolenRecoveryRequestType) && blockUnblcksource=='filter')
	{
		stolenRecoveryFileStatus='';
		stolenRecoverySourceStatus='';
		stolenRecoveryRequestType=null;
		
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
		stolenRecoveryRequestType=parseInt($("body").attr("data-requestType"));
	 
		//////console.log(" 333333stolenRecoverySourceStatus && stolenRecoveryRequestType is empty="+stolenRecoverySourceStatus+stolenRecoveryRequestType);
	}
	else if(isNaN(stolenRecoveryRequestType) && isNaN(stolenRecoveryFileStatus))
	{
		stolenRecoveryRequestType=parseInt($("body").attr("data-requestType"));
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
		stolenRecoveryRequestType=parseInt($("body").attr("data-requestType"));
		 
		//////console.log("stolenRecoveryRequestType is blank="+stolenRecoveryRequestType);
	}
	
	if(blockUnblcksource=='menu'){
		source__val="menu";
	}
	var table = $('#stolenLibraryTable').DataTable();
	var info = table.page.info(); 
	var pageNo=info.page;
	var pageSize =info.length;

	var filterRequest={
			"endDate":stolenRecoveryEndDate,
			"startDate":stolenRecoveryStartDate,
			"txnId":stolenRecoveryTxnId,
			"consignmentStatus":stolenRecoveryFileStatus,
			"sourceType":stolenRecoverySourceStatus,
			"requestType":stolenRecoveryRequestType,
			"featureId":featureId,
			"roleType":roleType,
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType": $("body").attr("data-roleType"),
			"pageNo":parseInt(pageNo),
			"pageSize":parseInt(pageSize),
			"quantity" : $('#IMEIQuantityFilter').val(),
			"deviceQuantity" : $('#deviceQuantityFilter').val(),
			"blockingTypeFilter" : $('#blockingTypeFilter').val()
			
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


function openStolenRecoveryModal()
{
	$('#chooseStolenOption').openModal({
		dismissible:false
	});
}

function openStolenRecoveryPage(pageType,pageView,txnId,reqSource)
{
	window.location.href = "./openlawfulStolenRecoveryPage?pageType="+pageType+"&pageView="+pageView+"&txnId="+txnId+"&reqSource="+reqSource;
}

function showSingleFormDiv()
{
	$("#SingleForm").css("display", "block");
	$("#Bulkform").css("display", "none");

	$('#singleFormSubmit').trigger("reset");
	$('#bulkFormSubmit').trigger("reset");

}
function  showBulkFormDiv(){

	$("#SingleForm").css("display", "none");
	$("#Bulkform").css("display", "block");

	$('#singleFormSubmit').trigger("reset");
	$('#bulkFormSubmit').trigger("reset");

}

function singleRecoverydiv()
{
	$("#singleRecoveryDiv").css("display", "block");
	$("#bulkRecoveryDiv").css("display", "none");

	$('#singleRecoveryForm').trigger("reset");
	$('#bulkRecoveryForm').trigger("reset");

}
function  showBulkRecovery(){

	$("#singleRecoveryDiv").css("display", "none");
	$("#bulkRecoveryDiv").css("display", "block");

	$('#singleRecoveryForm').trigger("reset");
	$('#bulkRecoveryForm').trigger("reset");
	$("#bulkRecoverycountry").val("Cambodia").change();
	//$("#bulkRecoverycountry").attr("style", "pointer-events: none;");

}



var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});

$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#singleStolendeviceIDType,#sigleRecoverydeviceIDType');

	}
});

$.getJSON('./getSourceTypeDropdown/DOC_TYPE/12', function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].tagId).text(data[i].interp).attr("docValue",data[i].value).appendTo('#docTypetag1');

	}
});

$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#singleStolendeviceType,#sigleRecoverydeviceType');

	}
});

$.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#sigleRecoverydeviceSimStatus,#singleStolenSimStatus');

	}
});
$.getJSON('./getDropdownList/ADDRESS_TYPE', function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#addressType');

	}
});

$.getJSON('./getDropdownList/OPERATORS', function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#singleStolenOperator,#singleStolenOperator3,#singleStolenOperator4,#singleStolenOperator5');
	}
});

$.getJSON('./getDropdownList/COMPLAINT_TYPE', function(data) {

	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#singleStolenComplaintType,#deviceBulkStolenComplaint');
	}
});


$.getJSON('./getDropdownList/DEVICE_STATUS', function(data) {
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].value).text(data[i].interp)
		.appendTo('#sigleRecoverydeviceStatus');

	}
});

var RequestData = {
		"tag" : "GREY_TO_BLACK_MOVE_PERIOD_IN_DAY"
}
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});

$.ajax({
	url : "./system/viewTag",
	data :	JSON.stringify(RequestData),
	dataType : 'json',
	contentType : 'application/json; charset=utf-8',
	type : 'POST',
	success : function(data) {
		//////console.log(data.value);
		$('#defaultDatePeriod,#bulkDefaultPeiod,#editIndivisualDefaultPeriod,#editBulkDefaultPeriod').attr('title', data.value+' Days');
	},
	error : function() {
		//////console.log("Failed");
	}
});


function saveIndivisualStolenRequest(){
	if($('#singleStolendeviceIDType').val()==0){
		

		var luhnIMEI1=luhnCheck('singleStolenimei1','singleStolendeviceIDType');
		var luhnIMEI4=null;
		var luhnIMEI3=null;
		var luhnIMEI2=null;
		if($('#singleStolenimei2').val()!=null || $('#singleStolenimei2').val()!=''){
			
			var luhnIMEI2 =luhnCheck('singleStolenimei2','singleStolendeviceIDType')	
		}
		
		 if($('#singleStolenimei3').val()!=null || $('#singleStolenimei3').val()!=''){
			
			var luhnIMEI3 = luhnCheck('singleStolenimei3','singleStolendeviceIDType')	
		}
		
		 if($('#singleStolenimei4').val()!=null || $('#singleStolenimei4').val()!=''){
			 luhnIMEI4= luhnCheck('singleStolenimei4','singleStolendeviceIDType')	
		}
		
	//	alert("luhnIMEI1 "+luhnIMEI1+" luhnIMEI2 = "+luhnIMEI2+" luhnIMEI3 "+luhnIMEI3+" luhnIMEI4 = "+luhnIMEI4);
		if(luhnIMEI1==false || luhnIMEI2==false || luhnIMEI3==false || luhnIMEI4==false)
		{
			//alert("failed");
			return false
		}
		
		var checkIMEI=checkDuplicateImei($('#singleStolenimei1').val(),$('#singleStolenimei2').val(),$('#singleStolenimei3').val(),$('#singleStolenimei4').val());
		if(checkIMEI===true){
		$('#errorMsgOnModal').text('');
		$('#errorMsgOnModal').text($.i18n('duplicateImeiMessage'));
		return false;
	}
	}
	$('div#initialloader').fadeIn('fast');
	var formData= new FormData();
	
	var singleStolenfirstName=$('#singleStolenfirstName').val();
	var singleStolenmiddleName=$('#singleStolenmiddleName').val();
	var singleStolenlastName=$('#singleStolenlastName').val();
	var singleStolennIDPassportNumber=$('#singleStolennIDPassportNumber').val();
	var singleStolenemail=$('#singleStolenemail').val();
	var trimContactNumber1=$('#singleStolenphone1').val();
	var singleStolenphone1 =trimContactNumber1.replace(/[^A-Z0-9]/ig, "");
	var singleStolenaddress=$('#singleStolenaddress').val();
	var singleStolenstreetNumber=$('#singleStolenstreetNumber').val();
	var singleStolenvillage=$('#singleStolenvillage').val();
	var singleStolenlocality=$('#singleStolenlocality').val();
	var singleStolendistrict=$('#singleStolendistrict').val();
	var singleStolencommune=$('#singleStolencommune').val();
	var singleStolenpin=$('#singleStolenpin').val();
	var sigleStolenserialNumber=$('#sigleStolenserialNumber').val();
	var country=$('#country').val();
	var state=$('#state').val();
	var blockingTimePeriod=$('#stolenDatePeriod').val();
	var blockingType =$('.blocktypeRadio:checked').val();

	var singleStolendeviceBrandName=$('#singleStolendeviceBrandName').val();
	if($('#singleStolendeviceBrandName').val()==930){
		singleStolendeviceBrandName= $('#OtherBrandName').val();
		 
	}
	var singleStolenimei1=$('#singleStolenimei1').val();
	var singleStolenimei2=$('#singleStolenimei2').val();
	var singleStolenimei3=$('#singleStolenimei3').val();
	var singleStolenimei4=$('#singleStolenimei4').val();


	var singleStolendeviceIDType=$('#singleStolendeviceIDType').val();
	var singleStolendeviceType=$('#singleStolendeviceType').val();
	
	if(singleStolendeviceIDType==''){
		singleStolendeviceIDType=null;
	}
	if(singleStolendeviceType==''){
		singleStolendeviceType=null;
	}
	var singleStolenOperator=parseInt($('#singleStolenOperator').val());
	var singleStolenOperator2=parseInt($('#singleStolenOperator3').val());
	var singleStolenOperator3=parseInt($('#singleStolenOperator4').val());
	var singleStolenOperator4=parseInt($('#singleStolenOperator5').val());
	
	var singleStolenSimStatus=$('#singleStolenSimStatus').val();
	var singleStolenComplaintType=$('#singleStolenComplaintType').val();
	var trimContactNumber2 = $('#singleStolenphone2').val();
	var singleStolenphone2 =trimContactNumber2.replace(/[^A-Z0-9]/ig, "");

	var trimContactNumber3 = $('#singleStolenphone3').val();
	var singleStolenphone3 =trimContactNumber3.replace(/[^A-Z0-9]/ig, "");
	
	var trimContactNumber4 = $('#singleStolenphone4').val();
	var singleStolenphone4 =trimContactNumber4.replace(/[^A-Z0-9]/ig, "");
	
	var trimContactNumber5 = $('#singleStolenphone5').val();
	var singleStolenphone5 =trimContactNumber5.replace(/[^A-Z0-9]/ig, "");
	
	var singleStolenmodalNumber= $('#singleStolenmodalNumber').val();

	var singleDeviceAddress=$('#singleDeviceAddress').val();
	var singleDevicestreetNumber=$('#singleDevicestreetNumber').val();
	var singleDevicevillage=$('#singleDevicevillage').val();
	var singleDevicelocality=$('#singleDevicelocality').val();
	var singleDevicedistrict=$('#singleDevicedistrict').val();
	var singleDevicecommune=$('#singleDevicecommune').val();
	var singleDevicepin=$('#singleDevicepin').val();
	var singleDevicecountry=$('#singleDevicecountry').val();
	var singleDevicestate=$('#singleDevicestate').val();
	var singleDeviceRemark=$('#singleDeviceRemark').val();
	var IndivisualStolenDate=$('#IndivisualStolenDate').val();	
	var indivisualStolenfileName=$('#singleStolenFile').val();

	var uploadedFileName = $("#singleStolenFile").val();
	uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
	//////console.log("**** file name"+uploadedFileName)

	var nationality=$('#nationality').val();
	var addressType=$('#addressType').val();
//	var fileFileDetails=$('#uploadFirSingle').val();
//	fileFileDetails=fileFileDetails.replace(/^.*[\\\/]/, '');

	var fieldId = 1;
	var fileInfo = [];
	var formData = new FormData();
	var fileData = [];
	var documentFileNameArray = [];
	var x;
	var filename = '';
	var filediv;
	var i = 0;
	var formData = new FormData();
	var docTypeTagIdValue = '';
	var filename = '';
	var filesameStatus = false;
	var documenttype = false;
	var docTypeTag = '';

	/* $('.fileDiv').each( */
			for(var j=1;j<id;j++){
			
				
				if(typeof  $('#docTypetag' + fieldId).val()!== "undefined"){
					var x = {
					"docType" : $('#docTypetag' + fieldId).val(),
					"fileName" : $('#docTypeFile' + fieldId).val()
							.replace('C:\\fakepath\\', '')
				}
				formData.append('firFileName[]', $('#docTypeFile'
						+ fieldId)[0].files[0]);

				documentFileName = $('#docTypeFile' + fieldId)
						.val().replace('C:\\fakepath\\', '')
				docTypeTag = $('#docTypetag' + fieldId).val();

				var fileIsSame = documentFileNameArray
						.includes(documentFileName);

				var documentTypeTag = documentFileNameArray
						.includes(docTypeTag);

				if (filesameStatus != true) {
					filesameStatus = fileIsSame;
				}

				if (documenttype != true) {
					documenttype = documentTypeTag;

				}
				documentFileNameArray.push(documentFileName);
				documentFileNameArray.push(docTypeTag);

				
				
				if(!x['docType']=='')
					{
					//console.log("if");
					fileInfo.push(x);
					}
				else{
					//console.log("else");
					
				}
				
				
				}
				fieldId++;
				i++;
				
			}

	if (filesameStatus == true) {

		$('#fileFormateModal').openModal({
			dismissible : false
		});
		$('#fileErrormessage').text('')
		$('#fileErrormessage').text($.i18n('duplicateFileName'));
		// $("#saveGrievancesubmitButton").prop('disabled', false);
        $('div#initialloader').delay(300).fadeOut('slow');
		return false;

	}

	if (documenttype == true) {

		$('#fileFormateModal').openModal({
			dismissible : false
		});
		$('#fileErrormessage').text('')
		$('#fileErrormessage').text($.i18n('documentTypeName'));
$('div#initialloader').delay(300).fadeOut('slow');
//$("#saveGrievancesubmitButton").prop('disabled', false);
		return false;

	}
	if(singleStolenpin=="")
		{
		singleStolenpin=null;
		}
	if(singleDevicepin==""){
		singleDevicepin=null;
	}
	
	var stolenIndividualUserDB={
			"alternateContactNumber": singleStolenphone1,
			"commune": singleStolencommune,
			"contactNumber": singleStolenphone2,
			"contactNumber2": singleStolenphone3,
			"contactNumber3": singleStolenphone4,
			"contactNumber4": singleStolenphone5,
			"country": country,
			"deviceBrandName": singleStolendeviceBrandName,
			"deviceIdType": singleStolendeviceIDType,
			"deviceStolenCommune": singleDevicecommune,
			"deviceStolenDistrict": singleDevicedistrict,
			"deviceStolenLocality": singleDevicelocality,
			"deviceStolenPostalCode": singleDevicepin,
			"deviceStolenPropertyLocation": singleDeviceAddress,
			"deviceStolenStreet": singleDevicestreetNumber,
			"deviceStolenVillage": singleDevicevillage,
			"deviceStolenCountry": singleDevicecountry,
			"deviceStolenProvince": singleDevicestate,
			"deviceType":singleStolendeviceType,
			"district": singleStolendistrict,
			"email":singleStolenemail,
			"firstName":singleStolenfirstName,
			"imeiEsnMeid1": parseInt(singleStolenimei1),
			"imeiEsnMeid2": parseInt(singleStolenimei2),
			"imeiEsnMeid3": parseInt(singleStolenimei3),
			"imeiEsnMeid4": parseInt(singleStolenimei4),
			"lastName": singleStolenlastName,
			"locality": singleStolenlocality,
			"multiSimStatus": singleStolenSimStatus,
			"middleName": singleStolenmiddleName,
			"modelNumber":singleStolenmodalNumber,
			"nid": singleStolennIDPassportNumber,
			"operator": singleStolenOperator,
			"operator2": singleStolenOperator2,
			"operator3": singleStolenOperator3,
			"operator4": singleStolenOperator4,
			"phoneNo": singleStolenphone2,
			"postalCode": singleDevicepin,
			"propertyLocation": singleStolenaddress,
			"province": state,
			"remark": singleDeviceRemark,
			"street": singleStolenstreetNumber,
			"village":singleStolenvillage,
			"nidFileName":uploadedFileName,
			"addressType":addressType,
			"nationality":nationality,
			"deviceSerialNumber":sigleStolenserialNumber,
	}


	var request={
			"dateOfStolen":IndivisualStolenDate,
			"attachedFiles" : fileInfo,
			"blockingTimePeriod":blockingTimePeriod,
			"blockingType":blockingType,
			"requestType":0,
			"sourceType":5,
			"deviceQuantity":1,
			"complaintType": singleStolenComplaintType,
			"operatorTypeId":singleStolenOperator,
			"stolenIndividualUserDB":stolenIndividualUserDB
	}
	//formData.append('firFileName', $('#uploadFirSingle')[0].files[0]);
	formData.append('fileInfo[]', JSON.stringify(fileInfo));
	formData.append('file', $('#singleStolenFile')[0].files[0]);
	formData.append("request",JSON.stringify(request));
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});

	$.ajax({
		url: './lawfulIndivisualStolen',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (response, textStatus, jqXHR) {
			//////console.log(response)
			$('div#initialloader').delay(300).fadeOut('slow');
			if(response.errorCode==0){
				$("#indivisualStolenButton").prop('disabled', true);
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#IndivisualStolenTxnId').text(response.txnId)
			}
			else if(response.errorCode==5)
				{
				$('#sucessMessage').text('');
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#sucessMessage').text($.i18n(response.tag));
				}
			else{
				$('#sucessMessage').text('');
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#sucessMessage').text(response.message);
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
			$('div#initialloader').delay(300).fadeOut('slow');

		}
	});
	return false;

}


//__________________--------------------------_______________________Edit  Pages functions___________________---------------------------------------_____________________________





function saveCompanyStolenRequest(){
	$('div#initialloader').fadeIn('fast');
	$("#bulkStolenButton").prop('disabled', true);
	var formData= new FormData();

	var bulkStolencompanyName=$('#bulkStolencompanyName').val();
	var bulkStolenaddress=$('#bulkStolenaddress').val();
	var bulkStolenstreetNumber=$('#bulkStolenstreetNumber').val();
	var bulkStolenvillage=$('#bulkStolenvillage').val();
	var bulkStolenlocality=$('#bulkStolenlocality').val();
	var bulkStolendistrict=$('#bulkStolendistrict').val();
	var bulkStolencommune=$('#bulkStolencommune').val();
	var bulkStolenpin=$('#bulkStolenpin').val();
	var country2=$('#country2').val();
	var state2=$('#state2').val();

	var blockingTimePeriod=$('#stolenBulkDatePeriod').val();
	var blockingType =$('.bulkblocktypeRadio:checked').val();


	var firstName=$('#firstName').val();
	var bulkStolenmiddleName=$('#bulkStolenmiddleName').val();
	var bulkStolenlastName=$('#bulkStolenlastName').val();
	var bulkStolenofficeEmail=$('#bulkStolenofficeEmail').val();
	var trimbulkStolenContact=$('#bulkStolenContact').val();
	var bulkStolenContact =trimbulkStolenContact.replace(/[^A-Z0-9]/ig, "");
	

	var uploadFirBulk=$('#uploadFirBulk').val();

	var deviceBulkStolenaddress=$('#deviceBulkStolenaddress').val();
	var deviceBulkStolenstreetNumber=$('#deviceBulkStolenstreetNumber').val();
	var deviceBulkStolenvillage=$('#deviceBulkStolenvillage').val();
	var deviceBulkStolenlocality=$('#deviceBulkStolenlocality').val();
	var deviceBulkStolendistrict=$('#deviceBulkStolendistrict').val();
	var deviceBulkStolencommune=$('#deviceBulkStolencommune').val();
	var deviceBulkStolenpin=$('#deviceBulkStolenpin').val();
	var country3 = $('#country3').val();
	var state3= $('#state3').val();
	var deviceBulkStolenComplaint=$('#deviceBulkStolenComplaint').val();
	var deviceBulkStolenquantity=$('#deviceBulkStolenquantity').val();
	var deviceBulkStolenRemark=$('#deviceBulkStolenRemark').val();
	var bulkStolenDate=$('#bulkStolenDate').val();
	var bulkDevicequantity=$('#devicequantity').val();

	var uploadFirBulk=$('#uploadFirBulk').val();
	uploadFirBulk=uploadFirBulk.replace(/^.*[\\\/]/, '');

	if(deviceBulkStolenpin==""){
		deviceBulkStolenpin=null
	}
	if(bulkStolenpin==""){
		bulkStolenpin=null
	}
	
	var stolenOrganizationUserDB= {
			"commune": bulkStolencommune,
			"companyName": bulkStolencompanyName,
			"country": country2,
			"district": bulkStolendistrict,
			"email": bulkStolenofficeEmail,
			"incidentCommune": deviceBulkStolencommune,
			"incidentCountry": country3,
			"incidentDistrict": deviceBulkStolendistrict,
			"incidentLocality": deviceBulkStolenlocality,
			"incidentPostalCode": deviceBulkStolenpin,
			"incidentProvince": state3,
			"incidentStreet": deviceBulkStolenstreetNumber,
			"incidentPropertyLocation": deviceBulkStolenaddress,
			"incidentVillage": deviceBulkStolenvillage,
			"locality": deviceBulkStolenlocality ,
			"personnelFirstName": firstName,
			"personnelLastName":bulkStolenlastName ,
			"personnelMiddleName":bulkStolenmiddleName ,
			"phoneNo": bulkStolenContact,
			"postalCode": bulkStolenpin,
			"propertyLocation": bulkStolenaddress,
			"province": state2,
			"street": bulkStolenstreetNumber,
			"village": bulkStolenvillage
	}


	var request={
			"qty":deviceBulkStolenquantity,
			"deviceQuantity":bulkDevicequantity,
			"dateOfStolen":bulkStolenDate,
			"blockingTimePeriod":blockingTimePeriod,
			"blockingType":blockingType,
			"remark":deviceBulkStolenRemark,
			"complaintType": deviceBulkStolenComplaint,
			"requestType":0,
			"sourceType":6,
			"firFileName":uploadFirBulk,
			"stolenOrganizationUserDB":stolenOrganizationUserDB
	}
	formData.append('file', $('#deviceBulkStolenFile')[0].files[0]);
	formData.append('firFileName', $('#uploadFirBulk')[0].files[0]);
	formData.append("request",JSON.stringify(request));

		
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});

	$.ajax({
		url: './lawfulOraganisationStolen',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function (response, textStatus, jqXHR) {
			
			
			$('div#initialloader').delay(300).fadeOut('slow');
			//////console.log(response)

			if(response.errorCode==0){
				$("#bulkStolenButton").prop('disabled', true);
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#IndivisualStolenTxnId').text(response.txnId)
			}
			else if(response.errorCode==5){
				$('#sucessMessage').text('');
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#sucessMessage').text($.i18n(response.tag));
			}
			
			else{
				$('#sucessMessage').text('');
				$('#IndivisualStolenSucessPopup').openModal({
					dismissible:false
				});
				$('#sucessMessage').text(response.message);
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
			$('div#initialloader').delay(300).fadeOut('slow');

		}
	});
	return false;


}


function DeleteConsignmentRecord(txnId,id,reqType){
	$("#DeleteConsignment").openModal({
		dismissible:false
	});
	$("#transID").text(txnId);
	$("#setStolenRecoveyRowId").text(id);
	//////console.log("  reqType  ="+reqType)
	window.reqType=reqType;
}


function confirmantiondelete(){
	var txnId = $("#transID").text();
	var id= $("#setStolenRecoveyRowId").text();
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var currentRoleType = $("body").attr("data-stolenselected-roleType"); 
	var remarks = $("#textarea1").val();
	var role = currentRoleType == null ? roleType : currentRoleType;
	//////console.log("txnId===**"+txnId+" userId="+userId+" roleType== "+roleType+ " currentRoleType=="+currentRoleType);
	//////console.log("  reqType========"+window.reqType)
	var obj ={
			"txnId" : txnId,
			"roleType":roleType,
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
			//////console.log(data);
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
	$("#confirmDeleteConsignment").openModal({
		dismissible:false
	});
	return false;
}

//------------------------------------------- Admin Approve------------------------------------------ 

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
			"roleType": roleType,
			"userType":roleType,
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"txnId": window.transactionId,
			"userId":parseInt(userId),
			"userName" : $("body").attr("data-username")
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


//------------------------------------------- Admin Reject------------------------------------------

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
			"roleType": roleType,
			"userType":roleType,
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"txnId": window.transactionId,
			"userId":parseInt(userId),
			"userName" : $("body").attr("data-username")
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
				$('#rejectRequestMsg').text('');
				$('#rejectRequestMsg').text($.i18n(data.tag));
				
				
			}
			else{
				$('#rejectInformation').closeModal(); 
				$('#confirmRejectInformation').openModal({dismissible:false});
				$('#rejectRequestMsg').text('');
				$('#rejectRequestMsg').text($.i18n('errorMsg'));
			}
		},
		error : function() {
			$('#rejectInformation').closeModal(); 
			$('#confirmRejectInformation').openModal({dismissible:false});
			$('#rejectRequestMsg').text('');
			$('#rejectRequestMsg').text($.i18n('errorMsg'));
		}
	});
	
	return false;
}

function confirmRejectInformation(){
	$('#rejectInformation').closeModal();
	setTimeout(function(){$('#confirmRejectInformation').openModal({dismissible:false});},200);
}

/*function clearFileName() {
	//alert("ss")
	$('#bulkRecoveryFile').val('');
	$("#bulkRecoveryFileName").val('');
	$('#fileFormateModal').closeModal();
}
*/

function clearFileName() {

	var fieldId=$('#FilefieldId').val();
	
	if(fieldId=='singleStolenFile')
		{
		$('#'+fieldId).val('');
		$('#singleStolenFileName').val('');
		}
	else if(fieldId=='uploadFirSingle')
		{
		$('#'+fieldId).val('');
		$('#uploadFirSingleName').val('');
		}
	
	
	else if(fieldId=='deviceBulkStolenFile')
		{
		$('#'+fieldId).val('');
		$('#deviceBulkStolenFileName').val('');
		}
	else if(fieldId=='uploadFirBulk')
	{
		$('#'+fieldId).val('');
	$('#uploadFirSingleBulkName').val('');
	}
	
	$('#fileFormateModal').closeModal();
	$('#FilefieldId').val('');
}

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});

$.getJSON('./getDropdownList/TOP_BRAND', function(data) {
	
	/*var html='<option value="">Select Brand Name</option>';
	$('#singleStolendeviceBrandName').append(html);*/	
	//$('#select2-singleStolendeviceBrandName-container').empty();
	for (i = 0; i < data.length; i++) {
		$('<option>').val(data[i].id).text(data[i].interp)
				.appendTo('#singleStolendeviceBrandName');
	}
	$("#singleStolendeviceBrandName").eq(0).removeAttr("tabindex");
});
var dataFiltersorce= $("body").attr("data-filtersorce");
var dataSource= $("body").attr("data-source");

if(dataFiltersorce=="" || dataFiltersorce==null && dataSource==null || dataSource==""){
	
	$('select#singleStolendeviceBrandName').select2();	
}




$('#singleStolendeviceBrandName').on(
		'change',
		function() {
			var brand_id = $('#singleStolendeviceBrandName').val();
			$.getJSON('./productModelList?brand_id=' + brand_id,
					function(data) {
				        $('#select2-singleStolenmodalNumber-container').empty();
						$("#singleStolenmodalNumber").empty();
						var html='<option value="">Select Model Number</option>';
						$('#singleStolenmodalNumber').append(html);
						for (i = 0; i < data.length; i++) {
							$('<option>').val(data[i].id).text(
									data[i].modelName).appendTo(
									'#singleStolenmodalNumber');
						}
					});
			$('select#singleStolenmodalNumber').select2();
		});




$(document).on("keyup", "#singleStolenphone3", function(e) {
	var mobilenumber=$('#singleStolenphone3').val();
	//////console.log(" 2 mobilenumber=="+mobilenumber);
	if(mobilenumber.length<'1' )
	{$("#singleStolenOperator3").attr("required", false);  
	$("#operator3span").css("display", "none");
	}
	else
	{
		
		$("#operator3span").css("display", "block");
		$('#singleStolenOperator3').prop('required',true);
	}
});


$(document).on("keyup", "#singleStolenphone4", function(e) {
	var mobilenumber=$('#singleStolenphone4').val();
	//////console.log(" 3  mobilenumber=="+mobilenumber);
	if(mobilenumber.length<'1' )
	{$("#singleStolenOperator4").attr("required", false);  	$("#operator4span").css("display", "none"); 
	}
	else
	{
		
		$("#operator4span").css("display", "block");
	    $('#singleStolenOperator4').prop('required',true);
	}
});


$(document).on("keyup", "#singleStolenphone5", function(e) {
	var mobilenumber=$('#singleStolenphone5').val();
	//////console.log(" 4 mobilenumber=="+mobilenumber);
	if(mobilenumber.length<'1' )
	{$("#singleStolenOperator5").attr("required", false);   	$("#operator5span").css("display", "none");
	}
	else
	{
		$("#operator5span").css("display", "block");
		$('#singleStolenOperator5').prop('required',true);
	}
});

var lawfulStolenHistoryTable;
function historyRecord(txnID, requestType, source){
	//////console.log("txn id=="+txnID)
	var requestType = requestType;
	$("#tableOnModal").openModal({dismissible:false});
	 var filter =[];
	 var formData= new FormData();
	 var userTypeValue=$("body").attr("data-roleType");
	 ////console.log("requestType--->" +requestType);
	 if(userTypeValue=='CEIRAdmin'&& requestType == 0 && source=='5'){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","request_type","source_type","file_status","complaint_type","fir_file_name",
					    "blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark","date_of_stolen",
					     "user_id","ceir_admin_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":5
		} 
		 ////alert("requestType1-->" +requestType+" source1-->" +source);
	 }else if(userTypeValue=='CEIRAdmin'&& requestType == 0 && source=='6'){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","request_type","source_type","file_status","complaint_type","file_name","fir_file_name",
					    "blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark","date_of_stolen",
					     "user_id","ceir_admin_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":5
		} 
		 ////alert("requestType2-->" +requestType+" source2-->" +source);
	 }else if(userTypeValue=='CEIRAdmin' && requestType == 1 && source=='5'){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","request_type","source_type","file_status","complaint_type","fir_file_name",
					    "blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark","date_of_recovery",
					     "user_id","ceir_admin_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":5
		} 
		 ////alert("requestType3-->" +requestType+" source3-->" +source);
	 }else if(userTypeValue=='CEIRAdmin' && requestType == 1 && source=='6'){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","request_type","source_type","file_status","complaint_type","file_name","fir_file_name",
					    "blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark","date_of_recovery",
					     "user_id","ceir_admin_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":5
		} 
		 ////alert("requestType4-->" +requestType+" source4-->" +source); 
	 }
	 else if(userTypeValue !='CEIRAdmin' && requestType == 0 && source=='5'){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","request_type","source_type","file_status","complaint_type","fir_file_name",
					    "blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark","date_of_stolen",
					     "user_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":5
		}
		 ////alert("requestType5-->" +requestType+" source5-->" +source);
	 } else if(userTypeValue !='CEIRAdmin' && requestType == 0 && source=='6'){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","request_type","source_type","file_status","complaint_type","file_name","fir_file_name",
					    "blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark","date_of_stolen",
					     "user_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":5
		}
		 ////alert("requestType6-->" +requestType+" source6-->" +source);
	 } else if(userTypeValue !='CEIRAdmin' && requestType == 1 && source=='5'){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","request_type","source_type","file_status","complaint_type","fir_file_name",
					    "blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark","date_of_recovery",
					     "user_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":5
		}
		 ////alert("requestType7-->" +requestType+" source7-->" +source);
	 }else if(userTypeValue !='CEIRAdmin' && requestType == 1 && source=='6'){
		 var filterRequest={
				 "columns": [
					    "created_on","modified_on","txn_id","role_type","request_type","source_type","file_status","complaint_type","file_name","fir_file_name",
					    "blocking_type","blocking_time_period","quantity","device_quantity","remark","rejected_remark","date_of_recovery",
					     "user_id"
					    ],
				"tableName": "stolenand_recovery_mgmt_aud",
				"dbName" : "ceirconfig",
				"txnId":txnID,
				"featureId":5
		}
		 ////alert("requestType8-->" +requestType+" source8-->" +source);
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
	
	if( lawfulStolenHistoryTable !== null && lawfulStolenHistoryTable !== undefined ){
		//console.log('Going to destroy history table');
		lawfulStolenHistoryTable.destroy();
		$('#data-table-history').empty();
	}
	
	$.ajax({
		url: 'Consignment/consignment-history',
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function(result){
			var dataObject = eval(result);
			////alert(JSON.stringify(dataObject.data))
			lawfulStolenHistoryTable = $('#data-table-history').DataTable({
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





$('#singleStolendeviceIDType').on('change', function() {
	var value=parseInt($(this).val());

	switch (value) {
	case 0:
		/*$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("pattern","[0-9]{15,16}");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("maxlength","16");*/
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").removeAttr("onkeyup");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		$('#errorMsgOnModal').text($.i18n('IMEIMsg'));
		
		break;
	case 1:
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("pattern","[A-F0-9]{15,16}");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("maxlength","16");
        $("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").removeAttr("onkeyup");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$('#errorMsgOnModal').text($.i18n('MEIDMsg'));
		break;
	case 2:
		
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").val('');
        $("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("pattern","[0-9]{8,11}");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("onkeyup","isLengthValid(this.value)");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("maxlength","11");	
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#errorMsgOnModal").text($.i18n('ESNMsg'));
		break;
	}

}); 

function isLengthValid(val){
	var deviceIDLength=val.length;
	if(!isNaN(val)){
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("pattern","[0-9]{11,11}");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("maxlength","11");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
	}
	else if(typeof val == 'string' || val instanceof String){
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("maxlength","8");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("pattern","[A-F0-9]{8,8}");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");
		$("#singleStolenimei1,#singleStolenimei2,#singleStolenimei3,#singleStolenimei4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");

	}
}


$('#sigleRecoverydeviceIDType').on('change', function() {
	var value=parseInt($(this).val());

	switch (value) {
	case 0:
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").val('');
		/*$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("pattern","[0-9]{15,16}");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("maxlength","16");
		*/
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").removeAttr("onkeyup");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationIMEI')+"')");
		
		$('#errorMsgOnModal').text($.i18n('IMEIMsg'));
		
		break;
	case 1:
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("pattern","[A-F0-9]{15,16}");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("maxlength","16");
		
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").removeAttr("onkeyup");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationMEID')+"')");
		$('#errorMsgOnModal').text($.i18n('MEIDMsg'));
		break;
	case 2:
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").val('');
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("pattern","[0-9]{8,11}");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("onkeyup","isLengthValid(this.value)");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("maxlength","11");	
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#errorMsgOnModal").text($.i18n('ESNMsg'));
		break;
	}

}); 

function isLengthValid(val){
	var deviceIDLength=val.length;
	if(!isNaN(val)){
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("pattern","[0-9]{11,11}");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("maxlength","11");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN11')+"')");
	}
	else if(typeof val == 'string' || val instanceof String){
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("maxlength","8");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("pattern","[A-F0-9]{8,8}");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninput","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");
		$("#sigleRecoveryimeiNumber1,#sigleRecoveryimeiNumber2,#sigleRecoveryimeiNumber3,#sigleRecoveryimeiNumber4").attr("oninvalid","InvalidMsg(this,'input','"+$.i18n('validationESN8')+"')");

	}
}



$(document).on("keyup", "#singleStolenimei1", function(e) {
	var singleStolenimei1=$('#singleStolenimei1').val();
	if(singleStolenimei1.length<'1' )
	{
		$("#singleStolendeviceIDType").attr("required", false);
		/*$('#currency').attr("disabled",true);*/
		/*$('#currencyDiv').hide();

		$("#currency")[0].selectedIndex = 0;*/
		$("#deviceIdTypeSpan").css("display", "none");
	}
	else
	{
		$('#singleStolendeviceIDType').prop('required',true);
		//$("#currency").attr("required", true);
		/*$('#currency').attr("disabled",false);*/
		$("#deviceIdTypeSpan").css("display", "block");

	}
});



function enableSelectFile() {
	 
	if($('#docTypetag1').val() != ''){
		$("#docTypeFile1").attr("disabled", false);
		$("#docTypeFile1").attr("required", true);
		$("#removestar").find(".star").remove();
		$("#supportingdocumentFile").append('<span class="star">*</span>');
	}else{
		$("#docTypeFile1").attr("required", false);
		$('#filetextField').val('');
		$("#removestar").find(".star").remove();
	}
}

function enableAddMore(id,removeFileDivId) {

    var uploadedFileName = $("#"+id).val();
	uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
	////alert("file extension=="+uploadedFileName)
	var ext = uploadedFileName.split('.').pop();

	var fileSize = ($("#"+id)[0].files[0].size);
	/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
		//alert("----"+fileSize);*/
	fileSize = Math.floor(fileSize/1000);
	$('#FilefieldId').val(id);
	
	var fileExtension =ext.toLowerCase();
	
	var extArray = ["png","jpg","jpeg","gif","bmp","gif","csv","pdf","docx"];
	var isInArray =extArray.includes(fileExtension);
	
	$('#removeFileInput').val(id);
	$('#removeFileId').val(removeFileDivId);
	////console.log("isInArray: "+isInArray)
	if (uploadedFileName.length > 30) {
		$('#fileFormateModal').openModal();
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageValidationName'));
	} 
	else if(isInArray ==false)
	{
		$('#fileFormateModal').openModal({
			dismissible:false
		});
		$(".add_field_button").attr("disabled", true);
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageMessageCSV'));

	}
	else if(ext=='csv')
	{
		
		if(fileSize>='10000'){
			$(".add_field_button").attr("disabled", true);
			window.parent.$('#fileFormateModal').openModal({
				dismissible:false
			});
			
		}
		
	}
	else if(fileSize>=5000){
		$('#fileFormateModal').openModal({
			dismissible:false
		});
		$('#fileErrormessage').text('');
		$('#fileErrormessage').text($.i18n('imageSize'));	
		$(".add_field_button").attr("disabled", true);
	}
	
	$(".add_field_button").attr("disabled", false);
	$(".add_field_button_edit").attr("disabled", false);
}


var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
});
		
		$.getJSON('./addMoreFile/grievance_supporting_doc_count', function(data) {
			//console.log(data);

			localStorage.setItem("maxCount", data.value);

		});

		//var max_fields = 2; //maximum input boxes allowed
		var max_fields = localStorage.getItem("maxCount");
		if (max_fields==0 || max_fields==1){
			 //console.log("1111");
			 $(".add_field_button").prop('disabled', true);
		 }
		
		var wrapper = $(".mainDiv"); //Fields wrapper
		var add_button = $(".add_field_button"); //Add button ID
		var x = 1; //initlal text box count
		var id = 2;

		$(".add_field_button")
				.click(
						function(e) { //on add input button click
							e.preventDefault();
							var placeholderValue = $
									.i18n('selectFilePlaceHolder');
							if (x < max_fields) { //max input box allowed
								x++; //text box increment
								$(wrapper)
										.append(
												'<div id="filediv'+id+'" class="fileDiv"><div class="row"><div class="file-field col s12 m6"><label for="Category">'
														+ $
																.i18n('documenttype')
														+ '<span class="star">*</span> </label><select required id="docTypetag'
														+ id
														+ '" oninput="InvalidMsg(this,\'select\',\''
														+ $
																.i18n('selectDocumentType')
														+ '\');"  oninvalid="InvalidMsg(this,\'select\',\''
														+ $
																.i18n('selectDocumentType')
														+ '\');"  class="browser-default"> <option value="" disabled selected>'
														+ $
																.i18n('selectDocumentType')
														+ ' </option></select><select id="docTypetagValue'+id+'" style="display:none" class="browser-default"> <option value="" disabled selected>'
														+ $
																.i18n('selectDocumentType')
														+ ' </option></select></div><div class="file-field col s12 m6" style="margin-top: 23px;"><div class="btn"><span>'
														+ $
																.i18n('selectfile')
														+ '</span><input required onchange=enableAddMore("docTypeFile'+id+'","filediv'+id+'") id="docTypeFile'
														+ id
														+ '" type="file" oninput="InvalidMsg(this,\'fileType\',\''
														+ $
																.i18n('selectfile')
														+ '\');"  oninvalid="InvalidMsg(this,\'fileType\',\''
														+ $
																.i18n('selectfile')
														+ '\');" name="files[]" id="filer_input" /></div><div class="file-path-wrapper"><input class="file-path validate" placeholder="'+placeholderValue+'" type="text"></div></div><div style="cursor:pointer;background-color:red;margin-right: 1.7%;" id="remove_field_icon'+id+'" class="remove_field btn right btn-info" onclick="remove_field('+id+')">-</div></div></div>'); //add input box
							}
							  
								if(x==max_fields){
 									
									 $(".add_field_button").prop('disabled', true);
								}
								$.getJSON('./getSourceTypeDropdown/DOC_TYPE/12', function(
										data) { 	
									
									for (i = 0; i < data.length; i++) {
										//////console.log(data[i].interp);
										var optionId = id - 1;
										 
										$('<option>').val(data[i].tagId).text(
												data[i].interp).appendTo(
												'#docTypetag' + optionId);
										$('<option>').val(data[i].value).text(
												data[i].tagId).appendTo(
												'#docTypetagValue' + optionId);
										//////console.log('#docTypetag' + optionId);

									}
								});

							id++;
							

						});
		
		/* $(wrapper).on("click", ".remove_field", function(e) { //user click on remove text
			e.preventDefault();
			var  Iid = id - 1;
			alert(Iid);
			$('#filediv' + Iid).remove();
			$(this).parent('div').remove();
			x--;
			id--;

		}) */
		
		function remove_field(fieldId ){
			$('#filediv' + fieldId).remove();
			$(this).parent('div').remove();
			$(".add_field_button").prop('disabled', false);
			$(".add_field_button_edit").attr("disabled", false);
			x--;
			}
		
		
		var idedit = 2;
		$(".add_field_button_edit")
		.click(
				function(e) { //on add input button click
					e.preventDefault();
					var placeholderValue = $
							.i18n('selectFilePlaceHolder');
					if (x < max_fields) { //max input box allowed
						x++; //text box increment
						$(wrapper)
								.append(
										'<div id="filediv'+idedit+'" class="fileDiv"><div class="row"><div class="file-field col s12 m6"><label for="Category">'
												+ $
														.i18n('documenttype')
												+ '<span class="star">*</span> </label><select required id="docTypetag'
												+ idedit
												+ '" oninput="InvalidMsg(this,\'select\',\''
												+ $
														.i18n('selectDocumentType')
												+ '\');"  oninvalid="InvalidMsg(this,\'select\',\''
												+ $
														.i18n('selectDocumentType')
												+ '\');"  class="browser-default"> <option value="" disabled selected>'
												+ $
														.i18n('selectDocumentType')
												+ ' </option></select><select id="docTypetagValue'+idedit+'" style="display:none" class="browser-default"> <option value="" disabled selected>'
												+ $
														.i18n('selectDocumentType')
												+ ' </option></select></div><div class="file-field col s12 m6" style="margin-top: 23px;"><div class="btn"><span>'
												+ $
														.i18n('selectfile')
												+ '</span><input required onchange=enableAddMore("docTypeFile'+idedit+'","filediv'+idedit+'") id="docTypeFile'
												+ id
												+ '" type="file" oninput="InvalidMsg(this,\'fileType\',\''
												+ $
														.i18n('selectfile')
												+ '\');"  oninvalid="InvalidMsg(this,\'fileType\',\''
												+ $
														.i18n('selectfile')
												+ '\');" name="files[]" id="filer_input" /></div><div class="file-path-wrapper"><input class="file-path validate" placeholder="'+placeholderValue+'" type="text"></div></div><div style="cursor:pointer;background-color:red;margin-right: 1.7%;" id="remove_field_icon'+idedit+'" class="remove_field btn right btn-info" onclick="remove_field('+idedit+')">-</div></div></div>'); //add input box
					}
					  
						if(x==max_fields){
								
							 $(".add_field_button_edit").prop('disabled', true);
						}
						$.getJSON('./getSourceTypeDropdown/DOC_TYPE/12', function(
								data) { 	
							
							for (i = 0; i < data.length; i++) {
								//////console.log(data[i].interp);
								var optionId = idedit;
								 
								$('<option>').val(data[i].tagId).text(
										data[i].interp).appendTo(
										'#docTypetag' + optionId);
								$('<option>').val(data[i].value).text(
										data[i].tagId).appendTo(
										'#docTypetagValue' + optionId);
								//////console.log('#docTypetag' + optionId);

							}
						});

						idedit++;
					

				});

		function clearFileName() {
			
			var fieldId=$('#FilefieldId').val();
			//var existingFileName=$('#existingFileName').val();
			////alert("existingFileName=="+existingFileName);
			////alert(fieldId);
		 
			if(fieldId=='singleStolenFile')
			{
			$('#'+fieldId).val('');
			$('#singleStolenFileName').val('');
			}
		else if(fieldId=='uploadFirSingle')
			{
			$('#'+fieldId).val('');
			$('#uploadFirSingleName').val('');
			}
			
		else if(fieldId=='deviceBulkStolenFile')
		{
		$('#'+fieldId).val('');
		$('#deviceBulkStolenFileName').val('');
		}
			
		else if(fieldId=='uploadFirBulk')
		{
		$('#'+fieldId).val('');
		$('#uploadFirSingleBulkName').val('');
		}
		else if(fieldId=='bulkRecoveryFile')
		{
		$('#'+fieldId).val('');
		$('#bulkRecoveryFileName').val('');
		}
			$('#fileFormateModal').closeModal();
	/*		$('#fileFormateModal').closeModal();
			var fieldInput=$('#removeFileInput').val();
			$('#'+fieldInput).val('');
			var inputPlaceHolder=$('#removeFileId').val();
			 alert()
			$('#'+fileName).val(''); */

			}
function changeSelectDropDownToText(singleStolendeviceBrandName){
	if($('#'+singleStolendeviceBrandName).val()==930){
		$("#OtherBrandNameDiv").css("display", "block");
		 		$("#OtherBrandName").attr("required", true);
	}
	else{
		$("#OtherBrandNameDiv").css("display", "none");
		$("#OtherBrandName").attr("required", false);
	}
}	

$("#country").val("Cambodia").change();
/*$("#country").attr("style", "pointer-events: none;");*/

function filterResetLawfull(formID){
	$('#endDate').css('border-color', '');
	$('#errorMsg').text('');
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	filterStolen(lang,null);
}