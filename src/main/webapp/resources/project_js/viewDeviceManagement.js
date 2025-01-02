//var featureId = 55;
var featureId = $("body").attr("data-featureId");
var cierRoletype = sessionStorage.getItem("cierRoletype");
var userType = $("body").attr("data-roleType");
var lang = window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
var tac;
var elem;
//$.i18n().locale = lang;

lang='en';

var startdate = $('#startDate').val();
var endDate = $('#endDate').val();
var documenttype, selectfile, selectDocumentType;

/*$.i18n().load({
  'en': './resources/i18n/en.json',
  'km': './resources/i18n/km.json'
}).done(function() {
  selectfile = $.i18n('selectfile');
});*/

var userId = parseInt($("body").attr("data-userID"));
$(document).ready(function() {
  $('div#initialloader').fadeIn('fast');
  pageRendering(null, null);
  setAllDropdown();
  DeviceDataTable(lang, null, null, null);
  //console.log("tomcat path--" +$("body").attr("data-tomcat-path"));
});

function DeviceDataTable(lang, source, action, deviceId) {
  var source__val;
  if (source == 'filter') {
    source__val = source;
  } else {
    source__val = $("body").attr("data-session-source");
  }
  //alert ("1 with action" +action+" and deviceId--" +deviceId);
  if (action == 'viewHistory') {
    //alert ("2 with action" +action+" and deviceId--" +deviceId);
    viewHistoryDatatable('headers?type=deviceHistoryHeaders&lang=' + lang, 'getDeviceHistory?requestType=viewHistory&source=menu', deviceId);
  } else if (action == 'multiedit' && $('#multiEditButton').is(':checked') == true) {
    //alert ("3 with action" +action);
    DataTable('headers?type=deviceManagementHeaders&lang=' + lang + '&requestType=multiedit', 'deviceManagementData?source=' + source__val + '&requestType=multiedit');
  } else {
    DataTable('headers?type=deviceManagementHeaders&lang=' + lang, 'deviceManagementData?source=' + source__val);
  }

};

function multiEditOnChanged(checkbox) {
      console.log("multiedit called " +checkbox);
      if (checkbox.checked) {
        //name=ferret&color=purple
        console.log("multiedit cheked");
        DataTable('headers?type=deviceManagementHeaders&lang=' + lang + '&requestType=multiedit', 'deviceManagementData?source=menu&requestType=multiedit');
        $("#editDeviceBtn").css("display", "block");
        $("#addDeviceBtn").css("display", "none");
      } else {
        console.log("multiedit uncheked");
        DataTable('headers?type=deviceManagementHeaders&lang=' + lang, 'deviceManagementData?source=menu');
        $("#editDeviceBtn").css("display", "none");
        $("#addDeviceBtn").css("display", "block");
      }

};


var multiEditCount = 0;
//**************************************************Device Management table**********************************************
function DataTable(Url, dataUrl) {
  $('div#initialloader').fadeIn('fast');
  var filterRequest = {
    "startDate": $('#startDate').val(),
    "endDate": $('#endDate').val(),
    "deviceId": $('#filterTac').val(),
    "deviceType": $('#filterDeviceType').val(),
    "marketingName": $('#filterMarketingName').val(),
    "brandName": $('#filterBrandName').val(),
    "modelName": $('#filterModelName').val(),
    "os": $('#filterOs').val(),
    "mdrStatus": $('#filterStatus').val(),
    "featureId": parseInt(featureId),
    "userId": parseInt($("body").attr("data-userID")),
    "userType": $("body").attr("data-roleType"),
    //"userType" : parseInt($("body").attr("data-userTypeID")),
    "userTypeId": parseInt($("body").attr("data-userTypeID"))
  }
  //console.log(JSON.stringify(filterRequest));
  if (lang == 'km') {
    var langFile = './resources/i18n/khmer_datatable.json';
  } else if (lang == 'en') {
    var langFile = './resources/i18n/english_datatable.json';
  }
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: Url,
    type: 'POST',
    dataType: "json",
    success: function(result) {
      var table = $("#LibraryTable").DataTable({
        destroy: true,
        "serverSide": true,
        orderCellsTop: true,
        "ordering": true,
        "bPaginate": true,
        "bFilter": false,
        "bInfo": true,
        "bSearchable": true,
        "language": {
                                          "sEmptyTable": "No records found in the system",
                                          "infoFiltered": ""
                              },
        "aaSorting": [],
        columnDefs: [{
          orderable: false,
          targets: -1,
          "width": "87px",
        }],
        initComplete: function() {
          $('.dataTables_filter input').off().on('keyup', function(event) {
            if (event.keyCode === 13) {
              table.search(this.value.trim(), false, false).draw();
            }
          });
        },
        ajax: {
          url: dataUrl,
          type: 'POST',
          dataType: "json",
          data: function(d) {
            d.filter = JSON.stringify(filterRequest);
          },
          error: function(jqXHR, textStatus, errorThrown, data) {
           // window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
            // messageWindow(jqXHR['responseJSON']['message']);
            //window.parent.$('#500ErrorModal').openModal({
              ///dismissible: false
            //});
          }
        },
        "columns": result,
        drawCallback: function(settings) {
                          $('div#initialloader').delay(300).fadeOut('slow');
             }
      });
      
      //$('div#initialloader').delay(1000).fadeOut('slow');
      //$('div#initialloader').delay(300).fadeOut('slow');
      $('#LibraryTable tbody').on('click', 'tr', function() {
        var rawCheckboxId = $(this).closest('tr').find("input[type=checkbox]").attr('id');
        //alert("rawCheckboxId is "+rawCheckboxId);
        if ($('#' + rawCheckboxId).is(":checked") == true) {
          $("#editDeviceBtn").prop("disabled", false);
          $(this).removeClass('table.dataTable tbody tr');
          $(this).addClass('trselected');
        } else {
          $(this).removeClass('trselected');
          $(this).addClass('table.dataTable tbody tr');
          console.log("length =" + $('#LibraryTable tbody tr input[type=checkbox]:checked').length);
          $('#LibraryTable tbody tr input[type=checkbox]:checked').length != 0 ? $("#editDeviceBtn").prop("disabled", false) : $("#editDeviceBtn").prop("disabled", true);
        }
      });
    },
    error: function(jqXHR, textStatus, errorThrown) {}
  });
  
}

function selectAllCheckbox() {
  var table = $('#LibraryTable').DataTable();
  var data = table.rows().data();
  if ($("#selectAllCheckbox").is(':checked') === true) {
    data.each(function(value, index) {
      //console.log("value-----"+ value+" index------- "+index);
      var tableRow = JSON.stringify(value);
      if (tableRow.includes("checkbox") == true) {
        $('#LibraryTable tbody tr').removeClass('table.dataTable tbody tr');
        $(table.row(index).node()).find("input[type=checkbox]").prop("checked", true);
        $("#editDeviceBtn").prop("disabled", false);
        $(table.row(index).node()).addClass('trselected');
      }
    });
  } else {
    //console.log("MAIN CHECKBOX NOT CHECKED");
    //$('#LibraryTable tbody tr input[type=checkbox]:checked').length!=0 ? $("#editDeviceBtn").prop("disabled", false) : $("#editDeviceBtn").prop("disabled", true);
    $("#editDeviceBtn").prop("disabled", true);
    $('#LibraryTable').find("input[type=checkbox]").prop("checked", false);
    $('#LibraryTable tbody tr').removeClass('trselected');
    $('#LibraryTable tbody tr').addClass('table.dataTable tbody tr');
  };
};
$('#multiEditButton').change(function() {
  if (this.checked) {
    $("#editDeviceBtn").css("display", "block");
    $("#addDeviceBtn").css("display", "none");
    $("#editDeviceBtn").prop("disabled", true);
  } else {
    $("#editDeviceBtn").css("display", "none");
    $("#addDeviceBtn").css("display", "block");
  }
  multiEditCount = 0;
});
//**************************************************Device Management page filter area**********************************************
function pageRendering(requestType, deviceId) {
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  //$('div#initialloader').fadeIn('fast');
  $.ajax({
    url: 'deviceManagement/pageRendering?requestType=' + requestType+'&featureId='+featureId,
    type: 'POST',
    dataType: "json",
    success: function(data) {
      if (requestType !== "viewHistory") {
        //alert("requestType is-" +requestType);
        data.userStatus == "Disable" ? $('#btnLink').addClass("eventNone") : $('#btnLink').removeClass("eventNone");
        elem = data.pageTitle;
        $("#pageHeaderTitle").append(elem);
        var button = data.buttonList;
      if(button!=null){
         for(i=0; i<button.length; i++){
             if (button[i].id === "multiEditButton") {
                            var checkboxHTML = '<h6>' + button[i].buttonTitle + '</h6>' +
                                                       '<label class="switch">' +
                                                       '<input type="checkbox" id=' + button[i].id + ' onclick='+button[i].buttonURL+' >' +
                                                       '<span class="switch-slider"></span>' +
                                                       '</label>';
                                    $("#multiEditDiv").append(checkboxHTML);
                            };

            if (button[i].id === "addDeviceBtn") {
                    $("#multiEditDiv").after('<button type="button" id='+button[i].id+' class="btn btn-outline-dark" onclick='+button[i].buttonURL+'>'+button[i].buttonTitle+' </button>');
                 };
            }
       }


         //$("#pageHeader").append("<button type='button' id='addDeviceBtn' class='btn btn-outline-dark' onclick='addDevices()'> + Add Device</button>");

        $("#pageHeader").append("<button type='button' id='editDeviceBtn' class='btn btn-outline-dark' onclick='viewMultipleEdit()' style='display: none' disabled> Edit Device</button>");
        $("#pageHeader").append("<button type='button' id='backBtn' class='btn btn-outline-dark' onclick='backButton()' style='display: none'>Back</button>");
        //var startdate=$('#startDate').val(); 
        //var endDate=$('#endDate').val();	
        var date = data.inputTypeDateList;
        for (i = 0; i < date.length; i++) {
          if (date[i].type === "date") {
            $("#dataTableDiv").append("<div class='form-group'>" + "<label for=" + date[i].id + ">" + date[i].title + "</label>" + "<input class='form-control datepicker text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id=" + date[i].id + " autocomplete='off'>");
          } else if (date[i].type === "text") {
            $("#dataTableDiv").append("<div class='form-group'><label for=" + date[i].id + " class='center-align'>" + date[i].title + "</label><input type=" + date[i].type + " class='form-control' id=" + date[i].id + " placeholder='Enter Here' maxlength='19'/></div>");
            //<div class="form-group"><label for="transactionID">TransactionID</label><input type="text" class="form-control" id="transactionID" maxlength="19"></div>
          }else if (date[i].type === "select") {
            $("#dataTableDiv").append("<div class='form-group'>" +
            "<label for=" + date[i].id + ">" + date[i].title + "</label>" + "<select id=" + date[i].id + "  class='form-control'>" + "<option value='-1' selected>Select</option>" + "</select>" + "</div>" + "</div>");
          }
        }
        // dynamic dropdown portion
        var dropdown = data.dropdownList;
        for (i = 0; i < dropdown.length; i++) {
          var dropdownDiv = $("#dataTableDiv").append("<div class='form-group'>" +
            //"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
            "<label for=" + dropdown[i].id + ">" + dropdown[i].title + "</label>" + "<select id=" + dropdown[i].id + "  class='form-control'>" + "<option value='-1' selected>Select</option>" + "</select>" + "</div>" + "</div>");
          $('#dataTableDiv div:last').after("<p id='errorMsg' style='color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 180px !important;!i;!;' class='left'></p>")


        }
        var viewFilter = "viewFilter";
        $("#filterButtonDiv").append("<div><button type='button' class='btn btn-outline-dark' id='clearFilter'>Reset All</button></div>");
        $("#filterButtonDiv").append("<div><button type='button' class='btn btn-outline-dark' id='submitFilter'> <span><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></span> Apply Filter </button></div>");
        $("#filterButtonDiv").append("<div><button type='button' class='btn btn-outline-dark' onclick='exportData()'> <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'> Export</button>");
        $('#clearFilter').attr("onclick", "Resetfilter('filterform',null)");
        $('#submitFilter').attr('onclick', "DeviceDataTable('" + lang + "','filter','multiedit')");
        /*for (i = 0; i < button.length; i++) {
                $('#' + button[i].id).text(button[i].buttonTitle);
                if (button[i].type === "HeaderButton") {
                        $('#' + button[i].id).attr("href", button[i].buttonURL);
                } else {
                        $('#' + button[i].id).attr("onclick", button[i].buttonURL);
                }
        }*/
        
      } else {
        //$("#historyFilterform").empty();
        //alert("deviceId is-" +deviceId);
        //alert("requestType is-" +requestType);
        //$("#filterBox2").html("");
        //$("#filterBox2").empty();
        var button = data.buttonList;
        var date = data.inputTypeDateList;
        $("#historydataTableDiv").empty();
        for (i = 0; i < date.length; i++) {
          if (date[i].type === "date") {
            $("#historydataTableDiv").append("<div class='form-group'>" + "<label for=" + date[i].id + ">" + date[i].title + "</label>" + "<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id=" + date[i].id + " autocomplete='off'>");
          } else if (date[i].type === "text") {
            $("#historydataTableDiv").append("<div class='form-group'><label for=" + date[i].id + " class='center-align'>" + date[i].title + "</label><input type=" + date[i].type + " class='form-control' id=" + date[i].id + " placeholder='Enter Here' maxlength='19'/></div>");
            $('#historydataTableDiv div:last').after("<p id='errorMsgHistory' style='color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 97px;' class='left'></p>")
          }else if (date[i].type === "select") {
            $("#historydataTableDiv").append("<div class='form-group'>" +
            "<label for=" + date[i].id + ">" + date[i].title + "</label>" + "<select id=" + date[i].id + "  class='form-control'>" + "<option value='-1' selected> Select</option>" + "</select>" + "</div>" + "</div>");
          }
        }
        
        var dropdown = data.dropdownList;
        for (i = 0; i < dropdown.length; i++) {
          var dropdownDiv = $("#historydataTableDiv").append("<div class='form-group'>" +
            //"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
            "<label for=" + dropdown[i].id + ">" + dropdown[i].title + "</label>" + "<select id=" + dropdown[i].id + "  class='form-control'>" + "<option value='-1' selected> Select</option>" + "</select>" + "</div>" + "</div>");
          //$('#historydataTableDiv div:last').after("<p id='errorMsg' style='color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 97px;' class='left'></p>")
          $('#dataTableDiv div:last').after("<p id='errorMsg' style='color: red;font-size: 15px;position: absolute;left: 23px;margin: 0;top: 180px !important;!i;!;' class='left'></p>")
        }
        
        $("#historyfilterButtonDiv").empty();
        $("#historyfilterButtonDiv").append("<div><button type='button' class='btn btn-outline-dark' id='clearHistoryFilter'>Reset All</button></div>");
        $("#historyfilterButtonDiv").append("<div><button type='button' class='btn btn-outline-dark' id='historyFilter' > <span><img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></span> Apply Filter </button></div>");
        $('#historyFilter').attr('onclick', "DeviceDataTable(null,'filter','viewHistory','" + deviceId + "')");
        //DeviceDataTable(null,null,'viewHistory',null)
        //function DeviceDataTable(lang,source,action,deviceId)
        //onclick='DeviceDataTable(null,'filter','viewHistory',null)'	
        //$('#submitFilter').attr("onclick", "DeviceDataTable()");
        $('#clearHistoryFilter').attr("onclick", "Resetfilter('historyFilterform','" + deviceId + "')");
        $("#filterform").css("display", "none");
        $("#dataTableDiv").css("display", "none");
        $("#multiEditDiv").css("display", "none");
        $("#filterButtonDiv").css("display", "none");
        $("#addDeviceBtn").css("display", "none");
        $("#pageHeaderTitle").text('History');
        $("#historydataTableDiv").show();
        $("#historyfilterButtonDiv").show();
        $("#backBtn").css("display", "block");
      }
     // setAllDropdown();
    }
  });
  //$('div#initialloader').delay(300).fadeOut('slow');
};

function addDevices() {
  $("#datatableViewDiv").css("display", "none");
  $("#addMobileDetailDiv").css("display", "block");
 }

function viewMultipleEdit() {
  var multipleDeviceId = new Array();
  var tableIds = new Array();
  $("input[name='selector']:checked").each(function() {
    multipleDeviceId.push($(this).val());
    multiEditCount += 1;
  });
  //console.log("selected Id's' are: " + multipleDeviceId);
  viewDetails(multipleDeviceId, 'Multiedit');
}

