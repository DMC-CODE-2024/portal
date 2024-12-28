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
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!--<title>Company Stolen</title>-->

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

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">


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

<link rel="stylesheet"
	href="${context}/resources/project_css/stolenRecovery.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
<link rel="stylesheet"
	href="${context}/resources/project_css/intlTelInput.css">
<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>

<style>
.checkboxFont {
	color: #444;
	font-size: 16px;
	margin-right: 10px;
}

.section {
	padding-top: 0.5rem;
}

.welcomeMsg {
	padding-bottom: 50px !important;
	line-height: 1.5 !important;
	text-align: center;
}

.file-label {
	font-size: 0.9rem;
}

.contact-label {
	margin-top: -17px;
	margin-bottom: 0;
	font-size: 0.8rem;
}
</style>


</head>

<body data-id="5" data-roleType="${usertype}" data-id="5" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-operatorTypeId="${operatorTypeId}"
	data-selected-roleType="${stolenselectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-txnID="${not empty param.txnId ? param.txnId : 'null'}"
	data-source="${not empty param.reqSource ? param.reqSource : 'null'}">





	<section id="content">
		<!--start container-->
		<div id="initialloader"></div>
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div id="reportBlockUnblock">
								<div class="container-fluid pageHeader">
									<p id="headingType" class="PageHeading"><spring:message code="registration.updatereportstolen" /></p>
								</div>

								<div class="row">
								<!-- 	<div class="col s12">
										<ul class="tabs">
											<li class="tab col s3deviceListlinkDiv"><a class="active"
												onclick="showSingleFormDiv()">Individual</a></li>
											<li class="tab col s3"><a onclick="showBulkFormDiv()">Company/Organisation/Government</a></li>
										</ul>
									</div> -->
									<div id="SingleForm" class="col s12"
										style="margin-top: 30px; display: none">
										<form action="#" id="singleFormSubmit">
											<div class="row">

												<div class="col s12 m12">
													<h5 ><spring:message code="input.personalInformation" /></h5>
													<hr>
												</div>

												<div class="col-s12 m12">
													<div class="input-field col s12 m4">
														<input type="text" name="singleStolenfirstName" placeholder=""
															id="singleStolenfirstName"> <label
															for="singleStolenfirstName"><spring:message code="input.firstName" /> <span
															class="star">*</span></label>
													</div>
									<input type="text" id="existingStolenTxnId" style="display:none" value="${stolenTxnId}" >
													<div class="input-field col s12 m4">
														<input type="text" name="middleName"
														placeholder=""	id="singleStolenmiddleName"> <label
															for="middleName"><spring:message code="input.middleName" /></label>
													</div>

													<div class="input-field col s12 m4">
														<input type="text" name="lastName" placeholder=""
															id="singleStolenlastName"> <label for="lastName">
															<spring:message code="input.lastName" /> <span class="star">*</span>
														</label>
													</div>

													<!-- <div class="input-field col s12 m6">
                                                                <input type="text" name="nationality" id="nationality">
                                                                <label for="nationality">Nationality <span class="star">*</span></label>
                                                            </div> -->

													<!-- <div class="col s12 m6 l6" style="margin-top: -7px;">
                                                                <label for="country">Nationality <span class="star">*</span></label>
                                                                <select id="country" class="browser-default" class="mySelect"
                                                                    style="padding-left: 0;" required></select>
                                                            </div> -->

													<div class="file-field col s12 m6 l6"
														style="margin-top: -8px;">
														<h6 class="form-label">
															 <spring:message code="registration.uploadnid/passportimage" /><span class="star">*</span>
														</h6>
														<div class="btn">
															<span><spring:message code="input.selectfile" /></span> <input type="file"
																placeholder="Upload Photo" id="singleStolenFile">
														</div>
														<div class="file-path-wrapper">
															<input class="file-path validate" type="text"
																placeholder="Upload NID/Passport image"
																id="singleStolenFileName"
																title="Please upload national ID image">
														</div>
													</div>

													<div class="input-field col s12 m6"
														style="margin-top: 22px;">
														<input type="text" name="nIDPassportNumber" placeholder=""
															id="singleStolennIDPassportNumber"> <label
															for="nIDPassportNumber"><spring:message code="registration.nid/passportnumber" /> <span
															class="star">*</span></label>
													</div>

													<div class="input-field col s12 m6 l6">
														<input type="text" name="email" id="singleStolenemail" placeholder=""
															maxlength="30"> <label for="email"><spring:message code="input.email" />
														</label>
													</div>

													<div class="input-field col s12 m6 l6">
														<p class="contact-label">
															<spring:message code="registration.altcontactnumber" /> <span class="star">*</span>
														</p>
														<input type="tel" name="phone" id="singleStolenphone1" placeholder=""
															maxlength="15">
														<!-- <label for="phone">Alternate Contact Number <span class="star">*</span></label> -->
													</div>
													<!-- </div>

                                                        <div class="col s12 m12"> -->
													<div class="input-field col s12 m12">
														<input type="text" name="address" placeholder=""
															class="form-control boxBorder boxHeight"
															id="singleStolenaddress" pattern=[A-Za-z]
															title="Please enter your address"> <label
															for="address"><spring:message code="input.address" /> <span
															class="star">*</span></label>
													</div>

													<div class="input-field col s12 m6 l6">
														<input type="text" name="streetNumber" placeholder=""
															class="form-control boxBorder boxHeight"
															id="singleStolenstreetNumber" maxlength="30"
															pattern=[A-Za-z0-9] title="Please enter street number">
														<label for="streetNumber"><spring:message code="input.streetNumber" /> <span
															class="star">*</span></label>
													</div>

													<div class="input-field col s12 m6 l6">
														<input type="text" name="village" id="singleStolenvillage" placeholder=""
															maxlength="20"> <label for="village"><spring:message code="input.village" />
															<span class="star"></span>
														</label>
													</div>

													<div class="input-field col s12 m6 l6">
														<input type="text" name="locality" placeholder=""
															class="form-control boxBorder boxHeight"
															id="singleStolenlocality" maxlength="20"
															pattern=[A-Za-z0-9] title="Please enter your locality">
														<label for="locality"><spring:message code="input.locality" /> <span class="star"></span></label>
													</div>

													<div class="input-field col s12 m6 l6">
														<input type="text" name="district" placeholder=""
															id="singleStolendistrict" maxlength="20"> <label
															for="district"><spring:message code="input.district" /> <span class="star">*</span></label>
													</div>

													<div class="input-field col s12 m6 l6">
														<input type="text" name="commune" id="singleStolencommune" placeholder=""
															maxlength="20"> <label for="commune"><spring:message code="input.commune" />
															<span class="star">*</span>
														</label>
													</div>

													<div class="input-field col s12 m6 l6">
														<input type="text" name="pin" placeholder=""
															class="form-control boxBorder boxHeight"
															id="singleStolenpin" maxlength="20"> <label
															for="pin"><spring:message code="input.postalCode" /> <span class="star">*</span></label>
													</div>

													<div class="col s12 m6 l6">
														<label><spring:message code="table.country" /> <span class="star">*</span></label> <select
															id="country" class="browser-default" class="mySelect"
															style="padding-left: 0;" required></select>
													</div>

													<div class="col s12 m6 l6">
														<label> <spring:message code="input.province" /><span class="star">*</span></label> <select
															id="state" class="browser-default" class="mySelect"
															style="padding-left: 0;" required></select>
													</div>

													<div class="col s12 m12" style="margin-top: 30px;">
														<h5><spring:message code="modal.deviceInfo" /></h5>
														<hr>
													</div>

													<div>
														<div class="input-field col s12 m6"
															style="margin-top: 22px;">
															<input type="text" name="deviceBrandName" placeholder=""
																id="singleStolendeviceBrandName" maxlength="30">
															<label for="deviceBrandName"><spring:message code="registration.devicebrandname" /></label>
														</div>

														<div class="input-field col s12 m6"
															style="margin-top: 22px;">
															<input type="text" name="imeiNumber" placeholder=""
																id="singleStolenimeiNumber" maxlength="30"> <label
																for="imeiNumber"><spring:message code="registration.imei/meid/esnnumber" /></label>
														</div>

														<div class="col s6 m6 selectDropdwn">
															<label for="deviceIDType"><spring:message code="select.deviceIDType" /></label> <select
																id="singleStolendeviceIDType" class="browser-default">
																<option value="" disabled selected>
																	<spring:message code="select.deviceIDType" /></option>
															</select>
														</div>

														<div class="col s6 m6 selectDropdwn">
															<label for="deviceType"><spring:message code="select.deviceType" /></label> <select
																class="browser-default" id="singleStolendeviceType">
																<option value="" disabled selected><spring:message code="select.deviceType" /></option>
															</select>
														</div>

														<!-- <div class="col s6 m6 selectDropdwn">
                                                                <label for="deviceStatus">Device Status <span class="star">*</span></label>
                                                                <select id="deviceStatus" class="browser-default">
                                                                  <option value="" disabled selected>Device Status</option>
                                                                  <option value="New">New</option>
                                                                  <option value="used">used</option>
                                                                  <option value="Refurbished">Refurbished</option>
                                                                </select>
                                                              </div> -->

														<div class="input-field col s12 m6">
															<input type="text" name="modalNumber" placeholder=""
																id="singleStolenmodalNumber" maxlength="30"> <label
																for="modalNumber"><spring:message code="registration.modelnumber" /></label>
														</div>

														<div class="input-field col s12 m6">
															<p class="contact-label">
																 <spring:message code="input.contactNum" /><span class="star">*</span>
															</p>
															<input type="tel" name="phone" id="singleStolenphone2" placeholder=""
																maxlength="15">
															<!--  <label for="phone2">Contact Number <span class="star">*</span></label> -->
														</div>

														<!-- <div class="input-field col s12 m6">
                                                                <input type="text" name="operator" id="operator" maxlength="10">
                                                                <label for="operator">Operator <span class="star">*</span></label>
                                                            </div> -->

														<div class="col s12 m6 l6">
															<label> <spring:message code="registration.operator" /><span class="star">*</span></label> <select
																class="browser-default" id="singleStolenOperator">
																<option value="" disabled selected>
																	<spring:message code="registration.selectoperator" /></option>

															</select>
														</div>
														
														
														<div class="col s12 m6 l6">
															<label><spring:message code="select.multiSimStatus" />  <span class="star">*</span></label> <select
																class="browser-default" id="singleStolenSimStatus">
																<option value="" disabled selected>  <spring:message code="registration.selectMultiplest" />
																	</option>

															</select>
														</div>														

														<div class="col s12 m6 l6">
															<label> <spring:message code="registration.complainttype" /><span class="star">*</span></label>
															<select class="browser-default"
																id="singleStolenComplaintType">
																<option value="" disabled selected>
																	<spring:message code="registration.selectcomplainttype" /></option>

															</select>
														</div>

														<div class="col s12 m12" style="margin-top: 30px;">
															<h5><spring:message code="registration.plstolen" /></h5>
															<hr>
														</div>
														<!-- <div class="col s12 m12">
                                                                <p><b>Place Of Device Stolen</b></p>
                                                            </div> -->
														<div class="input-field col s12 m12">
															<input type="text" name="address" placeholder=""
																class="form-control boxBorder boxHeight"
																id="singleDeviceAddress" pattern=[A-Za-z]
																title="Please enter your address"> <label
																for="address"><spring:message code="input.address" /> <span
																class="star">*</span></label>
														</div>

														<div class="input-field col s12 m6 l6">
															<input type="text" name="streetNumber" placeholder=""
																class="form-control boxBorder boxHeight"
																id="singleDevicestreetNumber" maxlength="30"
																pattern=[A-Za-z0-9] title="Please enter street number">
															<label for="streetNumber"><spring:message code="input.streetNumber" /> <span
																class="star">*</span></label>
														</div>

														<div class="input-field col s12 m6 l6">
															<input type="text" name="village" placeholder=""
																id="singleDevicevillage" maxlength="20"> <label
																for="village"><spring:message code="input.village" /> <span class="star"></span></label>
														</div>

														<div class="input-field col s12 m6 l6">
															<input type="text" name="locality" placeholder=""
																class="form-control boxBorder boxHeight"
																id="singleDevicelocality" maxlength="20"
																pattern=[A-Za-z0-9] title="Please enter your locality">
															<label for="locality"><spring:message code="input.locality" /> <span class="star"></span></label>
														</div>

														<div class="input-field col s12 m6 l6">
															<input type="text" name="district" placeholder=""
																id="singleDevicedistrict" maxlength="20"> <label
																for="district"><spring:message code="input.district" /> <span class="star">*</span></label>
														</div>

														<div class="input-field col s12 m6 l6">
															<input type="text" name="commune" placeholder=""
																id="singleDevicecommune" maxlength="20"> <label
																for="commune"> <spring:message code="input.commune" /><span class="star">*</span></label>
														</div>

														<div class="input-field col s12 m6 l6">
															<input type="text" name="pin" placeholder=""
																class="form-control boxBorder boxHeight"
																id="singleDevicepin" maxlength="20"> <label
																for="pin"><spring:message code="input.postalCode" /> <span class="star">*</span></label>
														</div>

														<div class="col s12 m6 l6">
															<label> <spring:message code="table.country" /><span class="star">*</span></label> <select
																id="singleDevicecountry" class="browser-default"
																class="mySelect" style="padding-left: 0;" required></select>
														</div>

														<div class="col s12 m6 l6">
															<label><spring:message code="input.province" /> <span class="star">*</span></label> <select
																id="singleDevicestate" class="browser-default"
																class="mySelect" style="padding-left: 0;" required></select>
														</div>

														<div class="input-field col s12 m6">
															<textarea id="singleDeviceRemark" placeholder="" 
																class="materialize-textarea"></textarea>
															<label for="textarea1"><spring:message code="input.remarks" /></label>
														</div>
													</div>
												</div>
											</div>
											<span>  <spring:message code="input.requiredfields" /><span
												class="star">*</span></span>


												<div class="input-field col s12 center">
													<button class="btn modal-trigger"
														data-target="submitStolen"><spring:message code="button.submit" /></button>
													<a href="./stolenRecovery?FeatureId=5" class="btn"
														style="margin-left: 10px;"><spring:message code="modal.cancel" /></a>
												</div>
												
										</form>
									</div>


