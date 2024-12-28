var featureId = 21;
var userId = parseInt($("body").attr("data-userID"));
var cierRoletype = sessionStorage.getItem("cierRoletype");
var lang = window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

/*
 * window.parent.$('#langlist').on('change', function() { var
 * lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
 * window.location.assign("./manageTypeDevices?lang="+lang); });
 */

$.i18n().locale = lang;
var documenttype, selectfile, selectDocumentType;
$.i18n().load({
	'en' : './resources/i18n/en.json',
	'km' : './resources/i18n/km.json'
}).done(function() {

});

$(document).ready(function() {
	$('div#initialloader').fadeIn('fast');
	typeApprovedDataTable(lang)
	pageRendering();
	setAllDropdown();
});

var userType = $("body").attr("data-roleType");

function typeApprovedDataTable(lang) {
	if (userType == "CEIRAdmin") {
		Datatable('headers?type=AdminImportertrcManageType&lang=' + lang,
				'./importerAdmintrc');
	} else if (userType == "Importer" || userType == "TRC") {
		Datatable('headers?type=ImporterTrcManageType&lang=' + lang,
				'./importerAdmintrc');
	} else {
		Datatable('headers?type=trcManageType&lang=' + lang, './trc');
	}

}

// **************************************************Importer Type Approved
// table**********************************************

