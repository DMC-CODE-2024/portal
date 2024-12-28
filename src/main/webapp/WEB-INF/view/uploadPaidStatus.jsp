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
<!--<title>Upload Paid Status</title>-->
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
	href="${context}/resources/project_css/intlTelInput.css">

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


.disable {
    color: grey;
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

/* .dataTables_scrollBody {
    height: 100px !important;
} */
.dataTables_scrollBody {
    width: 100%;
    max-height: 400px !important;

   height: auto !important;


}
.dataTables_scroll {
    margin-top: 2px;
}
button.modal-action.modal-close.waves-effect.waves-green.btn-flat.right {
   height: 36px;
	 font-size: 31px
}
.header-fixed-style{
width: inherit;
z-index: 1003;
position: fixed;
}
</style>
</head>
<body data-id="12" data-roleType="${usertype}" data-username="${username}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnIdv}"
	data-selected-consignmentStatus="${consignmentStatus}" 
	session-value="${not empty param.NID ? param.NID : 'null'}"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}"
	data-filterSource="${filterSource}" data-userStatus="${userStatus}">


	<!-- //////////////////////////////////////////////////////////////////////////// -->

	<!-- START CONTENT -->
	<section id="content">
			<div id="initialloader"></div>
		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12" id="emptyTable">
						<div class="row card-panel">

							<div class="container-fluid pageHeader" id="pageHeader">
								<p class="PageHeading">
										<spring:message code="sidebar.Register_Device" />
									</p>
								<a href="" class="boton right" id="btnLink"></a>
							</div>

							<div class="row">
					

								<div id="user123" class="section" style="display: none;">
									<form action="" onsubmit="return submitDeviceInfo()"
										method="POST" enctype="multipart/form-data">
										<div class="row">
											<div class="col s12 m12">
												<div class="col s12 m12">
													<h5><spring:message code="input.personalInformation" /></h5>
													<hr>
												</div>
											</div>
											<div class="col s12 m12">
										<label for="nationality" id="nationalityLabelId"><spring:message
												code="input.Nationality" /> <span class="star">*</span></label>
										<div class=" boxHeight" id="chooseUserOption">
											<label><input class="with-gap"
												name="selectUSerViseForm" type="radio"
												onclick="showCambodianUserForm()" checked> <span><spring:message
														code="input.Cambodian" /></span> </label> <label> <input
												class="with-gap" type="radio" name="selectUSerViseForm"
												style="margin-left: 20px;" onclick="showOtherUserForm()" />
												<span><spring:message code="input.Other" /></span>
											</label>
										</div>
									</div>
											<div class="col s12 m12" style="margin-top: 20px;">
												<div class="input-field col s12 m4">
													<input type="text" id="nationalID" pattern="<spring:eval expression="@environment.getProperty('pattern.operatorNid')" />" 
													oninput="InvalidMsg(this,'input','<spring:message code="validation.12Character" />');"
											        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.12Character" />');"
													 required  name="nationalID" placeholder="" disabled="disabled" value="" /> <label for="nationalID" id="nidLabelName"
														class="center-align ml-10"><spring:message code="input.nid" /> <span class="star">*</span> </label>
												</div>

													<div class="col s12 m4" style="margin-top: -10px;">
															<label for="deviceType"><spring:message code="input.documenttype" /> <span
																class="star">*</span></label> <select class="browser-default"
																id="doc_type" 
																oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
											                    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');" required>
																<option value="" disabled selected><spring:message code="select.documenttype" /> </option>
															</select>
															
															<!-- <input type="text" id="docTypeNymericValue" style="display: none" > -->
														</div>	

												<div class="file-field col s12 m4"
													style="margin-top: -15px;">
													<h6 style="color: #000;" id="uploadNidImage"><spring:message code="input.supportingdocument" /> <span class="star">*</span>
													</h6>
													<div class="btn">
														<span><spring:message code="input.selectfile" /></span> <input type="file"
														oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
											oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														 onchange="isImageValid('csvUploadFile')"
														title= "<spring:message code="validation.NoChosen" />" required id="csvUploadFile" accept="*image">
													</div>
													<div class="file-path-wrapper">
														<input class="file-path validate responsive-file-div" id="csvUploadFileName"
															type="text">
													</div>
												</div>
											</div>
											<div class="col s12 m12">
												<div class="input-field col s12 m4 l4">
													<input type="text" name="firstName" id="firstName"
														required="required"
														pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
														 required>
													<label for="firstName" class="center-align"><spring:message code="input.firstName" /> <span class="star">*</span>
													</label>
												</div>

												<div class="input-field col s12 m4 l4">
													<input type="text" name="middleName" id="middleName"
														pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
														>
													<label for="middleName"><spring:message code="input.middleName" /></label>
												</div>

												<div class="input-field col s12 m4 l4">
													<input type="text" name="lastName" id="lastName"
														pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
														title= "<spring:message code="validation.20Character" />"  
														> <label for="lastName"><spring:message code="input.lastName" /> <span class="star"></span>
													</label>
												</div>
												<div class="input-field col s12 m6" id="nationalityDiv"
											style="display: none">
											<%-- <input type="text" id="nationality" name="nationality"
												pattern="[a-zA-Z]{1,25}" oninput="InvalidMsg(this,'input');"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												title="" maxlength="25"> --%>
												<p style="margin-top: -18px; margin-bottom: -3px; font-size: 12px;">
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
										<div class="input-field col s12 m6" id="entryCountryDiv" style="display: none;">
												<input type="text" id="datepicker"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													 maxlength="15" /> <label for="datepicker"><spring:message
														code="input.EntryCountry" /> <span class="star">*</span></label>
									</div>
											</div>
										</div>

										<div class="row">
											<div class="col s12 m12">
												<div class="input-field col s12 m12 l12">
													<input type="text" name="address"
														pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
														 maxlength="200" required
														class="form-control boxBorder boxHeight" id="address">
													<label for="address"><spring:message code="input.address" /> <span
														class="star">*</span></label>
												</div>
												
												
												<div class="input-field col s12 m6 l6">
													<p
														style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
														<spring:message code="table.country" /> <span class="star">*</span>
													</p>
													<select id="country" class="browser-default" disabled="disabled"
														class="mySelect"
														oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											            oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
														title= "<spring:message code="validation.selectFieldMsg" />"
														 style="padding-left: 0; color: rgb(53, 52, 52);" required></select>
												</div>

												<div class="input-field col s12 m6 l6">
													<p
														style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
													<spring:message code="input.province" /> <span class="star">*</span>
													</p>
													<select id="state" class="browser-default" class="mySelect"
													onchange="getDistrict(this,'district','commune');"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													title= "<spring:message code="validation.selectFieldMsg" />"
														style="padding-left: 0; color: rgb(53, 52, 52);" required></select>
												</div>
												
												<div class="col s12 m6 l6">
													<%-- <input type="text" pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
														 name="streetNumber"
														class="form-control boxBorder boxHeight" id="district"
														maxlength="30" required> --%> <label
														for="district"> <spring:message code="input.district" /> <span
														class="star">*</span>
														 <select
										id="district" class="browser-default" class="mySelect"
										onchange="getCommune(this,'commune','village');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0; font-size: 14.5px;  color: rgb(53, 52, 52);" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
													</label>
												</div>
												<div class=" col s12 m6 l6">
													<%-- <input type="text" pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
														 name="streetNumber"
														class="form-control boxBorder boxHeight" id="commune"
														maxlength="30" required/> --%> <label
														for="commune"> <spring:message code="input.commune" /> <span
														class="star">*</span>
													</label>
													<select
										id="commune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'village');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0; font-size: 14.5px;" required>
										<option value=""><spring:message code="select.commune" /></option>
										</select>
												</div>
												<div class=" col s12 m6 l6">
													<%-- <input type="text" pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
														name="streetNumber"
														class="form-control boxBorder boxHeight" id="village"
														maxlength="30" /> --%> <label
														for="village"> <spring:message code="input.village" /> <span
														class="star"></span>
														<select
										id="village" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;font-size: 14.5px;color: rgb(53, 52, 52);" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
													</label>
												</div>
												<div class="input-field col s12 m6 l6">
													<input type="text" pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
														 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
														title= "<spring:message code="validation.20Character" />"
														name="streetNumber"
														class="form-control boxBorder boxHeight" id="streetNumber"
														 required/> <label
														for="streetNumber"> <spring:message code="input.streetNumber" /> <span
														class="star">*</span>
													</label>
												</div>
													
												

												<div class="input-field col s12 m6 l6" style="margin-left:1px;">
													<input type="text" name="locality"
														pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
														
														class="form-control boxBorder boxHeight" id="locality"
														 /> <label
														for="locality"> <spring:message code="input.locality" /> <span class="star"></span>
													</label>
												</div>

													
												<div class="input-field col s12 m6 l6" style="margin-right: -1px;">
													
													<input type="text"
															pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.postalcode" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.postalcode" />');"
														title= "<spring:message code="validation.postalcode" />" name="streetNumber"
														class="form-control boxBorder boxHeight" id="postalcode"
														 /> <label
														for="postalcode"> <spring:message code="input.postalCode" /> <span
														class="star"></span>
													</label>
												</div>
												
											</div>

											<div class="col s12 m12" style="margin-top: 10px;">
												<div class="input-field col s12 m6 l6">
														<input type="email" name="email" id="email" pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.emial" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.emial" />');"
														title= "<spring:message code="validation.emial" />"> <label for="email"><spring:message code="input.email" /><span
														class="star"></span></label>
												</div>

												<div class="input-field col s12 m6 l6" style="margin-top: 18px;">
													<input type="tel" name="phone" 
													
														pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
														oninput="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
														title= "<spring:message code="validation.10digits" />" required  class="form-control boxBorder boxHeight" id="phone"
														> <label for="phone"><spring:message code="input.contactNum" /><span class="star">*</span>
													</label>
												</div>
											</div>
																					<div class="col s12 m12" style="height: 4rem;">
											<label for="nationality"><spring:message
													code="input.VIP" /> </label>
											<div class=" boxHeight">
												<label><input class="with-gap" type="radio"
													name="selectvip" value="Y" onclick="selectVip()"> <span><spring:message
															code="modal.yes" /></span> </label> <label> <input
													class="with-gap" value="N" type="radio" checked="checked"
													name="selectvip" style="margin-left: 20px;"
													onclick="removeSelectVip()" /> <span><spring:message
															code="modal.no" /></span>
												</label>
											</div>
										</div>

										<div class="row" style="display: none;" id="vipUserDiv">
											<div class="input-field col s12 m6">
												<input type="text" id="departmentName"
												
													pattern="<spring:eval expression="@environment.getProperty('pattern.departmentName')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.department" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.department" />');"
													  /> <label for="departmentName"><spring:message
														code="input.DepartmentName" /> <span class="star">*</span></label>
											</div>

											<div class="input-field col s12 m6">
												<input type="text" id="endUserdepartmentID"
													pattern="<spring:eval expression="@environment.getProperty('pattern.departmentID')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.departmentID" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.departmentID" />');"
													 /> <label for="endUserdepartmentID"><spring:message
														code="input.DepartmentID" /><span class="star">*</span> </label>
											</div>

											<div class="file-field input-field col s12 m6 l6">
												<h6 style="color: #000;">
													<spring:message code="input.UploadIDImage" />
													<span class="star">*</span>
												</h6>
												<div class="btn">
													<span><spring:message code="operator.file" /></span> <input
														type="file" accept="image/*"
														onchange="deptImageValidation()"
														oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														 id="endUserDepartmentId" 
														placeholder="">
												</div>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text"
														id="endUSerNidaPlaceholder"
														placeholder="<spring:message code="validation.deptPlaceholder" />">
														
												</div>
											</div>
										</div>

										<div class="col s12 m12" style="height: 4rem; display: none"
											id="askVisaDetails">
											<label for="nationality"><spring:message
													code="input.AddVisa" /> <span class="star">*</span></label>
											<div class=" boxHeight">
												<label><input class="with-gap" type="radio"
													name="onVisa" value="Y" onclick="showVisaDetails()">
													<span><spring:message code="modal.yes" /></span> </label> <label>
													<input class="with-gap" type="radio" id="onVisaNo"
													checked="checked" name="onVisa" value="N"
													style="margin-left: 20px;" onclick="hideVisaDetails()" />
													<span><spring:message code="modal.no" /></span>
												</label>
											</div>
										</div>

										<div class="row" id="visaDetails" style="display: none;">
											<div class="col s12 m6">
												<label for="visaType"><spring:message
														code="input.VisaType" /> <span class="star">*</span></label> <select
													class="browser-default" id="visaType"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
													 style="height: 33px">
													<option value="" disabled selected><spring:message
															code="input.SelectVisaType" /></option>

												</select>
											</div>

											<!-- <div class="input-field col s12 m6">
                                                    <input type="text" id="bdate2" class="datepicker" name="entryDate"
                                                        pattern="[]" title="" maxlength="20" />
                                                    <label for="bdate2">Entry Date In Country <span
                                                            class="star">*</span></label>
                                                </div> -->

											

											<div class="input-field col s12 m6">
												<input type="text" id="visaNumber" 
													pattern="<spring:eval expression="@environment.getProperty('pattern.departmentID')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.departmentID" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.departmentID" />');"
													/> <label for="visaNumber"><spring:message
														code="input.VisaNumber" /> <span class="star">*</span></label>
											</div>

											<!-- <div class="input-field col s12 m6">
                                                    <input type="text" id="bdate" class="datepicker" name="expiryDate"
                                                        pattern="[]" title="" maxlength="15" />
                                                    <label for="bdate">Visa Expiry Date <span
                                                            class="star">*</span></label>
                                                </div> -->

											<div class="input-field col s12 m6">
												<input type="text" id="datepicker1"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													 maxlength="15" /> <label for="datepicker1"><spring:message
														code="input.VisaExpiry" /> <span class="star">*</span></label>
											</div>

											<div class="file-field input-field col s12 m6">
												<h6 style="color: #000;">
													<spring:message code="input.UploadVisa" />
													<span class="star">*</span>
												</h6>
												<div class="btn">
													<span><spring:message code="operator.file" /></span> <input
														type="file" id="visaImage" accept="image/*"
														oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														onchange="visaImageValidation()"
														oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
														 placeholder="">
												</div>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text"
														id="ensUserVisaPlaceHolder"
														placeholder="<spring:message code="validation.visaPlaceholder" />">
													
														
														
												</div>
											</div>
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
															<label for="deviceType1"><spring:message code="select.deviceType" /> <span
																class="star"></span></label> <select class="browser-default"
																id="deviceType1" 
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																title= "<spring:message code="validation.selectFieldMsg" />">
																<option value=""  selected><spring:message code="select.selectDeviceType" /></option>


															</select>
														</div>

														<div class="col s12 m6">
															<label for="deviceIdType1"><spring:message code="select.deviceIDType" /> <span
																class="star">*</span></label> <select 
																class="browser-default" id="deviceIdType1"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																title= "<spring:message code="validation.selectFieldMsg" />" required>
																<option value="" disabled selected><spring:message code="select.selectDeviceIDType" /></option>

															</select>
														</div>

														<div class="col s12 m6">
																			<label for="multipleSimStatus1"><spring:message code="registration.selectMultiplestLawfull" /> <span class="star">*</span>
															</label> <select class="browser-default"  onchange="setContactIMEINumber('multipleSimStatus1','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required="required"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																title= "<spring:message code="validation.selectFieldMsg" />" id="multipleSimStatus1">
																<option value=""  selected><spring:message code="select.select" />
															</select>
														</div>

														<div class="col s12 m6">
															<label for="country1"><spring:message code="select.countryBoughtFrom" /> <span
																class="star"></span></label> <select id="country1"
																class="browser-default" class="mySelect"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																title= "<spring:message code="validation.selectFieldMsg" />" style="padding-left: 0;"></select>
														</div>

														<div class="input-field col s12 m6"
															style="margin-top: 23px;">
															<input type="text" id="serialNumber1"  name="serialNumber"
															pattern="<spring:eval expression="@environment.getProperty('pattern.serialNumber')" />"
																oninput="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
																title= "<spring:message code="validation.15serialNo" />"
																> <label for="serialNumber1"> <spring:message code="input.deviceSerialNumber" /> <span class="star"></span>
															</label>
														</div>

														<div class="col s12 m6" id="taxStatusDiv">
															<label for="taxStatus1"><spring:message code="select.taxPaidStatus" /> <span
																class="star">*</span></label> <select class="browser-default"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																required="required" id="taxStatus1">
																<option value="" disabled selected><spring:message code="select.selectTaxPaidStatus" /></option>

															</select>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col s12 m12">
														<div class="col s12 m6" style="margin-top: -10px;">
															<label for="deviceStatus1"><spring:message code="select.deviceStatus" /> <span
																class="star">*</span></label> <select class="browser-default"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																title= "<spring:message code="validation.selectFieldMsg" />"required id="deviceStatus1">
																<option value="" disabled selected><spring:message code="select.selectDeviceStatus" /></option>

															</select>
														</div>

														<div class="input-field col s12 m6 l6" id="priceDiv">
															<input type="text" name="Price" id="Price1"
																pattern="^\d+(?:\.\d{1,2})?$" maxlength="9"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
																title= "<spring:message code="validation.7digits" />" >
															<label for="Price1"><spring:message code="select.price" /></label>
														</div>

														<div class="col s12 m6" id="CurrencyDiv" style="display: none;">
															<label for="Currency1"><spring:message code="input.currency" /> <span
																class="star">*</span></label> <select class="browser-default"
																id="Currency1" 
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																title= "<spring:message code="validation.selectFieldMsg" />" > 
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
																	pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />" 
																		oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
											                            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																		title= "<spring:message code="validation.1516digit" />" required 
																		> <label for="IMEIA1"><spring:message code="title.one" />
																		 <span class="star">*</span>
																	</label><p id="errorMsgOnModal" class="deviceErrorTitle" style="margin-left: 45%;"></p>
																</div></div>
                                                              <div id="IMEIndContact2" style="display: none">
																<div class="input-field col s12 m6">
																	<input type="text" id="IMEIB1" name="IMEI2" 
																		pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />" 
																		oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
											                            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																		title= "<spring:message code="validation.1516digit" />" 
																		 > <label for="IMEIB2"><spring:message code="title.two" /></label>
																</div></div>
																<div id="IMEIndContact3" style="display: none">		
																<div class="input-field col s12 m6">
																	<input type="text" id="IMEIC1" name="IMEIC3" 
																		pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />" 
																		oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
											                            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																		title= "<spring:message code="validation.1516digit" />"
																		 > <label for="IMEIC1"><spring:message code="title.three" /></label>
														<!-- <p id="errorMsgOnModal" class="deviceErrorTitle" style="margin-top:-146px;margin-left:115px;"></p> -->
																</div></div>
																	<div id="IMEIndContact4" style="display: none">
																<div class="input-field col s12 m6" id="field">
																	<input type="text" id="IMEID1" name="IMEID4[]" 
																		pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />" 
																		oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
											                            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
																		title= "<spring:message code="validation.1516digit" />"
																		  id="field0"> <label
																		for="IMEID1"><spring:message code="title.four" /></label>
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
												<span style="font-size: 20px;">+</span>  <spring:message code="button.addMoreDevice" />
											</button> --%>
											<p>
												 <spring:message code="input.requiredfields" /> <span class="star">*</span>
											</p>
										</div>
										<div class="col s12 m12 center" style="margin-top: 30px;">
											<button class="btn " id="uploadPaidStatusbutton" type="submit"><spring:message code="button.submit" /></button>
											<a  href='./uploadPaidStatus?FeatureId=12' class="btn"
												style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
										</div>


									</form>
								</div>

								<div id="profile-page" class="section">
								
									<div class="container" id="user456" style="display: none;">
										<form action="${context}/uploadPaidStatus" id="viewRegisterDeviceFilter">
										<div class="registrationTableDiv_box" id="tableDiv"
											style="padding-bottom: 5px; background-color: #e2edef52;">
										</div>
											<div id="filterBtnDiv"></div>
											<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>
										</form>
									
							
										<div class="row">
											<div class="col s12 m12">
												<table class="responsive-table striped display"
													id="data-table-simple" cellspacing="0">

												</table>

												<a href="Javascript:void(0);" onclick="viewDeviceHistory()" style="display: none"><spring:message code="modal.header.viewBlockDevices" /></a>
											</div>
										</div>
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
	<!-- END CONTENT -->




	<!-- Modal start   -->

	<div id="viewBlockDevices" class="modal" style="width: 75%;">
		<button type="button"
			class=" modal-action modal-close waves-effect waves-green btn-flat right"
			data-dismiss="modal">&times;</button>
		<h6 class="modal-header"><spring:message code="modal.header.viewBlockDevices" /></h6>
		
		<div class="modal-content">

			<div class="row">
				<table class="responsive-table striped display"
					id="data-table-history" cellspacing="0">
				</table>
			</div>
		</div>
	</div>
	<!-- Modal End -->



	<!-- Modal start   -->

	<div id="deleteMsg" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.delete" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6><spring:message code="modal.deleteDeviceInfo" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<button class="btn" onclick="accept()"><spring:message code="modal.yes" /></button>
					<button class="modal-close btn" type="reset" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->



	<!-- Modal 2 start   -->

	<div id="viewDeviceInformation" class="modal">
		<h6 class="modal-header"><spring:message code="modal.viewDeviceInfo" /></h6>
		<div class="modal-content">

			<div class="row">
				<div class="row">
					<div class="input-field col s12 m6 l6">
						<input type="text" name="deviceType" id="viewdeviceType"
							placeholder="" maxlength="30" disabled
							style="height: 28px;"> <label for="viewdeviceType"><spring:message code="select.deviceType" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" name="deviceIdType" id="viewdeviceIdType"
							placeholder="" maxlength="30" disabled style="height: 28px;">
						<label for="viewdeviceIdType"><spring:message code="select.deviceIDType" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" name="simStatus" id="viewsimStatus"
							placeholder="" maxlength="30" disabled style="height: 28px;">
						<label for="viewsimStatus"><spring:message code="select.multiSimStatus" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" name="countryBought" id="viewcountryBought"
							placeholder="" maxlength="30" disabled style="height: 28px;">
						<label for="countryBought"><spring:message code="select.countryBoughtFrom" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="viewserialNumber" name="serialNumber"
							placeholder="" maxlength="20" disabled style="height: 28px;">
						<label for="viewserialNumber"><spring:message code="input.deviceSerialNumber" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" name="taxStatus" id="viewtaxStatus"
							placeholder="" maxlength="30" disabled style="height: 28px;">
						<label for="viewtaxStatus"><spring:message code="select.taxPaidStatus" /></label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s12 m6 l6">
						<input type="text" name="deviceStatus" id="viewdeviceStatus"
							placeholder="" maxlength="30" disabled style="height: 28px;">
						<label for="viewdeviceStatus"><spring:message code="select.deviceStatus" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" name="Price" id="viewPrice" placeholder=""
							maxlength="30" disabled style="height: 28px;"> <label
							for="viewPrice"><spring:message code="select.price" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" name="currency" id="viewcurrency"
							placeholder="" maxlength="30" disabled style="height: 28px;">
						<label for="viewcurrency"><spring:message code="input.currency" /></label>
					</div>
				</div>

				<div class="row input_fields_wrap">
					<div class="col s12 m12">
						<p style="margin-bottom: 0; margin-top: -10px;"><spring:message code="title.imeiMeidEsn" /></p>
					</div>
					<div class="input-field col s12 m6">
						<input type="text" id="viewIMEI1" name="IMEI1"
							pattern="[0-9]{15,16}"
							oninput="InvalidMsg(this,'input');" oninvalid="InvalidMsg(this,'input');"
							title= "<spring:message code="validation.1516digit" />" required  
							maxlength="16" placeholder="" disabled style="height: 28px;">
						<label for="viewIMEI1"><spring:message code="title.one" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="viewIMEI2" name="IMEI2"
							pattern="[0-9]{15,16}"
							oninput="InvalidMsg(this,'input');" oninvalid="InvalidMsg(this,'input');"
							title= "<spring:message code="validation.1516digit" />"
							maxlength="16" placeholder="" disabled style="height: 28px;">
						<label for="viewIMEI2"><spring:message code="title.two" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="viewIMEI3" name="IMEI3"
							pattern="[0-9]{15,16}"
							oninput="InvalidMsg(this,'input');" oninvalid="InvalidMsg(this,'input');"
							title= "<spring:message code="validation.1516digit" />"
							maxlength="16" placeholder="" style="height: 28px;" disabled>
						<label for="viewIMEI3"><spring:message code="title.three" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" id="viewIMEI4" name="IMEI4[]" pattern="[15-9]"
						oninput="InvalidMsg(this,'input');" oninvalid="InvalidMsg(this,'input');"
							title= "<spring:message code="validation.1516digit" />"
							maxlength="16" placeholder="" style="height: 28px;" disabled>
						<label for="viewIMEI4"><spring:message code="title.four" /></label>
					</div>

					<div class="col s12 m12 center" style="margin-top: 10px;">
						<button class="btn modal-close" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->

	

	<div id="regularisedDevice" class="modal">
		<h6 class="modal-header"> <spring:message code="customRegisterDevice" /> </h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="sucessMessage">
					<spring:message code="modal.message.futureRef" /> <span id="dynamicTxnId"></span>
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" onclick="refreshContent();"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div id="payTaxModal" class="modal">
		<h6 class="modal-header"><spring:message code="modal.payTaxInfo" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6><spring:message code="modal.taxHasBeenPaid" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" onclick="taxPaidStatus()"><spring:message code="modal.yes" /></button>
						<button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="confirmDeleteMsg" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.delete" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="responseMsg"><spring:message code="modal.deviceInfoDeleted" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<button class="btn" onclick="refreshContent();"><spring:message code="modal.ok" /></button>
				</div>
			</div>
		</div>
	</div>

	<div id="payNowTaxPayment" class="modal">
		<h6 class="modal-header"><spring:message code="modal.addDeviceInfo" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="taxPaidMsg"><spring:message code="modal.deviceStatus" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" onclick="refreshContent()"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
