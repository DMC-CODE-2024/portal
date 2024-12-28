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

<!DOCTYPE html>
<html lang="en" class="no-js">
<head><title>EIRS Portal</title>
<!--<title>Home</title>-->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800&display=swap"
	rel="stylesheet">
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="" name="description" />
<meta content="" name="author" />
<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- Security Tags -->

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png"
	sizes="32x32">
<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<link rel="shortcut icon" href="">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">

<!-- Custome CSS-->

<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
<link href="${context}/resources/plugins/prism/prism.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link href="${context}/resources/css/dashboard.css" type="text/css"
	rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">


<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">

<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>
<!------------------------------------------- Dragable Model---------------------------------->
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>



<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
<style type="text/css">
.dataTables_info {
	display: none;
}

.paging_simple_numbers {
	display: none;
}

.dataTables_filter {
	display: none;
}

.section {
	padding-bottom: 1rem;
	width: 99%;
	margin: auto;
	margin-top: 10px;
}

table.dataTable.display tbody tr:first-child td {
	border-top: none;
	min-width: 120px !important;
}
</style>
</head>

<body data-roleType="${usertype}" data-id="1"
	data-userTypeID="${usertypeId}" data-userID="${userid}"
	data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}">

	<!-- 
<section id="content">
		<div class="center">
			<h1 style="font-size: 35px; margin-top: 30px;">Welcome To Central Equipment Identity Register</h1>
		</div>
	</section> -->

	<section id="content">
		<!--start container-->
		<div id="initialloader"></div>
		<div class="container">
			<div class="section">
				<div class="row card-panel">
					<div class="pageHeader">
						<p class="PageHeading">
							<spring:message code="view.dashboard" />
						</p>

					</div>
					<div class="col s12 m12 l12">
						<div class="row"></div>
						<div class="col s12 m12">

							<div class="col s12 m12 info-div center" id="infoBox"
								style="margin-top: 30px;"></div>
							<div class="col s12 m12" style="padding-bottom: 40px;">
								<div class="wrap-table">
									<h4 class="header2"
										style="font-weight: bold; margin-top: 50px;">
										<spring:message code="table.header" />
									</h4>

									<table class="responsive-table striped display"
										id="notificationLibraryTable" cellspacing="0">

									</table>
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
	<script src="${context}/resources/custom_js/bootstrap.min.js"></script>

	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>


	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>





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
		src="${context}/resources/project_js/home.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src=""
		async></script>
<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
<script type="text/javascript">var countHit="";  $( document ).ready(function() {   if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
$("body").click(function(e) {
	$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});
	$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;countHit=0;},error: function (jqXHR, textStatus, errorThrown) {}});
	if( currentTime > timeoutTime )
	{
		countHit=countHit+1;
		 
		   if(countHit==1){
			   
			   window.top.location.href = "./login?isExpired=yes";   
		   }
 		 
		}
	else{timeoutTime = currentTime + timeout;}});});
	</script>

 <%--  <script>
  $( document ).ready(function() { 
var timeoutTime = <%=session.getLastAccessedTime()%>;
var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;
var currentTime;
if($("body").attr("data-roleType") == ''){window.top.location.href = "./login?isExpired=yes";}
$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {
currentTime = data;
},error: function (jqXHR, textStatus, errorThrown) {}});
if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script>
 </script> --%>
</body></html>