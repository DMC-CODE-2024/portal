	$('#langlist').on('change', function() {
		lang=$('#langlist').val() == 'km' ? 'km' : 'en';
		var url_string = window.location.href;
		var url = new URL(url_string);
		var type = url.searchParams.get("reportType");

		window.location.assign("forgotPassword?lang="+lang);			
		});	
$(document).ready(function () {

		 $('#langlist').val(data_lang_param);
		
var lang=data_lang_param;
		$.i18n().locale = lang;		
		$.i18n().load( {

			'en': './resources/i18n/en.json',
			'km': './resources/i18n/km.json'
		} ).done( function() { 
		});

				//$('.modal').openModal();
		$("body").on("keyup", "input#username", function (e) {
			var _this =$(this).val();
			if(_this.length>3){
				questionData(_this);
				if(e.which===8){
					questionData(_this);
							}
			}
				});
				
			});

			
		
			
			var password = document.getElementById("password");
			var confirm_password = document.getElementById("confirm_password");

			function validatePassword(){
			if(password.value != confirm_password.value) {
			confirm_password.setCustomValidity("Passwords Don't Match");
			} else {
			confirm_password.setCustomValidity('');
			}
			}
			password.onchange = validatePassword;
			confirm_password.onkeyup = validatePassword;

		