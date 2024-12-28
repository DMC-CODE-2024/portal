
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
<!--<title>Register Device</title>-->
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

<%-- <jsp:include page="/WEB-INF/view/endUserHeader.jsp" ></jsp:include>
<jsp:include page="/WEB-INF/view/endUserFooter.jsp" ></jsp:include> --%>

<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>

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
	
	height: 36px;
	 font-size: 31px
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
	margin-top: 0vh;
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
.dataTables_scrollBody {
    width: 100%;
    max-height: 400px !important;

   height: auto !important;


}
.dataTables_scroll {
    margin-top: 2px;
}
button.modal-action.modal-close.waves-effect.waves-green.btn-flat.right {
    height: 25px;
}
 
 .header-fixed-style{
width: inherit;
z-index: 1003;
position: fixed;
}

.row.card-panel.tableView {
    width: 77%;
    margin-left: 12%;
    margin-top: 2vh;
}
.row.card-panel.tableFormHeader {
    margin-top: 0vh;
}

 .container {
       margin: 0 auto;
    max-width: 100% !important;
    position: absolute;
}

.deviceErrorTitle {
    position: relative;
    top: 0px;
}
</style>
</head>
<body data-lang-param="${pageContext.response.locale}"
 session-value="${not empty param.Search ? param.Search : 'null'}">

	<!-- START CONTENT -->
	<section id="content">
			<div id="initialloader"></div>

		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="">
					

							<div class="row card-panel login-card-panel" id="user123" class="section" style="display: none;">
								
		<h6 class="fixPage-modal-header ">

