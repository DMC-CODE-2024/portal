var {featureId,roleType,userId,currentRoleType,userTypeId,userName,
    startdate,endDate,lang,role,userType} = {
    featureId :110,
    roleType :$("body").attr("data-roleType"),
    userId :$("body").attr("data-userID"),
    currentRoleType : $("body").attr("data-selected-roleType"),
    userTypeId: $("body").attr("data-userTypeID"),
    userType:   $("body").attr("data-roleType"),
    userName:   $("body").attr("data-selected-username"),
    startdate:  $('#startDate').val(),
    endDate:    $('#endDate').val(),
    lang:       $('#langval').val(),
    role :      this.currentRoleType === null ? roleType : this.currentRoleType
};

$(document).ready(function(){
    $('div#initialloader').fadeIn('fast');
    pageRendering().then(() => filterDropdown());
    table();
});



let payloadParameter =() => {
$('#langval').val(sessionStorage.getItem('lang') == null ? 'en' : sessionStorage.getItem('lang') == 'km' ? 'km' : 'en');
let isEmpty = (x)=>{
        if(x == undefined || x == ''){return null};
        return x;
    };
    $('div#initialloader').fadeIn('fast');
    var ellipsis = "...";
    var featureName=isEmpty($('#featureName').val());
    var {startDate,endDate,featureTxnId,value,description,featureName,language,modifiedOn} = {
        featureTxnId : isEmpty($('#txn').val()),
        id : isEmpty($('#id').val()),
      //  tag : isEmpty($('#tag').val()),
       // type: isEmpty($('#type').val()),
        value : isEmpty($('#value').val()),
      //  active : isEmpty($('#active').val()),
        featureName : isEmpty($('#featureName').val()),
       // remarks : isEmpty($('#remarks').val()),
        description : isEmpty($('#description').val()),
        //userType : isEmpty($('#userType').val()),
        language : isEmpty($('#language').val()),
        startDate : isEmpty($('#startDate').val()),
        endDate : isEmpty($('#endDate').val()),


    };
    var filterRequest=  {
       // "tag" : tag,
        //"type" : type,
        "value" :value,
        //"active" :active,
        "featureName" :featureName,
       // "remarks" :remarks,
        "description" :description,
      //  "userType" :userType,
        "language" :language ,
        "startDate" :startDate,
        "endDate" :endDate,
        "auditTrailModel": {
            "startDate":startDate,
            "endDate":endDate,
            "roleType":roleType,
            "featureId":parseInt(featureId),
            "userTypeId": parseInt(userTypeId),
            "userType":roleType,
            "userName" : userName,
            "userId":parseInt(userId),
            "type" : parseInt($('#type').val())

        }
    }
    return filterRequest;

}
function table(){


    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
        headers:
            { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
        url: './headers?type=eirsResponseParam',
        type: 'POST',
        dataType: "json",
        success: function(result){
            var table=  $("#server-side-table").DataTable({
                destroy:true,
                "serverSide": true,
                orderCellsTop : true,
                "ordering" : true,
                "bPaginate" : true,
                "bFilter" : false,
                "bInfo" : true,
                "bSearchable" : true,
                "scrollX": true,

                "aaSorting": [],
                initComplete: function() {
                    $('.dataTables_filter input')
                        .off().on('keyup', function(event) {
                        if (event.keyCode === 13) {
                            table.search(this.value.trim(), false, false).draw();
                        }

                    });
                },
                ajax: {
                    url : './eirs-response-param/paging',
                    type: 'POST',
                    dataType: "json",
                    data : function(d) {
                        d.filter = JSON.stringify(payloadParameter());
                    },
                    error: function (jqXHR, textStatus, errorThrown,data) {
                        /*
                        window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
                        window.parent.$('#500ErrorModal').openModal({
                        dismissible:false
                        });*/

                    }
                },
                "columns": result,
                fixedColumns: true,
                columnDefs: [{targets:[3], class:"columnwrap"}]
            });


            $('div#initialloader').delay(300).fadeOut('slow');

        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });
}


