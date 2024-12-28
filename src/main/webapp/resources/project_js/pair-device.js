    $(document).ready(function() {
    var IMEI;
    var lang= $("body").attr("data-lang-param");
    $.i18n().locale = lang;
    $('.addImei').on('click', function() {
    $.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
    }).done(function() {
    var imeiCount = $('.imei-row').length + 1;
    if (imeiCount <= 4) {
    var newImeiRow = `
    <div class="form-row imei-row" id="filedivimei${imeiCount}">
    <div class="form-group col-md-5">
    <label for="imei${imeiCount}">${$.i18n("IMEI")} ${$.i18n(imeiCount.toString())}<span class="star">*</span></label>
    <input type="text" autocomplete="off" class="form-control imei" id="imei${imeiCount}" name="imei${imeiCount}" placeholder='${$.i18n('15digitIMEINumber')}'
    pattern="[0-9]{15,16}" minlength="15" maxlength="15" oninput="InvalidMsg(this,'input','${$.i18n('validation.imei.16digit')}');"
    oninvalid="InvalidMsg(this,'input','${$.i18n('validation.imei.16digit')}');"
    required>
    </div>
    <div class="form-group col-md-5">
    <label for="phoneNumber${imeiCount}">${$.i18n("PhoneNumber")} <span class="star">*</span></label>
    <input type="text" autocomplete="off" class="form-control phoneNumber" id="phoneNumber${imeiCount}" name="phoneNumber${imeiCount}"
    placeholder='${$.i18n('EnterPhoneNumber')}'
    minlength="9" maxlength="12" pattern="^(0\\d{8,9}|855\\d{8,9})$"
    oninput="InvalidMsg(this,'input','${$.i18n('validation.msisdn.10digit.0855')}');"
    oninvalid="InvalidMsg(this,'input','${$.i18n('validation.msisdn.10digit.0855')}');" required>
    </div>

    <div class="form-group col-md-2"><label for="" class="mt-38">
    <a onclick="remove_field('imei${imeiCount}')" class="waves-effect waves-light removeImei"><i class="fa fa-trash delete-icon delete-icon-35" aria-hidden="true"></i></a>

    </div>
    `;
    $('#imeiContainer').append(newImeiRow);
    } else {
    $(this).prop('disabled', true);
    }
    });
    });


    $('#pairDeviceForm').on('submit', function(event) {
    event.preventDefault();
    var recaptcha=$("#pairDeviceForm #g-recaptcha-response").val();
    if(recaptcha===""){
    $("#errorMsgOnModal").css("display", "block");
    return false;
    }

    otpVerifyLimit=3;
    timeLeft=-1;
    otpTry=1;
    resendCount=1;
    document.getElementById("resendOTPclick").style.pointerEvents = "none";
    $('#resendOTPclick').css("color","#807a8759");

    var pairs = [];

    var isValidMSISDN=true;
var invalidPairs = [];

    $('.imei-row').each(function() {
    var imei = $(this).find('.imei').val();
    var msisdn = $(this).find('.phoneNumber').val();

    let isValidMsisdn = false;
    if(msisdn !=''){
    isCheckPass(msisdn, function(result) {
    if(result==false){
    invalidPairs.push(msisdn);
 //   errorModal("invalid_phone_number");
    isValidMsisdn = false;
    }
    else {
    isValidMsisdn = true;
    }

    });
    if (!isValidMsisdn) {
    return;
    }
    }
    pairs.push({ imei: imei, msisdn: msisdn });
    });


    let isValidContactNumber = false;
    var serialNumber = $('#serialNumber').val();
    var contactNumber = $('#contactNumber').val();
    var emailId = $('#emailAddress').val();


    if (contactNumber !== '') {
    isCheckPass(contactNumber, function(result) {
    if (result === false) {
   errorModal("invalid_contact_number",contactNumber);
    isValidContactNumber = false;
    }
    else{isValidContactNumber = true;
    }
    });
    if (!isValidContactNumber) {
    return;
    }
    }

    if(contactNumber=='' && emailId==''){
    errorModal("error_msg_pairdevice");
    return false;
    }

 if(invalidPairs.length){ errorModal("invalid_phone_number",invalidPairs); return;}

    var jsonData = {
    pairs: pairs,
    serialNumber: serialNumber,
    contactNumber: contactNumber,
    emailId: emailId || null,
    language: $('#langList').val()
    };


    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    url: './pair-device',
    type: 'POST',
    contentType: 'application/json',
     async: false,
         beforeSend: function() {
         $('#pairDeviceSubmitBtn').prop('disabled',true);
         },
    data: JSON.stringify(jsonData),
    success: function(data) {
    if(data.status ==='Success'){
    if(data.result.response ==='Success'){
    timeLeft = $("body").attr("data-timeout");
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
    }
    $('#errorMsgDiv,#errorDiv,#phoneNumberOTP,#emailMasking,#countryCode').html('');
    $('#otpFormRequest').trigger('reset');
    $('#pairDeviceFormDiv').hide();
    $('#pairDeviceOTPForm').show();
    $("#contactNumber").attr({requestID: data.result.requestId});
/*    let cc = $('#contactNumber').val().charAt(0) === '0' ? '0' : '+855';
     var mobile= cc == '0' ? $('#contactNumber').val().substring(1).replace(/\d(?=\d{4})/g, "x"): contactNumber.substring(3).replace(/\d(?=\d{4})/g, "x");
$('#countryCode').append(cc);
    $('#phoneNumberOTP').append(mobile);
    $('#emailMasking').append(emailId.replace(/\d(?=\d{4})/g, "x"));*/
    countDownFunction();
    document.getElementById("resendOTPclick").style.pointerEvents = "none";
    $('#resendOTPclick').css('color', 'black');

    }
    else{
    errorModal(data.errorInfo.errorMessage);
    }
    },
    error: function(xhr, status, error) {
    }
    });
    $('#pairDeviceSubmitBtn').removeProp('disabled');
    return false;
    });
    });


    function remove_field(fieldId){

    $('#' + fieldId).remove();
    $('#filediv' + fieldId).remove();


    $(".imei-row").each(function(index) {
    var newIndex = index + 1;
    $(this).find("label[for^='imei']").text($.i18n("IMEI") + " " + newIndex).append('<span class="star">*</span>');;
    });
    }

    let back =()=>{
    $('#pairDeviceFormDiv').show();
    $('#pairDeviceOTPForm').hide();
    grecaptcha.reset();
    $("#resendOTPclick,#resendOTPclick_time").css("display", "block");
    }

    let pairdatatableResponse =(data,tableID)=>{
    $('#'+tableID).DataTable({
    "data": data,
    "columns": [
    { "data": null },
    { "data": "actualImei" },
    { "data": "guiMsisdn" },
    { "data": "status" },
    { "data": "description" }
    ],
    "columnDefs": [{
    "targets": 0, // Target the first column (index 0)
    "render": function(data, type, row, meta) {
    // Render sequential numbers
    return meta.row + 1;
    }
    }],
    "searching": false,
    "bPaginate": false,
    "bInfo" : false,
    "ordering": false
    });
    };
