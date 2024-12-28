var cierRoletype = sessionStorage.getItem("cierRoletype");
var roleType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var currentRoleType = $("body").attr("data-selected-roleType"); 
var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';

/*window.parent.$('#langlist').on('change', function() {
	var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	var url_string = window.location.href;
	var url = new URL(url_string);
	var type_val = url.searchParams.get("type"); 
	window.location.assign("./greyList?type="+type_val+"&lang="+lang);				
}); */

$.i18n().locale = lang;	

$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
} ).done( function() { 
});


$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	operatorDatatable(lang);
	pagetitle(lang);
	
});


if(window.location.search == "?type=greyList?FeatureId=9"){
	window.serviceDump = 0
}else{
	window.serviceDump = 1
}




//**************************************************Registration table**********************************************

function operatorDatatable(lang){
$('div#initialloader').fadeIn('fast');
	var fileType = $("#fileType").val();
	var filterRequest={
			"endDate":$('#endDate').val(),
			"startDate":$('#startDate').val(),
			"serviceDump" : serviceDump,
			"fileType" : parseInt(fileType),
			"fileName" : $('#filename').val(),
			"userId":parseInt(userId),
			"userTypeId": parseInt($("body").attr("data-userTypeID")),
			"userType":$("body").attr("data-roleType"),
			"featureId":parseInt(featureId),
			"userName":$("body").attr("data-selected-username"),
			"roleType":$("body").attr("data-roleType")
		}
	
		if(lang=='km'){
				var langFile="./resources/i18n/khmer_datatable.json";
			}else if(lang=='en'){
				var langFile='./resources/i18n/english_datatable.json';
			}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'headers?type=greyBlackList&lang='+lang,
		type: 'POST',
		dataType: "json",
		success: function(result){
			/*////console.log("Url-------" +url+"--------"+ "dataUrl-------" +dataUrl);*/
			var table=	$("#operatorLibraryTable").DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : true,
				"bPaginate" : true,
				"bFilter" : false,
				"bInfo" : true,
				"bSearchable" : true,
				"oLanguage": {  
							"sUrl": langFile  
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
					url : 'operatorData',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(filterRequest); 
						//////console.log(JSON.stringify(filterRequest));
					},
					error: function (jqXHR, textStatus, errorThrown,data) {
						
						 window.parent.$('#msgDialog').text($.i18n('500ErrorMsg'));
						 // messageWindow(jqXHR['responseJSON']['message']);
						 window.parent.$('#500ErrorModal').openModal({
						 dismissible:false
						 });
						
					}

				},
				"columns": result,
				columnDefs : [
					{ orderable: false, targets: -1 }
					]
			});
			
			$('#operatorLibraryTable input').unbind();
		   $('div#initialloader').delay(300).fadeOut('slow');
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax");
		}
	});
}

function pagetitle(lang){
var url_string = window.location.href;
	var url = new URL(url_string);
	var type = url.searchParams.get("type");
pageRendering("operator/pageRendering?featureType="+type+"&lang="+lang);
	
}


//**************************************************Registration page buttons**********************************************

function pageRendering(URL){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: URL,
		type: 'POST',
		dataType: "json",
		success: function(data){
			data.userStatus == "Disable" ? $('#btnLink').addClass( "eventNone" ) : $('#btnLink').removeClass( "eventNone" );
			
			var elem='<p class="PageHeading">'+data.pageTitle+'</p>';		
			$("#pageHeader").append(elem);
			var button=data.buttonList;
			var date=data.inputTypeDateList;
			for(i=0; i<date.length; i++){
				if(date[i].type === "date"){
					$("#operatorTableDiv").append("<div class='input-field'>"+
							"<div id='enddatepicker' class='input-group'>"+
							"<input class='form-control datepicker' type='text' id="+date[i].id+" autocomplete='off' onchange='checkDate(startDate,endDate)'>"+
							"<label for="+date[i].id+">"+date[i].title
							+"</label>"+
							"<span	class='input-group-addon' style='color: #ff4081'>"+
							"<i	class='fa fa-calendar' aria-hidden='true' style='float: right; margin-top: -37px;'>"+"</i>"+"</span>");
					$( "#"+date[i].id ).datepicker({
						dateFormat: "yy-mm-dd",
						 maxDate: new Date()
			        });
				}else if(date[i].type === "text"){
					$("#operatorTableDiv").append("<div class='input-field' ><input type="+date[i].type+" id="+date[i].id+" maxlength='50' /><label for="+date[i].id+" class='center-align'>"+date[i].title+"</label></div>");
				}else if(date[i].type === "select"){
					var dropdownDiv=
						$("#operatorTableDiv").append("<div class='selectDropdwn'>"+
								
								"<div class='select-wrapper select2  initialized'>"+
								"<span class='caret'>"+"</span>"+
								"<input type='text' class='select-dropdown' readonly='true' data-activates='select-options-1023d34c-eac1-aa22-06a1-e420fcc55868' value='Consignment Status'>"+

								"<select id="+date[i].id+" class='select2 initialized'>"+
								"<option value='-1' selected>"+date[i].title+
								"</option>"+
								"</select>"+
								"</div>"+
						"</div>");
				}
				 
			} 
		
			var viewFilter="viewFilter";
			$("#operatorTableDiv").append("<div class='filter_btn'><button class='btn primary botton' type='button' id='submitFilter'></button></div>");
			$("#operatorTableDiv").append("<div class='filter_btn'><button type='button' class='btn primary botton' id='clearFilter'>"+$.i18n('clearFilter')+"</button></div>");
			$("#operatorTableDiv").append("<div class='filter_btn'><a onclick='exportButton()' type='button' class='export-to-excel right'>"+$.i18n('Export')+" <i class='fa fa-file-excel-o' aria-hidden='true'></i></a></div>");
			$('#clearFilter').attr("onclick", "Resetfilter('viewFilter')");
			for(i=0; i<button.length; i++){
				$('#'+button[i].id).text(button[i].buttonTitle);
				$('#'+button[i].id).attr("onclick", button[i].buttonURL);
			
			}
		
			
			//File Type-----------dropdown
			$.getJSON('./getDropdownList/FILE_TYPE', function(data) {
				for (i = 0; i < data.length; i++) {
					$('<option>').val(data[i].value).text(data[i].interp)
					.appendTo('#fileType');
				}
			});
			
			$("#btnLink").css({display: "none"}) 
			
		}
		
}); 

};




