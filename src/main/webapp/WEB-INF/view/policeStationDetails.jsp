<%@ page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Cache-Control", "no-store");
   response.setDateHeader("Expires", 0);
   response.setHeader("Pragma", "no-cache");

   int timeout = session.getMaxInactiveInterval();

   long accessTime = session.getLastAccessedTime();
   long currentTime = new Date().getTime();
   long dfd = accessTime + timeout;
   if (currentTime < dfd) {

   %>
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
<html lang="en">
<head>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='-1'>
<meta http-equiv='pragma' content='no-cache'>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="" name="description" />
<meta content="" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon"
	href="${context}/resources/assets/images/logo.png">
<%-- <link href="${context}/resources/css/materialize.css" type="text/css"
         rel="stylesheet" media="screen,projection"> --%>
<link rel="stylesheet"
	href="${context}/resources/assets/css/bootstrap.min.css">
<script src="${context}/resources/assets/js/jquery.min.js"></script>
<script src="${context}/resources/assets/js/popper.min.js"></script>
<script src="${context}/resources/assets/js/bootstrap.min.js"></script>
<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- Security Tags -->
<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
         var path = "${context}";
      </script>
<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<!-- CSS for icons(to remove later) -->
<link rel="stylesheet"
	href="${context}/resources/project_css/iconStates.css">
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<!-- CORE CSS-->
<link rel="stylesheet" href="${context}/resources/assets/css/style.css">
<script>
         var contextpath = "${context}";
      </script>

      <style>
          #filterButtonDiv{
          display: flex;
          flex-wrap: wrap;
          justify-content: flex-start;
      }
      </style>
</head>
<body data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-selected-username="${username}" data-featureId="${featureId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}" data-lang-param="${pageContext.response.locale}">
	<div class="content-box">
		<div class="content-container" id="datatableViewDiv">
			<div id="initialloader"></div>
			<div class="content-header" id="pageHeader">
				<h1 id="pageHeaderTitle"></h1>

			</div>
			<div class="filter-box" id="filterBox">
				<form action="" class="filter-row" id="filterform">
					<div id="errorMsgDiv" class="filter-form-row" style="width: 100%;"></div>
					<div id="dataTableDiv" class="filter-form-row"></div>
					<div id="filterButtonDiv" class="filter-btn-row"></div>
					<div id="registrationTableButtonDiv" class="filter-btn-row"></div>
					<div id="textbox-container"></div>
				</form>
			</div>
			<div id="LibraryTableDiv" class="table-box">
				<div class="table-responsive">
					<table id="LibraryTable" class="table">
						<thead class="thead-dark"></thead>
					</table>
				</div>
				<div id="footerBtn" class="table-paginationbox"></div>
			</div>
		</div>
	</div>





<!-- Priview END -->

<!--materialize js-->
<script type="text/javascript"
	src="${context}/resources/plugins/materialize.js"></script>
<script type="text/javascript"
	src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
<script src="${context}/resources/assets/js/custom.js"></script>
<!-- chartist -->
<script type="text/javascript"
	src="${context}/resources/project_js/globalVariables.js?version=<%= (int) (Math.random() * 10) %>"></script>
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
	src="${context}/resources/project_js/dragableModal.js"></script>
<script type="text/javascript"
	src="${context}/resources/project_js/policeStationDetails.js?version=<%= (int) (Math.random() * 10) %>"></script>

<script type="text/javascript"
	src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>"
	async></script>
<script type="text/javascript" src="" async></script>
<script type="text/javascript"
	src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
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
</body>
</html>
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