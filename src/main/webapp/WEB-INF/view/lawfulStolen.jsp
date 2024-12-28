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
<!--<title>Indivisual Recovery</title>-->

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
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="${context}/resources/project_css/intlTelInput.css">
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
    margin-left:70px;
    color: red;
		}
		.starAddressDistrict{
		margin-top: -19px;
    margin-left:50px;
    color: red;
		}
		selectlawfull:disabled {
    
    border-bottom: 1px dotted rgba(0, 0, 0, 0.26);
    padding-left: 5px;
}
    </style>



</head>
<body  data-id="5" data-roleType="${usertype}"
	data-lang-param="${language}"
	data-userTypeID="${usertypeId}" data-userID="${userid}"
	data-operatorTypeId="${operatorTypeId}"
	data-selected-roleType="${stolenselectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}">



		<div id="initialloader"></div>

	<section id="content">
		<!--start container-->

		<div class="container">
		 
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div id="reportBlockUnblock">
								<div class="container-fluid pageHeader">
									<p class="PageHeading">
										<spring:message code="input.ReportStolen" />
									</p>
								</div>

								<div class="row">
									<div class="col s12">
										<ul class="tabs">
											<li class="tab col s3"><a class="active"
												onclick="showSingleFormDiv()"> <spring:message
														code="input.Individual" /></a></li>
											<li class="tab col s3"><a onclick="showBulkFormDiv()">
													<spring:message
														code="registration.company/organisation/government" />
											</a></li>
										</ul>
									</div>
									<div id="SingleForm" class="col s12"
										style="margin-top: 30px; display: block">
										<form action="" id="SingleImeiBlockform"  style="position: relative;"
											onsubmit="return saveIndivisualStolenRequest()" method="POST"
											enctype="multipart/form-data">
											<div class="row">

												<div class="col s12 m12">
													<h5><spring:message code="input.personalInformation" /></h5>
												</div>

											<div class="col-s12 m12">
													<div class="input-field col s12 m4">
														<input type="text" name="singleStolenfirstName"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" required 
															id="singleStolenfirstName"> <label
															for="singleStolenfirstName"> <spring:message
																code="input.firstName" /> <span class="star"> *</span></label>
													</div>

													<div class="input-field col s12 m4">
														<input type="text" name="middleName"
															pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" 
															oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															id="singleStolenmiddleName"> <label
															for="singleStolenmiddleName"> <spring:message
																code="input.middleName" /></label>
													</div>

													<div class="input-field col s12 m4">
														<input type="text" name="lastName"
															pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" 
															oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															 id="singleStolenlastName">
														<label for="singleStolenlastName"> <spring:message
																code="input.lastName" /><span class="star"> </span>
														</label>
													</div>


													<div class="file-field col s12 m4 l6"
														style="margin-top: -8px;">
														<h6 class="form-label">
															<spring:message
																code="registration.uploadnid/passportimage" />
															<span class="star"> *</span>
														</h6>
														<div class="btn">
															<span> <spring:message code="input.selectfile" /></span>
															<input type="file" pattern="{0,30}"
																oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
																oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
																required placeholder="" onchange="isImageValid('singleStolenFile')"
																id="singleStolenFile">
														</div>
														<div class="file-path-wrapper">
															<input class="file-path validate" type="text"
																placeholder="<spring:message code="registration.uploadnid/passportimage" />"
																id="singleStolenFileName"
																title="">
														</div>
													</div>

													<div class="input-field col s12 m4 l6"
														style="margin-top: 22px;">
														<input type="text" name="nIDPassportNumber"
															pattern="<spring:eval expression="@environment.getProperty('pattern.importerNid')" />" 
															oninput="InvalidMsg(this,'input','<spring:message code="validation.12Character" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.12Character" />');"
															required 
															id="singleStolennIDPassportNumber"> <label
															for="singleStolennIDPassportNumber"> <spring:message code="registration.nid/passportnumber" /> <span
															class="star"> *</span></label>
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
														class="mySelect" onchange="setMandatoryandOptional('singleStolenvillage','singleStolenlocality','singleStolendistrict','singleStolencommune','state')"
														oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											            oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
														title= "<spring:message code="validation.selectFieldMsg" />"
														 style="padding-left: 0;"></select>
												 <%-- <label for="nationality" class=""><spring:message
													code="input.Nationality" /> <span class="star">*</span></label> --%>
										</div>

													<div class="input-field col s12 m4">
														<input type="email" name="email" id="singleStolenemail"
															pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
															oninput="InvalidMsg(this,'email','<spring:message code="validation.emial" />');"
															oninvalid="InvalidMsg(this,'email','<spring:message code="validation.emial" />');"
															> <label for="singleStolenemail"> <spring:message code="input.email" />
														</label>
													</div>

													<div class="col s12 m4" style="margin-top:0px;">
														<p class="contact-label">
															<spring:message code="registration.altcontactnumber" />
															<span class="star"> *</span>
														</p>
														<input type="text" name="phone" id="singleStolenphone1"
															pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');"
															required>
															
													</div> 
													<div class="col s12 m4 ">
															<label> <spring:message
																	code="registration.complainttype" /> <span
																class="star"> *</span></label> <select class="browser-default"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																required id="singleStolenComplaintType">
																<option value=""  selected>
																	<spring:message code="registration.selectcomplainttype" />
																</option>

															</select>
														</div>
													<div class="input-field col s12 m12">
														<input type="text" name="address"
															class="form-control boxBorder boxHeight"
															id="singleStolenaddress"
															pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
															required > <label for="singleStolenaddress">
															<spring:message code="input.addressLawfull" /> <span
															class="star"> *</span>
														</label>
													</div>
														<div class="col s12 m6 l6">
														<label> <spring:message code="input.Country" /><span
															class="star"> *</span></label> <select id="country"  onchange="setDropdownCambodianProviance('state');"
															class="browser-default" class="mySelect"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															required style="padding-left: 0; color: rgb(53, 52, 52);"></select>
													</div>
													<div class="col s12 m6 l6">
														<label id="provianceLabel"> <spring:message code="input.province" />
															 <span class="star stateLabel" > *</span></label> <select id="state"
															class="browser-default" class="mySelect"
															style="padding-left: 0;" onchange="getDistrict(this,'singleStolendistrict','singleStolencommune');"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															required /></select>
													</div>	
														<div class="col s12 m6 l6">
														<%-- <input type="text" name="district"
															id="singleStolendistrict"
															pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															required maxlength="30"> --%>
															
															 <label for="singleStolendistrict" id="singleStolenDistrictLabelID" >
															<spring:message code="input.district" /> <span id="singleStolendistrictLabel"
															class="star"> *</span>
														</label>
														
														 <select
										id="singleStolendistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'singleStolencommune','singleStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;font-size: 14.5px;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
													</div>

													<div class="col s12 m6 l6">
														<%-- <input type="text" name="commune" id="singleStolencommune"
															pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															required maxlength="30"> --%>
														<label id="singleStolenCommuneLabelID"
															for="singleStolencommune"> <spring:message
																code="input.commune" /> <span class=" star" id="singleStolenCommune"> *</span>
														</label>
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
															pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															 maxlength="30"> --%> <label  for="singleStolenvillage">
															<spring:message code="input.village" /> 
														</label>
														<select
										id="singleStolenvillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;">
										<option value=""><spring:message code="select.village" />
										</select>
													</div>
													
													<div class="input-field col s12 m6 l6">
														<input type="text" name="streetNumber"
															class="form-control boxBorder boxHeight"
															id="singleStolenstreetNumber"
															pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
															required > <label
															for="singleStolenstreetNumber"> <spring:message
																code="input.streetNumber" /><span class="star">
																*</span></label>
													</div>

												
													<div class="input-field col s12 m6 l6" style="margin-left:1px;">
														<input type="text" name="locality"
															class="form-control boxBorder boxHeight"
															id="singleStolenlocality"
															pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															> <label for="singleStolenlocality">
															<spring:message code="input.locality" />
														</label>
													</div>

												

													<div class="input-field col s12 m6 l6" style="margin-right: -1px;">
														<input type="text" name="pin"
															class="form-control boxBorder boxHeight"
															id="singleStolenpin" 
															pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
															maxlength="6"> <label for="singleStolenpin">
															<spring:message code="input.postalCode" /><span
															class="star"> </span>
														</label>
													</div>

												

													<div class="col s12 m12" style="margin-top: 30px;">
														<h5><spring:message code="modal.deviceInfo" /></h5>
														<hr>
													</div>

													<div>
														<div class="col s12 m6">
															<%-- <input type="text" name="deviceBrandName"
																id="singleStolendeviceBrandName"
																pattern="[a-zA-Z]{0,20}" 
															oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
																maxlength="20"> <label for="singleStolendeviceBrandName">
																<spring:message code="registration.devicebrandname" />
															</label> --%>
															<label for="singleStolendeviceBrandName"><spring:message
													code="registration.devicebrandname" /> <span class="star">*</span></label>
											<select id="singleStolendeviceBrandName" class="browser-default"
												onchange="changeSelectDropDownToText('singleStolendeviceBrandName')"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												required>
												<option value=""  selected><spring:message
														code="registration.selectproduct" />
												</option>
											</select>
														</div>

												
														<div class="row">	
														<div class="col s6 m6 ">
															<label for="deviceIDType"> <spring:message
																	code="select.deviceIDType" /> <span class="star" id="deviceIdTypeSpan" style="display: none ; margin-top: -18px;margin-left: 82px;">*</span> </label> <select
															id="singleStolendeviceIDType" class="browser-default">
																<option value=""  selected>
																	<spring:message code="select.deviceIDType" />
																</option>
															</select>
														</div>
 													
 													
 													<div class="input-field  col s12 m12" id="OtherBrandNameDiv" style="display: none">
														<input type="text" name="brandName" id="OtherBrandName"
															pattern="[a-zA-Z0-9\s,'*$-]{0,50}"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
															required maxlength="50"> <label
															for="singleStolencommune"> <spring:message
																code="registration.devicebrandname" /> <span class=" star"> *</span>
														</label>
													</div>
														</div>


														<%-- <div class=" col s12 m6">
															<input type="text" name="modalNumber"
																id="singleStolenmodalNumber" pattern="[a-zA-Z0-9]{0,30}"
																
															oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
																maxlength="30"> <label for="singleStolenmodalNumber">
																<spring:message code="input.modelNumber" />
															</label>
															
															<label for="singleStolenmodalNumber"><spring:message
														code="registration.modelnumber" /> <span class="star"></span></label>
												<select id="singleStolenmodalNumber" class="browser-default"
													onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													>
													<option value=""  selected>
														<spring:message code="registration.selectmodelnumber" /></option>

												</select>
														</div> --%>

 														

														<%--

														<div class="col s12 m6 l6">
															<label> <spring:message code="operator.Operator" />
																<span class="star">*</span></label> <select
																class="browser-default" id="singleStolenOperator"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																required>
																<option value=""  selected>
																	<spring:message code="registration.selectoperator" />
																</option>
															</select>
														</div>
														
														<div class="col s12 m6">
															<p class="contact-label">
																<spring:message code="input.contactNum2" />
																<span class="star"></span>
															</p>
															<input type="text" name="phone2" id="singleStolenphone3"
																pattern="[0-9\s,+]{7,15}" maxlength="15" oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" >
														</div>

														

														<div class="col s12 m6 l6">
															<label id="operatorLabel3"> <spring:message code="operator.Operator2" />
																<span class="star" id="operator3span" style="display: none;margin-top: -18px;margin-left: 59px;">*</span></label> 
																<select class="browser-default" id="singleStolenOperator3"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
																<option value=""  selected>
																	<spring:message code="registration.selectoperator" />
																</option>
															</select>
														</div>
														<div class="col s12 m6">
															<p class="contact-label">
																<spring:message code="input.contactNum3" />
																<span class="star"></span>
															</p>
															<input type="text" name="phone2" id="singleStolenphone4"
																pattern="[0-9\s,+]{7,15}" maxlength="15" oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');">
														</div>

														

														<div class="col s12 m6 l6">
															<label id="operatorLabel4"> <spring:message code="operator.Operator3" />
																<span class="star" id="operator4span" style="display: none;margin-top: -18px;margin-left: 59px;">*</span></label> <select
																class="browser-default" id="singleStolenOperator4"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
																<option value=""  selected>
																	<spring:message code="registration.selectoperator" />
																</option>
															</select>
														</div>
																												

														<div class="col s12 m6 l6">
															<label id="operatorLabel3"> <spring:message code="operator.Operator4" />
																<span class="star" id="operator5span" style="display: none;margin-top: -18px;margin-left: 59px;"> *</span></label> <select
																class="browser-default" id="singleStolenOperator5"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
																<option value=""  selected>
																	<spring:message code="registration.selectoperator" />
																</option>
															</select>
														</div> --%>
														<div class="row">
														
														<div class="col s6 m6 ">
															<label for="deviceType"> <spring:message
																	code="select.deviceType" /></label> <select
																class="browser-default" id="singleStolendeviceType">
																<option value=""  selected>
																	<spring:message code="select.deviceType" />
																</option>
															</select>
														</div>
														<div class="col s12 m6 l6">
															<label> <spring:message
																	code="select.multiSimStatus" />
																	<span class="star" >*</span>
															</label> <select class="browser-default" required="required"
																id="singleStolenSimStatus" onchange="setContactIMEINumber('singleStolenSimStatus','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
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
																<span class="star"> *</span>
															</p>
															<input type="text" name="phone2" id="singleStolenphone2"
																	pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
																  oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" required>
														</div>
														
														<div class="input-field col s12 m6">
															<input type="text" name="imeiNumber"
																pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															    oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"  
																 id="singleStolenimei1" > 
																<label for="singleStolenimei1"><spring:message code="registration.one.IMEI" /> <span class="star"> </span> 
																</label><p id="errorMsgOnModal" class="deviceErrorTitle" style="margin-left: 45%;"></p>
														</div>
														</div>
														<div id="IMEIndContact2" style="display: none">
														<div class="col s12 m6">
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
																
																 id="singleStolenimei2" > <label
																for="singleStolenimei12"> <spring:message
																	code="registration.two.IMEI" /></label>
														</div>
														</div>
														<div id="IMEIndContact3" style="display: none">
														<div class="col s12 m6">
															<p class="contact-label">
																<spring:message code="input.contactNum3" />
																<span class="star"></span>
															</p>
															<input type="text" name="phone2" id="singleStolenphone4"
																pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
																 oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');">
														</div>
														
														
														<div class="input-field col s12 m6">
															<input type="text" name="imeiNumberThree"
																pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																
																 id="singleStolenimei3"> <label
																for="singleStolenimei3"> <spring:message code="registration.three.IMEI" /></label>
														
														</div>
														</div>
														
														<div id="IMEIndContact4" style="display: none">
														<div class="col s12 m6">
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
																
																 id="singleStolenimei4"> <label
																for="singleStolenimei4"> <spring:message code="registration.four.IMEI" /></label>
														
														</div>

														</div>
														
														
														<div class="col s12 m12">
															<p style="margin-top: 3px; margin-bottom: 5px">
																<spring:message code="operator.blocking" />
															</p>
															<label style="margin-right: 2%;"> <input
																type="radio" class="blocktypeRadio" 
																value="Immediate" onchange="setDateMandatoryOrOptional('Immediate','stolenDatePeriod')"
																onclick="document.getElementById('calender').style.display = 'none';"
																name="stolenBlockPeriod" checked> <spring:message code="operator.immediate" />
															</label> <label style="margin-right: 2%;"> <input
																type="radio" class="blocktypeRadio" value="Default" id="defaultDatePeriod" title="" 
																onclick="document.getElementById('calender').style.display = 'none';" onchange="setDateMandatoryOrOptional('Default','stolenDatePeriod')"
																name="stolenBlockPeriod"> <spring:message code="operator.default" />
															</label> <label> <input type="radio" required="required"
																value="tilldate" class="blocktypeRadio" onchange="setDateMandatoryOrOptional('tilldate','stolenDatePeriod')"
																onclick="document.getElementById('calender').style.display = 'block';"
																name="stolenBlockPeriod"> <spring:message code="operator.later" />
															</label>
															<div class="input-field col s12 m6 responsiveDiv stolen_calender"
																style="display: none; width: 30%; margin-right: 30%; float: right; margin-top: -15px"
																id="calender">
																<div id="startdatepicker" class="input-group date">
																<%-- <p> <spring:message code="operator.blockingTypePeriod" /> </p> --%>
																<label for="stolenDatePeriod"><spring:message code="operator.blockingTypePeriod" /> <span class="star"> </span> 
																</label>
																	<input type="text" id="stolenDatePeriod"
																		style="margin-top: -9px" /> <span
																		class="input-group-addon" style="color: #ff4081"><i
																		class="fa fa-calendar" aria-hidden="true"
																		style="float: right; margin-top: -30px;"></i></span>
																</div>
															</div>
														</div>

														<%-- <div class="col s12 m12"
															style="margin-top: 30px; font-weight: bold;">
															<h6>
																<spring:message code="registration.imei/meid/esnnumber" />
															</h6>
														</div> --%>

														

														


														
														

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
																id="singleDeviceAddress"
																pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
																required > <label for="singleDeviceAddress">
																<spring:message code="input.address" /><span
																class="star"> *</span>
															</label>
														</div>
														
														<div class="col s12 m6">
															<label> <spring:message code="input.Country" /><span
																class="star"> *</span></label> <select id="singleDevicecountry" disabled="disabled"
																class="browser-default" class="mySelect" onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																style="padding-left: 0; color: rgb(53, 52, 52);" required></select>
														</div>

														<div class="col s12 m6">
															<label> <spring:message code="input.province" /> <span
																class="star">*</span></label> <select id="singleDevicestate"
																class="browser-default" class="mySelect"
																style="padding-left: 0;"onchange="getDistrict(this,'singleDevicedistrict','singleDevicecommune');"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																required>
															</select>
														</div>
															<div class="col s12 m6 l6">
															<%-- <input type="text" name="district"
																id="singleDevicedistrict"
																pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																required maxlength="30"> --%>
																 <label for="singleDevicedistrict">
																<spring:message code="input.district" /><span
																class="star"> * </span>
															</label><select
										id="singleDevicedistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'singleDevicecommune','singleDevicevillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;font-size: 14.5px;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
																
														</div>

														<div class="col s12 m6 l6">
															<%-- <input type="text" name="commune"
																id="singleDevicecommune"
																pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																required maxlength="30"> --%>
															<label for="singleDevicecommune">
																<spring:message code="input.commune" /> <span
																class="star"> *</span>
															</label>	<select
										id="singleDevicecommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'singleDevicevillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										
										<option value=""><spring:message code="select.commune" /></option>
										</select>
																 
														</div>
														
														<div class="col s12 m6 l6">
															<%-- <input type="text" name="village"
																id="singleDevicevillage" maxlength="20"
																pattern="[a-zA-Z0-9\s,'*$-]{0,20}"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																 maxlength="30"> --%>
															<label for="singleDevicevillage">
																<spring:message code="input.village" /> <span
																class="star"></span>
															</label>	 <select
										id="singleDevicevillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" />
										</select>
																  
														</div>
														
														<div class="input-field col s12 m6">
															<input type="text" name="streetNumber"
																class="form-control boxBorder boxHeight"
																id="singleDevicestreetNumber"
																pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
																required > <label
																for="singleDevicestreetNumber"> <spring:message
																	code="input.streetNumber" /> <span class="star">
																	*</span></label>
														</div>

														

														<div class="input-field col s12">
															<input type="text" name="locality"
																class="form-control boxBorder boxHeight"
																id="singleDevicelocality" 
																	pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
																 maxlength="30"> <label for="singleDevicelocality">
																<spring:message code="input.locality" /> <span
																class="star"> </span>
															</label>
														</div>
													<div class="input-field col s12 m6">
															<input type="text" name="pin"
																class="form-control boxBorder boxHeight"
																id="singleDevicepin"
																pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
																 > <label for="singleDevicepin">
																<spring:message code="registration.postalcode" /><span
																class="star"> </span>
															</label>
														</div>
																		
													<div class="input-field col s12 m6">
															<input type="text" name="IndivisualStolenDate"
																id='IndivisualStolenDate' class='form-control datepick'
																autocomplete='off'  onchange="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');"
																 oninvalid="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');"
																
																required /> <label for="IndivisualStolenDate"
																class="center-align"> <spring:message
																	code="operator.stolenDate" /> <span class="star">*</span>
															</label> <span class="input-group-addon" style="color: #ff4081"><i
																class="fa fa-calendar" aria-hidden="true"></i></span>
														</div>

														

														

														

														<%-- <div class="file-field col s12 m6 l6">
															<h6 class="form-label"
																style="margin: 0; font-size: 0.9rem;">
																<spring:message code="input.UploadFIR" />
															</h6>
															<div class="btn">
																<span> <spring:message code="input.selectfile" /></span>
																<input type="file"
																	oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
																	oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
																	placeholder="" id="uploadFirSingle" onchange="isImageValid('uploadFirSingle')"> 
															</div>
															<div class="file-path-wrapper">
																<input class="file-path validate" type="text"
																	placeholder="<spring:message code="input.UploadFIR" />"
																	id="uploadFirSingleName"
																	title="Please upload national
																ID image">
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
<button class="btn right add_field_button" type="button" disabled="disabled"><span
style="font-size: 20px;">+</span><spring:message code="input.addmorefile" /></button>
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
											


											<div class="input-field col s12 center top-space">
											<div><p class="top-space"> <spring:message code="input.requiredfields" />
                                                    <span class="star">*</span></p></div>
												<button class="btn" type="submit"
													id="indivisualStolenButton">
													<spring:message code="button.submit" />
												</button>
												<a href="./stolenRecovery?FeatureId=5" class="btn"
													style="margin-left: 10px;"> <spring:message
														code="button.cancel" /></a>
											</div>
												</div>
											
										</form>
									</div>


									<!-- ____________________________________________________Bulk stolen form________________________________________________________________________ -->


									<div id="Bulkform" class="col s12" style="display: none">
										<form action="" 
											onsubmit="return saveCompanyStolenRequest()" method="POST"
											enctype="multipart/form-data">
											<div class="input-field col s12 m6">
												<input type="text" name="companyName" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.companyName')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.companyName" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.companyName" />');"
													required id="bulkStolencompanyName"> <label
													for="bulkStolencompanyName"> <spring:message
														code="registration.companyName" /> <span class="star">
														*</span></label>
											</div>

											<div class="input-field col s12 m6">
												<input type="text" name="address"
													class="form-control boxBorder boxHeight"
													id="bulkStolenaddress"
													pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
													required  /> <label for="bulkStolenaddress">
													<spring:message code="input.address" /> <span class="star">*</span>
												</label>
											</div>
											
												<div class="col s12 m6 l6">
												<label> <spring:message code="input.Country" /><span
													class="star"> *</span></label> <select id="country2" disabled="disabled"
													class="browser-default" class="mySelect"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													required style="padding-left: 0; color: rgb(53, 52, 52);"></select>
											</div>

											<div class="col s12 m6 l6">
												<label> <spring:message code="input.province" /> <span
													class="star"> *</span></label> <select id="state2"
													onchange="getDistrict(this,'bulkStolendistrict','bulkStolencommune');"
													class="browser-default" class="mySelect"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													required style="padding-left: 0;"></select>
											</div>

                                              <div class="col s12 m6 l6">
												<%-- <input type="text" name="district" id="bulkStolendistrict"
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													required maxlength="30"> --%>
													<label for="bulkStolendistrict">
													<spring:message code="input.district" /> <span
													class="star"> *</span>
													<select
										id="bulkStolendistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'bulkStolencommune','bulkStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;  font-size: 14.5px;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select> 
												</label>
											</div>

											<div class="col s12 m6 l6">
											<%-- 	<input type="text" name="commune" id="bulkStolencommune"
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													required maxlength="30"> --%>
													 <label for="bulkStolencommune">
													<spring:message code="input.commune" /> <span class="star">
														*</span>
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
												<%-- <input type="text" name="village" id="bulkStolenvillage"
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													 maxlength="30">  --%>
													  <label for="bulkStolenvillage">
													<spring:message code="input.village" /> 
												</label>
												 <select
										id="bulkStolenvillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
													
											</div>
											<div class="input-field col s12 m6 l6">
												<input type="text" name="streetNumber"
													class="form-control boxBorder boxHeight"
													id="bulkStolenstreetNumber" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
													required  title="Please enter street number">
												<label for="bulkStolenstreetNumber"> <spring:message
														code="input.streetNumber" /><span class="star"> *</span></label>
											</div>

											

											<div class="input-field col s12 m6 l6" style="margin-left:1px;">
												<input type="text" name="locality"
													class="form-control boxBorder boxHeight"
													id="bulkStolenlocality"
													pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
													 title="Please enter your locality">
												<label for="bulkStolenlocality"> <spring:message
														code="input.locality" /> </label>
											</div>

											

											<div class="input-field col s12 m6 l6" style="    margin-right: -1px;">
												<input type="text" name="pin"
													class="form-control boxBorder boxHeight" id="bulkStolenpin"
													pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
													 > <label for="bulkStolenpin"> <spring:message
														code="registration.postalcode" /> <span class="star">
														</span>
												</label>
											</div>

										

											<div class="col s12 m12" style="margin-top: 30px;">
												<h5>
													<spring:message code="registration.authorizedpersonnelLawfull" />
												</h5>
												<hr>
											</div>
											<!-- <div class="col s12 m12">
                                                        <p><b>Authorized personnel</b> </p>
                                                    </div> -->

											<div class="input-field col s12 m4">
												<input type="text" name="bulkStolenfirstName" id="firstName"
													pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													required > <label for="firstName">
													<spring:message code="input.firstName" /> <span
													class="star"> *</span>
												</label>
											</div>

											<div class="input-field col s12 m4">
												<input type="text" name="middleName"
													pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="
													validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','
												<spring:message code="validation.20Character" />');"
													 id="bulkStolenmiddleName"> <label
													for="middleName"> <spring:message
														code="input.middleName" /></label>
											</div>

											<div class="input-field col s12 m4">
												<input type="text" name="lastName" id="bulkStolenlastName"
													pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													 > <label for="bulkStolenlastName">
													<spring:message code="input.lastName" /> <span
													class="star"></span>
												</label>
											</div>

											<div class="input-field col s12 m6">
												<input type="email" name="officeEmail"
													pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
													oninput="InvalidMsg(this,'email','<spring:message code="
													validation.emial" />');"
													oninvalid="InvalidMsg(this,'email','
												<spring:message code="validation.emial" />');"
													id="bulkStolenofficeEmail"> <label
													for="bulkStolenofficeEmail"> <spring:message
														code="registration.officialemailid" /></label>
											</div>

											<div class="input-field col s12 m6">
												<!-- <p class="contact-label">Alternate Contact Number <span class="star">*</span></p> -->
												<input type="text" name="phone" id="bulkStolenContact"
													pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');"
													/> <label for="bulkStolenContact"> <spring:message
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
													id="deviceBulkStolenaddress"
													pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
													maxlength="200" required /> <label for="deviceBulkStolenaddress"> <spring:message
														code="input.address" /> <span class="star"> *</span></label>
											</div>
											<div class="col s12 m6 l6">
												<label> <spring:message code="input.Country" /><span
													class="star"> *</span></label> <select id="country3" disabled="disabled"
													class="browser-default " class="mySelect"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													required style="padding-left: 0; color: rgb(53, 52, 52);"></select>
											</div>

											<div class="col s12 m6 l6">
												<label> <spring:message code="input.province" /> <span
													class="star"> *</span></label> <select id="state3" onchange="getDistrict(this,'deviceBulkStolendistrict','deviceBulkStolencommune');"
													class="browser-default" class="mySelect" 
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													 style="padding-left: 0; " required>
													 
													 </select>
											</div>
											
											<div class="col s12 m6 l6">
											<%-- 	<input type="text" name="district"
													id="deviceBulkStolendistrict"
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													required maxlength="30"> --%> <label for="deviceBulkStolendistrict">
													<spring:message code="input.district" /> <span
													class="star"> *</span> <select
										id="deviceBulkStolendistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'deviceBulkStolencommune','deviceBulkStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;font-size: 14.5px" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
												</label>
											</div>

											<div class="col s12 m6 l6">
												<%-- <input type="text" name="commune"
													id="deviceBulkStolencommune"
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													required maxlength="30"> --%> <label for="deviceBulkStolencommune">
													<spring:message code="input.commune" /><span class="star">
														*</span>
												</label>
												<select
										id="deviceBulkStolencommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'deviceBulkStolenvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option>
										</select>
											</div>
												
												<div class="col s12 m6">
												<%-- <input type="text" name="village"
													id="deviceBulkStolenvillage"
													pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
													 maxlength="30"> --%><label for="deviceBulkStolenvillage">
													<spring:message code="input.village" />
												</label>
													 <select
										id="deviceBulkStolenvillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
													  
											</div>
											
											<div class="input-field col s12 m6">
												<input type="text" name="streetNumber"
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenstreetNumber"
													pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
													required > <label for="deviceBulkStolenstreetNumber">
													<spring:message code="input.streetNumber" /> <span
													class="star"> *</span>
												</label>
											</div>

											

											<div class="input-field col s12 m6"  style="    margin-left:2px;">
												<input type="text" name="locality" 
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenlocality"
													pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
													 > <label for="deviceBulkStolenlocality">
													<spring:message code="input.locality" /> 
												</label>
											</div>

											

											<div class="input-field col s12 m6 l6" style="    margin-right: -2px;">
												<input type="text" name="pin"
													class="form-control boxBorder boxHeight"
													id="deviceBulkStolenpin" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
													 > <label for="deviceBulkStolenpin">
													<spring:message code="registration.postalcode" /><span
													class="star"> </span>
												</label>
											</div>

											

											<div class="col s12 m6 l6">
												<label> <spring:message
														code="registration.complainttype" /><span class="star">
														*</span></label> <select class="browser-default"
													id="deviceBulkStolenComplaint"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													required>
													<option value=""  selected>
														<spring:message code="registration.selectcomplainttype" />
													</option>

												</select>
											</div>

											<div class="input-field col s12 m6 l6"
												style="margin-top: 16px;">
												<input type="text" name="quantity"
													class="form-control boxBorder boxHeight" 
													id="deviceBulkStolenquantity" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													required> <label for="deviceBulkStolenquantity"> <spring:message
														code="input.quantity" /><span class="star"> *</span></label>
											</div>
											
											<div class="input-field col s12 m6 l6"
												style="margin-top: 22px;">
												<input type="text" name="devicequantity"
													class="form-control boxBorder boxHeight" 
													id="devicequantity" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													required> <label for="devicequantity"> <spring:message
														code="input.devicequantity" /><span class="star"> *</span></label>
											</div>
											
											<%-- <div class="input-field col s12 m6">
											<input type="text" name="devicequantity" id="devicequantity"
												pattern="[0-9]{0,7}"
												
												maxlength="7"  oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"  required/> <label for="devicequantity"
												class="center-align"><spring:message code="input.devicequantity" /> <span class="star">*</span></label>
										</div> --%>


											<div class="file-field col s12 m6">
												<h6 class="file-label">
													<spring:message code="registration.uploaddevicelist" />
													<span class="star"> *</span>
												</h6>
												<div class="btn">
													<span> <spring:message code="input.selectfile" /></span> <input
														type="file"
														oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														required id="deviceBulkStolenFile" onchange="isFileValid('deviceBulkStolenFile')" accept=".csv">
												</div>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text" id="deviceBulkStolenFileName">
												</div>
											</div>

												
											<div class="col s12 m6 blockingType">
												<p style="margin-top: 3px; margin-bottom: 5px">
													<spring:message code="operator.blocking" />
												</p>
												<label style="margin-right: 2%;"> <input
													type="radio" class="bulkblocktypeRadio" value="Immediate" onchange="setDateMandatoryOrOptional('Immediate','stolenBulkDatePeriod')"
													onclick="document.getElementById('stolenCalender').style.display = 'none';"
													name="stolenBulkBlockPeriod" checked> <spring:message
														code="operator.immediate" />
												</label> <label style="margin-right: 2%;"> <input
													type="radio" class="bulkblocktypeRadio" value="Default"  id="bulkDefaultPeiod" title=""
													onclick="document.getElementById('stolenCalender').style.display = 'none';" onchange="setDateMandatoryOrOptional('Default','stolenBulkDatePeriod')"
													name="stolenBulkBlockPeriod"> <spring:message
														code="operator.default" />
												</label> <label> <input type="radio" required="required"
													value="tilldate" class="bulkblocktypeRadio" onchange="setDateMandatoryOrOptional('tilldate','stolenBulkDatePeriod')"
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
											</div>
											<div class="input-field col s12 m6">
												<input type="text" name="bulkStolenDate" id='bulkStolenDate'
													class='form-control datepick' autocomplete='off'
													
													oninput="InvalidMsg(this,'input','<spring:message code="validation.requiredMsg" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.requiredMsg" />');"
													
													required /> <label for="bulkStolenDate"
													class="center-align"> <spring:message
														code="operator.stolenDate" /> <span class="star">
														*</span>
												</label> <span class="input-group-addon" style="color: #ff4081"><i
													class="fa fa-calendar" aria-hidden="true"></i></span>
											</div>

											<div class="file-field col s12 m6 l6" style="    margin-right: 1px;">
												<h6 class="form-label" style="margin: 0;margin-bottom: 10px; font-size: 0.9rem;">
													<spring:message code="input.UploadFIR" />
												</h6>
												<div class="btn">
													<span> <spring:message code="input.selectfile" /></span> <input
														type="file" onchange="isImageValid('uploadFirBulk')"
														oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														placeholder="Upload FIR" id="uploadFirBulk">
												</div>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text"
														
														id="uploadFirSingleBulkName"
														title="Please upload national ID
													image">
												</div>
											</div>

											<div class="input-field col s12 m12"
												style="margin-top: 22px;">
												<textarea id="deviceBulkStolenRemark"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
													maxlength="10000" class="materialize-textarea"></textarea>
												<label for="textarea1"> <spring:message
														code="input.remarksLawfull" /></label>
											</div>
											
											

											<div class="col s12 m12">
											<p> <spring:message code="input.requiredfields" />
												<span class="star">*</span></p>
												<a href="./Consignment/sampleFileDownload/7"> <spring:message
														code="input.downlaod.sample" /></a>
											</div>

											<div class="input-field col s12 center">
												<button class="btn" type="submit" id="bulkStolenButton">
													<spring:message code="button.submit" />
												</button>
												<a href="./stolenRecovery?FeatureId=5" class="btn"
													style="margin-left: 10px;"> <spring:message
														code="button.cancel" /></a>
											</div>
										</form>
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
								<a href="./stolenRecovery?FeatureId=5" class="btn" style="margin: 20px 0;">
									<spring:message code="modal.ok" />
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--end container-->
	<div id="fileFormateModal" class="modal">
		<h6 class="modal-header"><spring:message code="fileValidationModalHeader" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="fileErrormessage"><spring:message code="fileValidationName" /><br> <br> <spring:message code="fileValidationFormate" /> <br><br> <spring:message code="fileValidationSize" /> </h6>
				<input type="text" id="FilefieldId" style="display: none;">
				<input type="text" id='removeFileId' style="display: none;">
			<input type="text" id='removeFileInput' style="display: none">
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
	</section>



	<!--materialize js-->
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
		src=""></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

	

	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>	

	
		<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script type="text/javascript"
		src="${context}/resources/project_js/provinceDropdown.js?version=<%= (int) (Math.random() * 10) %>" async></script> 
	<script type="text/javascript"
		src="" async></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/nationality.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/CommanLocality.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript" src="${context}/resources/js/intlTelInput.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript" src="${context}/resources/js/utils.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script>
		$('.datepick').datepicker({
				dateFormat : "yy-mm-dd",
			maxDate:"0"
		});

		populateCountries("singleDevicecountry");
		populateStates("singleDevicecountry", "singleDevicestate");

		setDropdownProviance('singleDevicestate');

		populateCountries("country2");
		populateStates("country2", "state2");

		populateCountries("country3");
		populateStates("country3", "state3");

		//populateCountries("nationality", "");
		
		
		//populateCountries("country");
		/* var input = document.querySelector("#singleStolenphone1");
		window.intlTelInput(input, {
			utilsScript : "${context}/resources/js/utils.js",
		});
		var input2 = document.querySelector("#singleStolenphone2");
		window.intlTelInput(input2, {
			utilsScript : "${context}/resources/js/utils.js",
		});
	 */

		$('#stolenDatePeriod').datepicker({
			dateFormat : "yy-mm-dd",
			minDate: "0"
		});

		$('#stolenDatePeriodedit').datepicker({
			dateFormat : "yy-mm-dd"
		});

		$('#stolenDatePeriodUnblock').datepicker({
			dateFormat : "yy-mm-dd"
		});

		$('#stolenBulkDatePeriod').datepicker({
			dateFormat : "yy-mm-dd",
			minDate: "0"
		});

		$('#stolenDatePeriodedit').datepicker({
			dateFormat : "yy-mm-dd"
		});

		$('#stolenDatePeriodUnblock').datepicker({
			dateFormat : "yy-mm-dd"
		});
		
		
		
		function isImageValid(id) {
		
			var uploadedFileName = $("#"+id).val();
			uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
			//alert("file extension=="+uploadedFileName)
			var ext = uploadedFileName.split('.').pop();
			$('#FilefieldId').val(id);
			var fileSize = ($("#"+id)[0].files[0].size);
			/*fileSize = (Math.round((fileSize / 100000) * 100) / 100)
			alert("----"+fileSize);*/
			fileSize = Math.floor(fileSize/1000);
			//$('#FilefieldId').val(id);
			//alert(uploadedFileName+"----------"+ext+"----"+fileSize)
			var fileExtension =ext.toLowerCase();
			//console.log("file type: "+fileExtension);
			var extArray = ["png", "jpg","jpeg","gif","bmp","gif"];
			var isInArray =extArray.includes(fileExtension);
			////console.log.log("isInArray: "+isInArray)
			if (uploadedFileName.length > 30) {
				$('#fileFormateModal').openModal();
				$('#fileErrormessage').text('');
				$('#fileErrormessage').text($.i18n('imageMessage'));
			}
			else if(isInArray ==false)
			{
				$('#fileFormateModal').openModal({
					dismissible:false
				});
				$('#fileErrormessage').text('');
				$('#fileErrormessage').text($.i18n('imageMessage'));

			}
			else if(fileSize>=5000){
				$('#fileFormateModal').openModal({
					dismissible:false
				});
				$('#fileErrormessage').text('');
				$('#fileErrormessage').text($.i18n('imageSize'));
			}
		}
		/* function clearFileName() {
			var fieldId=$('#FilefieldId').val();
			alert(fieldId);
			if(fieldId=='singleStolenFile')
				{
				$('#singleStolenFileName').val('');
				}
			else if(fieldId=='uploadFirSingle')
				{
				$('#uploadFirSingleName').val('');
				}
		
			$('#fileFormateModal').closeModal();
		} */
		
		$("#singleDevicecountry").val("Cambodia").change();
		//$("#singleDevicecountry").attr("style", "pointer-events: none;");
		
		
		
		$("#country3").val("Cambodia").change();
		//$("#country3").attr("style", "pointer-events: none;");
		
		$("#country2").val("Cambodia").change();
		//$("#country2").attr("style", "pointer-events: none;");
		
		populateCountries("country");
		populateStates("country", "state");
		
		setDropdownProviance('state2');
		setDropdownProviance('state3');
		
		
	
	</script>

	<script type="text/javascript"
		src="${context}/resources/project_js/select2.js"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/stolenRecovery.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/lawfulStolenRecovery.js?version=<%= (int) (Math.random() * 10) %>"></script>

<script type="text/javascript">
/* $('div#initialloader').delay(300).fadeOut('slow'); */
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