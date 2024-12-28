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

let isEmpty = (x)=>{
if(x == undefined || x == ''){return null};
return x;
};

let payloadParameter =() => {


	$('div#initialloader').fadeIn('fast');
	var ellipsis = "...";
	var {startDate,endDate,requestMode,status,requestType,action,category,addedBy} = {
        requestMode : isEmpty($('#mode').val()),
        status :  isEmpty($('#status').val()),
        action : isEmpty($('#request').val()),
        startDate : isEmpty($('#startDate').val()),
        endDate : isEmpty($('#endDate').val()),
        category:isEmpty($('#category').val()),
        addedBy:isEmpty($('#uploadedby').val())
       };


    var filterRequest=  {
        "transactionId":isEmpty($('#transactionID').val()),
      "requestMode": requestMode,
      "status": status,
      "requestType": "BLOCK_LIST",
      "action":action,
      "category":category,
      "addedBy":addedBy,
      "uploadedBy": addedBy,
        "auditTrailModel": {
			"startDate":startDate,
			"endDate":endDate,
            "roleType":roleType,
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
    				url: './headers?type=eirsListMgmt',
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
    							url : './eirs-list-management/paging',
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
		url: './eirs-list-management/page-rendering?type=blocked-imei',
		type: 'POST',
		dataType: "json",
		success: function(data){
			var elem='<h1>'+data.pageTitle+'<h1>';
			 $("#pageHeader").append(elem);
			 $("#pageHeader").append('<div class="toggle-row ml-auto mr-4"></div>');
            $("#pageHeader").append("<button type='button' id='upload' class='btn btn-outline-dark mr-2' onclick='upload()'> + New </button>");
            $("#pageHeader").append('<a href="./view-block-imei?FeatureId=' + featureId + '" target="mainArea"><button type="button"  id="btnLink"  class="btn btn-outline-dark">View List</button></a>');

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


//
function filterDropdown(){

$.getJSON('./getDropdownList/BLOCKED_IMEI_CATEGORY_TYPE', function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].interpretation).text(data[i].interpretation)
					.appendTo('#form1-type,#form2-type,#category');
				}
			});

	$.getJSON('./getDropdownList/EIRS_LIST_MGMT_ACTION_TYPE', function(data) {
    				for (i = 0; i < data.length; i++) {
    					$('<option>').val(data[i].interpretation).text(data[i].interpretation)
    					.appendTo('#form1-action,#form2-action,#request');
    				}
    			});
 	$.getJSON('./getDropdownList/EXCEPTION_LIST_MODE', function(data) {
     				for (i = 0; i < data.length; i++) {
     					$('<option>').val(data[i].interpretation).text(data[i].interpretation)
     					.appendTo('#mode');
     				}
     			});
     				$.getJSON('./getDropdownList/EXCEPTION_LIST_STATUS', function(data) {
                    				for (i = 0; i < data.length; i++) {
                    					$('<option>').val(data[i].interpretation).text(data[i].interpretation)
                    					.appendTo('#status');
                    				}
                    			});
/*const param= ["requestMode","action","status"];
var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajaxSetup({
							headers:
							{ 'X-CSRF-TOKEN': token }
						});
						$.ajax({        url: './list-management-const',
                        				headers: {
                                                'Accept': 'application/json',
                                                'Content-Type': 'application/json'
                                            },
                        				type: 'POST',
                        				dataType: "json",
                        				data: JSON.stringify(param),
                        				success: function(result){
                        				for(const e of result['requestMode']){$('<option>').val(e).text(e).appendTo('#mode');}
                        				for (const e of result['status']){$('<option>').val(e).text(e).appendTo('#status');}
                        				}
                        				});*/
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
		url: './eirs-list-management/export',
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


let upload = ()=>  {
$('#form1').trigger('reset');
$('#form2').trigger('reset');
$('#errorDiv').html("");
//$('#form2-submit').addClass('disabled-btn');
            $("#NewRequest").openModal({dismissible:false});
            }



function singleRequest(type){
var {msisdn,imei,imsi} = {
msisdn:isEmpty($('#form1-msisdn').val()),
imei:isEmpty($('#form1-imei').val()),
imsi:isEmpty($('#form1-imsi').val())
};
$('#errorDiv').html("");
if(msisdn==null && imei==null && imsi==null){
 $('#errorDiv').html("One of the 3 fields IMEI , MSISDN, IMSI can't blank");
    return false;
    }


  var eirsListManagementEntity=  {
    "msisdn":msisdn,
    "imei":imei,
    "imsi":imsi,
    "requestMode": "Single",
     "status":"Init",
     "userId":userId,
    "category":isEmpty($('#form1-type').val()),
    "action":isEmpty($('#form1-action').val()),
    "remarks":isEmpty($('#form1-remarks').val()),
      "requestType": "BLOCK_LIST",
          "addedBy":userName,
        "auditTrailModel": {
            "roleType":roleType,
              "featureId":parseInt(featureId),
              "userTypeId": parseInt(userTypeId),
              "userType":roleType,
              "userName" : userName,
              "userId":parseInt(userId),
              "type" : parseInt($('#type').val())
    }
    };
var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url : "./eirs-list-management/single",
					data : JSON.stringify(eirsListManagementEntity),
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					type : 'POST',
					 beforeSend: function() {
                            $('#form1-submit').addClass('disabled');
                        },
                        complete: function() {
                            $('#form1-submit').removeClass('disabled');
                        },
					success: function (data, textStatus, jqXHR) {
			        $('#NewRequest').closeModal();

     otpSuccessModal(' Successfully saved and your Txn ID is : '+data.requestID);

        setTimeout(function() {
         window.location.href = './block-imei?FeatureId='+featureId;
     	}, 5000);


}
});
return false;
}


