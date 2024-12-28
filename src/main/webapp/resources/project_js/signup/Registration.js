function openRegistrationPage(usertype) {
	window.location.href = contextpath + "/registration?type=" + usertype;
}
function portDropDownData() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'GET',
		url : contextpath + '/getDropdownList/CUSTOMS_PORT',
		contentType : "application/json",
		dataType : 'html',
		async : false,
		success : function(data) {
			var response = JSON.parse(data);
			var asTypeDropdown = $("#arrivalPort");
			for (var i = 0; i < response.length; i++) {
				var data2 = '<option value="' + response[i].value + '">'
						+ response[i].interp + '</option>';
				asTypeDropdown.append(data2);
			}
		},
		error : function(xhr, ajaxOptions, thrownError) {
		}
	});
}
function verifyOtp() {
	$("#otpVerifyBtn").prop('disabled', true);
	var obj = "";
	$("#verifyOtpForm").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj = {
				phoneOtp : val.find('#phoneOtp').val(),
				emailOtp : val.find('#emailOtp').val(),
				userid : val.find('#userid').val()
			}
		}
	});
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/verifyOtp',
		contentType : "application/json",
		dataType : 'html',
		data : JSON.stringify(obj),
		success : function(data) {
			var resp = JSON.parse(data);
			if (resp.statusCode == "200") {
				// window.location.href='#otpMessage';

				// $('#otpMessage').modal('open');

				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					$("#otpVerification").closeModal();
					$('#otpMessage').openModal({
						dismissible : false
					});

					$("#otpResponse").text($.i18n(resp.tag));
				});

			} else {

				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(
						function() {
							$("#otpVerification #verifyOtpResp").text(
									$.i18n(resp.tag));
						});
			}
			$("#otpVerifyBtn").prop('disabled', false);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			$("#otpVerifyBtn").prop('disabled', false);
		}

	});
	return false;
}

function verifyOtp2() {
	$("#otpVerifyBtn").prop('disabled', true);
	var username=document.getElementById("username").value;
	var obj = "";
	$("#verifyOtpForm").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj = {
				phoneOtp : val.find('#phoneOtp').val(),
				emailOtp : val.find('#emailOtp').val(),
				userid : val.find('#userid').val(),
				forgotPassword : '1'
			}
		}
	});
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/verifyOtp',
		contentType : "application/json",
		dataType : 'html',
		data : JSON.stringify(obj),
		success : function(data) {
			var resp = JSON.parse(data);
			if (resp.statusCode == "200") {
				// window.location.href='#otpMessage';

				// $('#otpMessage').modal('open');

				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					$("#otpVerification").closeModal();
					$("#usernamedata").val(username);
					$('#changePassword').openModal({
				        dismissible:false
				    });
				});

			} else {

				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(
						function() {
							$("#otpVerification #verifyOtpResp").text(
									$.i18n(resp.tag));
						});
			}
			$("#otpVerifyBtn").prop('disabled', false);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			$("#otpVerifyBtn").prop('disabled', false);
		}

	});
	return false;
}

function resendOtp() {
	var id = document.getElementById("userid").value;
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/resendOtp/' + id,
		contentType : "application/json",
		dataType : 'html',
		success : function(data) {
			var response = JSON.parse(data);

			$.i18n().locale = $('#langlist').val();
			$.i18n().load({
				'en' : './resources/i18n/en.json',
				'km' : './resources/i18n/km.json'
			}).done(function() {
				$("#verifyOtpResp").text($.i18n(response.tag));
			});

		},
		error : function(xhr, ajaxOptions, thrownError) {
		}
	});
}

function resendOtp2(){
	var id=document.getElementById("userid").value;
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/profileResendOtp/'+id,
		contentType : "application/json",
		dataType : 'html',
		success : function(data) {
			var response=JSON.parse(data);
			var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
			$.i18n().locale = lang;
				$.i18n().load( {
					'en': './resources/i18n/en.json',
					'km': './resources/i18n/km.json'
				}).done( function() {
					$("#verifyOtpResp").text($.i18n(response.tag));

				});
		},
		error: function (xhr, ajaxOptions, thrownError) {
		}
	});
}