<!-- ____________________________________________________Bulk stolen form________________________________________________________________________ -->


									<div id="Bulkform" class="col s12" style="display: block">
										<form action="" id="SingleImeiBlockform" onsubmit="return updateCompanyStolenDetails()" method="POST" enctype="multipart/form-data">
											<div class="input-field col s12 m6">
												<input type="text" name="companyName"
												pattern="<spring:eval expression="@environment.getProperty('pattern.companyName')" />"
												 required  placeholder="" title="" 
												    oninput="InvalidMsg(this,'input','<spring:message code="validation.companyName" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.companyName" />');"
													id="bulkStolencompanyName"> <label
													for="companyName"> <spring:message code="registration.companyName" /><span class="star">*</span></label>
											</div>
<input type="text" id="pageViewType" value="${viewType}" style="display: none;">
											<div class="input-field col s12 m6">
												<input type="text" name="address" placeholder=""
													class="form-control boxBorder boxHeight"
													id="bulkStolenaddress" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />" 
													title=""
													oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');" 
												    required="required"> <label
													for="address"> <spring:message code="input.address" /><span
													class="star">*</span></label>
											</div>


											<div class="col s12 m6 l6">
												<label><spring:message code="table.country" /> <span class="star">*</span></label> <select
													id="country2" class="browser-default" class="mySelect"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													style="padding-left: 0;" required></select>
											</div>

											<div class="col s12 m6 l6">
												<label><spring:message code="input.province" /><span class="star">*</span></label> <select
													id="state2" class="browser-default" class="mySelect" 	onchange="getDistrict(this,'bulkStolendistrict','bulkStolencommune');"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													style="padding-left: 0;" required></select>
											</div>
											
											<div class=" col s12 m6 l6">
												<%-- <input type="text" name="district" id="bulkStolendistrict" placeholder=""
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title=""
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												 maxlength="30" required="required"> --%> <label for="district"><spring:message code="input.district" />
													<span class="star">*</span>
												</label>
												<select
										id="bulkStolendistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'bulkStolencommune','bulkStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
											</div>

											<div class=" col s12 m6 l6">
												<%-- <input type="text" name="commune" id="bulkStolencommune" placeholder=""
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title=""
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												 maxlength="30" required="required"> --%> <label for="commune"><spring:message code="input.commune" />
													<span class="star">*</span>
												</label>
												<select
										id="bulkStolencommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'bulkStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option>
										</select>
											</div>
											
											<div class="col s12 m6 l6">
												<%-- <input type="text" name="village" id="bulkStolenvillage" placeholder=""
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title=""
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												 maxlength="30" > --%>
												  <label for="village"><spring:message code="input.village" />
													<span class="star"></span>
												</label>
												<select
										id="bulkStolenvillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option></select>
											</div>
											
											<div class="input-field col s12 m6 l6">
												<input type="text" name="streetNumber" placeholder=""
													class="form-control boxBorder boxHeight"
													id="bulkStolenstreetNumber" title=""
													pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
													required="required" >
												<label for="streetNumber"> <spring:message code="input.streetNumber" /><span
													class="star">*</span></label>
											</div>

											

											<div class="input-field col s12 m6 l6" style="margin-left:1px">
												<input type="text" name="locality" placeholder=""
													class="form-control boxBorder boxHeight"
													id="bulkStolenlocality" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
													 title="" oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
													 maxlength="30" 
													title="Please enter your locality"> <label
													for="locality"><spring:message code="input.locality" /> <span class="star"></span></label>
											</div>

											

											<div class="input-field col s12 m6 l6" style="margin-right: -1px">
												<input type="text" name="pin"
													class="form-control boxBorder boxHeight" id="bulkStolenpin" placeholder=""
													pattern="[0-9]{6,6}" title=""   
													pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
													> <label for="pin"><spring:message code="input.postalCode" />
													<span class="star"></span>
												</label>
											</div>

											

											<div class="col s12 m12" style="margin-top: 30px;">
												<h5><spring:message code="registration.authorizedpersonnelLawfull" /></h5>
												<hr>
											</div>
											<!-- <div class="col s12 m12">
                                                        <p><b>Authorized personnel</b> </p>
                                                    </div> -->

											<div class="input-field col s12 m4">
												<input type="text" name="bulkStolenfirstName" placeholder="" id="firstName" 
												pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
												 title="Please enter alphabets  upto 20 characters only"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												 required="required">
												<label for="firstName"> <spring:message code="input.firstName" /><span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m4">
												<input type="text" name="middleName" placeholder=""
												oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													id="bulkStolenmiddleName" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />">
													 <label for="middleName">
													<spring:message code="input.middleName" /></label>
											</div>

											<div class="input-field col s12 m4">
												<input type="text" name="lastName" placeholder="" id="bulkStolenlastName"
												pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" title="" 
												oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												 >
												<label for="lastName"><spring:message code="input.lastName" /> <span class="star"></span></label>
											</div>

											<div class="input-field col s12 m6">
												<input type="email" name="officeEmail" placeholder=""
													id="bulkStolenofficeEmail" pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
												 title="" oninput="InvalidMsg(this,'email','<spring:message code="validation.emial" />');"
													oninvalid="InvalidMsg(this,'email','<spring:message code="validation.emial" />');"
												   > <label
													for="officeEmail"><spring:message code="registration.officialemailid" /></label>
											</div>

											<div class="input-field col s12 m6">
												<!-- <p class="contact-label">Alternate Contact Number <span class="star">*</span></p> -->
												<input type="tel" name="phone" id="bulkStolenContact" placeholder=""
													pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />" title=""
													oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');
													"oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" 
													> <label for="phone2">
													<spring:message code="input.contactNum" /> <span
													class="star"></span></label>
											</div>
												
												
											<!-- <div class="input-field col s12 m6">
                                                        <input type="text" name="totalQuantity" id="totalQuantity">
                                                        <label for="totalQuantity">Total Device Quantity </label>
                                                    </div> -->

											<div class="col s12 m12" style="margin-top: 30px;">
												<h5><spring:message code="registration.plstolen" /></h5>
												<hr>
											</div>
											<!-- <div class="col s12 m12">
                                                        <p><b>Place Of Device Stolen</b></p>
                                                    </div> -->
											<div class="input-field col s12 m12">
												<input type="text" name="address" placeholder=""
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenaddress"  title=""
													pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />" 
													oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
													 required="required"> <label
													for="address"><spring:message code="input.address" /> <span
													class="star">*</span></label>
											</div>
												
												<div class="col s12 m6 l6">
												<label><spring:message code="table.country" /> <span class="star">*</span></label> <select
													id="country3" class="browser-default" class="mySelect"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													style="padding-left: 0;" required></select>
											</div>

											<div class="col s12 m6 l6">
												<label> <spring:message code="input.province" /><span class="star">*</span></label> <select
													id="state3" class="browser-default" class="mySelect" onchange="getDistrict(this,'deviceBulkStolendistrict','deviceBulkStolencommune');"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													style="padding-left: 0;" required></select>
											</div>
											<div class="col s12 m6 l6">
												<%-- <input type="text" name="district" placeholder=""
													id="deviceBulkStolendistrict"pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title="" maxlength="30" 
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													required="required"> --%> <label
													for="district"><spring:message code="input.district" /> <span class="star">*</span></label>
													<select
										id="deviceBulkStolendistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'deviceBulkStolencommune','deviceBulkStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
											</div>

											<div class=" col s12 m6 l6">
												<%-- <input type="text" name="commune" placeholder=""
													id="deviceBulkStolencommune" pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title="" maxlength="30"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													 required="required"> --%> <label
													for="commune"> <spring:message code="input.commune" /><span class="star">*</span></label>
													<select
										id="deviceBulkStolencommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'deviceBulkStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required><option value=""><spring:message code="select.commune" /></option>
										</select>
											</div>
											
											<div class="col s12 m6 l6">
												<%-- <input type="text" name="village" placeholder="" id="deviceBulkStolenvillage"
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title="" maxlength="30"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');" > --%> <label
													for="village"><spring:message code="input.village" /> <span class="star"></span></label>
													 <select
										id="deviceBulkStolenvillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
											</div>
											
											<div class="input-field col s12 m6 l6" style="margin-top: 23px;">
												<input type="text" name="streetNumber" placeholder=""
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenstreetNumber"  title=""
													pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
													  required="required">
												<label for="streetNumber"><spring:message code="input.streetNumber" /> <span
													class="star">*</span></label>
											</div>


											<div class="input-field col s12 m6 l6">
												<input type="text" name="locality" placeholder=""
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenlocality"  title=""
													pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />" 
													oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="" />');"
													>
												<label for="locality"><spring:message code="input.locality" /> <span class="star"></span></label>
											</div>

											

											<div class="input-field col s12 m6 l6">
												<input type="text" name="pin" placeholder=""
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenpin"  title="" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
													 > <label
													for="pin"><spring:message code="input.postalCode" /><span class="star"></span></label>
											</div>

											

											<div class="col s12 m6 l6">
												<label><spring:message code="registration.complainttype" /> <span class="star">*</span></label> <select
													class="browser-default" id="deviceBulkStolenComplaint"  required="required"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
													<option value="" disabled  selected>
														<spring:message code="registration.selectcomplainttype" /></option>

												</select>
											</div>

											<div class="input-field col s12 m6 l6"
												style="margin-top: 22px;">
												<input type="text" name="quantity" placeholder=""
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenquantity" required="required"
													pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													title=""> <label
													for="quantity"><spring:message code="input.quantity" /> <span class="star">*</span></label>
											</div>
											
											<div class="col s12 m6 l6"
												style="margin-top: 5px;    margin-left: 1px;">
												<label for="devicequantity" class="active" id="deviceQuantityLabel"> <spring:message
														code="input.devicequantity" /><span class="star"> *</span></label>
												<input type="text" name="devicequantity"
													class="form-control boxBorder boxHeight" 
													id="devicequantity" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													required> 
											</div>

											<div class="file-field col s12 m6">
												<h6 class="file-label">
													<spring:message code="registration.uploaddevicelist" /> <span class="star"></span>
												</h6>
												<div class="btn" id="deviceListlinkDiv">
													<span id="dviceFileText"><spring:message code="input.selectfile" /></span> <input type="file"
													oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
													 onchange="isFileValid('deviceBulkStolenFile')" accept=".csv"
														id="deviceBulkStolenFile" placeholder="Upload Photo">
												</div>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text" id="stolenFileName"
														placeholder="Upload Device List"
														title="Please upload your photo">
														<!-- <a href="#" id="deviceListlink" style="display: none;">Preview</a> -->
												</div>
											</div>


											<div class="input-field col s12 m6" data-original-title="" title="">
															<input type="text" name="IndivisualStolenDate" id="IndivisualStolenDate" class="form-control datepick" autocomplete="off" title="" required="" data-original-title="
																validation.requiredMsg" title="<spring:message code=" validation.requiredMsg" />">
															<label for="IndivisualStolenDate" class="center-align" data-original-title="" title="">
																<spring:message
														code="operator.stolenDate" />
														 <span class="star" data-original-title="" title="">*</span>
															</label> <span class="input-group-addon" style="color: #ff4081" data-original-title="" title=""><i class="fa fa-calendar" aria-hidden="true" data-original-title="" title=""></i></span>
														</div>
														
														
