<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head><title>EIRS Portal</title>
<!--<title>Footer</title>-->

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="" name="description" />
<meta content="" name="author" />

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
	href="${context}/resources/assets/css/iconStates.css">

<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">


<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>

<!------------------------------------------- Dragable Model---------------------------------->

<script
	src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
	
<style>

</style>
</head>
<body>

        <footer class="page-footer" style="position: fixed; bottom: 0; width: 100%;">
        <div class="footer-copyright">
            <div class="container">
                <span class="right">
                <spring:message code="registration.copyright" />
              
                
                </span>
            </div>
        </div>
    </footer>

	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	
	<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>


	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>

	