function setAllDropdown() {
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.getJSON('./getDropdownList/0/0' , function(data) {
	/*$('#filterStatus, #historyFilterStatus').empty();
	$('<option>').val('-1').text('Select').appendTo('#filterStatus,#historyFilterStatus');*/
	//if(!$('#filterStatus > option').length==5){
		for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].state).text(data[i].interpretation).appendTo('#filterStatus,#historyFilterStatus');
    //}
	}
    
  });
  $.getJSON('./getDropdownList/MULTI_SIM_STATUS', function(data) {
	//$('#editSimSlots,#editnumberofIMEI,#addSimSlots,#addnumberofIMEI,#viewHistorySimSlots,#viewHistorynumberofIMEI').empty();
	//$('<option>').val('').text('Select').appendTo('#editSimSlots,#editnumberofIMEI,#addSimSlots,#addnumberofIMEI,#viewHistorySimSlots,#viewHistorynumberofIMEI');
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editSimSlots,#editnumberofIMEI,#addSimSlots,#addnumberofIMEI,#viewHistorySimSlots,#viewHistorynumberofIMEI');
    }
  });
  $.getJSON('./getDropdownList/MDR_DEVICE_STATUS', function(data) {
	//$('#addDeviceStatus,#viewDevicestatus,#copyViewdevicestatus,#editDeviceStatus,#viewHistoryDevicestatus').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#addDeviceStatus,#viewDevicestatus,#copyViewdevicestatus,#editDeviceStatus,#viewHistoryDevicestatus');
    }
  });
  $.getJSON('./getDropdownList/SELFIE_CAMERA_TYPE', function(data) {
	//$().empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editSelfieCameratype,#addSelfieCameratype,#viewSelfieCameratype,#viewHistorySelfieCameratype');
    }
  });
  $.getJSON('./getDropdownList/MAIN_CAMERA_TYPE', function(data) {
	//$('#editTriple,#addTriple,#viewTriple,#viewHistoryTriple').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editTriple,#addTriple,#viewTriple,#viewHistoryTriple');
    }
  });
  $.getJSON('./getDropdownList/COMMS_RADIO', function(data) {
	//$('#editRadioSupport,#addRadioSupport,#viewRadioSupport,#viewHistoryRadioSupport').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editRadioSupport,#addRadioSupport,#viewRadioSupport,#viewHistoryRadioSupport');
    }
  });
  $.getJSON('./getDropdownList/COMMS_NFC', function(data) {
	//$('#editNFCSupport,#addNFCSupport,#viewNFCSupport,#viewHistoryNFCSupport').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editNFCSupport,#addNFCSupport,#viewNFCSupport,#viewHistoryNFCSupport');
    }
  })
  $.getJSON('./getDropdownList/SOUND_3.5MM_JACK', function(data) {
	//$('#editSoundJack,#addSoundJack,#viewSoundJack,#viewHistorySoundJack').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editSoundJack,#addSoundJack,#viewSoundJack,#viewHistorySoundJack');
    }
  });
  $.getJSON('./getDropdownList/SOUND_LOUDSPEAKER', function(data) {
	//$('#editLoudspeaker,#addLoudspeaker,#viewLoudspeaker,#viewHistoryLoudspeaker').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editLoudspeaker,#addLoudspeaker,#viewLoudspeaker,#viewHistoryLoudspeaker');
    }
  });
  $.getJSON('./getDropdownList/MEMORY_CARD_SLOT', function(data) {
	//$('#editMemoryCardSlot,#addMemoryCardSlot,#viewHistoryMemoryCardSlot').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editMemoryCardSlot,#addMemoryCardSlot,#viewHistoryMemoryCardSlot');
    }
  });
  $.getJSON('./getDropdownList/SOFTSIM_SUPPORT', function(data) {
	//$('#editSoftSimSupport,#addSoftSimSupport,#viewSoftSimSupport,#viewHistorySoftSimSupport').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editSoftSimSupport,#addSoftSimSupport,#viewSoftSimSupport,#viewHistorySoftSimSupport');
    }
  });
  $.getJSON('./getDropdownList/ESIM_SUPPORT', function(data) {
	//$('#editSimSupport,#addSimSupport,#vieweSimSupport,#editHistorySimSupport,#viewHistoryeSimSupport').empty();
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#editSimSupport,#addSimSupport,#vieweSimSupport,#editHistorySimSupport,#viewHistoryeSimSupport');
    }
  });
  $.getJSON('./productList', function(data) {
	$('#copyFromBrandName').empty();
	$('<option>').val('').text('Select').appendTo('#copyFromBrandName');
    for (i = 0; i < data.length; i++) {
      $('<option>').val(data[i].brandName).text(data[i].brandName).appendTo('#copyFromBrandName');
    }
  });
/*  $.getJSON('./addMoreFile/device_supporting_doc_count', function(data) {
    localStorage.setItem("maxCount", data.value);
    console.log("maxcount in API response " +JSON.stringify(data.value));
  });*/
  //$.getJSON('./getAgentName', function(data) {
	//console.log("getAgentName " +JSON.stringify(Data));
    //for (i = 0; i < data.length; i++) {
     // $('<option>').val(data[i].userName).text(data[i].userName).appendTo('#historyFilterAgentName');
    //}
  //});
  $.getJSON('./getDeviceTypeName', function(data) {
	//console.log("getDeviceTypeName " +JSON.stringify(data));
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i]).text(data[i]).appendTo('#filterDeviceType,#addDeviceType,#editDeviceType,#historyfilterDeviceType');
    }
  });
  
   $.getJSON('./getCountryName', function(data) {
	//console.log("getDeviceTypeName " +JSON.stringify(data));
    for (i = 0; i < data.length; i++) {
     $('<option>').val(data[i]).text(data[i]).appendTo('#editManufacturerCountry');
    }
  });
}

function viewDetails(deviceIds, Action) {
  $('div#initialloader').fadeIn('fast');
  var deviceId;
  //console.log("Action Recieved " +Action+" with Device ID " +deviceIds);
  Action == 'Multiedit' ? deviceId = deviceIds[0] : deviceId = deviceIds;
  var RequestData = {
    "deviceId": deviceId,
    "featureId": parseInt(featureId),
    "userId": parseInt($("body").attr("data-userID")),
    "userType": $("body").attr("data-roleType"),
    //"userType" : parseInt($("body").attr("data-userTypeID")),
    "userTypeId": parseInt($("body").attr("data-userTypeID"))
  }
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: 'viewbyDeviceID',
    data: JSON.stringify(RequestData),
    dataType: 'json',
    contentType: 'application/json; charset=utf-8',
    type: 'POST',
    success: function(data) {
      //console.log(data);
      $(".resetImgID").attr("img-id",null);
      $("#mainFrameEdit,#mainFrameEditInput1,#mainFrameEditInput2,#mainFrameEditInput3,#mainFrameEditInput4,#mainFrameEditInput5").val(null);
      if (Action == "View") {
        console.log("in view part with Action recieved " + Action);
        $("#mainFrame,#subFrame0,#subFrame1,#subFrame2,#subFrame3,#subFrame4").attr("src", './resources/assets/images/NoImage.jpg');
        setViewPopupData(data);
        $("#datatableViewDiv").css("display", "none");
        $("#mobileDetailViewDiv").css("display", "block");
      } else if (Action == "viewDetailHistory") {
        setViewPopupData(data);
        $("#datatableViewDiv").css("display", "none");
        $("#mobileDetailViewDiv").css("display", "block");
        //$("#viewdetailedHistoryLabel").css("display", "block");
        //$("#viewModelLabel,#editFromViewBtn").css("display", "none");
      } else if (Action == "copyView") {
        console.log("in copyView part  Action recieved " + Action);
        setcopyViewPopupData(data);
      } else if (Action == "EditfromView") {
        setEditPopupData(data, Action, deviceIds.toString());
        $("#datatableViewDiv").css("display", "none");
        $("#mobileDetailViewDiv").css("display", "none");
        $("#mobileDetailEditDiv").css("display", "block");
        $('#cancelbtn').attr("onclick", "closeEditPage()");
      }else if (Action == "copy") {
		setEditPopupData(data, Action, deviceIds.toString());
        $("#datatableViewDiv").css("display", "none");
        $("#mobileDetailViewDiv").css("display", "none");
        $("#mobileDetailEditDiv").css("display", "block");
        $('#cancelbtn').attr("onclick", "closeEditPage()");
        
         $('#cancelbtn').attr("onclick", "closeBtnfromEdit('" + Action + "')");
         console.log("in copy part  Action recieved " + Action);
        
      } else {
        console.log("in Edit part  Action recievedwith " + Action);
        //$("#mainFrameEdit0,#mainFrameEdit1,#mainFrameEdit2,#mainFrameEdit3,#mainFrameEdit4").attr("src", './resources/assets/images/NoImage.jpg');
        setEditPopupData(data, Action, deviceIds.toString());
        $("#datatableViewDiv").css("display", "none");
        $("#mobileDetailViewDiv").css("display", "none");
        $("#mobileDetailEditDiv").css("display", "block");
        $('#cancelbtn').attr("onclick", "closeBtnfromEdit('" + Action + "')");
        Action=='Multiedit' ? $('#multiEditButton').prop('checked', true) : $('#multiEditButton').prop('checked', false)
        //console.log("in setEditPopupData Action Recieved " +Action+" with Device ID " +deviceId);
      }
      $('div#initialloader').delay(300).fadeOut('slow');
    },
    error: function() {
      //alert("Failed");
    }
  });
}


//copy data

function viewDetailsCopy(deviceIds, Action) {
  //alert("SK "+  deviceIds)
  //$('div#initialloader').fadeIn('fast');
 // var deviceId;
 // Action == 'Multiedit' ? deviceId = deviceIds[0] : deviceId = deviceIds;
  var RequestData = {
    "deviceId": deviceIds,
    "featureId": parseInt(featureId),
    "userId": parseInt($("body").attr("data-userID")),
    "userType": $("body").attr("data-roleType"),
    "userTypeId": parseInt($("body").attr("data-userTypeID"))
  }
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: 'viewbyDeviceID',
    data: JSON.stringify(RequestData),
    dataType: 'json',
    contentType: 'application/json; charset=utf-8',
    type: 'POST',
    success: function(data) {
      //console.log(data);
    $("#editBrand").val(data.content[0].brandName);
    $("#editModel").val(data.content[0].modelName);
 	$("#editDeviceType").val(data.content[0].deviceType);
	$("#editManufacturer").val(data.content[0].manufacturer);
	$("#editOem").val(data.content[0].oem);
  	$("#editOrganizationID").val(data.content[0].organizationId);
  	var allocationDate = data.content[0].allocationDate;
  	if (allocationDate != null) {
    	allocationDate = allocationDate.split(' ')[0];
    	$("#editDeviceIDAllocationDate").val(allocationDate);
  	}
  	// Start TRC
  	var trcAppDate = data.content[0].trcApprovalDate;
  	if (trcAppDate != null) {
    	trcAppDate = trcAppDate.split(" ")[0];
    	$("#editTrcApprovalDate").val(trcAppDate);
  	}else{
		$("#editTrcApprovalDate").text(" ");
		$("#editTrcApprovalDate").hide();
	}
  	$("#editTrcTypeApprovedBy").val(data.content[0].trcTypeApprovedBy);
  	
  	if(data.content[0].isTypeApproved==0){
		$("#editIsTypeApproved").val("false");
	}else{
		$("#editIsTypeApproved").val("true");
	}
  	$("#edittrcApprovedStatus").val(data.content[0].trcApprovedStatus);
    $("#editManufacturerCountry").val(data.content[0].manufacturerCountry);
    $('#editManufacturerCountry').prop('disabled', true);
          },
    error: function() {
      //alert("Failed");
    }
  });
}


//end copy 


function viewHistoryDetails(deviceId,rowId){
  $('div#initialloader').fadeIn('fast');
  console.log("rowId " +rowId+" and DeviceId  "+deviceId);
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: './getDeviceHistoryInfo?deviceId=' + deviceId + 
    							'&featureId=' + parseInt(featureId) + 
    							'&userId=' + parseInt($("body").attr("data-userID")) + 
    							'&userType=' + $("body").attr("data-roleType") +
    							'&userTypeId=' +parseInt($("body").attr("data-userTypeID")) +
    							'&rowId=' +parseInt(rowId),
    contentType: 'application/json; charset=utf-8',
    type: 'POST',
    success: function(data, textStatus, xhr) {
      console.log("in success function "+JSON.stringify(data));
      setHistoryViewData(data);
      $("#datatableViewDiv").css("display", "none");
      $("#mobileDetailHistoryViewDiv").css("display", "block")
      //$("#viewdetailedHistoryLabel").css("display", "block");
      //$("#viewModelLabel,#editFromViewBtn").css("display", "none");
      //DeviceDataTable(lang, null, null, null);
      //$("#materialize-lean-overlay-3").css("display","none");
    },
    
    
    error: function() {
      ////console.log("Error");
    }
  
  });
    $('div#initialloader').delay(400).fadeOut('slow');
};