<div class="col s12 m6 blockingType">
												<p style="margin-top: 3px; margin-bottom: 5px">
													<spring:message code="operator.blocking" />
												</p>
												<label style="margin-right: 2%;"> <input
													type="radio" class="blocktypeRadio"  value="Immediate" onchange="setDateMandatoryOrOptional('Immediate','stolenBulkDatePeriod')"
													onclick="document.getElementById('stolenCalender').style.display = 'none';"
													name="stolenBulkBlockPeriod" checked> <spring:message
														code="operator.immediate" />
												</label> <label style="margin-right: 2%;"> <input onchange="setDateMandatoryOrOptional('Default','stolenBulkDatePeriod')"
													type="radio" class="blocktypeRadio" value="Default" id="editBulkDefaultPeriod" title=""
													onclick="document.getElementById('stolenCalender').style.display = 'none';"
													name="stolenBulkBlockPeriod"> <spring:message
														code="operator.default" />
												</label> <label> <input type="radio" required="required" onchange="setDateMandatoryOrOptional('tilldate','stolenBulkDatePeriod')"
													value="tilldate" class="blocktypeRadio"
													onclick="document.getElementById('stolenCalender').style.display = 'block';"
													name="stolenBulkBlockPeriod"> <spring:message
														code="operator.later" />
												</label>
												<div class="input-field col s6 m2 responsiveDiv"
													style="display: none; width: 30%; margin-right: 30%; float: right; margin-top: -15px"
													id="stolenCalender">
													<div id="Stolenstartdatepicker" class="input-group date">
														<label for="stolenBulkDatePeriod"><spring:message code="operator.blockingTypePeriod" /> <span class="star"> </span> 
																</label>
														<input type="text" id="stolenBulkDatePeriod"
															style="margin-top: -9px" /> <span
															class="input-group-addon" style="color: #ff4081"><i
															class="fa fa-calendar" aria-hidden="true"
															style="float: right; margin-top: -30px;"></i></span>
													</div>

												</div>

