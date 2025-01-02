//var featureId = 55;
var featureId = $("body").attr("data-featureId");
//var featureId = 4;
var cierRoletype = sessionStorage.getItem("cierRoletype");
var userType = $("body").attr("data-roleType");
var lang = window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
var tac;
var elem;
$.i18n().locale = lang;
var startdate = $('#startDate').val();
var endDate = $('#endDate').val();
var documenttype, selectfile, selectDocumentType;
$.i18n().load({
  'en': './resources/i18n/en.json',
  'km': './resources/i18n/km.json'
}).done(function() {
  selectfile = $.i18n('selectfile');
});

var userId = parseInt($("body").attr("data-userID"));
$(document).ready(function() {
  //$('div#initialloader').fadeIn('fast');
  getDashboardCount();
  DeviceDataTable(lang, null, null, null);

   var protocol = window.location.protocol;
              var domain = window.location.hostname;
              var port = window.location.port;
              window.urlWithProtocol = port == '' ? protocol + "//" + domain : protocol + "//" + domain +":" + port;
              completeDomainName = port == '' ? protocol + "//" + domain : protocol + "//" + domain +":" + port;
              //alert("MDR Dashboard " +window.urlWithProtocol);
  
});

function DeviceDataTable(lang, source, action, deviceId) {
  var source__val;
  if (source == 'filter') {
    source__val = source;
  } else {
    source__val = $("body").attr("data-session-source");
  }
  //alert ("1 with action" +action+" and deviceId--" +deviceId);
  DataTable('headers?type=deviceManagementHeaders&lang=' + lang, 'deviceManagementData?requestType=dashboardIcon'); 
}


function getDashboardCount() {
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': token
    }
  });
  $.ajax({
    url: './dashboardCount?userId='+parseInt($("body").attr("data-userID")),
    contentType: 'application/json; charset=utf-8',
    type: 'GET',
    success: function(data, textStatus, xhr) {
      console.log(data);
      $('#totalDeviceCount').text(data.totalDevices);
      $('#newDeviceCount').text(data.newDevices);
      $('#updatedDeviceCount').text(data.updatedDevices);
      $('#completedDeviceCount').text(data.completedDevices);
      //DeviceDataTable(lang, null, null, null);
      //$("#materialize-lean-overlay-3").css("display","none");
    },
    error: function() {
      console.log("Error");
    }
  });
  
}