<div id="approveInformation" class="modal" style="width: 40%; z-index: 1003; opacity: 1; transform: scaleX(1); top: 10%;">
        <h6 class="modal-header"><spring:message code="modal.header.approve" /></h6>
        <div class="modal-content">
            <div class="row">
                <form action="">
                   
                    <h6> <spring:message code="modal.approveRequest" /><span id="approveTxnId"></span> ?</h6>
                </form>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a onclick="aprroveDevice()" class="btn modal-trigger"><spring:message code="modal.yes" /></a>
                    <button class="btn modal-close" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
                      <span id="userId" hidden></span>
                       <span id="adminCurrentStatus" hidden></span>
                </div>
            </div>
        </div>
    </div>
    
    <div id="confirmApproveInformation" class="modal" style="width: 40%; z-index: 1005; opacity: 1; transform: scaleX(1); top: 10%;">
        <h6 class="modal-header"><spring:message code="modal.header.approve" /></h6>
        <div class="modal-content">
            <div class="row">
                <form action="">
                    
                    <h6 id="approveSucessMessage"><spring:message code="modal.deviceApproved" /></h6>
                   
                </form>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                     <a class="btn modal-close" href="./uploadPaidStatus"><spring:message code="modal.ok" /></a>
                   
                </div>
            </div>
        </div>
    </div>
    
    
    <div id="rejectInformation" class="modal">
    <div class="header-fixed header-fixed-style">
           <h6 class="modal-header"><spring:message code="modal.header.reject" /></h6>
           </div>
           <div class="scrollDivHeight"></div>
            <div class="modal-content">
             <form action="" onsubmit=" return rejectUser()" method="POST">
            <div class="row">
             <h6><spring:message code="modal.rejectRequest" /><span id="disapproveTxnId"></span> ?</h6>
               
                
                    <div class="input-field" style="margin-top: 30px;">
                        <textarea id="Reason" class="materialize-textarea" name="Reason"
                        oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
						oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
                         style="min-height: 8rem;" required="required"></textarea>
                        <label for="Reason" style="margin-left: -10px;"><spring:message code="input.remarks" /><span
												class="star">*</span></label>
                    </div>
                   
                    
                
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <button type="submit" class="btn"><spring:message code="modal.yes" /></button>
                    <button class="btn modal-close" type="reset"  style="margin-left: 10px;"><spring:message code="modal.no" /></button>
                </div>
            </div>
            </form>
        </div>
    </div>
  
    	<div id="confirmRejectInformation" class="modal">
         <h6 class="modal-header"><spring:message code="modal.header.reject" /></h6>
          <div class="modal-content">
            <div class="row">
                <form action="">
                  
                    <h6 id="deviceRejectPopUp"><spring:message code="modal.deviceRejected" /></h6>
                </form>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a class="btn modal-close" href="./uploadPaidStatus"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>
    <div id="fileFormateModal" class="modal">
		<h6 class="modal-header"><spring:message code="fileValidationModalHeader" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="fileErrormessage"><spring:message code="fileValidationName" /><br> <br> <spring:message code="fileValidationFormate" /> <br><br> <spring:message code="fileValidationSize" /> </h6>
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
	
		<div id="visafileFormateModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="fileValidationModalHeader" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="visafileErrormessage">
					<spring:message code="fileValidationName" />
					<br> <br>
					<spring:message code="fileValidationFormate" />
					<br>
					<br>
					<spring:message code="fileValidationSize" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close  btn" onclick="clearVisaName()"
							style="margin-left: 10px;">
							<spring:message code="modal.ok" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="DeptfileFormateModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="fileValidationModalHeader" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="DeptfileErrormessage">
					<spring:message code="fileValidationName" />
					<br> <br>
					<spring:message code="fileValidationFormate" />
					<br>
					<br>
					<spring:message code="fileValidationSize" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close  btn" onclick="clearDeptName()"
							style="margin-left: 10px;">
							<spring:message code="modal.ok" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