function setHistoryViewData(data) {
  console.log("in updated setHistoryViewData");
 // $('#editFromViewBtn').attr("onclick", "viewDetails('" + data.deviceId + "','EditfromView')");
 
 $("#viewHistoryManufacturer").text("").removeClass('highlight');
 $("#viewHistoryManufacturer").text(data.manufacturer);
 if(data.updateColumns.includes("manufacturer")==true){
	$("#viewHistoryManufacturer").addClass('highlight');
 }
 								
 $("#viewHistoryMarketingname").text("").removeClass('highlight');
 $("#viewHistoryMarketingname").text(data.marketingName);
 if(data.updateColumns.includes("marketingName")==true){
	$("#viewHistoryMarketingname").addClass('highlight');
 }
  
 $("#viewHistorytac").text(data.deviceId);
 
  /*data.updateColumns.includes("manufacturingLocation")==true ? 
  				$("#viewHistoryManAddress").append("<mark style='background-color:#f7ede6'>" + data.manufacturingLocation + "</mark>")
  								: $("#viewHistoryManAddress").text(data.manufacturingLocation);*/
 
 $("#viewHistoryManAddress").text("").removeClass('highlight');
 $("#viewHistoryManAddress").text(data.manufacturingLocation);
 if(data.updateColumns.includes("manufacturingLocation")==true){
	$("#viewHistoryManAddress").addClass('highlight');
 };
  
 $("#viewHistorybrand").text("").removeClass('highlight');
 $("#viewHistorybrand").text(data.brandName);
 if(data.updateColumns.includes("brandName")==true){
	$("#viewHistorybrand").addClass('highlight');
 };
 
 $("#viewHistoryModel").text("").removeClass('highlight');
 $("#viewHistoryModel").text(data.modelName);
 if(data.updateColumns.includes("modelName")==true){
	$("#viewHistoryModel").addClass('highlight');
 };
 
 //$("#viewNetworktech").text(data.networkTechnologyGSM);
  //Handling for checkbox starts
  $('input:checkbox').removeAttr('checked');
  $('#historyCheck1').removeClass('highlight');
  data.networkTechnologyGSM == 1 ? $('input[id=viewHistoryGSMCheck]').prop('checked', true) : $('input[id=viewHistoryGSMCheck]').prop('checked', false);
  if(data.updateColumns.includes("networkTechnologyGSM")==true){
		$('#historyCheck1').addClass('highlight');
	};
  
  $('#historyCheck2').removeClass('highlight');
  data.networkTechnologyCDMA == 1 ? $('input[id=viewHistoryCDMACheck]').prop('checked', true) : $('input[id=viewHistoryCDMACheck]').prop('checked', false);
  if(data.updateColumns.includes("networkTechnologyCDMA")==true){
		$("#historyCheck2").addClass('highlight');
  };
  
  $('#historyCheck3').removeClass('highlight');
  data.networkTechnologyEVDO == 1 ? $('input[id=viewHistoryEVDOCheck]').prop('checked', true) : $('input[id=viewHistoryEVDOCheck]').prop('checked', false);
  if(data.updateColumns.includes("networkTechnologyEVDO")==true){
		$("#historyCheck3").addClass('highlight');
  };
  
  $('#historyCheck4').removeClass('highlight');
  data.networkTechnologyLTE == 1 ? $('input[id=viewHistoryLTECheck]').prop('checked', true) : $('input[id=viewHistoryLTECheck]').prop('checked', false);
  if(data.updateColumns.includes("networkTechnologyLTE")==true){
		$('#historyCheck4').addClass('highlight');
  };
   
  $('#historyCheck5').removeClass('highlight'); 		
  data.networkTechnology5G == 1 ? $('input[id=viewHistory5GCheck]').prop('checked', true) : $('input[id=viewHistory5GCheck]').prop('checked', false);
  if(data.updateColumns.includes("networkTechnology5G")==true){
		$('#historyCheck5').addClass('highlight');
  };
 
 
 $("#viewHistorynetworkBand2G").text("").removeClass('highlight');
 $("#viewHistorynetworkBand2G").text(data.network2GBand);
 if(data.updateColumns.includes("network2GBand")==true){
	$("#viewHistorynetworkBand2G").addClass('highlight');
 };
 
 $("#viewHistorynetworkBand3G").text("").removeClass('highlight');
 $("#viewHistorynetworkBand3G").text(data.network3GBand);
 if(data.updateColumns.includes("network3GBand")==true){
	$("#viewHistorynetworkBand3G").addClass('highlight');
 };
 
 $("#viewHistorynetworkBand4G").text("").removeClass('highlight');
 $("#viewHistorynetworkBand4G").text(data.network4GBand);
 if(data.updateColumns.includes("network4GBand")==true){
	$("#viewHistorynetworkBand4G").addClass('highlight');
 };
 
 $("#viewHistorynetworkBand5G").text("").removeClass('highlight');
 $("#viewHistorynetworkBand5G").text(data.network5GBand);
 if(data.updateColumns.includes("network5GBand")==true){
	$("#viewHistorynetworkBand5G").addClass('highlight');
 };
 
 $("#viewHistorynetworkspeed").text("").removeClass('highlight');
 $("#viewHistorynetworkspeed").text(data.networkSpeed);
 if(data.updateColumns.includes("networkSpeed")==true){
	$("#viewHistorynetworkspeed").addClass('highlight');
 };
 
 $("#HistoryBrandDetails").text("").removeClass('highlight');
 $("#HistoryBrandDetails").text(data.bandDetail);
 if(data.updateColumns.includes("bandDetail")==true){
	$("#HistoryBrandDetails").addClass('highlight');
 };

 
 $("#HistoryDeviceType").text("").removeClass('highlight');
 $("#HistoryDeviceType").text(data.deviceType);
 if(data.updateColumns.includes("deviceType")==true){
	$("#HistoryDeviceType").addClass('highlight');
 };
 
 $("#HistoryNetworkIdentifier").text("").removeClass('highlight');
 $("#HistoryNetworkIdentifier").text(data.networkSpecificIdentifier);
 if(data.updateColumns.includes("networkSpecificIdentifier")==true){
	$("#HistoryNetworkIdentifier").addClass('highlight');
 };
 

  var announceDate = data.announceDate;
  if (announceDate != null) {
    //console.log("announceDate is  " +announceDate);
    announceDate = announceDate.split(' ')[0];
    $("#viewHistoryannounceDate").val(announceDate);
    $('#viewHistoryannounceDate').removeClass('highlight');
    if(data.updateColumns.includes("announceDate")==true){
		$('#viewHistoryannounceDate').addClass('highlight');
	}
  };
  
  var launchDate = data.launchDate;
  if (launchDate != null) {
    launchDate = launchDate.split(' ')[0];
    $("#viewHistoryLaunchDate").val(launchDate);
     $('#viewHistoryLaunchDate').removeClass('highlight');
    if(data.updateColumns.includes("launchDate")==true){
		$("#viewHistoryLaunchDate").addClass('highlight');
	}						
  };
  
  var allocationDate = data.allocationDate;
  if (allocationDate != null) {
    allocationDate = allocationDate.split(' ')[0];
    $("#viewHistoryallocationDate").val(allocationDate);
    $('#viewHistoryallocationDate').removeClass('highlight');
    if(data.updateColumns.includes("allocationDate")==true){
		$("#viewHistoryallocationDate").addClass('highlight');
	}
  };
  var discontinueDate = data.discontinueDate;
  if (discontinueDate != null) {
    discontinueDate = discontinueDate.split(' ')[0];
    $("#viewHistorydiscontinuedDate").val(discontinueDate);
    $('#viewHistorydiscontinuedDate').removeClass('highlight');
    if(data.updateColumns.includes("discontinueDate")==true){
		$("#viewHistorydiscontinuedDate").addClass('highlight');
	}
  };
  
  $("#viewHistoryDevicestatus").val(data.deviceStatus);
   $('#viewHistoryDevicestatus').removeClass('highlight');
  if(data.updateColumns.includes("deviceStatus")==true){
		$('#viewHistoryDevicestatus').addClass('highlight');
  };								
  
 $("#viewHistoryOEM").text("").removeClass('highlight');
 $("#viewHistoryOEM").text(data.oem);
 if(data.updateColumns.includes("oem")==true){
	$("#viewHistoryOEM").addClass('highlight');
 };
 
 $("#viewHistoryOrganizationId").text("").removeClass('highlight');
 $("#viewHistoryOrganizationId").text(data.organizationId);
 if(data.updateColumns.includes("organizationId")==true){
	$("#viewHistoryOrganizationId").addClass('highlight');
 }
  
 $("#viewHistorySimSlots").text("").removeClass('highlight');
 $("#viewHistorySimSlots").text(data.simSlot);
 if(data.updateColumns.includes("simSlot")==true){
	$("#viewHistorySimSlots").addClass('highlight');
 };
 
 $("#viewHistorynumberofIMEI").text("").removeClass('highlight');
 $("#viewHistorynumberofIMEI").text(data.imeiQuantity);
 if(data.updateColumns.includes("imeiQuantity")==true){
	$("#viewHistorynumberofIMEI").addClass('highlight');
 };
 
 $("#viewHistorySimtype").text("").removeClass('highlight');
 $("#viewHistorySimtype").text(data.simType);
 if(data.updateColumns.includes("simType")==true){
	$("#viewHistorySimtype").addClass('highlight');
 };
 
 $("#viewHistoryDimension").text("").removeClass('highlight');
 $("#viewHistoryDimension").text(data.bodyDimension);
 if(data.updateColumns.includes("bodyDimension")==true){
	$("#viewHistoryDimension").addClass('highlight');
 };
 
 $("#viewHistoryBodyweight").text("").removeClass('highlight');
 $("#viewHistoryBodyweight").text(data.bodyWeight);
 if(data.updateColumns.includes("bodyWeight")==true){
	$("#viewHistoryBodyweight").addClass('highlight');
 };
 
  
  $("#viewHistoryeSimSupport").val(data.esimSupport);
  $('#viewHistoryeSimSupport').removeClass('highlight');
  if(data.updateColumns.includes("esimSupport")==true){
		$('#viewHistoryeSimSupport').addClass('highlight');
  };								
  								
  
  $("#viewHistorySoftSimSupport").val(data.softsimSupport);
  $('#viewHistorySoftSimSupport').removeClass('highlight');
  if(data.updateColumns.includes("softsimSupport")==true){
		$('#viewHistorySoftSimSupport').addClass('highlight');
  };
  
 $("#viewHistorytype").text("").removeClass('highlight');
 $("#viewHistorytype").text(data.displayType);
 if(data.updateColumns.includes("displayType")==true){
	$("#viewHistorytype").addClass('highlight');
 };
 								
 $("#viewHistoryResolution").text("").removeClass('highlight');
 $("#viewHistoryResolution").text(data.displayResolution);
 if(data.updateColumns.includes("displayResolution")==true){
	$("#viewHistoryResolution").addClass('highlight');
 };
 
 $("#viewHistoryProtection").text("").removeClass('highlight');
 $("#viewHistoryProtection").text(data.displayProtection);
 if(data.updateColumns.includes("displayProtection")==true){
	$("#viewHistoryProtection").addClass('highlight');
 };
 
 $("#viewHistoryOs").text("").removeClass('highlight');
 $("#viewHistoryOs").text(data.os);
 if(data.updateColumns.includes("os")==true){
	$("#viewHistoryOs").addClass('highlight');
 };
 
 $("#viewHistoryOSversion").text("").removeClass('highlight');
 $("#viewHistoryOSversion").text(data.osBaseVersion);
 if(data.updateColumns.includes("osBaseVersion")==true){
	$("#viewHistoryOSversion").addClass('highlight');
 };
 
 $("#viewHistoryinternalMemory").text("").removeClass('highlight');
 $("#viewHistoryinternalMemory").text(data.memoryInternal);
 if(data.updateColumns.includes("memoryInternal")==true){
	$("#viewHistoryinternalMemory").addClass('highlight');
 };
 
 $("#viewHistoryRAM").text("").removeClass('highlight');
 $("#viewHistoryRAM").text(data.ram);
 if(data.updateColumns.includes("ram")==true){
	$("#viewHistoryRAM").addClass('highlight');
 };
 
 $("#viewHistoryMemoryCardSlot").text("").removeClass('highlight');
 $("#viewHistoryMemoryCardSlot").text(data.memoryCardSlot);
 if(data.updateColumns.includes("memoryCardSlot")==true){
	$("#viewHistoryMemoryCardSlot").addClass('highlight');
 };
 
 $("#viewHistoryCPU").text("").removeClass('highlight');
 $("#viewHistoryCPU").text(data.platformCPU);
 if(data.updateColumns.includes("platformCPU")==true){
	$("#viewHistoryCPU").addClass('highlight');
 };
 
 $("#viewHistoryGPU").text("").removeClass('highlight');
 $("#viewHistoryGPU").text(data.platformGPU);
 if(data.updateColumns.includes("platformGPU")==true){
	$("#viewHistoryGPU").addClass('highlight');
 };
 
 $("#viewHistoryGPU").text("").removeClass('highlight');
 $("#viewHistoryGPU").text(data.platformGPU);
 if(data.updateColumns.includes("platformGPU")==true){
	$("#viewHistoryGPU").addClass('highlight');
 };
 
 
$("#viewHistoryTriple").val(data.mainCameraType);
 $('#viewHistoryTriple').removeClass('highlight');
  if(data.updateColumns.includes("mainCameraType")==true){
		$('#viewHistoryTriple').addClass('highlight');
 }; 								
 
 $("#viewHistoryMainCameraSpecs").text("").removeClass('highlight');
 $("#viewHistoryMainCameraSpecs").text(data.mainCameraSpec);
 if(data.updateColumns.includes("mainCameraSpec")==true){
	$("#viewHistoryMainCameraSpecs").addClass('highlight');
 };
 
 $("#viewHistoryMainCameraFeature").text("").removeClass('highlight');
 $("#viewHistoryMainCameraFeature").text(data.mainCameraFeature);
 if(data.updateColumns.includes("mainCameraFeature")==true){
	$("#viewHistoryMainCameraFeature").addClass('highlight');
 };
 	
 $("#viewHistoryMainCameraVideo").text("").removeClass('highlight');
 $("#viewHistoryMainCameraVideo").text(data.mainCameraVideo);
 if(data.updateColumns.includes("mainCameraVideo")==true){
	$("#viewHistoryMainCameraVideo").addClass('highlight');
 };
 
 $("#viewHistorySelfieCameratype").val(data.selfieCameraType);
 $('#viewHistorySelfieCameratype').removeClass('highlight');
  if(data.updateColumns.includes("selfieCameraType")==true){
		$('#viewHistorySelfieCameratype').addClass('highlight');
 }; 								
 
 $("#viewHistorySelfieCameraSpecs").text("").removeClass('highlight');
 $("#viewHistorySelfieCameraSpecs").text(data.selfieCameraSpec);
 if(data.updateColumns.includes("selfieCameraSpec")==true){
	$("#viewHistorySelfieCameraSpecs").addClass('highlight');
 };
 
 $("#viewHistorySelfieCameraFeature").text("").removeClass('highlight');
 $("#viewHistorySelfieCameraFeature").text(data.selfieCameraFeature);
 if(data.updateColumns.includes("selfieCameraFeature")==true){
	$("#viewHistorySelfieCameraFeature").addClass('highlight');
 };
 
 $("#viewHistorySelfieCameraVideo").text("").removeClass('highlight');
 $("#viewHistorySelfieCameraVideo").text(data.selfieCameraVideo);
 if(data.updateColumns.includes("selfieCameraVideo")==true){
	$("#viewHistorySelfieCameraVideo").addClass('highlight');
 };
 
 $("#viewHistoryLoudspeaker").val(data.soundLoudspeaker);
 $('#viewHistoryLoudspeaker').removeClass('highlight');
  if(data.updateColumns.includes("soundLoudspeaker")==true){
		$('#viewHistoryLoudspeaker').addClass('highlight');
 };								
  								  								
 $("#viewHistorySoundJack").val(data.sound35mmJack);
 $('#viewHistorySoundJack').removeClass('highlight');
  if(data.updateColumns.includes("sound35mmJack")==true){
		$('#viewHistorySoundJack').addClass('highlight');
 };									
 
 $("#viewHistoryWLANSupport").text("").removeClass('highlight');
 $("#viewHistoryWLANSupport").text(data.commsWLAN);
 if(data.updateColumns.includes("commsWLAN")==true){
	$("#viewHistoryWLANSupport").addClass('highlight');
 };
 
 $("#viewHistoryBluetoothSupport").text("").removeClass('highlight');
 $("#viewHistoryBluetoothSupport").text(data.commsBluetooth);
 if(data.updateColumns.includes("commsBluetooth")==true){
	$("#viewHistoryBluetoothSupport").addClass('highlight');
 };
 
 $("#viewHistoryGPSSupport").text("").removeClass('highlight');
 $("#viewHistoryGPSSupport").text(data.commsGPS);
 if(data.updateColumns.includes("commsGPS")==true){
	$("#viewHistoryGPSSupport").addClass('highlight');
 };
 
 $("#viewHistoryUSBSupport").text("").removeClass('highlight');
 $("#viewHistoryUSBSupport").text(data.commsUSB);
 if(data.updateColumns.includes("commsUSB")==true){
	$("#viewHistoryUSBSupport").addClass('highlight');
 };
 
 $("#viewHistoryRadioSupport").val(data.commsRadio);
 $('#viewHistoryRadioSupport').removeClass('highlight');
  if(data.updateColumns.includes("commsRadio")==true){
		$('#viewHistoryRadioSupport').addClass('highlight');
 };	 								
  	
 $("#viewHistoryNFCSupport").val(data.commsNFC);
 $('#viewHistoryNFCSupport').removeClass('highlight');
  if(data.updateColumns.includes("commsNFC")==true){
		$('#viewHistoryNFCSupport').addClass('highlight');
 };	
 
 $("#viewHistorySensors").text("").removeClass('highlight');
 $("#viewHistorySensors").text(data.sensor);
 if(data.updateColumns.includes("sensor")==true){
	$("#viewHistorySensors").addClass("highlight");
 };
 
 $("#viewHistoryDeviceColor").text("").removeClass('highlight');
 $("#viewHistoryDeviceColor").text(data.colors);
 if(data.updateColumns.includes("colors")==true){
	$("#viewHistoryDeviceColor").addClass('highlight');
 };
 
 $("#viewHistoryUICC").text("").removeClass('highlight');
 $("#viewHistoryUICC").text(data.removableUICC);
 if(data.updateColumns.includes("removableUICC")==true){
	$("#viewHistoryUICC").addClass('highlight');
 };
  
 $("#viewHistoryEUICC").text("").removeClass('highlight');
 $("#viewHistoryEUICC").text(data.removableEUICC);
 if(data.updateColumns.includes("removableEUICC")==true){
	$("#viewHistoryEUICC").addClass('highlight');
 }; 
  
 $("#viewHistoryBatteryCapacity").text("").removeClass('highlight');
 $("#viewHistoryBatteryCapacity").text(data.batteryCapacity);
 if(data.updateColumns.includes("batteryCapacity")==true){
	$("#viewHistoryBatteryCapacity").addClass('highlight');
 }; 
 
 $("#viewHistoryBatteryChargingSupport").text("").removeClass('highlight');
 $("#viewHistoryBatteryChargingSupport").text(data.batteryCharging);
 if(data.updateColumns.includes("batteryCharging")==true){
	$("#viewHistoryBatteryChargingSupport").addClass('highlight');
 }; 
								
 $("#viewHistoryBatteryChargingSupport2").text("").removeClass('highlight');
 $("#viewHistoryBatteryChargingSupport2").text(data.batteryCharging);
 if(data.updateColumns.includes("batteryCharging")==true){
	$("#viewHistoryBatteryChargingSupport2").addClass('highlight');
 }; 
  
 $("#viewHistoryAsia").text("").removeClass('highlight');
 $("#viewHistoryAsia").text(data.launchPriceAsianMarket);
 if(data.updateColumns.includes("launchPriceAsianMarket")==true){
	$("#viewHistoryAsia").addClass('highlight');
 }; 
  
 $("#viewHistoryUS").text("").removeClass('highlight');
 $("#viewHistoryUS").text(data.launchPriceUSMarket);
 if(data.updateColumns.includes("launchPriceUSMarket")==true){
	$("#viewHistoryUS").addClass('highlight');
 }; 
 
 $("#viewHistoryEurope").text("").removeClass('highlight');
 $("#viewHistoryEurope").text(data.launchPriceEuropeMarket);
 if(data.updateColumns.includes("launchPriceEuropeMarket")==true){
	$("#viewHistoryEurope").addClass('highlight');
 }; 
 
 $("#viewHistoryInternational").text("").removeClass('highlight');
 $("#viewHistoryInternational").text(data.launchPriceInternationalMarket);
 if(data.updateColumns.includes("launchPriceInternationalMarket")==true){
	$("#viewHistoryInternational").addClass('highlight');
 };
  
 $("#viewHistoryLaunchPriceCambodia").text("").removeClass('highlight');
 $("#viewHistoryLaunchPriceCambodia").text(data.launchPriceCambodiaMarket);
 if(data.updateColumns.includes("launchPriceCambodiaMarket")==true){
	$("#viewHistoryLaunchPriceCambodia").addClass('highlight');
 };
  
 $("#viewHistorySourcePriceCambodia").text("").removeClass('highlight');
 $("#viewHistorySourcePriceCambodia").text(data.sourceOfCambodiaMarketPrice);
 if(data.updateColumns.includes("sourceOfCambodiaMarketPrice")==true){
	$("#viewHistorySourcePriceCambodia").addClass('highlight');
 };
 
 $("#viewHistoryCustomPrice").text("").removeClass('highlight');
 $("#viewHistoryCustomPrice").text(data.customPriceOfDevice);
 if(data.updateColumns.includes("customPriceOfDevice")==true){
	$("#viewHistoryCustomPrice").addClass('highlight');
 };
  
 $("#viewHistoryGlobalIssue").text("").removeClass('highlight');
 $("#viewHistoryGlobalIssue").text(data.reportedGlobalIssue);
 if(data.updateColumns.includes("reportedGlobalIssue")==true){
	$("#viewHistoryGlobalIssue").addClass('highlight');
 };
  
 $("#viewHistoryLocalIssue").text("").removeClass('highlight');
 $("#viewHistoryLocalIssue").text(data.reportedLocalIssue);
 if(data.updateColumns.includes("reportedLocalIssue")==true){
	$("#viewHistoryLocalIssue").addClass('highlight');
 };
 
 $("#viewHistoryRemarks").text("").removeClass('highlight');
 $("#viewHistoryRemarks").text(data.remark);
 if(data.updateColumns.includes("remark")==true){
	$("#viewHistoryRemarks").addClass('highlight');
 };
 
 
 //TRC
 $("#viewHistoryTrcApprovalDate").text("").removeClass('highlight');
 $("#viewHistoryTrcApprovalDate").text(data.trcApprovalDate);
 if(data.updateColumns.includes("trcApprovalDate")==true){
	$("#viewHistoryTrcApprovalDate").addClass('highlight');
 };

$("#viewHistoryTrcTypeApprovedBy").text("").removeClass('highlight');
 $("#viewHistoryTrcTypeApprovedBy").text(data.trcTypeApprovedBy);
 if(data.updateColumns.includes("trcTypeApprovedBy")==true){
	$("#viewHistoryTrcTypeApprovedBy").addClass('highlight');
 };

$("#viewHistoryManufacturerCountry").text("").removeClass('highlight');
 $("#viewHistoryManufacturerCountry").text(data.manufacturerCountry);
 if(data.updateColumns.includes("manufacturerCountry")==true){
	$("#viewHistoryManufacturerCountry").addClass('highlight');
 };

$("#viewHistoryIsTypeApproved").text("").removeClass('highlight');

/*if(data.content[0].isTypeApproved==0){*/ //Testing by DMC
if(data.isTypeApproved==0){
	$("#viewHistoryIsTypeApproved").text("false");
}else{
	$("#viewHistoryIsTypeApproved").text("true");
}

 //$("#viewHistoryIsTypeApproved").text(data.isTypeApproved);
 if(data.updateColumns.includes("isTypeApproved")==true){
	$("#viewHistoryIsTypeApproved").addClass('highlight');
 };


$("#viewHistorytrcApprovedStatus").text("").removeClass('highlight');
 //$("#viewHistorytrcApprovedStatus").text(data.trcApprovedStatus);
 $("#viewHistorytrcApprovedStatus").text(data.isTypeApproved);
 if(data.updateColumns.includes("trcApprovedStatus")==true){
	$("#viewHistorytrcApprovedStatus").addClass('highlight');
 };
//TRC
 
 //previewRegistrtionFile(data.attachedFiles, 'View');
  //console.log("Attatched Files Details " +JSON.stringify(data.attachedFiles));
}


