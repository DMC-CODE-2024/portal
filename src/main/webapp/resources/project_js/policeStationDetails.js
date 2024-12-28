
$('#langlist').on('change', function() {
	//lang=$('#langlist').val() == 'km' ? 'km' : 'en';
	//var lang = window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

	//var url_string = window.location.href;
	//var url = new URL(url_string);
	//var type = url.searchParams.get("type");
	//window.location.assign("./policeTrackLostDevice?FeatureId=101&lang="+lang);
	var selectedLanguage = document.getElementById('langlist').value;
    // Get selected language
    window.location.href ='?lang='+ selectedLanguage;
});
var featureId = $("body").attr("data-featureid");
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType");
var startdate=$('#startDate').val();
var endDate=$('#endDate').val();

var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

//var lang = $("body").attr("data-lang");

$.i18n().locale = lang;
/*$.i18n().locale = "en";*/

$.i18n().load({
    'en' : './resources/i18n/en.json',
    'km' : './resources/i18n/km.json'
}).done(function() {
});



function loadEnCSS() {

    if(filesAdded.indexOf('../resources/asset/css/en.css') !== -1)
        return

    var head = document.getElementsByTagName('head')[0]

    // Creating link element
    var style = document.createElement('link')
    style.href = '../resources/asset/css/en.css'
    style.type = 'text/css'
    style.rel = 'stylesheet'
    head.append(style);

    // Adding the name of the file to keep record
    filesAdded += ' ../resources/asset/css/en.css'
  }
  function loadKmCSS() {

    if(filesAdded.indexOf('../resources/asset/css/en.css') !== -1)
        return

    var head = document.getElementsByTagName('head')[0]

    // Creating link element
    var style = document.createElement('link')
    style.href = '../resources/asset/css/en.css'
    style.type = 'text/css'
    style.rel = 'stylesheet'
    head.append(style);

    // Adding the name of the file to keep record
    filesAdded += ' ../resources/asset/css/en.css'
  }

$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	Datatable();
	pageRendering();
	filterDropdown();

});

function Datatable(){
	$('div#initialloader').fadeIn('fast');
	var payload={
			"province" : $('#province').val()==""  ? null : $('#province').val(),
			"commune" : $('#commune').val()==""  ? null : $('#commune').val(),
			"district" : $('#district').val()==""  ? null : $('#district').val(),
			"police" : $('#police').val()==""  ? null : $('#police').val(),
			"msisdn" : $('#contact').val()==""  ? null : $('#contact').val(),
			"name" : $('#name').val()==""  ? null : $('#name').val(),
			"auditTrailModel":{
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"userName" : $("body").attr("data-selected-username"),
 			}
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'headers?type=policeStationDetailsHeaders',
		type: 'POST',
		dataType: "json",
		success: function(result){
			/*//////console.log("Url-------" +url+"--------"+ "dataUrl-------" +dataUrl);*/
			var table=	$("#LibraryTable").removeAttr('width').DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : true,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"bSearchable" : true,
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
					url : './policeStationDetail',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(payload);
						////////console.log(JSON.stringify(filterRequest));
					}

				},
				"columns": result,
				fixedColumns: true,
			});
			$('div#initialloader').delay(300).fadeOut('slow');

		},
		error: function (jqXHR, textStatus, errorThrown) {
			////////console.log("error in ajax");
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
    url: './policeDetails/pageRendering',
    type: 'POST',
    dataType: "json",
    success: function(data){
    var elem='<h1>'+data.pageTitle+'<h1>';
    $("#pageHeader").append(elem);
    $("#pageHeader").append('<div class="toggle-row ml-auto mr-4"></div>');
    var button=data.buttonList;
    var date=data.inputTypeDateList;
    var startdate=$('#viewstartDate').val();
    var endDate=$('#viewEndDate').val();
    console.log("ful vl== "+date);
				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){
								$("#filterButtonDiv").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='validDate(viewstartDate,viewEndDate)' id="+date[i].id+" autocomplete='off'>"
									);
								}
					else if(date[i].type === "text"){
						//$("#registrationTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='60' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
						$("#filterButtonDiv").append("<div class='form-group'><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label><input type="+date[i].type+" class='form-control' id="+date[i].id+" placeholder='Enter here' maxlength='19'/></div>");

					}
					else if(date[i].type === "select"){
					var dropdownDiv=
							$("#filterButtonDiv").append(
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

    var viewFilter="viewFilter";


			$('#errorMsgDiv').append("<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;' class='left'></p>")

  	$("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='clearFilter'>Reset All</button></div>");
    $("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' id='historyFilter' class='btn btn-outline-dark' onclick='Datatable()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button>");
    $("#registrationTableButtonDiv").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>"+$.i18n('Export')+" <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");

  $('#clearFilter').attr("onclick", "filterReset('filterform')");
  resolve();
    }
    });
    });
    };


    $('.datepicker').on('mousedown',function(event){
    event.preventDefault();
    });


    function exportData()
    {


    	var filterRequest={

            "province" : $('#province').val()==""  ? null : $('#province').val(),
			"commune" : $('#commune').val()==""  ? null : $('#commune').val(),
			"district" : $('#district').val()==""  ? null : $('#district').val(),
			"police" : $('#police').val()==""  ? null : $('#police').val(),
			"msisdn" : $('#contact').val()==""  ? null : $('#contact').val(),
			"name" : $('#name').val()==""  ? null : $('#name').val(),
			"auditTrailModel":{
				"userId":parseInt(userId),
				"featureId":parseInt(featureId),
				"userTypeId": parseInt($("body").attr("data-userTypeID")),
				"userType":$("body").attr("data-roleType"),
				"userName" : $("body").attr("data-selected-username"),
 			}


    	}


    	var token = $("meta[name='_csrf']").attr("content");
    	var header = $("meta[name='_csrf_header']").attr("content");
    	$.ajaxSetup({
    		headers:
    		{ 'X-CSRF-TOKEN': token }
    	});

    	$.ajax({
    		url: './exportPoliceDetails',
    		type: 'POST',
    		dataType : 'json',
    		contentType : 'application/json; charset=utf-8',
    		data : JSON.stringify(filterRequest),
    		success: function (data, textStatus, jqXHR) {
    			  finalURL(data.url);

    		},
    		error: function (jqXHR, textStatus, errorThrown) {

    		}
    	});

    }


    function filterReset(formID){
    	$('#'+formID).trigger('reset');
    	$("label").removeClass('active');
    	$('#errorMsg').text('');
    	Datatable(lang,null);
    }


