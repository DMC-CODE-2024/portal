var featureId = 11;
var userId = $("body").attr("data-userID");
var cierRoletype = sessionStorage.getItem("cierRoletype");
var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

$.i18n().locale = lang;	
$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
} ).done( function() { 
});


$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	typeApprovedDataTable(lang)
	pageRendering();
	setAllDropdown();
});




var userType = $("body").attr("data-roleType");

function typeApprovedDataTable(lang){
	if(userType=="CEIRAdmin"){
		Datatable('headers?type=AdmintrcManageType&lang='+lang,'./trc');
	}else if(userType=="Importer"){
		Datatable('headers?type=ImporterTrcManageType&lang='+lang,'./trc');
	}else{
		Datatable('headers?type=trcManageType&lang='+lang,'./trc');
	}
	
}





//**************************************************Type Approved table**********************************************

function Datatable(Url,dataUrl){
	var txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;
	var userId = userType=="CEIRAdmin" ? 0 : parseInt($("body").attr("data-userID")); 

		var filterRequest={
				"endDate":$('#endDate').val(),
				"startDate":$('#startDate').val(),
			  	"tac" : $('#tac').val(),
			  	"txnId" : txn,
			  	"userId":userId,
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"adminStatus" : parseInt($('#Status').val()),
				}	
		
if(lang=='km'){
	var langFile='./resources/i18n/khmer_datatable.json';
}
	$.ajax({
		url: Url,
		type: 'POST',
		dataType: "json",
		success: function(result){
			var table=	$("#typeAprroveTable").removeAttr('width').DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : false,
				"bPaginate" : true,
				"bFilter" : true,
				"bInfo" : true,
				"bSearchable" : true,
				"oLanguage": {  
					"sUrl": langFile  
				},
				
				ajax: {
					url : dataUrl,
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(filterRequest); 
						////console.log(JSON.stringify(filterRequest));
					}

				},
				"columns": result,
				fixedColumns: true,
				columnDefs: [
		            { width: 142, targets: result.length - 1 },
		            { width: 143, targets: 0 },
		            { width: 118, targets: 2 }
			]
			});
			
			$('#typeAprroveTable input').unbind();
		    $('#typeAprroveTable input').bind('keyup', function (e) {
		        if (e.keyCode == 13) {
		            table.search(this.value).draw();
		        }
		    });
		    $('div#initialloader').delay(300).fadeOut('slow');
		},
		error: function (jqXHR, textStatus, errorThrown) {
			////console.log("error in ajax");
		}
	});
}


//**************************************************Type Approved page buttons**********************************************

function pageRendering(){
	$.ajax({
		url: 'TRC/pageRendering',
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
					$("#typeAprroveTableDiv")
					.append("<div class='input-field col s6 m2'>"+
							"<div id='enddatepicker' class='input-group'>"+
							"<input class='form-control datepicker' type='text' id="+date[i].id+" autocomplete='off'>"+
							"<label for="+date[i].id+">"+date[i].title
							+"</label>"+
							"<span	class='input-group-addon' style='color: #ff4081'>"+
							"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");
					$( "#"+date[i].id ).datepicker({
						dateFormat: "yy-mm-dd",
						 maxDate: new Date()
			        });
				}else if(date[i].type === "text"){
					$("#typeAprroveTableDiv").append("<div class='input-field col s6 m2' ><input type="+date[i].type+" id="+date[i].id+" maxlength='19' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
				}
				 
			} 
			
			if(userType=="TRC"){
				////console.log("userType is----->"+userType)
			}else{
				// dynamic drop down portion
				var dropdown=data.dropdownList;
				for(i=0; i<dropdown.length; i++){
					var dropdownDiv=
						$("#typeAprroveTableDiv").append("<div class='col s6 m2 selectDropdwn'>"+
								
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
	
			$("#typeAprroveTableDiv").append("<div class=' col s3 m2 l1'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
			$("#typeAprroveTableDiv").append("<div class='col s3 m2 l1'><a href='JavaScript:void(0)' onclick='exportTacData()' type='button' class='export-to-excel right'>"+$.i18n('Export')+" <i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				if(button[i].type === "HeaderButton"){
					$('#'+button[i].id).attr("href", button[i].buttonURL);
				}
				else{
					$('#'+button[i].id).attr("onclick", button[i].buttonURL);
				}
			}
	

			$.getJSON('./getDropdownList/'+featureId+'/'+$("body").attr("data-userTypeID"), function(data) {

				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].state).text(data[i].interp)
					.appendTo('#Status');
				}
			});
		}
		
	}); 
}


