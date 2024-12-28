var featureId = $("body").attr("data-featureId");
var {featureId,roleType,userId,currentRoleType,userTypeId,userName,
 startdate,endDate,lang,role,userType} = {
 featureId :featureId,
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
 // Determine the province value
 var provinceText = $('#province option:selected').text();
 var provinceValue = $('#province').val();
 var province = (provinceText === 'Select') ? isEmpty(provinceValue) : isEmpty(provinceText);
 var {startDate,endDate,featureTxnId,commune,district} = {
  featureTxnId : isEmpty($('#txn').val()),
  district : isEmpty($('#district').val()),
  commune : isEmpty($('#commune').val()),
  province: province,
  startDate : isEmpty($('#startDate').val()),
  endDate : isEmpty($('#endDate').val()),
 };
 var filterRequest=  {
  "commune" : commune,
  "language" : sessionStorage.getItem('lang')== null ? 'en' : sessionStorage.getItem('lang') ,
  "district" :district ,
  "province" :province,
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
 if(lang=='en'){
  var langFile='./resources/i18n/english_datatable.json';
 }

 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $.ajaxSetup({
  headers:
      { 'X-CSRF-TOKEN': token }
 });
 $.ajax({
  url: './headers?type=systemAddressHeaders',
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
    "language": {
     "sEmptyTable": "No records found in the system",
     "infoFiltered": ""
    },
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
     url : './address-management/paging',
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
   url: './address-management/page-rendering',
   type: 'POST',
   dataType: "json",
   success: function(data){
    var elem='<h1>'+data.pageTitle+'<h1>';
    $("#pageHeader").append(elem);
    $("#pageHeader").append('<div class="toggle-row ml-auto mr-4"></div>');
    $("#pageHeader").append("Language : &nbsp; <select id='langval'><option value='en'>EN</option><option value='km'>KM</option></select>");

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

    $('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")

    $("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='clearFilter'>Reset All</button></div>");
    $("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='table()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
    $("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");


    $('#clearFilter').attr("onclick", "filterReset('viewFilter')");
    /*    for(i=0; i<button.length; i++){
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
  url: './address-management/export',
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


function filterDropdown() {
 let lang = sessionStorage.getItem('lang') == null ? 'en' : sessionStorage.getItem('lang');
  $('#langval').val(lang);
 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $.ajaxSetup({ headers: { 'X-CSRF-TOKEN': token } });

 // Fetch and populate provinces
 $.ajax({
  url: "./address-management/distinctProvince",
  data: JSON.stringify(["province", "provinceKm" , "id"]),
  dataType: 'json',
  contentType: 'application/json; charset=utf-8',
  type: 'POST',
  success: function(data) {
   const provincesEn = data["province"];
   const provincesKm = data["provinceKm"];
   const ids = data["id"];
   for (let i = 0; i < provincesEn.length; i++) {
    $('<option>').val(ids[i]).text(provincesEn[i]).appendTo('#province,#province-edit');
   }
   for (let i = 0; i < provincesKm.length; i++) {
    $('<option>').val(ids[i]).text(provincesKm[i]).appendTo('#province-edit-kh,#province');
   }
  },
  error: function() {
   // Handle errortail
  }
 });

 // Fetch and populate districts
 $.ajax({
  url: "./address-management/distinctDistrict",
  data: JSON.stringify(["district", "districtKm"]),
  dataType: 'json',
  contentType: 'application/json; charset=utf-8',
  type: 'POST',
  success: function(data) {
   const districtsEn = data["district"];
   const districtsKm = data["districtKm"];
   for (const district of districtsEn) {
    $('<option>').val(district).text(district).appendTo('#district-edit,#district');
   }
   for (const district of districtsKm) {
    $('<option>').val(district).text(district).appendTo('#district-edit-kh,#district');
   }
  },
  error: function() {
   // Handle error
  }
 });

 // Fetch and populate communes
 $.ajax({
  url: "./address-management/distinctCommune",
  data: JSON.stringify(["commune", "communeKm"]),
  dataType: 'json',
  contentType: 'application/json; charset=utf-8',
  type: 'POST',
  success: function(data) {
   const communesEn = data["commune"];
   const communesKm = data["communeKm"];
   for (const commune of communesEn) {
    $('<option>').val(commune).text(commune).appendTo('#commune-edit,#commune');
   }
   for (const commune of communesKm) {
    $('<option>').val(commune).text(commune).appendTo('#commune-edit-kh,#commune');
   }
  },
  error: function() {
   // Handle error
  }
 });
}

let payload;
let findByID = (id)=>{
 let payload = payloadParameter();
 window.xid=id;

 var request ={
  "id" : parseInt(id)
 }

 payload=  {
  "id":id,
  "auditTraildDTO": {
   "roleType":roleType,
   "featureId":parseInt(featureId),
   "userTypeId": parseInt(userTypeId),
   "userType":roleType,
   "userName" : userName,
   "userId":parseInt(userId),
   "type" : parseInt($('#type').val()),
   "filterDTO": null
  }
 }

 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $.ajaxSetup({
  headers:
      { 'X-CSRF-TOKEN': token }
 });
 $.ajax({
  url : "./address-management/ids",
  data : JSON.stringify(payload),
  dataType : 'json',
  contentType : 'application/json; charset=utf-8',
  type : 'POST',
  success : function(data) {
   let language = payloadParameter();

   // Retrieve values from the database based on selected language
   let province =  data.value.province;
   let district = data.value.district ;
   let commune =data.value.commune;
   let provinceKm = data.value.provinceKm;
   let districtKm = data.value.districtKm;
   let communeKm = data.value.communeKm;

   // Set values for BOTH English and Khmer dropdown menus
   // Set the text of the dropdowns
   $('#province-edit option').filter(function() {
    return $(this).text() == province;
   }).prop('selected', true);

   $('#province-edit-kh option').filter(function() {
    return $(this).text() == provinceKm;
   }).prop('selected', true);
   $('#district-edit').val(district);
   $('#district-edit-kh').val(districtKm);
   $('#commune-edit').val(commune);
   $('#commune-edit-kh').val(communeKm);

   // Update payload with all values

  },
  error : function() {
  }
 });

};


let deleteAction = (id)=>{
 $('#confirmationModal').openModal({
  dismissible: false
 });
 window.delId=id;
};




let deleteByID = ()=>{
 let payload = payloadParameter();
 payload["id"]=window.delId;
 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $.ajaxSetup({
  headers:
      { 'X-CSRF-TOKEN': token }
 });
 $.ajax({
  url : "./address-management",
  data : JSON.stringify(payload),
  dataType : 'json',
  contentType : 'application/json; charset=utf-8',
  type : 'DELETE',
  success : function(data) {
/*   $('#modalTitle').text('');
   $('#updateFieldMessage').text('');
   $('#modalTitle').text('Delete Series');
   $('#updateFieldMessage').text('Successfully Deleted');

   $('#updateFieldsSuccess').openModal({
    dismissible: false
   });*/
     setTimeout(function() {location.reload();}, 100);
      window.parent.alertify.error("Record successfully deleted",4);
  },
  error : function() {
   window.parent.alertify.error("We encountered an unexpected error.Please try again later",4);
  }
 });

};



let viewDetails = (id)=>{
 $("#editModal").openModal({
  dismissible:false
 });
 findByID(id);

}



$(document).on('change', '#langval', function(){
 sessionStorage.setItem('lang', $('#langval').val());
 location.reload();
});


$(document).on('change', '#province-edit', function(){
 getmodelDistrict();
});



let getmodelDistrict= ()=> {
 var request = {
  "provinceId" : $("#province-edit").val()
 }
 console.log("Request payload:", request);
 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $.ajaxSetup({
  headers : {
   'X-CSRF-TOKEN' : token
  }
 });

 $.ajax({
  url : "./address-management/getDistrict",
  data : JSON.stringify(request),
  dataType : 'json',
  contentType : 'application/json; charset=utf-8',
  type : 'POST',
  success : function(data, textStatus, jqXHR) {
   //console.log("Response data:", data);
   var result = data;
   let language = payloadParameter();
   $('#district-edit').empty();
   var html='<option value="">Select</option>';
   $('#district-edit').append(html);
   if(language.language == 'en') {
    for (i = 0; i < result.length; i++) {
     var html='<option value="'+result[i].district+'">'+result[i].district+'</option>';
     $('#district-edit').append(html);
    }
   }
   else if(language.language == 'km') {
    for (i = 0; i < result.length; i++) {
     var html='<option value="'+result[i].districtKm+'">'+result[i].districtKm+'</option>';
     $('#district-edit').append(html);
    }
   }
  },
  error : function(jqXHR, textStatus, errorThrown) {
   $('#district-edit').empty();
   var html='<option value="">Select</option>';
   $('#district-edit').append(html);
  }
 });
}






$(document).on('change', '#district-edit', function(){
 getmodelCommune();
});


let getmodelCommune =()=> {

 var request = {
  "district" : $("#district-edit").val()
 }
 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $.ajaxSetup({
  headers : {
   'X-CSRF-TOKEN' : token
  }
 });
 $.ajax({
  url : "./address-management/getCommune",
  data : JSON.stringify(request),
  dataType : 'json',
  contentType : 'application/json; charset=utf-8',
  type : 'POST',
  success : function(data, textStatus, jqXHR) {
   var result = data;
   let language = payloadParameter();
   $('#commune-edit').empty();
   let html='<option value="">Select</option>';
   $('#commune-edit').append(html);
   if(language.language == 'en') {
    for (i = 0; i < result.length; i++) {
     let html='<option value="'+result[i].commune+'">'+result[i].commune+'</option>';
     $('#commune-edit').append(html);
    }
   }
   else if(language.language == 'km') {
    for (i = 0; i < result.length; i++) {
     let html='<option value="'+result[i].communeKm+'">'+result[i].communeKm+'</option>';
     $('#commune-edit').append(html);
    }
   }
  },
  error : function(jqXHR, textStatus, errorThrown) {
   $('#commune-edit').empty();
   let html='<option value="">Select</option>';
   $('#commune-edit').append(html);
  }
 });
}




function update(){

 let request = payloadParameter();

 let finalLangVal=request.language;
 request['id']=window.xid;
 request["auditTrailModel"]['columnName']=finalLangVal;

 request["commune"] = $("#commune-edit").val(),
     request["district"] = $("#district-edit").val(),
     request["province"] = $("#province-edit option:selected").text()

 if(request.commune =='' || request.district =='' || request.province ==''){
  return false;
 }


 request["communeKm"] = $("#commune-edit-kh").val(),
     request["districtKm"] = $("#district-edit-kh").val(),
     request["provinceKm"] = $("#province-edit-kh option:selected").text()
 if(request.communeKm =='' || request.districtKm =='' || request.provinceKm ==''){
  return false;
 }

 event.preventDefault();


 var token = $("meta[name='_csrf']").attr("content");
 var header = $("meta[name='_csrf_header']").attr("content");
 $.ajaxSetup({
  headers:
      { 'X-CSRF-TOKEN': token }
 });
 $.ajax({
  url: './address-management',
  type: 'PUT',
  data : JSON.stringify(request),
  dataType : 'json',
  contentType : 'application/json; charset=utf-8',
  success: function (data, textStatus, jqXHR) {
/*   $("#editModal").closeModal();
   $("#updateFieldsSuccess").openModal({
    dismissible:false
   });
   $('#updateFieldMessage').text('');
   $('#updateFieldMessage').text('Address List Updated Successfully.');*/
     setTimeout(function() {location.reload();}, 100);
    window.parent.alertify.success("Address list updated successfully",4);
  },
  error: function (jqXHR, textStatus, errorThrown) {
window.parent.alertify.error("We encountered an unexpected error.Please try again later",4);
  }
 });
 return false;
}