<div class="col s9 m10 l10 select-lang-lable-all">
<p><spring:message code="modal.header.registerdevice" /></p>
<i class="fa fa-globe fa-6" aria-hidden="true"></i>
</div>
<div class="col s3 m2 l2 right">
<select class="browser-default select-lang-drpdwn-all" id="langlistSave">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
</div>
</h6>

									<form action="" onsubmit="return submitEndUserDeviceInfo()"
						method="POST" enctype="multipart/form-data" autocomplete="off" >
						<div class="col s12 m12 l12">
							<div class="row">
								<div class="row">

									<div>
										<h5>
											<spring:message code="input.personalInformation" />
										</h5>
										<hr>
									</div>
									<div class="col s12 m12">
										<label for="nationality"><spring:message
												code="input.Nationality" /> <span class="star">*</span></label>
										<div class=" boxHeight">
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
									
									<div id="nationalID">
							

										<div class="input-field col s12 m4">
											<input type="text" id="endUserfirstName"
											pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												required  /> <label for="endUserfirstName"><spring:message
													code="input.firstName" /> <span class="star">*</span></label>
										</div>

										<div class="input-field col s12 m4">
											<input type="text" id="endUsermiddleName"
												pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
												oninput="InvalidMsg(this,'input');"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												
												 /> <label for="endUsermiddleName"><spring:message
													code="input.middleName" /> </label>
										</div>

										<div class="input-field col s12 m4">
											<input type="text" id="endUserlastName"
												pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
												 /> <label for="endUserlastName"><spring:message
													code="input.lastName" /> <span class="star"></span></label>
										</div>

										<div class="input-field col s12 m6" id="nationalityDiv"
											style="display: none">
											<%-- <input type="text" id="nationality" name="nationality"
												pattern="[a-zA-Z]{1,25}" oninput="InvalidMsg(this,'input');"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												title="" maxlength="25"> <label for="nationality" class=""><spring:message
													code="input.Nationality" /> <span class="star">*</span></label> --%>
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
										</div>
										<div class="input-field col s12 m6" id="entryCountryDiv" style="display: none;">
												<input type="text" id="datepicker"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													 maxlength="15" /> <label for="datepicker"><spring:message
														code="input.EntryCountry" /> <span class="star">*</span></label>
									</div>
										<div class="input-field col s12 m12 l12">
											<input type="text" pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
												required class="form-control boxBorder boxHeight" id="address">
											<label for="address"><spring:message
													code="input.address" /> <span class="star">*</span> </label>
										</div>

										<div class="input-field col s12 m6 l6">
											<p
												style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
												<spring:message code="input.Country" />
												<span class="star">*</span>
											</p>
											<select id="country" class="browser-default" class="mySelect" disabled="disabled"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;color: rgb(53, 52, 52);"" required></select>
										</div>

										<div class="input-field col s12 m6 l6"
											style="margin-bottom: 5px;">
											<p
												style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
												<spring:message code="input.province" />
												<span class="star">*</span>
											</p>
											<select id="state" class="browser-default" class="mySelect"
											onchange="getDistrict(this,'endUserdistrict','commune');"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required>
												<option value=""><spring:message code="select.district" /></option>
												</select>
										</div>
										<div class="col s12 m6 l6">
											<%-- <input type="text" id="endUserdistrict"
												pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												required maxlength="30"> --%>
												<label for="endUserdistrict"><spring:message
													code="input.district" /> <span class="star">*</span> </label>
													<select
										id="endUserdistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'commune','village');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
												 
										</div>
										<div class="col s12 m6 l6">
											<%-- <input type="text" id="commune" pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												required maxlength="30"> --%> <label for="commune"><spring:message
													code="input.commune" /> <span class="star">*</span></label>
													
													<select
										id="commune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'village');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option>
										</select>
										</div>
										
										<div class="col s12 m6 l6">
											<%-- <input type="text" id="village"
												pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												title="" maxlength="30"> --%> <label for="village"><spring:message
													code="input.village" /> <span class="star"></span> </label>
													<select
										id="village" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
										</div>
										
										<div class="input-field col s12 m6 l6" style="margin-left: 0px;margin-top: 23px; ">
											<input type="text" class="form-control boxBorder boxHeight"
												id="streetNumber" pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
												required > <label for="streetNumber"><spring:message
													code="input.streetNumber" /> <span class="star">*</span> </label>
										</div>

										<div class="input-field col s12 m6 l6" style="margin-right:1px">
											<input type="text" class="form-control boxBorder boxHeight"
												pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
												 class="form-control boxBorder boxHeight"
												id="locality" id="endUserlocality"> <label
												for="locality"><spring:message code="input.locality" />
												<span class="star"></span></label>
										</div>

										
										
										

										

										<div class="input-field col s12 m6 l6"  style="margin-left:-1px">
											<input type="text" class="form-control boxBorder boxHeight"
												id="pin" 
												pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
												 > <label for="pin"><spring:message
													code="registration.postalcode" /><span class="star"></span></label>
										</div>

										

										<div class="input-field col s12 m6" style="margin: 0;">
											<label for="phone">
												<spring:message code="input.contactNum" />
												<span class="star">*</span>
											</label>
											<input type="tel" id="phone" pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
												required >
										</div>

										<div class="input-field col s12 m6">
											<input type="email" id="endUseremailID"
												pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
											
												/> <label for="endUseremailID"><spring:message
													code="input.EmailID" /> </label>
										</div>


			<div class="input-field col s12 m6">
											<input type="text" id="endUserNID"
												pattern="<spring:eval expression="@environment.getProperty('pattern.operatorNid')" />"
												value="${nid}" readonly="readonly"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												required  /> <label id="endUserNID"
												for="NID"><spring:message
													code="registration.nationalid/passporartnumber" /> <span class="star">*</span></label>
										</div>
										<div class="col s12 m6" style="margin-top: -6px;">
															<label for="deviceType"><spring:message code="input.documenttype" /> <span
																class="star">*</span></label> <select class="browser-default"
																id="doc_type" 
																oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
											                    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');" required>
																<option value="" disabled selected><spring:message code="select.documenttype" /> </option>
															</select>
															
															<!-- <input type="text" id="docTypeNymericValue" style="display: none" > -->
														</div>	
										<div class="file-field col s12 m6" style="margin-top: -8px; margin-right: 1%">
											<h6 style="font-size: 12px;" id="nidType">
												<spring:message code="input.IDImage" />
												<span class="star">*</span>
											</h6>
											<div class="btn">
												<span><spring:message code="input.selectfile" /> </span> <input
													type="file" onchange="fileTypeValueChanges('uploadnationalID')"
										oninput="InvalidMsg(this,'input','<spring:message code="validation.file" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.file" />');"
													title="<spring:message code="validation.file" />"
													accept="image/*" id="uploadnationalID" required>
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate" type="text"
													id="nidPlaceHolder" placeholder="<spring:message code="validation.PassportPlaceholder" />"> 
													
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
										<div class="row">
											<div class="col s12 m12" style="margin-top: 30px;">
												<h5>
													<spring:message code="modal.deviceInfo" />
												</h5>
												<hr>
											</div>
											<div id="mainDeviceInformation" class="mainDeviceInformation">
												<div id="deviceInformation" class="deviceInformation">
													<div class="col s12 m6">
														<label for="deviceIdType1"><spring:message
																code="select.deviceIDType" /><span class="star">*</span></label>
														<select class="browser-default"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															required id="deviceIdType1">
															<option value="" disabled selected><spring:message
																	code="select.selectDeviceIDType" /></option>

														</select>
													</div>


													<div class="col s12 m6">
														<label for="multipleSimStatus1"><spring:message
																code="registration.selectMultiplestLawfull" /><span class="star">*</span></label>
														<select class="browser-default" required="required" onchange="setContactIMEINumber('multipleSimStatus1','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															 id="multipleSimStatus1">
															<option value=""  selected><spring:message
																	code="select.multiSimStatus" /></option>

														</select>
													</div>

													<div class="col s12 m6">
														<label for="deviceType1"><spring:message
																code="select.deviceType" /></label>
														<select class="browser-default" style="height: 34px"
															id="deviceType1"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															>
															<option value=""  selected><spring:message
																	code="select.deviceType" /></option>

														</select>
													</div>
													<div class="input-field col s12 m6 l6">
														<p
															style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
															<spring:message code="select.countryBoughtFrom" />
															
														</p>
														<select id="country1" class="browser-default"
															style="margin-bottom: 5px;" class="mySelect"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															 style="padding-left: 0;"></select>
													</div>
													<div class="input-field col s12 m6"
														style="margin-top: 22px;">
														<input type="text" id="serialNumber1"
																pattern="<spring:eval expression="@environment.getProperty('pattern.serialNumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
															> <label
															for="serialNumber1"><spring:message
																code="input.deviceSerialNumber" />
														</label>
													</div>

													<div class="col s12 m6">
														<label for="deviceStatus1"><spring:message
																code="select.deviceStatus" /></label>
														<select class="browser-default"
															oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
															 id="deviceStatus1">
															<option value=""  selected><spring:message
																	code="select.selectDeviceStatus" /></option>

														</select>
													</div>
													
													<%-- <div class="col s12 m6" style="    margin-right: 2px;" >
															<label for="taxStatus1"><spring:message code="select.taxPaidStatus" /> <span
																class="star">*</span></label> <select class="browser-default"
																oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
																required="required" id="taxStatus1">
																<option value="" disabled selected><spring:message code="select.selectTaxPaidStatus" /></option>

															</select>
														</div>
													
													<div class="input-field col s12 m6 l6" id="priceDiv" style="margin-top: 27px;         margin-left: -2px;">
															<input type="text" name="Price" id="Price1"
																pattern="[0-9]{0,7}" 
															oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
											            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
																title= "<spring:message code="validation.7digits" />" maxlength="7">
															<label for="Price1"><spring:message code="select.price" /></label>
														</div> --%>

														<div class="col s12 m6" id="CurrencyDiv" style="display: none;    margin-left: -1px;">
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

													
													<div id="IMEIndContact1" style="display: none">
													<div class="col s12 m12" style="position: relative;">
														<p>
															<spring:message code="title.imeiMeidEsn" />
														</p>
														<p id="errorMsgOnModal" class="deviceErrorTitle"></p>
													</div>
													<div class="input-field col s12 m6">
														<input type="text" id="IMEIA1" 
														pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															required > <label for="IMEIA1"><spring:message
																code="title.one" /> <span class="star">*</span></label>
													</div></div>
													<div id="IMEIndContact2" style="display: none">
													<div class="input-field col s12 m6">
														<input type="text" id="IMEIB1" 
														pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															title="<spring:message code="validation.1516digit" />"
															> <label for="IMEIB1"><spring:message
																code="title.two" /></label>
													</div></div>
													<div id="IMEIndContact3" style="display: none">
													<div class="input-field col s12 m6">
														<input type="text" id="IMEIC1" 
														pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															title="<spring:message code="validation.1516digit" />"
															> <label for="IMEIC1"><spring:message
																code="title.three" /></label>
													
													</div></div>
													<div id="IMEIndContact4" style="display: none">	
													<div class="input-field col s12 m6">
														<input type="text" id="IMEID1" 
														pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
															oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
															title="<spring:message code="validation.1516digit" />"
															> <label for="IMEID1"><spring:message
																code="title.four" /></label>
													</div></div>


												</div>
											</div>
											<!-- <div class="input_fields_wrap_1"></div> -->

											<div class="row">
												<div class="col s12 m12">
													<%-- <button class="btn right add_field_button"
														style="margin-top: 5px;">
														<span style="font-size: 20px;">+</span>
														<spring:message code="button.addMoreDevice" />
													</button> --%>
												</div>
											</div>
										</div>

										<p>
					      <label style="color: black!important;">
					        <input name="disclamer" id="disclamer" type="checkbox" 	oninput="InvalidMsg(this,'checkbox','<spring:message code="validation.checkbox" />');" oninvalid="InvalidMsg(this,'checkbox','<spring:message code="validation.checkbox" />');" required />
					        <span> <span class="star">*</span> <spring:message code="registration.certifyMsg" /></span>
					      </label>
					    </p>	
										<p>
											<spring:message code="input.requiredfields" />
											<span class="star">*</span>
										</p>
										<div class="row" style="padding-bottom: 50px;">
											<div class="input-field col s12 m12 center">
												<button id="endUserRegisterButton" type="submit" disabled="disabled" class="btn">
													<spring:message code="button.submit" />
												</button>
												<a href="./redirectToHomePage" class="btn"
													style="margin-left: 10px;"><spring:message
														code="button.cancel" /></a>
											</div>
										</div>
									</div>
								</div>

			</div></div></form>
								</div>

								
							</div>
							<div class="container" id="user456" style="display: none;">
				
							<%-- <h6 class="fixPage-modal-header ">
						<spring:message code="modal.header.registerdevice" />
					</h6> --%>
					<div class="row card-panel tableView" >
							<%-- <h6 class="fixPage-modal-header ">
						<spring:message code="modal.header.registerdevice" />
					</h6> --%>
					
						<h6 class="fixPage-modal-header rg_device">
<div class="col s8 m6 l8 select-lang-lable-all">
<p><spring:message code="modal.header.registerdevice" /></p>
</div>
<div class="col s4 m6 l4 ">
<i class="fa fa-globe fa-6" aria-hidden="true"></i>
<select class="browser-default select-lang-drpdwn-all" id="langlist">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
<a href="" class="boton right" id="btnLink"></a>
</div>

</h6>
					
					
					
							
							<div id="profile-page" class="section">
								
									
										<form action="${context}/uploadPaidStatus">
										<div class="col s12 m12 l12" id="tableDiv"
											style="padding-bottom: 5px; background-color: #e2edef52; display:none">
										</div>
											<div id="filterBtnDiv"></div>
											<p id="errorMsg" style="color: red;font-size: 12px;position: absolute;left: 40px;margin: 0;top: 122px;"class="left"></p>
										</form>
									
							
										<div class="row">
											<div class="col s12 m12">
												<table class="responsive-table striped display"
													id="data-table-simple" cellspacing="0">

												</table>
													<div class="input-field col s12 m12 l12 center">
                                           
                                            <a href="./redirectToHomePage" class="btn"
                                                style="margin-left: 10px;"><spring:message code="modal.close" /></a>
                                        </div>
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
	
	<div id="endUserRegisterDeviceModal" class="modal">
			<h6 class="modal-header">
				<spring:message code="modal.header.registerdevice" />
			</h6>
			<div class="modal-content">

				<div class="row">
					<!-- <h6>Your request to upload device details has been accepted. The Transaction ID is ___________. Please
                    save this for future reference.
                    Kindly check the status of file upload by clicking on the check upload status button on the previous
                    page and providing the Transaction ID. -->
					<h6 id="sucessMessageId">
						<spring:message code="modal.message.futureRef" />
						<span id="endUsertXnId"></span>
					</h6>
					<!--    </h6> -->
				</div>
				<div class="row">
					<div class="input-field col s12 center">
						<div class="input-field col s12 center">
							<a href="./redirectToHomePage" class="btn"><spring:message
									code="modal.ok" /></a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="endUserRegisterDeviceDuplicateImei" class="modal">
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
	</section>

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
<div id="viewBlockDevices" class="modal" style="width: 75%;">
		<button type="button"
			class=" modal-action modal-close btn-flat right"
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
	
	<div id="deleteMsg" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.delete" /></h6>
		<div class="modal-content">

			<div class="row">
				<h6><spring:message code="modal.deleteDeviceInfo" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<button class="btn" onclick="accept()"><spring:message code="modal.yes" /></button>
					<button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
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
	
	<div style="display: none;">
	<form action="selfRegisterDevicePage" method="post" id="changedLangForm">
	<input type="text" id="changedLangValue" name="lang" style="display: none;">
	<input type="text" id="changedLangNid"  name="Search" style="display: none;">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
	</div>
	<form action="viewDeviceInformation" method="post" id="viewDeviceForm">
	<input type="text" id="viewbyImei" name="viewbyImei" style="display: none">
	<input type="text" id="viewbytxnId" name="viewbytxnId" style="display: none">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
	
	<div id="tableOnModal" class="modal">
	<div class="header-fixed header-fixed-style">
		<button type="button"
			class=" modal-action modal-close  btn-flat right"
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
	<div style="display: none;">
	<form action="EndUser_AddDevices" method="post" id="openEndUserAddDeviceForm">
	<!-- <input type="text" id="changedEndUserAddDeviceLangValue" name="lang" style="display: none;"> -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
	</div>
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
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
	

		<script type="text/javascript" src="${context}/resources/js/intlTelInput.js"></script>

		<script type="text/javascript" src="${context}/resources/js/utils.js"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/nationality.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>


		
		<script type="text/javascript"
		src="${context}/resources/project_js/provinceDropdown.js?version=<%= (int) (Math.random() * 10) %>" async></script> 

	<%-- 	<script type="text/javascript"
		src="${context}/resources/js/intlTelInput.js"></script> --%>

	<script type="text/javascript"
		src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/CommanLocality.js?version=<%= (int) (Math.random() * 10) %>"></script>
<script type="text/javascript"
		src="${context}/resources/project_js/selfRegisterDevice.js?version=<%= (int) (Math.random() * 10) %>"></script>

<script type="text/javascript">
/*  var input2 = document.querySelector("#phone");
window.intlTelInput(input2, {
	utilsScript : "${context}/resources/js/utils.js",
});  */


</script>
</body></html>
	
