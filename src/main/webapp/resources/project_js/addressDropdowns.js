/**
 * 
 */
 

 
	$.getJSON('./getAllProvince', function(data) {
		$('#provinceCity').empty();
		var html='<option value=""></option>';
		$('#provinceCity').append(html);	
		
		for (i = 0; i < data.length; i++) {
			var html='<option value="'+data[i].province+'">'+data[i].province+'</option>';
			$('#provinceCity').append(html);	
			
		}
	});



function getDistrict(province) {
	
	var provinceVal=$('#'+province).val();
	
	var request = {
		"province" : provinceVal
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
				url : './getallDistrict',
				type : 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				async: false,
				contentType : 'application/json; charset=utf-8',
				success : function(data, textStatus, jqXHR) {
					var result = data;
					$('#commune,#district').empty();
					var html='<option value="">'+$.i18n('selectdistrict')+'</option>';
					$('#district').append(html);	
					 for (i = 0; i < result.length; i++) {
						
						var html='<option value="'+result[i].id+'">'+result[i].district+'</option>';
						$('#district').append(html);	
					} 

				},
				error : function(jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});
}




function getCommune(district) {
	var districtVal=$('#'+district).val();
	var request = {
		"districtID" : parseInt(districtVal)
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
				url : './getallCommune',
				type : 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				async: false,
				contentType : 'application/json; charset=utf-8',
				success : function(data, textStatus, jqXHR) {
					var result = data;
					$('#commune,#village').empty();
					var html='<option value="">'+$.i18n('selectvillage')+'</option>';
					$('#village').append(html);	
					var html='<option value="">'+$.i18n('selectcommune')+'</option>';
					$('#commune').append(html);	
					 for (i = 0; i < result.length; i++) {
						
						var html='<option value="'+result[i].id+'">'+result[i].commune+'</option>';
						$('#commune').append(html);	
					} 

				},
				error : function(jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});
}

function getPolice(police) {
	var policeVal=$('#'+police).val();
	var request = {
		"districtID" : parseInt(district)
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var html='<option value="1">NBR Police</option>';
						$('#policeStation').append(html);
	
}



function getVillage(current) {
	var request = {
		"communeID" : parseInt(current.value)
	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
				url : './getallVillage',
				type : 'POST',
				data : JSON.stringify(request),
				async: false,
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success : function(data, textStatus, jqXHR) {
					var result = data;
					$('#village').empty();
					var html='<option value="">'+$.i18n('selectvillage')+'</option>';
					$('#village').append(html);	
					 for (i = 0; i < result.length; i++) {
						
						var html='<option value="'+result[i].id+'">'+result[i].village+'</option>';
						$('#village').append(html);	
					} 

				},
				error : function(jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});
}

