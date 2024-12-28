<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Security Tags -->
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:csrfMetaTags />
<!-- Security Tags -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head><title>EIRS Portal</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="msapplication-tap-highlight" content="no">
<meta name="description"
	content="Materialize is a Material Design Admin Template,It's modern, responsive and based on Material Design by Google. ">
<meta name="keywords"
	content="materialize, admin template, dashboard template, flat admin template, responsive admin template,">
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='-1'>
<meta http-equiv='pragma' content='no-cache'>

<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- Security Tags -->
<!--<title>CEIR | Registration</title>-->

<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<!-- For iPhone -->

<!-- For Windows Phone -->
<link rel="stylesheet"
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css">
<!-- CORE CSS-->

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png"
	sizes="32x32">

<!--<link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">-->
<!-- Compiled and minified CSS -->
<link rel="stylesheet"
	href="${context}/resources/custom_js/materialize.min.css">

<!-- Custome CSS-->
<link href="" type="text/css"
	rel="stylesheet" media="screen,projection">
<!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
<link href="${context}/resources/plugins/prism/prism.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/chartist-js/chartist.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link href="${context}/resources/project_css/leanOverlay.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<!-- Country -->
<style>
input[type="checkbox"] {
	display: none;
}

footer {
	padding-left: 0;
}

.btn-flat {
	height: auto;
}

.star {
	color: red;
}

.dropdown-content li>a, .dropdown-content li>span {
	color: #444;
}

.input-field>label {
	color: #444 !important;
}

[type="radio"]:not (:checked ), [type="radio"]:checked {
	opacity: 0;
}

input[type=text], input[type=password], input[type=email], input[type=url],
	input[type=time], input[type=date], input[type=datetime-local], input[type=tel],
	input[type=number], input[type=search], textarea.materialize-textarea {
	background-color: transparent !important;
	border: none !important;
	border-bottom: 1px solid #9e9e9e !important;
	border-radius: 0 !important;
	outline: none !important;
	height: 2.6rem !important;
	width: 100% !important;
	font-size: 1rem !important;
	margin: 0 0 5px 0 !important;
	padding: 0 !important;
	box-shadow: none !important;
	-webkit-box-sizing: content-box !important;
	-moz-box-sizing: content-box !important;
	box-sizing: content-box !important;
	transition: all .3s !important;
}

input


[
type
=
text
]


:focus


:not

 

(
[
readonly
]

 

)
{
border-bottom
:
1px

 

1
px

 

solid

 

#ff4081

 

!
important


;
box-shadow


:

 

0
1
px

 

0
0
#ff4081

 

!
important


;
}
input[type=text]:focus:not ([readonly] )+label {
	color: #ff4081 !important;
	background-color: transparent !important;
}

.input-field {
	position: relative;
	margin-top: 1rem;
	margin-bottom: 0;
}

.row {
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 0;
}

.btn {
	background-color: #ff4081 !important;
}

select {
	background-color: transparent;
	border: none;
	border-bottom: 1px solid #9e9e9e;
	padding: 0;
	margin-top: 0;
	height: 2.6rem;
}

[type="checkbox"]:not (:checked ), [type="checkbox"]:checked {
	position: inherit;
	opacity: 1;
	pointer-events: none;
}

[type="checkbox"]+span:not (.lever ):before, [type="checkbox"]:not (.filled-in
	 )+span:not (.lever ):after {
	display: none;
}

input[type="checkbox"] {
	display: block;
}

[type="checkbox"]:not (:checked ), [type="checkbox"]:checked {
	float: left;
	margin-top: 5px;
}

.fa-eye-slash, .fa-eye {
	position: absolute;
	right: 10px;
	top: 10px;
}

.upload-file-label {
	margin: 0;
}

.file-field .btn {
	line-height: 2.4rem;
	height: 2.4rem;
}

.section .registration-form {
	padding-top: 1rem;
	padding-bottom: 1rem;
	width: 90%;
	margin: auto;
	/* border: solid 2px #444; */
}
</style>
<script>
	var contextpath = "${context}";
</script>
</head>
</head>
<body>


	<!--   Scripts
    ================================================ -->
	<!-- jQuery Library -->
	<script type="text/javascript"
		src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>

	<script src="${context}/resources/custom_js/materialize.min.js"></script>
	<%-- <script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script> --%>
	<script type="text/javascript" src="${context}/resources/js/country.js"></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<!-- data-tables -->
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/data-tables-script.js"></script>

	<!-- //////////////////////////////////////////////////////////////////////////// -->
	<!-- //////////////////////////////////////////////////////////////////////////// -->


	<!-- ajax js -->
	<script type="text/javascript"
		src="${context}/resources/project_js/signup/Registration.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/signup/Profile.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/signup/Password.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/signup/Login.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<div id="ErrorPopup" class="modal modal-small"
		style="margin: 20vh 54vh; display: block;">
		<h6 class="modal-header">
			<spring:message code="registration.homepage" />

		</h6>
		<div class="modal-content">
			<div class="row">
				<h6>
					<spring:message code="${not empty sessionScope.tag ? sessionScope.tag : 'Reg_flag_off'}" />
					<%-- 	<spring:message code="Reg_flag_off" /> --%>
				</h6>
			</div>
			<div class="input-field col s12 center">
				<div class="input-field col s12 center">
					<a href="${context}/DMC" class="btn"
						name="add_user" id="add_user"><spring:message code="modal.ok" /></a>	
					<%-- <a href="#"
						class="modal-close btn" style="margin-left: 10px;"><spring:message
							code="modal.no" /></a> --%>
				</div>
			</div>
		</div>
	</div>
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


	<script type="text/javascript"
		src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<!--
	<script type="text/javascript">
		$(document).ready(function() {
			dataByTag("link_dmc_portal", "add_user", 1);
		});
	</script>
 -->
</body></html>