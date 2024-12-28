var featureId = $("body").attr("data-featureId");
$(document).ready(function(){
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});

$.getJSON('./getDropdownList/FEATURE_NAME_LINKED_CC', function(data) {
for (i = 0; i < data.length; i++) {
$('<option>').val(data[i].value).text(data[i].interpretation)
.appendTo('#feature-name');
}
});

});


let manualPairArray = [
//{ title: 'S.No',"data": null },
{ title: 'Created Date',"data": "createdOn" },
{ title: 'Request ID',"data": "requestId" },
{ title: 'Request Type',"data": "requestType" },
{ title: 'IMEI',"data": "imei1" },
{ title: 'IMSI',"data": null },
{ title: 'MSISDN',"data": "msisdn1" }
];


$('#ccform').on('submit', function(event) {
event.preventDefault();
var recaptcha=$("#ccform #g-recaptcha-response").val();
if(recaptcha===""){
$("#errorMsgOnModal").css("display", "block");
return false;
}

$('#rejectedMsgModal,#ccValidModal').hide();
let id= $('#requestId').val();
customerCareRequest = {
requestId : id,
featureName: $('#feature-name').val()
}


var headers = manualPairArray;
customerCareRequest["feature"]="MANUAL";

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});
$.ajax({
url: './pair-device-id',
type: 'POST',
contentType: 'application/json',
data: JSON.stringify(customerCareRequest),
success: function (data, textStatus, jqXHR) {
$('#ccFormDiv').hide();
if(data.requestIdResponse.length == 0){
$('#rejectedMsgModal').show();
}
else{
dataTable(data.requestIdResponse,'requestIDdatatable',headers);
$('#ccValidModal').show();
}
}
});
return false;
});

let dataTable =(data,tableID,columnsArray)=>{
$('#'+tableID).DataTable({
"data": data,
"columns": columnsArray,
/*"columnDefs": [{
"targets": 0, // Target the first column (index 0)
"render": function(data, type, row, meta) {
// Render sequential numbers
return meta.row + 1;
}
}],*/
"searching": false,
"bPaginate": false,
"bInfo" : false,
"ordering": false
});
};

let resetAll = () => {
$('#ccform').trigger('reset');
}