function checkImeiRefreshCaptcha(imageId,contextpath) {
	//alert("contextpath is " +contextpath);
	path = contextpath + '/captcha?cache='; // for example
	imageObject = document.getElementById(imageId);
	imageObject.src = path + (new Date()).getTime();
}




function refreshCaptcha(imageId) {
	path = contextpath + '/captcha?cache='; // for example
	imageObject = document.getElementById(imageId);
	imageObject.src = path + (new Date()).getTime();
}

function reg() {
	return false;
}


function defer(method) {
    if (window.jQuery) {
       //////console.log("jquery loaded");
    } else {
    	////console.log("jquery not loaded ");
        setTimeout(function() { defer(method) }, 50);
    }
}


function asTypeData() {

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'GET',
		url : contextpath + '/getSourceTypeDropdown/AS_TYPE/22',
		contentType : "application/json",
		dataType : 'html',
		async : false,
		success : function(data) {
			var response = JSON.parse(data);
			var asTypeDropdown = $("#type");
			for (var i = 0; i < response.length; i++) {
				var data2 = '<option value="' + response[i].value + '">'
						+ response[i].interp + '</option>';
				asTypeDropdown.append(data2);
			}
		},
		error : function(xhr, ajaxOptions, thrownError) {
		}
	});
}
function usertypeData() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});

	$.ajax({
		type : 'GET',
		url : contextpath + '/usertypeList/',
		contentType : "application/json",
		dataType : 'html',
		async : false,
		success : function(data) {
			var response = JSON.parse(data);
			var usertypeDropdown = $("#usertypes");
			for (var i = 0; i < response.length; i++) {
				var data2 = '<option value="' + response[i].id + '">'
						+ response[i].usertypeName + '</option>';
				usertypeDropdown.append(data2);
			}
			setTimeout(function() {
				$('.dropdown-trigger').dropdown();
				$('select').formSelect();
			}, 1000);
		},
		error : function(xhr, ajaxOptions, thrownError) {
		}
	});
}

function usertypeData2(id) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'GET',
		url : contextpath + '/getTypeDropdownList/ROLE_TYPE/' + id,
		contentType : "application/json",
		dataType : 'html',
		async : false,
		success : function(data) {
			var response = JSON.parse(data);
			var usertypeDropdown = $("#usertypes");
			for (var i = 0; i < response.length; i++) {
				var data2 = '<option value="' + response[i].value + '">'
						+ response[i].interp + '</option>';
				usertypeDropdown.append(data2);

			}
			usertypeDropdown.val(id);
			$('#usertypes option[value="' + id + '"]').attr('disabled', true);
			setTimeout(function() {
				$('.dropdown-trigger').dropdown();
				$('select').formSelect();
			}, 1000);
		},
		error : function(xhr, ajaxOptions, thrownError) {
		}
	});
}

function usertypeDropDownData() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'GET',
		url : contextpath + '/usertypeList/',
		contentType : "application/json",
		dataType : 'html',
		success : function(data) {
			var response = JSON.parse(data);
			var usertypeDropdown = $("#usertypes");
			for (var i = 0; i < response.length; i++) {
				var data2 = '<option value="' + response[i].id + '">'
						+ response[i].usertypeName + '</option>';
				usertypeDropdown.append(data2);
			}
		},
		error : function(xhr, ajaxOptions, thrownError) {
		}
	});
}

function systemConfigList(id, tag) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'GET',
		url : contextpath + '/operatorList/' + tag,
		contentType : "application/json",
		dataType : 'html',
		success : function(data) {
			var response = JSON.parse(data);
			var operatorType = $("#" + id);
			for (var i = 0; i < response.length; i++) {
				var data2 = '<option value="' + response[i].value + '">'
						+ response[i].interp + '</option>';
				operatorType.append(data2);
			}
		},
		error : function(xhr, ajaxOptions, thrownError) {
		}
	});
}

