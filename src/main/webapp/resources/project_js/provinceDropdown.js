var lang=$("body").attr("data-lang-param") == 'km' ? 'km' : 'en';	
$.i18n().locale = lang;	
var selectProviance;
$.i18n().load( {
	'en': './resources/i18n/en.json',
	'km': './resources/i18n/km.json'
} ).done( function() { 
	selectProviance=$.i18n('selectProviance');
	
});
 
function setDropdown(){
 
	$.getJSON('./getAllProvince', function(data) {
		$('#state').empty();
		var html='<option value="">'+selectProviance+'</option>';
		$('#state').append(html);	
		
		for (i = 0; i < data.length; i++) {
			var html='<option value="'+data[i].province+'">'+data[i].province+'</option>';
			$('#state').append(html);	
			
		}
	});
	
}


 



function setDropdownProviance(state){
	$.ajaxSetup({
		async: false
		});
	$.getJSON('./getAllProvince', function(data) {
		$('#'+state).empty();
		var html='<option value="">'+selectProviance+'</option>';
		$('#'+state).append(html);	
		
		for (i = 0; i < data.length; i++) {
			var html='<option value="'+data[i].province+'">'+data[i].province+'</option>';
			$('#'+state).append(html);	
			
		}
	});
	
}
function setDropdownCambodianProviance(state){
	 
	var nationalityType=$('#country').val();
	 
$('#'+state).empty();
	if(nationalityType=='Cambodia'){
	
	$.getJSON('./getAllProvince', function(data) {
		$('#'+state).empty();
		var html='<option value="">'+selectProviance+'</option>';
		$('#'+state).append(html);	
		
		for (i = 0; i < data.length; i++) {
			var html='<option value="'+data[i].province+'">'+data[i].province+'</option>';
			$('#'+state).append(html);	
			
		}
	});
	}
}