function closeBtnfromEdit(Action) {
  if (Action == 'Edit') {
    DeviceDataTable(lang, 'filter', null, null);
    $("#editDeviceBtn").css("display", "none");
    $("#addDeviceBtn").css("display", "block");
  }else if (Action == 'copy' ) {
	
    //DeviceDataTable(lang, 'filter', null, null);
    DeviceDataTable(lang, null, null, null);
    $("#editDeviceBtn").css("display", "none");
    $("#addDeviceBtn").css("display", "block");
    
  } else {
    $('#multiEditButton').prop('checked', true);
    DeviceDataTable(window.parent.$('#langlist').val(), 'filter', 'multiedit', null);
    $("#editDeviceBtn").css("display", "block");
    $("#addDeviceBtn").css("display", "none");
  }
  $("#docTypeFile1").attr("disabled", false);
  $("#docTypeFileSave").attr("disabled", false);
  
  //Reset Tab
  $('#mobileDetailEditDiv ul li a').each(function() {
    $("#mobileDetailEditDiv ul li a").removeAttr('class');
  });	
  $('#mobileDetailEditDiv ul li a:first').addClass('active');
  $('#mobileDetailEditDiv .tab-content [id^=tabEdit]').removeClass('active show');
  $('#mobileDetailEditDiv .tab-content :first').addClass('active show');
  $("#mobileDetailEditDiv").css("display", "none");
  $("#datatableViewDiv").css("display", "block");
  
}

function setcopyViewPopupData(data) {
  $("#copyViewbrand").text(data.content[0].brandName);
  $("#copyViewmodelName").text(data.content[0].modelName);
  $("#copyViewOsType").text(data.content[0].os);
  $("#copyViewMarketingName").text(data.content[0].marketingName);
  $("#copyViewManufacturer").text(data.content[0].manufacturer);
  $("#copyViewManufacturingAddress").text(data.content[0].manufacturingLocation);
  $("#copyViewdevicestatus").text(data.content[0].deviceStatus);
  $("#copyViewOrganizationID").text(data.content[0].organizationId);
  $("#copyViewDeviceIDAllocationDate").text(data.content[0].organizationId);
  $('#copyButton').attr("onclick", "copyDetails('" + data.content[0].deviceId + "','copy')");
  previewRegistrtionFile(data.content[0].attachedFiles, 'copyView');
  //copyAllImage();
}

function setViewPopupData(data) {
  //console.log("set view data" +JSON.stringify(data.content[0].brandName));
  $('#editFromViewBtn').attr("onclick", "viewDetails('" + data.content[0].deviceId + "','EditfromView')");
  $("#viewManufacturer").text(data.content[0].manufacturer);
  $("#viewMarketingname").text(data.content[0].marketingName);
  $("#viewtac").text(data.content[0].deviceId);
  $("#viewManAddress").text(data.content[0].manufacturingLocation);
  $("#viewbrand").text(data.content[0].brandName);
  $("#viewModel").text(data.content[0].modelName);
  //$("#viewNetworktech").text(data.content[0].networkTechnologyGSM);
  //Handling for checkbox starts
  $('input:checkbox').removeAttr('checked');
  data.content[0].networkTechnologyGSM == 1 ? $('input[id=viewGSMCheck]').prop('checked', true) : $('input[id=viewGSMCheck]').prop('checked', false);
  data.content[0].networkTechnologyCDMA == 1 ? $('input[id=viewCDMACheck]').prop('checked', true) : $('input[id=viewCDMACheck]').prop('checked', false);
  data.content[0].networkTechnologyEVDO == 1 ? $('input[id=viewEVDOCheck]').prop('checked', true) : $('input[id=viewEVDOCheck]').prop('checked', false);
  data.content[0].networkTechnologyLTE == 1 ? $('input[id=viewLTECheck]').prop('checked', true) : $('input[id=viewLTECheck]').prop('checked', false);
  data.content[0].networkTechnology5G == 1 ? $('input[id=view5GCheck]').prop('checked', true) : $('input[id=view5GCheck]').prop('checked', false);
  $("#viewnetworkBand2G").text(data.content[0].network2GBand);
  $("#viewnetworkBand3G").text(data.content[0].network3GBand);
  $("#viewnetworkBand4G").text(data.content[0].network4GBand);
  $("#viewnetworkBand5G").text(data.content[0].network5GBand);
  
  
  $("#viewnetworkspeed").text(data.content[0].networkSpeed);
  $("#BrandDetails").text(data.content[0].bandDetail);
  
  //New added Field
  $("#viewDeviceType").text(data.content[0].deviceType);
  $("#viewNetworkIdentifier").text(data.content[0].networkSpecificIdentifier);
  
  
  
  var announceDate = data.content[0].announceDate;
  if (announceDate != null) {
    //console.log("announceDate is  " +announceDate);
    announceDate = announceDate.split(' ')[0];
    //console.log("announceDate is AFTER SPLIT " +announceDate);
    $("#viewannounceDate").val(announceDate);
  }
  var launchDate = data.content[0].launchDate;
  if (launchDate != null) {
    launchDate = launchDate.split(' ')[0];
    $("#viewLaunchDate").val(launchDate);
  }
  var allocationDate = data.content[0].allocationDate;
  if (allocationDate != null) {
    allocationDate = allocationDate.split(' ')[0];
    $("#viewallocationDate").val(allocationDate);
  }
  var discontinueDate = data.content[0].discontinueDate;
  if (discontinueDate != null) {
    discontinueDate = discontinueDate.split(' ')[0];
    $("#viewdiscontinuedDate").val(discontinueDate);
  }
  $("#viewDevicestatus").val(data.content[0].deviceStatus);
  $("#viewOEM").text(data.content[0].oem);
  $("#viewOrganizationId").text(data.content[0].organizationId);
  $("#viewSimSlots").text(data.content[0].simSlot);
  $("#viewnumberofIMEI").text(data.content[0].imeiQuantity);
  $("#viewSimtype").text(data.content[0].simType);
  $("#viewDimension").text(data.content[0].bodyDimension);
  $("#viewBodyweight").text(data.content[0].bodyWeight);
  $("#vieweSimSupport").val(data.content[0].esimSupport);
  $("#viewSoftSimSupport").val(data.content[0].softsimSupport);
  $("#viewtype").text(data.content[0].displayType);
  $("#viewSize").text(data.content[0].displaySize);
  $("#viewResolution").text(data.content[0].displayResolution);
  $("#viewProtection").text(data.content[0].displayProtection);
  $("#viewOs").text(data.content[0].os);
  $("#viewOSversion").text(data.content[0].osBaseVersion);
  $("#viewinternalMemory").text(data.content[0].memoryInternal);
  $("#viewRAM").text(data.content[0].ram);
  $("#viewMemoryCardSlot").text(data.content[0].memoryCardSlot);
  $("#viewCPU").text(data.content[0].platformCPU);
  $("#viewGPU").text(data.content[0].platformGPU);
  $("#viewTriple").val(data.content[0].mainCameraType);
  $("#viewMainCameraSpecs").text(data.content[0].mainCameraSpec);
  $("#viewMainCameraFeature").text(data.content[0].mainCameraFeature);
  $("#viewMainCameraVideo").text(data.content[0].mainCameraVideo);
  $("#viewSelfieCameratype").val(data.content[0].selfieCameraType);
  $("#viewSelfieCameraSpecs").text(data.content[0].selfieCameraSpec);
  $("#viewSelfieCameraFeature").text(data.content[0].selfieCameraFeature);
  $("#viewSelfieCameraVideo").text(data.content[0].selfieCameraVideo);
  $("#viewLoudspeaker").val(data.content[0].soundLoudspeaker);
  $("#viewSoundJack").val(data.content[0].sound35mmJack);
  $("#viewWLANSupport").text(data.content[0].commsWLAN);
  $("#viewBluetoothSupport").text(data.content[0].commsBluetooth);
  $("#viewGPSSupport").text(data.content[0].commsGPS);
  $("#viewUSBSupport").text(data.content[0].commsUSB);
  $("#viewRadioSupport").val(data.content[0].commsRadio);
  $("#viewNFCSupport").val(data.content[0].commsNFC);
  $("#viewSensors").text(data.content[0].sensor);
  $("#viewDeviceColor").text(data.content[0].colors);
  $("#viewUICC").text(data.content[0].removableUICC);
  $("#viewEUICC").text(data.content[0].removableEUICC);
  $("#viewBatteryCapacity").text(data.content[0].batteryCapacity);
  $("#viewBatteryChargingSupport").text(data.content[0].batteryCharging);
  $("#viewAsia").text(data.content[0].launchPriceAsianMarket);
  $("#viewUS").text(data.content[0].launchPriceUSMarket);
  $("#viewEurope").text(data.content[0].launchPriceEuropeMarket);
  $("#viewInternational").text(data.content[0].launchPriceInternationalMarket);
  $("#viewLaunchPriceCambodia").text(data.content[0].launchPriceCambodiaMarket);
  $("#viewSourcePriceCambodia").text(data.content[0].sourceOfCambodiaMarketPrice) == "" ? $("#viewSourcePriceCambodia").text("0") : $("#viewSourcePriceCambodia").text(data.content[0].sourceOfCambodiaMarketPrice);
  $("#viewCustomPrice").text(data.content[0].customPriceOfDevice);
  $("#viewGlobalIssue").text(data.content[0].reportedGlobalIssue);
  $("#viewLocalIssue").text(data.content[0].reportedLocalIssue);
  $("#viewRemarks").text(data.content[0].remark);
  
  //TRC
  //$("#viewTrcApprovalDate").text(data.content[0].trcApprovalDate);
/*  if(data.content[0].trcApprovalDate!=null || data.content[0].trcApprovalDate==="null" || data.content[0].trcApprovalDate==="Null"){
		$("#viewTrcApprovalDate").text("");
	}else{
		$("#viewTrcApprovalDate").text(data.content[0].trcApprovalDate);	
	}*/
	
	//alert(data.content[0].trcApprovalDate);
	
  	var trcApprovedDate = data.content[0].trcApprovalDate;
  	if (trcApprovedDate != null) {
		console.log("Success "+trcApprovedDate);
    	trcApprovedDate = trcApprovedDate.split(' ')[0];
    	$("#viewTrcApprovalDate").text(trcApprovedDate);
  	}else{
		console.log("Failed "+trcApprovedDate);
		$("#viewTrcApprovalDate").text("");
	}
  	/*if(data.content[0].trcApprovalDate==null || data.content[0].trcApprovalDate==="null" || data.content[0].trcApprovalDate==="Null"){
		$("#viewTrcApprovalDate").text("");
	}*/
	
  $("#viewTrcTypeApprovedBy").text(data.content[0].trcTypeApprovedBy);
  
  $("#viewManufacturerCountry").text(data.content[0].manufacturerCountry);
  
	if(data.content[0].isTypeApproved==0){
		$("#viewIsTypeApproved").text("false");
	}else{
		$("#viewIsTypeApproved").text("true");
	}
   
 // $("#viewIsTypeApproved").text(data.content[0].isTypeApproved);
 	if(data.content[0].trcApprovedStatus==null || data.content[0].trcApprovedStatus==="null" || data.content[0].trcApprovedStatus==="Null"){
		$("#viewtrcApprovedStatus").text("");
	}else{
		$("#viewtrcApprovedStatus").text(data.content[0].trcApprovedStatus);	
	}
  
  
  //end TRC
  
  previewRegistrtionFile(data.content[0].attachedFiles, 'View');
  //console.log("Attatched Files Details " +JSON.stringify(data.content[0].attachedFiles));
}

function previewRegistrtionFile(srcFileDetails, Action) {
  console.log("srcFileDetails are " + JSON.stringify(srcFileDetails) + " with Action recieved " + Action);
  //$("#mainFrameEdit,#mainFrameEdit1,#mainFrameEdit2,#mainFrameEdit3,#mainFrameEdit4,#mainFrameEdit5").files=null;
  
  //var attachedFilesDetails = new Array();
  	//View IMG Tags
    $("#mainFrame,#subFrame1,#subFrame2,#subFrame3,#subFrame4,#subFrame5").attr("src", './resources/assets/images/NoImage.jpg');
    //Edit IMG Tags	
    $("#mainFrameEdit,#mainFrameEdit1,#mainFrameEdit2,#mainFrameEdit3,#mainFrameEdit4,#mainFrameEdit5").attr("src", './resources/assets/images/NoImage.jpg');
    
    //copyFrom IMG Tag
    $("#copyFromMainFrame,#copyFromsubFrame1,#copyFromsubFrame2,#copyFromsubFrame3,#copyFromsubFrame4,#copyFromsubFrame5").attr("src", './resources/assets/images/NoImage.jpg');
    
    
  if (srcFileDetails.length == 0) {
    console.log("no file details recieved for Action " + Action);
    //View IMG Tags
    $("#mainFrame,#subFrame1,#subFrame2,#subFrame3,#subFrame4,#subFrame5").attr("src", './resources/assets/images/NoImage.jpg');
    //Edit IMG Tags	
    $("#mainFrameEdit,#mainFrameEditInput1,#mainFrameEditInput2,#mainFrameEditInput3,#mainFrameEditInput4,#mainFrameEditInput5").val(null);
    $("#mainFrameEdit,#mainFrameEdit1,#mainFrameEdit2,#mainFrameEdit3,#mainFrameEdit4,#mainFrameEdit5").attr("src", './resources/assets/images/NoImage.jpg');
    //copyFrom IMG Tag
    $("#copyFromMainFrame,#copyFromsubFrame1,#copyFromsubFrame2,#copyFromsubFrame3,#copyFromsubFrame4,#copyFromsubFrame5").attr("src", './resources/assets/images/NoImage.jpg');
  }
  console.log("file details srcFileDetails.length " + srcFileDetails.length);
  //$(".resetImgID").attr("img-id",null);
 // $(".resetImgID").attr("alt",null);
  
  for (i = 1; i <= srcFileDetails.length; i++) {
    var fileName = srcFileDetails[i-1].fileName;
    var filePath = srcFileDetails[i-1].filePath;
    if (fileName == "" || fileName == null) {
      console.log("file name " + fileName + " for Action " + Action);
    } else {
      console.log("file details recieved for Action " + Action);
      var FinalLink = filePath.split("webapps")[1];
	  console.log("FinalLink is --- " + FinalLink + " and value of  i---" + i);
      Action == 'View' ? $("#subFrame" + i).attr("src", './resources/assets/images/NoImage.jpg') && $("#subFrame" + i).attr("src", FinalLink) && $("img#mainFrame").attr('src', $("img#subFrame1").attr('src')) 
      			: $("#mainFrameEdit" + i).attr("src", FinalLink) && $("#mainFrameEdit" + i).attr("img-id", srcFileDetails[i-1].id) && $("img#mainFrameEdit").attr('src', $("img#mainFrameEdit1").attr('src'));
      Action == 'copyView' ? $("#copyFromsubFrame" + i).attr("src", './resources/assets/images/NoImage.jpg') && $("#copyFromsubFrame" + i).attr("src", FinalLink) && $("img#copyFromMainFrame").attr('src', $("img#copyFromsubFrame1").attr('src')) : $("#copyFromsubFrame" + i).attr("src", FinalLink);
      if (Action == 'copy') {
        //$("#subFrameEdit1,#subFrameEdit2,#subFrameEdit3,#subFrameEdit4,#subFrameEdit5").attr("src", './resources/assets/images/NoImage.jpg');
        $("#subFrameEdit" + i).attr("src", FinalLink);
      }
      console.log("filePath is " + filePath + " with Action  " + Action);
      //Action == 'copy' ? $("#subFrameEdit"+i).attr("src", "") && $("#subFrameEdit"+i).attr("src", FinalLink) : $("#subFrameEdit"+i).attr("src", FinalLink);
    }
    //console.log("fileName is "+fileName+" and filePath is "+filePath);
  }
 
  copyAllImage();
}

function selectImage(src) {
  $("#mainFrame").attr("src", '');
  $("#mainFrame").attr("src", src);
  $("#copyFromMainFrame").attr("src", src);
};
var sourceCopyTac = null;

function copyDetails(copiedDeviceId, Action) {
  //copiedDeviceId=$("#copyFromTac").val();
  console.log("copiedDeviceId is " + copiedDeviceId + " and Action is " + Action);
  $('#CopyForm-choose,#CopyForm-view').closeModal({
    dismissible: false
  });
  $('.modal-backdrop').remove();
  $('#editForm').trigger('reset');  
  $("#editCopiedTac").text('');
  $("#editCopiedTac").append($("#editTac").text());
  $("#editCopiedId").text($("#editId").text());
  	if($('#multiEditButton').is(':checked') == true){
		Action="MultiEdit";
 	}
  viewDetails(copiedDeviceId, Action);
  //viewDetailsCopy(copiedDeviceId, Action);
}


