var {featureId,roleType,userId,currentRoleType,userTypeId,userName,
startdate,endDate,lang,role,userType} = {
    featureId :90,
    roleType :$("body").attr("data-roleType"),
    userId :$("body").attr("data-userID"),
    currentRoleType : $("body").attr("data-selected-roleType"),
    userTypeId:	$("body").attr("data-userTypeID"),
    userType:	$("body").attr("data-roleType"),
    userName:	$("body").attr("data-selected-username"),
    startdate:	$('#startDate').val(),
    endDate:	$('#endDate').val(),
    lang:	window.parent.$('#langlist').val() == 'km' ? 'km' : 'en',
    role : this.currentRoleType === null ? roleType : this.currentRoleType
   };


   $(document).ready(function(){
   	$('div#initialloader').fadeIn('fast');
   	table();
   	pageRendering().then(() => filterDropdown());
   });

let isEmpty = (x)=>{
if(x == undefined || x == ''){return null};
return x;
};
 var filterRequest;
let payloadParameter =() => {

	$('div#initialloader').fadeIn('fast');
	var ellipsis = "...";
	var {startDate,endDate,requestMode,status,requestType,action,operatorName,remarks,seriesEnd,seriesStart,seriesType} = {
        requestMode : isEmpty($('#mode').val()),
        status :  isEmpty($('#status').val()),
        action : isEmpty($('#request').val()),
        startDate : isEmpty($('#startDate').val()),
        endDate : isEmpty($('#endDate').val()),
        operatorName:isEmpty($('#operatorName').val()),
        remarks:isEmpty($('#remarks').val()),
        seriesEnd:isEmpty($('#seriesEnd').val()),
        seriesStart:isEmpty($('#seriesStart').val()),
        seriesType:isEmpty($('#seriesType').val())
       };
    filterRequest=  {
    "userName":isEmpty($('#userid').val()),
        "operatorName":operatorName,
        "remarks":remarks,
        "seriesEnd": seriesEnd,
        "seriesStart": seriesStart,
        "seriesType": seriesType,
        "auditTraildDTO": {
        "roleType":roleType,
        "featureId":parseInt(featureId),
        "userTypeId": parseInt(userTypeId),
        "userType":roleType,
        "userName" : userName,
        "userId":parseInt(userId),
        "type" : parseInt($('#type').val()),
        "filterDTO": {
            "columnName": null,
            "sort": null,
            "filter": false,
            "endDate":endDate,
            "startDate":startDate
            }
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
    				url: './headers?type=msisdn',
    				type: 'POST',
    				dataType: "json",
    				success: function(result){
    					var table=	$("#server-side-table").DataTable({
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
    							url : './msisdn-series/paging',
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
		url: './msisdn-series/page-rendering',
		type: 'POST',
		dataType: "json",
		success: function(data){
			var elem='<h1>'+data.pageTitle+'<h1>';
			 $("#pageHeader").append(elem);
			 $("#pageHeader").append('<div class="toggle-row ml-auto mr-4"></div>');

            //$("#pageHeader").append('<a href="./msisdn-series-add-series" target="mainArea"><button type="button"  id="btnLink"  class="btn btn-outline-dark">Add Series</button></a>');
            $("#pageHeader").append('<button type="button"  id="btnLink"  onclick="add()" class="btn btn-outline-dark">Add Series</button>');


			/*var nextPageLink = '<a href="./approveTac/approved?FeatureId=84" target="mainArea"><button type="button"  id="btnLink"  class="btn btn-outline-dark"></button></a>';
			$("#pageHeader").append(nextPageLink);
*/
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
		/*	for(i=0; i<button.length; i++){
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


//
function filterDropdown(){

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});

$.getJSON('./getDropdownList/OPERATOR_SERIES', function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].interpretation).text(data[i].interpretation)
					.appendTo('#seriesType,#form1-seriesType,#form2-seriesType');
				}
			});


$.getJSON('./getDropdownList/OPERATORS_NAME', function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].interpretation).text(data[i].interpretation)
					.appendTo('#operatorName,#form1-operatorName,#form2-operatorName');
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
		url: './msisdn-series/export',
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



let add = ()=>{
$('#form1').trigger('reset');
//$('#form2').trigger('reset');
 $('#addModal').openModal({
    	dismissible: false
  	  });

};



let addSeries = ()=> {
var {seriesEnd,seriesStart} = {
              seriesEnd: $('#form1-seriesEnd').val(),
              seriesStart: $('#form1-seriesStart').val()
};

if(seriesStart>seriesEnd){
 $('#errorDiv').html("Value of series start should be less than series end");
return false;
}

if(seriesStart=='' || seriesEnd==''){
return false;
}
if($('#form1-length').val()==''){
return false;
}


 var payload=  {
              "operatorName":$('#form1-operatorName').val(),
              "remarks":$('#form1-remarks').val(),
              "seriesEnd": seriesEnd,
              "seriesStart": seriesStart,
              "seriesType": $('#form1-seriesType').val(),
              "userId":parseInt(userId),
              "length":$('#form1-length').val(),
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
					url : "./msisdn-series",
					data : JSON.stringify(payload),
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					type : 'POST',
					success: function (data, textStatus, jqXHR) {
	$('#modalTitle').text('');
		$('#updateFieldMessage').text('');
$('#modalTitle').text('Add Series');
    setTimeout(function() {
      location.reload();
    }, 100); // A short delay to allow the message to be displayed
window.parent.alertify.success('Operator series saved successfully',4);


/*		$('#updateFieldMessage').text('Record successfully saved');

		 $('#updateFieldsSuccess').openModal({
            	dismissible: false
          	  });*/
					},
					error: function (jqXHR, textStatus, errorThrown) {
window.parent.alertify.success('Oops! Something went wrong on our end',4);
					}
				});
				return false;


};


$('#form1-seriesType,#form2-seriesType').change(function() {
let imsiMsg='InvalidMsg(this,"input","Please enter 5 digit number which start from 456");';
let msisdnMsg='InvalidMsg(this,"input","Please enter 5 digit number which start from 855");';
let imsiPattern='^(456\\d{2})$';
let msisdnPattern='^(855\\d{2})$';
let imsi_tag="EL_IMSI_LENGTH";
let msisdn_tag="EL_MSISDN_LENGTH";
let imsiLengthVal = $("#form2-length").attr("imsiLengthVal");
let msisdnLengthVal = $("#form2-length").attr("msisdnLengthVal");

   $('#errorDiv,#errorDivForm2').html("");
   if($('#form1-seriesType').val()==='imsi'){
    $("#form1-seriesStart,#form1-seriesEnd").attr({pattern: imsiPattern,
           oninput: imsiMsg,
           oninvalid: imsiMsg});
                $('#form1-seriesEnd').val('');
                    $('#form1-seriesStart').val('');
                    setLength(imsi_tag);
   }
   else if($('#form1-seriesType').val()==='msisdn'){
       $("#form1-seriesStart,#form1-seriesEnd").attr({pattern: msisdnPattern,
       oninput: msisdnMsg,
       oninvalid: msisdnMsg});
       $('#form1-seriesEnd').val('');
         $('#form1-seriesStart').val('');
          setLength(msisdn_tag);
      }
       else if($('#form2-seriesType').val()==='imsi'){
             $('#form2-seriesStart').val('');
            $('#form2-seriesEnd').val('');

          $("#form2-seriesStart,#form2-seriesEnd").attr({pattern: imsiPattern,
                 oninput: imsiMsg,
                 oninvalid: imsiMsg});
                    $('#form2-seriesEnd').val('');
                    $('#form2-seriesStart').val('');

            $('#form2-seriesStart').val($("#form2-seriesStart").attr("imsiSeriesStart"));
            $('#form2-seriesEnd').val($("#form2-seriesEnd").attr("imsiSeriesEnd"));
            setLength(imsi_tag,imsiLengthVal);

         }
         else if($('#form2-seriesType').val()==='msisdn'){
             $("#form2-seriesStart,#form2-seriesEnd").attr({pattern: msisdnPattern,
             oninput: msisdnMsg,
             oninvalid: msisdnMsg});
             $('#form2-seriesEnd').val('');
             $('#form2-seriesStart').val('');
                           $('#form2-seriesStart').val($("#form2-seriesStart").attr("msisdnSeriesStart"));
                                $('#form2-seriesEnd').val($("#form2-seriesEnd").attr("msisdnSeriesEnd"));
                      setLength(msisdn_tag,msisdnLengthVal);
            }
  });

function validateForm(form,event){
const start=form.start.value;
const end=form.end.value;

if(start=='' || end==''){
return false;
}

if(start>end){
 $('#errorDivForm2').html("Value of series start should be less than series end");
 event.preventDefault();
return false;
}
if($('#form2-length').val()==''){
return false;
}

return true;


}



let updateSeries = (event)=> {
 let {start,end} = {
                        end: $('#form2-seriesEnd').val(),
                        start: $('#form2-seriesStart').val()
          };

const form=document.getElementById("form2");

if(!validateForm(form,event)){return;}
 event.preventDefault();

 let payload=  {
 "id":window.xid,
              "operatorName":$('#form2-operatorName').val(),
              "remarks":$('#form2-remarks').val(),
              "seriesEnd": end,
              "seriesStart": start,
              "seriesType": $('#form2-seriesType').val(),
              "userId":parseInt(userId),
              "length":$('#form2-length').val(),
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
                					url : "./msisdn-series",
                					data : JSON.stringify(payload),
                					dataType : 'json',
                					contentType : 'application/json; charset=utf-8',
                					type : 'PUT',
                					success: function (data, textStatus, jqXHR) {
                	$('#modalTitle').text('');
                		$('#updateFieldMessage').text('');
                $('#modalTitle').text('Edit Series');
         /*       		$('#updateFieldMessage').text('Record successfully updated');

                		 $('#updateFieldsSuccess').openModal({

                            	dismissible: false
                          	  });*/
                          	      setTimeout(function() {
                                    location.reload();
                                  }, 100); // A short delay to allow the message to be displayed
                              window.parent.alertify.success('Operator series updated successfully',4);

                					},
                					error: function (jqXHR, textStatus, errorThrown) {
                					}
                				});
//form.submit();

                return false;
                };




function updateAction(id){
$('#form1,#form2').trigger('reset');
window.xid=id;
 $('#updateModal').openModal({
    	dismissible: false
  	  });
var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./msisdn-series/"+id,
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		success : function(data) {
$('#form2-operatorName').val(data.operatorName);
let onChangePromise = new Promise(function(myResolve, myReject) {
$('#form2-seriesType').val(data.seriesType).trigger('change');
setTimeout(function() { myResolve(); }, 1000);
});
$('#form2-seriesStart').val(data.seriesStart);
$('#form2-seriesEnd').val(data.seriesEnd);
$('#form2-remarks').val(data.remarks);

   if(data.seriesType==='msisdn'){
      $("#form2-seriesStart").attr({msisdnSeriesStart: data.seriesStart});
      $("#form2-seriesEnd").attr({msisdnSeriesEnd: data.seriesEnd});
      $("#form2-length").attr({msisdnLengthVal: data.length});
   }
   else if(data.seriesType==='imsi') {
         $("#form2-seriesStart").attr({imsiSeriesStart: data.seriesStart});
         $("#form2-seriesEnd").attr({imsiSeriesEnd: data.seriesEnd});
        $("#form2-length").attr({imsiLengthVal: data.length})

   }

   onChangePromise.then(() => $("#form2-length").val(data.length));

    $('#form2-length').val($("#form2-seriesEnd").attr("lengthVal"));
	},
		error : function() {
		}
	});

}