function Datatable(Url, dataUrl) {

	var txn = (txnIdValue == 'null' && transactionIDValue == undefined) ? $(
			'#transactionID').val() : transactionIDValue;

	var FilterUserType = $('#userType').val() == '-1'
			|| $('#userType').val() == undefined ? null : $(
			"#userType option:selected").text();
	
	var modelNumber = $('#filteredModel').val() == '' || $('#filteredModel').val() == undefined ? -1 : $('#filteredModel').val();
	var productName = $('#filterdbrandname').val() == undefined || $('#filterdbrandname').val() == -1 ? null : $('#filterdbrandname').val();
	var countryName = $('#country').val() == undefined || $('#country').val() == -1 ? null : $('#country').val();
	
	
	if (userType == "CEIRAdmin") {
	
		var filterRequest = {
			"endDate" : $('#endDate').val(),
			"startDate" : $('#startDate').val(),
			"tac" : $('#tac').val(),
			"txnId" : $('#transactionID').val() == null ? txn : $('#transactionID').val(),
			"userId" : userId,
			"featureId" : parseInt(featureId),
			"userTypeId" : parseInt($("body").attr("data-userTypeID")),
			"userType" : $("body").attr("data-roleType"),
			"status" : parseInt($('#Status').val()),
			"filterUserType" : FilterUserType,
			
			"displayName" : $('#filterDisaplay').val(),
			"productName" : productName,
			"modelNumber" : parseInt(modelNumber),
			"countryName" : countryName,
		}
		
	}else if(userType == "TRC"){
		
		var filterRequest = {
			"endDate" : $('#endDate').val(),
			"startDate" : $('#startDate').val(),
			"tac" : $('#tac').val(),
			"txnId" :$('#transactionID').val() == null ? txn : $('#transactionID').val(),
			"userId" : userId,
			"featureId" : parseInt(featureId),
			"userTypeId" : parseInt($("body").attr("data-userTypeID")),
			"userType" : $("body").attr("data-roleType"),
			
			"status" : parseInt($('#Status').val()),
			"productName" : productName,
			"modelNumber" : parseInt(modelNumber),
			"countryName" : countryName,
			"trademark" : $('#trademark').val()
		}
		
	} else {
		
		var filterRequest = {
			"endDate" : $('#endDate').val(),
			"startDate" : $('#startDate').val(),
			"tac" : $('#tac').val(),
			"txnId" : $('#transactionID').val() == null ? txn : $('#transactionID').val(),
			"userId" : userId,
			"featureId" : parseInt(featureId),
			"userTypeId" : parseInt($("body").attr("data-userTypeID")),
			"userType" : $("body").attr("data-roleType"),
			
			"status" : parseInt($('#Status').val()),
			"productName" : productName,
			"modelNumber" : parseInt(modelNumber),
			"countryName" : countryName,
			"trademark" : $('#trademark').val()
		}
	}
	
	
	if (lang == 'km') {
		var langFile = "./resources/i18n/khmer_datatable.json";
	}else if(lang=='en'){
		var langFile='./resources/i18n/english_datatable.json';
	}
	
	$("#submitFilter").prop('disabled', true);
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	
	console.log("filterRequest-->"+JSON.stringify(filterRequest));
	
	$.ajax({
		url : Url,
		type : 'POST',
		dataType : "json",
		success : function(result) {
			var table = $("#ImporterAdmintypeAprroveTable").removeAttr('width')
					.DataTable({
						destroy : true,
						"serverSide" : true,
						orderCellsTop : true,
						"ordering" : true,
						"bPaginate" : true,
						"bFilter" : false,
						"bInfo" : true,
						"bSearchable" : true,
						"oLanguage" : {
							"sUrl" : langFile
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
						ajax : {
							url : dataUrl,
							type : 'POST',
							dataType : "json",
							data : function(d) {
								d.filter = JSON.stringify(filterRequest);
								// ////console.log(JSON.stringify(filterRequest));

							}

						},
						"columns" : result,
						fixedColumns : true,

						columnDefs : [ {
							width : 158,
							targets : result.length - 1
						}, {
							width : 121,
							targets : 0
						},
						{ orderable: false, targets: -1 }
						]

					});
			$("#submitFilter").prop('disabled', false);
			$('div#initialloader').delay(300).fadeOut('slow');
			
		},
		
		error : function(jqXHR, textStatus, errorThrown) {
			// ////console.log("error in ajax");
		}
	});

}

// **************************************************Type Approved page
// buttons**********************************************

function pageRendering() {
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$
			.ajax({
				url : 'adminImprterTrc/pageRendering',
				type : 'POST',
				dataType : "json",
				success : function(data) {
					data.userStatus == "Disable" ? $('#btnLink').addClass(
							"eventNone") : $('#btnLink').removeClass(
							"eventNone");

					var elem = '<p class="PageHeading">' + data.pageTitle
							+ '</p>';
					$("#pageHeader").append(elem);
					var button = data.buttonList;

					var date = data.inputTypeDateList;
					for (i = 0; i < date.length; i++) {
						if (date[i].type === "date") {
							$("#typeAprroveTableDiv")
									.append(
											"<div class='input-field'>"
													+ "<div id='enddatepicker' class='input-group'>"
													+ "<input class='form-control datepicker' type='text'  id="
													+ date[i].id
													+ " autocomplete='off' onchange='checkDate(startDate,endDate)'>"
													+ "<label for="
													+ date[i].id
													+ ">"
													+ date[i].title
													+ "</label>"
													+ "<span	class='input-group-addon' style='color: #ff4081'>"
													+ "<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"
													+ "</i>" + "</span>");
							$("#" + date[i].id).datepicker({
								dateFormat : "yy-mm-dd",
								maxDate : new Date()
							});
						} else if (date[i].type === "text") {
							$("#typeAprroveTableDiv").append(
									"<div class='input-field' ><input type="
											+ date[i].type + " id="
											+ date[i].id
											+ " maxlength='18' /><label for="
											+ date[i].id
											+ " class='center-align'>"
											+ date[i].title + "</label></div>");
						}
						$("#tac").prop("maxLength", 8);

					}

					// dynamic drop down portion
					var dropdown = data.dropdownList;
					for (i = 0; i < dropdown.length; i++) {
						
							var dropdownDiv = $("#typeAprroveTableDiv")
							.append(
									"<div class='selectDropdwn'>"
											+

											"<div class='select-wrapper select2  initialized'>"
											+ "<span class='caret'>"
											+ "</span>"
											+ "<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"
											+

											"<select onchange='getModelName()' id="
											+ dropdown[i].id
											+ " class='select2 initialized'>"
											+ "<option value='-1' >"
											+ dropdown[i].title
											+ "</option>" + "</select>"
											+ "</div>" + "</div>");
					}
					
					var viewFilter="viewFilter";
					$("#typeAprroveTableDiv").append(
									"<div class='filter_btn'><button type='button' class='btn primary botton' id='submitFilter'/></div>");
					$("#typeAprroveTableDiv").append("<div class='filter_btn'><button type='button'  class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
					$("#typeAprroveTableDiv")
							.append(
									"<div class='filter_btn'><a href='JavaScript:void(0)' onclick='exportTacData()' type='button' class='export-to-excel right'>"
											+ $.i18n('Export')
											+ " <i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
					$('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");
					for (i = 0; i < button.length; i++) {
						$('#' + button[i].id).text(button[i].buttonTitle);
						if (button[i].type === "HeaderButton") {
							$('#' + button[i].id).attr("href",
									button[i].buttonURL);
						} else {
							$('#' + button[i].id).attr("onclick",
									button[i].buttonURL);
						}
					}
					
					
					
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
					});
					
					$
							.getJSON('./getDropdownList/' + featureId + '/'
									+ $("body").attr("data-userTypeID"),
									function(data) {

										for (i = 0; i < data.length; i++) {
											$('<option>').val(data[i].state)
													.text(data[i].interp)
													.appendTo('#Status');
										}
									});

					$.getJSON('./getusertypefeature/' + featureId + '/'+ $("body").attr("data-userTypeID"),
							function(data) {
								for (i = 0; i < data.length; i++) {
									$('<option>').val(data[i].id).text(
											data[i].usertypeInterp).appendTo(
											'#userType');
								}
populateCountries("country", "state");
							});
					
					$.getJSON('./productList', function(data) {
						for (i = 0; i < data.length; i++) {
							$('<option>').val(data[i].id).text(data[i].brand_name)
									.appendTo('#filterdbrandname');
						}
						//$('select#filterdbrandname').select2();
					});

				}
				

			});

}


function getModelName(){
	var brand_id = $('#filterdbrandname').val();
	$.getJSON('./productModelList?brand_id=' + brand_id,
			function(data) {
	
		//$('#select2-modelNumber-container').empty();
				$('#filteredModel').empty();
				var html='<option value="">Select Model Number</option>';
				$('#filteredModel').append(html);	
				for (i = 0; i < data.length; i++){
					var html='<option value="'+data[i].id+'">'+data[i].modelName+'</option>';
					$('#filteredModel').append(html);	
				}
				
				$("#filteredModel,#Status,#userType").prop('onchange', null); //for disabling onchange function in dropdown
				
			});
}


if (userType == "CEIRAdmin") {
	$("#btnLink").css({
		display : "none"
	});
}

if (userType == "CEIRAdmin") {
	$("#btnLink").css({
		display : "none"
	});
}

// ******
function ImporterviewByID(id, actionType, projectPath, modalID) {
	$('#' + modalID).openModal({
		dismissible : false
	});
	window.projectPath = projectPath;
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.ajax({
		url : "./viewByID/" + id + "?lang=" + lang+ "&userType=" + userType
		+ "&userId=" + userId, // controller haven'nt made
													// yet for this url. this is
													// dummy url.
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			// ////console.log(+data);
			if (actionType == 'view') {
				// $("#viewImporterModal").openModal();

				setImporterViewPopupData(data, projectPath);

			} else if (actionType == 'edit') {

				setImporterEditPopupData(data)
				// setUploadedFiles(data)

			}

		},
		error : function() {
			// ////console.log("failed");
		}
	});

}

function setImporterViewPopupData(data, projectPath) {

	$("#viewtradmark").val(data.trademark);
	$("#viewmodelName").val(data.productNameInterp);
	$("#viewModelnumber").val(data.modelNumberInterp);
	$("#viewManufacturercountry").val(data.manufacturerCountry);
	$('#viewrequestDate').val(data.requestDate);
	$('#viewFrequency').val(data.frequencyRange);
	$("#viewImportertac").val(data.tac);
	$("#viewtxnId").val(data.txnId);

	var result = data;
	var importerViewResponse = [];
	importerViewResponse.push(result);

	$('#chatMsg').empty();
	var projectpath = path + "/Consignment/dowloadFiles/actual";
	for (var i = 0; i < importerViewResponse.length; i++) {
		for (var j = 0; j < importerViewResponse[i]["attachedFiles"].length; j++) {
			if (importerViewResponse[i].attachedFiles[j].docType == null
					|| importerViewResponse[i].attachedFiles[j].docType == undefined) {
				importerViewResponse[i].attachedFiles[j].docType == "";
			} else {
				if (importerViewResponse[i].attachedFiles[j].docType == "") {

					// $("#chatMsg").append("<div class='chat-message-content
					// clearfix'> <span class='document-Type' ><b>Document Type
					// : </b>"+data[i].attachedFiles[j].docType+"</span> <a
					// href='"+projectpath+"/"+data[i].attachedFiles[j].fileName+"/"+data[i].attachedFiles[j].grievanceId+"/"+data[i].attachedFiles[j].docType+"'>"+data[i].attachedFiles[j].fileName+"</a></div>");
				} else {

					fileName = importerViewResponse[i].attachedFiles[j].fileName
							.split(' ').join('%20');
					$("#chatMsg")
							.append(
									"<div class='chat-message-content clearfix'> <span class='document-Type' ><b>Document Type : </b>"
											+ importerViewResponse[i].attachedFiles[j].docType
											+ "</span> <a onclick=onclick=fileDownload('"
											+ fileName
											+ "','actual','"
											+ importerViewResponse[i].txnId
											+ "','"
											+ importerViewResponse[i].attachedFiles[j].docType
											+ "')>"
											+ importerViewResponse[i].attachedFiles[j].fileName
											+ "</a></div>");
				}
				// $("#chatMsg").append("<div class='chat-message-content
				// clearfix'><span class='document-Type' ><b>Document Type :
				// </b>"+importerViewResponse[i].attachedFiles[j].docType+"</span>
				// <a
				// href='"+projectpath+"/"+importerViewResponse[i].attachedFiles[j].fileName+"/"+importerViewResponse[i].txnId+"/"+importerViewResponse[i].attachedFiles[j].docType+"'>"+importerViewResponse[i].attachedFiles[j].fileName+"</a></div>");
			}
		}
	}

}

function setImporterEditPopupData(data) {
	var model = data.modelNumber;
	$("#editImportertransactionid").val(data.txnId);
	$("#editTradmark").val(data.trademark);
	$("#productname").val(data.productName);

	var brand_id = $('#productname').val();
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.getJSON('./productModelList?brand_id=' + brand_id, function(data) {
		$("#modelNumber").empty();
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].id).text(data[i].modelName).appendTo(
					'#modelNumber');
		}
		$('#modelNumber').val(model);
	});

	// setTimeout(function(){ $('#modelNumber').val(data.modelNumber); },200);
	$("#editmanufacturercountry").val(data.manufacturerCountry);
	$('#editfrequency').val(data.frequencyRange)
	$("#editImportertac").val(data.tac);
	$("#importerColumnid").val(data.id);
	$("#approveStatus").val(data.approveStatus);

	$.getJSON('./getSourceTypeDropdown/DOC_TYPE/21', function( // same values
																// to be
																// configure for
																// featureId 21
	data) {
		$("#docTypetag1").empty();
		$('#docTypetag1').append(
				'<option value="">' + $.i18n('selectDocumentType')
						+ '</option>');
		for (i = 0; i < data.length; i++) {
			// ////console.log(data[i].interp);
			$('<option>').val(data[i].tagId).text(data[i].interp).appendTo(
					'#docTypetag1');
		}

	});

	// $("#editImporterFileName").val(data.attachedFiles[0].fileName);
	// $("#docTypetag1").val(data.attachedFiles[0].docType);
}

