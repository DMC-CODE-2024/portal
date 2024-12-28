<%@ page import="java.util.Date"%>
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
<head>
<title>EIRS Portal</title>
<!--<title>Table</title>-->

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

<link rel="stylesheet"
	href="${context}/resources/assets/css/bootstrap.min.css">
<script src="${context}/resources/assets/js/jquery.min.js"></script>
<script src="${context}/resources/assets/js/popper.min.js"></script>
<script src="${context}/resources/assets/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<script type="text/javascript"> var path = "${context}";</script>
<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<!-- CSS for icons(to remove later) -->
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<!-- CORE CSS-->

<link rel="stylesheet" href="${context}/resources/assets/css/style.css">
<link rel="stylesheet" href="${context}/resources/assets/css/loaderMsg.css">





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

section {
	margin: 0 0.5rem;
}
</style>
</head>
<body data-id="39" data-roleType="${usertype}"
	data-userTypeID="${usertypeId}" data-userID="${userid}"
	data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-username="${username}"
	data-selected-consignmentStatus="${consignmentStatus}"
	data-featureId="${featureId}">

    <div id="initialtextloader" style="display:none"></div>

	<div class="content-box">
		<div class="content-container">
		    <div class="content-header">
				<h1>
					<spring:message code="modal.header.Search" />
				</h1>
			</div>
			<div class="filter-box">
				<div id="submitbtn">
					<form action="#" onsubmit="return searchIMEIDetails()">
						<div class="form-row align-items-center">

							<%-- <div class="form-group col-md-4 mb-3">
								<label>IMEI <span class="red">*</span></label> <input
									type="text" class="form-control mb-2" id="searchIMEI"
									placeholder="Enter IMEI" maxlength="16"
									pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
									oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
									oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
									required />
							</div> --%>
							<div class="form-group col-md-4 mb-3">
								<label>IMEI <span class="red">*</span></label> <input
									type="text" class="form-control mb-2" id="searchIMEI"
									placeholder="Enter IMEI" maxlength="16"
									pattern="<spring:eval expression="@environment.getProperty('pattern.ImeiAplhanumericLength16')" />"
									oninput="InvalidMsg(this,'input','<spring:message code="validation.imeialphanumeric.16digit" />');"
									oninvalid="InvalidMsg(this,'input','<spring:message code="validation.imeialphanumeric.16digit" />');"
									required />
									<div id="errorIMEIMsgDiv" class="filter-form-row" style="width: 100%;height: 18px;">
									<p id='errorIMEIMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;display:none;' class='left'><spring:message code="search.invalid.imei" /></p>
									</div>

							</div>

							<div class="form-group col-md-4 mb-3">
								<label>Ticket ID <span class="red">*</span></label> <input type="text"
									class="form-control mb-2" id="searchTicketId"
									placeholder="Enter Ticket ID" maxlength="18"
									pattern="<spring:eval expression="@environment.getProperty('pattern.ticketId')" />"
									oninput="InvalidMsg(this,'input','<spring:message code="validation.ticketId.18chars" />');"
									oninvalid="InvalidMsg(this,'input','<spring:message code="validation.ticketId.18chars" />');"
									required />
									<div id="errorTicketMsgDiv" class="filter-form-row" style="width: 100%;height: 18px;">
									<p id='errorMsg' style='color: red;font-size: 15px;left: 23px;margin: 0;display:none;' class='left';><spring:message code="search.invalid.ticket" /></p>
									</div>

							</div>
							<div class="col-auto">
							    <button type="submit" class="btn save-button-search-imei" id="submit">Search</button>
								<button type="button" class="btn cancel-btn-search-imei"> Clear</button>
								<div style="width: 100%;height: 14px;">
								</div>
							</div>


						</div>
					</form>

				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

	<!-- chartist -->

	<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
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
		src="${context}/resources/project_js/searchIMEI.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
      src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
   <%-- <script type="text/javascript"
          src="${context}/resources/project_js/searchIMEIContent.js?version=<%= (int) (Math.random() * 10) %>"></script> --%>

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

</body>
</html>
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