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
<!--<title>View Add Device Information</title>-->

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

<script type="text/javascript"
	src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
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
<body data-id="12" session-value="${not empty param.NID ? param.NID : 'null'}" data-roleType="${usertype}"
data-txnid-value="${not empty param.transactionID ? param.transactionID : 'null'}" data-source-value="${not empty param.source ? param.source : 'null'}">

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
													<input type="text" id="nationalID" readonly="readonly" value="${viewInformation.endUserDB.nid}"/> <label for="nationalID"
														class="center-align ml-10"><spring:message code="registration.nationalid/passporartnumber" /></label>
												</div>

													<div class="col s12 m4" style="margin-top: -10px;">
															<label for="deviceType"><spring:message code="input.documenttype" /> <span
																class="star"></span></label> <%-- <select class="browser-default" disabled="disabled"
																id="doc_type" value="${viewInformation.endUserDB.nid}"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
											                    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');" required>
																<option value="" disabled selected><spring:message code="select.documenttype" /> </option>
															</select> --%>
															<input type="text" value="${viewInformation.endUserDB.documentInterp}" readonly="readonly">
															
															<!-- <input type="text" id="docTypeNymericValue" style="display: none" > -->
														</div>	

												<div class="file-field col s12 m4"
													style="margin-top: -15px;">
													<h6 style="color: #000;"><spring:message code="validation.PassportPlaceholder" /> <span class="star"></span>
													</h6>
													<!-- <div class="">
														 <input type="text"  readonly="readonly" >
													</div> -->
													<div class="file-path-wrapper">
														<input class="file-path validate responsive-file-div" id="csvUploadFileName" readonly="readonly" value="${viewInformation.endUserDB.passportFileName}"
															type="text">
														<a	class="imgPreviewLink" onclick="previewFile('${fileLink}','${viewInformation.endUserDB.passportFileName}','${viewInformation.endUserDB.txnId}','${viewInformation.endUserDB.docTypeInterp}')"><spring:message code="input.preView" /></a>
													</div>
												</div>
											</div>
											<div class="col s12 m12">
												<div class="input-field col s12 m4 l4">
													<input type="text" readonly="readonly" value="${viewInformation.endUserDB.firstName}"	>
													<label for="firstName" class="center-align"><spring:message code="input.firstName" /> <span class="star"></span>
													</label>
												</div>

												<div class="col s12 m4 l4">
													<label for="middleName" class="active"><spring:message code="input.middleName" /></label>
													<c:choose>
												<c:when test = "${viewInformation.endUserDB.middleName=='' || viewInformation.endUserDB.middleName==null}">
													<input type="text" readonly="readonly" id="middleName" value="NA">
												</c:when>
												<c:otherwise>
												<input type="text" readonly="readonly" id="middleName" value="${viewInformation.endUserDB.middleName}">
												</c:otherwise>
												</c:choose>
													
												</div>

												<div class="input-field col s12 m4 l4">
													<input type="text"readonly="readonly"  value="${viewInformation.endUserDB.lastName}"> 
													<label for="lastName"><spring:message code="input.lastName" /> <span class="star"></span>
													</label>
												</div>
												
												<div class="input-field col s12 m6" id="nationalityDiv"
											style="display: block">
											<input type="text" id="nationality" readonly="readonly" name="nationality" value="${viewInformation.endUserDB.nationality}"> <label for="nationality" class=""><spring:message
													code="input.Nationality" /></label>
										</div>
										<c:choose>
												<c:when test = "${viewInformation.endUserDB.nationality=='Cambodian'}">
										<div class="input-field col s12 m6" id="entryCountryDiv" style="display: none;">
												<input type="text" readonly="readonly" id="datepicker" value="${viewInformation.endUserDB.entryDateInCountry}" /> <label for="datepicker"><spring:message
														code="input.EntryCountry" /> <span class="star"></span></label>
									</div>
									</c:when>
									<c:otherwise>
									<div class="input-field col s12 m6" id="entryCountryDiv" style="display: block;">
												<input type="text" readonly="readonly" class="active" id="datepicker" value="${viewInformation.endUserDB.entryDateInCountry}" /> <label for="datepicker"><spring:message
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
														 value="${viewInformation.endUserDB.propertyLocation}" class="form-control boxBorder boxHeight" id="address">
													<label for="address"><spring:message code="input.address" /> <span
														class="star"></span></label>
												</div>

												<div class="input-field col s12 m6 l6">
													<input type="text" readonly="readonly"
														value="${viewInformation.endUserDB.street}"
														class="form-control boxBorder boxHeight" id="streetNumber"
														maxlength="20" required/> <label
														for="streetNumber"> <spring:message code="input.streetNumber" /> <span
														class="star"></span>
													</label>
												</div>
													<div class="input-field col s12 m6 l6">
													<c:choose>
												<c:when test = "${viewInformation.endUserDB.village=='' || viewInformation.endUserDB.village==null}">
													<input type="text" readonly="readonly" value="NA"
														class="form-control boxBorder boxHeight" 
														maxlength="30" required/>
													</c:when>
													<c:otherwise>
													<input type="text" readonly="readonly" value="${viewInformation.endUserDB.village}"
														class="form-control boxBorder boxHeight" 
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
												<c:when test = "${viewInformation.endUserDB.locality=='' || viewInformation.endUserDB.locality==null}">
													<input type="text" readonly="readonly" value="NA"
														class="form-control boxBorder boxHeight" 
														maxlength="30" required/>
														</c:when>
														<c:otherwise>
														<input type="text" readonly="readonly" value="${viewInformation.endUserDB.locality}"
														class="form-control boxBorder boxHeight" 
														maxlength="30" required/>
														</c:otherwise>
														</c:choose>
														 <label
														for="locality"> <spring:message code="input.locality" /> <span class="star"></span>
													</label>
												</div>

													<div class="input-field col s12 m6 l6">
													<input type="text" readonly="readonly" value="${viewInformation.endUserDB.district}"
														class="form-control boxBorder boxHeight" id="district"
														maxlength="30" required> <label
														for="district"> <spring:message code="input.district" /> <span
														class="star"></span>
													</label>
												</div>
												<div class="input-field col s12 m6 l6">
													<input type="text" readonly="readonly" value="${viewInformation.endUserDB.commune}"
														class="form-control boxBorder boxHeight" id="commune"
														maxlength="30" required/> <label
														for="commune"> <spring:message code="input.commune" /> <span
														class="star"></span>
													</label>
												</div>
												<div class="input-field col s12 m6 l6">
													
													<input type="text" readonly="readonly"
														class="form-control boxBorder boxHeight" id="postalcode"
														maxlength="6"  value="${viewInformation.endUserDB.postalCode}" required/> <label
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
														 <input type="text" readonly="readonly" value="${viewInformation.endUserDB.country}">
												</div>

												<div class="input-field col s12 m6 l6">
													<p
														style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
													<spring:message code="input.province" /> <span class="star"></span>
													</p>
													<input type="text" readonly="readonly"  value="${viewInformation.endUserDB.province}">
												<%-- 	<select id="state" class="browser-default" class="mySelect" disabled="disabled"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													title= "<spring:message code="validation.selectFieldMsg" />"
														style="padding-left: 0;" required></select> --%>
												</div>
											</div>

											<div class="col s12 m12" style="margin-top: 10px;">
												<div class="col s12 m6 l6">
												 <label for="email"><spring:message code="input.email" /><span
														class="star"></span></label>
														<c:choose>
												<c:when test = "${viewInformation.endUserDB.email=='' || viewInformation.endUserDB.email==null}">
														<input type="email" readonly="readonly" 
														 value="NA">
														 </c:when>
														 <c:otherwise>
														 <input type="email" readonly="readonly" 
														 value="${viewInformation.endUserDB.email}">
														 </c:otherwise>
														 </c:choose>
												</div>

												<div class="input-field col s12 m6 l6" style="margin-top: 18px;">
													<input type="text" readonly="readonly"
														pattern="[0-9]{10,10}"  value="${viewInformation.endUserDB.phoneNo}" > <label for="phone"><spring:message code="input.contactNum" /><span class="star"></span>
													</label>
												</div>
											</div>
											
											<div class="col s12 m12" style="height: 4rem;">
											<label for="nationality"><spring:message
													code="input.VIP" /> </label>
											<div class=" boxHeight">
												 <c:choose>
												<c:when test = "${viewInformation.endUserDB.isVip=='Y'}">
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
												 
												<input class="with-gap" type="radio" name="selectvip" disabled value="Y"  >
												 <span><spring:message code="modal.yes" /></span>
												
												  </label>
												  <label> 
												  <input class="with-gap" value="N" type="radio" disabled="disabled" readonly="readonly" checked="checked"
													name="selectvip" style="margin-left: 20px;" /> <span><spring:message code="modal.no" /></span>
												</label>
												</c:otherwise>
												</c:choose>
											</div>
										</div>
										<div class="row" style="display: none;" id="vipUserDiv">
											<div class="input-field col s12 m6">
												<input type="text" id="departmentName" readonly="readonly" value="${viewInformation.endUserDB.userDepartment.name}"/> 
												<label for="departmentName"><spring:message
														code="input.DepartmentName" /> <span class="star"></span></label>
											</div>

											<div class="input-field col s12 m6">
												<input type="text" id="endUserdepartmentID" readonly="readonly" value="${viewInformation.endUserDB.userDepartment.departmentId}" />
												 <label for="endUserdepartmentID"><spring:message
														code="input.DepartmentID" /><span class="star"></span> </label>
											</div>

											<div class="file-field input-field col s12 m6 l6">
												 <h6 style="color: #000;">
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
													<input class="file-path validate" type="text" readonly="readonly" value="${viewInformation.endUserDB.userDepartment.departmentFilename}"
													  id="endUSerNidaPlaceholder">
													<a	class="imgPreviewLink" onclick="previewFile('${fileLink}','${viewInformation.endUserDB.userDepartment.departmentFilename}','${viewInformation.endUserDB.txnId}')"><spring:message code="input.preView" /></a>	
												</div>
											</div>
										</div>
										
								<div class="col s12 m12" style="height: 4rem; display: block "id="askVisaDetails">
											<label for="nationality"><spring:message
													code="input.AddVisa" /> <span class="star"></span></label>
											<div class=" boxHeight">
												<c:choose>
												<c:when test = "${viewInformation.endUserDB.onVisa=='Y'}">
												<label><input class="with-gap" type="radio" disabled="disabled"
													name="onVisa" value="Y" checked="checked">
													<span><spring:message code="modal.yes" /></span> </label> <label>
													<input class="with-gap" type="radio" id="onVisaNo" disabled="disabled"
													 name="onVisa" value="N"
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
											<c:forEach items="${viewInformation.endUserDB.visaDb}" var="list">
											<div class="col s12 m6">
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

											<div class="file-field input-field col s12 m6">
												<h6 style="color: #000;">
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
													<a	class="imgPreviewLink" onclick="previewFile('${fileLink}','${list.visaFileName}','${viewInformation.endUserDB.txnId}')"><spring:message code="input.preView" /></a>
														
														
												</div>
											</div>
											</c:forEach>
										</div>
										</div>
									
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
															class="star"></span></label>
															<c:choose>
												<c:when test = "${viewInformation.deviceTypeInterp=='' || viewInformation.deviceTypeInterp==null}">
															<input type="text" value="NA" readonly="readonly">
												</c:when>
												<c:otherwise>
											<input type="text" value="${viewInformation.deviceTypeInterp}" readonly="readonly">
												</c:otherwise>	
											</c:choose>
													</div>

													<div class="col s12 m6">
														<label for="deviceIdType1"><spring:message code="select.deviceIDType" /><span
															class="star"></span></label> 
															<input type="text" value="${viewInformation.deviceIdTypeInterp}" readonly="readonly">
													</div>

													<div class="col s12 m6">
														<label for="multipleSimStatus1"><spring:message code="select.multiSimStatus" /><span class="star"></span>
														</label>
														<c:choose>
												<c:when test = "${viewInformation.multiSimStatus=='' || viewInformation.multiSimStatus==null}">
														 <input type="text" value="NA" readonly="readonly">
												</c:when>
												<c:otherwise>
												<input type="text" value="${viewInformation.multiSimStatus}" readonly="readonly">
												</c:otherwise>
												</c:choose>
													</div>

													<div class="col s12 m6">
														<label for="country1"><spring:message code="select.countryBoughtFrom" /><span
															class="star"></span></label> 
														<c:choose>
												<c:when test = "${viewInformation.country=='' || viewInformation.country==null}">
															<input type="text" value="NA" readonly="readonly">
												</c:when>
												<c:otherwise>
												<input type="text" value="${viewInformation.country}" readonly="readonly">
												</c:otherwise>
												</c:choose>
												
													</div>

													<div class="col s12 m6"
														style="">
														<label for="serialNumber1"> <spring:message code="input.deviceSerialNumber" /><span class="star"></span>
														</label>
														<c:choose>
												<c:when test = "${viewInformation.deviceSerialNumber=='' || viewInformation.deviceSerialNumber==null}">
														<input type="text" value="NA" readonly="readonly">
												</c:when>
												<c:otherwise>
												<input type="text" value="${viewInformation.deviceSerialNumber}" readonly="readonly">
												</c:otherwise>
												</c:choose>		 
													</div>

													<div class="col s12 m6">
														<label for="taxStatus1"><spring:message code="select.taxPaidStatus" /><span
															class="star"></span></label> 
															<c:choose>
												<c:when test = "${viewInformation.taxPaidStatusInterp=='' || viewInformation.taxPaidStatusInterp==null}">
															<input type="text" readonly="readonly" value="NA">
															</c:when>
															<c:otherwise>
															<input type="text" readonly="readonly" value="${viewInformation.taxPaidStatusInterp}">
															</c:otherwise>
															</c:choose>
															
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m6">
														<label for="deviceStatus1"><spring:message code="select.deviceStatus" /><span
															class="star"></span></label> 
														<c:choose>
												<c:when test = "${viewInformation.deviceStatusInterp=='' || viewInformation.deviceStatusInterp==null}">
														<input type="text" readonly="readonly" value="NA">	
													</c:when>
													<c:otherwise>
													<input type="text" readonly="readonly" value="${viewInformation.deviceStatusInterp}">
													</c:otherwise>
													</c:choose>
													</div>
                                                      <c:choose>
												<c:when test = "${viewInformation.endUserDB.onVisa=='N'}">
													<div class="col s12 m6 l6">
														<label for="Price1"><spring:message code="select.price" /></label>
														<c:choose>
												<c:when test = "${viewInformation.price=='' || viewInformation.price==null}">
														<input type="text" id="Price1" value="NA" readonly="readonly">
														</c:when>
														<c:otherwise>
														<input type="text" id="Price1" value="${viewInformation.price}" readonly="readonly">
														</c:otherwise>
														</c:choose>
													</div>

													<div class="col s12 m6">
														<label for="Currency1" class="active"><spring:message code="input.currency" /><span class="star"></span></label>
														<c:choose>
												<c:when test = "${viewInformation.currencyInterp=='' || viewInformation.currencyInterp==null}">
														<input type="text" value="NA" readonly="readonly">
														</c:when>
														<c:otherwise>
														<input type="text" value="${viewInformation.currencyInterp}" readonly="readonly">
														</c:otherwise>
														</c:choose>
													</div>
													</c:when>
													<c:otherwise>
													
													</c:otherwise>
													</c:choose>
													
													<div class="input-field col s12 m12">
																	<c:choose>
															<c:when test = "${viewInformation.deviceRemark=='' || viewInformation.deviceRemark==null}">
															<textarea id="singleDeviceRemark"  readonly="readonly"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																 class="materialize-textarea">NA</textarea>
																</c:when>
																<c:otherwise>
																<textarea id="singleDeviceRemark" readonly="readonly"  
																oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
																maxlength="10000" class="materialize-textarea">${viewInformation.deviceRemark}</textarea>
																</c:otherwise>
																</c:choose>
																
															<label for="textarea1"> <spring:message
																	code="input.remarksLawfull" /></label>
														</div>
												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class='col s12 m12 input_fields_wrap'>
														<p><spring:message code="title.imeiMeidEsn" /></p>
														<div class='row'>
															<div class="input-field col s12 m6">
																<input type="text" value="${viewInformation.firstImei}" readonly="readonly">
																 <label for="IMEIA1"><spring:message code="title.one" /><span
																	class="star"></span></label>
															</div>
															<div class="input-field col s12 m6">
																<c:choose>
												<c:when test = "${viewInformation.secondImei=='' || viewInformation.secondImei==null}">
																<input type="text" value="NA" readonly="readonly">
																</c:when>
																<c:otherwise>
																<input type="text" value="${viewInformation.secondImei}" readonly="readonly">
																</c:otherwise>
																</c:choose>
																 <label for="IMEIB1" class="Active"><spring:message code="title.two" /></label>
															</div>

															<div class="input-field col s12 m6">
															<c:choose>
												                 <c:when test = "${viewInformation.thirdImei=='' || viewInformation.thirdImei==null}">
																<input type="text" value="NA" readonly="readonly">
																</c:when>
																<c:otherwise>
																<input type="text" value="${viewInformation.thirdImei}" readonly="readonly">
																</c:otherwise>
																</c:choose>
																 <label for="IMEIC1" class="Active"><spring:message code="title.three" /></label>
															</div>

															<div class="input-field col s12 m6" id="field">
																<c:choose>
												                 <c:when test = "${viewInformation.fourthImei=='' || viewInformation.fourthImei==null}">
																<input type="text" value="NA" readonly="readonly">
																</c:when>
																<c:otherwise>
																<input type="text" value="${viewInformation.fourthImei}" readonly="readonly">
																</c:otherwise>
																</c:choose>
																 <label for="IMEID1" class="Active"><spring:message code="title.four" /></label>
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
										<button type='button' class="btn"  id="redirectToPage"
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