let payload;
let deleteAction = (id)=>{

 $('#confirmationModal').openModal({
    	dismissible: false
  	  });
  	   payload=  {
  	   "id":id,
  	   "userId":parseInt(userId),
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
};


let deleteByID = ()=>{
          //console.log(JSON.stringify(payload));
var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : "./msisdn-series",
		data : JSON.stringify(payload),
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'DELETE',
		success : function(data) {
			$('#modalTitle').text('');
        		$('#updateFieldMessage').text('');
		$('#modalTitle').text('Delete Series');
/*		$('#updateFieldMessage').text('Successfully Deleted');

		 $('#updateFieldsSuccess').openModal({
            	dismissible: false
          	  });*/
          	      setTimeout(function() {
                    location.reload();
                  }, 100); // A short delay to allow the message to be displayed
              window.parent.alertify.error('Operator series record successfully deleted',4);

	},
		error : function() {
			//alert("Failed");
		}
	});

};




function setLength(tag,v){

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	let promise = new Promise(function(resolve, myReject) {

$.getJSON('./getDropdownList/'+tag, function(data) {

$('#form1-length, #form2-length').empty();
$('<option>').val('').text('Select').prependTo('#form1-length, #form2-length');
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].interpretation).text(data[i].interpretation)
					.appendTo('#form1-length,#form2-length');
				}
			});
			setTimeout(function() { resolve(); }, 1000);
                });
                promise.then(() => $("#form2-length").val(v));


   	}
