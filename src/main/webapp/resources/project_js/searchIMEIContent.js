//var featureId = 26;
var featureId = $("body").attr("data-featureId");
var userId = $("body").attr("data-userID");
var cierRoletype = sessionStorage.getItem("cierRoletype");
var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
var userType = $("body").attr("data-roleType");
var userName = $("body").attr("data-selected-username");
var msisdn = $("body").attr("data-msisdn");
var imei = $("body").attr("data-imei");

var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

$.i18n().locale = lang;


$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
}).done( function() {

});

$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	$('.content-box input[type="text"]').val('');
	var imeiDetail = localStorage.getItem("jsonData");
	//console.log("imeiDetail --" +imeiDetail);
	var deviceDetail =localStorage.getItem("mdrJsonData");

	setGsmaDetails(JSON.parse(imeiDetail));

	setDeviceInformation(JSON.parse(deviceDetail));
	getDeviceState();
});

function setGsmaDetails(imeiDetail){
    $("#msisdn").val(imeiDetail.msisdn);
	$("#imei").val(imeiDetail.imei);
	$("#imsi").val(imeiDetail.imsi);
};

function setDeviceInformation(data){
        $("#handsetType").val(data.deviceType);
		$("#osType").val(data.os);
		$("#brandName").val(data.brandName);
		$("#modelName").val(data.modelName);
		$("#marketingName").val(data.marketingName);
		$("#manufactureName").val(data.manufacturer);
		//$("#deviceStatus").val(data.deviceStatus);
		$("#organizationId").val(data.organizationId);
		$("#trcApprovalStatus").val(data.trcApprovedStatus);
};

function getDeviceState(customerCareRequest) {
    var customerCareRequest = {
            "imei": $("body").attr("data-imei"),
            "msisdn": $("body").attr("data-msisdn"),
    };

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': token
        }
    });

    return $.ajax({
        url: "./get-device-state",
        type: 'POST',
        data: JSON.stringify(customerCareRequest),
        dataType : 'json',
        contentType : 'application/json; charset=utf-8',
        success: function (data) {
            //console.log("data " +JSON.stringify(data));
            initializeDeviceStateTable(data);
            var flattenedData = data.result.flat();
            initializeDeviceStateTable(flattenedData);
           },
    });
};


function initializeDeviceStateTable(data) {
    //console.log("data -- " +data);
    $('#DeviceStateTable').DataTable({
        "destroy": true,
        "searching": false,
        "paging": false,
        "info": false,
        "ordering": false,
        "language": {
            "emptyTable": "No records found in the system",
            "infoFiltered": ""
        },
        "data": data,
        "columns": [
            {
                "data": "tableName",
                "defaultContent": "NA"
            },
            {
                "data": "createdOn",
                "defaultContent": "NA"

            },
            {
                "data": "imei",
                "defaultContent": "NA",
                "render": function (data, type, row) {
                    if (typeof row['imei'] === 'undefined' || row['imei'] === null || row['imei'] === '') {
                        return '<td><a title="View"><img src="./resources/assets/images/fi-rr-cross.svg" alt="icon" class="cross-icon"></a></td>';
                    } else {
                        return '<td><a title="View"><img src="./resources/assets/images/tick-circle.svg" alt="icon" class="cross-icon"></a></td>';
                    }
                }
            },
            {
                "render": function (data, type, row) {
                    if (typeof row['imei'] === 'undefined' || row['imei'] === null || row['imei'] === '') {
                        return '<td><a title="View"><img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid grayscale"></a></td>';
                    } else {
                        var tableName = row['tableName'];
                        var imei= row['imei']
                        return '<td><a onclick="viewTableDetail(\'' +imei + '\', \'' + tableName + '\')" title="View"><img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid"></a></td>';
                    }
                }
            }
        ]

    });
    $('div#initialloader').delay(300).fadeOut('slow');
};


var blackListTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
    
    { title: 'IMEI',"data": "imei","defaultContent": "NA"},
    { title: 'MSISDN',"data": "msisdn","defaultContent": "NA"},
    { title: 'IMSI',"data": "imsi","defaultContent": "NA"},
    { title: 'Source',"data": "source","defaultContent": "NA"}
];


var blackListHistoryTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
    
    { title: 'IMEI',"data": "imei","defaultContent": "NA"},
    { title: 'MSISDN',"data": "msisdn","defaultContent": "NA"},
    { title: 'IMSI',"data": "imsi","defaultContent": "NA"},
    { title: 'Source',"data": "source","defaultContent": "NA"},
    { title: 'Operation',"data": "operationInterp","defaultContent": "NA"},
];


var greyListTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
	{ title: 'IMEI',"data": "imei","defaultContent": "NA"},
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA"},
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA"},
	{ title: 'Source',"data": "source","defaultContent": "NA"}
];