function setEditPopupData(data, Action, deviceId) {
  //document.getElementById('editTac').removeAttribute('data-title');
  console.log("in setEditPopupData inside function Action Recieved " + Action + " with Device ID " + deviceId);
  //Edit Headers
  var tacs = deviceId.substring(0, 17);
  console.log("tacs------"+tacs);
  console.log("deviceId.toString()---" +deviceId.toString());
  $("#editId").text(data.content[0].id);
  //Action = 'Multiedit' ? $("#editId").text(deviceId) : $("#editId").text(data.content[0].deviceId);
 // Action = 'copy' ? $("#editId").text(deviceId) : $("#editId").text(data.content[0].deviceId);
 
 
 
 if(Action != 'copy') {
	console.log("in copy condition setEditPopupData inside function Action Recieved " + Action + " with Device ID " + deviceId);
	$("#editBrand").val(data.content[0].brandName);
    $("#editModel").val(data.content[0].modelName);
 	$("#editDeviceType").val(data.content[0].deviceType);
	$("#editManufacturer").val(data.content[0].manufacturer);
	$("#editOem").val(data.content[0].oem);
  	$("#editOrganizationID").val(data.content[0].organizationId);
  	var allocationDate = data.content[0].allocationDate;
  	if (allocationDate != null) {
    	allocationDate = allocationDate.split(' ')[0];
    	$("#editDeviceIDAllocationDate").val(allocationDate);
  	}
  	// Start TRC
  	var trcAppDate = data.content[0].trcApprovalDate;
  	if (trcAppDate != null) {
    	trcAppDate = trcAppDate.split(" ")[0];
    	$("#editTrcApprovalDate").val(trcAppDate);
  	}else{
		$("#editTrcApprovalDate").text(" ");
		$("#editTrcApprovalDate").hide();
	}
  
  	$("#editTrcTypeApprovedBy").val(data.content[0].trcTypeApprovedBy);
  	
  	if(data.content[0].isTypeApproved==0){
		$("#editIsTypeApproved").val("false");
	}else{
		$("#editIsTypeApproved").val("true");
	}
  	
  	$("#edittrcApprovedStatus").val(data.content[0].trcApprovedStatus);
  
   // End  TRC
  }
  $("#editManufacturerCountry").val(data.content[0].manufacturerCountry);
  
  //$("#editManufacturer").val(data.content[0].manufacturer);
  $("#editMarketingName").val(data.content[0].marketingName);
  if (Action == 'Multiedit') {
	//alert("Action in if "+Action);
	$("#editTac").text('');
    $("#editTac").text(tacs);
    $("#editTac").append('...');
    document.getElementById('editTac').setAttribute('data-title', deviceId.toString());
	//console.log("#editTac-----" +$("#editTac").text());
   
    
    document.getElementById('editTac').setAttribute('data-title', deviceId.toString());
    $('#editManufacturerCountry').prop('disabled', true);
    $("#editManufacturerCountry").css('display', 'none');
    
    $("#edit_Brand").val(data.content[0].brandName);
 	$("#edit_Model").val(data.content[0].modelName);
    
    
  } else {
	//alert("Action in else "+Action);
    if(Action=='MultiEdit'){
		//alert("1");
		//$("#editTac").text(data.content[0].deviceId);
    	$("#editTac").text('');
    	$("#editTac").text($("#editCopiedTac").text());
    	$("#editId").text($("#editCopiedId").text());
    	viewDetailsCopy(($("#editCopiedTac").text()).split(",")[0], "copy");
    }else{
		//alert("2");
		//$("#editTac").text(data.content[0].deviceId);
    	$("#editTac").text('');
    	$("#editTac").text(tacs);
    	//$("#editId").text($("#editCopiedId").text());
    }
    
    $('#editManufacturerCountry').prop('disabled', false);
    $("#editManufacturerCountry").css('display', 'block');
  }
  //Action == 'Multiedit' ? $("#editTac").text(deviceId) : $("#editTac").text(data.content[0].deviceId);
  if (Action == 'copy') {
    //console.log("inside if with Action = "+Action+" and Copied TAC " +$("#editCopiedTac").text());
    $("#editTac").text('');
    $("#editTac").text($("#editCopiedTac").text());
    $("#editId").text($("#editCopiedId").text());
    
    viewDetailsCopy(($("#editCopiedTac").text()).split(",")[0], "copy");
    
    
    
    $('#updateButton').attr('onclick', "updateDeviceDetails('copy')");
  }
  $("#editManufacturingAddress").val(data.content[0].manufacturingLocation);
   //Handling for checkbox starts
  $('input:checkbox').removeAttr('checked');
  data.content[0].networkTechnologyGSM == 1 ? $('input[id=editGSMCheck]').prop('checked', true) : $('input[id=editGSMCheck]').prop('checked', false);
  data.content[0].networkTechnologyCDMA == 1 ? $('input[id=editCDMACheck]').prop('checked', true) : $('input[id=editCDMACheck]').prop('checked', false);
  data.content[0].networkTechnologyEVDO == 1 ? $('input[id=editEVDOCheck]').prop('checked', true) : $('input[id=editEVDOCheck]').prop('checked', false);
  data.content[0].networkTechnologyLTE == 1 ? $('input[id=editLTECheck]').prop('checked', true) : $('input[id=editLTECheck]').prop('checked', false);
  data.content[0].networkTechnology5G == 1 ? $('input[id=edit5GCheck]').prop('checked', true) : $('input[id=edit5GCheck]').prop('checked', false);
  //Handling for checkbox End
  //Network
  $("#edit2GBand").val(data.content[0].network2GBand);
  $("#edit3GBand").val(data.content[0].network3GBand);
  $("#edit4GBand").val(data.content[0].network4GBand);
  $("#edit5GBand").val(data.content[0].network5GBand);
  $("#editNetworkSpeed").val(data.content[0].networkSpeed);
  $("#editBrandDetails").val(data.content[0].bandDetail);
  
  
  $("#editnetworkSpecificIdentifier").val(data.content[0].networkSpecificIdentifier);
  //Launch
  var announceDate = data.content[0].announceDate;
  if (announceDate != null) {
    //console.log("announceDate is  " +announceDate);
    announceDate = announceDate.split(' ')[0];
    //console.log("announceDate is AFTER SPLIT " +announceDate);
    $("#editAnnounceDate").val(announceDate);
  }
  var launchDate = data.content[0].launchDate;
  if (launchDate != null) {
    launchDate = launchDate.split(' ')[0];
    $("#editLaunchdate").val(launchDate);
  }
  $("#editDeviceStatus").val(data.content[0].deviceStatus);
    var discontinueDate = data.content[0].discontinueDate;
  if (discontinueDate != null) {
    discontinueDate = discontinueDate.split(' ')[0];
    $("#editDiscontinuedDate").val(discontinueDate);
  }
  $("#editSimSlots").val(data.content[0].simSlot);
  $("#editnumberofIMEI").val(data.content[0].imeiQuantity);
  $("#editSimtype").val(data.content[0].simType);
  $("#editDimension").val(data.content[0].bodyDimension);
  $("#editBodyweight").val(data.content[0].bodyWeight);
  $("#editSimSupport").val(data.content[0].esimSupport);
  $("#editSoftSimSupport").val(data.content[0].softsimSupport);
  $("#edittype").val(data.content[0].displayType);
  $("#editSize").val(data.content[0].displaySize);
  $("#editResolution").val(data.content[0].displayResolution);
  $("#editProtection").val(data.content[0].displayProtection);
  $("#editOs").val(data.content[0].os);
  $("#editOSversion").val(data.content[0].osBaseVersion);
  $("#editInternalMemory").val(data.content[0].memoryInternal);
  $("#editRAM").val(data.content[0].ram);
  $("#editMemoryCardSlot").val(data.content[0].memoryCardSlot);
  $("#editCPU").val(data.content[0].platformCPU);
  $("#editGPU").val(data.content[0].platformGPU);
  $("#editTriple").val(data.content[0].mainCameraType);
  $("#editMainCameraSpecs").val(data.content[0].mainCameraSpec);
  $("#editMainCameraFeature").val(data.content[0].mainCameraFeature);
  $("#editMainCameraVideo").val(data.content[0].mainCameraVideo);
  $("#editSelfieCameratype").val(data.content[0].selfieCameraType);
  $("#editSelfieCameraSpecs").val(data.content[0].selfieCameraSpec);
  $("#editSelfieCameraFeature").val(data.content[0].selfieCameraFeature);
  $("#editSelfieCameraVideo").val(data.content[0].selfieCameraVideo);
  $("#editLoudspeaker").val(data.content[0].soundLoudspeaker);
  $("#editSoundJack").val(data.content[0].sound35mmJack);
  $("#editWLANSupport").val(data.content[0].commsWLAN);
  $("#editBluetoothSupport").val(data.content[0].commsBluetooth);
  $("#editGPSsupport").val(data.content[0].commsGPS);
  $("#editUSBSupport").val(data.content[0].commsUSB);
  $("#editRadioSupport").val(data.content[0].commsRadio);
  $("#editNFCSupport").val(data.content[0].commsNFC);
  $("#editSensors").val(data.content[0].sensor);
  $("#editDeviceColor").val(data.content[0].colors);
  $("#editUICC").val(data.content[0].removableUICC);
  $("#editEUICC").val(data.content[0].removableEUICC);
  $("#editBatteryCapacity").val(data.content[0].batteryCapacity);
  $("#editBatteryChargingSupport").val(data.content[0].batteryCharging);
  $("#editAsia").val(data.content[0].launchPriceAsianMarket);
  $("#editUS").val(data.content[0].launchPriceUSMarket);
  $("#editEurope").val(data.content[0].launchPriceEuropeMarket);
  $("#editInternational").val(data.content[0].launchPriceInternationalMarket);
  $("#editlaunchPriceCambodia").val(data.content[0].launchPriceCambodiaMarket);
  $("#editsourcePriceCambodia").val(data.content[0].sourceOfCambodiaMarketPrice) == "" ? $("#editsourcePriceCambodia").val("0") : $("#editsourcePriceCambodia").val(data.content[0].sourceOfCambodiaMarketPrice);
  $("#editcustomPrice").val(data.content[0].customPriceOfDevice);
  $("#editGlobalReportedIssue").val(data.content[0].reportedGlobalIssue);
  $("#editLocalReportedIssue").val(data.content[0].reportedLocalIssue);
  $("#editRemarks").val(data.content[0].remark);
  
  // Start TRC
 /* var trcAppDate = data.content[0].trcApprovalDate;
  if (trcAppDate != null) {
    trcAppDate = trcAppDate.split(" ")[0];
    $("#editTrcApprovalDate").val(trcAppDate);
  }else{
		$("#editTrcApprovalDate").text(" ");
		$("#editTrcApprovalDate").hide();
	}
  
  $("#editTrcTypeApprovedBy").val(data.content[0].trcTypeApprovedBy);
  $("#editManufacturerCountry").val(data.content[0].manufacturerCountry);
  //$("#editIsTypeApproved").val(data.content[0].isTypeApproved);
  if(data.content[0].isTypeApproved==0){
		$("#editIsTypeApproved").val("false");
	}else{
		$("#editIsTypeApproved").val("true");
	}
  
  $("#edittrcApprovedStatus").val(data.content[0].trcApprovedStatus);
  */
   // End  TRC
   
  //previewRegistrtionFile(data.content[0].attachedFiles);
  //console.log("Attatched Files Details " +data.content[0].attachedFiles);
  Action == 'copy' ? previewRegistrtionFile(data.content[0].attachedFiles, 'copy') : previewRegistrtionFile(data.content[0].attachedFiles, 'Edit')
}

$('#copyFromfilterMarketingName').keyup(function() {
     var inputText = $(this).val();
     searchDetails('filterCopyFrom',inputText);
});

function searchDetails(Action,inputText) {
  //alert("searchDetails..");
  $('div#initialloader').fadeIn('fast');
  //console.log("Action rcieved " + Action);

  var tac;
  var brandName;
  var modelName;


  //Action == 'filterCopyFrom' ? brandName = $('#selectedBrandName').text() : brandName = $('#copyFromBrandName').val();
if(Action == 'filterCopyFrom'){
    tac = $('#selectedTac').text();
    brandName = $('#selectedBrandName').text()
    modelName =  $('#selectedModelName').text();
}else{
    tac = $('#copyFromTac').val();
    brandName = $('#copyFromBrandName').val();
    modelName = $('#copyFromMarketingName').val();
};

  //console.log("tac" + tac);
  //console.log("brand Name " + brandName);
  //console.log("model Name " + modelName);

  $('#selectedTac').text(tac);
  $('#selectedBrandName').text(brandName);
  $('#selectedModelName').text(modelName);



  //console.log($('#selectedBrandName').text());

  var marketingName=inputText;
  //console.log("marketingName " +marketingName );

  var filterRequest = {
    "brandName": brandName,
    "deviceId": tac,
    "modelName": modelName,
    "marketingName" : marketingName,
    "featureId": parseInt(featureId),
    "userId": parseInt($("body").attr("data-userID")),
    "userType": $("body").attr("data-roleType"),
    //"userType" : parseInt($("body").attr("data-userTypeID")),
    "userTypeId": parseInt($("body").attr("data-userTypeID"))
  }
  //console.log(JSON.stringify(filterRequest));
  
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: 'headers?type=deviceManagementHeaders&lang=' + lang,
    type: 'POST',
    dataType: "json",
    success: function(result) {
      var table = $("#copyDetailTable").DataTable({
        destroy: true,
        "serverSide": true,
        orderCellsTop: true,
        "ordering": true,
        "bPaginate": true,
        "bFilter": false,
        "bInfo": true,
        "bSearchable": true,
        "language": {
                                          "sEmptyTable": "No records found in the system",
                                          "infoFiltered": ""
                              },
        "aaSorting": [],
        columnDefs: [{
          orderable: false,
          targets: -1,
          "sPaginationType": "full_numbers"
        }],
        initComplete: function() {
          $('.dataTables_filter input').off().on('keyup', function(event) {
            if (event.keyCode === 13) {
              table.search(this.value.trim(), false, false).draw();
            }
          });
        },
        ajax: {
          url: 'deviceManagementData?requestType=copyfrom',
          type: 'POST',
          dataType: "json",
          data: function(d) {
            d.filter = JSON.stringify(filterRequest);
            document.getElementById("copyform-serach-box").reset();
            //alert("in success function");
          },
          error: function(jqXHR, textStatus, errorThrown, data) {
            window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
            // messageWindow(jqXHR['responseJSON']['message']);
            window.parent.$('#500ErrorModal').openModal({
              dismissible: false
            });
          }
        },
        "columns": result
      });
      $('div#initialloader').delay(300).fadeOut('slow');
    },
    error: function(jqXHR, textStatus, errorThrown) {}
  });
  //'copy From'
}

function backButton() {
  $("#filterform").show();
  $("#dataTableDiv").show();
  $("#multiEditDiv").show();
  $("#filterButtonDiv").show();
  $("#addDeviceBtn").show();
  $("#LibraryTableDiv").css("display", "block");
  $("#historyTableDiv").css("display", "none");
  $("#pageHeaderTitle").text('');
  $("#pageHeaderTitle").text(elem);
  //$("#historyFilterform").css("display", "block");
  //$("#historydataTableDiv").css("display", "block");
  $("#historydataTableDiv").hide();
  $("#historyfilterButtonDiv").hide();
  $("#backBtn").hide();
  //pageRendering(null,null);
  DeviceDataTable(lang, null, null);
}

function viewHistory(deviceId) {
  pageRendering('viewHistory', deviceId);
  DeviceDataTable(null, null, 'viewHistory', deviceId);
}

function viewHistoryDatatable(Url, dataUrl, deviceId) {
  //console.log("deviceId recieved for history " +deviceId);
  //console.log("Url-------" +Url+"  dataUrl--------"+dataUrl+" deviceId----------"+deviceId);
  //var tac = $("#historyFilterTac").val()==='' ?  deviceId : $("#historyFilterTac").val();
  $('div#initialloader').fadeIn('fast');
  var tac = deviceId;
  var filterRequest = {
    "createdOn": $('#historyStartDate').val(),
    "modifiedOn": $('#historyEndDate').val(),
    "deviceId": tac,
    "deviceType": $('#historyfilterDeviceType').val(),
    "brandName": $('#historyFilterBrandName').val(),
    "marketingName": $('#historyfilterMarketingName').val(),
    "modelName": $('#historyFilterModelName').val(),
    "userDisplayName": $('#historyFilterAgentName').val(),
    "mdrStatus": $('#historyFilterStatus').val(),
    "featureId": parseInt(featureId),
    "userId": parseInt($("body").attr("data-userID")),
    //"userId": parseInt($('#historyFilterAgentName').val()),
    "userType": $("body").attr("data-roleType"),
    //"userType" : parseInt($("body").attr("data-userTypeID")),
    "userTypeId": parseInt($("body").attr("data-userTypeID"))
  }
  //console.log(JSON.stringify(filterRequest));
 
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: Url,
    type: 'POST',
    dataType: "json",
    success: function(result) {
      var table = $("#data-table-history").DataTable({
        destroy: true,
        "serverSide": true,
        orderCellsTop: true,
        "ordering": true,
        "bPaginate": true,
        "bFilter": false,
        "bInfo": true,
        "bSearchable": true,
        "language": {
                                          "sEmptyTable": "No records found in the system",
                                          "infoFiltered": ""
                              },
        "aaSorting": [],
        columnDefs: [{
          orderable: false,
          targets: -1
        }],
        initComplete: function() {
          $('.dataTables_filter input').off().on('keyup', function(event) {
            if (event.keyCode === 13) {
              table.search(this.value.trim(), false, false).draw();
            }
          });
        },
        ajax: {
          url: dataUrl,
          type: 'POST',
          dataType: "json",
          async: false,
          data: function(d) {
			d.filter = JSON.stringify(filterRequest);
            $("#LibraryTableDiv").css("display", "none");
            $("#historyTableDiv").css("display", "block");
           },
          error: function(jqXHR, textStatus, errorThrown, data) {
            window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
            // messageWindow(jqXHR['responseJSON']['message']);
            window.parent.$('#500ErrorModal').openModal({
              dismissible: false
            });
          }
        },
        "columns": result
      });
    }
  });
   $('div#initialloader').delay(300).fadeOut('slow');
}

