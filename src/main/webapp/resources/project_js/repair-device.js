$(document).ready(function() {
$('#repairDeviceForm').on('submit', function(event) {
event.preventDefault();
var recaptcha=$("#repairDeviceForm #g-recaptcha-response").val();
if(recaptcha===""){
$("#errorMsgOnModal").css("display", "block");
return false;
}
var oldMsisdn = $('#oldPhoneNumber').val();
var newMsisdn = $('#phoneNumber1').val();
var imei = $('#imei').val();
/*var contactNumber = $('#contactNumber').val();
var emailId = $('#emailAddress').val();*/

otpVerifyLimit=3;
timeLeft=-1;
otpTry=1;
resendCount=1;
document.getElementById("resendOTPclick").style.pointerEvents = "none";
$('#resendOTPclick').css("color","#807a8759");


if(oldMsisdn==newMsisdn){
errorModal("equal_value_exist");
return false;
}

/*
else if(contactNumber=='' && emailId==''){
errorModal("contact_email_field");
return false;
}
*/



let isOldMsisdnValid = false;
if(oldMsisdn!=''){
isCheckPass(oldMsisdn, function(result) {
if(result==false){
errorModal("invalid_phone_number",oldMsisdn);
isOldMsisdnValid = false;
}
else {
isOldMsisdnValid = true;
}
});
if (!isOldMsisdnValid) {
return;
}
}


let isnewMsisdnValid = false;
if(newMsisdn!=''){
isCheckPass(newMsisdn, function(result) {
if(result==false){
errorModal("invalid_phone_number",newMsisdn);
isnewMsisdnValid = false;
}
else {
if (newMsisdn.charAt(0) === '0') {
newMsisdn = "855" + newMsisdn.substring(1);
}
isnewMsisdnValid = true;
}
});
if (!isnewMsisdnValid) {
return;
}
}


/*let isValidContactNumber = false;
if (contactNumber !== '') {
isCheckPass(contactNumber, function(result) {
if (result === false) {
errorModal("invalid_contact_number",contactNumber);
isValidContactNumber = false;
}
else{
if (contactNumber.charAt(0) === '0') {
contactNumber = "855" + contactNumber.substring(1);
}
isValidContactNumber = true;
}
});
if (!isValidContactNumber) {
return;
}
}*/


var jsonData = {
oldMsisdn: oldMsisdn,
newMsisdn: newMsisdn,
imei: imei,
/*contactNumber: contactNumber,
emailId: emailId || null,*/
language: $('#langList').val()
};


// Send AJAX request
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({
headers:
{ 'X-CSRF-TOKEN': token }
});
$.ajax({
url: './pair-device/repair',
type: 'POST',
contentType: 'application/json',
async: false,
beforeSend: function() {
$('#repairDeviceSubmitBtn').prop('disabled',true);
},
data: JSON.stringify(jsonData),
success: function(data) {

if(data.result.response ==='Success'){
timeLeft =$("body").attr("data-timeout");
elem = document.getElementById('countdown');
timerId = setInterval(countdown, 1000);
countdown();
$('#field1').val('');
$('#field2').val('');
$('#field3').val('');
$('#field4').val('');
$('#field5').val('');
$('#field6').val('');
otpSuccessModal(data.result.description);

$('#errorMsgDiv,#errorDiv,#phoneNumberOTP,#emailMasking,#countryCode').html('');
$('#otpFormRequest').trigger('reset');
$('#repairDeviceFormDiv').hide();
$('#repairDeviceOTPForm').show();

$("#contactNumber").attr({requestID: data.result.requestId});

/*let cc = $('#contactNumber').val().charAt(0) === '0' ? '0' : '+855';
var mobile= cc == '0' ? $('#contactNumber').val().substring(1).replace(/\d(?=\d{4})/g, "x"): contactNumber.substring(3).replace(/\d(?=\d{4})/g, "x");
$('#countryCode').append(cc);
$('#phoneNumberOTP').append(mobile);
$('#emailMasking').append(emailId.replace(/\d(?=\d{4})/g, "x"));*/
countDownFunction();
document.getElementById("resendOTPclick").style.pointerEvents = "none";
$('#resendOTPclick').css('color', 'black');

}

else{
errorModal(data.result.description);
}
},
error: function(xhr, status, error) {


}
});
$('#repairDeviceSubmitBtn').removeProp('disabled');
return false;
});
});

let back =()=>{
$('#repairDeviceFormDiv').show();
$('#repairDeviceOTPForm').hide();
grecaptcha.reset();
$("#resendOTPclick,#resendOTPclick_time").css("display", "block");
}