function myFunction(message) {
	var x = document.getElementById("snackbar");
	x.className = "show";
	$('#errorMessage').html(message);
	setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}

function dispatchDateValidation(){
	var currentDate;
	var dispatcDate=  $('#expectedDispatcheDate').val();
	var now=new Date();
	if(now.getDate().toString().charAt(0) != '0'){
		currentDate='0'+now.getDate();

		/ alert("only date="+currentDate); /
	}
	else{
		currentDate=now.getDate();
	}
	var today = now.getFullYear()+ '-' + (now.getMonth()+1)+ '-' +currentDate ;
	//alert("today"+today);
	//////console.log("dispatche="+dispatcDate);
	//////console.log("todays parse date"+Date.parse(today));
	//////console.log("dispatche parse date"+Date.parse(dispatcDate));


	if(Date.parse(today)>Date.parse(dispatcDate))
	{
		myFunction("dispatche date should be greater then or equals to today");
		$('#expectedDispatcheDate').val("");
	}

	//alert("current date="+today+" dispatche date="+dispatcDate)
}

function arrivalDateValidation(){
	var currentDate;
	var dispatcDate=  $('#expectedArrivalDate').val();
	var now=new Date();
	if(now.getDate().toString().charAt(0) != '0'){
		currentDate='0'+now.getDate();

		/ alert("only date="+currentDate); /
	}
	else{
		currentDate=now.getDate();
	}
	var today = now.getFullYear()+ '-' + (now.getMonth()+1)+ '-' +currentDate ;
	//alert("today"+today);
	////console.log("dispatche="+dispatcDate);
	//////console.log("todays parse date"+Date.parse(today));
	//////console.log("dispatche parse date"+Date.parse(dispatcDate));


	if(Date.parse(today)>Date.parse(dispatcDate))
	{
		myFunction("Arrival date should be greater then or equals to today");
		$('#expectedArrivalDate').val("");
	}
	//alert("current date="+today+" dispatche date="+dispatcDate)
}

$('.datepicker').on('mousedown',function(event){
	event.preventDefault();
});



function exportButton(){
	
	var startDate=$('#startDate').val();
	var endDate = $('#endDate').val();
	var userTypeId= parseInt($("body").attr("data-userTypeID"));
	var userType=$("body").attr("data-roleType");
	var serviceDump= window.serviceDump;
	var fileType = $("#fileType").val();
	var fileName = $('#filename').val();

	
	var table = $('#operatorLibraryTable').DataTable();
	var info = table.page.info(); 
    var pageNo=info.page;
    var pageSize =info.length;
	//////console.log("--------"+pageSize+"---------"+pageNo);
	//////console.log("startdate ="+startDate+"  endDate=="+endDate+"userTypeId ="+userTypeId+"userType ="+userType+"serviceDump ="+serviceDump+"fileType ="+fileType+"status  "+status)
	window.location.href="./exportOperatorDetails?startDate="+startDate+"&endDate="+endDate+"&userTypeId="+userTypeId+"&userType="+userType+"&serviceDump="+serviceDump+"&fileName="+fileName+"&featureId="+parseInt(featureId)+"&fileType="+fileType+"&pageSize="+pageSize+"&pageNo="+pageNo;
}

function Resetfilter(formID){
	$('#'+formID).trigger('reset');
	$("label").removeClass('active');
	operatorDatatable(lang,null);
}