var featureId = $("body").attr("data-featureId");

    var {featureId,roleType,userId,currentRoleType,userTypeId,userName,
    startdate,endDate,lang,role,userType} = {
    featureId :featureId,
    roleType :$("body").attr("data-roleType"),
    userId :$("body").attr("data-userID"),
    currentRoleType : $("body").attr("data-selected-roleType"),
    userTypeId:	$("body").attr("data-userTypeID"),
    userType:	$("body").attr("data-roleType"),
    userName:	$("body").attr("data-selected-username"),
    startdate:	$('#startDate').val(),
    endDate:	$('#endDate').val(),
    lang:	    window.parent.$('#langlist').val() == 'km' ? 'km' : 'en',
    role :      this.currentRoleType === null ? roleType : this.currentRoleType
    };

    $(document).ready(function(){
    $('div#initialloader').fadeIn('fast');
    pageRendering();
    viewLMDatatable();
    });



    let payloadParameter =() => {

    let isEmpty = (x)=>{
    if(x == undefined || x == ''){return null};
    return x;
    };
    $('div#initialloader').fadeIn('fast');
    var ellipsis = "...";
  var filterRequest={
			"serialNumber" : $('#viewSerialNumber').val()=="" ? null : $('#viewSerialNumber').val(),
			"imei" : $('#imei').val()=="" ? null : $('#imei').val(),
			"manufacturerId" : $('#viewManufactureID').val()=="" ? null : $('#viewManufactureID').val(),
			"manufacturerName" : $('#viewManufactureNamer').val()=="" ? null : $('#viewManufactureNamer').val(),
			"auditTrailModel":{
				"startDate":$('#viewstartDate').val()=="" ? null : $('#viewstartDate').val(),
				"endDate":$('#viewstartDate').val()=="" ? null : $('#viewstartDate').val(),
 				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"userName" : $("body").attr("data-selected-username"),
 			}
	}

    return filterRequest;

    }


    function viewLMDatatable(){
    if(lang=='en'){
    var langFile='./resources/i18n/english_datatable.json';
    }

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    url: './headers?type=viewLocalManufactureHeaders',
    type: 'POST',
    dataType: "json",
    success: function(result){
    var table=	$("#historyTableDiv").DataTable({
    destroy:true,
    "serverSide": true,
    orderCellsTop : true,
    "ordering" : true,
    "bPaginate" : true,
    "bFilter" : false,
    "bInfo" : true,
    "bSearchable" : true,
    "scrollX": true,
    "language": {
    "sEmptyTable": "No records found in the system",
    "infoFiltered": ""
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
    url : './viewLocalManufactureData',
    type: 'POST',
    dataType: "json",
    data : function(d) {
    d.filter = JSON.stringify(payloadParameter());
    },
    error: function (jqXHR, textStatus, errorThrown,data) {

    }
    },
    "columns": result,
    fixedColumns: true,
    columnDefs: [{targets:[3], class:"columnwrap"}]
    });


    $('div#initialloader').delay(300).fadeOut('slow');

    },
    error: function (jqXHR, textStatus, errorThrown) {

    }
    });
    }


    function pageRendering(){
    return new Promise((resolve, reject) => {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });

    $.ajax({
    url: './viewLocalManufacture/pageRendering',
    type: 'POST',
    dataType: "json",
    success: function(data){
    var elem='<h1>'+data.pageTitle+'<h1>';
    $("#pageHeader").append(elem);
    $("#pageHeader").append('<div class="toggle-row ml-auto mr-4"></div>');
    $("#pageHeader").append('<a href="./localManufacturerIMEI?FeatureId='+featureId+'" target="mainArea"><button type="button"  id="btnLink"  class="btn btn-outline-dark">Back</button></a>');

    var button=data.buttonList;
    var date=data.inputTypeDateList;

				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){
								$("#filterSection").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkUploadedDate(viewstartDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#filterSection").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");

					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#filterSection").append(
										"<div class='form-group'>"+
										//"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
										"<label for="+date[i].id+">"+date[i].title+"</label>"+
										"<select id="+date[i].id+"  class='form-control'>"+
										"<option value='' selected>Select</option>"+
										"</select>"+
										"</div>"+
								"</div>");
					}

				}

    var viewFilter="viewFilter";


			$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")

  			$("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='clearFilter'>Reset All</button></div>");
    $("#filterButtonSection").append("<div class='form-group'><button type='button' id='historyFilter' class='btn btn-outline-dark' onclick='viewLMDatatable()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
    $("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportViewData()'>"+$.i18n('Export')+" <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

  $('#clearFilter').attr("onclick", "filterReset('viewFilter')");
  resolve();
    }
    });
    });
    };


    $('.datepicker').on('mousedown',function(event){
    event.preventDefault();
    });


function filterReset(formID){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	$('#errorMsgDiv').text('');
	viewLMDatatable();
}



function exportViewData() {
  var table = $('#historyTableDiv').DataTable();
  var info = table.page.info();
  var pageNo = info.page;
  var pageSize = info.length;

  var payload={
			"serialNumber" : $('#viewSerialNumber').val()=="" ? null : $('#viewSerialNumber').val(),
			"manufacturerId" : $('#viewManufactureID').val()=="" ? null : $('#viewManufactureID').val(),
			"manufacturerName" : $('#viewManufactureNamer').val()=="" ? null : $('#viewManufactureNamer').val(),
			"pageNo": parseInt(pageNo),
			 "pageSize": parseInt(pageSize),
			"auditTrailModel":{
				"startDate":$('#viewstartDate').val()=="" ? null : $('#viewstartDate').val(),
				"endDate":$('#viewstartDate').val()=="" ? null : $('#viewstartDate').val(),
 				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"userName" : $("body").attr("data-selected-username"),
			}
	}

  ////console.log(JSON.stringify(filterRequest))
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: './exportViewLMDetails',
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(payload),
    success: function(data, textStatus, jqXHR) {

      finalURL(data.url);
    },
    error: function(jqXHR, textStatus, errorThrown) {}
  });
}
