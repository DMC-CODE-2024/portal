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
<!--<title>NID</title>-->

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

section {
	margin: 0 0.5rem;
}
 .container {
       margin: 0 auto;
    max-width: 100% !important;
    position: absolute;
}

.input-field.col.s12.m2.l2.buttonDiv {
    margin-left: 12px;
    width: 40%;
}

.input-field.col.s12.m3.l3.placeholderDiv {
    margin-left: 11px;
}
</style>
</head>
<body data-id="12" data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}" data-lang-param="${pageContext.response.locale}">


	<!-- //////////////////////////////////////////////////////////////////////////// -->

	<!-- START CONTENT -->
	<section id="content" >
	
			<div class="container">

			<div class="section">
		<div class="row card-panel login-card-panel">
			<h6 class="fixPage-modal-header ">

<div class="col s9 m10 l11 select-lang-lable-all width87">	
<p><spring:message code="modal.header.registerdevice" /></p>

<i class="fa fa-globe fa-6" aria-hidden="true"></i>
</div>
<div class="col s3 m2 l1 right width13" style="padding: 0;">
<select class="browser-default select-lang-drpdwn-all" id="langlist">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
</div>
</h6>
		
			<div class="row">
				<div class="col s12 m12">
					<div id="submitbtn">
					<div class="input-field col s12 l3 m12" style="width: 35.666667%;">
							<label for="Search" class="center-align ml-10" style="width:100%;text-align: left;"><spring:message code="input.nid" /><span class="star">*</span></label>
						
						</div>
						
						<form action="selfRegisterDevicePage" method="post">
						<div class="input-field col s12  m12 l5 placeholderDiv">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<input type="text" id="Search" name="Search"
								 pattern="<spring:eval expression="@environment.getProperty('pattern.operatorNid')" />"
								oninput="InvalidMsg(this,'input','<spring:message code="validation.13NID" />');" 
								  oninvalid="InvalidMsg(this,'input','<spring:message code="validation.13NID" />');"
								placeholder="<spring:message code="input.nidInput" />" required>
						</div>
							
						<div class="input-field col s12 m12 l4 buttonDiv">
						
							<button type="submit" class="btn"  id="submit"><spring:message code="button.submit" /></button>
							<a href="./redirectToHomePage" class="btn"><spring:message code="modal.close" /></a>
						</div>
						</form>
						<div class="col s12 m12"><p id="errorMsgOnModal" class="nidValidationMsg"><spring:message code="validation.12NID" /></p></div>
					</div>
				</div>
			</div>
		</div>
		</div></div>
	</section>
<!--materialize js-->
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	
		<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>

	<!--custom-script.js - Add your own theme custom JS-->



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
	
<script type="text/javascript"
src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

<%-- <script type="text/javascript"
src="${context}/resources/project_js/nidForm.js?version=<%= (int) (Math.random() * 10) %>"></script> --%>


<script>

$('#langlist').on('change', function() {
lang=$('#langlist').val() == 'km' ? 'km' : 'en';
var url_string = window.location.href;
var url = new URL(url_string);
var type = url.searchParams.get("type");
window.location.assign("selfRegisterDevice?lang="+lang);
});

$('#langlist').val(data_lang_param);
</script>

<script type="text/javascript"
src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>

</body></html>