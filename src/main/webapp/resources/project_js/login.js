var data_lang_param = $("body").attr("data-lang-param") == 'km' ? 'km' : 'en';
$('#langlist').on('change', function() {
	lang = $('#langlist').val() == 'km' ? 'km' : 'en';
	var url_string = window.location.href;
	var url = new URL(url_string);
	var type = url.searchParams.get("type");
	window.location.assign("login?&lang=" + lang);
});



		$(document).ready(function() {
			//var url = new URL( window.location.href);
			//var langParameter = url.searchParams.get("lang") == 'km' ? 'km' : 'en';
			$('#langlist').val(data_lang_param);
			dataByTag("link_dmc_portal", "newUserLink", 1);
			//  $("label[for='username']").addClass("active");
			/*  if ($("#username").val() != '') {
				  $("label[for='username']").addClass('active');
				  } else {
					  $("label[for='username']").removeClass('remove');
				  }
			  if ($("#password").val() != '') {
				  $("label[for='password']").addClass('active');
				  } else {
					  $("label[for='password']").removeClass('remove');
				  }
*/		});


		//Login Msg from javascript

		/*var msg = $("body").attr("data-msg");
		sessionStorage.getItem("loginMsg") == null ? $('#errorMsg').text(msg) : $('#errorMsg').text(sessionStorage.getItem("loginMsg"));
		*/
		sessionStorage.getItem("loginMsg") != null ?  $('#errorMsg').text(sessionStorage.getItem("loginMsg")) : null;

		sessionStorage.removeItem("loginMsg");