function setUploadedFiles(data) {
	var max_fields = localStorage.getItem("maxCount");
	if (max_fields == 0) {
		// ////console.log("1111");
		$(".add_field_button").prop('disabled', true);
	}

	var wrapper = $(".mainDiv"); // Fields wrapper
	var add_button = $(".add_field_button"); // Add button ID
	var x = 1; // initlal text box count
	var id = 2;
	var wrapper = $(".mainDiv");
	var result = data;
	var importerViewResponse = [];
	importerViewResponse.push(result);
	for (var i = 0; i < importerViewResponse.length; i++) {
		for (var j = 0; j < importerViewResponse[i]["attachedFiles"].length; j++) {

		/*	//alert("Document Type----->"
					+ importerViewResponse[i].attachedFiles[j].docType.length
					+ " File Name--->"
					+ importerViewResponse[i].attachedFiles[j].fileName.length)*/
			if ((importerViewResponse[i].attachedFiles[j].docType.length == 2)
					|| (importerViewResponse[i].attachedFiles[j].fileName.length == 2)) {
				var placeholderValue = $.i18n('selectFilePlaceHolder');
				if (x < max_fields) { // max input box allowed
					x++
					$(wrapper)
							.append(
									'<div id="filediv'
											+ id
											+ '" class="fileDiv"><div class="row"><div class="file-field col s12 m6"><label for="Category">'
											+ $.i18n('documenttype')
											+ '</label><select id="docTypetag'
											+ id
											+ '"  class="browser-default"> <option value="" disabled selected>'
											+ $.i18n('selectDocumentType')
											+ ' </option></select><select id="docTypetagValue'
											+ id
											+ '" style="display:none" class="browser-default"> <option value="" disabled selected>'
											+ $.i18n('selectDocumentType')
											+ ' </option></select></div><div class="file-field col s12 m6" style="margin-top: 23px;"><div class="btn"><span>'
											+ $.i18n('selectfile')
											+ '</span><input id="docTypeFile'
											+ id
											+ '" type="file"  name="files[]" id="filer_input" /></div><div class="file-path-wrapper"><input class="file-path validate" placeholder="'
											+ placeholderValue
											+ '" type="text"></div></div>  <div style="cursor:pointer;background-color:red;margin-right: 1.7%;" onclick="remove_field('+id+')" class="remove_field btn right btn-info">-</div></div></div>');
				}
				if(x==max_fields){
					
					 $(".add_field_button").prop('disabled', true);
				}
				
				
				
			} else {

				//alert("in else part")
			}

			$("#docTypetag1").val(
					importerViewResponse[i].attachedFiles[j].docType);
			$("#fileName").val(
					importerViewResponse[i].attachedFiles[j].fileName);
		}
	}

}

