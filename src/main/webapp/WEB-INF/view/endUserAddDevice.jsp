
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<!-- Security Tags -->
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:csrfMetaTags />
<!-- Security Tags -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<title>CEIR Portal</title>
<!--<title>Add Devices</title>-->
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='-1'>
<meta http-equiv='pragma' content='no-cache'>

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="" name="description" />
<meta content="" name="author" />
<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- Security Tags -->
<%-- <jsp:include page="/WEB-INF/view/endUserHeader.jsp" ></jsp:include>
<jsp:include page="/WEB-INF/view/endUserFooter.jsp" ></jsp:include>
 --%>
<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png"
	sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">

<%-- 
<link href="${context}/resources/css/jquery-datepicker2.css"
	type="text/css" rel="stylesheet" media="screen,projection"> --%>
<!-- Custome CSS-->
<link href="" type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
<link href="${context}/resources/plugins/prism/prism.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
<link rel="stylesheet"
	href="${context}/resources/project_css/intlTelInput.css">

<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">


<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>


<!------------------------------------------- Dragable Model---------------------------------->

<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>



<style>
.row {
	margin-bottom: 0;
	margin-top: 0;
}

input[type=text] {
	height: 35px;
	margin: 0 0 5px 0;
}

.checkboxFont {
	font-size: 16px;
	margin-right: 10px;
}

textarea.materialize-textarea {
	padding: 0;
	padding-left: 10px;
}

.btn-flat {
	height: auto;
}

select option {
	color: #444;
}

#filterFileStatus {
	color: #444;
}

.dropdown-content li>a, .dropdown-content li>span {
	color: #444;
}

.welcomeMsg {
	padding-bottom: 50px !important;
	line-height: 1.5 !important;
	text-align: center;
}

.pay-tax-icon {
	font-size: 20px;
	color: #2e568b;
	margin: 0 7px;
}

.row {
	margin-top: 0px;
}

.section {
	padding-top: 0 !important;
}

label {
	font-size: 0.8rem;
}

input[type=text]:disabled+label {
	color: #444;
}

input::placeholder {
	color: #444;
}

select:disabled {
	color: #444;
}

/* .btn-info {
            margin-right: 1%;
        } */
input[type='search'] {
	background-image: url(images/search-512.jpg);
	background-position: 97% 7px;
	background-repeat: no-repeat;
	color: #444;
}
</style>
</head>
<body data-id="12"
	session-value="${not empty param.NID ? param.NID : 'null'}"
	data-roleType="${usertype}"
	data-lang-param="${pageContext.response.locale}" onLoad='self.scrollTo(0,0)'>

	<!-- START CONTENT -->
	<section id="content">
		<!-- <div id="initialloader"></div> -->
		<!--start container-->

		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel register-device-responsive-page"
							style="margin: 5vh auto auto; display: block;">
							<h6 class="fixPage-modal-header ">
<div class="col s9 m10 l10 select-lang-lable-all width87">
<p><spring:message
code="registerconsignment.header.addDeviceInformation" /></p>


