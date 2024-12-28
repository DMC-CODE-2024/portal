/*
		window.parent.$('#langlist').on('change', function() {
			var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
			window.location.assign("./uploadPaidStatus?lang="+lang);
		}); */
		
		
	$('#btnLink').css({"display":"none"});	
	var roleType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var userType = $("body").attr("data-roleType"); 
	var featureId = 39; 

	
	
	function hide() {
		var tableName = $('#tableId').val();
		var databaseName=$('#DBId').val()
		
		if(tableName.length == 0){
			//////console.log("please field input");
		}else{
			//sessionStorage.setItem("roleType",roleType);
			
		sessionStorage.setItem("tableName", tableName);
		sessionStorage.setItem("databaseName", databaseName);
		window.location.replace("./dbTables?via=other&tableName="+tableName);
		}
	}
	
	
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token } 
	});
	$.ajax({
		url: './getallDB',
		type: 'POST',
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		success: function (data, textStatus, jqXHR) {
			for (i = 0; i < data.length; i++){
				$('<option>').val(data[i]).text(data[i]).appendTo('#DBId');
				//$('<option>').val(data[i]).prop("selected","selected");
				//$('#DBId').prop("selected","selected");
			}
			
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});
	
	function setTable(){
	var dbName = $('#DBId').val();
	$('#tableId').empty();
	//var dbName = 'app';
	$.ajaxSetup({
		headers:
		{ 'X-CSRF-TOKEN': token } 
	});
	$.ajax({
		url: './getallTables?dbName='+dbName+'&featureId='+featureId+'&userId='+userId+'&userType='+userType,
		type: 'POST',
		dataType : 'json',
		contentType : 'application/json; charset=utf-8',
		success: function (data, textStatus, jqXHR) {
			var result = data.tableNames;
			for (i = 0; i < result.length; i++){
				$('<option>').val(result[i]).text(result[i]).appendTo('#tableId');
			}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			//////console.log("error in ajax")
		}
	});
	}	
	
	
	