populateCountries("editmanufacturercountry");


function updateImporterTypeDevice() {
	$('div#initialloader').fadeIn('fast');
	var userId = $("body").attr("data-userID");
	//var id = $("#importerColumnid").val();

	var fieldId = 1;
	var fileInfo = [];
	var formData = new FormData();
	var fileData = [];

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
	var documentFileNameArray = [];

	for (var k=1; k<id; k++){
		if($('#docTypetag'+fieldId).val() != undefined && $('#docTypetag'+fieldId).val() != false ){
				var x = {
					"docType" : $('#docTypetag' + fieldId).val(),
					"fileName" : $('#docTypeFile' + fieldId).val().replace(
							'C:\\fakepath\\', '')
				}
				formData.append('files[]',
						$('#docTypeFile' + fieldId)[0].files[0]);

				documentFileName = $('#docTypeFile' + fieldId).val().replace(
						'C:\\fakepath\\', '')
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

				fileInfo.push(x);
		}
				fieldId++;
				i++;
	};

	if (filesameStatus == true) {

		// $('#fileFormateModal').openModal();
		$('#fileFormateModal').openModal({
			dismissible : false
		});
		$('#fileErrormessage').text('')
		$('#fileErrormessage').text($.i18n('duplicateFileName'));
		return false;

	}
	if (documenttype == true) {

		$('#fileFormateModal').openModal({
			dismissible : false
		});
		$('#fileErrormessage').text('')
		$('#fileErrormessage').text($.i18n('documentTypeName'));
		return false;

	}

	var multirequest = {
		"attachedFiles" : fileInfo,
		"trademark" : $('#editTradmark').val(),
		"productName" : $('#productname').val(),
		"modelNumber" : $('#modelNumber').val(),
		"manufacturerCountry" : $('#editmanufacturercountry').val(),
		"frequencyRange" : $('#editfrequency').val(),
		"tac" : $('#editImportertac').val(),
		"txnId" : $("#editImportertransactionid").val(),
		"userId" : $("body").attr("data-userID"),
		"featureId" : parseInt(featureId),
		"approveStatus" : $("#approveStatus").val(),
		"id" : parseInt($("#importerColumnid").val()),
		"userType" : $("body").attr("data-roleType")
	}

	// ////console.log("multirequest------------->" +JSON.stringify(multirequest))
	formData.append('fileInfo[]', JSON.stringify(fileInfo));
	formData.append('multirequest', JSON.stringify(multirequest));
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.ajax({
		url : './update-register-approved-device',
		type : 'POST',
		data : formData,
		processData : false,
		contentType : false,
		success : function(data, textStatus, jqXHR) {
			$('div#initialloader').delay(300).fadeOut('slow');
			// ////console.log(data);
			$('#updateManageTypeDevice').openModal({
				dismissible : false
			});
			if (data.errorCode == 200) {
				$('#updateTacMessage').text('');
				$('#updateTacMessage').text($.i18n('TYPE_APPROVE_UPDATE_SUCCESS'));
			} else if(data.errorCode == 201) {
				$('#updateTacMessage').text('');
				$('#updateTacMessage').text($.i18n('REGISTER_TYPE_APPROVE_REJECTED'));
			}else if(data.errorCode == 204) {
				$('#updateTacMessage').text('');
				$('#updateTacMessage').text($.i18n('TYPE_APPROVE_WRONG_ID'));
			}else if(data.errorCode == 500) {
				$('#updateTacMessage').text('');
				$('#updateTacMessage').text($.i18n('TYPE_APPROVE_UPDATE_FAIL'));
			}else if(data.errorCode == 409) {
				$('#updateTacMessage').text('');
				$('#updateTacMessage').text($.i18n('UPDATE_ERROR'));
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// ////console.log("error in ajax")
		}
	});
	return false;
}

function setAllDropdown() {
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.getJSON('./productList', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].id).text(data[i].brand_name).appendTo(
					'#productname');
		}
	});

	$('#productname').on(
			'change',
			function() {
				var brand_id = $('#productname').val();
				$.getJSON('./productModelList?brand_id=' + brand_id, function(
						data) {
					$("#modelNumber").empty();
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].id).text(data[i].modelName)
								.appendTo('#modelNumber');
					}
				});
			});

	$.getJSON('./getSourceTypeDropdown/DOC_TYPE/' + featureId + '', function(
			data) {
		for (i = 0; i < data.length; i++) {
			// ////console.log(data[i].interp);
			$('<option>').val(data[i].tagId).text(data[i].interp).appendTo(
					'#docTypetag1');
		}
	});

}

