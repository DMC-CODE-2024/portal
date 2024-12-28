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
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<script type="text/javascript"
	src="${context}/resources/js/intlTelInput.js"></script>
<script type="text/javascript" src="${context}/resources/js/utils.js"></script>

<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">


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

<link rel="stylesheet"
	href="${context}/resources/project_css/stolenRecovery.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
<link rel="stylesheet"
	href="${context}/resources/project_css/intlTelInput.css">

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

select {
	margin-bottom: 5px;
	height: 2.2rem;
}

.iti--allow-dropdown input, .iti--allow-dropdown input[type=text] {
	margin-bottom: 5px !important;
}
.starAddress{
		margin-top: -19px;
    margin-left:62px;
    color: red;
		}
		.starAddressDistrict{
		margin-top: -19px;
    margin-left:43px;
    color: red;
		}
</style>


</head>

<body data-id="5" data-roleType="${usertype}"
	data-userTypeID="${usertypeId}" data-userID="${userid}"
	data-operatorTypeId="${operatorTypeId}"
	data-selected-roleType="${stolenselectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-txnID="${not empty param.txnId ? param.txnId : 'null'}"
	data-source="${not empty param.reqSource ? param.reqSource : 'null'}">





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
									<p id="headingType" class="PageHeading">
										<spring:message code="registration.updatereportstolen" />
									</p>
								</div>

								<div class="row">
									<!-- 	<div class="col s12">
										<ul class="tabs">
											<li class="tab col s3"><a class="active"
												onclick="showSingleFormDiv()">Individual</a></li>
											<li class="tab col s3"><a onclick="showBulkFormDiv()">Company/Organisation/Government</a></li>
										</ul>
									</div> -->
									<div id="SingleForm" class="col s12"
										style="margin-top: 30px; display: block">
										<form action="" id="SingleImeiBlockform"
											onsubmit="return updateIndivisualStolen()" method="POST"
											enctype="multipart/form-data">
											<div class="row">

												<div class="col s12 m12">
													<h5>
														<spring:message code="input.personalInformation" />
													</h5>
													<input type="text" id="existingStolenTxnId"
														style="display: none" value="${stolenTxnId}">
													<hr>
												</div>

												<div class="col-s12 m12">
													<div class="input-field col s12 m4">
														<input type="text" name="singleStolenfirstName"
															placeholder="" required="required"
															pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															title="" id="singleStolenfirstName">
														<label for="singleStolenfirstName"><spring:message
																code="input.firstName" /> <span class="star">*</span></label>

													</div>
													<input type="text" id="pageViewType" value="${viewType}"
														style="display: none;"> <input type="text"
														id="pageName" value="${pageName}" style="display: none;">
													<div class="input-field col s12 m4">
														<input type="text" name="middleName" placeholder=""
															pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" title=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															 id="singleStolenmiddleName"> <label
															for="middleName"><spring:message
																code="input.middleName" /></label>
													</div>

													<div class="input-field col s12 m4">
														<input type="text" name="lastName" placeholder=""
															pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" title=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															 id="singleStolenlastName"> <label
															for="lastName"> <spring:message
																code="input.lastName" /> <span class="star"></span>
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
															<spring:message
																code="registration.uploadnid/passportimage" />
															<span class="star"></span>
														</h6>
														<div class="btn" id="passportImageDiv">
															<span id="passportImageText"><spring:message
																	code="input.selectfile" /></span> <input type="file"
																accept="*image"
																oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
																oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
																onchange="isImageValid('singleStolenFile')"
																id="singleStolenFile">
														</div>
														<div class="file-path-wrapper">
															<input class="file-path validate" type="text"
																placeholder="<spring:message code="registration.uploadnid/passportimage" />"
																id="singleStolenFileName" title=""> <a href="#"
																id="PassportNidLink" class="imgPreviewLink"
																style="display: none;"><spring:message code="input.preView" /></a>
														</div>
													</div>

													<div class="input-field col s12 m6"
														style="margin-top: 22px;">
														<input type="text" name="nIDPassportNumber" placeholder=""
															required="required"  title=""
															pattern="<spring:eval expression="@environment.getProperty('pattern.importerNid')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.12Character" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.12Character" />');"
															maxlength="15" id="singleStolennIDPassportNumber">
														<label for="nIDPassportNumber"> <spring:message
																code="registration.nid/passportnumber" /> <span
															class="star">*</span></label>
													</div>
													
													
													<div class="input-field col s12 m4 l6" id="nationalityDiv" style="margin-top: 29px;">
											
												<p
														style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
													<spring:message code="input.Nationality" /><span class="star">*</span>
													</p>
												<select id="nationality" class="browser-default"
														class="mySelect"
														oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											            oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
														title= "<spring:message code="validation.selectFieldMsg" />"
														 style="padding-left: 0;"></select>
												 <%-- <label for="nationality" class=""><spring:message
													code="input.Nationality" /> <span class="star">*</span></label> --%>
										</div> 
										
										<div class="input-field col s12 m4 l6"  style="margin-top: 29px;">
											
												<p
														style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
													<spring:message code="input.addressType" /><span class="star">*</span>
													</p>
												<select id="addressType" class="browser-default" 
														class="mySelect" onchange="setMandatoryandOptionalEdit('singleStolenvillage','singleStolenlocality','singleStolendistrict','singleStolencommune','state')"
														oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											            oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
														title= "<spring:message code="validation.selectFieldMsg" />"
														 style="padding-left: 0;">
														 
														 </select>
												 <%-- <label for="nationality" class=""><spring:message
													code="input.Nationality" /> <span class="star">*</span></label> --%>
										</div>

													<div class="input-field col s12 m4">
														<input type="email" name="email" id="singleStolenemail"
															placeholder=""
															pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"title=""
															oninput="InvalidMsg(this,'email','<spring:message code="validation.emial" />');"
															oninvalid="InvalidMsg(this,'email','<spring:message code="validation.emial" />');"
															> <label for="email"><spring:message
																code="input.email" /> </label>
													</div>

													<div class="input-field col s12 m4" style="margin-top:0px;">
														<p class="contact-label">
															<spring:message code="registration.altcontactnumber" />
															<span class="star">*</span>
														</p>
														<input type="text" name="phone" id="singleStolenphone1"
															required="required"  pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
															placeholder=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');"
															>
														<!-- <label for="phone">Alternate Contact Number <span class="star">*</span></label> -->
													</div>
													<div class="col s12 m4">
															<label><spring:message
																	code="registration.complainttype" /> <span
																class="star">*</span></label> <select class="browser-default"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																required="required" id="singleStolenComplaintType">
																<option value=""  selected>
																	<spring:message code="registration.selectcomplainttype" /></option>

															</select>
														</div>
													<!-- </div>

                                                        <div class="col s12 m12"> -->
													<div class="input-field col s12 m12">
														<input type="text" name="address" placeholder=""
															class="form-control boxBorder boxHeight"
															id="singleStolenaddress"
															pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />" title=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
															 required="required" > <label
															for="address"><spring:message
																code="input.addressLawfull" /> <span class="star">*</span></label>
													</div>
													
													<div class="col s12 m6 l6">
														<label> <spring:message code="table.country" /><span
															class="star">*</span></label> <select id="country" 
															class="browser-default" class="mySelect"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															style="padding-left: 0;" required></select>
													</div>

													<div class="col s12 m6 l6">
														<label id="provianceLabel" ><spring:message code="input.province" /> <span
															class="star"></span></label> <select id="state"
															onchange="getDistrict(this,'singleStolendistrict','singleStolencommune');"
															class="browser-default" class="mySelect"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															style="padding-left: 0;" required></select>
													</div>
													
													<div class="col s12 m6 l6">
														<%-- <input type="text" name="district" placeholder=""
															id="singleStolendistrict"
															pattern="[a-zA-Z0-9\s,'*$-]{0,30}" required="required"
															title=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															maxlength="30"> --%>
															 <label for="district" id="singleStolenDistrictLabelID"> <spring:message
																code="input.district" /><span id="singleStolendistrictLabel"
															class="star">  </span></label>
															
															<select
										id="singleStolendistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'singleStolencommune','singleStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
													</div>

													<div class=" col s12 m6 l6">
														<%-- <input type="text" name="commune" id="singleStolencommune"
															placeholder="" pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
															required="required" title=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															maxlength="30"> --%>
															<label for="commune" id="singleStolenCommuneLabelID"><spring:message
																code="input.commune" /> <span class=" star" id="singleStolenCommune">  </span> </label>
															<select
										id="singleStolencommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'singleStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option>
										</select>
															 
													</div>
													
													<div class="col s12 m6 l6">
														<%-- <input type="text" name="village" id="singleStolenvillage"
															placeholder="" pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
															 title=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															maxlength="30"> --%>
															
															 <label for="village"><spring:message
																code="input.village" /> <span class="star"></span> </label>
																<select
										id="singleStolenvillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
													</div>
																
													<div class="input-field col s12 m6 l6">
														<input type="text" name="streetNumber" placeholder=""
															class="form-control boxBorder boxHeight"
															id="singleStolenstreetNumber"
															pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />" required="required"
															title=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
															> <label for="streetNumber"><spring:message
																code="input.streetNumber" /> <span class="star">*</span></label>
													</div>

													

													<div class="input-field col s12 m6 l6" style="margin-left:1px;">
														<input type="text" name="locality" placeholder=""
															class="form-control boxBorder boxHeight"
															id="singleStolenlocality"
															pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
															title=""
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															> <label for="locality"> <spring:message
																code="input.locality" /><span class="star"></span></label>
													</div>

													

													<div class="input-field col s12 m6 l6" style="margin-right: -1px;">
														<input type="text" name="pin" placeholder=""
															class="form-control boxBorder boxHeight"
															id="singleStolenpin"
															pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
															title="" maxlength="6"  > <label
															for="pin"><spring:message
																code="registration.postalcode" /> <span class="star"></span></label>
													</div>

													

													<div class="col s12 m12" style="margin-top: 30px;">
														<h5>
															<spring:message code="modal.deviceInfo" />
														</h5>
														<hr>
													</div>

													<div>
													<div class="row">
														<div class="col s12 m6">
															<%-- <input type="text" name="deviceBrandName" placeholder=""
																id="singleStolendeviceBrandName"
																pattern="[a-zA-Z]{0,20}" title=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
																maxlength="20"> <label for="deviceBrandName"><spring:message
																	code="registration.devicebrandname" /></label> --%>
																	
															<label for="editsingleStolendeviceBrandName"><spring:message
													code="registration.devicebrandname" /> <span class="star">*</span></label>
											<select id="editsingleStolendeviceBrandName" class="browser-default" 
												
												onchange="changeSelectDropDownToText('editsingleStolendeviceBrandName')"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												required>
												<option value=""  selected><spring:message
														code="registration.selectproduct" />
												</option>
												</select>		
														</div>

														<%-- <div class="input-field col s12 m6"
															style="margin-top: 22px;">
															<input type="text" name="imeiNumber" placeholder=""
																id="singleStolenimeiNumber" pattern="[0-9]{15,16}" title="Please enter minimum 15 and maximum 16 digit only" 
															maxlength="16"> <label
																for="imeiNumber"><spring:message code="registration.imei/meid/esnnumber" /></label>
														</div> --%>

														<div class="col s6 m6 ">
															<label for="deviceIDType"><spring:message
																	code="select.deviceIDType" /><span class="star" id="deviceIdTypeSpan" style="display: none ; margin-top: -18px;margin-left: 82px;"> *</span></label> <select
																
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																id="singleStolendeviceIDType" class="browser-default">
																<option value=""  selected>
																	<spring:message code="select.deviceIDType" /></option>
															</select>
														</div>

														
													<div class="input-field col s12 m12" id="OtherBrandNameDiv" style="display: none">
														<input type="text" name="brandName" id="OtherBrandName"
															
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															required maxlength="50"> <label
															for="OtherBrandNameLabel"> <spring:message
																code="registration.devicebrandname" /> <span class=" star"> *</span>
														</label>
													</div>
													</div>
													<div class="row">
														<div class="col s12 m6 ">
															<label for="deviceType"><spring:message
																	code="select.deviceType" /></label> <select
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																class="browser-default" id="singleStolendeviceType">
																<option value=""  selected><spring:message
																		code="select.deviceType" /></option>
															</select>
														</div>
														<div class="col s12 m6 l6">
															<label> <spring:message
																	code="select.multiSimStatus" /> <span class="star">*
																	</span></label> <select class="browser-default" required="required" 
																onchange="setContactIMEINumber('singleStolenSimStatus','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																id="singleStolenSimStatus">
																<option value=""  selected>
																	<spring:message code="registration.selectMultiplestLawfull" />
																</option>

															</select>
														</div>
														
														<div class="input-field col s12 m6"
														style="margin-top: 22px;">
														<input type="text" name="sigleStolenserialNumber"
															id="sigleStolenserialNumber"
															pattern="<spring:eval expression="@environment.getProperty('pattern.serialNumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															> <label
															for="sigleStolenserialNumber"><spring:message
																code="input.deviceSerialNumber" /></label>
													</div>
														
														</div>
														
														
												<div id="IMEIndContact1" style="display: none">	
														<div class="col s12 m6">
															<p class="contact-label">
																<spring:message code="input.contactNum" />
																<span class="star">*</span>
															</p>
															<input type="text" name="phone" id="singleStolenphone2"
																placeholder="" required 
																pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');"
																title="">
															<!--  <label for="phone2">Contact Number <span class="star">*</span></label> -->
														</div>

														<!-- <div class="input-field col s12 m6">
                                                                <input type="text" name="operator" id="operator" maxlength="10">
                                                                <label for="operator">Operator <span class="star">*</span></label>
                                                            </div> -->
														
														<div class="input-field col s12 m6">
															<input type="text" name="imeiNumber"
																pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																
																title="<spring:message code=" validation.1516digit" />"
																 id="updatesingleStolenimei1"> <label
																for="updatesingleStolenimei1"> <spring:message
																	code="registration.one.IMEI" /> <span class="star">
																	</span></label><p id="errorMsgOnModal" class="deviceErrorTitle" style="margin-top: -56px;margin-left: 173px;"></p>
														</div>
														</div>
														<div id="IMEIndContact2" style="display: none"">
														<div class="col s12 m6" style="margin-right: 0px;">
															<p class="contact-label">
																<spring:message code="input.contactNum2" />
																<span class="star"></span>
															</p>
															<input type="text" name="phone2" id="singleStolenphone3"
																pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
																 oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" >
														</div>
													 
														

														<div class="input-field col s12 m6">
															<input type="text" name="imeiNumberTwo"
																pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																title="<spring:message code=" validation.1516digit" />"
																 id="updatesingleStolenimei2"> <label
																for="updatesingleStolenimei2"> <spring:message
																	code="registration.two.IMEI" /></label>
														</div>
														</div>
														<div id="IMEIndContact3" style="display: none"">
														<div class="col s12 m6">
															<p class="contact-label">
																<spring:message code="input.contactNum3" />
																<span class="star"></span>
															</p>
															<input type="text" name="phone2" id="singleStolenphone4"
																pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
																 oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" >
														</div>

														

														<div class="input-field col s12 m6">
															<input type="text" name="imeiNumberThree"
																pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																title="<spring:message code=" validation.1516digit" />"
																maxlength="16" id="updatesingleStolenimei3"> <label
																for="updatesingleStolenimei3"> <spring:message
																	code="registration.three.IMEI" /></label>
																	
														</div>
														</div>
														<div id="IMEIndContact4" style="display: none"">
														<div class="col s12 m6" style="margin-right: 0px;">
															<p class="contact-label">
																<spring:message code="input.contactNum4" />
																<span class="star"></span>
															</p>
															<input type="text" name="phone2" id="singleStolenphone5"
																pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
																 oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" >
														</div>

														
	<div class="input-field col s12 m6">
															<input type="text" name="imeiNumberFour"
																pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																title="<spring:message code=" validation.1516digit" />"
															    id="updatesingleStolenimei4"> <label
																for="updatesingleStolenimei4"> <spring:message
																	code="registration.four.IMEI" /></label>
														</div>
														</div>
 

													
														
														<div class="row" id="editBlockTimePeriod">
<div class="col s12 m6">
<spring:message code="operator.blocking" /> <label style="margin-right: 2%;"> <input
type="radio" name="editbulkBlockdeviceradio" class="blocktypeRadio" 
value="Immediate"  onchange="setDateMandatoryOrOptional('Immediate','stolenDatePeriodedit')"
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod">
<spring:message code="operator.immediate" />
</label> <label style="margin-right: 2%;"> <input type="radio" onchange="setDateMandatoryOrOptional('Default','stolenDatePeriodedit')"
name="editbulkBlockdeviceradio" class="blocktypeRadio" value="Default" id="editIndivisualDefaultPeriod" title=""
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod">
<spring:message code="operator.default" />
</label> <label> <input type="radio" name="editbulkBlockdeviceradio" 
value="tilldate" class="blocktypeRadio" onchange="setDateMandatoryOrOptional('tilldate','stolenDatePeriodedit')"
onclick="document.getElementById('calender').style.display = 'block';"
name="stolenBlockPeriod">
<spring:message code="operator.later" /></label>

</div>
<div class="input-field col s6 m6 responsiveDiv" style="display: none;" id="calender">
<div id="startdatepicker" class="input-group date">
<label for="stolenDatePeriodedit"><spring:message code="operator.blockingTypePeriod" /> <span class="star"> </span> 
																</label>
<input type="text" id="stolenDatePeriodedit" style="margin-top: -9px" /> <span
class="input-group-addon" style="color: #ff4081"><i class="fa fa-calendar"
aria-hidden="true" style="float: right; margin-top: -30px;"></i></span>
</div>
</div>

<!-- 
<div class="input-field col s6 m6 responsiveDiv" style="display: block;" id="calender">
<div id="startdatepicker" class="input-group date">
<input type="text" id="stolenDatePeriodedit" placeholder="" style="margin-top: -9px" class="hasDatepicker">
<label for="" class="active">Blocking Time Period</label>
<p> Blocking Time Period </p>
 <span class="input-group-addon" style="color: #ff4081">
    
    <i class="fa fa-calendar" aria-hidden="true" style="float: right; margin-top: -30px;"></i></span>
</div>
</div> -->

<div class="col s12 m6 l6" style="display: none" id="stolenDate">

<label for="TotalPrice" class="center-align">
<spring:message code="operator.tilldate" /></label>
<div id="startdatepicker" class="input-group" style="margin-top: 10px;">

<input class="form-control" placeholder="" name="inputsaves" type="text" id="startDateFilter"
readonly /> <span class="input-group-addon" style="color: #ff4081"><i
class="glyphicon glyphicon-calendar"
onclick="_Services._selectstartDate()"></i></span>
</div>
</div>
</div>

														<div class="col s12 m12" style="margin-top: 30px;">
															<h5>
																<spring:message code="registration.plstolen" />
															</h5>
															<hr>
														</div>
														<!-- <div class="col s12 m12">
                                                                <p><b>Place Of Device Stolen</b></p>
                                                            </div> -->
														<div class="input-field col s12 m12">
															<input type="text" name="address" placeholder=""
																class="form-control boxBorder boxHeight"
																id="singleDeviceAddress"
																pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"title=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
																 required="required"> <label
																for="address"><spring:message
																	code="input.address" /> <span class="star">*</span></label>
														</div>
														
															<div class="col s12 m6">
															<label><spring:message code="table.country" /> <span
																class="star">*</span></label> <select id="singleDevicecountry"
																class="browser-default"
																onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																class="mySelect" style="padding-left: 0;" required></select>
														</div>

														<div class="col s12 m6">
															<label><spring:message code="input.province" />
																<span class="star">*</span></label> <select
																id="singleDevicestate" class="browser-default" onchange="getDistrict(this,'singleDevicedistrict','singleDevicecommune');"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																class="mySelect" style="padding-left: 0;" required></select>
														</div>
														
														<div class=" col s12 m6 l6">
															<%-- <input type="text" name="district" placeholder=""
																id="singleDevicedistrict"
																pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
																required="required" title="" 
																oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
																maxlength="30"> --%> <label for="district"><spring:message
																	code="input.district" /> <span class="star">*</span></label>
																	<select
										id="singleDevicedistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'singleDevicecommune','singleDevicevillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option></select>
														</div>

														<div class=" col s12 m6 l6">
															<%-- <input type="text" name="commune" placeholder=""
																id="singleDevicecommune" pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
																required="required" title=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
																maxlength="30"> --%> <label for="commune"><spring:message
																	code="input.commune" /> <span class="star">*</span></label>
																	<select
										id="singleDevicecommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'singleDevicevillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option></select>
														</div>
														
														<div class="col s12 m4">
															<%-- <input type="text" name="village" placeholder=""
																id="singleDevicevillage"
																pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
																 title=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
																maxlength="30"> --%> <label for="village"><spring:message
																	code="input.village" /> <span class="star"></span></label>
																	<select
										id="singleDevicevillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option></select>
														</div>
														
														<div class="input-field col s12 m4">
															<input type="text" name="streetNumber" placeholder=""
																class="form-control boxBorder boxHeight"
																id="singleDevicestreetNumber"
																pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
																required="required" title=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
																> <label for="streetNumber"><spring:message
																	code="input.streetNumber" /> <span class="star">*</span></label>
														</div>

														

														<div class="input-field col s12 m4">
															<input type="text" name="locality" placeholder=""
																class="form-control boxBorder boxHeight"
																id="singleDevicelocality"
															pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
																 title=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																> <label for="locality"><spring:message
																	code="input.locality" /> <span class="star"></span></label>
														</div>


														<div class="input-field col s12 m6 l6" style="margin-left: -34%;">
															<input type="text" name="pin" placeholder=""
																class="form-control boxBorder boxHeight"
																id="singleDevicepin" 
																pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
																
																oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
																title="" maxlength="6"> <label for="pin"><spring:message
																	code="registration.postalcode" /> <span class="star"></span></label>
														</div>

													
														<div class="input-field col s12 m6" data-original-title=""
															title="">
															<input type="text" name="IndivisualStolenDate"
																id="IndivisualStolenDate"
																onchange="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');"
																oninvalid="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');"
																class="form-control datepick" autocomplete="off"
																title="" required=""
																data-original-title="
																validation.requiredMsg">
															<label for="IndivisualStolenDate" class="center-align"
																data-original-title="" title=""> <spring:message
																	code="operator.stolenDate" /> <span class="star"
																data-original-title="" title="">*</span>
															</label> <span class="input-group-addon" style="color: #ff4081"
																data-original-title="" title=""><i
																class="fa fa-calendar" aria-hidden="true"
																data-original-title="" title=""></i></span>
														</div>

														<%-- <div class="file-field col s12 m6" data-original-title=""
															title="">
															<h6 class="form-label"
																style="margin: 0; font-size: 0.9rem;"
																data-original-title="" title="">
																<spring:message code="input.UploadFIR" />
															</h6>
															<div class="btn" id="firImageDiv" data-original-title=""
																title="">
																<span id="firDivText" data-original-title="" title="">
																	<spring:message code="input.selectfile" />
																</span> <input type="file"
																	oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
																	oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
																	onchange="isImageValid('uploadFirSingle')"
																	accept="*Image" placeholder="Upload FIR"
																	id="uploadFirSingle" data-original-title="" title="">
															</div>
															<div class="file-path-wrapper" data-original-title=""
																title="">
																<input class="file-path validate" type="text"
																	placeholder=""
																	id="uploadFirSingleName" title=""
																	data-original-title=""> <a id="firImageLink"
																	class="imgPreviewLink" style="display: none;"><spring:message code="input.preView" /></a>
															</div>
														</div> --%>
														
														<div id="mainDiv" class="mainDiv">
<div id="filediv" class="fileDiv">
<div class="row">

<div class="col s12 m6 l6" style="margin-top: 8px;">
<label for="Category"><spring:message code="input.documenttype" /></label>
<select class="browser-default" id="docTypetag1" onchange="enableSelectFile()" >
<option value="" selected><spring:message code="select.documenttype" /> </option>

</select>
<select class="browser-default" id="docTypetagValue1" 
oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
style="display: none;">
<option value="" disabled selected><spring:message code="select.documenttype" /></option>

</select>
</div>
<div class="file-field col s12 m6" id="removestar">
<h6 id="supportingdocumentFile" style="color: #000;"> <spring:message code="input.supportingdocument" /></h6>
<div class="btn">
<span><spring:message code="input.selectfile" /></span>
<input type="file" name="files[]" id="docTypeFile1"  disabled="disabled" onchange="enableAddMore('docTypeFile1','filediv')"
oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');" 
oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');" >
</div>
<div class="file-path-wrapper">
<input class="file-path validate" type="text"  id="filetextField"
placeholder="<spring:message code="grievanceFileMessage" />">
<div>
<p id="myFiles"></p>
</div>
</div>
</div>
</div>


</div>

</div>
<div class="col s12 m6 right">
<button class="btn right add_field_button_edit" type="button" disabled="disabled"><span
style="font-size: 20px;">+</span><spring:message code="input.addmorefile" /></button>
</div>
														
														<div class="input-field col s12 m12">
															<textarea id="singleDeviceRemark" maxlength="10000"
																placeholder=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																class="materialize-textarea"></textarea>
															<label for="textarea1"><spring:message
																	code="input.remarksLawfull" /> </label>
														</div>
														
															<div class="input-field col s12 m12" style="display: none;" id="singleDeviceRejectRemarkDiv">
															<textarea id="singleDeviceRejectRemark" maxlength="10000"
																placeholder=""
																oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																class="materialize-textarea"></textarea>
															<label for="textarea1"><spring:message
																	code="input.remarksRejected" /> </label>
														</div>
														<div class="chat-message clearfix" id="chatMsg"></div>
													</div>
												</div>
											</div>
											<span> <spring:message code="input.requiredfields" />
												<span class="star">*</span></span>


											<div class="input-field col s12 center">
												<button class="btn" id="IndivisualUpdateStolen"
													type="submit">
													<spring:message code="button.submit" />
												</button>
												<%-- <a href="./stolenRecovery?FeatureId=5"
													class="btn modal-trigger" style="margin-left: 10px;"><spring:message
														code="button.cancel" /></a> --%>
												<a class="btn modal-close" onclick="closeViewPage()">
												<spring:message code="modal.close" /></a>		
											</div>

										</form>
									</div>


									<!-- ____________________________________________________Bulk stolen form________________________________________________________________________ -->


									<div id="Bulkform" class="col s12" style="display: none">
										<form action="#" style="margin-top: 30px;" id="bulkFormSubmit">
											<div class="input-field col s12 m6">
												<input type="text" name="companyName"
													id="bulkStolencompanyName"> <label
													for="companyName"><spring:message
														code="registration.companyName" /> <span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6">
												<input type="text" name="address"
													class="form-control boxBorder boxHeight"
													id="bulkStolenaddress" pattern=[A-Za-z]
													title="Please enter your address"> <label
													for="address"><spring:message code="input.address" />
													<span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="streetNumber"
													class="form-control boxBorder boxHeight"
													id="bulkStolenstreetNumber" maxlength="30"
													pattern=[A-Za-z0-9] title="Please enter street number">
												<label for="streetNumber"><spring:message
														code="input.streetNumber" /> <span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="village" id="bulkStolenvillage"
													maxlength="20"> <label for="village"><spring:message
														code="input.village" /> <span class="star"></span> </label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="locality"
													class="form-control boxBorder boxHeight"
													id="bulkStolenlocality" maxlength="20" pattern=[A-Za-z0-9]
													title="Please enter your locality"> <label
													for="locality"><spring:message
														code="input.locality" /> <span class="star"></span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="district" id="bulkStolendistrict"
													maxlength="20"> <label for="district"><spring:message
														code="input.district" /> <span class="star">*</span> </label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="commune" id="bulkStolencommune"
													maxlength="20"> <label for="commune"><spring:message
														code="input.commune" /> <span class="star">*</span> </label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="pin"
													class="form-control boxBorder boxHeight" id="bulkStolenpin"
													maxlength="6"> <label for="pin"><spring:message
														code="registration.postalcode" /> <span class="star">*</span>
												</label>
											</div>

											<div class="col s12 m6 l6">
												<label><spring:message code="table.country" /> <span
													class="star">*</span></label> <select id="country2"
													class="browser-default" class="mySelect"
													style="padding-left: 0;" required></select>
											</div>

											<div class="col s12 m6 l6">
												<label><spring:message code="input.province" /> <span
													class="star">*</span></label> <select id="state2"
													class="browser-default" class="mySelect"
													style="padding-left: 0;" required></select>
											</div>

											<div class="col s12 m12" style="margin-top: 30px;">
												<h5>
													<spring:message code="registration.authorizedpersonnel" />
												</h5>
												<hr>
											</div>
											<!-- <div class="col s12 m12">
                                                        <p><b>Authorized personnel</b> </p>
                                                    </div> -->

											<div class="input-field col s12 m4">
												<input type="text" name="bulkStolenfirstName" id="firstName">
												<label for="firstName"><spring:message
														code="input.firstName" /> <span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m4">
												<input type="text" name="middleName"
													id="bulkStolenmiddleName"> <label for="middleName">
													<spring:message code="input.middleName" />
												</label>
											</div>

											<div class="input-field col s12 m4">
												<input type="text" name="lastName" id="bulkStolenlastName">
												<label for="lastName"><spring:message
														code="input.lastName" /> <span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6">
												<input type="text" name="officeEmail"
													id="bulkStolenofficeEmail"> <label
													for="officeEmail"><spring:message
														code="registration.officialemailid" /></label>
											</div>

											<div class="input-field col s12 m6">
												<!-- <p class="contact-label">Alternate Contact Number <span class="star">*</span></p> -->
												<input type="text" name="phone" id="bulkStolenContact"
													maxlength="15"> <label for="phone2"> <spring:message
														code="input.contactNum" /></label>
											</div>

											<!-- <div class="input-field col s12 m6">
                                                        <input type="text" name="totalQuantity" id="totalQuantity">
                                                        <label for="totalQuantity">Total Device Quantity </label>
                                                    </div> -->

											<div class="col s12 m12" style="margin-top: 30px;">
												<h5>
													<spring:message code="registration.plstolen" />
												</h5>
												<hr>
											</div>
											<!-- <div class="col s12 m12">
                                                        <p><b>Place Of Device Stolen</b></p>
                                                    </div> -->
											<div class="input-field col s12 m12">
												<input type="text" name="address"
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenaddress" pattern=[A-Za-z]
													title="Please enter your address"> <label
													for="address"><spring:message code="input.address" />
													<span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="streetNumber"
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenstreetNumber" maxlength="30"
													pattern=[A-Za-z0-9] title="Please enter street number">
												<label for="streetNumber"><spring:message
														code="input.streetNumber" /> <span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="village"
													id="deviceBulkStolenvillage" maxlength="20"> <label
													for="village"><spring:message code="input.village" />
													<span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="locality"
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenlocality" maxlength="20"
													pattern=[A-Za-z0-9] title="Please enter your locality">
												<label for="locality"> <spring:message
														code="input.locality" /><span class="star"></span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="district"
													id="deviceBulkStolendistrict" maxlength="20"> <label
													for="district"><spring:message
														code="input.district" /> <span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="commune"
													id="deviceBulkStolencommune" maxlength="20"> <label
													for="commune"><spring:message code="input.commune" />
													<span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6 l6">
												<input type="text" name="pin"
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenpin" maxlength="6"> <label
													for="pin"> <spring:message
														code="registration.postalcode" /><span class="star">*</span></label>
											</div>

											<div class="col s12 m6 l6">
												<label><spring:message code="table.country" /> <span
													class="star">*</span></label> <select id="country3"
													class="browser-default" class="mySelect"
													style="padding-left: 0;" required></select>
											</div>

											<div class="col s12 m6 l6">
												<label><spring:message code="input.province" /> <span
													class="star">*</span></label> <select id="state3"
													class="browser-default" class="mySelect"
													style="padding-left: 0;" required></select>
											</div>

											<div class="col s12 m6 l6">
												<label><spring:message
														code="registration.complainttype" /> <span class="star">*</span></label>
												<select class="browser-default"
													id="deviceBulkStolenComplaint">
													<option value="" disabled selected>
														<spring:message code="registration.selectcomplainttype" /></option>

												</select>
											</div>

											<div class="input-field col s12 m6 l6"
												style="margin-top: 22px;">
												<input type="text" name="quantity"
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenquantity" maxlength="10" pattern=[0-9]
													title="Please enter your locality"> <label
													for="quantity"> <spring:message
														code="input.quantity" /><span class="star">*</span></label>
											</div>

											<div class="file-field col s12 m6">
												<h6 class="file-label">
													<spring:message code="registration.uploaddevicelist" />
													<span class="star">*</span>
												</h6>
												<div class="btn">
													<span><spring:message code="input.selectfile" /></span> <input
														type="file" id="deviceBulkStolenFile"
														placeholder="Upload Photo">
												</div>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text"
														placeholder="Upload Device List"
														title="Please upload your photo">
												</div>
											</div>

											<div class="input-field col s12 m6" style="margin-top: 22px;">
												<textarea id="deviceBulkStolenRemark"
													class="materialize-textarea"></textarea>
												<label for="textarea1"><spring:message code="input.remarks" /></label>
											</div>

											<div class="col s12 m12">
												<a href="./stolenRecovery?FeatureId=5" id="sampleFileLink"><spring:message code="input.downlaod.sample" /></a>
											</div>

											<div class="input-field col s12 center">
												<button class="btn modal-trigger" data-target="submitStolen">
													<spring:message code="button.submit" />
												</button>
												<a href="./stolenRecovery?FeatureId=5"
													class="btn" style="margin-left: 10px;"><spring:message
														code="button.cancel" /></a>
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
		<h6 class="modal-header">
			<spring:message code="registration.updatereportstolen" />
		</h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="dynamicMessage">
					<spring:message code="input.Theupdated" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="./stolenRecovery?FeatureId=5" class=" btn"><spring:message
								code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="fileFormateModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="fileValidationModalHeader" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="fileErrormessage">
					<spring:message code="fileValidationName" />
					<br> <br>
					<spring:message code="fileValidationFormate" />
					<br>
					<br>
					<spring:message code="fileValidationSize" />
				</h6>
				
				<input type="text" id='removeFileId' style="display: none;">
				<input type="text" id="FilefieldId" style="display: none;">
				<input type="text" id="existingFileName" style="display: none;">
					<input type="text" id='removeFileInput' style="display: none">
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close  btn" onclick="clearFileName()"
							style="margin-left: 10px;">
							<spring:message code="modal.ok" />
						</button>
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

	
	
	<script type="text/javascript"
		src=""></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

	
	
	<!--scrollbar-->
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

	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js"></script>	

	
		<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js"></script>

	<script type="text/javascript"
		src="" async></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/provinceDropdown.js?version=<%= (int) (Math.random() * 10) %>" async></script>  
		<script type="text/javascript" src="${context}/resources/js/intlTelInput.js"></script>
		<script type="text/javascript" src="${context}/resources/js/utils.js"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/select2.js"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/CommanLocality.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/nationality.js?version=<%= (int) (Math.random() * 10) %>"></script>
<script type="text/javascript"
		src="${context}/resources/project_js/lawfulStolenRecovery.js?version=<%= (int) (Math.random() * 10) %>"></script>
<script type="text/javascript"
		src="${context}/resources/project_js/editLawfulStolen.js?version=<%= (int) (Math.random() * 10) %>"></script>


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
} else {

%>
<script language="JavaScript">
sessionStorage.setItem("loginMsg",
"*Session has been expired");
window.top.location.href = "./login";
</script>
<%
}
%>