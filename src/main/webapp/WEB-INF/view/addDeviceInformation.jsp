<%@ page import="java.util.Date" %>
<%
   response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "no-cache");
	
    /*   //200 secs
	 session.setAttribute("usertype", null);  */
/* 	 session.setMaxInactiveInterval(10); */
	 int timeout = session.getMaxInactiveInterval();
	 long accessTime = session.getLastAccessedTime();
	 long currentTime= new Date().getTime(); 
	 long dfd= accessTime +timeout;
	
	 if( currentTime< dfd){
	/*  response.setHeader("Refresh", timeout + "; URL = ../login");
	 System.out.println("timeout========"+timeout); 
	if (session.getAttribute("usertype") != null) { */
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!-- Security Tags -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:csrfMetaTags />
<!-- Security Tags -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head><title>EIRS Portal</title>
<!--<title>Device Information</title>-->

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="" name="description" />
<meta content="" name="author" />
<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- Security Tags -->
<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<!--   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"></script>  
 -->

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">


<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href=""
	type="text/css" rel="stylesheet" media="screen,projection">
<%-- <link href="${context}/resources/css/jquery-datepicker2.css"
	type="text/css" rel="stylesheet" media="screen,projection"> --%>
<!-- Custome CSS-->
<link href="" type="text/css"
	rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
<link href="${context}/resources/plugins/prism/prism.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<%--  <link href="${context}/resources/plugins/chartist-js/chartist.min.css" type="text/css" rel="stylesheet" media="screen,projection"> --%>
<link rel="stylesheet"
	href="${context}/resources/project_css/viewConsignment.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">

<%-- <link rel="stylesheet"
	href="${context}/resources/project_css/jquery-ui.css"> --%>
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>

<script src="${context}/resources/js/jquery.blockUI.js"></script>
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
	margin-top: 5px;
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
<body data-id="12" session-value="${not empty param.NID ? param.NID : 'null'}"
 data-username="${username}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-roleType="${usertype}">

	<!-- START CONTENT -->
	<section id="content">
	<div id="initialloader"></div>
		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div class="container-fluid pageHeader">
								<p class="PageHeading"><spring:message code="registerconsignment.header.addDeviceInformation" /></p>
								<!-- <a href="#addDevice" class="boton right modal-trigger">Add Device</a> -->
							</div>
							<div id="user123" class="section">
								<form action="" onsubmit="return submitDeviceInfo()"
									method="POST" enctype="multipart/form-data">
									<div id="mainDeviceInformation" class="mainDeviceInformation">
										<div id="deviceInformation" class="deviceInformation">
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m12" style="margin-top: 30px;">
														<h5><spring:message code="modal.deviceInfo" /></h5>
														<hr>
													</div>

													<div class="col s12 m6">
														<label for="deviceType1"><spring:message code="select.deviceType" /><span
															class="star"></span></label> <select class="browser-default"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											                oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															id="deviceType1">
															<option value=""  selected><spring:message code="select.selectDeviceType" />
																</option>


														</select>
													</div>

													<div class="col s12 m6">
														<label for="deviceIdType1"><spring:message code="select.deviceIDType" /><span
															class="star">*</span></label> <select required="required"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											                oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															class="browser-default" id="deviceIdType1">
															<option value="" disabled="disabled" selected><spring:message code="select.selectDeviceIDType" /></option>

														</select>
													</div>

													<div class="col s12 m6">
														<label for="multipleSimStatus1"><spring:message code="registration.selectMultiplestLawfull" /><span class="star">*</span>
														</label> <select class="browser-default"  required="required" onchange="setContactIMEINumber('multipleSimStatus1','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
														oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															id="multipleSimStatus1">
															<option value=""  selected><spring:message code="select.select" />
														</select>
													</div>

													<div class="col s12 m6">
														<label for="country1"><spring:message code="select.countryBoughtFrom" /><span
															class="star"></span></label> <select id="country1"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															class="browser-default" class="mySelect"
															style="padding-left: 0;">
															<option value=""  selected><spring:message code="select.countryBoughtFrom" />
														</select>
													</div>

													<div class="input-field col s12 m6"
														style="margin-top: 28px;">
														<input type="text" id="serialNumber1" name="serialNumber"
														pattern="<spring:eval expression="@environment.getProperty('pattern.serialNumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
											        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															title=""
															maxlength="25"> <label for="serialNumber1"> <spring:message code="input.deviceSerialNumber" /><span class="star"></span>
														</label>
													</div>

													<div class="col s12 m6" id="taxStatusDiv">
														<label for="taxStatus1"><spring:message code="select.taxPaidStatus" /><span
															class="star">*</span></label> <select class="browser-default"
															required="required"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															 id="taxStatus1">
															<option value="" disabled selected><spring:message code="select.selectTaxPaidStatus" /></option>

														</select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m6" style="margin-top: -10px;">
														<label for="deviceStatus1"><spring:message code="select.deviceStatus" /><span
															class="star">*</span></label> <select class="browser-default"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															required="required" id="deviceStatus1">
															<option value="" disabled selected><spring:message code="select.selectDeviceStatus" /></option>

														</select>
													</div>

													<div class="input-field col s12 m6 l6" id="priceDiv">
														<input type="text" name="Price" id="Price1"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
											        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
														pattern="^\d+(?:\.\d{1,2})?$"  maxlength="9">
														<label for="Price1"><spring:message code="select.price" /></label>
													</div>

													<div class="col s12 m6" id="CurrencyDiv" style="display: none;">
														<label for="Currency1"><spring:message code="input.currency" /><span class="star">*</span></label>
														<select class="browser-default" id="Currency1"
														oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											            oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
															<option value="" disabled selected><spring:message code="select.selectCurrency" /></option>
														 </select>
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
														<div id="IMEIndContact1" style="display: none">
														<p><spring:message code="title.imeiMeidEsn" /></p>
															<div class="input-field col s12 m6">
																<input type="text" id="IMEIA1" name="IMEI1"
																	pattern="[0-9]{15,16}" required 
																	oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
											        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																
																	maxlength="16"> <label for="IMEIA1"><spring:message code="title.one" /><span
																	class="star">*</span></label>	<p id="errorMsgOnModal" class="deviceErrorTitle" style="margin-top:-88px;margin-left: 173px;"></p>
															</div></div>
															<div id="IMEIndContact2" style="display: none">
															<div class="input-field col s12 m6">
																<input type="text" id="IMEIB1" name="IMEI2"
																	pattern="[0-9]{15,16}" 
																	oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
											        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															
																	maxlength="16"> <label for="IMEIB1"><spring:message code="title.two" /></label>
															</div></div>
<div id="IMEIndContact3" style="display: none">
															<div class="input-field col s12 m6">
																<input type="text" id="IMEIC1" name="IMEIC3"
																	pattern="[0-9]{15,16}" 
																	oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
											        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																
																	maxlength="16"> <label for="IMEIC1"><spring:message code="title.three" /></label>
														
															</div></div>
<div id="IMEIndContact4" style="display: none">
															<div class="input-field col s12 m6" id="field">
																<input type="text" id="IMEID1" name="IMEID4[]"
																	pattern="[0-9]{15,16}" 
																	oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
											        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																	title="Please enter minimum 15 and maximum 16 digit only"
																	maxlength="16" id="field0"> <label for="IMEID1"><spring:message code="title.four" /></label>
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
										</button> --%>
										<p>
											<spring:message code="input.requiredfields" /> <span class="star">*</span>
										</p>
									</div>

									<div class="col s12 m12 center" style="margin-top: 30px;">
										<button class="btn " type="submit"> <spring:message code="button.submit" /></button>
										<button type='button' class="btn" id="redirectToPage" 
												style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
									</div>

								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--end container-->
	</section>
	<!-- END CONTENT -->
	</div>
	<!-- END WRAPPER -->

	</div>
	<!-- END MAIN -->



	<!-- //////////////////////////////////////////////////////////////////////////// -->

	<!-- START FOOTER -->
	<!-- <footer class="page-footer"
		style="position: fixed; bottom: 0; width: 100%;">
		<div class="footer-copyright">
			<div class="container">
				<span class="right">Copyright Ã‚Â© 2018 Sterlite Technologies
					Ltd, All rights reserved.</span>
			</div>
		</div>
	</footer> -->
	<!-- END FOOTER -->

	<!-- Modal 2 start   -->

	<div id="payNowTaxPayment" class="modal">
		<div class="modal-content">
			<h6 class="modal-header"><spring:message code="registerconsignment.header.addDeviceInformation" /></h6>
			<div class="row">
				<h6><spring:message code="modal.regularizedDevice" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close btn"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->

	<!-- Modal 2 start   -->

	<div id="needToPayTax" class="modal">
		<div class="modal-content">
			<h6 class="modal-header"><spring:message code="modal.payTaxInfo" /></h6>
			<div class="row">
				<h6><spring:message code="modal.needTaxPay" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close btn"> <spring:message code="button.payNow" /></button>
						<button class="modal-close btn" style="margin-left: 10px;"><spring:message code="button.payLater" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->

	<!-- Pay Tax Modal start   -->

	<div id="payTaxModal" class="modal">
		<div class="modal-content">
			<h6 class="modal-header"><spring:message code="modal.payTaxInfo" /></h6>
			<div class="row">
				<h6> <spring:message code="modal.taxHasBeenPaid" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close modal-trigger btn"
							data-target="payNowTaxPayment"><spring:message code="modal.yes" /></button>
						<button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Pay Tax Modal End -->

	
	
	<!-- Modal 2 start   -->

	<div id="addDevice" class="modal">
		<div class="modal-content">
			<h6 class="modal-header"><spring:message code="button.adddevice" /></h6>
			<div class="row">
				<div class="row">

					<div class="col s12 m6">
						<label for="deviceType"><spring:message code="select.deviceType" /><span class="star">*</span></label>
						<select class="browser-default" id="deviceType">
							<option value="" disabled selected><spring:message code="select.deviceType" /></option>
							<option value="Handheld">Handheld</option>
							<option value="MobilePhone">Mobile Phone/Feature phone</option>
							<option value="Vehicle">Vehicle</option>
							<option value="Portable">Portable(include PDA)</option>
							<option value="Module">Module</option>
							<option value="Dongle">Dongle</option>
							<option value="WLAN">WLAN Router</option>
							<option value="Modem">Modem</option>
							<option value="Smartphone">Smartphone</option>
							<option value="Computer">Connected Computer</option>
							<option value="Tablet">Tablet</option>
							<option value="e-Book">e-Book</option>
						</select>
					</div>

					<div class="col s12 m6">
						<label for="deviceType"><spring:message code="select.multiSimStatus" /> <span
							class="star">*</span></label> <select class="browser-default"
							id="deviceType">
							<option value="" disabled selected><spring:message code="select.multiSimStatus" /></option>
							<option value="Yes">Yes</option>
							<option value="No">No</option>
						</select>
					</div>

					<div class="col s12 m6">
						<label for="country"><spring:message code="select.countryBoughtFrom" /> <span
							class="star">*</span></label> <select id="country"
							class="browser-default" class="mySelect" style="padding-left: 0;"
							required></select>
					</div>

					<div class="input-field col s12 m6" style="margin-top: 25px;">
						<input type="text" id="serialNumber" name="serialNumber"
							pattern="[0-9]"
							title="Please enter your device serial number first"
							maxlength="20"> <label for="serialNumber"><spring:message code="input.deviceSerialNumber" /><span class="star">*</span>
						</label>
					</div>

					<div class="col s12 m6">
						<label for="deviceType"><spring:message code="select.taxPaidStatus" /><span class="star">*</span></label>
						<select class="browser-default" id="deviceType">
							<option value="" disabled selected><spring:message code="select.taxPaidStatus" /></option>
							<option value="Regularized">Regularized</option>
							<option value="Paid">Paid</option>
							<option value="NotPaid">Not Paid </option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col s12 m12">
						<p style="margin-bottom: 0;"><spring:message code="title.imeiMeidEsn" /></p>
					</div>
					<div class="input-field col s12 m6">
						<input type="text" id="IMEI1" name="IMEI1" pattern="[0-9]"
							title="Please enter minimum 15 and maximum 16 digit only"
							maxlength="16"> <label for="IMEI1"><spring:message code="title.one" /><span
							class="star">*</span></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="IMEI2" name="IMEI2" pattern="[0-9]"
							title="Please enter minimum 15 and maximum 16 digit only"
							maxlength="16"> <label for="IMEI2"><spring:message code="title.two" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="IMEI3" name="IMEI3" pattern="[0-9]"
							title="Please enter minimum 15 and maximum 16 digit only"
							maxlength="16"> <label for="IMEI3"><spring:message code="title.three" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="IMEI4" name="IMEI4[]" pattern="[0-9]"
							title="Please enter minimum 15 and maximum 16 digit only"
							maxlength="16"> <label for="IMEI4"><spring:message code="title.four" /></label>
					</div>

					<div class="col s12 m12">
						<p><spring:message code="input.requiredfields" /><span class="star">*</span>
						</p>
					</div>

					<div class="col s12 m12 center" style="margin-top: 10px;">
						<button class="btn modal-trigger modal-close"
							data-target="submitMsg"><spring:message code="button.submit" /></button>
						<button class="btn modal-trigger modal-close"
							data-target="cancelMsg" style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->

	<!-- Modal 2 start   -->

	<div id="viewDeviceInformation" class="modal">
		<div class="modal-content">
			<h6 class="modal-header"><spring:message code="modal.viewDeviceInfo" /></h6>
			<div class="row">
				<div class="row">

					<div class="col s12 m6">
						<label for="deviceType"><spring:message code="select.deviceType" /><span class="star">*</span></label>
						<select class="browser-default" id="deviceType" disabled>
							<option value="MobilePhone"><spring:message code="select.mobileFeature" /></option>
						</select>
					</div>

					<div class="col s12 m6">
						<label for="deviceType"><spring:message code="select.multiSimStatus" /><span
							class="star">*</span></label> <select class="browser-default"
							id="deviceType" disabled>
							<option value="Yes">Yes</option>
						</select>
					</div>

					<div class="col s12 m6" style="margin-top: 3px;">
						<label for="country"><spring:message code="select.countryBoughtFrom" /><span
							class="star">*</span></label> <input type="text" id="country"
							name="country" placeholder="" disabled>
					</div>

					<div class="input-field col s12 m6" style="margin-top: 25px;">
						<input type="text" id="serialNumber" name="serialNumber"
							pattern="[0-9]"
							title="Please enter your device serial number first"
							maxlength="20" placeholder="" disabled> <label
							for="serialNumber"><spring:message code="input.deviceSerialNumber" /><span
							class="star">*</span></label>
					</div>

					<div class="col s12 m6">
						<label for="deviceType"> <spring:message code="select.taxPaidStatus" /><span class="star">*</span></label>
						<select class="browser-default" id="deviceType" disabled>
							<option value="Regularized"> <spring:message code="select.regularized" /></option>
						</select>
					</div>
				</div>
				<div class="row input_fields_wrap">
					<div class="col s12 m12">
						<p style="margin-bottom: 0;"><spring:message code="title.imeiMeidEsn" /></p>
					</div>
					<div class="input-field col s12 m6">
						<input type="text" id="IMEI1" name="IMEI1" pattern="[0-9]" 
							title="Please enter minimum 15 and maximum 16 digit only"
							maxlength="16" placeholder="" disabled> <label
							for="IMEI1"><spring:message code="title.one" /><span class="star">*</span></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="IMEI2" name="IMEI2" pattern="[0-9]"
							title="Please enter minimum 15 and maximum 16 digit only"
							maxlength="16" placeholder="" disabled>
						<label for="IMEI2"><spring:message code="title.two" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="IMEI3" name="IMEI3" pattern="[0-9]"
							title="Please enter minimum 15 and maximum 16 digit only"
							maxlength="16"> <label for="IMEI3"><spring:message code="title.three" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="IMEI4" name="IMEI4[]" pattern="[0-9]"
							title="Please enter minimum 15 and maximum 16 digit only"
							maxlength="16"> <label for="IMEI4"><spring:message code="title.four" /></label>
					</div>

					<div class="col s12 m12 center" style="margin-top: 10px;">
						<button class="btn modal-close" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->

	<!-- Modal start   -->

	<div id="cancelMsg" class="modal">
		<h6 class="modal-header"><spring:message code="modal.cancelrequest" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6><spring:message code="modal.dataWillBeLost" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<!-- <button class="modal-close btn">yes</button> -->
						<a href="./uploadPaidStatus" class="btn"><spring:message code="modal.yes" /></a>
						<button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->

	<!-- Modal start   -->

	<div id="regularisedDevice" class="modal">
		<h6 class="modal-header"><spring:message code="customRegisterDevice" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="sucessMessage"><spring:message code="modal.message.futureRef" />  <span id="dynamicTxnId"></span>
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" id="ok"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="deleteMsg" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.delete" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6><spring:message code="modal.deleteDeviceInfo" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<button class="modal-close modal-trigger btn"
						data-target="confirmDeleteMsg"><spring:message code="modal.yes" /></button>
					<button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->

	<!-- Modal start   -->

	<div id="confirmDeleteMsg" class="modal">
		<h6 class="modal-header"> <spring:message code="modal.header.delete" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6><spring:message code="modal.deviceInfoDeleted" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<button class="modal-close btn"><spring:message code="modal.ok" /></button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->

	<!-- Modal start   -->

	<div id="submitMsg" class="modal">
		<h6 class="modal-header"> <spring:message code="modal.submitRequest" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6><spring:message code="modal.requestSubmit" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close btn"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->


<div id="AddDeviceDuplicateImei" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.registerdevice" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="deviceDupliCateImeiMsg"><spring:message code="modal.message.futureRef" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a  class="modal-close btn" ><spring:message code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	
	<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>

	
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

	<script type="text/javascript"
		src="${context}/resources/i18n_library/min.js"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/addDeviceInfo.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<!-- ================================================
    Scripts
    ================================================ -->
<script type="text/javascript">
$('#ok,#redirectToPage').click(function(){

	var usersNid =sessionStorage.getItem("nationalId");
	var enterdNid = usersNid.replace("#", "%23");

	window.location.replace("${context}/uploadPaidStatus?via=other&NID="+enterdNid);
	 
});

$('div#initialloader').delay(300).fadeOut('slow');
</script>

<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
      
<script type="text/javascript">var countHit="";  $( document ).ready(function() { if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
$("body").click(function(e) {
	$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});
	$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;countHit=0;},error: function (jqXHR, textStatus, errorThrown) {}});
	if( currentTime > timeoutTime )
	{
		
		document.addEventListener("click", handler, true);
	  function handler(e) {
			  e.stopPropagation();
			  e.preventDefault();
			}  
			   
	 
		window.top.location.href = "./login?isExpired=yes";   
		   
 		 
		}
	else{timeoutTime = currentTime + timeout;}});});
	</script>
	
	
</body></html>
<%
	} else {
		/*  request.setAttribute("msg", "  *Please login first");
		request.getRequestDispatcher("./index.jsp").forward(request, response); */
%>
<script language="JavaScript">
	sessionStorage.setItem("loginMsg",
			"*Session has been expired");
	window.top.location.href = "./login";
</script>
<%
	}
%>