var multiEditCount = 0;
//**************************************************Device Management table**********************************************
function DataTable(Url, dataUrl) {
   //alert("Url"+ Url+ " dataUrl "+dataUrl);
  //$('div#initialloader').fadeIn('fast');
  var filterRequest = {
    "startDate": $('#startDate').val(),
    "endDate": $('#endDate').val(),
    "deviceId": $('#filterTac').val(),
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
        "oLanguage": {
          "sUrl": langFile
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
      
      //$('div#initialloader').delay(500).fadeOut('slow');
      //$('div#initialloader').delay(300).fadeOut('slow');
      
    },
    error: function(jqXHR, textStatus, errorThrown) {}
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
      }  else {
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








function closeBtnfromEdit(Action) {
  if (Action == 'Edit') {
    DeviceDataTable(lang, 'filter', null, null);
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
  //New added Field
  $("#viewNetworkTechnology5G").text(data.content[0].networkTechnology5GInterp);
  $("#viewNetworkTechnology6G").text(data.content[0].networkTechnology6GInterp);
  $("#viewNetworkTechnology7G").text(data.content[0].networkTechnology7GInterp);
  
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
  $("#viewBatteryChargingSupport2").text(data.content[0].batteryCharging);
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
 /* $("#viewTrcApprovalDate").text(data.content[0].trcApprovalDate);
  $("#viewTrcTypeApprovedBy").text(data.content[0].trcTypeApprovedBy);
  $("#viewManufacturerCountry").text(data.content[0].manufacturerCountry);
  $("#viewIsTypeApproved").text(data.content[0].isTypeApproved);
  $("#viewtrcApprovedStatus").text(data.content[0].trcApprovedStatus);
  */
  
  	var trcApprovedDate = data.content[0].trcApprovalDate;
  	if (trcApprovedDate != null) {
		console.log("Success "+trcApprovedDate);
    	trcApprovedDate = trcApprovedDate.split(' ')[0];
    	$("#viewTrcApprovalDate").text(trcApprovedDate);
  	}else{
		console.log("Failed "+trcApprovedDate);
		$("#viewTrcApprovalDate").text("");
	}
  
  $("#viewTrcTypeApprovedBy").text(data.content[0].trcTypeApprovedBy);
  
  $("#viewManufacturerCountry").text(data.content[0].manufacturerCountry);
  
	if(data.content[0].isTypeApproved==0){
		$("#viewIsTypeApproved").text("false");
	}else{
		$("#viewIsTypeApproved").text("true");
	}
   
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
  	//View IMG Tags
  $("#mainFrame,#subFrame1,#subFrame2,#subFrame3,#subFrame4,#subFrame5").attr("src", './resources/assets/images/NoImage.jpg');
   
  if (srcFileDetails.length == 0) {
    console.log("no file details recieved for Action " + Action);
    //View IMG Tags
    $("#mainFrame,#subFrame1,#subFrame2,#subFrame3,#subFrame4,#subFrame5").attr("src", './resources/assets/images/NoImage.jpg');
  }
  console.log("file details srcFileDetails.length " + srcFileDetails.length);
  //$(".resetImgID").attr("img-id",null);
 // $(".resetImgID").attr("alt",null);
  
/*  for (i = 1; i <= srcFileDetails.length; i++) {
    var fileName = srcFileDetails[i-1].fileName;
    var filePath = srcFileDetails[i-1].filePath;
    if (fileName == "" || fileName == null) {
      console.log("file name " + fileName + " for Action " + Action);
    } else {
      console.log("file details recieved for Action " + Action);
      //var FinalLink = filePath.replace('/u01/eirsapp/apache-tomcat-9.0.78/webapps', '');
      var FinalLink = filePath.replace('/u01/tomcat/webapps', '');
      console.log("FinalLink is --- " + FinalLink + " and value of  i---" + i);
      $("#subFrame" + i).attr("src", './resources/assets/images/NoImage.jpg') && $("#subFrame" + i).attr("src", FinalLink) && $("img#mainFrame").attr('src', $("img#subFrame1").attr('src')), 
      			// : $("#mainFrameEdit" + i).attr("src", FinalLink) && $("#mainFrameEdit" + i).attr("img-id", srcFileDetails[i-1].id) && $("img#mainFrameEdit").attr('src', $("img#mainFrameEdit1").attr('src'));
      //Action == 'copyView' ? $("#copyFromsubFrame" + i).attr("src", './resources/assets/images/NoImage.jpg') && $("#copyFromsubFrame" + i).attr("src", FinalLink) && $("img#copyFromMainFrame").attr('src', $("img#copyFromsubFrame1").attr('src')) : $("#copyFromsubFrame" + i).attr("src", FinalLink);
      console.log("filePath is " + filePath + " with Action  " + Action);
      //Action == 'copy' ? $("#subFrameEdit"+i).attr("src", "") && $("#subFrameEdit"+i).attr("src", FinalLink) : $("#subFrameEdit"+i).attr("src", FinalLink);
    }
    //console.log("fileName is "+fileName+" and filePath is "+filePath);
  }
*/  
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
      
      $("#subFrameEdit" + i).attr("src", FinalLink);
      console.log("filePath is " + filePath + " with Action  " + Action);
    }
  }
 
  
}

function selectImage(src) {
  $("#mainFrame").attr("src", '');
  $("#mainFrame").attr("src", src);
  $("#copyFromMainFrame").attr("src", src);
};
var sourceCopyTac = null;





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



function updateDeviceConfirmation() {
  return false;
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
  return false;
};

function closeConfirmation() {
 $('#AddconfirmationModal').closeModal({
    	dismissible: false
  	});	
};

function clickok(){
	$('#saveConfirmationMessage,#AddconfirmationModal').closeModal({
    	dismissible: false
  	});
  	DeviceDataTable(lang, null, null, null);
	$("#addMobileDetailDiv").css("display", "none");
    $("#datatableViewDiv").css("display", "block");
}
var idCount = 0;
const preview = (file) => {
  const fr = new FileReader();
  fr.onload = () => {
    //alert("inside preview1");
    // const div = document.createElement("div");
    console.log("filereader1 updated Line----1601 with idCount " + idCount);
    console.log("inside preview1");
    idCount = idCount + 1;
    //idCount = idCount;
    enableAndDisableUploadButton(idCount, "docTypeFile1");
    console.log("'src', URL.createObjectURL(file)---" + URL.createObjectURL(file));
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
var idCount1 = 0;
const preview2 = (file) => {
  const fr1 = new FileReader();
  fr1.onload = () => {
    // const div = document.createElement("div");
    console.log("filereader2 Line----1639");
    idCount1 = idCount1 + 1;
    enableAndDisableUploadButton(idCount1, "docTypeFileSave");
    console.log("inside preview2");
    //document.getElementById("mainFrameSave" + idCount1).removeAttribute('src');
    //document.getElementById("mainFrameSave" + idCount1).src = fr1.result;  // String Base64 
    //document.getElementById("mainFrameSave" + idCount1).setAttribute('src', fr1);
    //document.getElementById("mainFrameSave" + idCount1).alt = file.name;
    console.log("'src', URL.createObjectURL(file)---" + URL.createObjectURL(file));
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
  console.log("filereader3 Line----1695");
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
  console.log("in UploadUpdateImage");
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
  console.log("max_fields+ " +max_fields);
  if (count == max_fields) {
    $("#" + inputId).prop("disabled", true);
    console.log("in if block with count " +count);
  } else {
    $("#" + inputId).attr("disabled", false);
    console.log("in else block with count " +count);
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