function filterDropdown() {
 // Fetch and populate provinces
 $.ajax({
  url: "./policeStation/distinctProvince",
  data: JSON.stringify(["province", "id"]),
  dataType: 'json',
  contentType: 'application/json; charset=utf-8',
  type: 'POST',
  success: function(data) {
   const provincesEn = data["province"];
   const ids = data["id"];
   for (let i = 0; i < provincesEn.length; i++) {
    $('<option>').val(ids[i]).text(provincesEn[i]).appendTo('#province');
   }

  },
  error: function() {
   // Handle errortail
  }
 });

 // Fetch and populate districts
 $.ajax({
  url: "./policeStation/distinctDistrict",
  data: JSON.stringify(["district", "id"]),
  dataType: 'json',
  contentType: 'application/json; charset=utf-8',
  type: 'POST',
  success: function(data) {
   const districtsEn = data["district"];
   const ids = data["id"];
   for (let i = 0; i < districtsEn.length; i++) {
    $('<option>').val(ids[i]).text(districtsEn[i]).appendTo('#district');
   }

  },
  error: function() {
   // Handle error
  }
 });

 // Fetch and populate communes
 $.ajax({
  url: "./policeStation/distinctCommune",
  data: JSON.stringify(["commune", "id"]),
  dataType: 'json',
  contentType: 'application/json; charset=utf-8',
  type: 'POST',
  success: function(data) {
   const communesEn = data["commune"];
   const ids = data["id"];
   for (let i = 0; i < communesEn.length; i++) {
    $('<option>').val(ids[i]).text(communesEn[i]).appendTo('#commune');
   }
  },
  error: function() {
   // Handle error
  }
 });

  // Fetch and populate police
  $.ajax({
   url: "./policeStation/distinctPoliceStation",
   data: JSON.stringify(["police", "id"]),
   dataType: 'json',
   contentType: 'application/json; charset=utf-8',
   type: 'POST',
   success: function(data) {
    const policeEn = data["police"];
    const ids = data["id"];
    for (let i = 0; i < policeEn.length; i++) {
     $('<option>').val(ids[i]).text(policeEn[i]).appendTo('#police');
    }
   },
   error: function() {
    // Handle error
   }
  });
}

