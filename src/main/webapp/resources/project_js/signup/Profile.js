//var lang=$('#langlist').val() == 'km' ? 'km' : 'en';
var tag;
function changePassword() {
	$("#changePassBtn").prop('disabled', true);
	var obj = "";
	$("#changePassword").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj = {
				oldPassword : val.find('#oldPassword').val(),
				password : val.find('#password').val(),
				confirmPassword : val.find('#confirm_password').val()
			}
		}
	});

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/changePassword',
		data : JSON.stringify(obj),
		contentType : "application/json",
		dataType : 'html',
		success : function(data) {
			var resp = JSON.parse(data);
			if (resp.statusCode == '200') {
$('#changePassword').hide();
				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(
						function() {
							/*	$("#changePasswordMessage #cPassSucessMsg").text(
									$.i18n(resp.tag));
						$("#changePassword").closeModal();
							$("#changePasswordMessage").openModal({
								dismissible : false
							});*/

                           alertify.success($.i18n(resp.tag),4);
						});

			} else {
				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {

					$("#changePassword #errorMsg").text($.i18n(resp.tag));
				});

			}
			$("#changePassBtn").prop('disabled', false);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			$("#changePassBtn").prop('disabled', false);
		}

	});
	return false;
}

function updateUserStatusModal() {

	// $("#updateStatusBtn").prop('disabled', true);
	 $("#passwordBtn").prop('disabled', true);
	 
	var obj = "";
	obj = {
		status : $("input[name='status']:checked").val(),
		password : $("#confirmPassword").val()

	};

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/updateUserStatus',
		contentType : "application/json",
		dataType : 'html',
		data : JSON.stringify(obj),
		success : function(data) {

			var resp = JSON.parse(data);
			if (resp.statusCode == '200') {
				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(
						function() {

							$("#manageAccountSubmit #mgAccount").text(
									$.i18n(resp.tag));
							$("#manageAccount").closeModal();
							$("#manageAccountSubmit").openModal({
								dismissible : false
							});

						});
			} else {
				 $("#passwordBtn").prop('disabled', false);
				$.i18n().locale = $('#langlist').val();
				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {
					$("#passwordModal").closeModal();
					errorMessageReg($.i18n(resp.tag));
					// $("#userStatusForm #errorMsg").text($.i18n(resp.tag));
				});
			}
			// $("#updateStatusBtn").prop('disabled', true);
		},
		error : function(xhr, ajaxOptions, thrownError) {
			// $("#updateStatusBtn").prop('disabled', true);
		}

	});
	return false;

}
/*
 * function updateUSerStatus(){ passwordPopup(); }
 */
function questionDataByCategory2() {

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$
			.ajax({
				type : 'GET',
				url : contextpath + '/allSecurityQuestionList/',
				contentType : "application/json",
				dataType : 'html',
				success : function(data) {
					var response = JSON.parse(data);
					var usertypeDropdown1 = $("#registrationForm #questionId0");
					var usertypeDropdown2 = $("#registrationForm #questionId1");
					var usertypeDropdown3 = $("#registrationForm #questionId2");
					var data1 = '<option value="" disabled selected>Security Question 1</option>';
					var data2 = '<option value="" disabled selected>Security Question 2</option>';
					var data3 = '<option value="" disabled selected>Security Question 3</option>';
					var checkVal = usertypeDropdown1.val();
					var checkVal2 = usertypeDropdown2.val();
					var checkVal3 = usertypeDropdown3.val();
					for (var i = 0; i < response.length; i++) {
						if (response[i].category == 1) {
							if (checkVal == response[i].id) {

							} else {
								var text = '<option value="' + response[i].id
										+ '">' + response[i].question
										+ '</option>';
								usertypeDropdown1.append(text);
							}
						} else if (response[i].category == 2) {
							if (checkVal2 == response[i].id) {

							} else {
								var text = '<option value="' + response[i].id
										+ '">' + response[i].question
										+ '</option>';
								usertypeDropdown2.append(text);
							}
						} else if (response[i].category == 3) {
							if (checkVal3 == response[i].id) {

							} else {
								var text = '<option value="' + response[i].id
										+ '">' + response[i].question
										+ '</option>';
								usertypeDropdown3.append(text);
							}
						} else {
						}
					}

				},
				error : function(xhr, ajaxOptions, thrownError) {
				}
			});
}