$.getJSON('./addMoreFile/more_files_count', function(data) {
	// ////console.log(data);
	localStorage.setItem("maxCount", data.value);
});

// var max_fields = 2; //maximum input boxes allowed
var max_fields = localStorage.getItem("maxCount");

var wrapper = $(".mainDiv"); // Fields wrapper
var add_button = $(".add_field_button"); // Add button ID
var x = 1; // initlal text box count
var id = 2;
$(".add_field_button")
		.click(
				function(e) { // on add input button click
					e.preventDefault();
					var placeholderValue = $.i18n('selectFilePlaceHolder');
					if (x < max_fields) { // max input box allowed
						x++; // text box increment
						$(wrapper)
								.append(
										'<div id="filediv'
												+ id
												+ '" class="fileDiv"><div class="row"><div class="file-field col s12 m6"><label for="Category">'
												+ $.i18n('documenttype')
												+ '</label><select id="docTypetag'
												+ id
												+ '"  class="browser-default"> <option value="" disabled selected>'
												+ $.i18n('selectDocumentType')
												+ ' </option></select><select id="docTypetagValue'
												+ id
												+ '" style="display:none" class="browser-default"> <option value="" disabled selected>'
												+ $.i18n('selectDocumentType')
												+ ' </option></select></div><div class="file-field col s12 m6" style="margin-top: 23px;"><div class="btn"><span>'
												+ $.i18n('selectfile')
												+ '</span><input id="docTypeFile'
												+ id
												+ '" type="file" onchange=enableAddMore("docTypeFile'+id+'","filediv'+id+'")  name="files[]" id="filer_input" /></div><div class="file-path-wrapper"><input class="file-path validate" placeholder="'
												+ placeholderValue
												+ '" type="text"></div></div>  <div style="cursor:pointer;background-color:red;margin-right: 1.7%;" onclick="remove_field('+id+')" class="remove_field btn right btn-info">-</div></div></div>');
					}
					if(x==max_fields){
						
						 $(".add_field_button").prop('disabled', true);
					}
					$.getJSON('./getSourceTypeDropdown/DOC_TYPE/21', function(
							data) {

						for (i = 0; i < data.length; i++) {
							// ////console.log(data[i].interp);
							var optionId = id - 1;
							$('<option>').val(data[i].tagId).text(
									data[i].interp).appendTo(
									'#docTypetag' + optionId);
							$('<option>').val(data[i].value)
									.text(data[i].tagId).appendTo(
											'#docTypetagValue' + optionId);
							// ////console.log('#docTypetag' + optionId);

						}
					});
					id++;

				});

