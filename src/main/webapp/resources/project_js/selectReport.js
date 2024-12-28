/*
		window.parent.$('#langlist').on('change', function() {
			var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
			window.location.assign("./uploadPaidStatus?lang="+lang);
		}); */
	
		var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';


		$.i18n().locale = lang;	

		$.i18n().load( {
			'en': './resources/i18n/en.json',
			'km': './resources/i18n/km.json'
		} ).done( function() { 
			
		});

	$('#btnLink').css({"display":"none"});	
	var userType = $("body").attr("data-roleType");
	var userId = $("body").attr("data-userID");
	var featureId = 42; 
	
	$.getJSON('./getDropdownList/REPORT_CATEGORY', function(data) {
		for (i = 0; i < data.length; i++) {
			$('<option>').val(data[i].value).text(data[i].interp)
			.appendTo('#reportCatagory');
		}
	});

	$('#reportCatagory').on(
			'change',
			function() {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajaxSetup({
					headers:
					{ 'X-CSRF-TOKEN': token }
				});
				
				var reportCategory = parseInt($('#reportCatagory').val());
				
				$.ajax({
					url: './getallreports?reportCategory='+reportCategory+'&featureId='+featureId+'&userId='+userId+'&userType='+userType,
					type: 'POST',
					dataType : 'json',
					contentType : 'application/json; charset=utf-8',
					success: function (data, textStatus, jqXHR) {
						var result= data;
						$("#tableId").empty();
						for (i = 0; i < result.length; i++){
							//alert(result[i].reportTrends[0].typeFlag);
							$('<option>').val(result[i].reportnameId).text(result[i].reportName).attr("trendValue",result[i].reportTrends[0].typeFlag).appendTo('#tableId');
						//	$('<option>').val(data[i].tagId).text(data[i].interp).attr("docValue",data[i].value).appendTo('#doc_type');
						}

					},
					error: function (jqXHR, textStatus, errorThrown) {
						//////console.log("error in ajax")
					}
				});
			});
	
	
	
	function hide() {
		var reportname = $('#tableId').val();
		var reportInterp = $("#tableId option:selected").text();
		var trendTypeFlag=$("#tableId option:selected").attr("trendvalue");
	
		if(reportname.length == 0){
			//////console.log("please field input");
		}else{
			//sessionStorage.setItem("roleType",roleType);
		sessionStorage.setItem("reportname",reportname);
		sessionStorage.setItem("reportInterp",reportInterp);
		sessionStorage.setItem("trendTypeFlag",trendTypeFlag);
		window.location.replace("./report?via=other&tableName="+reportname);
		return false;
		}
		
	};
	
	
	
