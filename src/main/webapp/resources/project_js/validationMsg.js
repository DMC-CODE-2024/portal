
        $(document).ready(function() {
        var lang=$("body").attr("data-lang-param") == 'km' ? 'km' : 'en';
        $.i18n().locale = lang;
        $.i18n().load( {
        'en': '../resources/i18n/en.json',
        'km': '../resources/i18n/km.json',
        'en': './resources/i18n/en.json',
        'km': './resources/i18n/km.json'
        } ).done( function() {
        });
        });

        $(function(){
        $('*').tooltip({ track: true });
        $('*[title]').tooltip('disable');
        });



        function InvalidMsg(textbox,type,msg) {
        var element = document.getElementById(textbox.id);
        if(element.validity.valueMissing){
        if(type=="input" ){
        element.setCustomValidity($.i18n('requiredMsg_input'));
        }
        else if(type=="date"){
        element.setCustomValidity($.i18n('requiredMsg_date'));
        }
        else if(type=="select"){
        element.setCustomValidity($.i18n('requiredMsg_select'));
        }
        else if(type=="fileType"){
        element.setCustomValidity($.i18n('requiredMsg_fileType'));
        }
        else if(type=="email"){
        element.setCustomValidity($.i18n('requiredMsg_email'));
        }
        else if(type=="checkbox" && $('#'+textbox.id).is(":checked")== false){
        element.setCustomValidity($.i18n('requiredMsg_checkbox'));
        }
        }

        else if (element.validity.patternMismatch) {

        if(type=="input" || type=="date" || type=="select" || type=="fileType" || type=="email"){
        element.setCustomValidity(msg);
        }

        else if(type=="checkbox" && $('#'+textbox.id).is(":checked")== true){
        element.setCustomValidity('');
        }

        return false;
        }
        else{

        if(type=="input" || type=="date" || type=="select" || type=="fileType" || type=="email" || (type=="checkbox" && $('#'+textbox.id).is(":checked")== true)){
        element.setCustomValidity('');
        }

        return true;

        }
        }

        function errorModalForInvalidExtension(message){
        var modalHtml = `
        <div class="modal fade modalBackdrop hidden" id="InvalidExtension" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true" style="display:none">
        <div class="modal-dialog modal-sm transform-10" id="1233189" role="document">
        <div class="modal-content">
        <div class="modal-body">
        </button>
        <p class="Rejected" id="invalidmsg"></p>
        </div>
        </div>
        </div>
        </div>
        `;

        $("body").append(modalHtml);
        $('#invalidmsg').html(message);
        $('#InvalidExtension').show();
        }


        function validateFile(input,type) {
        var filePath = input.value;
        var fileExtension = filePath.split('.').pop().toLowerCase();
        if (type=='CSV_ALLOWED' && fileExtension !== 'csv') {
        window.parent.alertify.error('File should have extension as csv');
        input.value = '';
        return false;
        }

        if (type=='TXT_ALLOWED' && fileExtension !== 'txt'  ) {
        input.value = '';
         window.parent.alertify.error('File should have extension as txt');
        return false;
        }
        }








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




