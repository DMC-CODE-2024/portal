<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!--<title>TRC </title>-->

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
	href="${context}/resources/css/grievance.css">



</head>

<body data-id="8" data-roleType="${usertype}" data-userTypeID="${usertypeId}" 
data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}" 
data-stolenselected-roleType="${stolenselectedUserTypeId}"
data-session-id="${not empty param.id ? param.id : 'null'}"
data-session-roles="${not empty param.roles ? param.roles : 'null'}"
data-session-type="${not empty param.type ? param.type : 'null'}"
>


	<!-- START CONTENT -->
	<!-- START CONTENT -->
		<section id="content" style="margin:0 0.5rem">
                <!--start container-->
                <div class="container">
                    <div class="section">
                        <form action="${context}/trcInformation" method="post" >
							<div class="card-panel">
                                <div class="row">
                                    <div class="col s12 m12">
                                        <h5><spring:message code="input.ViewTRC" /></h5>
                                        <hr>
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="input-field col s12 m4 l4">
                                                <input type="text" name="firstName" id="firstName" maxlength="20" value="${registration.firstName}" disabled="" placeholder="">
                                                <label for="firstName" class="center-align active"><spring:message code="input.firstName" /> </label>
                                            </div>

                                            <div class="input-field col s12 m4 l4">
                                                <input type="text" name="middleName" id="middleName" maxlength="20" value="${not empty registration.middleName ? registration.middleName : 'NA'}"  disabled="" placeholder="">	
                                                <label for="middleName" class="active"><spring:message code="input.middleName" /></label>
                                            </div>

                                            <div class="input-field col s12 m4 l4">
                                                <input type="text" name="lastName" id="lastName" maxlength="20" value="${registration.lastName}" disabled="" placeholder="">
                                                <label for="lastName" class="active"><spring:message code="input.lastName" /></label>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="input-field col s12 m12 l12">
                                                <input type="text" name="address" id="address" value="${registration.propertyLocation}" disabled="" placeholder="">
                                                <label for="address" class="active"><spring:message code="input.address" /> </label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="streetNumber" id="streetNumber" maxlength="30" value="${registration.street}" disabled="" placeholder="">
                                                <label for="streetNumber" class="active"><spring:message code="input.streetNumber" /> </label>
                                            </div>
                                            
                                            <div class="input-field col s12 m6 l6">
												<input type="text" name="village" id="village" maxlength="20" value="${not empty registration.village ? registration.village : 'NA'}" disabled="" placeholder="">
												<label for="village"><spring:message code="input.village" /></label>
											</div>
											

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="locality" id="locality" maxlength="20" value="${not empty registration.locality ? registration.locality : 'NA'}" disabled="" placeholder="">
                                                <label for="locality" class="active"><spring:message code="input.locality" /> </label>
                                            </div>
											
											<div class="input-field col s12 m6 l6">
												<input type="text" name="district" id="district" maxlength="20" value="${registration.district	}" disabled="" placeholder="">
												<label for="district"><spring:message code="input.district" /></label>
											</div>
											
											<div class="input-field col s12 m6 l6">
                                      			 <input type="text" name="commune" id="commune" maxlength="20" value="${registration.commune}" disabled="" placeholder="">
                                      			 <label for="commune" class="active"><spring:message code="input.commune" /></label>
                                  			</div>
                                  			
                                  			<div class="input-field col s12 m6 l6">
									 			 <input type="text" name="pin" id="pin" maxlength="20" value="${registration.postalCode}" disabled="" placeholder="">
									  			<label for="pin"><spring:message code="registration.postalcode" /> </label>
											</div> 	
											
                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="country" id="country" maxlength="20" value="${registration.country}" disabled="" placeholder="">
                                                <label for="country" class="active"><spring:message code="input.Country" /> </label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="Province" id="Province" maxlength="20" value="${registration.province}" disabled="" placeholder="">
                                                <label for="Province" class="active"><spring:message code="input.province" /></label>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="NationalID" id="NationalID" maxlength="30" value="${registration.passportNo}" disabled="" placeholder="">
                                                <label for="NationalID" class="active"><spring:message code="registration.nationalid" /> </label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="uploadNationalId" id="uploadNationalId" maxlength="30" value="${registration.nidFilename}" disabled="">
                                                <label for="uploadNationalId" class="active"><spring:message code="registration.uploadednationalid" /> </label>
                                                 <span><a href="#" onclick="previewRegistrtionFile('${registration.nidFilePath}','${registration.nidFilename}')"><spring:message code="registration.preview" /> </a></span>  
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="uploadPhoto" id="uploadPhoto" maxlength="30" value="${registration.photoFilename}" disabled="">
                                                <label for="uploadPhoto" class="active"><spring:message code="registration.uploadedphoto" /> </label>
                                                <span> <a href="#" onclick="previewRegistrtionFile('${registration.photoFilePath}','${registration.photoFilename}')"><spring:message code="registration.preview" /> </a> </span> 
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="employeeID" id="employeeID" maxlength="30" value="${registration.employeeId}" disabled="" placeholder="">
                                                <label for="employeeID" class="active"><spring:message code="registration.employeeid" /> </label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="uploadIdCard" id="uploadIdCard" maxlength="30" value="${registration.idCardFilename}" disabled="">
                                                <label for="uploadIdCard" class="active"><spring:message code="registration.uploadedidcard" /> </label>
                                              <span>  <a href="#" onclick="previewRegistrtionFile('${registration.idCardFilePath}','${registration.idCardFilename}')"><spring:message code="registration.preview" /> </a>  </span>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="natureOfEmployment" id="natureOfEmployment" maxlength="30" value="${registration.natureOfEmploymentInterp}" disabled="" placeholder="">
                                                <label for="natureOfEmployment" class="active"><spring:message code="registration.natureofemployment" /></label>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="designation" id="designation" maxlength="30" value="${registration.designation}" disabled="" placeholder="">
                                                <label for="designation" class="active"><spring:message code="registration.designationandtitle" /> </label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="reportingAuthorityName" id="reportingAuthorityName" maxlength="30" value="${not empty registration.authorityName ? registration.authorityName : 'NA'}" disabled="" placeholder="">
                                                <label for="reportingAuthorityName" class="active"><spring:message code="registration.reportingauthorityname" /></label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="reportingAuthorityEmail" id="reportingAuthorityEmail" maxlength="30" value="${registration.authorityEmail}" disabled="" placeholder="">
                                                <label for="reportingAuthorityEmail" class="active"><spring:message code="registration.ReportingAuthorityEmailid" /></label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="reportingAuthorityContact" id="reportingAuthorityContact" maxlength="30" value="${registration.authorityPhoneNo}" disabled="" placeholder="">
                                                <label for="reportingAuthorityContact" class="active"><spring:message code="registration.reportingauthoritycontactnumber" /></label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="email" id="email" maxlength="30" value="${registration.email}" disabled="" placeholder="">
                                                <label for="email" class="active"><spring:message code="input.email" /> </label>
                                            </div>

                                            <div class="input-field col s12 m6 l6">
                                                <input type="text" name="phone" id="phone" maxlength="10" value="${registration.phoneNo}" disabled="" placeholder="">
                                                <label for="phone" class="active"><spring:message code="input.contactNum" /> </label>
                                            </div>
                                            
                                            <div class="input-field col s12 m6">
                                   				 <input type="text" name="approvedBy" id="approvedBy" value="${not empty registration.user.approvedBy ? registration.user.approvedBy : 'NA'}" maxlength="16" placeholder="" disabled="">
                                   				 <label for="approvedBy" class="active"><spring:message code="registration.approedBy" /> </label>
                               			   </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col s12 m12">
                                        <div class="input-field col s12 center">
                                            <!-- <a href="index.html" class="btn" id="btnSave"> Submit</a> -->
                                             <a class="btn modal-close" href="./registrationRequest?txnID=${not empty param.txnID ? param.txnID : 'null'}&source=${not empty param.source ? param.source : 'null'}"><spring:message code="modal.cancel" /></a>
                                        </div>
                                    </div>
                                </div>

                        
                    </div></form>
                </div>
                <!--end container-->
            </div></section>
            
           <!-- Preview Modal start   -->

	<div id="viewuplodedModel" class="modal">
	<a href="#!" class="modal-close waves-effect waves-green btn-flat">&times;</a>
		<div class="modal-content">
			<div class="row">
					<img src="" id="fileSource" width="400" height="400">
			</div>
		</div>
	</div>
	<!-- Modal End -->
     

	
	<!--materialize js-->
	<script type="text/javascript"
		src="${context}/resources/custom_js/materialize.min.js"></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	

	
	<script
		src="${context}/resources/custom_js/moment.min.js"></script>



	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
	<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>

	
	<!--custom-script.js - Add your own theme custom JS-->


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

<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
		
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