var greyListHistoryTableArray = [
	    { title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
    	{ title: 'IMEI',"data": "imei","defaultContent": "NA"},
    	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA"},
    	{ title: 'IMSI',"data": "imsi","defaultContent": "NA"},
    	{ title: 'Source',"data": "source","defaultContent": "NA"},
    	{ title: 'Operation',"data": "operationInterp","defaultContent": "NA"},
];


var pairingListTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
	{ title: 'IMEI',"data": "imei","defaultContent": "NA"},
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA"},
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA"},
	{ title: 'Pairing Mode',"data": "pairMode","defaultContent": "NA"}
];


var pairingListHistoryTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
	{ title: 'IMEI',"data": "imei","defaultContent": "NA"},
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA"},
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA"},
	{ title: 'Pairing Mode',"data": "pairMode","defaultContent": "NA"},
	{ title: 'Operation',"data": "action","defaultContent": "NA"}
];


var stolenTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
	{ title: 'IMEI',"data": "imei","defaultContent": "NA"},
	{ title: 'Category',"data": "status","defaultContent": "NA"},
	//{ title: 'Serial Number',"data": "requestType","defaultContent": "NA"},
	{ title: 'Request Mode',"data": "requestType","defaultContent": "NA"},
    { title: 'Request ID',"data": "requestId","defaultContent": "NA"}
];


var stolenHistoryTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
	{ title: 'IMEI',"data": "imei","defaultContent": "NA"},
	{ title: 'Category',"data": "status","defaultContent": "NA"},
	{ title: 'Request Mode',"data": "requestType","defaultContent": "NA"},
	{ title: 'Request ID',"data": "requestId","defaultContent": "NA"}
];

var customTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA" },
    { title: 'IMEI',"data": "imei","defaultContent": "NA" },
	{ title: 'Serial Number',"data": "serialNumber","defaultContent": "NA" },
];

var nwlTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA" },
    { title: 'IMEI',"data": "imei","defaultContent": "NA" },
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA" },
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA" },
    //{ title: 'GSMA Status',"data": "validityFlag","defaultContent": "NA" },
	{ title: 'TRC Status',"data": "trcImeiStatusInterp","defaultContent": "NA" },
	{ title: 'GDCE/Manufacture Status',"data": "gdceStatusInterp","defaultContent": "NA" },
	{ title: 'Validity Status',"data": "validityFlagInterp","defaultContent": "NA" },
	{ title: 'Reason',"data": "reasonForInvalidImei","defaultContent": "NA" },
];

var invalidImeiTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA" },
    { title: 'IMEI',"data": "imei","defaultContent": "NA" },
];

var duplicateDeviceTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA" },
	{ title: 'Modified Date',"data": "modifiedOn","defaultContent": "NA" },
	{ title: 'IMEI',"data": "imei","defaultContent": "NA" },
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA" },
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA" },
];

var duplicateHistoryTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA" },
	{ title: 'Modified Date',"data": "modifiedOn","defaultContent": "NA" },
	 { title: 'IMEI',"data": "imei","defaultContent": "NA" },
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA" },
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA" },
	{ title: 'Operation',"data": "operationInterp","defaultContent": "NA" },
	{ title: 'Source',"data": "source","defaultContent": "NA" }
];


var duplicateTableArray = [
	{ title: 'Detection Date',"data": "createdOn","defaultContent": "NA" },
    { title: 'IMEI',"data": "imei","defaultContent": "NA" },
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA" },
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA" },
	{ title: 'Last Active Date',"data": "modifiedOn","defaultContent": "NA" }
];

var EDRDuplicateTableArray = [
	{ title: 'Detection Date',"data": "createdOn","defaultContent": "NA" },
    { title: 'IMEI',"data": "imei","defaultContent": "NA" },
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA" },
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA" },
	{ title: 'Last Active Date',"data": "modifiedOn","defaultContent": "NA" }
];

var exceptionListTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
    { title: 'IMEI',"data": "imei","defaultContent": "NA"},
    { title: 'MSISDN',"data": "msisdn","defaultContent": "NA"},
    { title: 'IMSI',"data": "imsi","defaultContent": "NA"},
    { title: 'Source',"data": "source","defaultContent": "NA"}
];

