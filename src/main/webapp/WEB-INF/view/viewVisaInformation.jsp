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
<!--<title>Visa Information</title>-->

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
	href="${context}/resources/project_css/viewConsignment.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">


<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>

<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>
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
<body data-id="43" data-roleType="${usertype}" session-value="${not empty param.NID ? param.NID : 'null'}" data-source-value="${not empty param.source ? param.source : 'null'}">

	<!-- START CONTENT -->
	<section id="content">
		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div class="container-fluid pageHeader">
								<p class="PageHeading"><spring:message code="registerconsignment.header.viewDeviceInformation" /></p>
								<!-- <a href="#addDevice" class="boton right modal-trigger">Add Device</a> -->
							</div>
							<div id="user123" class="section"> 
								<form action="" onsubmit="return submitDeviceInfo()" id="viewDeviceForm"
									method="POST" enctype="multipart/form-data">
																			<div class="row">
											<div class="col s12 m12">
												<div class="col s12 m12">
													<h5><spring:message code="input.personalInformation" /></h5>
													<hr>
												</div>
											</div>
											<div class="col s12 m12" style="margin-top: 20px;">
												<div class="input-field col s12 m4">
													<input type="text" id="nationalID" readonly="readonly" value="${viewInformation.data.nid}"/> <label for="nationalID"
														class="center-align ml-10"><spring:message code="input.nidText" /></label>
												</div>

													<div class="col s12 m4" style="margin-top: -3px;">
															<label for="deviceType"><spring:message code="input.documenttype" /> <span
																class="star"></span></label> <%-- <select class="browser-default" disabled="disabled"
																id="doc_type" value="${viewInformation.endUserDB.nid}"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
											                    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');" required>
																<option value="" disabled selected><spring:message code="select.documenttype" /> </option>
															</select> --%>
															<input type="text" value="${viewInformation.data.docTypeInterp}" readonly="readonly">
															
															<!-- <input type="text" id="docTypeNymericValue" style="display: none" > -->
														</div>	

												<div class="file-field col s12 m4"
													style="margin-top: -15px;">
													<h6 style="color: #000;"><spring:message code="input.uploadNidProof" /> <span class="star"></span>
													</h6>
													<!-- <div class="">
														 <input type="text"  readonly="readonly" >
													</div> -->
													<div class="file-path-wrapper">
														<input class="file-path validate responsive-file-div" id="csvUploadFileName" readonly="readonly" value="${viewInformation.data.passportFileName}"
															type="text">
														<a	class="imgPreviewLink" onclick="previewFile('${fileLink}','${viewInformation.data.passportFileName}','${viewInformation.data.txnId}','${viewInformation.data.docTypeInterp}')"><spring:message code="input.preView" /></a>
													<input type="text" style="display: none" id="redirectionTxnid" value="${txnId}">
													</div>
												</div>
											</div>
											<div class="col s12 m12">
												<div class="input-field col s12 m4 l4">
													<input type="text" readonly="readonly" value="${viewInformation.data.firstName}"	>
													<label for="firstName" class="center-align"><spring:message code="input.firstName" /> <span class="star"></span>
													</label>
												</div>

												<div class="input-field col s12 m4 l4">
												 <c:choose>
												<c:when test = "${viewInformation.data.middleName=='' || viewInformation.data.middleName==null}">
													<input type="text" readonly="readonly" id="middleName" value="NA">
													</c:when>
													<c:otherwise>
													<input type="text" readonly="readonly" id="middleName" value="${viewInformation.data.middleName}">
													</c:otherwise>
													</c:choose>
													<label for="middleName" class="active"><spring:message code="input.middleName" /></label>
												</div>

												<div class="input-field col s12 m4 l4">
													<input type="text"readonly="readonly"  value="${viewInformation.data.lastName}"> 
													<label for="lastName"><spring:message code="input.lastName" /> <span class="star"></span>
													</label>
												</div>
												
												<div class="input-field col s12 m6" id="nationalityDiv"
											style="display: block">
											<input type="text" id="nationality" readonly="readonly" name="nationality" value="${viewInformation.data.nationality}"> <label for="nationality" class=""><spring:message
													code="input.Nationality" /></label>
										</div>
										<c:choose>
												<c:when test = "">
										<div class="input-field col s12 m6" id="entryCountryDiv" style="display: none;">
												<input type="text" readonly="readonly" id="datepicker" value="${viewInformation.data.entryDateInCountry}" /> <label for="datepicker"><spring:message
														code="input.EntryCountry" /> <span class="star">*</span></label>
									</div>
									</c:when>
									<c:otherwise>
									<div class="input-field col s12 m6" id="entryCountryDiv" style="display: block;">
												<input type="text" readonly="readonly" class="active" id="datepicker" value="${viewInformation.data.entryDateInCountry}" /> <label for="datepicker"><spring:message
														code="input.EntryCountry" /> <span class="star"></span></label>
									</div>
									</c:otherwise>
									</c:choose>
											</div>
										</div>

										<div class="row">
											<div class="col s12 m12">
												<div class="input-field col s12 m12 l12">
													<input type="text" readonly="readonly"
														 value="${viewInformation.data.propertyLocation}" class="form-control boxBorder boxHeight" id="address">
													<label for="address"><spring:message code="input.address" /> <span
														class="star"></span></label>
												</div>

												<div class="input-field col s12 m6 l6">
													<input type="text" readonly="readonly"
														value="${viewInformation.data.street}"
														class="form-control boxBorder boxHeight" id="streetNumber"
														maxlength="20" required/> <label
														for="streetNumber"> <spring:message code="input.streetNumber" /> <span
														class="star"></span>
													</label>
												</div>
													<div class="input-field col s12 m6 l6">
													 <c:choose>
												<c:when test = "${viewInformation.data.village=='' || viewInformation.data.village==null}">
													<input type="text" readonly="readonly" value="NA" class="form-control boxBorder boxHeight" id="village"
														maxlength="30" required/>
													</c:when>
													<c:otherwise>
													<input type="text" readonly="readonly" value="${viewInformation.data.village}" class="form-control boxBorder boxHeight" id="village"
														maxlength="30" required/>
													
													</c:otherwise>
													</c:choose>
													
														 <label
														for="village"> <spring:message code="input.village" /> <span
														class="star"></span>
													</label>
												</div>
												

												<div class="input-field col s12 m6 l6"> 
												 <c:choose>
												<c:when test = "${viewInformation.data.locality=='' || viewInformation.data.locality==null}">
													<input type="text" readonly="readonly" value="NA"
														class="form-control boxBorder boxHeight" id="locality"
														maxlength="30" required/>
														</c:when>
														<c:otherwise>
														<input type="text" readonly="readonly" value="${viewInformation.data.locality}"
														class="form-control boxBorder boxHeight" id="locality"
														maxlength="30" required/>
														</c:otherwise>
														</c:choose>
														 <label
														for="locality"> <spring:message code="input.locality" /> <span class="star"></span>
													</label>
												</div>

													<div class="input-field col s12 m6 l6">
													<input type="text" readonly="readonly" value="${viewInformation.data.district}"
														class="form-control boxBorder boxHeight" id="district"
														maxlength="30" required> <label
														for="district"> <spring:message code="input.district" /> <span
														class="star"></span>
													</label>
												</div>
												<div class="input-field col s12 m6 l6">
													<input type="text" readonly="readonly" value="${viewInformation.data.commune}"
														class="form-control boxBorder boxHeight" id="commune"
														maxlength="30" required/> <label
														for="commune"> <spring:message code="input.commune" /> <span
														class="star"></span>
													</label>
												</div>
												<div class="input-field col s12 m6 l6">
													
													<input type="text" readonly="readonly"
														class="form-control boxBorder boxHeight" id="postalcode"
														maxlength="6"  value="${viewInformation.data.postalCode}" required/> <label
														for="postalcode"> <spring:message code="input.postalCode" /> <span
														class="star"></span>
													</label>
												</div>
												<div class="input-field col s12 m6 l6">
													<p
														style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
														<spring:message code="table.country" /> <span class="star"></span>
													</p>
													<%-- <select id="country" class="browser-default"
														class="mySelect" disabled="disabled"  value="${viewInformation.endUserDB.country}"
														oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											            oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
														title= "<spring:message code="validation.selectFieldMsg" />"
														 style="padding-left: 0;" required></select> --%>
														 <input type="text" readonly="readonly" value="${viewInformation.data.country}">
												</div>

												<div class="input-field col s12 m6 l6">
													<p
														style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
													<spring:message code="input.province" /> <span class="star"></span>
													</p>
													<input type="text" readonly="readonly"  value="${viewInformation.data.province}">
												<%-- 	<select id="state" class="browser-default" class="mySelect" disabled="disabled"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													title= "<spring:message code="validation.selectFieldMsg" />"
														style="padding-left: 0;" required></select> --%>
												</div>
											</div>

											<div class="col s12 m12" style="margin-top: 10px;">
												<div class="input-field col s12 m6 l6">
												 <c:choose>
												<c:when test = "${viewInformation.data.email=='' || viewInformation.data.email==null}">
														<input type="email" readonly="readonly" id="email"
														 value="NA">
												</c:when>
												<c:otherwise>
												<input type="email" readonly="readonly" id="email"
														 value="${viewInformation.data.email}">
												</c:otherwise>
												</c:choose>		 
														  <label for="email"><spring:message code="input.email" /><span
														class="star"></span></label>
												</div>

												<div class="input-field col s12 m6 l6" style="margin-top: 18px;">
													<input type="text" readonly="readonly"
														pattern="[0-9]{10,10}"  value="${viewInformation.data.phoneNo}" > <label for="phone"><spring:message code="input.contactNum" /><span class="star"></span>
													</label>
												</div>
												<div class="input-field col s12 m6 l6" style="margin-top: 18px;margin-right: 1px;">
												<c:choose>
												<c:when test = "${viewInformation.data.rejectedRemark=='' || viewInformation.data.rejectedRemark==null}">
													<input type="text" readonly="readonly"
														pattern="[0-9]{10,10}"  value="NA" >
												</c:when>
												<c:otherwise>
												<input type="text" readonly="readonly"
														pattern="[0-9]{10,10}"  value="${viewInformation.data.rejectedRemark}" >
												</c:otherwise>
												</c:choose>		
														 <label for="textarea1" class="active"><spring:message
																	code="input.remarksRejected" /> </label>
												</div>
											</div>
											
											<div class="col s12 m12" style="height: 4rem;">
											<label for="nationality"><spring:message
													code="input.VIP" /> </label>
											<div class=" boxHeight">
												 <c:choose>
												<c:when test = "${viewInformation.data.isVip=='Y'}">
												<label>
												 
												<input class="with-gap" type="radio" name="selectvip" value="Y" disabled="disabled" checked="checked">
												 <span><spring:message code="modal.yes" /></span>
												
												  </label>
												  
												  <label> 
												  <input class="with-gap" value="N" type="radio" name="selectvip" disabled="disabled" style="margin-left: 20px;" /> 
												  <span><spring:message code="modal.no" /></span>
												</label>
												  </c:when>
												 <c:otherwise>
												 <label>
												 
												<input class="with-gap" type="radio" name="selectvip" readonly="readonly" value="Y"  disabled="disabled" >
												 <span><spring:message code="modal.yes" /></span>
												
												  </label>
												  <label> 
												  <input class="with-gap" value="N" type="radio" readonly="readonly" checked="checked" disabled="disabled"
													name="selectvip" style="margin-left: 20px;" /> <span><spring:message code="modal.no" /></span>
												</label>
												</c:otherwise>
												</c:choose>
											</div>
										</div>
										<div class="row" style="display: none;" id="vipUserDiv">
											<div class="input-field col s12 m6">
												<input type="text" id="departmentName" readonly="readonly" value="${viewInformation.data.userDepartment.name}"/> 
												<label for="departmentName"><spring:message
														code="input.DepartmentName" /> <span class="star"></span></label>
											</div>

											<div class="input-field col s12 m6">
												<input type="text" id="endUserdepartmentID" readonly="readonly" value="${viewInformation.data.userDepartment.departmentId}" />
												 <label for="endUserdepartmentID"><spring:message
														code="input.DepartmentID" /><span class="star"></span> </label>
											</div>

											<div class="file-field input-field col s12 m6 l6">
												 <h6 style="color: #000;    font-size: 0.8rem;margin: 0px 0px 5px;">
													<spring:message code="input.UploadIDImage" />
													<span class="star"></span>
												</h6>
											<%--	<div class="btn">
													<span><spring:message code="operator.file" /></span> <input
														type="file" accept="image/*"
														onchange="deptImageValidation()"
														oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														 id="endUserDepartmentId" 
														placeholder="">
												</div> --%>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text" readonly="readonly" value="${viewInformation.data.userDepartment.departmentFilename}"
													  id="endUSerNidaPlaceholder">
													<a	class="imgPreviewLink" onclick="previewFile('${fileLink}','${viewInformation.data.userDepartment.departmentFilename}','${viewInformation.data.txnId}')"><spring:message code="input.preView" /></a>	
												</div>
											</div>
										</div>
										
								<div class="col s12 m12" style="height: 4rem; display: block "id="askVisaDetails">
											<label for="nationality"><spring:message
													code="input.AddVisa" /> <span class="star"></span></label>
											<div class=" boxHeight">
												<c:choose>
												<c:when test = "${viewInformation.data.onVisa=='Y'}">
												<label><input class="with-gap" type="radio" disabled="disabled"
													name="onVisa" value="Y" checked="checked">
													<span><spring:message code="modal.yes" /></span> </label> <label>
													<input class="with-gap" type="radio" id="onVisaNo" 
													 name="onVisa" value="N" disabled="disabled"
													style="margin-left: 20px;" />
													<span><spring:message code="modal.no" /></span>
												</label>
												</c:when>
												<c:otherwise>
												<label><input class="with-gap" type="radio" disabled="disabled"
													name="onVisa" value="Y">
													<span><spring:message code="modal.yes" /></span> </label>
													 <label>
													<input class="with-gap" type="radio" id="onVisaNo" disabled="disabled"
													checked="checked" name="onVisa" value="N"
													style="margin-left: 20px;"  />
													<span><spring:message code="modal.no" /></span>
												</label>
												</c:otherwise>
												</c:choose>
											</div>
										</div>

										<div class="row" id="visaDetails" style="display: none;">
											<c:forEach items="${viewInformation.data.visaDb}" var="list">
											<div class="col s12 m6" style="margin-top: -3px;">
												<label for="visaType"><spring:message
														code="input.VisaType" /> <span class="star"></span></label> 
					                           <input type="text" readonly="readonly" value="${list.visaTypeInterp}">
											</div>

											
											<div class="input-field col s12 m6">
												<input type="text" id="visaNumber" readonly="readonly" value="${list.visaNumber}" /> <label for="visaNumber"><spring:message
														code="input.VisaNumber" /> <span class="star"></span></label>
											</div>

											<!-- <div class="input-field col s12 m6">
                                                    <input type="text" id="bdate" class="datepicker" name="expiryDate"
                                                        pattern="[]" title="" maxlength="15" />
                                                    <label for="bdate">Visa Expiry Date <span
                                                            class="star">*</span></label>
                                                </div> -->

											<div class="input-field col s12 m6">
												<input type="text" id="datepicker1" readonly="readonly" value="${list.visaExpiryDate}" > <label for="datepicker1"><spring:message
														code="input.VisaExpiry" /> <span class="star"></span></label>
											</div>

											<div class="file-field input-field col s12 m6" style="margin-top: -3px;">
												<h6 style="color: #000; font-size: 0.8rem;margin: 0px 0px 5px;">
													<spring:message code="input.UploadVisa" />
													<span class="star"></span>
												</h6>
												<%-- <div class="btn">
													<span><spring:message code="operator.file" /></span> <input
														type="file" id="visaImage" accept="image/*"
														oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														onchange="visaImageValidation()"
														oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														 placeholder="">
												</div> --%>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text" value="${list.visaFileName}"  readonly="readonly"
														id="ensUserVisaPlaceHolder">
													<a	class="imgPreviewLink" onclick="previewFile('${fileLink}','${list.visaFileName}','${txnId}')"><spring:message code="input.preView" /></a>
														
														
												</div>
											</div>
											</c:forEach>
										</div>
										</div>
									
									<div id="mainDeviceInformation" class="mainDeviceInformation" style="display: none">
										<div id="deviceInformation" class="deviceInformation">
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m12" style="margin-top: 30px;">
														<h5><spring:message code="modal.deviceInfo" /></h5>
														<hr>
													</div>

													<div class="col s12 m6">
														<label for="deviceType1"><spring:message code="select.deviceType" /><span
															class="star"></span></label>
															<input type="text" value="" readonly="readonly">
													</div>

													<div class="col s12 m6">
														<label for="deviceIdType1"><spring:message code="select.deviceIDType" /><span
															class="star"></span></label> 
															<input type="text" value="" readonly="readonly">
													</div>

													<div class="col s12 m6">
														<label for="multipleSimStatus1"><spring:message code="select.multiSimStatus" /><span class="star"></span>
														</label> <input type="text" value="" readonly="readonly">
													</div>

													<div class="col s12 m6">
														<label for="country1"><spring:message code="select.countryBoughtFrom" /><span
															class="star"></span></label> 
															<input type="text" value="" readonly="readonly">
													</div>

													<div class="input-field col s12 m6"
														style="margin-top: 28px;">
														<input type="text" value="" readonly="readonly">
														 <label for="serialNumber1"> <spring:message code="input.deviceSerialNumber" /><span class="star"></span>
														</label>
													</div>

													<div class="col s12 m6">
														<label for="taxStatus1"><spring:message code="select.taxPaidStatus" /><span
															class="star"></span></label> <input type="text" readonly="readonly" value="">
															
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m6" style="margin-top: -10px;">
														<label for="deviceStatus1"><spring:message code="select.deviceStatus" /><span
															class="star"></span></label> 
														<input type="text" readonly="readonly" value="">	
													</div>
                                                      <c:choose>
												<c:when test = "">
													<div class="input-field col s12 m6 l6">
														<input type="text" id="Price1" value="" readonly="readonly">
														<label for="Price1"><spring:message code="select.price" /></label>
													</div>

													<div class="col s12 m6">
														<label for="Currency1" class="active"><spring:message code="input.currency" /><span class="star"></span></label>
														<input type="text" value="" readonly="readonly">
													</div>
													</c:when>
													<c:otherwise>
													
													</c:otherwise>
													</c:choose>
												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class='col s12 m12 input_fields_wrap'>
														<p><spring:message code="title.imeiMeidEsn" /></p>
														<div class='row'>
															<div class="input-field col s12 m6">
																<input type="text" value="" readonly="readonly">
																 <label for="IMEIA1"><spring:message code="title.one" /><span
																	class="star"></span></label>
															</div>
															<div class="input-field col s12 m6">
																<input type="text" value="" readonly="readonly">
																 <label for="IMEIB1"><spring:message code="title.two" /></label>
															</div>

															<div class="input-field col s12 m6">
																<input type="text" value="" readonly="readonly">
																 <label for="IMEIC1"><spring:message code="title.three" /></label>
															</div>

															<div class="input-field col s12 m6" id="field">
																<input type="text" value="" readonly="readonly">
																 <label for="IMEID1"><spring:message code="title.four" /></label>
															</div>
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
										<%-- <p>
											<spring:message code="input.requiredfields" /> <span class="star"></span>
										</p> --%>
									</div>

									<div class="col s12 m12 center" style="margin-top: 30px;">
										<%-- <button class="btn " type="submit"> <spring:message code="button.submit" /></button> --%>
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

	<%-- <div id="addDevice" class="modal">
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
 --%>	<!-- Modal End -->

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
		<h6 class="modal-header"><spring:message code="modal.uploadPaidDevice" /></h6>
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
			<script type="text/javascript" src="${context}/resources/project_js/common.js"></script>

	<!-- ================================================
    Scripts
    ================================================ -->

<script type="text/javascript">
$('#redirectToPage').click(function(){
	var nationalID=$('#nationalID').val();
	var txnID= $('#redirectionTxnid').val();
	var source= $("body").attr("data-source-value");
	
	    if (source=='menu'){
			txnID='';
		}
		else if(source=='filter'){
			txnID='';
			source='menu'
		}

	 window.location.replace("${context}/updateVisa?txnID="+txnID+"&source="+source);
	});
	
var selectvip=$("input[name='selectvip']:checked").val()
var onVisa=$("input[name='onVisa']:checked").val()
if(selectvip=="Y")
	{
	$("#vipUserDiv").css("display", "block"); 
	}
if(onVisa=='Y')
	{
	

	$("#visaDetails").css("display", "block"); 
	}
/* 	
$("label[for='middleName']").addClass('active');
$("label[for='datepicker']").addClass('active');
$("label[for='email']").addClass('active');
$("label[for='Price1']").addClass('active');
 */


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