    //datepicker ID's to select date range
    $( "#expectedDispatcheDateEdit,#expectedArrivaldateEdit" ).datepicker({
    dateFormat: "yy-mm-dd"
    });

    //error message DIV's
    $('#consignmentTableDIv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#registrationTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#greivanceTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#FieldTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#updateModal div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#typeAprroveTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#stolenRecoveryFormDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#operatorTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#deviceActivationTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#userManageTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    //$('#auditTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#auditTableDiv div:last').after("<p id='errorMsg' style='color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 97px;' class='left'></p>")
    $('#userManageLibraryTable div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#CurrencyTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#PortTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#userManagementTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#userFeatureTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#userTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#dbTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#alertTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#ipLogTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')
    $('#pendingTacTableDiv div:last').after('<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>')


    function checkDate(startDate,endDate) {

    var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
    $.i18n().locale = lang;
    $.i18n().load( {
    'en': '../resources/i18n/en.json',
    'km': '../resources/i18n/km.json',
    'en': './resources/i18n/en.json',
    'km': './resources/i18n/km.json'
    } ).done( function() {
    });

    var input1 = startDate.value;
    var input2 = endDate.value;

    var currentTime = new Date()
    var month = ("0" + (currentTime.getMonth() + 1)).slice(-2)
    var day = ("0" + (currentTime.getDate())).slice(-2)
    var year = currentTime.getFullYear();
    var input3=year+"-"+month+"-"+day;

    $('#errorMsgOnModal').text('');

    var searchParams = new URLSearchParams(window.location.search);
    //alert(window.location.href+"-----------"+searchParams)

    if (input1 > input3 || input2 > input3) {
    $('#errorMsg').text($.i18n('currentDateError'));
    }
    else{
    $('#errorMsg').text('');
    }


    if(input1 > input3){
    $('#'+startDate.id).val('');
    }
    if(input2 > input3){
    $('#'+endDate.id).val('');
    }


    if(input1 > input2 && !input2==''){
    $('#errorMsg').text($.i18n('endDate'));
    $('#'+startDate.id).val('');
    }
    }





    // for modal
    function checkDateOnModal(startDate,endDate) {
    var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';


    $.i18n().locale = lang;
    $.i18n().load( {
    'en': '../resources/i18n/en.json',
    'km': '../resources/i18n/km.json',
    'en': './resources/i18n/en.json',
    'km': './resources/i18n/km.json'
    } ).done( function() {

    });
    var input_start = myStringToDate(startDate.value);
    var input_end = myStringToDate(endDate.value);
    $('#errorMsgOnModal').text('');
    if (input_end.getTime() == input_start.getTime()) {
    $('#errorMsgOnModal').text('');
    $('#'+endDate.id).css('border-color', '');


    }
    else if(input_end.getTime() < input_start.getTime()){
    $('#'+endDate.id).css('border-color', 'red');
    $('#errorMsgOnModal').text($.i18n(endDate.id));
    $(':input[type="submit"]').addClass( "eventNone" );

    }
    else{
    $('#errorMsgOnModal').text('');
    $('#'+endDate.id).css('border-color', '');
    $(':input[type="submit"]').removeClass( "eventNone" );
    }

    }




    function checkLaunchDate(launchDate) {
    var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
    $.i18n().locale = lang;
    $.i18n().load( {
    'en': '../resources/i18n/en.json',
    'km': '../resources/i18n/km.json',
    'km': '../resources/i18n/km.json',
    'en': '../resources/i18n/en.json'
    } ).done( function() {


    var input1 = launchDate.value;

    var currentTime = new Date();
    var month = ("0" + (currentTime.getMonth() + 1)).slice(-2);
    var day = ("0" + (currentTime.getDate())).slice(-2);
    var year = currentTime.getFullYear();
    var input3=year+"-"+month+"-"+day;
    if((input1 > input3)){
    $('#'+launchDate.id).css('border-color', 'red');
    $('#'+launchDate.id).val('');
    $('#errorMsg').text($.i18n('launchDateError'));
    }
    else{
    $('#errorMsg').text('');
    $('#'+launchDate.id).css('border-color', '');
    }
    });

    }


    function checkUploadedDate(viewstartDate) {
    var input1 = viewstartDate.value;

    var currentTime = new Date();
    var month = ("0" + (currentTime.getMonth() + 1)).slice(-2);
    var day = ("0" + (currentTime.getDate())).slice(-2);
    var year = currentTime.getFullYear();
    var input3=year+"-"+month+"-"+day;
    if((input1 > input3)){
    $('#'+viewstartDate.id).css('border-color', 'red');
    $('#'+viewstartDate.id).val('');
    $('#errorMsghistoryDiv,#errorMsgDiv').text('Uploaded Date should not be greater than today Date');
    }
    else{
    $('#errorMsghistoryDiv,#errorMsgDiv').text('');
    $('#'+viewstartDate.id).css('border-color', '');
    }

    }
    function checkStolenDate(creationDate,updatedDate) {

        //var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
        $.i18n().locale = 'en';
        $.i18n().load( {
        'en': '../resources/i18n/en.json',
        'km': '../resources/i18n/km.json',
        'en': './resources/i18n/en.json',
        'km': './resources/i18n/km.json'
        } ).done( function() {
        });

        var input1 = creationDate.value;
        var input2 = updatedDate.value;

        var currentTime = new Date()
        var month = ("0" + (currentTime.getMonth() + 1)).slice(-2)
        var day = ("0" + (currentTime.getDate())).slice(-2)
        var year = currentTime.getFullYear();
        var input3=year+"-"+month+"-"+day;

        $('#errorMsgOnModal').text('');

        var searchParams = new URLSearchParams(window.location.search);

        if (input1 > input3 || input2 > input3) {
        $('#errorMsghistoryDiv,#errorMsgDiv').text('Creation Date or Updated Date should not be greater than today Date');
        }
        else{
        $('#errorMsghistoryDiv,#errorMsgDiv').text('');
        }

        if(input1 > input3){
        $('#'+creationDate.id).val('');
        }
        if(input2 > input3){
        $('#'+updatedDate.id).val('');
        }


        if(input1 > input2 && !input2==''){
        $('#errorMsghistoryDiv,#errorMsgDiv').text('Creation Date should be less than or equal to Updated Date');
        $('#'+creationDate.id).val('');
        }
        }


    function validDate(viewstartDate,viewEndDate) {

    //var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
    $.i18n().locale = 'en';
    $.i18n().load( {
    'en': '../resources/i18n/en.json',
    'km': '../resources/i18n/km.json',
    'en': './resources/i18n/en.json',
    'km': './resources/i18n/km.json'
    } ).done( function() {
    });

    var input1 = viewstartDate.value;
    var input2 = viewEndDate.value;

    var currentTime = new Date()
    var month = ("0" + (currentTime.getMonth() + 1)).slice(-2)
    var day = ("0" + (currentTime.getDate())).slice(-2)
    var year = currentTime.getFullYear();
    var input3=year+"-"+month+"-"+day;

    $('#errorMsgOnModal').text('');

    var searchParams = new URLSearchParams(window.location.search);

    if (input1 > input3 || input2 > input3) {
    $('#errorMsghistoryDiv,#errorMsgDiv').text('Approved End Date or Approved Start Date should not be greater than today Date');
    }
    else{
    $('#errorMsghistoryDiv,#errorMsgDiv').text('');
    }

    if(input1 > input3){
    $('#'+viewstartDate.id).val('');
    }
    if(input2 > input3){
    $('#'+viewEndDate.id).val('');
    }


    if(input1 > input2 && !input2==''){
    $('#errorMsghistoryDiv,#errorMsgDiv').text('Approved Start Date should be less than or equal to Approved End Date');
    $('#'+viewstartDate.id).val('');
    }
    }

    $(document).ready(function() {
    var protocol = window.location.protocol;
    var domain = window.location.hostname;
    var port = window.location.port;
    window.urlWithProtocol = port == '' ? protocol + "//" + domain : protocol + "//" + domain +":" + port;
    completeDomainName = port == '' ? protocol + "//" + domain : protocol + "//" + domain +":" + port;
    });


    /*sampleFileDownloadById*/
    function sampleFileDownloadById(id,tag){
    var sampeFileRequest = {
    "featureId": parseInt(id),
    "currentContextPath": completeDomainName,
    "type":tag
    }
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    url : "./Consignment/sampleFileDownloads",
    data : JSON.stringify(sampeFileRequest),
    dataType : 'json',
    async: false,
    contentType : 'application/json; charset=utf-8',
    type : 'POST',
    success: function (data, textStatus, jqXHR) {

    fetch(data.url, { method: 'HEAD' })
                        .then(response => {
                            if (response.ok) {
                              var fileExtension = data.url.split('.').pop();
                              if (fileExtension === "txt") {
                          $("#sampleFileDownloadId"+id).attr({href : data.url});
                          $("#sampleFileDownloadId"+id).attr({download : data.url.split('/').pop()});
                          $("#sampleFileDownloadId"+id).removeAttr("onclick");
                          $("#sampleFileDownloadId" + id)[0].click();
                           return;
                              }
                          else{
                              window.location.href = data.url;
                          }

                            } else {
                                window.parent.alertify.error('Oops! The sample file you are looking for seems to be missing');

                            }
                        })
                        .catch(() => {
                         window.parent.alertify.error('Oops! Something went wrong on our end.We are working to fix it as quickly as possible');

                        });
    }
    });
    }


    function finalURL(dataURL){
    if(dataURL ==null || dataURL == "" || dataURL ==undefined){
    }
    else{
    var urlInRespone=dataURL;
    var parts = urlInRespone.split('/');
    var extractedValue = parts.slice(0, 3).join('/');
    var finalPath = urlInRespone.replace(extractedValue, window.urlWithProtocol);
    return window.location.href = finalPath;

    }
    }



    //Duplicate Date detection function
    function checkDetactionDate(filterDetectionDate) {
    var input1 = filterDetectionDate.value;

    var currentTime = new Date();
    var month = ("0" + (currentTime.getMonth() + 1)).slice(-2);
    var day = ("0" + (currentTime.getDate())).slice(-2);
    var year = currentTime.getFullYear();
    var input3=year+"-"+month+"-"+day;
    if((input1 > input3)){
    $('#'+filterDetectionDate.id).css('border-color', 'red');
    $('#'+filterDetectionDate.id).val('');
    $('#errorMsgDiv').text('Uploaded Date should not be greater than today Date');
    }
    else{
    $('#errorMsgDiv').text('');
    $('#'+filterDetectionDate.id).css('border-color', '');
    }

    }

function checkCurrentDate(expiry) {
    var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
    $.i18n().locale = lang;
    $.i18n().load({
    'en': '../resources/i18n/en.json',
    'km': '../resources/i18n/km.json',
    'km': '../resources/i18n/km.json',
    'en': '../resources/i18n/en.json'
    }).done( function() {


    var input1 = expiry.value;

    var currentTime = new Date();
    var month = ("0" + (currentTime.getMonth() + 1)).slice(-2);
    var day = ("0" + (currentTime.getDate())).slice(-2);
    var year = currentTime.getFullYear();
    var input3=year+"-"+month+"-"+day;
    if((input1 > input3)){
    $('#'+expiry.id).css('border-color', 'red');
    $('#'+expiry.id).val('');
    $('#errorMsgDiv').text($.i18n('expiryDateError'));

    }
    else{
    $('#errorMsgDiv').text('');
    $('#'+expiry.id).css('border-color', '');
    }
    });
    }