function questionData(username) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});

	$.i18n().locale = $('#langlist').val();
	$.i18n().load({
		'en' : './resources/i18n/en.json',
		'km' : './resources/i18n/km.json'
	}).done(function() {

		});

	$.ajax({
				type : 'GET',
				url : contextpath + '/securityQuestionList/' + username,
				contentType : "application/json",
				dataType : 'html',
				success : function(data) {
					var resp = JSON.parse(data);
					var usertypeDropdown = $("#questionId");
					usertypeDropdown.empty();
					var data1 = '<option value="" disabled selected>'+$.i18n('Security_Question')+'</option>';
					usertypeDropdown.append(data1);
					var response=resp.data;
					if(resp.errorCode==200){
						for (var i = 0; i < response.length; i++) {

							var data2 = '<option value="' + response[i].id + '">'
									+ response[i].question + '</option>';
							usertypeDropdown.append(data2);
						}
						$("#forgotPassword #errorMsg").text("");
					}
					else{
						$.i18n().locale = $('#langlist').val();

						//	$("#forgotPassword #errorMsg").text(resp.response);
							$.i18n().load( {
								'en': './resources/i18n/en.json',
								'km': './resources/i18n/km.json'
							}).done( function() {
								$("#forgotPassword #errorMsg").text($.i18n(resp.tag));
							});

					}


				},
				error : function(xhr, ajaxOptions, thrownError) {
				}
			});
}

function saveRegistration() {
	$("#btnSave").prop('disabled', true);
	var obj = "";
	var oj2 = "";
	var questionData = [];
	$("#registrationForm .securityQuestionDiv").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj2 = {
				questionId : parseInt(val.find('.questionId').val()),
				answer : val.find('.answer').val(),
			}
			questionData.push(obj2);
		}
	});

	var data = [];
	var $el = $("#usertypes");
	$el.find('option:selected').each(function() {
		data.push($(this).val());
	});

	$("#registrationForm").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj = {
				firstName : val.find('#firstName').val(),
				userLanguage : val.find('#langlist option:selected').val(),
				middleName : val.find('#middleName').val(),
				lastName : val.find('#lastName').val(),
				type : val.find('#type').val(),
				passportNo : val.find('#passportNo').val(),
				companyName : val.find('#companyName').val(),
				email : val.find('#email').val(),
				phoneNo : val.find('#phoneNo').val(),
				propertyLocation : val.find('#propertyLocation').val(),
				street : val.find('#street').val(),
				village : val.find("#village").val(),
				locality : val.find('#locality').val(),
				district : val.find('#district').val(),
				commune : val.find('#commune').val(),
				postalCode : val.find('#postalCode').val(),
				province : val.find('#state').val(),
				country : val.find('#country').val(),
				vatStatus : val.find("input[name='vatStatus']:checked").val(),
				vatNo : val.find('#vatNo').val(),
				roles : data,
				password : val.find('#password').val(),
				rePassword : val.find('#confirm_password').val(),
				captcha : val.find('#captcha').val(),
				userTypeId : val.find('#usertypeId').val(),
				usertypeName : val.find('#usertypeName').val(),
				questionList : questionData
			}
		}
	});
	var formData;

	formData = new FormData();
	formData.append('file', $('#file')[0].files[0]);
	formData.append('data', JSON.stringify(obj));
	formData.append('vatFile', $('#vatFile')[0].files[0]);
	registrationAjax(formData);
	// $("#btnSave").prop('disabled', true);
	/*
	 * $("#otpMsgModal").openModal({ dismissible:false });
	 */
	return false;
}