function pageRendering(){
    return new Promise((resolve, reject) => {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajaxSetup({
            headers:
                { 'X-CSRF-TOKEN': token }
        });

        $.ajax({
            url: './eirs-response-param/page-rendering',
            type: 'POST',
            dataType: "json",
            success: function(data){
                var elem='<h1>'+data.pageTitle+'<h1>';
                $("#pageHeader").append(elem);
                $("#pageHeader").append('<div class="toggle-row ml-auto mr-4"></div>');
               // $("#pageHeader").append("Language : &nbsp; <select id='langval'><option value='en'>EN</option><option value='km'>KM</option></select>");

                var button=data.buttonList;

                var date=data.inputTypeDateList;



                for(i=0; i<date.length; i++){
                    if(date[i].type === "date"){
                        $("#filterSection").append("<div class='form-group'>"+
                            "<label for="+date[i].id+">"+date[i].title+"</label>"+
                            "<input class='form-control text-uppercase' type='date' onchange='checkDate(startDate,endDate)' id="+date[i].id+" autocomplete='off'>"
                        );
                    }
                    else if(date[i].type === "text"){
//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
                        $("#filterSection").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");

                    }
                    else if(date[i].type === "select"){
                        var dropdownDiv=
                            $("#filterSection").append(
                                "<div class='form-group'>"+
                                //"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+
                                "<label for="+date[i].id+">"+date[i].title+"</label>"+
                                "<select id="+date[i].id+"  class='form-control'>"+
                                "<option value='' selected>Select</option>"+
                                "</select>"+
                                "</div>"+
                                "</div>");
                    }

                }

                 $("#filterSection").append(
                                    "<div class='form-group'>" +
                                            "<label for='description' class='center-align active'>Description</label>" +
                                            "<input type='text' name='mnoName' class='form-control' id='description' placeholder='Enter Description'>" +
                                            "</div>"
                            );
//                            $("#filterSection").append(
//                                    "<div class='form-group'>" +
//                                            "<label for='type' class='center-align active'>Type</label>" +
//                                            "<input type='text' class='form-control' id='type' placeholder='Enter Type'>" +
//                                            "</div>"
//                            );
                            $("#filterSection").append(
                                    "<div class='form-group'>" +
                                            "<label for='value' class='center-align active'>Value</label>" +
                                            "<input type='text'  class='form-control' id='value' placeholder='Enter Value'>" +
                                            "</div>"
                            );
//                            $("#filterSection").append(
//                                    "<div class='form-group'>" +
//                                            "<label for='active' class='center-align active'>Active</label>" +
//                                            "<input type='text'  class='form-control' id='active' placeholder='Enter Active'>" +
//                                            "</div>"
//                            );
//                            $("#filterSection").append(
//                                    "<div class='form-group'>" +
//                                            "<label for='featureName' class='center-align active'>Feature Name</label>" +
//                                            "<input type='text'  class='form-control' id='featureName' placeholder='Enter Feature name'>" +
//                                            "</div>"
//                            );
//                          $("#filterSection").append(
//                              "<div class='form-group'>" +
//                                  "<label for='language' class='center-align active'>Language</label>" +
//                                  "<select class='form-control' id='language'>" +
//                                      "<option value=''>Select</option>" +
//                                      "<option value='en'>en</option>" +
//                                      "<option value='km'>km</option>" +
//                                  "</select>" +
//                              "</div>"
//                          );
                $("#filterSection").append(
                  "<div class='form-group'>" +
                  "<label for='featureName' class='center-align active'>Feature Name</label>" +
                  "<select id='featureName' class='form-control' required>" +
                  "<option value='' selected>Select</option>" +
                    "</select>" +
                  "</div>"
             ); $("#filterSection").append(
                  "<div class='form-group'>" +
                  "<label for='language' class='center-align active'>Language</label>" +
                  "<select id='language' class='form-control' required>" +
                  "<option value='' selected>Select</option>" +
                    "</select>" +
                  "</div>"
             );




                $('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")

                $("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='clearFilter'>Reset All</button></div>");
                $("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='table()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
                $("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");


                $('#clearFilter').attr("onclick", "filterReset('viewFilter')");
        /*        for(i=0; i<button.length; i++){
                $('#'+button[i].id).text(button[i].buttonTitle);
                $('#'+button[i].id).attr("onclick", button[i].buttonURL);

                }*/
                resolve();
            }
        });
    });
};


$('.datepicker').on('mousedown',function(event){
    event.preventDefault();
});

function filterDropdown(){
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
        headers:
            { 'X-CSRF-TOKEN': token }
    });

/*    $.getJSON('./getDropdownList/Feature_Name', function(data) {
        for (i = 0; i < data.length; i++) {
            $('<option>').val(data[i].interpretation).text(data[i].interpretation)
                .appendTo('#featureName ,#featureName-edit');
        }
    });


    $.getJSON('./getDropdownList/Language', function(data) {
        for (i = 0; i < data.length; i++) {
            $('<option>').val(data[i].interpretation).text(data[i].interpretation)
                .appendTo('#language ,#language-edit');
        }
    });*/
 $.ajax({
  url: "./eirs-response-param/distinct",
  data: JSON.stringify(["featureName", "language"]),
  dataType: 'json',
  contentType: 'application/json; charset=utf-8',
  type: 'POST',
  success: function(data) {
   const featureNameVal = data["featureName"];
   const languageVal = data["language"];
   for (let i = 0; i < featureNameVal.length; i++) {
    $('<option>').val(featureNameVal[i]).text(featureNameVal[i]).appendTo('#featureName ,#featureName-edit');
   }
   for (let i = 0; i < languageVal.length; i++) {
    $('<option>').val(languageVal[i]).text(languageVal[i]).appendTo('#language ,#language-edit');
   }
  },
  error: function() {
   // Handle errortail
  }
 });
}