<%-- 	<div id="addDevice" class="modal">
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
	</div> --%>
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

	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
			<!--plugins.js - Some Specific JS codes for Plugin Settings-->
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

			<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<!-- ================================================
    Scripts
    ================================================ -->

<script type="text/javascript">
$('#redirectToPage').click(function(){
	var nationalID=$('#nationalID').val();
var userType= $("body").attr("data-roleType");
var txnID= $("body").attr("data-txnid-value");
var source= $("body").attr("data-source-value");
var viewall=sessionStorage.getItem("ViewAll");

sessionStorage.removeItem("ViewAll");
if (source=='menu'){
	txnID='';
}
else if (source=='dashboard'){
	txnID='';
}
else if(source=='filter'){
	txnID='';
	source='menu'
}



   if(userType=="CEIRAdmin")
	   {
	   window.location.replace("${context}/uploadPaidStatus?txnID="+txnID+"&source="+source);
	   }
 
   else{
	 if(viewall=="ViewAll"  )  {
		 
		 window.location.replace("${context}/uploadPaidStatus?via=other&txnID="+txnID+"&source="+source);
		 }
	 else if(source=="dashboard"){
	
		 window.location.replace("${context}/uploadPaidStatus?via=other&txnID="+txnID+"&source="+source);
	 }
		
	 
	 else{
			var enterdNid = nationalID.replace("#", "%23");
			
		 window.location.replace("${context}/uploadPaidStatus?via=other&NID="+enterdNid+"&txnID="+txnID+"&source="+source);	 
	 }
	  
       }
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
 $("label[for='middleName']").addClass('active');

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