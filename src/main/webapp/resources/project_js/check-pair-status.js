        var IMEI;

        let formSubmit = (event)=> {

        const form=document.getElementById("checkPairStatusForm");
        if(!validateForm(form,event)){return;}
        event.preventDefault();
        /*   $('#langlist').val(data_lang_param);*/

        var recaptcha=$("#checkPairStatusForm #g-recaptcha-response").val();
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


        var imei = $('#imei').val();
        var msisdn = $('#phoneNumber1').val();
        var contactNumber = $('#contactNumber').val();
        var emailId = $('#emailAddress').val();

        let isValidMsisdn = false;
        if(msisdn!=''){
        isCheckPass(msisdn, function(result) {
        if(result==false){
        errorModal("invalid_phone_number",msisdn);
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


        let isValidContactNumber = false;
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
        }

        var jsonData = {
        imei: imei,
        msisdn: msisdn,
        contactNumber: contactNumber,
        language: $('#langList').val(),
        emailId: emailId || null
        };

        // Send AJAX request
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajaxSetup({
        headers:
        { 'X-CSRF-TOKEN': token }
        });
        $.ajax({
        url: './pair-device/status',
        type: 'POST',
        contentType: 'application/json',
        async: false,
        beforeSend: function() {
        $('#cpsSubmitBtn').prop('disabled',true);
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
        $('#otpFormRequest').trigger('reset');
        $('#checkPairStatusFormDiv').hide();
        $('#errorDiv,#phoneNumberOTP,#emailMasking,#countryCode').html('');
        $('#OTPForm').show();
$("#contactNumber").attr({requestID: data.result.requestId});
  /*      let cc = $('#contactNumber').val().charAt(0) === '0' ? '0' : '+855';
        var mobile= cc == '0' ? $('#contactNumber').val().substring(1).replace(/\d(?=\d{4})/g, "x"): contactNumber.substring(3).replace(/\d(?=\d{4})/g, "x");

        $('#phoneNumberOTP').append(mobile);
        $('#countryCode').append(cc);
        $('#emailMasking').append(emailId.replace(/\d(?=\d{4})/g, "x"));*/
        countDownFunction();
        document.getElementById("resendOTPclick").style.pointerEvents = "none";
        $('#resendOTPclick').css('color', 'black');
        countDownFunction();
        }
        else{
        errorModal(data.errorInfo.errorMessage);
        }
        },
        error: function(xhr, status, error) {

        }
        });
        $('#cpsSubmitBtn').removeProp('disabled');
        return false;
        };



        function validateForm(form,event){
        const field1=$('#imei').val();
        const field2=$('#phoneNumber1').val();
        const field3=$('#contactNumber').val();
        const field4=$('#emailAddress').val();
        if(field1=='' && field2==''){
        errorModal("fill_imei_phone_field");
        event.preventDefault(); return false;
        }
        if(field3=='' && field4==''){
        errorModal("contact_email_field");
        event.preventDefault();return false;
        }
        return true;
        }



        let datatableResponse =(data)=>{
        $('#dataTable').DataTable({
        "data": data,
        "columns": [
        { "data": null },
        { "data": "actualImei" },
        { "data": "msisdn" }
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
        $('#cps-datatable').show();

        };



        let back =()=>{
        $('#checkPairStatusFormDiv').show();
        $('#OTPForm').hide();
        grecaptcha.reset();
        $("#resendOTPclick,#resendOTPclick_time").css("display", "block");
        }