<i class="fa fa-globe fa-6" aria-hidden="true"></i>
</div>
<div class="col s3 m2 l2 right width13" style="padding: 0;">
<select class="browser-default select-lang-drpdwn-all"
id="langlist">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message
code="lang.khmer" /></option>
</select>
</div>
</h6>


							<div id="user123" class="section">
								<form action="" onsubmit="return submitDeviceInfo()"
									method="POST" enctype="multipart/form-data">
									<div id="mainDeviceInformation" class="mainDeviceInformation">
										<div id="deviceInformation" class="deviceInformation">
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m12" style="margin-top: 30px;">
														<h5>
															<spring:message code="modal.deviceInfo" />
														</h5>
														<hr>
													</div>

													<div class="col s12 m6">
														<label for="deviceType1"><spring:message
																code="select.deviceType" /><span class="star"></span></label> <select
															class="browser-default"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															id="deviceType1">
															<option value="" selected><spring:message
																	code="select.selectDeviceType" />
															</option>


														</select>
													</div>

													<div class="col s12 m6">
														<label for="deviceIdType1"><spring:message
																code="select.deviceIDType" /><span class="star">*</span></label>
														<select required="required"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															class="browser-default" id="deviceIdType1">
															<option value="" disabled selected><spring:message
																	code="select.selectDeviceIDType" /></option>

														</select>
													</div>

													<div class="col s12 m6">
														<label for="multipleSimStatus1"><spring:message
																code="registration.selectMultiplestLawfull" /><span class="star">*</span>
														</label> <select class="browser-default" required="required" onchange="setContactIMEINumber('multipleSimStatus1','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															id="multipleSimStatus1">
															<option value="" selected><spring:message
																	code="select.select" />
														</select>
													</div>

													<div class="col s12 m6">
														<label for="country1"><spring:message
																code="select.countryBoughtFrom" /><span class="star"></span></label>
														<select id="country1"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															class="browser-default" class="mySelect"
															style="padding-left: 0;">
															<option value="" selected><spring:message
																	code="select.countryBoughtFrom" />
														</select>
													</div>

													


												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m6" style="margin-top: -10px;">
														<label for="deviceStatus1"><spring:message
																code="select.deviceStatus" /><span class="star"></span></label>
														<select class="browser-default"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															id="deviceStatus1">
															<option value="" selected><spring:message
																	code="select.selectDeviceStatus" /></option>

														</select>
													</div>
													<div class="input-field col s12 m6"
														style="margin-top: 10px;">
														<input type="text" id="serialNumber1" name="serialNumber"
															pattern="[A-Za-z0-9]{0,25}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															title="" maxlength="25"> <label
															for="serialNumber1"> <spring:message
																code="input.deviceSerialNumber" /><span class="star"></span>
														</label>
													</div>
													<div class="input-field col s12 m12">
															<textarea id="singleDeviceRemark"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																maxlength="10000" class="materialize-textarea"></textarea>
															<label for="textarea1"> <spring:message
																	code="input.remarksLawfull" /></label>
														</div>


												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class='col s12 m12 input_fields_wrap'>
														
														<div class='row'>
															<div id="IMEIndContact1" style="display: none"><p>
															<spring:message code="title.imeiMeidEsn" />
														</p>
															<div class="input-field col s12 m6">
																<input type="text" id="IMEIA1" name="IMEI1"
																	pattern="[0-9]{15,16}" required 
																	oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	maxlength="16"> <label for="IMEIA1"><spring:message
																		code="title.one" /><span class="star">*</span></label><p id="errorMsgOnModal" class="deviceErrorTitle"
																	style="margin-top: -66px; margin-left: 104px;"></p>
															</div></div>
																<div id="IMEIndContact2" style="display: none">
															<div class="input-field col s12 m6">
																<input type="text" id="IMEIB1" name="IMEI2" 
																	pattern="[0-9]{15,16}"
																	oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	maxlength="16"> <label for="IMEIB1"><spring:message
																		code="title.two" /></label>
															</div></div>
	                                                  <div id="IMEIndContact3" style="display: none">
															<div class="input-field col s12 m6">
																<input type="text" id="IMEIC1" name="IMEIC3" 
																	pattern="[0-9]{15,16}"
																	oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	maxlength="16"> <label for="IMEIC1"><spring:message
																		code="title.three" /></label>
																
															</div></div>
																<div id="IMEIndContact4" style="display: none">
															<div class="input-field col s12 m6" id="field">
																<input type="text" id="IMEID1" name="IMEID4[]"
																	pattern="[0-9]{15,16}"
																	oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	title="Please enter minimum 15 and maximum 16 digit only"
																	maxlength="16" id="field0"> <label for="IMEID1"><spring:message
																		code="title.four" /></label>
															</div></div>
															
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col s12 m12">
										<%-- <button class="btn right add_field_button"
											style="margin-top: 5px;">
											<span style="font-size: 20px;">+</span><spring:message code="button.addMoreDevice" />
										</button>
										<p>
											<spring:message code="input.requiredfields" /> <span class="star">*</span>
										</p> --%>
									</div>

									<div class="col s12 m12 center"
										style="margin-top: 30px; padding-bottom: 50px;">
										<button class="btn " type="submit">
											<spring:message code="button.submit" />
										</button>
										<button type='button' class="btn" id="redirectToPage"
											style="margin-left: 10px;">
											<spring:message code="button.cancel" />
										</button>
									</div>

								</form>

								<form action="selfRegisterDevicePage" method="post"
									id="cancelAddDeviceForm" style="display:none;">
									<input type="text" id="nationalIdForCancel" name="Search">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--end container-->
	</section>

	<div id="regularisedDevice" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.registerdevice" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="sucessMessage">
					<spring:message code="modal.message.futureRef" />
					<span id="dynamicTxnId"></span>
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" id="ok">
							<spring:message code="modal.ok" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="endUserAddDeviceDuplicateImei" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.registerdevice" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="dupliCateImeiMsg">
					<spring:message code="modal.message.futureRef" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a class="modal-close btn"><spring:message code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div style="display: none;">
		<form action="EndUser_AddDevices" method="post"
			id="changedLangAddDeviceForm">
			<input type="text" id="changedAddDeviceLangValue" name="lang"
				style="display: none;"> <input type="hidden"
				name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
	</div>



	<!-- Modal End -->
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>

	<script src="${context}/resources/custom_js/bootstrap.min.js"></script>



	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	
	<!-- i18n library -->
	<script type="text/javascript"
		src="${context}/resources/project_js/CLDRPluralRuleParser.js"></script>
	<script type="text/javascript"
		src="${context}/resources/i18n_library/i18n.js"></script>
	<script type="text/javascript"
		src="${context}/resources/i18n_library/messagestore.js"></script>

	<script type="text/javascript"
		src="${context}/resources/i18n_library/fallbacks.js"></script>

	<script type="text/javascript"
		src="${context}/resources/i18n_library/language.js"></script>

	<script type="text/javascript"
		src="${context}/resources/i18n_library/parser.js"></script>


	<script type="text/javascript"
		src="${context}/resources/i18n_library/emitter.js"></script>


	<script type="text/javascript"
		src="${context}/resources/i18n_library/bidi.js"></script>

	<script type="text/javascript"
		src="${context}/resources/i18n_library/history.js"></script>

	<%-- <script type="text/javascript"
		src="${context}/resources/i18n_library/min.js"></script>
	
			<script type="text/javascript" src="${context}/resources/js/intlTelInput.js"></script> --%>

	<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/endUserAddDevice.js?version=<%= (int) (Math.random() * 10) %>"></script>


	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>


 	

	<script type="text/javascript"
		src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>



	<script type="text/javascript">
/* var input2 = document.querySelector("#phone");
window.intlTelInput(input2, {
	utilsScript : "${context}/resources/js/utils.js",
}); */
$('div#initialloader').delay(300).fadeOut('slow');
</script>

</body>
</html>