function updateDeviceConfirmation() {
  return false;
}

function closeEditPage() {
  //$("#datatableViewDiv").css("display", "block");
  $("#mobileDetailViewDiv").css("display", "block");
  $("#mobileDetailEditDiv").css("display", "none");
}

function closeAddPage() {
  $("#addMobileDetailDiv").css("display", "none");
  $("#datatableViewDiv").css("display", "block");
  Resetfilter('addDeviceForm', null);
  $("#docTypeFile1").attr("disabled", false);
  $("#docTypeFileSave").attr("disabled", false);
  //Reset Tab
  $('#addMobileDetailDiv ul li a').each(function() {
    $("#addMobileDetailDiv ul li a").removeAttr('class');
  });
  $('#addMobileDetailDiv ul li a:first').addClass('active');
  $('#addMobileDetailDiv .tab-content [id^=tabadd]').removeClass('active show');
  $('#addMobileDetailDiv .tab-content :first').addClass('active show');
  //Reset image
  $('[id^=mainFrameSave]').attr("src", './resources/assets/images/NoImage.jpg');
  idCount1=0;
  //enableAndDisableUploadButton(idCount1, "docTypeFileSave");
}

var idCount1;
function addDeviceDetails() {

  var fieldList = [];
  $("#addManufacturer").val()=="" ? fieldList.push("Manufacturer") : $("#addManufacturer").val();
  $("#addBrand").val()=="" ? fieldList.push ("Brand Name") : $("#addBrand").val();
  $("#addModel").val()=="" ? fieldList.push ("Model Name") : $("#addModel").val();
  $("#addDeviceType").val()==0 ? fieldList.push ("Device Type") : $("#addDeviceType").val();
  $("#addOem").val()=="" ? fieldList.push ("OEM") : $("#addOem").val();
  $("#addOrganizationID").val()=="" ? fieldList.push ("Organization ID") : $("#addOrganizationID").val();
  $("#addDeviceIDAllocationDate").val()=="" ? fieldList.push ("Device ID Allocation Date") : $("#addDeviceIDAllocationDate").val();
  //console.log("fieldList updated is  "+fieldList +" and length"+fieldList.length);

  if(fieldList.length !=0){
  		for (var i = 0; i < fieldList.length; i++) {
   		//console.log("field values---" +fieldList[i]);
   		$("#errorFieldList").append("<ul><li>"+fieldList[i]+"</li></ul>");
  		 };
  	 	$("#fieldValidationMsg").css("display", "block");
  	 	$("#errorFieldList").css("display", "block");
    		 $("#saveDeviceButton").addClass('disabled');
  	} else {
  $('div#initialloader').fadeIn('fast');
  var fileInfo = [];
  var formData = new FormData();
  var x;
  //Handling for checkbox
  var networkTechnologyGSM = $('#addGSMCheck').is(':checked') == true ? 1 : 0;
  var networkTechnologyCDMA = $('#addCDMACheck').is(':checked') == true ? 1 : 0;
  var networkTechnologyEVDO = $('#addEVDOCheck').is(':checked') == true ? 1 : 0;
  var networkTechnologyLTE = $('#addLTECheck').is(':checked') == true ? 1 : 0;
  var networkTechnology5G = $('#add5GCheck').is(':checked') == true ? 1 : 0;
  //var networkTechnology6G = $('#add6GCheck').is(':checked') == true ? 1 : 0;
  //var networkTechnology7G = $('#add7GCheck').is(':checked') == true ? 1 : 0;
  //var multiRequest = [];
  //var deviceRequest;
  //var deviceIds = [];
  //var rowIds = [];
  fileInfo = [];
  var attachedFiles = [];
  var temp;
  for (var j = 1; j <= 5; j++) {
    //console.log("j is ------" + j);
    //console.log("document.getElementById---- " + document.getElementById("mainFrameSaveInput" + j));
    temp = document.getElementById("mainFrameSaveInput" + j);
    //console.log("temp updated-" + temp);
    //console.log("document.getElementById('mainFrameSaveInput' + j).files.length--" + document.getElementById("mainFrameSaveInput" + j).files.length);
    if (document.getElementById("mainFrameSaveInput" + j).files.length == 0) {
      continue;
    }
    temp = temp.files.item(0);
    x = {
      //"docTypeInterp": "MDR",
      //"id": parseInt($("#editId").text()),
      "docType": "MDR",
      //"mdrId": parseInt(rowIds[i]),
      //"url": "",
      "fileName": temp.name
    }
    fileInfo.push(x);
    //console.log("x is-------" + JSON.stringify(x));
    attachedFiles.push(x);
    formData.append('files[]', temp);
  }
  
 var multiRequest = {
    //Basic Parameters
    //"id": parseInt(rowIds[i]),
    "deviceState" : $('#completeCheckBox').is(":checked") == true ? deviceState=3 : deviceState=0,
    "deviceId": $("#addTac").val(),
    "featureId": parseInt(featureId),
    "userId": parseInt($("body").attr("data-userID")),
    //"userType" : $("body").attr("data-roleType"),
    "userType": parseInt($("body").attr("data-userTypeID")),
    "userTypeId": parseInt($("body").attr("data-userTypeID")),
    //headers
    "marketingName": $("#addMarketingName").val(),
    "manufacturer": $("#addManufacturer").val(),
    "manufacturingLocation": $("#addManufacturingAddress").val(),
    "modelName": $("#addModel").val(),
    "brandName": $("#addBrand").val(),
    //checkboxes
    "networkTechnologyGSM": networkTechnologyGSM,
    "networkTechnologyCDMA": networkTechnologyCDMA,
    "networkTechnologyEVDO": networkTechnologyEVDO,
    "networkTechnologyLTE": networkTechnologyLTE,
    "networkTechnology5G": networkTechnology5G,
    //"networkTechnology6G": networkTechnology6G,
    //"networkTechnology7G": networkTechnology7G,
    //Network
    "network2GBand": $("#add2GBand").val(),
    "network3GBand": $("#add3GBand").val(),
    "network4GBand": $("#add4GBand").val(),
    "network5GBand": $("#add5GBand").val(),
    "networkSpeed": $("#addNetworkSpeed").val(),
    "bandDetail": $("#addBrandDetails").val(),
    //New Field
    "deviceType": $("#addDeviceType").val(),
    //"networkSpecificIdentifier": parseInt($("#addNetworkSpeceficIdentifier").val()),
    "networkSpecificIdentifier": parseInt($("#addNetworkSpeceficIdentifier").val()) == '' ? 0 : parseInt($("#addNetworkSpeceficIdentifier").val()),
     //"networkSpecificIdentifier":0,
    //Launch
    "announceDate": $("#addAnnounceDate").val() == '' ? null : $("#addAnnounceDate").val() + " 00:00:00",
    "launchDate": $("#addLaunchdate").val() == '' ? null : $("#addLaunchdate").val() + " 00:00:00",
    "deviceStatus": $("#addDeviceStatus").val(),
    "oem": $("#addOem").val(),
    "organizationId": $("#addOrganizationID").val(),
    "allocationDate": $("#addDeviceIDAllocationDate").val() == '' ? null : $("#addDeviceIDAllocationDate").val() + " 00:00:00",
    "discontinueDate": $("#addDiscontinuedDate").val() == '' ? null : $("#addDiscontinuedDate").val() + " 00:00:00",
    //Body
    "simSlot": parseInt($("#addSimSlots").val()) == '' ? 0 : parseInt($("#addSimSlots").val()),
    "imeiQuantity": parseInt($("#addnumberofIMEI").val()) == '' ? 0 : parseInt($("#addnumberofIMEI").val()),
    "simType": $("#addSimtype").val(),
    "bodyDimension": $("#addDimension").val(),
    "bodyWeight": $("#addBodyweight").val(),
    
    //"esimSupport": $("#addSimSupport").val(),
    //"softsimSupport": $("#addSoftSimSupport").val(),
    
     "esimSupport": parseInt($("#addSimSupport").val()) == '' ? 0 : parseInt($("#addSimSupport").val()),
      "softsimSupport": parseInt($("#addSoftSimSupport").val()) == '' ? 0 : parseInt($("#addSoftSimSupport").val()),
    
    //Display
    "displayType": $("#addtype").val(),
    "displaySize": $("#addSize").val(),
    "displayResolution": $("#addResolution").val(),
    "displayProtection": $("#addProtection").val(),
    //Platform
    "os": $("#addOs").val(),
    "osBaseVersion": $("#addOSversion").val(),
    "memoryInternal": parseInt($("#addInternalMemory").val()) == '' ? 0 : parseInt($("#addInternalMemory").val()),
    "ram": $("#addRAM").val(),
    "memoryCardSlot": parseInt($("#addMemoryCardSlot").val()) == '' ? 0 : parseInt($("#addMemoryCardSlot").val()),
    "platformCPU": $("#addCPU").val(),
    "platformGPU": $("#addGPU").val(),
    //Camera
    "mainCameraType": parseInt($("#addTriple").val()),
    "mainCameraSpec": $("#addMainCameraSpecs").val(),
    "mainCameraFeature": $("#addMainCameraFeature").val(),
    "mainCameraVideo": $("#addMainCameraVideo").val(),
    "selfieCameraType": parseInt($("#addSelfieCameratype").val()),
    "selfieCameraSpec": $("#addSelfieCameraSpecs").val(),
    "selfieCameraFeature": $("#addSelfieCameraFeature").val(),
    "selfieCameraVideo": $("#addSelfieCameraVideo").val(),
    //Sound
    "soundLoudspeaker": parseInt($("#addLoudspeaker").val()),
    "sound35mmJack": parseInt($("#addSoundJack").val()),
    //Comm
    "commsWLAN": $("#addWLANSupport").val(),
    "commsBluetooth": $("#addBluetoothSupport").val(),
    "commsGPS": $("#addGPSsupport").val(),
    "commsUSB": $("#addUSBSupport").val(),
    "commsRadio": parseInt($("#addRadioSupport").val()),
    "commsNFC": parseInt($("#addNFCSupport").val()),
    //Misc
    "sensor": $("#addSensors").val(),
    "colors": $("#addDeviceColor").val(),
    "removableUICC": parseInt($("#addUICC").val()) == '' ? 0 : parseInt($("#addUICC").val()),
    "removableEUICC": parseInt($("#addEUICC").val()) == '' ? 0 : parseInt($("#addEUICC").val()),
    "batteryCapacity": parseInt($("#addBatteryCapacity").val()) == '' ? 0 : parseInt($("#addBatteryCapacity").val()),
    "batteryCharging": $("#addBatteryChargingSupport").val(),
    //Price
    "launchPriceAsianMarket": $("#addAsia").val() == '' ? 0 : parseFloat($("#addAsia").val()),
    "launchPriceUSMarket": $("#addUS").val() == '' ? 0 : parseFloat($("#addUS").val()),
    "launchPriceEuropeMarket": $("#addEurope").val() == '' ? 0 : parseFloat($("#addEurope").val()),
    "launchPriceInternationalMarket": $("#addInternational").val() == '' ? 0 : parseFloat($("#addInternational").val()),
    "launchPriceCambodiaMarket": $("#addlaunchPriceCambodia").val() == '' ? 0 : parseFloat($("#addlaunchPriceCambodia").val()),
    "customPriceOfDevice": $("#addcustomPrice").val() == '' ? 0 : parseFloat($("#addlaunchPriceCambodia").val()),
    "sourceOfCambodiaMarketPrice": $("#addsourcePriceCambodia").val() == '' ? 0 : parseFloat($("#addsourcePriceCambodia").val()),
    //Issues
    "reportedGlobalIssue": $("#addGlobalReportedIssue").val(),
    "reportedLocalIssue": $("#addLocalReportedIssue").val(),
    "remark": $("#addRemarks").val(),
    //attached Files
    "attachedFiles": fileInfo
  }
  formData.append('fileInfo[]', JSON.stringify(fileInfo));
  formData.append("multirequest", JSON.stringify(multiRequest));
  //formData.append('deviceId', $("#editTac").text());
  //formData.append('id', parseInt($("#editId").text()));
  //formData.append('files[]', JSON.stringify(fileInfo));
  //console.log(JSON.stringify(multiRequest));
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: './addDeviceDetails',
    type: 'POST',
    data: formData,
    mimeType: 'multipart/form-data',
    processData: false,
    contentType: false,
    async: false,
    success: function(response, textStatus, jqXHR) {
      //console.log(JSON.stringify(response));
      var data = JSON.parse(response);
      //console.log("data - "+ data);
      //console.log("data.errorCode " +data.errorCode);
      $('#AddconfirmationModal').closeModal({
    	dismissible: false
  	});
  	$("#addMobileDetailDiv").css("display", "none");
    $("#datatableViewDiv").css("display", "block");
      Resetfilter('addDeviceForm', null);
      $('[id^=mainFrameSave]').attr("src", './resources/assets/images/NoImage.jpg');
      idCount1=0;
  	  DeviceDataTable(lang, null, null, null);
  	  //console.log("data.errorCode " +data.errorCode);
  	  if(data.errorCode === '500'){
  	    $('#saveFailedConfirmationMessage').openModal({
                                        	dismissible: false
                                      	  });
                                       setTimeout(function() {
                                       $('#saveFailedConfirmationMessage').closeModal({
                                        	dismissible: false
                                      	  });
                                    	}, 3000);

    }else{
        $('#saveConfirmationMessage').openModal({
                           	dismissible: false
                         	  });
                          setTimeout(function() {
                          $('#saveConfirmationMessage').closeModal({
                           	dismissible: false
                         	  });
                       	}, 3000);
  	  }

      //$("#mobileDetailEditDiv").css("display", "block");
      //alert("inside save success function" +JSON.stringify(response));
    },
    error: function(jqXHR, textStatus, errorThrown) {
      //console.log("error in ajax")
    }
  });
  $('div#initialloader').delay(300).fadeOut('slow');
  return false;
};
};