function filterReset(formID){
    $('#'+formID).trigger('reset');
    $("label").removeClass('active');
    $('#errorMsg').text('');
    table();
}



function exportData(){

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
        headers:
            { 'X-CSRF-TOKEN': token }
    });
    $.ajax({
        url: './eirs-response-param/export',
        type: 'POST',
        dataType : 'json',
        contentType : 'application/json; charset=utf-8',
        data : JSON.stringify(payloadParameter()),
        success: function (data, textStatus, jqXHR) {
            finalURL(data.url);
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });

}




let findByID = (id) => {
let payload = payloadParameter();
window.xid = id;

// Create a request payload to fetch details by ID
let requestPayload = {
        "id": parseInt(id)
    };

// Setup CSRF token
var token = $("meta[name='_csrf']").attr("content");
    $.ajaxSetup({
    headers: { 'X-CSRF-TOKEN': token }
});

        $.ajax({
    url: "./eirs-response-param/ids",
            data: JSON.stringify(requestPayload),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            type: 'POST',
            success: function(data) {
        // Assuming the returned data structure aligns with eirs-response-param model
        $('#id-edit').val(data.id|| '');
        $('#type-edit').val(data.type|| '');
        $('#value-edit').val(data.value || '');
        $('#active-edit').val(data.active || '');
        $('#featureName-edit').val(data.featureName || '');
        $('#remarks-edit').val(data.remarks || '');
        $('#description-edit').val(data.description || '');
        $('#userType-edit').val(data.userType || '');
        $('#language-edit').val(data.language || '');
        $('#startDate-edit').val(data.startDate || '');
        $('#endDate-edit').val(data.endDate || '');
        $('#tag-edit').val(data.tag || '');

        // Populate the modal fields for editing
        $("#editModal").openModal({
                dismissible: false
            });
    },
    error: function() {
        // Handle error
        console.error("Failed to fetch details.");
    }
});
        };


let viewDetails = (id)=>{
$("#editModal").openModal({
    dismissible:false
});
findByID(id);

}


function update() {
    let request = payloadParameter();

    request['id'] = window.xid;
    request["auditTrailModel"]['columnName'] = request['language'] || 'en'; // Remove language handling if not needed


    // Get values from the modal fields
    request["description"] = $("#description-edit").val();
    request["value"] = $("#value-edit").val();
    request["featureName"] = $("#featureName-edit").val();
   // request["remarks"] = $("#remarks-edit").val();
    request["language"] = $("#language-edit").val();
  //  request["userType"] = $("#userType-edit").val();

    // Validate required fields
    if (!request.description || !request.value || !request.featureName || !request.language) {
        alert("Please fill all required fields.");
        return false;
    }

    // Prevent default form submission
    event.preventDefault();

    // Setup CSRF token
    var token = $("meta[name='_csrf']").attr("content");
    $.ajaxSetup({
            headers: { 'X-CSRF-TOKEN': token }
    });

    $.ajax({
            url: './eirs-response-param',
            type: 'PUT',
            data: JSON.stringify(request),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function(data) {
        $("#editModal").closeModal();
        $("#updateFieldsSuccess").openModal({
                dismissible: false
            });
        $('#updateFieldMessage').text('Eirs Response Param Data Updated Successfully.');
    },
    error: function() {
        // Handle error
        console.error("Failed to update.");
    }
    });

    return false;
}
//
//function update(event) {
//    event.preventDefault();
//
//    const data = {
//        type: document.getElementById('type-edit').value,
//        value: document.getElementById('value-edit').value,
//        feature_name: document.getElementById('feature_name-edit').value,
//        remarks: document.getElementById('remarks-edit').value,
//        user_type: document.getElementById('user_type-edit').value,
//        language: document.getElementById('language-edit').value,
//    };
//
//    fetch('/api/eirs-response-param/update', {
//        method: 'PUT',
//        headers: {
//            'Content-Type': 'application/json'
//        },
//        body: JSON.stringify(data)
//    })
//        .then(response => response.json())
//        .then(data => {
//            if (data.success) {
//                // Handle success, e.g., close modal and refresh the data table
//                $('#editModal').modal('hide');
//                // Refresh the data table or reload the page
//            } else {
//                // Handle failure, e.g., show an error message
//                alert('Failed to update the record.');
//            }
//        })
//        .catch(error => console.error('Error:', error));
//}