if(userType=="CEIRAdmin"){
	$("#btnLink").css({display: "none"});
	}

if(userType=="CEIRAdmin"){
	$("#btnLink").css({display: "none"});
	}

function viewByID(id,actionType,projectPath){
	
	window.projectPath = projectPath;
	
	$.ajax({
		url : "./viewByID/"+id+"?lang="+lang, //controller haven'nt made yet for this url. this is dummy url.
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			////console.log(+data);
			if(actionType=='view')
				{
				$("#viewModal").openModal();
				setViewPopupData(data,projectPath);
			
				}
			else if(actionType=='edit')
				{
				$("#editModal").openModal();
				setEditPopupData(data)
				
				}
		},
		error : function() {
			////console.log("failed");
		}
	});
	
}
 

function ImporterviewByID(id,actionType,projectPath){
	
	window.projectPath = projectPath;
	
	
	$.ajax({
		url : "./viewByID/"+id, //controller haven'nt made yet for this url. this is dummy url.
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			////console.log(+data);
			if(actionType=='view')
				{
				$("#viewImporterModal").openModal();
				setImporterViewPopupData(data,projectPath);
			
				}
			else if(actionType=='edit')
				{
				$("#importereditModal").openModal();
				setImporterEditPopupData(data)
				
				}
			
		},
		error : function() {
			////console.log("failed");
		}
	});
	
}


function setViewPopupData(data,projectPath){
	$("#viewmanufacturerId").val(data.manufacturerId);
	$("#viewmanufacturerName").val(data.manufacturerName);
	$("#viewcountry").val(data.country);
	$("#viewtac").val(data.tac);
	$("#status").val(data.stateInterp);
	$('#viewrequestDate').val(data.requestDate)
	$("#viewapproveDisapproveDate").val(data.approveDisapproveDate);
	$("#viewremark").val(data.remark);
	
	var result= data;
	var importerViewResponse = [];
	importerViewResponse.push(result);
	
	$('#chatMsg').empty();
	var projectpath=path+"/Consignment/dowloadFiles/actual";
	for(var i=0; i< importerViewResponse.length; i++)
	{
		for (var j=0 ; j < importerViewResponse[i]["attachedFiles"].length; j++)
			{
			if(importerViewResponse[i].attachedFiles[j].docType == null){
				importerViewResponse[i].attachedFiles[j].docType == "";
			}else{
				$("#chatMsg").append("<div class='chat-message-content clearfix'><span class='document-Type' ><b>Document Type : </b>"+importerViewResponse[i].attachedFiles[j].docType+"</span>  <a href='"+projectpath+"/"+importerViewResponse[i].attachedFiles[j].fileName+"/"+importerViewResponse[i].txnId+"/"+importerViewResponse[i].attachedFiles[j].docType+"'>"+importerViewResponse[i].attachedFiles[j].fileName+"</a></div>");
			}
		}
	}
	
}

