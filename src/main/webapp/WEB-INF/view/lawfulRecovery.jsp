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
<!--<title>Stolen</title>-->

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
<%-- <link href="${context}/resources/css/jquery-datepicker2.css"
	type="text/css" rel="stylesheet" media="screen,projection"> --%>
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
	href="${context}/resources/project_css/stolenRecovery.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="${context}/resources/project_css/select2.css">

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

.blockingType {
	height: 4.6rem;
	margin-bottom: 5px;
}

textarea.materialize-textarea {
	height: auto;
	max-height: 300px;
	s
}

select.browser-default {
	height: 34px;
	margin-bottom: 4px;
}

.checkboxFont {
	color: #444;
	font-size: 16px;
	margin-right: 10px;
}
section#content {

    position: absolute;
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
    margin-top: -7px;
    margin-bottom: 0;
    font-size: 0.8rem;
}
.blockingType {
	height: 4.6rem;
	margin-bottom: 5px;
}

textarea.materialize-textarea {
	height: unset !important;
	max-height: 300px !important;
}

select {
	margin-bottom: 5px;
	height: 2.2rem;
}

.iti--allow-dropdown input, .iti--allow-dropdown input[type=text] {
	margin-bottom: 5px !important;
}
</style>


</head>

<body data-id="5" data-roleType="${usertype}"
	data-userTypeID="${usertypeId}" data-userID="${userid}"
	data-operatorTypeId="${operatorTypeId}"
	data-selected-roleType="${stolenselectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-filterSource="${filterSource}">





	<!-- START CONTENT -->
	<section id="content">
		<div id="initialloader"></div>
		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div id="reportBlockUnblock">
								<div class="container-fluid pageHeader">
									<p class="PageHeading">
										<spring:message code="registration.reportrecovery" />
									</p>
								</div>

								<div class="row">
									<div class="col s12">
										<ul class="tabs">
											<li class="tab col s3"><a class="active"
												onclick="singleRecoverydiv()"><spring:message
														code="input.Individual" /></a></li>
											<li class="tab col s3"><a onclick="showBulkRecovery()"><spring:message
														code="registration.company/organisation/government" /></a></li>
										</ul>
									</div>
									<div id="singleRecoveryDiv" class="col s12"
										style="margin-top: 30px; display: block">
										<form action="" id=""
											onsubmit="return saveIndivisualRecoveryRequest()"
											method="POST" enctype="multipart/form-data">
											<div class="row">
												<div class="col-s12 m12">
													<div class="col s12 m6">

														<label for="sigleRecoverydeviceBrandName"><spring:message
																code="registration.devicebrandname" /> <span
															class="star"></span></label> <select
															id="sigleRecoverydeviceBrandName" class="browser-default"
															onchange="changeSelectDropDownToText('sigleRecoverydeviceBrandName')"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
															<option value=""  selected><spring:message
																	code="registration.selectproduct" />
															</option>
														</select>
														<%--  <input type="text" name="sigleRecoverydeviceBrandName" id="sigleRecoverydeviceBrandName" pattern="[a-zA-Z]{0,30}" 
                                                     oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');" 
                                                     oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
                                                                 maxlength="30">
                                                                <label for="sigleRecoverydeviceBrandName"><spring:message code="registration.devicebrandname" /></label> --%>
													</div>
													<%-- <div class="col s12 m6">

														<label for="singleRecoverymodalNumber"><spring:message
																code="registration.modelnumber" /> <span
															id="modalNumerSpan" class="star" style="display: none;">*</span></label>
														<select id="singleRecoverymodalNumber"
															class="browser-default"
															onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
															<option value=""  selected>
																<spring:message code="registration.selectmodelnumber" /></option>

														</select>
													</div> --%>
													<%-- 
                                                            <div class="input-field col s12 m6" style="margin-top: 22px;">
                                                                <input type="text" name="sigleRecoveryimeiNumber" id="sigleRecoveryimeiNumber" 
                                                                 pattern="[0-9]{15,16}" 
                                                               oninput="InvalidMsg(this,'input');" oninvalid="InvalidMsg(this,'input');"
                                                                title= "<spring:message code="validation.1516digit" />" required  maxlength="16" />
                                                                <label for="sigleRecoveryimeiNumber"> <spring:message code="registration.imei/meid/esnnumber" /><span class="star"> *</span></label>
                                                            </div> --%>

													<div class="col s6 m6 " style="margin-top: 4px;">
														<label for="sigleRecoverydeviceIDType"><spring:message
																code="select.deviceIDType" />  <span class="star">
																*</span></label>  <select id="sigleRecoverydeviceIDType" required="required"
															class="browser-default"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
															<option value=""  selected><spring:message
																	code="select.deviceIDType" /></option>
														</select>
													</div>
													
													<div class="input-field  col s12 m12" id="OtherBrandNameDiv" style="display: none">
														<input type="text" name="brandName" id="OtherBrandName"
															pattern="[a-zA-Z0-9\s,'*$-]{0,50}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															 maxlength="50"> <label
															for="singleStolencommune"> <spring:message
																code="registration.devicebrandname" /> <span class=" star"> *</span>
														</label>
													</div>

													<div class="col s6 m6 ">
														<label for="sigleRecoverydeviceType"><spring:message
																code="select.deviceType" /> </label> <select
															class="browser-default" id="sigleRecoverydeviceType"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
															<option value=""  selected><spring:message
																	code="select.deviceType" /></option>
														</select>
													</div>

													<div class="col s6 m6 ">
														<label for="sigleRecoverydeviceSimStatus"> <spring:message
																code="select.multiSimStatus" /><span class=" star"> *</span></label> <select
															id="sigleRecoverydeviceSimStatus" class="browser-default" required="required"
															onchange="setContactIMEINumber('sigleRecoverydeviceSimStatus','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
															<option value=""  selected><spring:message
																	code="select.multiSimStatus" /></option>
														</select>
													</div>

													<div class="input-field col s12 m6"
														style="margin-top: 22px;">
														<input type="text" name="sigleRecoveryserialNumber"
															id="sigleRecoveryserialNumber"
															pattern="<spring:eval expression="@environment.getProperty('pattern.serialNumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															> <label
															for="sigleRecoveryserialNumber"><spring:message
																code="input.deviceSerialNumber" /></label>
													</div>

													
										           	<div id="IMEIndContact1" style="display: none">	
													<div class="col s12 m12"
														style="margin-top: 10px; font-weight: bold;">
														<h6>
															<spring:message code="registration.imei/meid/esnnumber" />
														</h6>
													</div>
													<div class="input-field col s12 m6">
														<input type="text" name="sigleRecoveryimeiNumber1" required="required"
														pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															 id="sigleRecoveryimeiNumber1" /> <label
															for="sigleRecoveryimeiNumber1"><spring:message
																code="registration.one" /><span class="star"> *</span></label>
													</div>
													</div>
													<div id="IMEIndContact2" style="display: none">
													<div class="input-field col s12 m6">
														<input type="text" name="imeiNumberTwo"
															pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															 id="sigleRecoveryimeiNumber2"> <label
															for="sigleRecoveryimeiNumber2"><spring:message
																code="registration.two" /></label>
													</div>
													</div>
													<div id="IMEIndContact3" style="display: none">						
													<div class="input-field col s12 m6">
														<input type="text" name="imeiNumberThree"
																pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															id="sigleRecoveryimeiNumber3"> <label
															for="sigleRecoveryimeiNumber3"><spring:message
																code="registration.three" /></label>
														<p id="errorMsgOnModal" class="deviceErrorTitle"></p>
													</div>
													</div>
													<div id="IMEIndContact4" style="display: none">	
													<div class="input-field col s12 m6">
														<input type="text" name="imeiNumberFour"
																pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															 id="sigleRecoveryimeiNumber4"> <label
															for="sigleRecoveryimeiNumber4"><spring:message
																code="registration.four" /></label>
													</div></div>

													<div class="col s12 m12" style="margin-top: 30px;">
														<h5>
															<spring:message code="registration.placeofdevicerecovery" />
														</h5>
														<hr>
													</div>
													<!-- <div class="col s12 m12">
                                                                <p><b>Place Of Device Recovery</b></p>
                                                            </div> -->
													<div class="input-field col s12 m12">
														<input type="text" id="sigleRecoveryaddress"
															name="sigleRecoveryaddress"
															class="form-control boxBorder boxHeight"
																pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
															 required /> <label
															for="sigleRecoveryaddress"> <spring:message
																code="input.address" /><span class="star"> *</span></label>
													</div>
													<div class="col s12 m6 l6">
														<label><spring:message code="table.country" /> <span
															class="star">*</span></label> <select id="country1" disabled="disabled"
															class="browser-default" class="mySelect"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															required style="padding-left: 0; color: rgb(53, 52, 52);"></select>
													</div>

													<div class="col s12 m6 l6">
														<label> <spring:message code="input.province" /><span
															class="star"> *</span></label> <select id="state1" 
															class="browser-default" class="mySelect" 
															style="padding-left: 0;" onchange="getDistrict(this,'sigleRecoverydistrict','sigleRecoverycommune');"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															required></select>
													</div>
													<div class="col s12 m6 l6">
														<%-- <input type="text" name="sigleRecoverydistrict"
															id="sigleRecoverydistrict"
															pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															required /> --%>
															
															 <label for="sigleRecoverydistrict"><spring:message
																code="input.district" /> <span class="star"> *</span></label>
																
																 <select
										id="sigleRecoverydistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'sigleRecoverycommune','sigleRecoveryvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
													</div>

													<div class="col s12 m6 l6">
														<%-- <input type="text" name="sigleRecoverycommune"
															id="sigleRecoverycommune" maxlength="30"
															pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															required /> --%> <label for="sigleRecoverycommune"> <spring:message
																code="input.commune" /><span class="star"> *</span></label>
																<select
										id="sigleRecoverycommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'sigleRecoveryvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option>
										</select>
													</div>
													
													<div class=" col s12 m6 l6">
														<%-- <input type="text" name="sigleRecoveryvillage"
															id="sigleRecoveryvillage" maxlength="30"
															pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															 /> --%> 
															<label for="sigleRecoveryvillage"> <spring:message
																code="input.village" /></label> <select
										id="sigleRecoveryvillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
															 
													</div>
													
													<div class="input-field col s12 m6 l6">
														<input type="text" name="sigleRecoverystreetNumber"
															class="form-control boxBorder boxHeight"
															id="sigleRecoverystreetNumber" 
															pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
															required /> <label for="sigleRecoverystreetNumber">
															<spring:message code="input.streetNumber" /><span
															class="star"> *</span>
														</label>
													</div>

													

													<div class="input-field col s12 m12">
														<input type="text" name="sigleRecoverylocality"
															class="form-control boxBorder boxHeight"
															id="sigleRecoverylocality" 
																pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															 /> <label for="sigleRecoverylocality"><spring:message
																code="input.locality" /> </label>
													</div>

													

													<div class="input-field col s12 m6 l6">
														<input type="text" name="sigleRecoverypin"
															class="form-control boxBorder boxHeight"
															id="sigleRecoverypin" 
																pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
															  /> <label for="sigleRecoverypin"> <spring:message
																code="input.postalCode" /><span class="star"></span></label>
													</div>

													

													<%--  <div class="col s6 m6 ">
                                                                <label for="sigleRecoverydeviceStatus"><spring:message code="select.deviceStatus" /> <span class="star"> *</span></label>
                                                                <select id="sigleRecoverydeviceStatus" class="browser-default" 
                                                                oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                                oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                                               required >
                                                        	 <option value="" disabled selected><spring:message code="select.deviceStatus" /></option>
                                                                </select>
                                                              </div> --%>





													<%-- <div class="col s12 m6 blockingType">
<p style="margin-top: 3px; margin-bottom: 5px"><spring:message code="operator.blocking" /></p>
<label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio" id=""
value="Immediate"
onclick="document.getElementById('SingleRecoverycalender').style.display = 'none';"
name="singleRecoveryPeriod" checked><spring:message code="operator.immediate" />
</label> <label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio"
value="Default"
onclick="document.getElementById('SingleRecoverycalender').style.display = 'none';"
name="singleRecoveryPeriod"><spring:message code="operator.default" />
</label> <label> <input type="radio" required="required" value="tilldate" class="blocktypeRadio"
onclick="document.getElementById('SingleRecoverycalender').style.display = 'block';"
name="singleRecoveryPeriod"><spring:message code="operator.later" />
</label>
<div class="col s6 m2 responsiveDiv"
style="display: none; width: 30%; margin-right: 30%; float: right; margin-top: -15px" id="SingleRecoverycalender">
<div id="startdatepicker" class="input-group date">
<input type="text" id="singleRecoveryDatePeriod"
style="margin-top: -9px" /> <span class="input-group-addon"
style="color: #ff4081"><i class="fa fa-calendar"
aria-hidden="true" style="float: right; margin-top: -30px;"></i></span>
</div>

</div>


<div class="col s12 m2 l2" style="width: 40%; display: none; float: right; margin-right:30%;"
id="stolenDate">

<label for="TotalPrice" class="center-align"><spring:message code="operator.tilldate" /></label>
<div id="startdatepicker" class="input-group" style="margin-top: 10px;">

<input class="form-control" name="inputsaves" type="text"
id="startDateFilter" readonly /> <span class="input-group-addon"
style="color: #ff4081"><i
class="glyphicon glyphicon-calendar"
onclick="_Services._selectstartDate()"></i></span>
</div>
</div>
</div> --%>

													<div class="input-field col s12 m6">
														<input type="text" name="deviceRecoveryDevice"
															id='IndivisualRecoveryDevice'
															class='form-control datepick' autocomplete='off'
															oninput="InvalidMsg(this,'input','<spring:message code="validation.requiredMsg" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.requiredMsg" />');"
															required /> <label for="IndivisualRecoveryDevice"
															class="center-align"><spring:message
																code="operator.recoveryDate" /> <span class="star">*</span>
														</label> <span class="input-group-addon" style="color: #ff4081"><i
															class="fa fa-calendar" aria-hidden="true"></i></span>
													</div>



													<div class="input-field col s12 m12">
														<textarea id="sigleRecovery"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
															maxlength="10000" class="materialize-textarea"></textarea>
														<label for="sigleRecovery"><spring:message
																code="input.remarksLawfull" /> </label>
													</div>
												</div>
											</div>
											<p>
												<spring:message code="input.requiredfields" />
												<span class="star"> *</span>
											</p>


											<div class="input-field col s12 center">
												<button class="btn" type="submit" id="singleDeviceRecovery">
													<spring:message code="button.submit" />
												</button>
												<a href="./stolenRecovery?FeatureId=5" class="btn"
													style="margin-left: 10px;"><spring:message
														code="modal.cancel" /></a>
											</div>
										</form>
									</div>
								</div>
								<div id="bulkRecoveryDiv" class="col s12 m12"
									style="display: none">
									<form action="#" style="margin-top: 30px;"
										onsubmit="return saveCompanyRecoveryRequest()" method="POST"
										enctype="multipart/form-data" id="bulkRecoveryForm">
										<div class="input-field col s12 m6 l6"
											style="margin-top: 20px;">
											<input type="text" name="bulkRecoveryquantity"
												class="form-control boxBorder boxHeight"
												id="bulkRecoveryquantity" required
												id="deviceBulkStolenquantity" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
												required> <label for="bulkRecoveryquantity"><spring:message
													code="input.quantity" /> <span class="star"> *</span></label>
										</div>

										<div class="input-field col s12 m6 l6"
											style="margin-top: 20px;">
											<input type="text" name="recoveryDevicequantity"
												class="form-control boxBorder boxHeight"
												id="recoveryDevicequantity" 
												pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
												required> <label for="recoveryDevicequantity"><spring:message
													code="input.devicequantity" /> <span class="star">
													*</span></label>
										</div>

										<%-- <div class="input-field col s12 m6">
											<input type="text" name="devicequantity" id="recoveryDevicequantity"
												pattern="[0-9]{0,7}"
												
												maxlength="7"  oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"  required/> <label for="devicequantity"
												class="center-align"><spring:message code="input.devicequantity" /> <span class="star">*</span></label>
										</div> --%>

										<div class="file-field col s12 m6">
											<h6 style="margin: 2px;">
												<spring:message code="registration.uploadfile" />
												<span class="star"> *</span>
											</h6>
											<div class="btn">
												<span><spring:message code="input.selectfile" /></span> <input
													type="file" id="bulkRecoveryFile"
													onchange="isFileValid('bulkRecoveryFile')"
													oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
													oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
													required accept=".csv" placeholder="">
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate" type="text"
													id="bulkRecoveryFileName"
													placeholder="<spring:message code="registration.uploadfile" />"
													title="Please upload your photo">
											</div>
										</div>

										<div class="input-field col s12 m12">
											<textarea id="bulkRecoveryRemark"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
												maxlength="10000" class="materialize-textarea"
												style="height: auto; max-height: 300px;"></textarea>
											<label for="bulkRecoveryRemark"><spring:message
													code="input.remarksLawfull" /></label>
										</div>

										<%--    <div class="col s12 m6">
<p style="margin-top: 3px; margin-bottom: 5px"><spring:message code="operator.blocking" /></p>
<label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio" id=""
value="Immediate"
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod" checked><spring:message code="operator.immediate" />
</label> <label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio"
value="Default"
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod"><spring:message code="operator.default" />
</label> <label> <input type="radio" required="required" value="tilldate" class="blocktypeRadio"
onclick="document.getElementById('calender').style.display = 'block';"
name="stolenBlockPeriod"><spring:message code="operator.later" />
</label>
<div class="col s6 m2 responsiveDiv"
style="display: none; width: 30%; margin-right: 30%; float: right; margin-top: -15px" id="calender">
<div id="startdatepicker" class="input-group date">
<input type="text" id="stolenDatePeriod"
style="margin-top: -9px" /> <span class="input-group-addon"
style="color: #ff4081"><i class="fa fa-calendar"
aria-hidden="true" style="float: right; margin-top: -30px;"></i></span>
</div>

</div>


<div class="col s12 m2 l2" style="width: 40%; display: none; float: right; margin-right:30%;"
id="stolenDate">

<label for="TotalPrice" class="center-align"><spring:message code="operator.tilldate" /></label>
<div id="startdatepicker" class="input-group" style="margin-top: 10px;">

<input class="form-control" name="inputsaves" type="text"
id="startDateFilter" readonly /> <span class="input-group-addon"
style="color: #ff4081"><i
class="glyphicon glyphicon-calendar"
onclick="_Services._selectstartDate()"></i></span>
</div>
</div>
</div> --%>



										<div class="col s12 m12">
											<a href="./Consignment/sampleFileDownload/7"><spring:message
													code="input.downlaod.sample" /></a>
										</div>

										<div class="col s12 m12" style="margin-top: 30px;">
											<h5>
												<spring:message code="registration.placeofdevicerecovery" />
											</h5>
											<hr>
										</div>
										<!-- <div class="col s12 m12">
                                                        <p><b>Place Of Device Recovery</b></p>
                                                    </div> -->
										<div class="input-field col s12 m12">
											<input type="text" name="bulkRecoveryaddress"
												class="form-control boxBorder boxHeight"
												id="bulkRecoveryaddress"
													pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
												required > <label
												for="bulkRecoveryaddress"><spring:message
													code="input.address" /> <span class="star"> *</span></label>
										</div>
										
											<div class="col s12 m6 l6">
											<label> <spring:message code="table.country" /><span
												class="star"> *</span></label> <select id="bulkRecoverycountry" disabled="disabled"
												class="browser-default" class="mySelect"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												required style="padding-left: 0; color: rgb(53, 52, 52);"></select>
										</div>

										<div class="col s12 m6 l6">
											<label><spring:message code="input.province" /> <span
												class="star"> *</span></label> <select id="bulkRecoverystate" onchange="getDistrict(this,'bulkRecoverydistrict','bulkRecoverycommune');"
												class="browser-default" class="mySelect"
												style="padding-left: 0;"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												required></select>
										</div>

											<div class="col s12 m6 l6">
											<%-- <input type="text" name="bulkRecoverydistrict"
												id="bulkRecoverydistrict"
												pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												required maxlength="30"> --%> <label
												for="bulkRecoverydistrict"> <spring:message
													code="input.district" /><span class="star"> *</span></label>
													<select
										id="bulkRecoverydistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'bulkRecoverycommune','bulkRecoveryvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
										</div>

										<div class="col s12 m6 l6">
											<%-- <input type="text" name="bulkRecoverycommune"
												id="bulkRecoverycommune"
												pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												required maxlength="30"> --%> <label
												for="bulkRecoverycommune"><spring:message
													code="input.commune" /><span class="star"> *</span></label>
													<select
										id="bulkRecoverycommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'bulkRecoveryvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option>
										</select>
										</div>
										
										<div class="col s12 m6 l6">
											<%-- <input type="text" name="bulkRecoveryvillage"
												id="bulkRecoveryvillage"
												pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												 maxlength="30"> --%> <label
												for="bulkRecoveryvillage"><spring:message
													code="input.village" /></label>
													
													<select
										id=bulkRecoveryvillage class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
										</div>
															
										<div class="input-field col s12 m6 l6">
											<input type="text" name="bulkRecoverystreetNumber"
												class="form-control boxBorder boxHeight"
												id="bulkRecoverystreetNumber"
												pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
												required > <label
												for="bulkRecoverystreetNumber"><spring:message
													code="input.streetNumber" /> <span class="star"> *</span></label>
										</div>

										

										<div class="input-field col s12 m12">
											<input type="text" name="bulkRecoverylocality"
												class="form-control boxBorder boxHeight"
												id="bulkRecoverylocality"
													pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												 maxlength="30"> <label
												for="bulkRecoverylocality"><spring:message
													code="input.locality" /></label>
										</div>

										

										<div class="input-field col s12 m6 l6">
											<input type="text" name="bulkRecoverypin"
												class="form-control boxBorder boxHeight"
												id="bulkRecoverypin" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
												  maxlength="6"> <label for="bulkRecoverypin">
												<spring:message code="input.postalCode" /><span
												class="star"> </span>
											</label>
										</div>

									

										<div class="input-field col s12 m6">
											<input type="text" name="deviceRecoveryDevice"
												id='bulkRecoveryDate' class='form-control datepick'
												autocomplete='off'
												title="<spring:message code="validation.requiredMsg" />"
												required /> <label for="bulkRecoveryDate"
												class="center-align"><spring:message
													code="operator.recoveryDate" /> <span class="star">*</span>
											</label> <span class="input-group-addon" style="color: #ff4081"><i
												class="fa fa-calendar" aria-hidden="true"></i></span>
										</div>

										<div class="col s12 m12">
											<p>
												<spring:message code="input.requiredfields" />
												<span class="star"> *</span>
											</p>
										</div>

										<div class="input-field col s12 center">
											<button class="btn" type="submit" id="bulkRecoverySubmit">
												<spring:message code="button.submit" />
											</button>
											<a href="./stolenRecovery?FeatureId=5"
												class="btn" style="margin-left: 10px;"><spring:message
													code="modal.cancel" /></a>
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

		<div class="modal" id="IndivisualStolenSucessPopup">
			<h6 class="modal-header">
				<spring:message code="sidebar.Stolen/Recovery" />
			</h6>
			<div class="row" style="margin-top: 30px; padding: 0 20px;">
				<div class=" col s12 m12">
					<h6 id="sucessMessage">
						<spring:message code="input.StolenSucessMessage1" />
						<span id="IndivisualStolenTxnId"></span>
						<spring:message code="input.StolenSucessMessage2" />
					</h6>
					<div class="input-field col s12 center" style="margin: 20px 0;">
						<a href="./stolenRecovery?FeatureId=5" class="btn"
							style="margin: 20px 0;"><spring:message code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
		<!--end container-->
	</section>


	<!--materialize js-->
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

	<script type="text/javascript"
		src="${context}/resources/i18n_library/min.js"></script>

	<script type="text/javascript"
		src=""></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>



	<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/CommanLocality.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/provinceDropdown.js?version=<%= (int) (Math.random() * 10) %>" async></script> 
	<script type="text/javascript"
		src="${context}/resources/project_js/lawfulStolenRecovery.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/lawfulReportUnblock.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>"
		async></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/select2.js"></script>
	<script type="text/javascript"
		src=""
		async></script>

	<script>
		$('.datepick').datepicker({
             dateFormat: "yy-mm-dd",
             maxDate: new Date()
		});
		
    populateCountries(
        "country1"
    );
    populateStates(
        "country1",
        "state1"
    );
    
    populateCountries(
            "bulkRecoverycountry"
        );
        populateStates(
            "bulkRecoverycountry",
            "bulkRecoverystate"
        );
        
        $('#singleRecoveryDatePeriod').datepicker({
        	dateFormat: "yy-mm-dd"
        	});

        
        $('#stolenDatePeriod').datepicker({
        	dateFormat: "yy-mm-dd"
        	});


        function clearFileName() {
        	$('#bulkRecoveryFileName').val('');
        	$('#bulkRecoveryFile').val('');
        	
        	$('#fileFormateModal').closeModal();
        	
        }
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajaxSetup({
        headers:
        { 'X-CSRF-TOKEN': token }
        });
        
        $.getJSON('./getDropdownList/TOP_BRAND', function(data) {
        
        	for (i = 0; i < data.length; i++) {
        		$('<option>').val(data[i].id).text(data[i].interp)
        				.appendTo('#sigleRecoverydeviceBrandName');
        	}
        	$("#sigleRecoverydeviceBrandName").eq(0).removeAttr("tabindex");
        });
        $('select#sigleRecoverydeviceBrandName').select2();

        $('#sigleRecoverydeviceBrandName').on(
        		'change',
        		function() {
        			$("#singleRecoverymodalNumber").attr("required", false);
        			$("#modalNumerSpan").css("display", "none");
        			var brand_id = $('#sigleRecoverydeviceBrandName').val();
        			var token = $("meta[name='_csrf']").attr("content");
        			var header = $("meta[name='_csrf_header']").attr("content");
        			$.ajaxSetup({
        			headers:
        			{ 'X-CSRF-TOKEN': token }
        			});

        			$.getJSON('./productModelList?brand_id=' + brand_id,
        					function(data) {
        				$('#select2-singleRecoverymodalNumber-container').empty();		
        				$("#singleRecoverymodalNumber").empty();
        						for (i = 0; i < data.length; i++) {
        							$('<option>').val(data[i].id).text(
        									data[i].modelName).appendTo('#singleRecoverymodalNumber');
        						}
        					});
        			 $('select#singleRecoverymodalNumber').select2();
        		});

    	$("#country1").val("Cambodia").change();
		//$("#country1").attr("style", "pointer-events: none;");
		setDropdownProviance('state1');
		setDropdownProviance('bulkRecoverystate');
	
</script>


<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
<script type="text/javascript">var countHit="";  $( document ).ready(function() {   if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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