</div>
												<div class="col s12 m2 l2"
													style="width: 40%; display: none; float: right; margin-right: 30%;"
													id="stolenDate">

													<label for="TotalPrice" class="center-align"> <spring:message
															code="operator.tilldate" /></label>
													<div id="Stolenstartdatepicker" class="input-group"
														style="margin-top: 10px;">

														<input class="form-control" name="inputsaves" type="text"
															id="startDateFilter" readonly /> <span
															class="input-group-addon" style="color: #ff4081"><i
															class="glyphicon glyphicon-calendar"
															onclick="_Services._selectstartDate()"></i></span>
													</div>
												</div>
														
														<div class="file-field col s12 m6" data-original-title="" title="" style="margin-right: 2px;">
															<h6 class="form-label" style="margin:8px; font-size: 0.9rem;" data-original-title="" title="">
																<spring:message code="input.UploadFIR" />
															</h6>
															<div class="btn" id="firFileDiv" data-original-title="" title="">
																<span data-original-title="" title="" id="firFileText">
																	<spring:message code="input.selectfile" /></span>
																<input type="file" oninput="InvalidMsg(this,'fileType','
																	validation.NoChosen');" oninvalid="InvalidMsg(this,'fileType','
																No file Chosen ');" placeholder="Upload FIR" id="uploadFirSingle" onchange="isImageValid('uploadFirSingle')" data-original-title="" title="">
															</div>
															<div class="file-path-wrapper" data-original-title="" title="">
																<input class="file-path validate" type="text" placeholder="" id="uploadFirSingleName" title="" data-original-title="Please upload national
																ID image">
																<a href="#" id="firFilePreview" class="imgPreviewLink"  style="display: none;"><spring:message code="input.preView" /></a>
															</div>
														</div>
											<div class="input-field col s12 m6" style="margin-top: 22px;margin-right: -2px;">
												<textarea id="deviceBulkStolenRemark" placeholder=""
													class="materialize-textarea"></textarea>
												<label for="textarea1"><spring:message code="input.remarksLawfull" /></label>
											</div>
											<div class="input-field col s12 m12" style="display: none;" id="bulkDeviceRejectRemarkDiv">
															<textarea id="bulkDeviceRejectRemark" maxlength="10000"
																placeholder=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																class="materialize-textarea"></textarea>
															<label for="textarea1"><spring:message
																	code="input.remarksRejected" /> </label>
														</div>
											<div class="col s12 m12">
                                                        <a href="./Consignment/sampleFileDownload/7" id="editRecoverySampleFile"> <spring:message
														code="input.downlaod.sample" /></a>
											</div>

											<div class="input-field col s12 center">
												<button class="btn" id="companyStolenButton" type="submit"><spring:message code="button.submit" /></button>
												<a onclick="closeViewPage()" class="btn"
													style="margin-left: 10px;"><spring:message code="modal.cancel" /></a>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--end container-->
	</section>



 <div id="stolenSucessPopUp" class="modal">
  <h6 class="modal-header"><spring:message code="registration.updatereportstolen" /></h6>
        <div class="modal-content">
           
            <div class="row">
                <h6 id="dynamicMessage"><spring:message code="input.Theupdated" /></h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <div class="input-field col s12 center">
                        <a  href ="./stolenRecovery?FeatureId=5" class=" btn"><spring:message code="modal.ok" /></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <div id="fileFormateModal" class="modal">
		<h6 class="modal-header"><spring:message code="fileValidationModalHeader" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="fileErrormessage"><spring:message code="fileValidationName" /><br> <br> <spring:message code="fileValidationFormate" /> <br><br> <spring:message code="fileValidationSize" /> </h6>
			<input type="text" id="FilefieldId" style="display: none;">
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close  btn" onclick="clearFileName()"
							style="margin-left: 10px;"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="viewuplodedModel" class="modal" style="overflow: hidden">
	<a href="#!" class="modal-close waves-effect waves-green btn-flat">&times;</a>
		<div class="modal-content">
			<div class="row">
					<img src="" id="fileSource" width="400" height="400">
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>



	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
	<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>

	<!--custom-script.js - Add your own theme custom JS-->



	<!--scrollbar-->
	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	
	
		
	
	<script type="text/javascript"
		src=""></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

	
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
		src="${context}/resources/project_js/provinceDropdown.js?version=<%= (int) (Math.random() * 10) %>" async></script>
	 <script type="text/javascript"
		src="${context}/resources/project_js/CommanLocality.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/stolenRecovery.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/lawfulStolenRecovery.js?version=<%= (int) (Math.random() * 10) %>"></script>

