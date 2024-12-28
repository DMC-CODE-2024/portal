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
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Security Tags -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:csrfMetaTags />
<!-- Security Tags -->
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head><title>EIRS Portal</title>
<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- Security Tags -->
<!--<title>Importer</title>-->
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

<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
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
	href="${context}/resources/project_css/viewStock.css">
<link rel="stylesheet"
	href="${context}/resources/project_css/select2.css">
	
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">

</head>
<body data-id="21" data-roleType="${usertype}" data-userID="${userid}"
	data-userTypeID="${usertypeId}"
	data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}">




	<section id="content">
		<!--start container-->
		
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div class="container-fluid pageHeader">
								<p class="PageHeading">
									<spring:message code="modal.header.typeApproved" />
								</p>
							</div>

							<form onsubmit="return registerTAC()" method="POST"
								enctype="multipart/form-data" id="registerTAC">

								<div class="row myRow">
									<div class="input-field col s12 m6 l6" style="margin-top: 22px">
										<input type="text" id="trademark" name="trademark"
											pattern="<spring:eval expression="@environment.getProperty('pattern.trademark')" />"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.trademark" />');"
											oninvalid="InvalidMsg(this,'input','<spring:message code="validation.trademark" />');"
											title="" maxlength="160" required> <label
											for="trademark"><spring:message
												code="registration.trademark" /> <span class="star">*</span></label>
									</div>


									<div class="col s12 m6 l6" style="margin-bottom: 5px;">
										<label for="productName"><spring:message
												code="table.ProductName" /> <span class="star">*</span></label> <select
											id="productname" class="browser-default"
											onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											required>
											<option value="" disabled selected><spring:message
													code="registration.selectproduct" />
											</option>
										</select>
									</div>
								</div>

								<div class="row myRow">
									<div class="col s12 m6 l6">
										<label for="modalNumber"><spring:message
												code="registration.modelnumber" /> <span class="star">*</span></label>
										<select id="modelNumber" class="browser-default"
											onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											required>
											<option value="" disabled selected>
												<spring:message code="registration.selectmodelnumber" /></option>

										</select>
									</div>

									<div class="col s12 m6 l6" hidden="hidden">
										<select class="browser-default" id="status">
										</select>
									</div>

									<div class="col s12 m6 l6">
										<label><spring:message code="input.manufacturerCountry" /> <span
											class="star">*</span></label> <select id="country"
											class="browser-default" class="mySelect"
											style="padding-left: 0;"
											onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
											required></select>
									</div>

								</div>

								<div class="row myRow">
									<div class="input-field col s12 m6 l6">
										<input type="text" id="frequencyrange" 
										pattern="<spring:eval expression="@environment.getProperty('pattern.frequencyRange')" />"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
											oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
											maxlength="30" required> <label for="frequencyrange"><spring:message
												code="registration.frequencyrange" /> <span class="star">*</span></label>
									</div>
									<div class="input-field col s12 m6 l6">
										<input type="text" id="tac"
										pattern="<spring:eval expression="@environment.getProperty('pattern.tac')" />"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.tac8" />');"
											oninvalid="InvalidMsg(this,'input','<spring:message code="validation.tac8" />');"
											name="tac" maxlength="8" required="required"> <label
											for="tac"><spring:message code="registration.tac" />
											<span class="star">*</span></label>
									</div>
								</div>



								<div id="mainDiv" class="mainDiv">
									<div id="filediv" class="fileDiv">
										<div class="row myRow">
											<div class="col s12 m6 l6">
												<label for="Category"><spring:message
														code="input.documenttype" /></label> <select
													class="browser-default" id="docTypetag1"
													onchange="enableSelectFile()">
													<option value=""  selected><spring:message
															code="select.documenttype" />
													</option>

												</select> <select class="browser-default" id="docTypetagValue1"
													style="display: none;">
													<option value=""  selected><spring:message
															code="select.documenttype" /></option>

												</select>
											</div>

											<div class="file-field col s12 m6" id="removestar">
												<h6 id="supportingdocumentFile" class="file-upload-heading">
													<spring:message code="input.supportingdocument" />
												</h6>
												<div class="btn">
													<span><spring:message code="input.selectfile" /></span> <input
														type="file" name="files[]" id="docTypeFile1"
														disabled="disabled" onchange="enableAddMore('docTypeFile1','filediv')"
														onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
														oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
												</div>
												<div class="file-path-wrapper">
													<input class="file-path validate" type="text" id="filetextField"
														placeholder="<spring:message code="grievanceFileMessage" />">
													<div>
														<p id="myFiles"></p>
													</div>
												</div>
											</div>
										</div>


									</div>

								</div>
								<div class="col s12 m6 right">
									<button class="btn right add_field_button" disabled="disabled">
										<span style="font-size: 20px;">+</span>
										<spring:message code="input.addmorefile" />
									</button>
								</div>

								<div class="row myRow">
									<span><spring:message code="input.requiredfields" /><span
										class="star">*</span></span>
								</div>
								<div class="row">
									<div class="center">
										<button class="btn" id="trcSubmitButton" type="submit">
											<spring:message code="button.submit" />
										</button>
										<a href="./manageTypeDevices2" class="btn" id="Cancel"
											style="margin-left: 10px;"><spring:message
												code="button.cancel" /></a>
									</div>
								</div>

							</form>
						</div>
					</div>

				</div>

			</div>
		</div>

		<!--end container-->
	</section>


	<div id="RegisterManageTypeDevice" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.submitTypeApprove" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="sucessMessage"><spring:message code="TRCRegister_futureRef"/>  <span id="txnId"></span></h6>
				<input type="text" style="display: none" id="errorCode">
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a href="./manageTypeDevices2" class="btn"><spring:message
							code="modal.ok" /></a>
				</div>
			</div>
		</div>
	</div>

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
					<br> <br>
					<spring:message code="fileValidationSize" />
				</h6>
				<input type="text" id='removeFileId' style="display: none;">
			<input type="text" id='removeFileInput' style="display: none">
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class=" btn" onclick="clearFileName()"
							style="margin-left: 10px;">
							<spring:message code="modal.ok" />
						</button>
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

		<script
		src="${context}/resources/custom_js/moment.min.js"></script>
	
		<script type="text/javascript"
		src="${context}/resources/project_js/select2.js"></script>
	
	<script type="text/javascript"
		src="${context}/resources/project_js/importerTypeApproved.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript">
		populateCountries("country");
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
		/*  request.setAttribute("msg", "  Please login first");
		request.getRequestDispatcher("./index.jsp").forward(request, response);  */
%>
<script language="JavaScript">
	sessionStorage.setItem("loginMsg", "*Session has been expired");
	window.top.location.href = "./login";
</script>
<%
	}
%>