/*$(wrapper).on("click", ".remove_field", function(e) { // user click on remove
														// text
	e.preventDefault();
	var Iid = id - 1;
	 //alert("@@@"+Iid) 
	$('#filediv' + Iid).remove();
	$(this).parent('div').remove();
	x--;
	id--;

})*/

function remove_field(fieldId ){
	$('#filediv' + fieldId).remove();
	$(this).parent('div').remove();
	x--;
	$(".add_field_button").prop('disabled', false);
}

function openApproveTACPopUp(txnId, manufacturerName) {
	manufacturerName = manufacturerName.replace("+20", " ");
	// $('#ApproveTAC').openModal();
	$('#ApproveTAC').openModal({
		dismissible : false
	});
	$('#ApproveTacTxnId').text(txnId);
	$('#setApproveTacTxnId').val(txnId);

}

function approveSubmit(actiontype) {
	var txnId = $('#setApproveTacTxnId').val();
	var userId = $("body").attr("data-userID");
	var userType = $("body").attr("data-roleType");
	var adminApproveStatus = 6;
	var approveRequest = {
		"adminApproveStatus" : adminApproveStatus,
		"txnId" : txnId,
		"featureId" : featureId,
		"adminUserId" : userId,
		"adminUserType" : userType

	}
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.ajax({
		url : "./TACAprroveDisapprove",
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			// $('#confirmApproveTAC').openModal();

			$('#confirmApproveTAC').openModal({
				dismissible : false
			});
			if (data.errorCode == 0) {

				$('#approveSuccessMessage').text('');
				$('#approveSuccessMessage').text(
						$.i18n('TYPE_APPROVE_APPROVED'));
			} else {
				$('#approveSuccessMessage').text('');
				$('#approveSuccessMessage').text(
						$.i18n('TYPE_APPROVE_APPROVED'));
			}
		},
		error : function() {
			//alert("Failed");
		}
	});
}

function openDisapproveTACPopUp(txnId, manufacturerName) {
	manufacturerName = manufacturerName.replace("+20", " ");
	// $('#RejectTAC').openModal();

	$('#RejectTAC').openModal({
		dismissible : false
	});

	$('#RejectTacTxnId').text(txnId);
	$('#setRejectTacTxnId').val(txnId);
	$('#rejectTrcRemark').val("");
	$("label").removeClass('active');

}

function rejectSubmit(actiontype) {
	var txnId = $('#setRejectTacTxnId').val();
	var userId = $("body").attr("data-userID");
	var userType = $("body").attr("data-roleType");
	var adminApproveStatus = 7;
	var approveRequest = {
		"adminApproveStatus" : adminApproveStatus,
		"txnId" : txnId,
		"featureId" : featureId,
		"adminUserId" : userId,
		"adminUserType" : userType,
		"remark" : $("#rejectTrcRemark").val()

	}
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.ajax({
		url : "./TACAprroveDisapprove",
		data : JSON.stringify(approveRequest),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data) {
			$('#confirmRejectTAC').openModal();
			if (data.errorCode == 0) {

				$('#rejectSuccessMessage').text('');
				$('#rejectSuccessMessage')
						.text($.i18n('TYPE_APPROVE_REJECTED'));
			} else {
				$('#rejectSuccessMessage').text('');
				$('#rejectSuccessMessage')
						.text($.i18n('TYPE_APPROVE_REJECTED'));
			}
		},
		error : function() {
			//alert("Failed");
		}
	});

	return false;
}

