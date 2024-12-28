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
<c:set var="context" value="${pageContext.request.contextPath}" />
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="msapplication-tap-highlight" content="no">

<link rel="icon" type="image/x-icon"
	href="${context}/resources/assets/images/logo.png">

<link rel="stylesheet" href="${context}/resources/assets/css/bootstrap.mincheckIMEI.css" id="bootstrap-stylesheet"/>
<link media="print" onload="this.media='all'" href="${context}/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css"/>
<link media="print" onload="this.media='all'" href="${context}/resources/assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-stylesheet"/>
<link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/font/font-awesome/css/font-awesome.min.css">
<link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/assets/css/style.css">
	
<script async defer src="${context}/resources/assets/js/jquery.min.js"></script>
<script async defer src="${context}/resources/assets/js/popper.min.js"></script>

<!-- Check IMEI CSS -->
<link rel="shortcut icon"
	href="${context}/resources/assets/images/favicon.ico">
<!-- App css -->

<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- Security Tags -->

<link rel="apple-touch-icon-precomposed"
	href="images/favicon/apple-touch-icon-152x152.png">
<!-- For iPhone -->
<meta name="msapplication-TileColor" content="#00bcd4">
<meta name="msapplication-TileImage"
	content="images/favicon/mstile-144x144.png">
<!-- For Windows Phone -->
</head>

<body data-lang-param="${pageContext.response.locale}"
	data-layout="horizontal">
	
	<div id="wrapper">
		<!-- ============================================================== -->
		<!-- Start Page Content here -->
		<!-- ============================================================== -->

		<div class="content-page" style="margin-top: -23px !important;">
			<!-- <div class="content" style="padding-top: 0px !important;"> -->
				<!-- <div id="initialloader"></div> -->
				    <iframe src="https://lab1.goldilocks-tech.com/eirs/dashboard?token=${token}"  width="100%"  style="border: none;height: 100%; width: 100%"></iframe>
			<!-- </div> -->
			<!-- end content -->
		</div>
		<!-- END content-page -->
	</div>
	<!-- END wrapper -->

		
	<!-- Vendor js -->
	<script src="${context}/resources/assets/js/vendor.min.js"></script>

	<!-- App js -->
	<script src="${context}/resources/assets/js/app.min.js"></script>
	
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
	
</body>
</html>