function updateDeviceDetails(updateSource) {
  //	$('div#initialloader').fadeIn('fast');
  var fileInfo = [];
  var fieldId = 1;
  var formData = new FormData();
  var x;
  //Handling for checkbox
  var networkTechnologyGSM = $('#editGSMCheck').is(':checked') == true ? 1 : 0;
  var networkTechnologyCDMA = $('#editCDMACheck').is(':checked') == true ? 1 : 0;
  var networkTechnologyEVDO = $('#editEVDOCheck').is(':checked') == true ? 1 : 0;
  var networkTechnologyLTE = $('#editLTECheck').is(':checked') == true ? 1 : 0;
  var networkTechnology5G = $('#edit5GCheck').is(':checked') == true ? 1 : 0;
  var multiRequest = [];
  var deviceRequest;
  var deviceIds = [];
  var rowIds = [];
  //console.log("multiEditCount is " + multiEditCount);
  if (multiEditCount == 0) {
    multiEditCount = 1;
    deviceIds.push($("#editTac").text().trim());
    //deviceIds.push($("#editTac").text().trim().substring(0, str.length-3));
    rowIds.push($("#editId").text().trim());
  } else {
    if ($("#editTac").text().includes('...') == true) {
      var multiDeviceId = $("#editTac").text(document.getElementById('editTac').getAttribute('data-title'));
          multiDeviceId = $("#editTac").text().replace("...", "");
      deviceIds = multiDeviceId.trim().split(',');
      //console.log("deviceIds-----" +deviceIds);
      rowIds = $("#editId").text().trim().split(',');
      //console.log("includes('...')==true");
      //console.log("rowIds2 ---------" +rowIds+"  and deviceIds2-----" +deviceIds);
    } else {
      deviceIds = $("#editTac").text().trim().split(',');
      rowIds = $("#editId").text().trim().split(',');
      //console.log("includes('...')==false");
    }
  }
  for (i = 0; i < multiEditCount; i++) {
    fileInfo = [];
    //var elements = document.getElementsByClassName("subImageClass");
    ////console.log("elements.length --- " +elements.length);
    var attachedFiles = [];
    var temp;
    for (var j = 1; j <= 5; j++) {
      //temp = $("#mainFrameEditInput" + j).files.item[0];
      ////console.log("j is ------" + j);
      ////console.log("document.getElementById---- " + document.getElementById("mainFrameEditInput" + j));
      ////console.log("document by jquery---- " + $("#mainFrameEditInput" + j).prop("files")[0]);
      temp = document.getElementById("mainFrameEditInput" + j);
      //console.log("temp updated-" + temp);
      //console.log("document.getElementById('mainFrameEditInput' + j).files.length--" + document.getElementById("mainFrameEditInput" + j).files.length);
      //if (temp.files === null || temp.files === undefined ) {
      //	continue;
      //}
      
      const imgId = $("#mainFrameEdit" + j).attr("img-id");
      //console.log('image id:', $("#mainFrameEdit" + j).attr("img-id"));
      
      
      if (document.getElementById("mainFrameEditInput" + j).files.length == 0 && (imgId==null || imgId==undefined ) ) {
        continue;
      }
      temp = temp.files.item(0);
      
      x = {
		"docType": "MDR",
        "mdrId": parseInt(rowIds[i]),
	  };
      
      //console.log("temp----"+temp);
      if(temp!=null || temp!=undefined){
		x.fileName=temp.name;
	  };
      
      
      //document.getElementById(imgTagID).setAttribute('src', 'https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png');
      
      
     
      
      if (updateSource == 'simpleEdit') {
        if (!isNaN(imgId)) {
          x.id = parseInt(imgId);
        }
      }
      fileInfo.push(x);
      //console.log("x is-------" + JSON.stringify(x));
      attachedFiles.push(x);
      formData.append('files[]', temp);
    }
    deviceRequest = {
      //Basic Parameters
      "deviceState" : $('#completeCheckBoxEdit').is(":checked") == true ? deviceState=3 : deviceState=1,
      "id": parseInt(rowIds[i]),
      "deviceId": deviceIds[i],
      "featureId": parseInt(featureId),
      "userId": parseInt($("body").attr("data-userID")),
      //"userType" : $("body").attr("data-roleType"),
      "userType": parseInt($("body").attr("data-userTypeID")),
      "userTypeId": parseInt($("body").attr("data-userTypeID")),
      //headers
      "marketingName": $("#editMarketingName").val(),
      "manufacturer": $("#editManufacturer").val(),
      "manufacturingLocation": $("#editManufacturingAddress").val(),
      "modelName": $("#editModel").val(),
      "brandName": $("#editBrand").val(),
      //checkboxes
      "networkTechnologyGSM": networkTechnologyGSM,
      "networkTechnologyCDMA": networkTechnologyCDMA,
      "networkTechnologyEVDO": networkTechnologyEVDO,
      "networkTechnologyLTE": networkTechnologyLTE,
      "networkTechnology5G": networkTechnology5G,
      //Network
      "network2GBand": $("#edit2GBand").val(),
      "network3GBand": $("#edit3GBand").val(),
      "network4GBand": $("#edit4GBand").val(),
      "network5GBand": $("#edit5GBand").val(),
      "networkSpeed": $("#editNetworkSpeed").val(),
      "bandDetail": $("#editBrandDetails").val(),
      //New Field
      "deviceType": $("#editDeviceType").val(),
      "networkSpecificIdentifier": parseInt($("#editnetworkSpecificIdentifier").val()),
      //Launch
      "announceDate": $("#editAnnounceDate").val() == '' ? null : $("#editAnnounceDate").val() + " 00:00:00",
      "launchDate": $("#editLaunchdate").val() == '' ? null : $("#editLaunchdate").val() + " 00:00:00",
      "deviceStatus": $("#editDeviceStatus").val(),
      "oem": $("#editOem").val(),
      "organizationId": $("#editOrganizationID").val(),
      "allocationDate": $("#editDeviceIDAllocationDate").val() == '' ? null : $("#editDeviceIDAllocationDate").val() + " 00:00:00",
      "discontinueDate": $("#editDiscontinuedDate").val() == '' ? null : $("#editDiscontinuedDate").val() + " 00:00:00",
      //Body
      "simSlot": parseInt($("#editSimSlots").val()) == '' ? 0 : parseInt($("#editSimSlots").val()),
      "imeiQuantity": parseInt($("#editnumberofIMEI").val()) == '' ? 0 : parseInt($("#editnumberofIMEI").val()),
      "simType": $("#editSimtype").val(),
      "bodyDimension": $("#editDimension").val(),
      "bodyWeight": $("#editBodyweight").val(),
      "esimSupport": $("#editSimSupport").val(),
      "softsimSupport": $("#editSoftSimSupport").val(),
      //Display
      "displayType": $("#edittype").val(),
      "displaySize": $("#editSize").val(),
      "displayResolution": $("#editResolution").val(),
      "displayProtection": $("#editProtection").val(),
      //Platform
      "os": $("#editOs").val(),
      "osBaseVersion": $("#editOSversion").val(),
      "memoryInternal": parseInt($("#editInternalMemory").val()) == '' ? 0 : parseInt($("#editInternalMemory").val()),
      "ram": parseInt($("#editRAM").val()) == '' ? 0 : parseInt($("#editRAM").val()),
      "memoryCardSlot": parseInt($("#editMemoryCardSlot").val()) == '' ? 0 : parseInt($("#editMemoryCardSlot").val()),
      "platformCPU": $("#editCPU").val(),
      "platformGPU": $("#editGPU").val(),
      //Camera
      "mainCameraType": parseInt($("#editTriple").val()),
      "mainCameraSpec": $("#editMainCameraSpecs").val(),
      "mainCameraFeature": $("#editMainCameraFeature").val(),
      "mainCameraVideo": $("#editMainCameraVideo").val(),
      "selfieCameraType": parseInt($("#editSelfieCameratype").val()),
      "selfieCameraSpec": $("#editSelfieCameraSpecs").val(),
      "selfieCameraFeature": $("#editSelfieCameraFeature").val(),
      "selfieCameraVideo": $("#editSelfieCameraVideo").val(),
      //Sound
      "soundLoudspeaker": parseInt($("#editLoudspeaker").val()),
      "sound35mmJack": parseInt($("#editSoundJack").val()),
      //Comm
      "commsWLAN": $("#editWLANSupport").val(),
      "commsBluetooth": $("#editBluetoothSupport").val(),
      "commsGPS": $("#editGPSsupport").val(),
      "commsUSB": $("#editUSBSupport").val(),
      "commsRadio": parseInt($("#editRadioSupport").val()),
      "commsNFC": parseInt($("#editNFCSupport").val()),
      //Misc
      "sensor": $("#editSensors").val(),
      "colors": $("#editDeviceColor").val(),
      "removableUICC": parseInt($("#editUICC").val()) == '' ? 0 : parseInt($("#editUICC").val()),
      "removableEUICC": parseInt($("#editEUICC").val()) == '' ? 0 : parseInt($("#editEUICC").val()),
      "batteryCapacity": parseInt($("#editBatteryCapacity").val()) == '' ? 0 : parseInt($("#editBatteryCapacity").val()),
      "batteryCharging": $("#editBatteryChargingSupport").val(),
      //Price
      "launchPriceAsianMarket": parseInt($("#editAsia").val()) == '' ? 0 : parseInt($("#editAsia").val()),
      "launchPriceUSMarket": parseInt($("#editUS").val()) == '' ? 0 : $("#editUS").val(),
      "launchPriceEuropeMarket": parseInt($("#editEurope").val()) == '' ? 0 : parseInt($("#editEurope").val()),
      "launchPriceInternationalMarket": parseInt($("#editInternational").val()) == '' ? 0 : parseInt($("#editInternational").val()),
      "launchPriceCambodiaMarket": parseInt($("#editlaunchPriceCambodia").val()) == '' ? 0 : parseInt($("#editlaunchPriceCambodia").val()),
      "customPriceOfDevice": parseInt($("#editcustomPrice").val()) == '' ? 0 : parseInt($("#editlaunchPriceCambodia").val()),
      "sourceOfCambodiaMarketPrice": parseInt($("#editsourcePriceCambodia").val()) == '' ? 0 : parseInt($("#editsourcePriceCambodia").val()),
      //Issues
      "reportedGlobalIssue": $("#editGlobalReportedIssue").val(),
      "reportedLocalIssue": $("#editLocalReportedIssue").val(),
      "remark": $("#editRemarks").val(),
      
      "manufacturerCountry": $("#editManufacturerCountry").val(),
      
      //attached Files
      "attachedFiles": attachedFiles
    }
    multiRequest.push(deviceRequest);
  }
  formData.append('fileInfo[]', JSON.stringify(fileInfo));
  formData.append("multirequest", JSON.stringify(multiRequest));
  //formData.append('deviceId', $("#editTac").text());
  formData.append('id', parseInt($("#editId").text()));
  //console.log("files[]--" + JSON.stringify($('#mainFrameEditInput1')[0].files[0]));
  //formData.append('files[]', $('#mainFrameEditInput1')[0].files[0]);
  //formData.append('files[]',$('#docTypeFile1')[0].files[0]);
  console.log("JSON.stringify(fileInfo)--" + JSON.stringify(fileInfo));
  //console.log("formData --- " +JSON.stringify(formData));
  //alert(JSON.stringify($('#docTypeFile'+ fieldId)[0].files[0]));
  //console.log(JSON.stringify(multiRequest));
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: './updateDeviceDetails',
    type: 'POST',
    data: formData,
    mimeType: 'multipart/form-data',
    processData: false,
    contentType: false,
    async: false,
    success: function(response, textStatus, jqXHR) {
      //console.log(JSON.stringify(response));
       $('#updateConfirmationModal').closeModal({
    	dismissible: false
  	});
  	$("#mobileDetailEditDiv").css("display", "none");
    $("#datatableViewDiv").css("display", "block");
     // Resetfilter('addDeviceForm', null);
  	
      
      if (updateSource == 'simpleEdit' && $('#multiEditButton').is(':checked') == true) {
		//alert("updateSource 1 ==" +updateSource);
		$('#multiEditButton').prop('checked', true);
        $("#editDeviceBtn").prop("disabled", true);
		DeviceDataTable(lang, null ,'multiedit',null);
	  }else{
		//alert("updateSource 2 ==" +updateSource);
		DeviceDataTable(lang, null, null, null);
	  }
	  
  $('#updateConfirmationMessage').openModal({
    	dismissible: false
  	  });
   setTimeout(function() {
   $('#updateConfirmationMessage').closeModal({
    	dismissible: false
  	  });
	}, 3000);
    },
    error: function(jqXHR, textStatus, errorThrown) {
      //console.log("error in ajax")
    }
  });
  return false;
  //    $('div#initialloader').delay(300).fadeOut('slow');
}

function closeViewButton() {
  $("#datatableViewDiv").css("display", "block");
  $("#mobileDetailViewDiv").css("display", "none");
  //Reset Tab
  $('#mobileDetailViewDiv ul li a').each(function() {
    $("#mobileDetailViewDiv ul li a").removeAttr('class');
  });
  $('#mobileDetailViewDiv ul li a:first').addClass('active');
  $('#mobileDetailViewDiv .tab-content [id^=tab]').removeClass('active show');
  $('#mobileDetailViewDiv .tab-content :first').addClass('active show');
}


function closeHistoryViewButton() {
  $("#datatableViewDiv").css("display", "block");
  $("#mobileDetailHistoryViewDiv").css("display", "none");
  //Reset Tab
  $('#mobileDetailHistoryViewDiv ul li a').each(function() {
    $("#mobileDetailHistoryViewDiv ul li a").removeAttr('class');
  });
  $('#mobileDetailHistoryViewDiv ul li a:first').addClass('active');
  $('#mobileDetailHistoryViewDiv .tab-content [id^=tab]').removeClass('active show');
  $('#mobileDetailHistoryViewDiv .tab-content :first').addClass('active show');
}

function exportData() {
  var table = $('#LibraryTable').DataTable();
  var info = table.page.info();
  var pageNo = info.page;
  var pageSize = info.length;
  var filterRequest = {
    "startDate": $('#startDate').val(),
    "endDate": $('#endDate').val(),
    "deviceId": $('#filterTac').val(),
    "marketingName": $('#filterMarketingName').val(),
    "brandName": $('#filterBrandName').val(),
    "brandName": $('#filterBrandName').val(),
    "modelName": $('#filterModelName').val(),
    "os": $('#filterOs').val(),
    "mdrStatus": $('#filterStatus').val(),
    "featureId": parseInt(featureId),
    "userId": parseInt($("body").attr("data-userID")),
    "userType": $("body").attr("data-roleType"),
    //"userType" : parseInt($("body").attr("data-userTypeID")),
    "userTypeId": parseInt($("body").attr("data-userTypeID")),
    "pageNo": parseInt(pageNo),
    "pageSize": parseInt(pageSize)
  }
  //console.log(JSON.stringify(filterRequest))
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: './exportDeviceDetails',
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(filterRequest),
    success: function(data, textStatus, jqXHR) {
      //window.location.href = data.url;
      finalURL(data.url);
    },
    error: function(jqXHR, textStatus, errorThrown) {}
  });
}

function deleteDevice(deviceId) {
  $("#deleteDeviceId").text(deviceId);
  //alert("delete called with Device ID " +deviceId);
}

function deleteDeviceDetails() {
  $('div#initialloader').fadeIn('fast');
  var deviceId = $("#deleteDeviceId").text();
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: './deleteDevice?deviceId=' + deviceId + '&featureId=' + parseInt(featureId) + '&userId=' + parseInt($("body").attr("data-userID")) + '&userType=' + $("body").attr("data-roleType"),
    contentType: 'application/json; charset=utf-8',
    async: false,
    type: 'POST',
    success: function(data, textStatus, xhr) {
	
      //console.log(data);
      
      //$("#materialize-lean-overlay-3").css("display","none");
      $('#deleteConfirmationMessage').openModal({
    	dismissible: false
  	  });
  	 setTimeout(function() {
   	 $('#deleteConfirmationMessage').closeModal({
    	dismissible: false
  	  });
	}, 3000);
	
	DeviceDataTable(lang, null, null, null);
	
    },
    error: function() {
      ////console.log("Error");
    }
  });
  $('div#initialloader').delay(300).fadeOut('slow');
}

function Resetfilter(formID, deviceId) {
  $('#endDate').css('border-color', '');
  $('#errorMsg').text('');
  $("#docTypeFile1").attr("disabled", false);
  $("#docTypeFileSave").attr("disabled", false);
  $('#' + formID).trigger('reset');
  //$('input[id=multiEditButton]').prop('checked', false);
  $("label").removeClass('active');
  //alert('is multiEdit checked--' +$('#multiEditButton').is(":checked"));
  if (formID == "historyFilterform") {
    DeviceDataTable(lang, 'filter', 'viewHistory', deviceId);
  } else if ($('#multiEditButton').is(":checked") == true) {
    DeviceDataTable(window.parent.$('#langlist').val(), 'filter', 'multiedit', null);
  } else {
    DeviceDataTable(lang, 'filter', null, null);
  }
}

function openImageViewModal(imageSrcID) {
  var imageURL = document.getElementById(imageSrcID).src;
  $('#imageViewModal').openModal({
    dismissible: false
  });
  $("#imgInViewForm").attr("src", imageURL);
}

function openDeleteModal() {
  $('#deletePopUp').openModal({
    dismissible: false
  });
}

function addDeviceform() {
  if ($('#addTac').val() == '') {
    return false;
  }
  $('#AddconfirmationModal').openModal({
    dismissible: false
  });
  $('#completeCheckBox').prop('checked', false);
  $("#errorFieldList").text("");
  $("#saveDeviceButton").removeClass('disabled');
  return false;
};

function closeConfirmation() {
  $('#completeCheckBox').prop('checked', false);
  $("#errorFieldList").text(""); 
  $("#errorFieldList").css("display", "none");  	
  $("#saveDeviceButton").removeClass('disabled');
  $("#fieldValidationMsg").css("display", "none"); 
  $("#fieldValidationSuccessMsg").css("display", "none"); 
  $('#AddconfirmationModal').closeModal({
    	dismissible: false
  	});	
  	
};

function closeConfirmationupdate(){
  $('#completeCheckBoxEdit').prop('checked', false);
  $("#errorFieldListEdit").text(""); 
  $("#errorFieldListEdit").css("display", "none");  	
  $("#updateButton").removeClass('disabled');
  $("#fieldValidationMsgEdit").css("display", "none"); 
  $("#fieldValidationSuccessMsgEdit").css("display", "none"); 
  $('#myModal').closeModal({
    	dismissible: false
  	});	
}

idCount = 0;
const preview = (file) => {
  const fr = new FileReader();
  fr.onload = () => {
    //alert("inside preview1");
    // const div = document.createElement("div");
    //console.log("filereader1 updated Line----1601 with idCount " + idCount);
    //console.log("inside preview1");
    idCount = idCount + 1;
    //idCount = idCount;
    enableAndDisableUploadButton(idCount, "docTypeFile1");
    //console.log("'src', URL.createObjectURL(file)---" + URL.createObjectURL(file));
    document.getElementById("mainFrameEdit" + idCount).removeAttribute('src');
    //document.getElementById("mainFrameEdit" + idCount).src = fr.result;  // String Base64
    document.getElementById("mainFrameEdit" + idCount).setAttribute('src', URL.createObjectURL(file));
    document.getElementById("mainFrameEdit" + idCount).alt = file.name;
    document.getElementById("mainFrameEditInput" + idCount).files = document.getElementById("docTypeFile1").files;
    document.getElementById("mainFrameEdit").removeAttribute('src');
    //document.getElementById("mainFrameEdit").src = fr.result;  // String Base64
    document.getElementById("mainFrameEdit").setAttribute('src', URL.createObjectURL(file));
    document.getElementById("mainFrameEdit").alt = file.name;
    //creating remove button in image
    const removebtn = document.createElement("BUTTON");
    removebtn.setAttribute("id", "removeBtnID" + idCount);
    removebtn.setAttribute("onclick", "removeIMG('IMGID" + idCount + "','imgInputId" + idCount + "')");
    var removeText = document.createTextNode("Remove");
    removebtn.appendChild(removeText);
    //creating replace button in image
    const replacebtn = document.createElement("input");
    replacebtn.type = 'file';
    replacebtn.setAttribute("id", "replaceBtnID" + idCount);
    replacebtn.setAttribute("onchange", "UploadImage('IMGID" + idCount + "','replaceBtnID" + idCount + "')");
    var replaceText = document.createTextNode("Replace");
    replacebtn.appendChild(replaceText);
    //idCount++
  };
  fr.readAsDataURL(file);
};
idCount1 = 0;
const preview2 = (file) => {
  const fr1 = new FileReader();
  fr1.onload = () => {
    // const div = document.createElement("div");
    //console.log("filereader2 Line----1639");
    idCount1 = idCount1 + 1;
    enableAndDisableUploadButton(idCount1, "docTypeFileSave");
    //console.log("inside preview2");
    //document.getElementById("mainFrameSave" + idCount1).removeAttribute('src');
    //document.getElementById("mainFrameSave" + idCount1).src = fr1.result;  // String Base64 
    //document.getElementById("mainFrameSave" + idCount1).setAttribute('src', fr1);
    //document.getElementById("mainFrameSave" + idCount1).alt = file.name;
    //console.log("'src', URL.createObjectURL(file)---" + URL.createObjectURL(file));
    document.getElementById("mainFrameSave" + idCount1).removeAttribute('src');
    //document.getElementById("mainFrameEdit" + idCount).src = fr.result;  // String Base64
    document.getElementById("mainFrameSave" + idCount1).setAttribute('src', URL.createObjectURL(file));
    document.getElementById("mainFrameSave" + idCount1).alt = file.name;
    document.getElementById("mainFrameSaveInput" + idCount1).files = document.getElementById("docTypeFileSave").files;
    document.getElementById("mainFrameSave").removeAttribute('src');
    //document.getElementById("mainFrameEdit").src = fr.result;  // String Base64
    document.getElementById("mainFrameSave").setAttribute('src', URL.createObjectURL(file));
    document.getElementById("mainFrameSave").alt = file.name;
    //creating remove button in image
    //creating replace button in image
    const replacebtn = document.createElement("input");
    replacebtn.type = 'file';
    replacebtn.setAttribute("id", "replaceBtnIDSave" + idCount1);
    replacebtn.setAttribute("onchange", "UploadImageCopyFrom('IMGID" + idCount1 + "','replaceBtnIDSave" + idCount1 + "')");
    var replaceText = document.createTextNode("Replace");
    replacebtn.appendChild(replaceText);
  };
  fr1.readAsDataURL(file);
};