function questionDataByCategory() {

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$
			.ajax({
				type : 'GET',
				url : contextpath + '/allSecurityQuestionList/',
				contentType : "application/json",
				dataType : 'html',
				success : function(data) {
					var response = JSON.parse(data);
					var usertypeDropdown1 = $("#registrationForm #questionId0");
					var usertypeDropdown2 = $("#registrationForm #questionId1");
					var usertypeDropdown3 = $("#registrationForm #questionId2");
					var data1 = '<option value="" disabled selected>Security Question 1</option>';
					var data2 = '<option value="" disabled selected>Security Question 2</option>';
					var data3 = '<option value="" disabled selected>Security Question 3</option>';

					for (var i = 0; i < response.length; i++) {
						if (response[i].category == 1) {
							var text = '<option value="' + response[i].id
									+ '">' + response[i].question + '</option>';
							usertypeDropdown1.append(text);

						} else if (response[i].category == 2) {
							var text = '<option value="' + response[i].id
									+ '">' + response[i].question + '</option>';
							usertypeDropdown2.append(text);

						} else if (response[i].category == 3) {
							var text = '<option value="' + response[i].id
									+ '">' + response[i].question + '</option>';
							usertypeDropdown3.append(text);

						} else {
						}
					}

				},
				error : function(xhr, ajaxOptions, thrownError) {
				}
			});
}

function editProfile() {
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$
			.ajax({
				type : 'POST',
				url : contextpath + '/editProfile',
				contentType : "application/json",
				dataType : 'html',
				success : function(data) {
					var resp = JSON.parse(data);
					// $("#registrationForm #firstName").val("heello");
					$("#registrationForm #firstName").val(resp.firstName);
					$("#registrationForm #id").val(resp.id);
					$("#registrationForm #middleName").val(resp.middleName);
					$("#registrationForm #lastName").val(resp.lastName);
					$("#registrationForm #email").val(resp.email);
					$("#registrationForm #phoneNo").val(resp.phoneNo);
					$("#registrationForm #propertyLocation").val(
							resp.propertyLocation);
					$("#registrationForm #street").val(resp.street);

					$("#registrationForm #country").val(resp.country);
				
					//populateStates("country", "state");
					$("#registrationForm #state").val(resp.province);
					$('#registrationForm #state').val(resp.province).trigger(
							"change");
					
						$("#registrationForm #district").val(resp.district);
						$('#registrationForm #district').val(resp.district)
								.trigger("change");
					

						$("#registrationForm #commune").val(resp.commune);
						$('#registrationForm #commune').val(resp.commune).trigger("change");
					
						$("#registrationForm #village").val(resp.village);
				
					$("#registrationForm #postalCode").val(resp.postalCode);
					$("#registrationForm #locality").val(resp.locality);
					$("#registrationForm #asTypeName").val(resp.asTypeName);
					$("#registrationForm #type").val(resp.type);
					$("#registrationForm #companyName").val(resp.companyName);
					$("#registrationForm #passportNo").val(resp.passportNo);
					$("#questionId1 #country").val(resp.country);
					// $("#registrationForm #usertypes").val(resp.roles);
					$("#registrationForm #file").val(resp.nidFilename);
					$("#registrationForm #filePath").val(resp.nidFilePath);

					// nidFilename

					var arr = [];
					var vatStatus = resp.vatStatus;
					if (vatStatus == 1) {
						$("#registrationForm #vatFile").val(resp.vatFilename);
						$("#registrationForm #vatFilePath").val(
								resp.vatFilePath);
						document.getElementById("vatNumberField").style.display = "block";
						document.getElementById("vatFileDiv").style.display = "block";
						$("#vatYes").prop('checked', true);
						$("#registrationForm .vatStatus")
								.attr('disabled', true);
						$("#registrationForm #vatNo").val(resp.vatNo);
					} else {
						$("#vatNo").val("");
						$('#vatNo').attr("disabled", true);
						$("#vatFile").val("");
						$("#vatNos").prop('checked', true);
						$("#vatNos").val("");
						document.getElementById("vatNumberField").style.display = "none";
						document.getElementById("vatFileDiv").style.display = "none";
					}
					// arr=resp.roles;
					if (resp.userTypeId == 4 || resp.userTypeId == 5
							|| resp.userTypeId == 6) {
						$("#rolesDiv").show();
						$("#AsTypeDiv").show();
						// usertypeData2(resp.userTypeId);
					}
					// for (var i = 0; i < arr.length; i++) {
					// //$("#registrationForm #usertypes").val(arr[i]);
					// $('#registrationForm #usertypes
					// option[value="'+arr[i]+'"]').attr('selected', true);
					// $('#registrationForm #usertypes
					// option[value="'+arr[i]+'"]').attr('disabled', true);
					// }
					// loadByAsType(resp);

					// $("#").val(resp[i].);
					var questionData = resp.questionList;
					for (var i = 0; i < questionData.length; i++) {
						$("#registrationForm #questionId" + i).empty();
						var selectData = '<option value="'
								+ questionData[i].questionId + '">'
								+ questionData[i].question + '</option>';
						$("#registrationForm #questionId" + i).append(
								selectData);
						$("#registrationForm #answer" + i).val(
								questionData[i].answer);
						$("#registrationForm #id" + i).val(questionData[i].id);
					}
					questionDataByCategory2();

					$('div#initialloader').delay(300).fadeOut('slow');
				},
				error : function(xhr, ajaxOptions, thrownError) {
				}

			});
}