function setImporterViewPopupData(data,projectPath){

	$("#viewtradmark").val(data.trademark);
	$("#viewmodelName").val(data.productNameInterp);
	$("#viewModelnumber").val(data.modelNumberInterp);
	$("#viewManufacturercountry").val(data.manufacturerCountry);
	$('#viewrequestDate').val(data.requestDate)
	$('#viewFrequency').val(data.frequencyRange)
	$("#viewImportertac").val(data.tac);
	
	var result= data;
	var importerViewResponse = [];
	importerViewResponse.push(result);
	
	$('#chatMsg').empty();
	var projectpath=path+"/Consignment/dowloadFiles/actual";
	for(var i=0; i< importerViewResponse.length; i++)
	{
		for (var j=0 ; j < importerViewResponse[i]["attachedFiles"].length; j++)
		{
			if(importerViewResponse[i].attachedFiles[j].docType == null){
				importerViewResponse[i].attachedFiles[j].docType == "";
			}else{
				$("#chatMsg").append("<div class='chat-message-content clearfix'><span class='document-Type' ><b>Document Type : </b>"+importerViewResponse[i].attachedFiles[j].docType+"</span>  <a href='"+projectpath+"/"+importerViewResponse[i].attachedFiles[j].fileName+"/"+importerViewResponse[i].txnId+"/"+importerViewResponse[i].attachedFiles[j].docType+"'>"+importerViewResponse[i].attachedFiles[j].fileName+"</a></div>");
			}	
		}
	}
	
	
}

function setEditPopupData(data){
	$("#editmanufacturerId").val(data.manufacturerId);
	$("#editmanufacturerName").val(data.manufacturerName);
	$("#editcountry").val(data.country);
	$("#edittac").val(data.tac);
	$("#editdeviceType").val(data.approveStatus).change();
	$('#editRequestDate').val(data.requestDate)
	$("#editApproveRejectionDate").val(data.approveDisapproveDate);
	$("#editRemark").val(data.remark);
	$("#editFileName").val(data.fileName);
	$("#transactionid").val(data.txnId);
	$("#columnid").val(data.id);
	
	
}

function setImporterEditPopupData(data){
		var model  = data.modelNumber;
		$("#editImportertransactionid").val(data.txnId);
		$("#editTradmark").val(data.trademark);
		$("#productname").val(data.productName);
		
		var brand_id = $('#productname').val();
		$.getJSON('./productModelList?brand_id=' + brand_id,
				function(data) {
					$("#modelNumber").empty();
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].id).text(
								data[i].modelName).appendTo(
								'#modelNumber');
					}
					$('#modelNumber').val(model);
				});
		
		//setTimeout(function(){ $('#modelNumber').val(data.modelNumber); },200);
		$("#editmanufacturercountry").val(data.manufacturerCountry);
		$('#editfrequency').val(data.frequencyRange)
		$("#editImportertac").val(data.tac);
		$("#importerColumnid").val(data.id);
		//$("#editImporterFileName").val(data.attachedFiles[0].fileName);
		//$("#docTypetag1").val(data.attachedFiles[0].docType);
}

populateCountries
(   
		"editcountry"
);

populateCountries
(   
		"editmanufacturercountry"
);

function updateReportTypeDevice()
{
	var userId = $("body").attr("data-userID");
	var id=$("#columnid").val();
	 
		var fieldId=1;
		var fileInfo =[];
		var formData= new FormData();
		var fileData = [];

		var x;
		var filename='';
		var filediv;
		var i=0;
		var formData= new FormData();
		var docTypeTagIdValue='';
		var filename='';
		
		
		$('.fileDiv').each(function() {	
		var x={
			"docType":$('#docTypetag'+fieldId).val(),
			"fileName":$('#docTypeFile'+fieldId).val().replace('C:\\fakepath\\','')
			}
			formData.append('files[]',$('#docTypeFile'+fieldId)[0].files[0]);
			fileInfo.push(x);
			fieldId++;
			i++;
		});
		
		
			var multirequest={
					"attachedFiles":fileInfo,
					"manufacturerId" : $('#editmanufacturerId').val(),
					"manufacturerName" : $('#editmanufacturerName').val(),
					"country" : $('#editcountry').val(),
					"approveDisapproveDate" : $('#editApproveRejectionDate').val(),
					"requestDate" : $('#editRequestDate').val(),
					"tac" : $('#edittac').val(),
					"approveStatus" : parseInt($("#editdeviceType").val()),
					"remark" : $('#editRemark').val(),
					"txnId": $("#transactionid").val(),
					"userId" : $("body").attr("data-userID"),
					"featureId" : parseInt(featureId),
					"id": parseInt($("#columnid").val())
				}
	
		
		
		
		////console.log("multirequest------------->" +JSON.stringify(multirequest))
		formData.append('fileInfo[]',JSON.stringify(fileInfo));
		formData.append('multirequest',JSON.stringify(multirequest));
	 
		
		$.ajax({
			url : './update-register-approved-device',
			type : 'POST',
			data : formData,
			//mimeType: 'multipart/form-data',
			processData : false,
			contentType : false, 
			async:false,
			success : function(data, textStatus, jqXHR) {
			
				////console.log(data);
				
			
					
					 if (data.errorCode==0){
						$('#updateManageTypeDevice').openModal();
					}
					 else {

							$('#updateManageTypeDevice').openModal();
							$('#updateTacMessage').text('');
							$('#updateTacMessage').text(data.message);
						}
					 
			},
			error : function(jqXHR, textStatus, errorThrown) {
				////console.log("error in ajax")
			}
		});
		return false;
}