<script type="text/javascript"
		src="${context}/resources/project_js/editCompanyStolen.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/js/intlTelInput.js">
		</script>
 
	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js"></script>

	<script>
	var successMsg,stolenCompany,editstolenCompany;
	var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
	
	$("label[for='devicequantity']").addClass('active');
	$.i18n().locale = lang;	
	//alert(lang)

	
	
	$.i18n().load( {
		'en': './resources/i18n/en.json',
		'km': './resources/i18n/km.json'
	}).done( function() { 
		stolenCompany=$.i18n('stolenCompany');
		editstolenCompany=$.i18n('editstolenCompany');
		//alert(stolenCompany)
		viewPageType();
	});

	function viewPageType(){
	if($('#pageViewType').val()=='view')
	{
	$('#headingType').text('');
	$('#headingType').text(stolenCompany);
	//alert(stolenCompany)
	$("#deviceListlinkDiv").removeClass("btn");
	$('#deviceBulkStolenFile').attr('type','text');
   /* $("#deviceListlinkDiv").removeClass("btn");
	   $('#dviceFileText').text('');
	   $('#deviceBulkStolenFile').attr('type','text');
	   $("#deviceListlink").css("display", "block");
	   $("#deviceBulkStolenFile").css("display", "none"); */
	
	$("#firFileDiv").removeClass("btn");
   $('#firFileText').text('');
   $('#uploadFirSingle').attr('type','text');
   $("#firFilePreview").css("display", "block");
   $("#uploadFirSingle").css("display", "none");
	$("#editRecoverySampleFile").css("display", "none");
	   $("#Bulkform").find("input,textarea,button,select").prop("disabled",true);
	   //$("#Bulkform").find("select").attr("style", "pointer-events: none;");
	   $("#deviceBulkStolenFile").css("display", "none");
	   $("#dviceFileText").css("display", "none");
	   $("#companyStolenButton").css("display", "none");
		$(".star").css("display", "none");
		
		
		$("#bulkDeviceRejectRemarkDiv").css("display", "block");
	}
else{
	$('#headingType').text('');
	$('#headingType').text(editstolenCompany);
	$("#Bulkform").find("input,select,textarea,button").prop("disabled",false);
	$("#bulkDeviceRejectRemarkDiv").css("display", "none");
	$("#singleRecoveryDiv").find("select").attr("style", "pointer-events: block;");
	
}	
	}	
 populateCountries(
	        "singleDevicecountry",
	        "singleDevicestate"
	    );
	    populateStates(
	        "singleDevicecountry",
	        "singleDevicestate"
	    );
	    
	    
	    populateCountries(
	            "country",
	            "state"
	        );
	        populateStates(
	            "country",
	            "state"
	        );
	        
	        populateCountries(
		            "country2"
		        );
		        populateStates(
		            "country2",
		            "state2"
		        );
		        
		        populateCountries(
			            "country3"
			        );
			        populateStates(
			            "country3",
			            "state3"
			        );
		 
			        
			        $("#country3").attr("style", "pointer-events: none;");
        var input2 = document.querySelector("#singleStolenphone2");
        window.intlTelInput(input2, {
            utilsScript: "${context}/resources/js/utils.js",
        });
        var input = document.querySelector("#singleStolenphone1");
        window.intlTelInput(input, {
            utilsScript: "${context}/resources/js/utils.js",
        });
        
        setDropdownProviance('state2');
        setDropdownProviance('state3');   
          
         
        $('.datepick').datepicker({
			dateFormat: "yy-mm-dd",
			maxDate:"0"
		});

        $('#stolenBulkDatePeriod').datepicker({
        	dateFormat: "yy-mm-dd",
        	minDate: "0"
        	
        	});
        
        
    </script>

<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
<script type="text/javascript">var countHit="";  $( document ).ready(function() {  if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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
	}else{
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