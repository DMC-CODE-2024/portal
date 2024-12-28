    var otpVerifyLimit=3;
    var otpTry=1;
    var resendCount=1;

    function digitValidate (input) {
    input.value = input.value.replace(/[^0-9]/g,'');
    }


    const inputs = document.getElementById("inputs");
    inputs.addEventListener("input", function (e) {
    const target = e.target;
    const val = target.value;
    if (isNaN(val)) {
    target.value = "";
    return;
    }

    if (val != "") {
    const next = target.nextElementSibling;
    if (next) {
    next.focus();
    }
    }
    });

    inputs.addEventListener("keyup", function (e) {
    const target = e.target;
    const key = e.key.toLowerCase();

    if (key == "backspace" || key == "delete") {
    target.value = "";
    const prev = target.previousElementSibling;
    if (prev) {
    prev.focus();
    }
    return;
    }
    });


    function otpSuccessModal(message) {
    // Create modal div
    var modalDiv = $('<div>', {
    'class': 'modal fade',
    'id': 'successModal',
    'role': 'dialog'
    });

    // Create modal dialog div
    var modalDialogDiv = $('<div>', {
    'class': 'modal-dialog'
    });

    // Create modal content div
    var modalContentDiv = $('<div>', {
    'class': 'modal-content success-popup'
    });

    // Create modal body
    var modalBodyDiv = $('<div>', {
    'class': 'modal-body'
    });

    // Create modal content
    var modalContent = $('<p>').append(
    $('<img>', {
    'src': './resources/assets/images/check.svg',
    'alt': '',
    'class': 'mr-6'
    }),
    message
    );

    modalBodyDiv.append(modalContent);
    modalContentDiv.append(modalBodyDiv);
    modalDialogDiv.append(modalContentDiv);
    modalDiv.append(modalDialogDiv);
    $('body').append(modalDiv);
    var modalObj = new bootstrap.Modal(modalDiv[0]);
    modalObj.show();
    setTimeout(function() {
    modalObj.hide();
    modalDiv.remove();
    }, 5000);
    }

    function errorModal(message,arr){

    var modalHtml = `
    <div class="modal fade modalBackdrop hidden" id="InvalidRequest" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true" style="display:none">
    <div class="modal-dialog modal-sm transform-10" id="1233189" role="document">
    <div class="modal-content">
    <div class="modal-body">
    <button type="button" class="alert-close close" onclick="closeModal('InvalidRequest')">
    <span aria-hidden="true"><img src="./resources/assets/images/icons-close.svg" alt="close"></span>
    </button>
    <p class="Rejected" id="rejectedMsg"></p>
    </div>
    </div>
    </div>
    </div>
    `;

    $.i18n().locale =  $('#langList').val();
    $.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
    }).done(function() {
    if(arr == undefined){
    $('#rejectedMsg').html($.i18n(message));
    }
    else{
    $('#rejectedMsg').html(arr +" "+$.i18n(message));
    }
    });
    // Append modal HTML to the body
    $("body").append(modalHtml);

    $('#InvalidRequest').show();
    }


    let closeModal = (modalID)=>{
    $('#'+modalID).hide();
    }

    let countDownFunction = ()=>{
    timeLeft =$("body").attr("data-timeout");
    elem = document.getElementById('countdown');
    timerId = setInterval(countdown, 1000);
    countdown();
    }


    /*  Resent OTP */
    let resendOTP =()=>{

    if(resendCount>otpVerifyLimit){

    $("#resendOTPclick,#resendOTPclick_time").css("display", "none");
    }
    var request={
    "requestId": $("#contactNumber").attr("requestID")
    }
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    url: './pair-device/resend-otp',
    type: 'POST',
    contentType: 'application/json',
    data: JSON.stringify(request),
    success: function (data, textStatus, jqXHR) {
    countDownFunction();
    document.getElementById("resendOTPclick").style.pointerEvents = "none";
    $('#resendOTPclick').css('color', 'black');
    $('#resendOTPclick').css('cursor', 'none');
    if(data.result.response == 'Otp' || data.result.response == 'Pair-Invalid'){
    errorModal(data.result.description);
    }
    else{
    if(resendCount <= otpVerifyLimit){ otpSuccessModal(data.result.description);}
    else{
    var lang= $('#langList').val();
    $.i18n().locale = lang;
    $.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
    }).done(function() {
    errorModal($.i18n('limitExceedMsg'));
    });
    }

    resendCount++;
    }

    },
    error: function (jqXHR, textStatus, errorThrown) {

    }
    });
    };













    /*OTP API*/
    function submitOTPRequest(event,mav){

    const form=document.getElementById("otpFormRequest");

    if(!validateOTPForm(form,event)){return;}
    event.preventDefault();

    if(otpTry>otpVerifyLimit){
    if(mav=='pair'){
    $('#pairDeviceOTPForm').hide();
    $('#otpLimitExceedModal').show();
    }
    if(mav=='repair'){
    $('#repairDeviceOTPForm').hide();
    $('#otpLimitExceedModal').show();
    }
    if(mav=='repair'){
    $('#repairDeviceOTPForm').hide();
    $('#otpLimitExceedModal').show();
    }
    if(mav=='checkpairstatus'){
    $('#OTPForm').hide();
    $('#otpLimitExceedModal').show();
    }
    }

    const field1=form.field1.value;
    const field2=form.field2.value;
    const field3=form.field3.value;
    const field4=form.field4.value;
    const field5=form.field5.value;
    const field6=form.field6.value;
    var request={
    "requestId": $("#contactNumber").attr("requestID"),
    "otp": field1+field2+field3+field4+field5+field6
    }

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    url: './pair-device/otp',
    type: 'POST',
    contentType: 'application/json',
     async: false,
    data: JSON.stringify(request),
    success: function (data, textStatus, jqXHR) {

    if(mav=='pair'){
    if( data.result.response == 'Pair-Invalid'){
    $('#pairDeviceOTPForm,#otpLimitExceedModal').hide();
    //$('#rejectModalMsg').html(data.result.description);
    pairdatatableResponse(data.result.pairsStatus,'invalidpairdatatable');
    $('#rejectrequestNumberSpan').html($("#contactNumber").attr("requestID"));
    $('#rejectedMsgModal').show();

    }
    else if(data.result.response == 'Otp'){
    if(otpTry <=3){   errorModal(data.result.description); }
    otpTry++;
    }
    else {

    $('#pairDeviceOTPForm,#otpLimitExceedModal').hide();
    $('#acceptedMsgModal').show();
    //$('#successfullMsg').html(data.result.description);
    $('#requestNumberSpan').html($("#contactNumber").attr("requestID"));
    pairdatatableResponse(data.result.pairsStatus,'validpairdatatable');
    $('#otpFormRequest').trigger('reset');
    }

    }




    if(mav=='repair'){
    if( data.result.response == 'Pair-Invalid'){
    $('#repairDeviceOTPForm,#otpLimitExceedModal').hide();
    $('#rejectModalMsg').html(data.result.description);
    $('#rejectedMsgModal').show();
    }
    else if(data.result.response == 'Otp'){
    if(otpTry <=3){   errorModal(data.result.description); }

    otpTry++;
    }
    else {
    $('#repairDeviceOTPForm,#otpLimitExceedModal').hide();
    $('#acceptedMsgModal').show();
    $('#successfullMsg').html(data.result.description);
    $('#otpFormRequest').trigger('reset');
    }
    }




    else if(mav ==='checkpairstatus'){
    if(data.result.response == 'Otp'){
    if(otpTry <=3){   errorModal(data.result.description); }
    otpTry++;
    }
    else if(data.result.response == 'Pair-Invalid'){
    $('#OTPForm,#otpLimitExceedModal').hide();
    $('#rejectModalMsg').html(data.result.description);
    $('#rejectedMsgModal').show();
    //errorModal(data.result.description);
    }
    else{
    $('#OTPForm,#otpLimitExceedModal').hide();
    $('#otpFormRequest,#repairDeviceForm').trigger('reset');
    datatableResponse(data.result.pairs);
    }
    }



    },
    error: function (jqXHR, textStatus, errorThrown) {
    return false;
    }
    });
    return false;
    }

    function countdown() {
    if (timeLeft == -1) {
    clearTimeout(timerId);
    doSomething();
    } else {
    elem.innerHTML = timeLeft;
    timeLeft--;
    }
    }


    function doSomething() {
   document.getElementById("resendOTPclick").style.pointerEvents = "";
    $('#resendOTPclick').css('color', 'blue');
    $('#resendOTPclick').css('cursor', 'pointer');
    }


    function validateOTPForm(form,event){
    const field1=form.field1.value;
    const field2=form.field2.value;
    const field3=form.field3.value;
    const field4=form.field4.value;
    const field5=form.field5.value;
    const field6=form.field6.value;

    if(field1=='' || field2=='' || field3=='' || field4==''|| field5=='' || field6==''){
    return false;
    }

    return true;
    }