function editOtherProfile() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$
			.ajax({
				type : 'POST',
				url : contextpath + '/editProfile',
				contentType : "application/json",
				dataType : 'html',
				success : function(data) {
					var resp = JSON.parse(data);
					// $("#registrationForm #firstName").val("heello");
					$("#registrationForm #firstName").val(resp.firstName);
					$("#registrationForm #id").val(resp.id);
					$("#registrationForm #middleName").val(resp.middleName);
					$("#registrationForm #lastName").val(resp.lastName);
					$("#registrationForm #email").val(resp.email);
					$("#registrationForm #phoneNo").val(resp.phoneNo);
					$("#registrationForm #propertyLocation").val(
							resp.propertyLocation);
					$("#registrationForm #street").val(resp.street);
					
					$("#registrationForm #country").val(resp.country);
					$("#registrationForm #postalCode").val(resp.postalCode);
					$("#registrationForm #locality").val(resp.locality);
					$("#registrationForm #vatNo").val(resp.vatNo);
					$("#registrationForm #companyName").val(resp.companyName);
					$("#registrationForm #arrivalPort").val(
							resp.arrivalPortName);
					$("#registrationForm #operatorTypeName").val(
							resp.operatorTypeName);
					$("#registrationForm #portAddress").val(
							resp.portAddressName);
					$("#registrationForm #passportNo").val(resp.passportNo);
					$("#questionId1 #country").val(resp.country);
					$("#registrationForm #usertypes").val(resp.roles);

					$("#registrationForm #NationalIdImage").val(
							resp.nidFilename);
					$("#registrationForm #nidFilePath").val(resp.nidFilePath);

					$("#registrationForm #photo").val(resp.photoFilename);
					$("#registrationForm #photoFilePath").val(
							resp.photoFilePath);

					$("#registrationForm #idCard").val(resp.idCardFilename);
					$("#registrationForm #idCardFilePath").val(
							resp.idCardFilePath);

					$("#registrationForm #vatFile").val(resp.vatFilename);
					$("#registrationForm #vatFilePath").val(resp.vatFilePath);

					$("#registrationForm #employeeId").val(resp.employeeId);
					$("#registrationForm #natureOfEmployment").val(
							resp.natureOfEmploymentInterp);
					$("#registrationForm #designation").val(resp.designation);
					$("#registrationForm #authorityName").val(
							resp.authorityName);
					$("#registrationForm #authorityEmail").val(
							resp.authorityEmail);
					$("#registrationForm #authorityPhoneNo").val(
							resp.authorityPhoneNo);
					// $("#registrationForm
					// #authorityEmail").val(resp.authorityEmail);

					// nidFilename
					//populateStates("country", "state");
					
					$("#registrationForm #state").val(resp.province);
					
					$('#registrationForm #state').val(resp.province).trigger(
					"change");
						$("#registrationForm #district").val(resp.district);
						$('#registrationForm #district').val(resp.district)
								.trigger("change");
					

						$("#registrationForm #commune").val(resp.commune);
						$('#registrationForm #commune').val(resp.commune).trigger("change");
					
						$("#registrationForm #village").val(resp.village);
						
					var arr = [];
					var vatStatus = resp.vatStatus;
					arr = resp.roles;
					if (resp.userTypeId == 4 || resp.userTypeId == 5
							|| resp.userTypeId == 6) {
						$("#rolesDiv").show();
						$("#AsTypeDiv").show();
						usertypeData2(resp.userTypeId);
					}
					for (var i = 0; i < arr.length; i++) {
						$(
								'#registrationForm #usertypes option[value="'
										+ arr[i] + '"]').attr('disabled', true);
					}

					// $("#").val(resp[i].);
					var questionData = resp.questionList;
					for (var i = 0; i < questionData.length; i++) {
						$("#registrationForm #questionId" + i).empty();
						var selectData = '<option value="'
								+ questionData[i].questionId + '">'
								+ questionData[i].question + '</option>';
						$("#registrationForm #questionId" + i).append(
								selectData);
						$("#registrationForm #answer" + i).val(
								questionData[i].answer);
						$("#registrationForm #id" + i).val(questionData[i].id);
					}
					questionDataByCategory2();

					$('div#initialloader').delay(300).fadeOut('slow');
				},
				error : function(xhr, ajaxOptions, thrownError) {
				}

			});
}
function updateProfile() {
	$("#passwordBtn").prop('disabled', true);
	$("#btnSave").prop('disabled', true);
	$('#registrationForm #usertypes option').attr('disabled', false);
	var obj = "";
	var oj2 = "";
	var questionData = [];
	$("#registrationForm .securityQuestionDiv").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj2 = {
				questionId : parseInt(val.find('.questionId').val()),
				answer : val.find('.answer').val(),
				id : val.find('.id').val()
			}
			questionData.push(obj2);
		}
	});

	// var data=[];
	// var $el=$("#usertypes");
	// $el.find('option:selected').each(function(){
	// data.push($(this).val());
	// });

	var password = document.getElementById("confirmPassword").value;
	$("#registrationForm").each(function(key, val) {
		val = $(this);
		if (val.html() !== "") {
			obj = {
				id : val.find('#id').val(),
				firstName : val.find('#firstName').val(),
				middleName : val.find('#middleName').val(),
				lastName : val.find('#lastName').val(),
				type : val.find('#type').val(),
				email : val.find('#email').val(),
				phoneNo : val.find('#phoneNo').val(),
				propertyLocation : val.find('#propertyLocation').val(),
				street : val.find('#street').val(),
				village : val.find('#village').val(),
				locality : val.find('#locality').val(),
				district : val.find('#district').val(),
				commune : val.find('#commune').val(),
				postalCode : val.find('#postalCode').val(),
				country : val.find('#country').val(),
				province : val.find('#state').val(),
				companyName : val.find('#companyName').val(),
				passportNo : val.find('#passportNo').val(),
				country : val.find('#country').val(),
				questionList : questionData,
				password : password,
				designation : val.find("#designation").val(),
				authorityName : val.find("#authorityName").val(),
				authorityEmail : val.find("#authorityEmail").val(),
				authorityPhoneNo : val.find("#authorityPhoneNo").val()

			}
		}
	});

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$
			.ajax({
				type : 'POST',
				url : contextpath + '/updateProfile',
				contentType : "application/json",
				dataType : 'html',
				data : JSON.stringify(obj),

				success : function(data) {
					var response = JSON.parse(data);
					var lang = window.parent.$('#langlist').val() == 'km' ? 'km'
							: 'en';

					if (response.statusCode == '200') {
						if (response.userstatus == 'Approved') {

							$.i18n().locale = lang;
							$.i18n().load({
								'en' : './resources/i18n/en.json',
								'km' : './resources/i18n/km.json'
							}).done(
									function() {
										$("#profileResponse #updateInfoMsg")
												.text($.i18n(response.tag));
										$("#passwordModal").closeModal();
										$('#profileResponse').openModal({
											dismissible : false
										});

									});

						} else if (response.userstatus == 'OTP Verification Pending') {
							$.i18n().locale = $('#langlist').val();
							$.i18n().locale = lang;
							$.i18n().load({
								'en' : './resources/i18n/en.json',
								'km' : './resources/i18n/km.json'
							}).done(function() {
								$("#userid").val(response.userId);
								$("#passwordModal").closeModal();
								$("#otpMsg").text($.i18n(response.tag));
								$("#otpMsgModal").openModal({
									dismissible : false
								});
							});

							// $("#otpMsg").text(response.response);

						} else {
						}
					} else {

						$.i18n().locale = window.parent.$('#langlist').val();
						$.i18n().load({
							'en' : './resources/i18n/en.json',
							'km' : './resources/i18n/km.json'
						}).done(function() {
							// $("#registrationForm
							// #errorMsg").text($.i18n(response.tag));

							$("#passwordModal").closeModal();
							messageWindow($.i18n(response.tag));
						});
					}
					$("#passwordBtn").prop('disabled', false);
					$("#btnSave").prop('disabled', false);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					$("#passwordBtn").prop('disabled', false);
					$("#btnSave").prop('disabled', false);
				}
			});
	return false;
}