<div id="tableOnModal" class="modal">
<div class="header-fixed header-fixed-style">
		<button type="button"
			class=" modal-action modal-close waves-effect waves-green btn-flat right"
			data-dismiss="modal">&times;</button>
		<h6 class="modal-header"><spring:message code="modal.header.viewHistory" /></h6>
		</div>
		<div class="scrollDivHeight"></div>
		<div class="modal-content modal-content-style">

			<div class="row">
				<table class="responsive-table striped display"
					id="data-table-history2" cellspacing="0">
				</table>
			</div>
		</div>
	</div>
	
	<div id="customRegisterDeviceDuplicateImei" class="modal">
			<h6 class="modal-header">
				<spring:message code="modal.header.registerdevice" />
			</h6>
			<div class="modal-content">

				<div class="row">
					<!-- <h6>Your request to upload device details has been accepted. The Transaction ID is ___________. Please
                    save this for future reference.
                    Kindly check the status of file upload by clicking on the check upload status button on the previous
                    page and providing the Transaction ID. -->
					<h6 id="dupliCateImeiMsg">
						<%-- <spring:message code="modal.message.futureRef" />
						<span id="endUsertXnId"></span> --%>
					</h6>
					<!--    </h6> -->
				</div>
				<div class="row">
					<div class="input-field col s12 center">
						<div class="input-field col s12 center">
							<button  class="modal-close  btn"><spring:message
									code="modal.ok" /></button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div id="userDisabledModel" class="modal">
			<h6 class="modal-header">
				<spring:message code="modal.header.userDisabled" />
			</h6>
			<div class="modal-content">

				<div class="row">
					<h6 id="dupliCateImeiMsg">
						<spring:message code="account.disabled" />
					</h6>
					
				</div>
				<div class="row">
					<div class="input-field col s12 center">
						<div class="input-field col s12 center">
							<%-- <button  class="modal-close  btn"><spring:message
									code="modal.ok" /></button> --%>
							<a href="./uploadPaidStatus?FeatureId=12" class="btn" data-original-title="" title=""><spring:message
									code="modal.ok" /></a>
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


		
	
		<script type="text/javascript" src="${context}/resources/js/intlTelInput.js"></script>
		<script type="text/javascript" src="${context}/resources/js/utils.js"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/CommanLocality.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

		<script type="text/javascript"
		src="${context}/resources/project_js/provinceDropdown.js?version=<%= (int) (Math.random() * 10) %>" async></script>                              
	<script type="text/javascript"
		src="${context}/resources/project_js/uploadPaidStatus.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>	
		<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/nationality.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript"
		src="" async></script>

		<script type="text/javascript">
/* var input2 = document.querySelector("#phone");
window.intlTelInput(input2, {
	utilsScript : "${context}/resources/js/utils.js",
});
  */
$("label[for='phone']").addClass('active');


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


