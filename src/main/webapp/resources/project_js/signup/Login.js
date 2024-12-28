    function forgotPassword(){
    $("#forgotPasswordBtn").prop('disabled', true);
    var obj="";
    //var username=document.getElementById("username").value;
    $("#forgotPassword").each(function(key, val){
    val = $(this);
    if(val.html() !== "") {
    obj =
    {
    username:val.find('#username').val(),
    questionId:val.find('#questionId').val(),
    answer: val.find('#answer').val()
    }
    }
    });
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    type : 'POST',
    url : contextpath + '/forgotPasswordRequest',
    contentType : "application/json",
    dataType : 'html',
    data : JSON.stringify(obj),
    success : function(data) {
    var resp=JSON.parse(data);
    $("#otpVerification #userid").val(resp.userId);
    //		$('#content').addClass('lean-overlay');
    $("#otpMsg").text($.i18n(resp.tag));
    if(resp.statusCode=='200'){
    $('#otpMsgModal').openModal({
    dismissible : false
    });
    }
    else{
    $.i18n().locale = $('#langlist').val();
    $.i18n().load( {
    'en': './resources/i18n/en.json',
    'km': './resources/i18n/km.json'
    }).done( function() {
    $("#forgotPassword #errorMsg").text($.i18n(resp.tag));
    });

    }
    $("#forgotPasswordBtn").prop('disabled', false);
    },
    error: function (xhr, ajaxOptions, thrownError) {
    $("#forgotPasswordBtn").prop('disabled', false);
    }
    });
    return false;
    }
    function udapteNewPassword(){
    $("#UpdatePassBtn").prop('disabled', true);
    var obj="";
    $("#changePassword").each(function(key, val){
    val = $(this);
    if(val.html() !== "") {
    obj =
    {
    username:val.find('#usernamedata').val(),
    password:val.find('#password').val(),
    confirmPassword: val.find('#confirm_password').val()
    }
    }
    });
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    type : 'POST',
    url : contextpath + '/updateNewPassword',
    contentType : "application/json",
    dataType :'html',
    data : JSON.stringify(obj),
    success : function(data) {
    var resp=JSON.parse(data);
    if(resp.statusCode=='200'){
    $.i18n().locale = $('#langlist').val();
    $.i18n().load( {
    'en': './resources/i18n/en.json',
    'km': './resources/i18n/km.json'
    }).done( function() {
    $("#responseMsg").text($.i18n(resp.tag));
    });


    $("#submitBtnAction").openModal({
    dismissible:false
    });
    }
    else{
    $.i18n().locale = $('#langlist').val();
    $.i18n().load( {
    'en': './resources/i18n/en.json',
    'km': './resources/i18n/km.json'
    }).done( function() {
    $("#changePassword #errorMsg").text($.i18n(resp.tag));
    });
    }
    $("#UpdatePassBtn").prop('disabled', false);
    },
    error: function (xhr, ajaxOptions, thrownError) {
    $("#UpdatePassBtn").prop('disabled', false);
    }

    });
    return false;
    }

    function login(){
    //$('div#initialloader').fadeIn('fast');

    var recaptcha=$("#g-recaptcha-response").val();

    if(recaptcha===""){
    $("#errorMsgOnModal").css("display", "block");
    return false;
    }

    var obj="";
    $("#loginForm").each(function(key, val){

    val = $(this);
    if(val.html()!=="") {

    obj =
    {
    username:val.find('#username').val(),
    password:val.find('#password').val(),
    }

    }

    });
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    type : 'POST',
    url : contextpath + '/saveLogin',
    contentType : "application/json",
    dataType : 'html',
    data : JSON.stringify(obj),
    success : function(data) {
    var resp=JSON.parse(data);
    if(resp.statusCode=='200'){
    //	$('div#initialloader').delay(300).fadeOut('slow');
    sessionStorage.setItem("isSessionActive","Y");
    window.location.href="./dashboard";

    }
    else if(resp.statusCode=='401'){

    $("#userId").val(resp.userId);
    $('#changePassword').openModal({
    dismissible:false
    });
    //	$('div#initialloader').delay(300).fadeOut('slow');
    }
    else{
    //	$('div#initialloader').delay(300).fadeOut('slow');
    $.i18n().locale = $('#langlist').val();
    $.i18n().load( {
    'en': './resources/i18n/en.json',
    'km': './resources/i18n/km.json'
    }).done( function() {
    $("#errorMsg").text($.i18n(resp.tag));
    });

    }
    },
    error: function (xhr, ajaxOptions, thrownError) {
    }
    });
    return false;
    }


    function dataByTag(tag,divId,input){
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    type : 'GET',
    url :contextpath+'/dataByTag/'+tag+"/",
    contentType : "application/json",
    dataType : 'html',
    success : function(data) {
    var response=JSON.parse(data);
    if(input==1){
    var asTypeDropdown=$("#"+divId);
    asTypeDropdown.attr('href',response.value+"?lang="+ $('#langlist').val());
    }
    else if(input==2){
    var copyRightSpan=$("#"+divId);
    copyRightSpan.empty();
    copyRightSpan.append(response.value);
    }
    else{}
    },
    error: function (xhr, ajaxOptions, thrownError) {
    }
    });
    }




    function changeExpiryPassword(){
    $("#changePassBtn").prop('disabled', true);
    var obj="";
    $("#changePassword").each(function(key, val){
    val = $(this);
    if(val.html() !== "") {
    obj =
    {
    oldPassword:val.find('#oldPassword').val(),
    password:val.find('#password2').val(),
    confirmPassword: val.find('#confirm_password').val(),
    userid:val.find("#userId").val()
    }
    }
    });
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    type : 'POST',
    url : contextpath + '/changeExpirePassword',
    data : JSON.stringify(obj),
    contentType : "application/json",
    dataType : 'html',
    success : function(data) {
    var resp=JSON.parse(data);
    if(resp.statusCode=='200'){
    $("#changePasswordMessage #cPassSucessMsg").text(resp.response);
    $("#changePasswordMessage").openModal({
    dismissible:false
    });

    }
    else{
    $("#changePassword #errorMsg").text(resp.response);
    }
    $("#changePassBtn").prop('disabled', false);
    },
    error: function (xhr, ajaxOptions, thrownError) {
    $("#changePassBtn").prop('disabled', false);
    }

    });
    return false;
    }


