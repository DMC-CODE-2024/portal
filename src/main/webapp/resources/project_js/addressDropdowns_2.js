/**
 *
 */
 $(document).ready(function() {

     //var lang= window.parent.$('#langlist').val();
     var lang= "en";
     $.i18n().locale = lang;
    var provinceLang= lang=='en'? 'province': 'provinceKm';
    var districtLang= lang=='en'? 'district': 'districtKm';
    var communeLang= lang=='en'? 'commune': 'communeKm';
    provinceDropDown(provinceLang);
 });


	/*$.getJSON('./getAllProvince', function(data) {
		$('#provinceCity').empty();
		$('#provinceCity').append(html);
		for (i = 0; i < data.length; i++) {
			var html='<option value="'+data[i].province+'">'+data[i].province+'</option>';
			$('#provinceCity').append(html);

		}
	});
*/

function provinceDropDown(provinceLangVal){
    var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	let lang =$("body").attr("data-lang-param");
	var request = {
            		"lang" : "en"
            	}
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
$.ajax({
url: "./getAllProvince",
dataType : 'json',
data : JSON.stringify(request),
contentType: 'application/json; charset=utf-8',
type: 'POST',
success: function(data) {
for (i = 0; i < data.length; i++){
$('<option>').val(data[i].id).text(data[i].name).appendTo('#recoveryProvinceCity,#provinceCity,#provinceCityBulk');
}
},
error: function() {
// Handle error
}
});
}


function getDistrict(province) {
	var provinceVal=$('#'+province).val();
	let lang =$("body").attr("data-lang-param");
	var request = {
        		"id" : provinceVal,
        		"lang":"en"
        	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
				url : './getDistrict',
				type : 'POST',
				dataType : 'json',
				data : JSON.stringify(request),
				async: false,
				contentType : 'application/json; charset=utf-8',
				success : function(data, textStatus, jqXHR) {
					var result = data;
					$('#recoveryDistrict,#district,#districtBulk').empty();
					var html='<option value="">'+$.i18n('selectdistrict')+'</option>';
					$('#recoveryDistrict,#district,#districtBulk').append(html);
                    let lang =$("body").attr("data-lang-param");

                    for (i = 0; i < result.length; i++) {
                    						var html='<option value="'+result[i].id+'">'+result[i].name+'</option>';
                    						$('#recoveryDistrict,#district,#districtBulk').append(html);
                    					}


},
				error : function(jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});
}

function getCommune(district) {
	var districtValue=$('#'+district).val();
	let lang =$("body").attr("data-lang-param");
    	var request = {
            		"id" : districtValue,
            		"lang" : "en"
            	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
				url : './getCommune',
				type : 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				async: false,
				contentType : 'application/json; charset=utf-8',
				success : function(data, textStatus, jqXHR) {
					var result = data;
					$('#recoveryCommune,#commune,#communeBulk').empty();
					var html='<option value="">'+$.i18n('selectcommune')+'</option>';
					$('#recoveryCommune,#commune,#communeBulk').append(html);
					let lang =$("body").attr("data-lang-param");

                    for (i = 0; i < result.length; i++) {
                    						var html='<option value="'+result[i].id+'">'+result[i].name+'</option>';
                    						$('#recoveryCommune,#commune,#communeBulk,#viewRecoveryCommune').append(html);
                    					}


},
				error : function(jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});
}



function getPolice(commune) {
	var communeVal=$('#'+commune).val();
	let lang =$("body").attr("data-lang-param");
        	var request = {
                		"id" : communeVal,
                		"lang" : "en"
                	}
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
				url : './getPolice',
				type : 'POST',
				data : JSON.stringify(request),
				dataType : 'json',
				async: false,
				contentType : 'application/json; charset=utf-8',
				success : function(data, textStatus, jqXHR) {
					var result = data;
					$('#policeStation,#policeStationBulk').empty();
					var html='<option value="">'+$.i18n('selectPolice')+'</option>';
					$('#policeStation,#policeStationBulk').append(html);
					 for (i = 0; i < result.length; i++) {
                    						var response='<option value="'+result[i].id+'">'+result[i].name+'</option>';
                                            $('#policeStation,#policeStationBulk').append(response);
                    					}

},
				error : function(jqXHR, textStatus, errorThrown) {
					//////console.log("error in ajax")
				}
			});
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