function bulkRequest(type){
if($("#fileInput").val()==""){
		return false;
	}

  var eirsListManagementEntity=  {
  "requestMode": "Bulk",
    "category":isEmpty($('#form2-type').val()),
    "action":isEmpty($('#form2-action').val()),
    "remarks":isEmpty($('#form2-remarks').val()),
      "requestType": "BLOCK_LIST",
          "addedBy":userName,
          "userId":userId,
        "auditTrailModel": {
            "roleType":roleType,
              "featureId":parseInt(featureId),
              "userTypeId": parseInt(userTypeId),
              "userType":roleType,
              "userName" : userName,
              "userId":parseInt(userId),
              "type" : parseInt($('#type').val())
    }
    };



    var formData = new FormData();
        formData.append("file",fileInput.files[0]);
    	formData.append("model",JSON.stringify(eirsListManagementEntity));
var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
    url : "./eirs-list-management/bulk",
    type: 'POST',
     beforeSend: function() {
                               $('#form2-submitButton').addClass('disabled');
                            },
    data: formData,
    mimeType: 'multipart/form-data',
    enctype: 'multipart/form-data',
    processData: false,
    contentType: false,
    async: false,
					success: function (data, textStatus, jqXHR) {
			        $('#NewRequest').closeModal();
const jsonObject = JSON.parse(data);
 otpSuccessModal(' File uploaded successfully and your Txn ID is : '+jsonObject.requestID);
                                setTimeout(function() {
                                  	  $('#form2-submit').removeClass('disabled');
                                     window.location.href = './block-imei?FeatureId='+featureId;
                             	}, 5000);
}
});
return false;
}



let action =(transactionID,type,fileName) => {

////console.log("fileName "+fileName+" and transactionID " +transactionID);

fileName=fileName.split("%20").join(" ");
	////////console.log(" fileName "+fileName+" fileType  "+fileType+" txnId "+txnId+"  doc_TypeTag "+doc_TypeTag)
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url : './eirs-list-management/download?fileName='+fileName+'&transactionID='+transactionID+'&type='+type,
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		type : 'GET',
		success : function(data) {
		var finalLink;
			var filePath = data.url+"/"+transactionID+"/"+fileName;
			if(type==="PROCESSED"){
			finalLink=filePath;
			}
			else{finalLink = filePath.split("webapps")[1];}

			window.location.href=finalLink;

		},
		error : function() {

		}
	});

}


$("#fileInput").change(function(){
	if($("#fileInput").val()!=""){
		$('#form2-submit').removeClass('disabled-btn');
	}
});




let viewByID = (id)=>{
	 $('#ViewModal').openModal({
                            	dismissible: false
                          	  });
  var eirsListManagementEntity=  {
    "id":parseInt(id),
        "auditTrailModel": {
            "roleType":roleType,
              "featureId":parseInt(featureId),
              "userTypeId": parseInt(userTypeId),
              "userType":roleType,
              "userName" : userName,
              "userId":parseInt(userId),
              "type" : parseInt($('#type').val())
    }
    };
var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url : "./eirs-list-management",
					data : JSON.stringify(eirsListManagementEntity),
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					type : 'POST',
					success: function (data, textStatus, jqXHR) {

					$('#view-msisdn').val(data['value']['msisdn']);
					$('#view-imei').val(data['value']['imei']);
					$('#view-imsi').val(data['value']['imsi']);
					$('#view-txnid').val(data['value']['transactionId']);
					$('#view-mode').val(data['value']['requestMode']);
					$('#view-status').val(data['value']['status']);
					$('#view-request-type').val(data['value']['action']);
					$('#view-category').val(data['value']['category']);

					$('#view-tac').val(data['value']['tac']);
					$('#view-filename').val(data['value']['fileName']);
					$('#view-quantity').val(data['value']['quantity']);
					$('#view-addedby').val(data['value']['user']['username']);

					$('#view-remarks').val(data['value']['remarks']);


}
});
return false;
}
