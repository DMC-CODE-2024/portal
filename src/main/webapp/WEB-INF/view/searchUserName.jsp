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

<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">

<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
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
<body data-id="12" data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}">


	<!-- //////////////////////////////////////////////////////////////////////////// -->

	<!-- START CONTENT -->
	<section id="content">

		<div class="row card-panel">
			<div class="container-fluid pageHeader">
				<p class="PageHeading"><spring:message code="view.griev" /></p>
			</div>
			<div class="row">
				<div class="col s12 m12" style="margin-top: 20px;">
					<form action="" onsubmit="return hide()" method="post" >
					<div id="submitbtn">
						<div class="input-field col s12 m2">
							<label for="Search" class="center-align ml-10"><spring:message code="input.userName" /></label>
						
						</div>
						
						<div class="input-field col s12 m3 l3">
							<input type="text" id="Search" name="Search"
								pattern="[A-Za-z0-9]{1,12}" maxlength="30"
								oninput="InvalidMsg(this,'input','<spring:message code="validation.30username" />');" 
								  oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30username" />');"
								placeholder="<spring:message code="table.UserName" />" required>
						</div>
							
						<div class="input-field col s12 m2 l2">
						 <button class="btn" type="submit"><spring:message code="button.submit" /></button>
							<%-- <button type="button" class="btn"  id="submit" onclick="hide();"><spring:message code="button.submit" /></button> --%>
						</div>
						<%-- <div class="col s12 m12"><p id="errorMsgOnModal" class="nidValidationMsg"><spring:message code="validation.12NID" /></p></div> --%>
					</div>
					</form>
				</div>
			</div>
			
					<div class="row card-panel responsive-page" id="endUserRaiseGrievance" style="display: none">
                            <form onsubmit="return saveaAonymousGrievance()" method="POST" enctype="multipart/form-data" id="saveGrievance">
                             <input type="text" id="pageTypeValue" value="${reportType}" style="display: none;">
                                <div class="col s12 m12 l12">
                                    <div class="row">
                                        <div class="input-field col s12 m4">
                                            <input type="text" id="firstName"  name="firstName" pattern="[a-zA-Z]{0,20}" required="required"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"/>
                                            <label for="firstName"><spring:message code="input.firstName" /> <span class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m4">
                                            <input type="text" id="middleName" name="middleName" pattern="[a-zA-Z]{0,20}"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');" maxlength="20" />
                                            <label for="middleName"><spring:message code="input.middleName" /></label>
                                        </div>

                                        <div class="input-field col s12 m4">
                                            <input type="text" id="lastName" name="lastName" pattern="[a-zA-Z]{0,20}" 
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													 required   maxlength="20" />
                                            <label for="lastName"><spring:message code="input.lastName" /> <span class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m6">
                                            <input type="text" id="contactNumber" name="contactNumber" pattern="[0-9]{10,12}"
 													oninput="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
												  required   maxlength="10" />
                                            <label for="contactNumber"><spring:message code="input.contactNum" /><span
                                                    class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m6">
                                            <input type="email" id="emailID" name="emailID" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" 
											oninput="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
												required maxlength="30" />
                                            <label for="emailID"><spring:message code="input.EmailID" /><span class="star">*</span></label>
                                        </div>

                                        <div class="col s12 m6 selectDropdwn">
                                            <label for="endUsercategory"><spring:message code="input.Category" /> <span class="star">*</span></label>
                                            <select class="browser-default" 
											title="<spring:message code="" />" oninput="setCustomValidity('')"  
										            oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
										  required   id="endUsercategory">
                                                <option value="" disabled selected><spring:message code="input.Category" /></option>
                                            </select>
                                        </div>

                                        <div class="input-field col s12 m6">
                                            <textarea id="endUserRemark" 
										  oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
													
												  required   maxlength="200" class="materialize-textarea"></textarea>
                                            <label for="endUserRemark"><spring:message code="input.Remark" /><span
                                                    class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m6">
                                            <input type="text" id="endUsertransactionId" name="transactionId"
                                                pattern="[A-Z0-9]{18,18}"
      										 oninput="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
												maxlength="18" />
                                            <label for="endUsertransactionId"><spring:message code="input.TransactionID1" /></label>
                                        </div>

                                    </div>
									<div id="endUsermainDiv" class="endUsermainDiv">
									<div id="endUserfilediv" class="endUserfileDiv">	
                                    <div class="row">
                                        <div class="col s12 m6">
                                            <label for="endUserdocTypetag1"><spring:message code="input.documenttype" /></label>
                                            
                                            <select class="browser-default" id="endUserdocTypetag1"
                                                     oninput="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
                                             onchange="enableSelectFile()">
                                            
                                                <option value="" disabled selected><spring:message code="select.documenttype" /></option>
                                            </select>
                                        </div>

                                        
                                        <div class="file-field col s12 m6">
                                            <h6 class="upload-file-label" id="endUserFileLabel"><spring:message code="modal.UploadSupporting" />
                                            </h6>
                                            <div class="btn">
                                                <span><spring:message code="input.selectfile" /></span>
                                                <input id="endUserdocTypeFile1" type="file"   onchange="enableEndUserAddMore()" disabled="disabled"
 												
						oninput="InvalidMsg(this,'input','<spring:message code="validation.NoChosen" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.NoChosen" />');"
						 name="files[]" id="filer_input"
                                                    multiple="multiple" />
                                            </div>
                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text"
                                                    placeholder="<spring:message code="input.selectfile" />">
                                            </div>
                                        </div>

                                        <div class="input_fields_wrap"></div>

                                      
                                       
                                    </div>
									</div>
									</div>	

                                      <div class="col s12 m6 right">
                                            <button class="btn right endUser_add_field_button" disabled="disabled"><span
                                                    style="font-size: 20px;">+</span><spring:message code="input.addmorefile" /></button>
                                        </div>
                                         <p><spring:message code="input.requiredfields" /> <span class="star">*</span></p>
                                    <div class="row" style="margin-top: 30px;">
                                        <div class="input-field col s12 m12 l12 center">
                                            <button class="btn" id="saveAnonymousGrieavance" type="submit"><spring:message code="button.submit" /></button>
                                            <a onclick="openCancelPopUp()" class="btn"
                                                style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
                                        </div>
                                    </div>

                                </div>
                            </form>
                        </div>
		</div>
	</section>
	
	
	
		<div id="ErrorPopup" class="modal modal-small"
		style=" display: none;">
		<h6 class="modal-header">
			<spring:message code="view.griev" />

		</h6>
		<div class="modal-content">
			<div class="row">
				<h6>
					<spring:message code="tagOnlyForExternal" />
					<%-- 	<spring:message code="Reg_flag_off" /> --%>
				</h6>
			</div>
			<div class="input-field col s12 center">
				<div class="input-field col s12 center">
					
									<a href="JavaScript:Void(0);"
							class="modal-close btn"><spring:message code="modal.ok" /></a>
					<%-- <a href="#"
						class="modal-close btn" style="margin-left: 10px;"><spring:message
							code="modal.no" /></a> --%>
				</div>
			</div>
		</div>
	</div>
	
	
	
<!--materialize js-->
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>
	
<script type="text/javascript"
	src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>





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
		

	<script type="text/javascript"
		src="${context}/resources/project_js/searchUserName.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
<script type="text/javascript"
		src="" async></script>
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