function passwordPopup() {
	// $("#btnSave").prop('disabled', true);
	$("#passwordModal").openModal({
		dismissible : false
	});

	return false;
}

function verifyOtp2() {
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
		headers : {
			'X-CSRF-TOKEN' : token
		}
	});
	$.ajax({
		type : 'POST',
		url : contextpath + '/verifyOtp',
		contentType : "application/json",
		dataType : 'html',
		data : JSON.stringify(obj),
		success : function(data) {
			var resp = JSON.parse(data);
			$.i18n().locale = window.parent.$('#langlist').val();
			if (resp.statusCode == "200") {

				$.i18n().load({
					'en' : './resources/i18n/en.json',
					'km' : './resources/i18n/km.json'
				}).done(function() {

					$("#otpVerification").closeModal();
					$("#otpMessage #otpResponse").text($.i18n(resp.tag));
					$('#otpMessage').openModal({
						dismissible : false
					});
				});

			} else {

				// $.i18n().locale =window.parent.$('#langlist').val();
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

function redirectToDashboard() {
	window.location.href = "Home?lang=" + window.parent.$('#langlist').val();
}

function manageAccountPopup() {
	document.getElementById("userStatusForm").reset();
	$('#confirmPassword').val('');
	$("#manageAccount").openModal({
		dismissible : false
	});
}

function changePasswordPopup() {
	// document.getElementById("changePassForm").reset();
	$("#changePassForm #errorMsg").text("");
	$("#changePassForm input").val("");
	$("#changePassForm input").attr('type', 'password');
	$("#changePassForm label").removeClass("active");
	$("#changePassForm .input-field-addon i").removeClass("fa-eye");
	$("#changePassForm .input-field-addon i").addClass("fa fa-eye-slash");
	$("#changePassword").openModal({
		dismissible : false
	});
}

function openLogout() {
	$("#goToLogout").openModal({
		dismissible : false
	});
}

function openHome() {
	$("#goToHome").openModal({
		dismissible : false
	});
}

function loadByAsType(resp) {
	var x = document.getElementById("type").value;
	if (x == '0') {
		// $("input[name='vatStatus']").prop('checked',true);
		// vatShowHide();
		$("input[name='vatStatus']").attr('disabled', false);
		document.getElementById("uploadFile").style.display = "block";
		document.getElementById("passportNumberDiv").style.display = "block";
		document.getElementById("companyNames").style.display = "none";
	} else {
		// $("#vatYes").prop('checked',true);
		// vatShowHide();
		// $("input[name='vatStatus']").attr('disabled', true);
		document.getElementById("uploadFile").style.display = "none";
		document.getElementById("passportNumberDiv").style.display = "none";
		document.getElementById("companyNames").style.display = "block";
	}
}

function vatShowHide() {
	var radioValue = $("input[name='vatStatus']:checked").val();
	if (radioValue == 1) {
		document.getElementById("vatNumberField").style.display = "block";
		document.getElementById("vatFileDiv").style.display = "block";
	} else {
		$("#vatNo").val("");
		$("#vatFile").val("");
		$("input[name='vatFile']").val("");
		document.getElementById("vatNumberField").style.display = "none";
		document.getElementById("vatFileDiv").style.display = "none";
	}
}

function previewFile2(srcFilePath, srcFileName) {
	window.filePath = srcFilePath;
	window.fileName = srcFileName;
	window.fileExtension = fileName.replace(/^.*\./, '');
	window.FinalLink = filePath.concat(fileName);

	if (filePath == null || filePath == "" || filePath == undefined
			&& fileName == null || fileName == "" || fileName == undefined) {
	} else if (fileExtension == "jpg" || fileExtension == "jpeg"
			|| fileExtension == "png" || fileExtension == "gif"  || fileExtension == "PNG") {
		$("#fileSource").attr("src", FinalLink);
		$("#viewuplodedModel").openModal();
	} else {
		window.open(FinalLink);
	}
}
function disbaleSubmitLogiut(buttonId){
	$("#"+buttonId).prop('disabled', true);
}