var exceptionListHistoryTableArray = [
	    { title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
    	{ title: 'IMEI',"data": "imei","defaultContent": "NA"},
    	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA"},
    	{ title: 'IMSI',"data": "imsi","defaultContent": "NA"},
    	{ title: 'Source',"data": "source","defaultContent": "NA"},
    	{ title: 'Operation',"data": "operationInterp","defaultContent": "NA"},
];

var localManufacturerTableArray=[
         { title: 'Created Date',"data": "createdOn","defaultContent": "NA"},
         { title: 'IMEI',"data": "imei","defaultContent": "NA"},
         { title: 'Serial Number',"data": "serialNumber","defaultContent": "NA"},
];

var genericTableArray = [
	{ title: 'Created Date',"data": "createdOn","defaultContent": "NA" },
    { title: 'IMEI',"data": "imei","defaultContent": "NA" },
	{ title: 'MSISDN',"data": "msisdn","defaultContent": "NA" },
	{ title: 'IMSI',"data": "imsi","defaultContent": "NA" },
];


 function viewTableDetail(imei,tableName){
  $('div#initialloader').fadeIn('fast');
	$("#historyTableDiv").css("display", "none");
	$("#mainTableDiv").css("display", "none");

	$("#tableModelLabel,#historyTableModelLabel").text("");
	var headers;
	var historyHeaders;

	if(tableName == 'Black List'){
		headers = blackListTableArray;
		historyHeaders = blackListHistoryTableArray;
	}else if(tableName == 'Grey List'){
		headers = greyListTableArray;
		historyHeaders = greyListHistoryTableArray;

	}else if(tableName == 'Pairing'){
		headers = pairingListTableArray;
		historyHeaders = pairingListHistoryTableArray;
	}else if(tableName == 'Stolen'){
		console.log("tableName is  Stolen "+tableName);
		headers = stolenTableArray;
		historyHeaders = stolenHistoryTableArray;
	}else if(tableName == 'Custom'){
		//console.log("tableName is  Custom "+tableName);
		headers = customTableArray;
	}else if(tableName == 'National White List'){
     		//console.log("tableName is  National White List "+tableName);
     		headers = nwlTableArray;
     }else if(tableName == 'Invalid IMEI'){
     		//console.log("tableName is  Invalid IMEI "+tableName);
     		headers = invalidImeiTableArray;
     }else if(tableName == 'Duplicate Device Detail'){
     		console.log("tableName is  Duplicate Device Detail "+tableName);
     		headers = duplicateDeviceTableArray;
     		historyHeaders = duplicateHistoryTableArray;
     }else if(tableName == 'Duplicate'){
     		//console.log("tableName is  Duplicate Device Detail "+tableName);
     		headers = duplicateTableArray;
     }else if(tableName == 'Exception List'){
     		//console.log("tableName is  Duplicate Device Detail "+tableName);
            headers = exceptionListTableArray;
            historyHeaders = exceptionListHistoryTableArray;
     }else if(tableName == 'Local Manufacturer'){
            headers = localManufacturerTableArray;
     }else if(tableName =='EDR_Duplicate'){
       headers = EDRDuplicateTableArray;
     }else if(tableName == 'Black List History'){
		historyHeaders = blackListHistoryTableArray;
	}
	else if(tableName == 'Grey List History'){
		historyHeaders = greyListHistoryTableArray;
	}
	else if(tableName == 'Pairing History'){
		historyHeaders = pairingListHistoryTableArray;
	}
	else if(tableName== 'Stolen History'){
		historyHeaders = stolenHistoryTableArray;
		//console.log("tableName is Stolen History " +tableName);
	}else if(tableName == 'Duplicate Device Detail History'){
     	historyHeaders = duplicateHistoryTableArray;
    }else if(tableName == 'Exception List History'){
        historyHeaders = exceptionListHistoryTableArray;
    }
	else{
		headers = genericTableArray;
	}

		var request ={
				"imei" :  imei,
				"tableName" : tableName,
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"username" : $("body").attr("data-selected-username"),
				"featureId":parseInt(featureId),
				"userId":parseInt(userId),
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
		});
		$.ajax({
				url: './view-table-record',
				type: 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success: function (data) {
							$("#ViewTableDetailModel").openModal({
						 	   dismissible:false
						    });
						//console.log("data.tableResponse.length" +data.tableResponse.length);
						if(data.tableResponse.length != 0){
						    $("#mainTableDiv").css("display", "block");
                            dataTable(data.tableResponse,'tableDetailDatatable',headers);
							$("#tableModelLabel").text(data.tableResponse[0].tableName);
						}
						//console.log("data.historyTableResponse.length" +data.historyTableResponse.length);
						if(data.historyTableResponse.length != 0 ){
						    $("#historyTableDiv").css("display", "block");
                            dataTable(data.historyTableResponse,'tableHistoryDetailDatatable',historyHeaders);
							$("#historyTableModelLabel").text(data.historyTableResponse[0].tableName);
						}
				},

				error: function (jqXHR, textStatus, errorThrown) {
				}
			});
			$('div#initialloader').delay(300).fadeOut('slow');
}


let dataTable =(result,tableID,columnsArray)=>{
if ($.fn.DataTable.isDataTable('#' + tableID)) {
        $('#' + tableID).DataTable().destroy();
        $('#' + tableID).empty();
    };

$('#'+tableID).DataTable({
	dom: 'Bfrtip',
    retrieve: true,
	"data": result,
	"columns": columnsArray,
	"searching": false,
	"bPaginate": false,
	"bInfo" : false,
	"ordering": false
});

$('<style>')
        .prop('type', 'text/css')
        .html(`
            table.dataTable thead th, table.dataTable thead td {
                padding: 8px 5px;
                border-bottom: 1px solid #111;
                width: auto;
                background: var(--main-color) !important;
                color: var(--white-color) !important;
            }
        `)
        .appendTo('head');

};