//**********************************************************Export Excel file************************************************************************
function exportTacData()
{
	var txn= (txnIdValue == 'null' && transactionIDValue == undefined)? $('#transactionID').val() : transactionIDValue;
	var tacStartDate=$('#startDate').val();
	var tacEndDate=$('#endDate').val();
	var tacStatus=parseInt($('#Status').val());
	var tacNumber=$('#tac').val();
	var txnId = txn;
	var featureId = 11;
	var userType = userType;
	var userTypeId = parseInt($("body").attr("data-userTypeID"));
	
	
	////console.log("tacStatus=="+tacStatus);
     if(isNaN(tacStatus))
	   {
    	 tacStatus='';
  	   }
 
	var table = $('#typeAprroveTable').DataTable();
	var info = table.page.info(); 
 var pageNo=info.page;
  var pageSize =info.length;
	////console.log("pageSize=="+pageSize+" tacNumber=="+tacNumber+" tacStartDate=="+tacStartDate+" tacEndDate=="+tacEndDate+" tacStatus=="+tacStatus+" txnId=="+txnId+" pageSize=="+pageSize+" pageNo=="+pageNo);
	
	window.location.href="./exportTac?tacNumber="+tacNumber+"&tacStartDate="+tacStartDate+"&tacEndDate="+tacEndDate+"&tacStatus="+tacStatus+"&txnId="+txnId+"&featureId="+featureId+"&userType"+userType+"&userTypeId="+userTypeId+"&pageSize="+pageSize+"&pageNo="+pageNo;

}



function openApproveTACPopUp(txnId,	manufacturerName)
{
	manufacturerName=manufacturerName.replace("+20"," " );
	$('#ApproveTAC').openModal();
	$('#ApproveTacTxnId').text(txnId);
	$('#setApproveTacTxnId').val(txnId);

}
function approveSubmit(actiontype){
	var txnId=$('#setApproveTacTxnId').val();
	var userId = $("body").attr("data-userID");
	var userType=$("body").attr("data-roleType");
	var adminApproveStatus=0;
	var approveRequest={
			"adminApproveStatus":adminApproveStatus,
			"txnId":txnId,
			"featureId":11,
			"adminUserId":userId,
			"adminUserType":userType
			
	}
	$.ajax({
		url : "./TACAprroveDisapprove",
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			$('#confirmApproveTAC').openModal();
			if(data.errorCode==0){

				$('#approveSuccessMessage').text('');
				$('#approveSuccessMessage').text(data.message);
			}
			else{
				$('#approveSuccessMessage').text('');
				$('#approveSuccessMessage').text(data.message);
			}
		},
		error : function() {
			//alert("Failed");
		}
	});
}




