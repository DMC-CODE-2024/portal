var {featureId,roleType,userId,currentRoleType,userTypeId,userName,
startdate,endDate,lang,role,userType} = {
    featureId :$("body").attr("data-featureId"),
    roleType :$("body").attr("data-roleType"),
    userId :$("body").attr("data-userID"),
    currentRoleType : $("body").attr("data-selected-roleType"),
    userTypeId:	$("body").attr("data-userTypeID"),
    userType:	$("body").attr("data-roleType"),
    userName:	$("body").attr("data-selected-username"),
    startdate:	$('#startDate').val(),
    endDate:	$('#endDate').val(),
    lang:	    window.parent.$('#langlist').val() == 'km' ? 'km' : 'en',
    role :      this.currentRoleType === null ? roleType : this.currentRoleType
   };

   $(document).ready(function(){
   	$('div#initialloader').fadeIn('fast');
   	table();
   	pageRendering().then(() => filterDropdown());
   });

let payloadParameter =() => {

let isEmpty = (x)=>{
if(x == undefined || x == ''){return null};
return x;
};
	var ellipsis = "...";
	var featureName=isEmpty($('#featureName').val());
	var {modelName,manufacturer,manufacturingLocation,os,launchDate,simSlot,deviceType,tac} = {
        modelName : isEmpty($('#modelName').val()),
        manufacturer :  isEmpty($('#manufacturer').val()),
        manufacturingLocation : isEmpty($('#manufacturingLocation').val()),
        os:isEmpty($('#os').val()),
        launchDate: isEmpty($('#launchDate').val()),
        simSlot:	$('#simSlot').val(),
        deviceType:	isEmpty($('#deviceType').val()),
        tac:    isEmpty($('#tac').val())
       };


    var filterRequest=  {
        "modelName": modelName,
        "manufacturer": manufacturer,
        "manufacturingLocation": manufacturingLocation,
        "os": os,
        "simSlot": parseInt(simSlot),
        "deviceType": deviceType,
        "deviceId": tac,
        "auditTrailModel": {
        "startDate": launchDate,
        "roleType":roleType,
        "featureName" : featureName,
        "featureId":parseInt(featureId),
        "userTypeId": parseInt(userTypeId),
        "userType":roleType,
        "userName" : userName,
        "userId":parseInt(userId),
        "type" : parseInt($('#type').val()),
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
    				url: './headers?type=trc&requestType=NA',
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
    							url : './approve-device-tac/paging',
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
    						columnDefs: [{targets:[3], class:"columnwrap"}],
    						   drawCallback: function(settings) {
                                                   $('div#initialloader').delay(300).fadeOut('slow');
                                            }
    					});




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
		url: 'approve-device-tac/page-rendering?FeatureId='+featureId,
		type: 'POST',
		dataType: "json",
		success: function(data){

			var elem='<h1>'+data.pageTitle+'<h1>';
			$("#pageHeader").append(elem);
			var nextPageLink = '<a href="./approveTac/approved?FeatureId=' + featureId + '" target="mainArea"><button type="button"  id="btnLink"  class="btn btn-outline-dark"></button></a>';
			$("#pageHeader").append(nextPageLink);
			var button=data.buttonList;

			var date=data.inputTypeDateList;



				for(i=0; i<date.length; i++){
					if(date[i].type === "date"){
								$("#filterSection").append("<div class='form-group'>"+
								"<label for="+date[i].id+">"+date[i].title+"</label>"+
									"<input class='form-control text-uppercase' type='date' onchange='checkLaunchDate(launchDate)' id="+date[i].id+" autocomplete='off'>"
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
			$("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' id='submitFilter' onclick='table()'>Apply Filter <img src='./resources/assets/images/filter-icon.svg' alt='icon' class='img-fluid ml-1'></button></div>");
			$("#filterButtonSection").append("<div class='form-group'><button type='button' class='btn btn-outline-dark' onclick='exportData()'>Export <img src='./resources/assets/images/download-icon.svg' alt='icon' class='img-fluid ml-1'></button>");


			$('#clearFilter').attr("onclick", "filterReset('viewFilter')");
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);

			}
			resolve();
		}
});
	});
};


$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});



function filterDropdown(){
const param= ["os","deviceType","simSlot"];
var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajaxSetup({
							headers:
							{ 'X-CSRF-TOKEN': token }
						});
						$.ajax({        url: './adt',
                        				headers: {
                                                'Accept': 'application/json',
                                                'Content-Type': 'application/json'
                                            },
                        				type: 'POST',
                        				dataType: "json",
                        				data: JSON.stringify(param),
                        				success: function(result){
                        				for (const e of result['os']){$('<option>').val(e).text(e).appendTo('#os');}
                        				for (const e of result['deviceType']){$('<option>').val(e).text(e).appendTo('#deviceType');}
                        				for (const e of result['simSlot']){$('<option>').val(e).text(e).appendTo('#simSlot');}
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
		url: './approve-device-tac/export',
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

var actionPayload;
let action = (id,action)=>  {
            if(action==='APPROVED')
            $("#approveModal").openModal({dismissible:false});

			else if(action==='REJECT')
            $("#rejectModal").openModal({dismissible:false});


	actionPayload = {
            "auditTrailModel": {
            "roleType":roleType,
            "featureId":parseInt(featureId),
            "userTypeId": parseInt(userTypeId),
            "userType":roleType,
            "userName" : userName,
            "userId":parseInt(userId),
            "type" : parseInt($('#type').val()),
                },
	        "id": parseInt(id),
            "action": action,
            "approvedBy": userName
	                }
}

function approveAndRejectAction(){

    actionPayload["remark"]= actionPayload.action==='APPROVED' ? $('#approvalRemarks').val() : $('#rejectRemarks').val();

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './approve-device-tac',
		type: 'POST',
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(actionPayload),
		success: function (data, textStatus, jqXHR) {
			window.location.href = './approveTac?FeatureId='+featureId;
		},
		error: function (jqXHR, textStatus, errorThrown) {

		}
	});
	return false;
}

function ResetModel(){
	$("#approvalRemarks").val("");
	$("#rejectRemarks").val("");
};