document.querySelector("#docTypeFile1").addEventListener("change", (ev) => {
  //alert("called addEventListener");
  if (!ev.target.files) return; // Do nothing.
  [...ev.target.files].forEach(preview);
});
document.querySelector("#docTypeFileSave").addEventListener("change", (ev) => {
  if (!ev.target.files) return; // Do nothing.
  [...ev.target.files].forEach(preview2);
});

function removeIMG(imgTagID,imgInputId) {
  //$("#"+removeBtnID).remove();
 //$(".resetImgID").attr("img-id",null);
  $("#"+imgInputId).val('');
  document.getElementById(imgTagID).removeAttribute('src');
  //$("#mainFrameEdit,#mainFrameSave").attr("src", './resources/assets/images/NoImage.jpg');
  document.getElementById(imgTagID).setAttribute('src', 'https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png');
}

function UploadImage(imageInputID, mainFrameID) {
  //console.log("filereader3 Line----1695");
  //document.getElementById(imageInputID).removeAttribute('src');
  document.getElementById('mainFrameSave' + imageInputID).removeAttribute('src');
  //dd(imageInputID,replaceBtnID);
  //  frame.src=URL.createObjectURL(event.target.files[0]);
  document.getElementById(mainFrameID).removeAttribute('src');
  document.getElementById(mainFrameID).setAttribute('src', URL.createObjectURL(event.target.files[0]));
  //document.getElementById(mainFrameID).setAttribute('src', URL.createObjectURL(event.target.files[0]));
  //document.getElementById(imageInputID).setAttribute("src", URL.createObjectURL(event.target.files[0]));
  document.getElementById('mainFrameSave' + imageInputID).setAttribute("src", URL.createObjectURL(event.target.files[0]));
  document.getElementById("mainFrameSaveInput" + imageInputID).files = event.target.files;
}
/*function UploadImageCopyFrom(imageInputID, mainFrameID) {
        console.log("in UploadImageCopyFrom");
        //document.getElementById(imageInputID).removeAttribute('src');
        document.getElementById('copyFromsubFrame' + imageInputID).removeAttribute('src');
        //dd(imageInputID,replaceBtnID);
        //  frame.src=URL.createObjectURL(event.target.files[0]);
        document.getElementById(mainFrameID).removeAttribute('src');
        document.getElementById(mainFrameID).setAttribute('src', URL.createObjectURL(event.target.files[0]));
        //document.getElementById(mainFrameID).setAttribute('src', URL.createObjectURL(event.target.files[0]));
        //document.getElementById(imageInputID).setAttribute("src", URL.createObjectURL(event.target.files[0]));
        document.getElementById('copyFromsubFrame' + imageInputID).setAttribute("src", URL.createObjectURL(event.target.files[0]));
        document.getElementById("copyFromsubFrameInput" + imageInputID).files = event.target.files;
}*/
function UploadUpdateImage(imageInputID, mainFrameID) {
  //console.log("in UploadUpdateImage");
  document.getElementById('mainFrameEdit' + imageInputID).removeAttribute('src');
  //dd(imageInputID,replaceBtnID);
  //  frame.src=URL.createObjectURL(event.target.files[0]);
  document.getElementById(mainFrameID).removeAttribute('src');
  document.getElementById(mainFrameID).setAttribute('src', URL.createObjectURL(event.target.files[0]));
  document.getElementById('mainFrameEdit' + imageInputID).setAttribute("src", URL.createObjectURL(event.target.files[0]));
  document.getElementById("mainFrameEditInput" + imageInputID).files = event.target.files;
}

function dd(imageInputID, replaceBtnID) {
  const did = 'replaceBtnID' + idCount;
  const [file] = replaceBtnID1.files;
  if (file) {
    document.getElementById(imageInputID).setAttribute("src", URL.createObjectURL(file));
    //imageInputID.src = URL.createObjectURL(file);
  }
}

function enableAndDisableUploadButton(count, inputId) {
  var max_fields = localStorage.getItem("maxCount");
  //console.log("max_fields+ " +max_fields);
  if (count == max_fields) {
    $("#" + inputId).prop("disabled", true);
    //console.log("in if block with count " +count);
  } else {
    $("#" + inputId).attr("disabled", false);
    //console.log("in else block with count " +count);
  }
}

function hoverIMG(frameID) {
  hoversrc = document.getElementById(frameID).src
  document.getElementById("mainFrameSave").removeAttribute('src');
  document.getElementById("mainFrameSave").setAttribute('src', hoversrc);
}

function hoverIMGEdit(frameIDEdit) {
  hoversrcEdit = document.getElementById(frameIDEdit).src
  document.getElementById("mainFrameEdit").removeAttribute('src');
  document.getElementById("mainFrameEdit").setAttribute('src', hoversrcEdit);
}

function hoverIMGView(frameIDView) {
  hoversrcEdit = document.getElementById(frameIDView).src
  document.getElementById("mainFrame").removeAttribute('src');
  document.getElementById("mainFrame").setAttribute('src', hoversrcEdit);
}

function hoverIMGCopyView(copyFromframeIDView) {
  hoversrcEdit = document.getElementById(copyFromframeIDView).src
  document.getElementById("copyFromsubFrame").removeAttribute('src');
  document.getElementById("copyFromsubFrame").setAttribute('src', hoversrcEdit);
}
async function convertImageToBlob(url) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error('Image request failed');
    }
    const blob = await response.blob();
    //console.log("blob recieved :::::" + blob);
    return blob;
  } catch (error) {
    throw error;
  }
};

async function copyAllImage() {
  //console.log("window.location.origin" + window.location.origin);
  const baseURL = window.location.origin;
  for (var i = 1; i <= 5; i++) {
    const imageTag = document.getElementById('mainFrameEdit' + i);
    const fileInput = document.getElementById("mainFrameEditInput" + i);
    const src = imageTag.getAttribute('src');
    //const filename = ''; // Extract image file name
    const filename = src.substring(src.lastIndexOf('/') + 1);
    //console.log("src is  " + src);
    if (src == './resources/assets/images/NoImage.jpg' || !src) {
      continue;
    };
    try {
      const URL = baseURL + src;
      //console.log("Final URL " + URL);
      const imageBlob = await convertImageToBlob(encodeURI(URL));
      const imageFile = new File([imageBlob], filename, {
        type: imageBlob.type
      });
      const dataTransfer = new DataTransfer();
      dataTransfer.items.add(imageFile);
      fileInput.files = dataTransfer.files;
      //fileInput.files = new FileList([imageFile]);
      //console.log("in TRY");
    } catch (error) {
      //console.log(error);
    }
  }
};

function validateImportaintField(){
var fieldList = [];
if ($('#completeCheckBox').is(":checked") == true) {
	 //console.log("checked");

    $("#addManufacturer").val() == "" && !fieldList.includes("Manufacturer") ? fieldList.push("Manufacturer") : $("#addManufacturer").val();
    $("#addBrand").val() == "" && !fieldList.includes("Brand Name") ? fieldList.push("Brand Name") : $("#addBrand").val();
    $("#addModel").val() == "" && !fieldList.includes("Model Name") ? fieldList.push("Model Name") : $("#addModel").val();
    $("#addDeviceType").val()==0 && !fieldList.includes("Device Type") ? fieldList.push("Device Type") : $("#addDeviceType").val();
    $("#addOem").val()=="" && !fieldList.includes("OEM") ? fieldList.push("OEM") : $("#addOem").val();
    $("#addOrganizationID").val()=="" && !fieldList.includes("Organization ID") ? fieldList.push("Organization ID") : $("#addOrganizationID").val();
    $("#addDeviceIDAllocationDate").val()=="" && !fieldList.includes("Device ID Allocation Date") ? fieldList.push("Device ID Allocation Date") : $("#addDeviceIDAllocationDate").val();

    $("#addMarketingName").val()=="" ? fieldList.push ("Marketing Name") : $("#addMarketingName").val();

     if($("#addTechnologyCheckBoxdiv").find("input[type=checkbox]").is(":checked") != true){
	  		fieldList.push ("Technology");
	 };

     $("#addLaunchdate").val()=="" ? fieldList.push ("Launch Date") : $("#addLaunchdate").val();
	 $("#addDeviceStatus").val()==0 ? fieldList.push ("Device Status") : $("#addDeviceStatus").val();

	 $("#addSimSlots").val()==0 ? fieldList.push ("Number of Sim Slots") : $("#addSimSlots").val();
	 $("#addnumberofIMEI").val()==0 ? fieldList.push ("Number Of IMEI") : $("#addnumberofIMEI").val();
	 $("#addSimSupport").val()=="" ? fieldList.push ("ESIM Support") : $("#addSimSupport").val(); 
	 $("#addSoftSimSupport").val()=="" ? fieldList.push ("Soft SIM Support") : $("#addSoftSimSupport").val();
	 
	 $("#addOs").val()=="" ? fieldList.push ("OS") : $("#addOs").val();
	 $("#addOSversion").val()=="" ? fieldList.push ("OS Version") : $("#addOSversion").val();
	 $("#addRAM").val()=="" ? fieldList.push ("RAM") : $("#addRAM").val();
	 
	 $("#addWLANSupport").val()=="" ? fieldList.push ("WLAN Support") : $("#addWLANSupport").val();
	 $("#addBluetoothSupport").val()=="" ? fieldList.push ("Bluetooth Support") : $("#addBluetoothSupport").val();
	 $("#addGPSsupport").val()=="" ? fieldList.push ("GPS Support") : $("#addGPSsupport").val();
	 $("#addUSBSupport").val()=="" ? fieldList.push ("USB Support") : $("#addUSBSupport").val();
	 
	 $("#addUICC").val()=="" ? fieldList.push ("UICC") : $("#addUICC").val();
	 $("#addEUICC").val()=="" ? fieldList.push ("EUICC") : $("#addEUICC").val();
	 
	 $("#addAsia").val()=="" ? fieldList.push ("Asia") : $("#addAsia").val();
	 $("#addInternational").val()=="" ? fieldList.push ("International") : $("#addInternational").val();
	 $("#addlaunchPriceCambodia").val()=="" ? fieldList.push ("Launch Price In Cambodia Market") : $("#addlaunchPriceCambodia").val();
	 $("#addsourcePriceCambodia").val()=="" ? fieldList.push ("Source Of Cambodia Market Price") : $("#addsourcePriceCambodia").val();
	 $("#addcustomPrice").val()=="" ? fieldList.push ("Custom Price Of Device") : $("#addcustomPrice").val();
	 
	 //console.log("fieldList updated is  "+fieldList +" and length"+fieldList.length);
	 
	  if(fieldList.length !=0){
		for (var i = 0; i < fieldList.length; i++) {
 		//console.log("field values---" +fieldList[i]);
 		$("#errorFieldList").append("<ul><li>"+fieldList[i]+"</li></ul>");
		 }; 
	 	$("#fieldValidationMsg").css("display", "block");  
	 	$("#errorFieldList").css("display", "block");  	
  		 $("#saveDeviceButton").addClass('disabled');   
	} else {
		$("#fieldValidationMsg").css("display", "none"); 
		$("#fieldValidationSuccessMsg").css("display", "block");
		$("#errorFieldList").text("");   
		$("#errorFieldList").css("display", "none");  	
  		 $("#saveDeviceButton").removeClass('disabled');  
	} 
	                          
}else{
	//console.log("not checked");
	$("#fieldValidationMsg").css("display", "none"); 
	$("#fieldValidationSuccessMsg").css("display", "none"); 
	$("#errorFieldList").text("");  
	$("#errorFieldList").css("display", "none");  	
	$("#saveDeviceButton").removeClass('disabled');
	};
};

function validateImportaintFieldUpdate(){
var fieldList = [];
if ($('#completeCheckBoxEdit').is(":checked") == true) {
	 //console.log("checked");
	 $("#editManufacturer").val()=="" ? fieldList.push("Manufacturer") : $("#editManufacturer").val(); 
	 $("#editMarketingName").val()=="" ? fieldList.push ("Marketing Name") : $("#editMarketingName").val();
	// $("#editManufacturingAddress").val()=="" ? fieldList.push ("Manufacturing Address") : $("#editManufacturingAddress").val();  
	 $("#editBrand").val()=="" ? fieldList.push ("Brand Name") : $("#editBrand").val(); 
	 $("#editModel").val()=="" ? fieldList.push ("Model Name") : $("#editModel").val(); 
	 if($("#editTechnologyCheckBoxdiv").find("input[type=checkbox]").is(":checked") != true){
	  		fieldList.push ("Technology");
	 };
	 $("#editDeviceType").val()==0 ? fieldList.push ("Device Type") : $("#editDeviceType").val();
	 
	 $("#editLaunchdate").val()=="" ? fieldList.push ("Launch Date") : $("#editLaunchdate").val();
	 $("#editDeviceStatus").val()==0 ? fieldList.push ("Device Status") : $("#editDeviceStatus").val();
	 $("#editOem").val()=="" ? fieldList.push ("OEM") : $("#editOem").val();
	 $("#editDeviceIDAllocationDate").val()=="" ? fieldList.push ("Device ID Allocation Date") : $("#editDeviceIDAllocationDate").val();
	// $("#editDiscontinuedDate").val()=="" ? fieldList.push ("Discontinued Date") : $("#editDiscontinuedDate").val();
	 
	 $("#editSimSlots").val()==0 ? fieldList.push ("Number of Sim Slots") : $("#editSimSlots").val();
	 $("#editnumberofIMEI").val()==0 ? fieldList.push ("Number Of IMEI") : $("#editnumberofIMEI").val();
	 $("#editSimSupport").val()=="" ? fieldList.push ("ESIM Support") : $("#editSimSupport").val(); 
	 $("#editSoftSimSupport").val()=="" ? fieldList.push ("Soft SIM Support") : $("#editSoftSimSupport").val();
	 
	 $("#editOs").val()=="" ? fieldList.push ("OS") : $("#editOs").val();
	 $("#editOSversion").val()=="" ? fieldList.push ("OS Version") : $("#editOSversion").val();
	 $("#editRAM").val()=="" ? fieldList.push ("RAM") : $("#editRAM").val();
	 
	 $("#editWLANSupport").val()=="" ? fieldList.push ("WLAN Support") : $("#editWLANSupport").val();
	 $("#editBluetoothSupport").val()=="" ? fieldList.push ("Bluetooth Support") : $("#editBluetoothSupport").val();
	 $("#editGPSsupport").val()=="" ? fieldList.push ("GPS Support") : $("#editGPSsupport").val();
	 $("#editUSBSupport").val()=="" ? fieldList.push ("USB Support") : $("#editUSBSupport").val();
	 
	 $("#editUICC").val()=="" ? fieldList.push ("UICC") : $("#editUICC").val();
	 $("#editEUICC").val()=="" ? fieldList.push ("EUICC") : $("#editEUICC").val();
	 
	 $("#editAsia").val()=="" ? fieldList.push ("Asia") : $("#editAsia").val();
	 $("#editInternational").val()=="" ? fieldList.push ("International") : $("#editInternational").val();
	 $("#editlaunchPriceCambodia").val()=="" ? fieldList.push ("Launch Price In Cambodia Market") : $("#editlaunchPriceCambodia").val();
	 $("#editsourcePriceCambodia").val()=="" ? fieldList.push ("Source Of Cambodia Market Price") : $("#editsourcePriceCambodia").val();
	 $("#editcustomPrice").val()=="" ? fieldList.push ("Custom Price Of Device") : $("#editcustomPrice").val();
	 
	  $("#editManufacturerCountry").val()==0 ? fieldList.push ("Manufacturer Country") : $("#editManufacturerCountry").val();
	 
	 //console.log("fieldList updated is  "+fieldList +" and length"+fieldList.length);
	 
	  if(fieldList.length !=0){
		for (var i = 0; i < fieldList.length; i++) {
 		//console.log("field values---" +fieldList[i]);
 		$("#errorFieldListEdit").append("<ul><li>"+fieldList[i]+"</li></ul>");
		 }; 
	 	$("#fieldValidationMsgEdit").css("display", "block");  
	 	$("#errorFieldListEdit").css("display", "block");  	
  		 $("#updateButton").addClass('disabled');   
	} else {
		$("#fieldValidationMsgEdit").css("display", "none"); 
		$("#fieldValidationSuccessMsgEdit").css("display", "block");
		$("#errorFieldListEdit").text("");   
		$("#errorFieldListEdit").css("display", "none");  	
  		 $("#updateButton").removeClass('disabled');  
	} 
	                          
}else{
	//console.log("not checked");
	$("#fieldValidationMsgEdit").css("display", "none"); 
	$("#fieldValidationSuccessMsgEdit").css("display", "none"); 
	$("#errorFieldListEdit").text("");  
	$("#errorFieldListEdit").css("display", "none");  	
	$("#updateButton").removeClass('disabled');
	};
};

 $('button.close').click(function() {
   $('#copyFromfilterMarketingName').val("");
 });

