var ellipsis = "...";
var {featureId,roleType,userId,currentRoleType,userTypeId,userName,
startdate,endDate,lang,role,userType} = {
featureId :94,
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
table();
pageRendering().then(() => filterDropdown());
});



let payloadParameter =() => {

let isEmpty = (x)=>{
if(x == undefined || x == ''){return null};
return x;
};
$('div#initialloader').fadeIn('fast');
var ellipsis = "...";
var featureName=isEmpty($('#featureName').val());
var {startDate,endDate,featureTxnId,msisdn,email,channelType} = {
featureTxnId : isEmpty($('#txn').val()),
msisdn : isEmpty($('#msisdn').val()),
email : isEmpty($('#email').val()),
channelType : isEmpty($('#channelType').val()),
startDate : isEmpty($('#startDate').val()),
endDate : isEmpty($('#endDate').val()),
};


var filterRequest=  {
"featureTxnId" : featureTxnId,
"msisdn" :msisdn ,
"email" : email,
"featureName" : featureName,
"channelType" : channelType,
"auditTrailModel": {
"startDate":startDate,
"endDate":endDate,
"roleType":roleType,

"featureId":parseInt(featureId),
"userTypeId": parseInt(userTypeId),
"userType":roleType,
"userName" : userName,
"userId":parseInt(userId),
"type" : parseInt($('#type').val()),
}
}

return filterRequest;

}
function table(){
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
url: './headers?type=notification',
type: 'POST',
dataType: "json",
success: function(result){
var table=	$("#server-side-table").DataTable({
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
url : './notification/paging',
type: 'POST',
dataType: "json",
data : function(d) {
d.filter = JSON.stringify(payloadParameter());
},
error: function (jqXHR, textStatus, errorThrown,data) {
/*
window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
window.parent.$('#500ErrorModal').openModal({
dismissible:false
});*/

}
},
"columns": result,
fixedColumns: true,
columnDefs: [
{
render: function ( data, type, row ) {
return data.length > 80 ?
data.substr( 0, 80 ) + ellipsis : data;
},
targets: 5,
},
{ width: 100, targets: result.length - 1 },
{ orderable: false, targets: -1 }
]
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
url: './notification/page-rendering',
type: 'POST',
dataType: "json",
success: function(data){
var elem='<h1>'+data.pageTitle+'<h1>';
$("#pageHeader").append(elem);

var button=data.buttonList;

var date=data.inputTypeDateList;



for(i=0; i<date.length; i++){
if(date[i].type === "date"){
$("#filterSection").append("<div class='form-group'>"+
"<label for="+date[i].id+">"+date[i].title+"</label>"+
"<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
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

$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")

$("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='clearFilter'>Reset All</button></div>");
$("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='table()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
$("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");


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
$('#errorMsg').text('');
table();
}



function exportData(){

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});
$.ajax({
url: './notification/export',
type: 'POST',
dataType : 'json',
contentType : 'application/json; charset=utf-8',
data : JSON.stringify(payloadParameter()),
success: function (data, textStatus, jqXHR) {
finalURL(data.url);

},
error: function (jqXHR, textStatus, errorThrown) {

}
});

}



function filterDropdown(){

$.getJSON('./getDropdownList/NOTIFICATION_CHANNEL_TYPE', function(data) {
for (i = 0; i < data.length; i++) {
$('<option>').val(data[i].interpretation).text(data[i].interpretation)
.appendTo('#channelType');
}
});
$.getJSON('./getDropdownList/FEATURE_NAME_LIST', function(data) {
for (i = 0; i < data.length; i++) {
$('<option>').val(data[i].interpretation).text(data[i].interpretation)
.appendTo('#featureName');
}
});
}


let view = (id) =>{
$('#forMSISDN,#forEmail').hide();
let payload = payloadParameter();
payload['id']=id;
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});
$.ajax({
url: './notification',
type: 'POST',
dataType : 'json',
contentType : 'application/json; charset=utf-8',
data : JSON.stringify(payload),
success: function (data, textStatus, jqXHR) {
if(data.channelType=='SMS' || data.channelType=='SMS_OTP' || data.channelType=='CONTAIN_SMS'){
$('#msisdnval').text(data.msisdn);
$('#messageMsisdn').text(data.message);
$('#forMSISDN').show();
				$("#viewModel").openModal({
					        dismissible:false
					    });
}
if(data.channelType=='EMAIL'  || data.channelType=='EMAIL_OTP' || data.channelType=='CONTAIN_EMAIL'){
$('#messageEmail').text(data.message);
$('#subject').text(data.subject);
$('#emailId').text(data.email);
$('#forEmail').show();
				$("#viewModel").openModal({
					        dismissible:false
					    });
}

},
error: function (jqXHR, textStatus, errorThrown) {

}
});

};