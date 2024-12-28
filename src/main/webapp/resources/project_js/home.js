var userTypeId = parseInt($("body").attr("data-userTypeID"));
var userType = $("body").attr("data-roleType");
var userId = $("body").attr("data-userID");
var operatortypeid = window.parent.$("body").attr("data-operatortypeid");

var featureId="3";

var sessionLang=window.parent.$('#langlist').val() == 'en' ? 'en' : 'km';
$.i18n().locale = sessionLang;	



$(document).ready(function(){
	$('div#initialloader').fadeIn('fast');
	var url;

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: './dashboard/box?userTypeId='+userTypeId,
		type: 'GET',
		success: function(data){

			$.i18n().load( {
				'en': './resources/i18n/en.json',
				'km': './resources/i18n/km.json'
			} ).done( function() { 
				
			for (i = 0; i < data.length; i++) {
				var id=data[i].name;
				/*var finalID=id.replace (/\//g, "");*/
				url= data[i].url.split("?"); 
				$("#infoBox").append("<div class='round-circle-center-responsive'><div class='round-circle'><h6 class='right' style='width: 105px;'>"+$.i18n(data[i].name)+"</h6><p class='circle-para right' style='position:absolute;margin-top:70px;width: 170px;margin-left: 5px;padding-right: 0px !important;'><b id='"+data[i].id+"count'></b> </p><p class='center view-div-info'><a href='"+data[i].viewName+"?&source=dashboard' onclick='isActive(\""+data[i].featureId+"\")' class=''><i class='fa fa-eye view-icon teal-text' title='view'></i></a></p><div class='icon-div center'><i class='"+data[i].icon+"' aria-hidden='true'></i></div></div>");
				var finalID = data[i].id;
				var outParam = data[i].outParam;
				if(userTypeId == 8){
					userId = -1;
				}

				var operatorId;
				var requestType;
				if(data[i].name == 'Block Requests' && data[i].featureId == 7){
					requestType=2;
				}
				else if(data[i].name == 'Unblock Requests' && data[i].featureId == 7){
					requestType=3;
				}

				else if(data[i].name == 'Stolen Requests' && data[i].featureId == 5){
					requestType=0;
				}

				else if(data[i].name == 'Recovery Requests' && data[i].featureId == 5){
					requestType=1;
				}

				var user_Type=window.parent.$("body").attr("data-usertype");
				
				if(user_Type =='Operator'){
					operatorId=operatortypeid;
					}
				else{
					operatorId=-1;
				}

				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': token }
				});
				$.ajax({
					url: './'+url[0]+'?featureId='+data[i].featureId+'&userId='+userId+'&userTypeId='+userTypeId+'&requestType='+requestType+'&userType='+userType+'&operatorId='+operatorId,
					'async': false,
					type: 'GET',
					success: function(data){
						outParam == 'count' ? $('#'+finalID+'count').text(data.count) : $('#'+finalID+'count').text(data.quantity);	
					}
				});


			}
			});
		}
	});
	notificationDatatable(sessionLang);
});



localStorage.setItem("sourceType", "viaDashBoard");
localStorage.setItem("grievancePageSource", "viaDashBoard");



//**************************************************Notification Data table**********************************************

function notificationDatatable(){

	var filterRequest = {
			"userTypeId" : parseInt($("body").attr("data-userTypeID")),
			"userType" : $("body").attr("data-roleType"),
			"userId" : $("body").attr("data-userID"),
			"featureId" : 3
	}


	if(sessionLang=='km'){
		var langFile="./resources/i18n/khmer_datatable.json";
	}

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		url: 'headers?type=dashboardNotification&lang='+sessionLang,
		type: 'POST',
		dataType: "json",
		success: function(result){
			var table=	$("#notificationLibraryTable").DataTable({
				destroy:true,
				"serverSide": true,
				orderCellsTop : true,
				"ordering" : false,
				"bPaginate" : true,
				"bFilter" : true,
				"bInfo" : true,
				"bSearchable" : true,
				"pageLength": 10,
				ajax: {
					url : './NotificationData',
					type: 'POST',
					dataType: "json",
					data : function(d) {
						d.filter = JSON.stringify(filterRequest); 
					}

				},
				"columns": result
			});
			$('div#initialloader').delay(300).fadeOut('slow');
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax");
		}
	});
}



function isActive(feature){	
	window.parent.$('.navData li:nth-child(1)').removeClass("active");
	window.parent.$('.navData li a').each(function(){
		if($(this).attr('data-featureid') == feature){    	 
			$(this).closest('li').addClass("inactive");
			$(this).closest('li').removeClass("active");
			$(this).closest('li').removeClass("inactive");
			$(this).closest('li').addClass("active"); 
		}
	})
}