function openDisapproveTACPopUp(txnId,	manufacturerName)
{
	manufacturerName=manufacturerName.replace("+20"," " );
	$('#RejectTAC').openModal();
	
	$('#RejectTacTxnId').text(txnId);
	$('#setRejectTacTxnId').val(txnId);

}
function rejectSubmit(actiontype){
	var txnId=$('#setRejectTacTxnId').val();
	var userId = $("body").attr("data-userID");
	var userType=$("body").attr("data-roleType");
	var adminApproveStatus=1;
	var approveRequest={
			"adminApproveStatus":adminApproveStatus,
			"txnId":txnId,
			"featureId":11,
			"adminUserId":userId,
			"adminUserType":userType
			
	}
	$.ajax({
		url : "./TACAprroveDisapprove",
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			$('#confirmRejectTAC').openModal();
			if(data.errorCode==0){

				$('#rejectSuccessMessage').text('');
				$('#rejectSuccessMessage').text(data.message);
			}
			else{
				$('#rejectSuccessMessage').text('');
				$('#rejectSuccessMessage').text(data.message);
			}
		},
		error : function() {
			//alert("Failed");
		}
	});
}


$(document).on('keypress' , '#tac', validateNumber);
function validateNumber(event) {
var key = window.event ? event.keyCode : event.which;
if (event.keyCode === 8 || event.keyCode === 46) {
return true;
} else if ( key < 48 || key > 57 ) {
return false;
} else {
return true;
}
}

function setAllDropdown(){
$.getJSON('./getSourceTypeDropdown/DOC_TYPE/'+featureId, function(data) {
	for (i = 0; i < data.length; i++) {
		////console.log(data[i].interp);
		$('<option>').val(data[i].tagId).text(data[i].interp).appendTo(
				'#docTypetag1');
	}
});


}


var max_fields = 15; //maximum input boxes allowed
var wrapper = $(".mainDiv"); //Fields wrapper
var add_button = $(".add_field_button"); //Add button ID
var x = 1; //initlal text box count
var id = 2;
$(".add_field_button")
		.click(
				function(e) { //on add input button click
					e.preventDefault();
					if (x < max_fields) { //max input box allowed
						x++; //text box increment
						$(wrapper)
								.append(
										'<div id="filediv'+id+'" class="fileDiv"><div class="row"><div class="file-field col s12 m6"><label for="Category">'
												+ $
														.i18n('documenttype')
												+ ' <span class="star">*</span></label><select id="docTypetag'+id+'"  class="browser-default"> <option value="" disabled selected>'
												+ $
														.i18n('selectDocumentType')
												+ ' </option></select><select id="docTypetagValue'+id+'" style="display:none" class="browser-default"> <option value="" disabled selected>'
												+ $
														.i18n('selectDocumentType')
												+ ' </option></select></div> <div class="file-field col s12 m6" style="margin-top: 23px;"><div class="btn"><span>'
												+ $.i18n('selectfile')
												+ '</span><input id="docTypeFile'+id+'" type="file"  name="files[]" id="filer_input" /></div><div class="file-path-wrapper"><input class="file-path validate" type="text"></div></div><div style="cursor:pointer;background-color:red;margin-right: 1.7%;" class="remove_field btn right btn-info">-</div></div></div>'); //add input box
					}

					$.getJSON('./getSourceTypeDropdown/DOC_TYPE', function(
							data) {

						for (i = 0; i < data.length; i++) {
							////console.log(data[i].interp);
							var optionId = id - 1;
							$('<option>').val(data[i].tagId).text(
									data[i].interp).appendTo(
									'#docTypetag' + optionId);
							$('<option>').val(data[i].value).text(
									data[i].tagId).appendTo(
									'#docTypetagValue' + optionId);
							////console.log('#docTypetag' + optionId);

						}
					});
					id++;

				});

$(wrapper).on("click", ".remove_field", function(e) { //user click on remove text
	e.preventDefault();
	var Iid = id - 1;
	/*//alert("@@@"+Iid)*/
	$('#filediv' + Iid).remove();
	$(this).parent('div').remove();
	x--;
	id--;

})