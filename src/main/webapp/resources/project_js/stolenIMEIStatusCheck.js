//var featureId = 112;
var featureId = $("body").attr("data-featureId");
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType");
var creationDate = $('#filterCreatedDate').val();
var updatedDate = $('#filterUpdatedDate').val();
$.i18n().locale = "en";
var documenttype, selectfile, selectDocumentType;

$(document).ready(function() {
   $('div#initialloader').fadeIn('fast');
   Datatable();
   PageRendering();
   documenttype = $.i18n('documenttype');
   selectfile = $.i18n('selectfile');
   selectDocumentType = $.i18n('selectDocumentType');
   console.log("featureId " +featureId);

});

//alert("navData " +window.parent.$('.navData li.active a').attr('data-featureid'));

var role = currentRoleType == null ? roleType : currentRoleType;


function PageRendering() {
   pageRendering().then(() => setAllDropdown());
};

let isEmpty = (x) => {
   if (x == undefined || x == '') {
      return null
   };
   return x;
};


let payloadParameter = () => {
   var {
      createdOn,
      modifiedOn,
      transactionId,
      requestMode,
      imei1,
      fileName,
      status,
      featureId,
      userId,
      userTypeId,
      userType,
      userName
   } = {
      createdOn: isEmpty($('#filterCreatedDate').val()),
      modifiedOn: isEmpty($('#filterUpdatedDate').val()),
      transactionId: isEmpty($('#filterTransactionID').val()),
      requestMode: isEmpty($('#filterRequestMode').val()),
      imei1: isEmpty($('#filterImei').val()),
      fileName: isEmpty($('#filterFileName').val()),
      status: isEmpty($('#filterStatus').val()),
      featureId: parseInt(featureId),
      userId: parseInt(userId),
      userTypeId: parseInt($("body").attr("data-userTypeID")),
      userType: $("body").attr("data-roleType"),
      userName: $("body").attr("data-selected-username")
   };

   var payload = {
      "createdOn": createdOn,
      "modifiedOn": modifiedOn,
      "transactionId": transactionId,
      "requestMode": requestMode,
      "imei1": imei1,
      "fileName": fileName,
      "status": status,
      "featureId": featureId,
      "userId": userId,
      "userTypeId": userTypeId,
      "userType": userType,
      "userName": userName
   }
   return payload;
}

//**************************************** stolenIMEIStatus Device Table **********************************************

function Datatable(lang) {
   $('div#initialloader').fadeIn('fast');

   var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");
   $.ajaxSetup({
      headers: {
         'X-CSRF-TOKEN': token
      }
   });
   $.ajax({
      url: 'headers?type=stolenImeiStatusCheckHeaders',
      type: 'POST',
      dataType: "json",
      success: function(result) {
         var table = $("#LibraryTable").removeAttr('width').DataTable({
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
            }],
            initComplete: function() {
               $('.dataTables_filter input')
                  .off().on('keyup', function(event) {
                     if (event.keyCode === 13) {
                        table.search(this.value.trim(), false, false).draw();
                     }

                  });
            },
            ajax: {
               url: './getStolenImeiStatusCheckDetails',
               type: 'POST',
               dataType: "json",
               data: function(d) {
                  d.filter = JSON.stringify(payloadParameter());
                  //console.log(JSON.stringify(filterRequest));
               }

            },
            "columns": result,
            fixedColumns: true,
         });
         $('div#initialloader').delay(300).fadeOut('slow');

      },
      error: function(jqXHR, textStatus, errorThrown) {
         //console.log("error in ajax");
      }
   });
}




//**************************************************Duplicate Device page buttons**********************************************