function saveCustomRegistration() {
	$("#btnSave").prop('disabled', true);
	var obj = "";
	var oj2 = "";
	var questionData = [];
	$("#registrationForm .securityQuestionDiv").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj2 = {
				questionId : parseInt(val.find('.questionId').val()),
				answer : val.find('.answer').val(),
			}
			questionData.push(obj2);
		}
	});

	$("#registrationForm").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj = {
				firstName : val.find('#firstName').val(),
				userLanguage : val.find('#langlist option:selected').val(),
				middleName : val.find('#middleName').val(),
				lastName : val.find('#lastName').val(),
				propertyLocation : val.find('#propertyLocation').val(),
				street : val.find('#street').val(),
				village : val.find("#village").val(),
				locality : val.find('#locality').val(),
				district : val.find('#district').val(),
				commune : val.find('#commune').val(),
				postalCode : val.find('#postalCode').val(),
				country : val.find('#country').val(),
				province : val.find('#state').val(),
				passportNo : val.find('#passportNo').val(),
				employeeId : val.find("#employeeId").val(),
				natureOfEmployment : val.find("#natureOfEmployment").val(),
				designation : val.find("#designation").val(),
				authorityName : val.find("#authorityName").val(),
				authorityEmail : val.find("#authorityEmail").val(),
				authorityPhoneNo : val.find("#authorityPhoneNo").val(),
				email : val.find('#email').val(),
				phoneNo : val.find('#phoneNo').val(),
				password : val.find('#password').val(),
				rePassword : val.find('#confirm_password').val(),
				roles : val.find('#usertypes').val(),
				captcha : val.find('#captcha').val(),
				userTypeId : val.find('#usertypeId').val(),
				usertypeName : val.find('#usertypeName').val(),
				arrivalPort : val.find('#arrivalPort').val(),
				questionList : questionData,
				type : val.find('#type').val(),
				portAddress : val.find('#portAddress option:selected').val(),
				vatStatus : val.find('#vatStatus').val(),
				vatNo : val.find('#vatNo').val(),
				companyName : val.find('#companyName').val(),
			}
		}
	});
	var formData;
	var usertypeId = $('#usertypeId').val();
	formData = new FormData();
	formData.append('NationalIdImage', $('#NationalIdImage')[0].files[0]);
	formData.append('photo', $('#photo')[0].files[0]);
	formData.append('idCard', $('#idCard')[0].files[0]);
	if (usertypeId == "12") {
		formData.append('vatFile', $('#vatFile')[0].files[0]);
	}
	formData.append('data', JSON.stringify(obj));
	otherRegistrationAjax(formData);
	return false;
}

function saveOperatorRegistration() {
	$("#btnSave").prop('disabled', true);
	var obj = "";
	var oj2 = "";
	var questionData = [];
	$("#registrationForm .securityQuestionDiv").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj2 = {
				questionId : parseInt(val.find('.questionId').val()),
				answer : val.find('.answer').val(),
			}
			questionData.push(obj2);
		}
	});

	$("#registrationForm").each(
			function(key, val) {
				val = $(this);
				if (val.html() !== "") {
					obj = {
						firstName : val.find('#firstName').val(),
						userLanguage : val.find('#langlist option:selected')
								.val(),
						middleName : val.find('#middleName').val(),
						lastName : val.find('#lastName').val(),
						propertyLocation : val.find('#propertyLocation').val(),
						street : val.find('#street').val(),
						village : val.find("#village").val(),
						locality : val.find('#locality').val(),
						district : val.find('#district').val(),
						commune : val.find('#commune').val(),
						postalCode : val.find('#postalCode').val(),
						country : val.find('#country').val(),
						province : val.find('#state').val(),
						passportNo : val.find('#passportNo').val(),
						employeeId : val.find("#employeeId").val(),
						natureOfEmployment : val.find("#natureOfEmployment")
								.val(),
						designation : val.find("#designation").val(),
						authorityName : val.find("#authorityName").val(),
						authorityEmail : val.find("#authorityEmail").val(),
						authorityPhoneNo : val.find("#authorityPhoneNo").val(),
						email : val.find('#email').val(),
						phoneNo : val.find('#phoneNo').val(),
						type : val.find('#type').val(),
						password : val.find('#password').val(),
						rePassword : val.find('#confirm_password').val(),
						roles : val.find('#usertypes').val(),
						captcha : val.find('#captcha').val(),
						userTypeId : val.find('#usertypeId').val(),
						usertypeName : val.find('#usertypeName').val(),
						operatorTypeId : val.find('#operatorType').val(),
						operatorTypeName : val.find(
								'#operatorType option:selected').text(),
						type : val.find('#type').val(),
						questionList : questionData
					}
				}
			});
	var formData;

	formData = new FormData();
	formData.append('NationalIdImage', $('#NationalIdImage')[0].files[0]);
	formData.append('photo', $('#photo')[0].files[0]);
	formData.append('idCard', $('#idCard')[0].files[0]);
	formData.append('data', JSON.stringify(obj));
	otherRegistrationAjax(formData);
	return false;
}
function registrationAjax(obj) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/saveRegistration',
		data : obj,
		processData : false,
		contentType : false,
		success : function(response) {
			var respData = JSON.parse(JSON.stringify(response));
			if (respData.statusCode == 200) {

				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					$("#otpMsg").text($.i18n(respData.tag));
					$("#userid").val(respData.userId);
					$('#content').addClass('lean-overlay');
					$("#otpMsgModal").openModal({
						dismissible : false
					});

				});
			} else {
				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					// $("#registrationForm #msg").text($.i18n(respData.tag));
					errorMessageReg($.i18n(respData.tag));
				});

			}
			$("#btnSave").prop('disabled', false);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			$("#btnSave").prop('disabled', false);
		}
	});
}

