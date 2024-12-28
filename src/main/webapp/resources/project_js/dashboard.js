   $('#langlist').on('change', function() {
    var lang = $('#langlist').val();
   // sessionStorage.setItem("sessionLang", lang);
    $('#mainArea').attr('src', function() {
    //currentPageLocation = $(this).contents().get(0).location;
    //var feature = $(this).contents().find("body").attr('data-id');
    //sessionStorage.setItem("data-feature", feature);
    changeLanguage(lang);
   // sessionStorage.setItem("currentPageLocation", currentPageLocation);
    });
   window.location.replace("?lang=" + lang);
    });

    $(document)
    .ready(
    function() {
   var urlController= $('ul#sidebarUlID li:nth-child(1) a').attr('href');
    $('ul#sidebarUlID').find('li a[href="' + urlController + '"]').closest('li').addClass("active");
     $('#mainArea').attr('src', urlController);
    var url = new URL(window.location.href);
    var langParameter = url.searchParams.get("lang") == 'km' ? 'km' : 'en';
//    saveIPLog();
    window.parent.$('#langlist').val(langParameter);
/*
    sessionStorage.removeItem("currentPageLocation");
    sessionStorage.removeItem("data-feature");
*/

    });




    function downloadUserGuide(){
    let URI = "./Consignment/ManualFileDownload";

            var protocol = window.location.protocol;
            var domain = window.location.hostname;
            var port = window.location.port;
            window.urlWithProtocol = port == '' ? protocol + "//" + domain : protocol + "//" + domain +":" + port;
            completeDomainName = port == '' ? protocol + "//" + domain : protocol + "//" + domain +":" + port;


  var sampleFileRequest = {
    "userTypeId": parseInt($("body").attr("data-userTypeID")),
    "currentContextPath": completeDomainName
    }

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
    url : URI,
  data : JSON.stringify(sampleFileRequest),
     dataType : 'json',
     contentType : 'application/json; charset=utf-8',
     type : 'POST',
    success: function (data, textStatus, jqXHR) {

    fetch(data.url, { method: 'HEAD' })
    .then(response => {
    if (response.ok) {
 //    let iframe = document.getElementById('mainArea'); iframe.src=data.url;
var link = document.createElement('a');
            link.href = data.url;
            link.download = '';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
    } else {
    alertify.error('Oops! The file you are looking for seems to be missing');

    }
    })
    .catch(() => {
    alertify.error('Oops! Something went wrong on our end.We are working to fix it as quickly as possible');
    setTimeout(function() {
    $('#InvalidExtension').hide();
    }, 3000);
    });
    }
    });
    }

    function changeLanguage(lang) {

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers : {
    'X-CSRF-TOKEN' : token
    }
    });
    $.ajax({
    type : 'POST',
    url : './changeLanguage/' + lang,
    contentType : "application/json",
    dataType : 'html',
    success : function(data) {
    },
    error : function(xhr, ajaxOptions, thrownError) {
    }
    });
    }

 /*   function saveIPLog() {
    var obj = {
    username : $("body").attr("data-selected-username"),
    password : "",
    captcha : ""
    }

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    if(sessionStorage.getItem("isSessionActive") == "Y"){
    $.ajaxSetup({
    headers : {
    'X-CSRF-TOKEN' : token
    }
    });

    $.ajax({
    type : 'POST',
    url : contextpath + '/ipLogInfo',
    contentType : "application/json",
    data : JSON.stringify(obj),
    success : function(data) {
    // console.log("successfully saved");

    },
    error : function(xhr, ajaxOptions, thrownError) {

    }
    });
    }

    sessionStorage.removeItem("isSessionActive");
    }*/


/*alertify position*/
alertify.set('notifier','position', 'top-right');