function pageRendering() {

   return new Promise((resolve, reject) => {
      var token = $("meta[name='_csrf']").attr("content");
      var header = $("meta[name='_csrf_header']").attr("content");
      $.ajaxSetup({
         headers: {
            'X-CSRF-TOKEN': token
         }
      });
      $.ajax({
         url: 'stolenImeiStatusCheck/pageRendering',
         type: 'POST',
         dataType: "json",
         success: function(data) {
            var elem = '<h1>' + data.pageTitle + '<h1>';
            $("#pageHeaderTitle").append(elem);
            //$("#pageHeaderTitle").append('<div class="toggle-row ml-auto mr-4"></div>');
            //$("#pageHeaderTitle").append("<button type='button' id='upload' class='btn btn-outline-dark mr-2' onclick='upload()'> + New Search (Recovery) </button>");
            var button = data.buttonList;
            var date = data.inputTypeDateList;
            for (i = 0; i < date.length; i++) {
               if (date[i].type === "date") {
                  $("#dataTableDiv").append("<div class='form-group'>" +
                     "<label for=" + date[i].id + ">" + date[i].title + "</label>" +
                     "<input class='form-control text-uppercase' type='date' onchange='checkStolenDate(filterCreatedDate,filterUpdatedDate)' id=" + date[i].id + " autocomplete='off'>"
                  );
               } else if (date[i].type === "text") {
                  $("#dataTableDiv").append("<div class='form-group'><label for=" + date[i].id + " class='center-align'>" + date[i].title + "</label><input type=" + date[i].type + " class='form-control' id=" + date[i].id + " placeholder='Enter here' maxlength='19'/></div>");

               } else if (date[i].type === "select") {
                  var dropdownDiv =
                     $("#dataTableDiv").append(
                        "<div class='form-group'>" +
                        "<label for=" + date[i].id + ">" + date[i].title + "</label>" +
                        "<select id=" + date[i].id + "  class='form-control'>" +
                        "<option value='' selected>Select</option>" +
                        "</select>" +
                        "</div>" +
                        "</div>");
               }

            }


            var viewFilter = "viewFilter";


            $('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")
            $("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='clearFilter'>Reset All</button></div>");
            $("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='Datatable(null)'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
            $("#filterButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>" + $.i18n('Export') + " <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

            $('#clearFilter').attr("onclick", "filterReset('filterform',null)");

            for (i = 0; i < button.length; i++) {
               $('#' + button[i].id).text(button[i].buttonTitle);
               $('#' + button[i].id).attr("onclick", button[i].buttonURL);

            }

            resolve();
         }

      });
   });
   $('div#initialloader').delay(300).fadeOut('slow');
};


function setAllDropdown() {

   $.getJSON('./getDistinctStatus', function(data) {

   		  for (i = 0; i < data.length; i++) {
                   $('<option>').val(data[i]).text(data[i]).appendTo('#filterStatus');
         }
   	});


     $.getJSON('./getDropdownList/REQUEST_MODE', function(data) {
    	for (i = 0; i < data.length; i++) {
          $('<option>').val(data[i].value).text(data[i].interpretation).appendTo('#filterRequestMode');
        }
     })

}




function viewStolenDevice(rowId, transactionId) {
   window.location.replace("./imeiStatusCheck?via=other&transactionId=" + transactionId);
}




$('.datepicker').on('mousedown', function(event) {
   event.preventDefault();
});




function exportData() {
   ////console.log(JSON.stringify(filterRequest))
   var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");
   $.ajaxSetup({
      headers: {
         'X-CSRF-TOKEN': token
      }
   });
   $.ajax({
      url: './export-stolenimeistatus-details',
      type: 'POST',
      dataType: 'json',
      contentType: 'application/json; charset=utf-8',
      data: JSON.stringify(payloadParameter()),
      success: function(data, textStatus, jqXHR) {
         finalURL(data.url);
         $('div#initialloader').delay(300).fadeOut('slow');
      },
      error: function(jqXHR, textStatus, errorThrown) {}
   });
}



function filterReset(formID, action) {
   $('#' + formID).trigger('reset');
   $("label").removeClass('active');
   Datatable();
   $('#errorMsgDiv').text('');
}

let upload = () => {
   $('#form1').trigger('reset');
   $('#form2').trigger('reset');
   $('#errorDiv').html("");
   $('#form2-submitButton').addClass('disabled');
   $("#NewRequest").openModal({
      dismissible: false
   });
}


function singleRequest() {

   var {
      imei1,
      imei2,
      imei3,
      imei4,
      remark
   } = {
      imei1: isEmpty($('#form1-imei1').val()),
      imei2: isEmpty($('#form1-imei2').val()),
      imei3: isEmpty($('#form1-imei3').val()),
      imei4: isEmpty($('#form1-imei4').val()),
      remark: isEmpty($('#form1-remarks').val())
   };

   var stolenRequest = {
      "imei1": imei1,
      "imei2": imei2,
      "imei3": imei3,
      "imei4": imei4,
      "remark": remark,
      "requestMode": "Single",
      "auditTrailModel": {
         "featureId": parseInt(featureId),
         userTypeId: parseInt($("body").attr("data-userTypeID")),
         "userType": roleType,
         "userName": $("body").attr("data-selected-username"),
         "userId": parseInt($("body").attr("data-userID"))
      }
   };

   var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");
   $.ajaxSetup({
      headers: {
         'X-CSRF-TOKEN': token
      }
   });

   $.ajax({
      url: "./recoverStolenImeiDetail-single",
      data: JSON.stringify(stolenRequest),
      dataType: 'json',
      contentType: 'application/json; charset=utf-8',
      type: 'POST',
      beforeSend: function() {
         $('#form1-submit').addClass('disabled-btn');
      },
      complete: function() {
         $('#form1-submit').removeClass('disabled-btn');
      },
      success: function(data, textStatus, jqXHR) {
        if(data.statusCode==="500"){
                 $('#NewRequest').closeModal();
                 $("#contentDiv").css("display", "none");
                 $("#newRecoverySuccessScreen").css("display", "none");
                 $("#newRecoveryFailedScreen").css("display", "block");
        }else{
                     console.log(" in Single else" +data.requestID);
                     $('#NewRequest').closeModal();
                     $("#contentDiv").css("display", "none");
                     $("#newRecoveryFailedScreen").css("display", "none");
                     $("#newRecoverySuccessScreen").css("display", "block");
                     $("#recoveryTransactionId").append(data.requestID);
                     Datatable();
        }


         /*   let redirectURL = featureId==86 ? './eirs-list-management?FeatureId=' : './blocked-tac-list?FeatureId=';
         otpSuccessModal(' Successfully Saved and your Txn ID is : '+ data.requestID);*/
         /*setTimeout(function() {
       window.location.href = redirectURL+featureId;
    	}, 5000);*/

      },
      error: function(jqXHR, textStatus, errorThrown) {
      $('#NewRequest').closeModal();
      $("#contentDiv").css("display", "none");
      $("#newRecoverySuccessScreen").css("display", "none");
      $("#newRecoveryFailedScreen").css("display", "block");
      }
   });
   return false;
};

function bulkRequest() {
   var remark = isEmpty($('#form2-remarks').val());
   var stolenRequest = {
      "requestMode": "Bulk",
      "remark": remark,
      "auditTrailModel": {
         "featureId": parseInt(featureId),
         userTypeId: parseInt($("body").attr("data-userTypeID")),
         "userType": roleType,
         "userName": $("body").attr("data-selected-username"),
         "userId": parseInt($("body").attr("data-userID"))
      }
   };

   if (fileInput.files[0] == undefined) {
      return false;
   }
   var formData = new FormData();
   formData.append("file", fileInput.files[0]);
   formData.append("model", JSON.stringify(stolenRequest));
   var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");
   $.ajaxSetup({
      headers: {
         'X-CSRF-TOKEN': token
      }
   });

   $.ajax({
      url: "./recoverStolenImeiDetail-bulk",
      type: 'POST',
      data: formData,
      mimeType: 'multipart/form-data',
      enctype: 'multipart/form-data',
      processData: false,
      contentType: false,
      async: false,
      success: function(data, textStatus, jqXHR) {
       data = JSON.parse(data);
       //console.log("Response Data: ", data);
       //console.log(" in bulk else 1" +data.requestID);
         if(data.statusCode==="500"){
            $('#NewRequest').closeModal();
            $("#contentDiv").css("display", "none");
            $("#newRecoverySuccessScreen").css("display", "none");
            $("#newRecoveryFailedScreen").css("display", "block");
         }else{
                     //const jsonObject = JSON.parse(data);
                     $('#NewRequest').closeModal();
                     $("#contentDiv").css("display", "none");
                     $("#newRecoveryFailedScreen").css("display", "none");
                     $("#newRecoverySuccessScreen").css("display", "block");
                     $("#recoveryTransactionId").append(data.requestID);
                     Datatable();
         }

         /* let redirectURL = featureId==86 ? './eirs-list-management?FeatureId=' : './blocked-tac-list?FeatureId=';

           otpSuccessModal(' File uploaded successfully and your Txn ID is : '+jsonObject.requestID);

              setTimeout(function() {
                 $('#form2-submit').removeClass('disabled');
              window.location.href = redirectURL+featureId;
           	}, 5000);*/

      },
      error: function(jqXHR, textStatus, errorThrown) {
            $('#NewRequest').closeModal();
            $("#contentDiv").css("display", "none");
            $("#newRecoverySuccessScreen").css("display", "none");
            $("#newRecoveryFailedScreen").css("display", "block");

      }
   });
   return false;
}