function otherRegistrationAjax(obj) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/saveOtherRegistration',
		data : obj,
		processData : false,
		contentType : false,
		success : function(response) {
			var respData = JSON.parse(JSON.stringify(response));
			if (respData.statusCode == 200) {
				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					$("#otpMsg").text($.i18n(respData.tag));
					$("#userid").val(respData.userId);
					$("#otpMsgModal").openModal({
						dismissible : false
					});

				});

			} else {

				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					// $("#registrationForm #msg").text($.i18n(respData.tag));
					errorMessageReg($.i18n(respData.tag));
				});

			}
			$("#btnSave").prop('disabled', false);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			$("#btnSave").prop('disabled', false);
		}
	});
}

function openEndUserGrievancePage(reportType) {
	window.location.href = "./raiseAgrievance?reportType=" + reportType.value;

}

function openEndUserStockPage(reportType) {
	window.location.href = "./uploadAstock?reportType=" + reportType.value;
	/*
	 * $.ajax({ type : 'POST', url : contextpath +
	 * '/openEndUserStockPage?reportType='+reportType.value, processData :
	 * false, contentType : false, success : function(response) {
	 * respData=JSON.parse(JSON.stringify(response)); ////console.log("response from
	 * server: "+JSON.stringify(respData)); if(respData.statusCode==200){
	 * //window.location.href='./verifyOtpPage/?userid='+respData.userId;
	 * $("#userid").val(response.userId); //window.location.href='#otpMsgModal';
	 * $("#otpMsgModal").openModal(); $("#otpMsg").text(response.response); }
	 * else{ $("#registrationForm #msg").text(respData.response); }
	 * $("#btnSave").prop('disabled', false); }, error: function (xhr,
	 * ajaxOptions, thrownError) { $("#btnSave").prop('disabled', false); } });
	 */
}
function openEndUserStolenPage(type) {
	window.location.href = "./requestStolenRecovery?type=" + type.value;
}
function selfRegisterDevice() {
	window.location.href = "./selfRegisterDevice";
}
function updateVisaValidity() {
	window.location.href = "./updateVisavalidity";
}

function getByPort(port) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
	headers:
	{ 'X-CSRF-TOKEN': token }
	});
	$.ajax({
				type : 'GET',
				url : contextpath + '/byArrivalPort/' + port,
				contentType : "application/json",
				dataType : 'html',
				async : false,
				success : function(data) {
					var response = JSON.parse(data);
					var asTypeDropdown = $("#portAddress");
					asTypeDropdown.empty();
					var header = "<option value='' disabled selected>Select address</option>";
					asTypeDropdown.append(header);
					for (var i = 0; i < response.length; i++) {
						var data2 = '<option value="' + response[i].id + '">'
								+ response[i].address + '</option>';
						asTypeDropdown.append(data2);
					}
				},
				error : function(xhr, ajaxOptions, thrownError) {
				}
			});
}

function checkBoxClick() {
	$('#disclamer').click(function() {
		// check if checkbox is checked
		if ($(this).is(':checked')) {

			$('#btnSave').removeAttr('disabled'); // enable input

		} else {
			$('#btnSave').attr('disabled', true); // disable input
		}
	});
}

function openOtpPopup() {
	$('#otpMsgModal').closeModal();
	$("#otpVerification").openModal({
		dismissible : false
	});
}

function openAnModal() {
	$("#otpVerification").closeModal();
	$('#otpMessage').openModal({
		dismissible : false
	});
}




function getDistrict(current) {
	var request = {
		"province" : current.value
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
					$('#district,#commune').empty();
					var html='<option value="">'+$.i18n('selectcommune')+'</option>';
					$('#commune').append(html);
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




function getCommune(current) {
	var request = {
		"districtID" : parseInt(current.value)
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