function DeleteTacRecord(txnId, id) {
	// $("#DeleteTacConfirmationModal").openModal();
	$('#DeleteTacConfirmationModal').openModal({
		dismissible : false
	});
	$("#tacdeleteTxnId").text(txnId);
	$("#deleteTacId").val(id);
	$('#deleteTacRemark').val("");
	$("label").removeClass('active');
}

function confirmantiondelete() {
	var txnId = $("#tacdeleteTxnId").text();
	var remark = $("#deleteTacRemark").val();
	var id = $("#deleteTacId").val();
	
	
	// ////console.log("userType=="+userType+" ==id=="+id+"===userId===" +userId);

	/*
	 * var obj ={ "txnId" : txnId, "userType": $("body").attr("data-roleType"),
	 * "remark" : tacRemark }
	 */
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.ajax({
		url : "./importerTacDelete?id=" + id + "&userType=" + userType
				+ "&userId=" + userId+ "&remark=" +remark,
		// data : JSON.stringify(obj),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'POST',
		success : function(data, textStatus, xhr) {
			// ////console.log(data);

			// $("#stockModalText").text(data.message);
			$("#DeleteTacConfirmationModal").closeModal();

			// $("#closeDeleteModal").openModal();
			$('#closeDeleteModal').openModal({
				dismissible : false
			});
			if (data.errorCode == 0) {
				$("#tacModalText").text(stockDeleted);
			} else {
				$("#TacModalText").text(data.message);
			}
			$("#materialize-lean-overlay-3").css("display", "none");
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

function clearFileName() {
	/*$('#fileName').val('');
	$("#file").val('');
	$('#fileFormateModal').closeModal();*/
	
	$('#fileFormateModal').closeModal();
	var fieldInput=$('#removeFileInput').val();
	$('#'+fieldInput).val('');
	var inputPlaceHolder=$('#removeFileId').val();
	$('#'+inputPlaceHolder).find('input:text').val(''); 
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
	////alert(uploadedFileName+"----------"+ext+"----"+fileSize)
	var fileExtension =ext.toLowerCase();
	////console.log("file type: "+fileExtension);
	var extArray = ["png","jpg","jpeg","gif","bmp","gif","csv"];
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
		$('#fileErrormessage').text($.i18n('imageMessage'));

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
}
/*function enableSelectFile() {
	$("#docTypeFile1").attr("disabled", false);
	$("#docTypeFile1").attr("required", true);
	$("#supportingdocumentFile").append('<span class="star">*</span>');
}*/

function enableSelectFile(){
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

$("input[type=file]").keypress(function(ev) {
	return false;
	// ev.preventDefault(); //works as well

});

function historyRecord(txnID) {
	// ////console.log("txn id=="+txnID)
	$("#tableOnModal").openModal({
		dismissible : false
	});
	var filter = [];
	var formData = new FormData();
	
	
	if (userType == "CEIRAdmin"){
		var filterRequest = {

		"columns" : [ "created_on", "modified_on", "txn_id", "user_type",
				"approve_status", "trademark", "product_name", "model_number",
				"manufacturer_country", "frequency_range", "tac",
				"remark","admin_user_id","user_id" ],
		"tableName" : "type_approved_db_aud",
		"dbName" : "ceirconfig",
		"txnId" : txnID,
		"featureId":21
	}
	}else{
		var filterRequest = {

				"columns" : [ "created_on", "modified_on", "txn_id", "user_type",
						"approve_status", "trademark", "product_name", "model_number",
						"manufacturer_country", "frequency_range", "tac",
						"remark","user_id" ],
				"tableName" : "type_approved_db_aud",
				"dbName" : "ceirconfig",
				"txnId" : txnID,
				"featureId":21
			}
	}
	
	formData.append("filter", JSON.stringify(filterRequest));
	if (lang == 'km') {
		var langFile = './resources/i18n/khmer_datatable.json';
	}
	else if(lang=='en'){
		var langFile='./resources/i18n/english_datatable.json';
	}	
	// ////console.log("22");
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	
	$.ajax({
		url : './Consignment/consignment-history',
		type : 'POST',
		data : formData,
		processData : false,
		contentType : false,
		success : function(result) {
			var dataObject = eval(result);
			// //alert(JSON.stringify(dataObject.data))
			$('#data-table-history').dataTable({
				"order" : [ [ 1, "asc" ] ],
				destroy : true,
				"serverSide" : false,
				orderCellsTop : true,
				"ordering" : false,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"scrollX" : true,
				"oLanguage": {  
					"sUrl": langFile  
				},	
				"bSearchable" : true,
				pageLength : 3,
				"data" : dataObject.data,
				"columns" : dataObject.columns

			});
			$('div#initialloader').delay(300).fadeOut('slow');
		}

	});

	$('.datepicker').on('mousedown', function(event) {
		event.preventDefault();
	});

}

function Resetfilter(formID){
	$('#endDate').css('border-color', '');
	$('#errorMsg').text('');
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	//$('#filteredModel').val('');
	//registrationDatatable(lang,null);
	$('#filteredModel').empty();
	getModelName();
	typeApprovedDataTable(lang)
}

//****************************************************Export Excel ************************************************************************
function exportTacData() {
	
	var txn = (txnIdValue == 'null' && transactionIDValue == undefined) ? $('#transactionID').val() : transactionIDValue;
	var source__val;
	var tacStartDate = $('#startDate').val();
	var tacEndDate = $('#endDate').val();
	var tacStatus = parseInt($('#Status').val());
	var tacNumber = $('#tac').val();
	var table = $('#ImporterAdmintypeAprroveTable').DataTable();
	var info = table.page.info();
	var pageNo = info.page;
	var pageSize = info.length;
	
	if (isNaN(tacStatus)) {
		tacStatus = '';
	}
	
	if(transactionIDValue != undefined){
		source__val = 'noti'
	}else{
		source__val = tacStartDate != ''|| tacEndDate != ''|| tacStatus != '-1'|| tacNumber != ''|| txn != '' ? 'filter' : $("body").attr("data-session-source");
	}
	
	
	var txn = (txnIdValue == 'null' && transactionIDValue == undefined) ? $(
	'#transactionID').val() : transactionIDValue;

	var FilterUserType = $('#userType').val() == '-1'
	|| $('#userType').val() == undefined ? null : $(
	"#userType option:selected").text();
	var modelNumber = $('#filteredModel').val() == '' || $('#filteredModel').val() == undefined ? -1 : $('#filteredModel').val();
	var productName = $('#filterdbrandname').val() == undefined || $('#filterdbrandname').val() == -1 ? null : $('#filterdbrandname').val();
	var countryName = $('#country').val() == undefined || $('#country').val() == -1 ? null : $('#country').val();

	
	if (userType == "CEIRAdmin") {

		
var TRCRequest = {
		"endDate" : $('#endDate').val(),
		"startDate" : $('#startDate').val(),
		"tac" : $('#tac').val(),
		"txnId" : $('#transactionID').val() == null ? txn : $('#transactionID').val(),
		"userId" : userId,
		"featureId" : parseInt(featureId),
		"userTypeId" : parseInt($("body").attr("data-userTypeID")),
		"userType" :  userType,
		//"userType" : $("body").attr("data-roleType"),
		"status" : parseInt($('#Status').val()),
		"filterUserType" : FilterUserType,
		"displayName" : $('#filterDisaplay').val(),
		"productName" : productName,
		"source":source__val,
		"modelNumber" : parseInt(modelNumber),
		"countryName" : countryName,
		"pageNo":parseInt(pageNo),
		"pageSize":parseInt(pageSize)
	}

}else if(userType == "TRC"){

var TRCRequest = {
	"endDate" : $('#endDate').val(),
	"startDate" : $('#startDate').val(),
	"tac" : $('#tac').val(),
	"txnId" :$('#transactionID').val() == null ? txn : $('#transactionID').val(),
	"userId" : userId,
	"featureId" : parseInt(featureId),
	"userTypeId" : parseInt($("body").attr("data-userTypeID")),
	"userType" : $("body").attr("data-roleType"),
	"status" : parseInt($('#Status').val()),
	"modelNumber" :  -1,
	"pageNo":parseInt(pageNo),
	"pageSize":parseInt(pageSize),
	"trademark" : $('#trademark').val()
}

} else {

var TRCRequest = {
	"endDate" : $('#endDate').val(),
	"startDate" : $('#startDate').val(),
	"tac" : $('#tac').val(),
	"txnId" : $('#transactionID').val() == null ? txn : $('#transactionID').val(),
	"userId" : userId,
	"featureId" : parseInt(featureId),
	"userTypeId" : parseInt($("body").attr("data-userTypeID")),
	"userType" : $("body").attr("data-roleType"),
	"status" : parseInt($('#Status').val()),
	"productName" : productName,
	"modelNumber" : parseInt(modelNumber),
	"countryName" : countryName,
	"pageNo":parseInt(pageNo),
	"pageSize":parseInt(pageSize),
	"trademark" : $('#trademark').val()
}
}

	
////console.log(JSON.stringify(filterRequest))
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './exportTac',
		type: 'POST',
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(TRCRequest),
		success: function (data, textStatus, jqXHR) {
			  finalURL(data.url);

		},
		error: function (jqXHR, textStatus, errorThrown) {
			
		}
	});

}
