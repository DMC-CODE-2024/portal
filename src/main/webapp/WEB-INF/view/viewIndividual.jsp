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
<!--<title>Individual</title>-->

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


<link rel="stylesheet"
	href="${context}/resources/project_css/viewConsignment.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
	<link rel="stylesheet"
	href="${context}/resources/css/grievance.css">



</head>

<body data-id="8" data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}" data-stolenselected-roleType="${stolenselectedUserTypeId}">

	<section id="content">
        <!--start container-->
        <div class="container">
            <div class="section">
                <form id="registrationForm">
                    <div class="card-panel registration-form">
                        <div class="row">
                         <h5><spring:message code="input.ViewIndividual" /></h5>
                            <hr>
                            <div class="row" style="margin-top: 10px;">
                                <div class="input-field col s12 m4 l4">
                                    <input type="text" name="firstName" id="firstName" value="${registration.firstName}" maxlength="20" placeholder="" disabled="">
                                    <label for="firstName" class="center-align active"><spring:message code="input.firstName" /></label>
                                </div>

                                <div class="input-field col s12 m4 l4">
                                    <input type="text" name="middleName" id="middleName" value="${not empty registration.middleName ? registration.middleName : 'NA'}"  maxlength="20" placeholder="" disabled="">
                                    <label for="middleName" class="active"><spring:message code="input.middleName" /></label>
                                </div>

                                <div class="input-field col s12 m4 l4">
                                    <input type="text" name="lastName" id="lastName" value="${registration.lastName}" maxlength="20" placeholder="" disabled="">
                                    <label for="lastName" class="active"><spring:message code="input.lastName" /> </label>
                                </div>

                                <div class="input-field col s12 m6">
                                    <input type="text" name="asType" id="asType" value="${registration.asTypeName}" maxlength="20" placeholder="" disabled="">
                                    <label for="asType" class="active"><spring:message code="input.AsType" /></label>
                                </div>

                                <div class="input-field col s12 m6 l6" id="passportNumberDiv">
                                    <input type="text" name="passportNumber" id="passportNumber" value="${registration.passportNo}" maxlength="20" placeholder="" disabled="">
                                    <label for="passportNumber" class="active"><spring:message code="registration.nationalid" /></label>
                                </div>

                                <div class="input-field col s12 m6 l6">
                                    <input type="text" name="nationalityInformation" id="nationalityInformation" value="${registration.nidFilename}" maxlength="20" value="file.csv" disabled="">
                                    <label for="nationalityInformation" class="active"><spring:message code="registration.UploadNationalityInformation"/> </label>
                                   <span> <a href="#" onclick="previewRegistrtionFile('${registration.nidFilePath}','${registration.nidFilename}')"><spring:message code="registration.preview" /> </a></span> 
                                    
                                </div>

                                

                                <div class="input-field col s12 m6 l6">
                                    <input type="text" name="email" id="email" maxlength="30" value="${registration.email}" placeholder="" disabled="">
                                    <label for="email" class="active"><spring:message code="input.email" /></label>
                                </div>

                                <div class="input-field col s12 m6 l6">
                                    <input type="text" name="phone" id="phone" value="${registration.phoneNo}" maxlength="10" placeholder="" disabled="">
                                    <label for="phone" class="active"><spring:message code="input.contactNum" /> </label>
                                </div>


                            </div>

                            <div class="row">
                                <div class="input-field col s12 m12 l12">
                                    <input type="text" name="address" id="address" value="${registration.propertyLocation}" placeholder="" disabled="">
                                    <label for="address" class="active"><spring:message code="input.address" /></label>
                                </div>

                                <div class="input-field col s12 m6 l6">
                                    <input type="text" name="streetNumber" id="streetNumber" value="${registration.street}" maxlength="30" placeholder="" disabled="">
                                    <label for="streetNumber" class="active"><spring:message code="input.streetNumber" /></label>
                                </div>
                                
                                <div class="input-field col s12 m6 l6">
									<input type="text" name="village" id="village" maxlength="20" value="${not empty registration.village ? registration.village : 'NA'}" disabled="" placeholder="">
									<label for="village"><spring:message code="input.village" /></label>
								</div>

                                <div class="input-field col s12 m6 l6">
                                    <input type="text" name="locality" id="locality" value="${not empty registration.locality ? registration.locality : 'NA'}" maxlength="20" placeholder="" disabled="">
                                    <label for="locality" class="active"><spring:message code="input.locality" /></label>
                                </div>
                                
                                <div class="input-field col s12 m6 l6">
									<input type="text" name="district" id="district" maxlength="20" value="${registration.district	}" disabled="" placeholder="">
									<label for="district"><spring:message code="input.district" /></label>
								</div>
                                
                                
                                 <div class="input-field col s12 m6 l6">
                                       <input type="text" name="commune" id="commune" maxlength="20" value="${registration.commune}" disabled="" placeholder="">
                                       <label for="commune" class="active"><spring:message code="input.commune" /> </label>
                                  </div>
								
								<div class="input-field col s12 m6 l6">
									  <input type="text" name="pin" id="pin" maxlength="20" value="${registration.postalCode}" disabled="" placeholder="">
									  <label for="pin"><spring:message code="registration.postalcode" /> </label>
								</div> 	
									
                                
                                <div class="input-field col s12 m6 l6">
                                    <input type="text" name="country" id="country" value="${registration.country}" maxlength="20" placeholder="" disabled="">
                                    <label for="country" class="active"><spring:message code="input.Country" /></label>
                                </div>
                                
                                
                                <div class="input-field col s12 m6 l6">
                                    <input type="text" name="province" id="province" value="${registration.province}" maxlength="20" placeholder="" disabled="">
                                    <label for="province" class="active"><spring:message code="input.province" /></label>
                                </div>
						</div>

                            <div class="row">
                                    <div class="col s12 m6 l6">
                                            <label for="vatNumber"><spring:message code="registration.vatregistration" /> </label>
                                            <div class=" boxHeight">
                                                <input type="text" id="vat" value="${registration.vatStatus}" hidden="hidden">
                                                <input class="with-gap" name="group3" id="yes" type="radio"  disabled=""><spring:message code="modal.yes" />
                                                <input class="with-gap" name="group3" id="no" type="radio" style="margin-left: 20px;" disabled=""><spring:message code="modal.no" />
                                            </div>
                               </div>

                                <%-- <div class="input-field col s12 m6" id="userTypeNameField">
                                    <input type="text" name="roleType" id="roleType"  value="${registration['user'].usertype.usertypeName}" maxlength="16" placeholder="" disabled="">
                                    <label for="roleType" class="active"><spring:message code="table.RoleType" /> </label>
                                </div> --%>
                                
                                <div class="input-field col s12 m6 l6"  items="${registration.rolesList}" var="List"  >
										 <c:forEach items="${registration.rolesList}" var="List" varStatus="loop">
									<c:out value="${registration.rolesList[loop.index]['role']}"/>
									<c:if test="${!loop.last}">,</c:if>
                                          </c:forEach>  
                                          <input type="text" name="roleType" disabled="" id="roleType"  value="${registration.rolesList[loop.index]['role']}" maxlength="16" placeholder="">
                                   		  <label for="roleType" class="active"> <spring:message code="registration.roletype"/></label>
                                  </div>

                                <div class="input-field col s12 m6" id="vatNumberField" style="display: none;">
                                    <input type="text" name="vatNumber" id="vatNumber" value="${registration.vatNo}" maxlength="16" placeholder="" disabled="">
                                    <label for="vatNumber" class="active"><spring:message code="registration.vatnumber" /> </label>
                                </div>
                                
                                 <div class="input-field col s12 m6 l6" id="uploadedvatFileDiv" style="display: none;" >
                                    <input type="text" name="vatFile" id="uploadedVatFile" value="${registration.vatFilename}" maxlength="20"  disabled="">
                                    <label for="ploadedVatFile" class="active"><spring:message code="registration.uploadedVatFile"/> </label>
                                   <span> <a href="#" onclick="previewRegistrtionFile('${registration.vatFilePath}','${registration.vatFilename}')"><spring:message code="registration.preview" /> </a></span> 
                                </div>
                                
                                 <div class="input-field col s12 m6">
                                    <input type="text" name="approvedBy" id="approvedBy" value="${not empty registration.user.approvedBy ? registration.user.approvedBy : 'NA'}" maxlength="16" placeholder="" disabled="">
                                    <label for="approvedBy" class="active"><spring:message code="registration.approedBy" /> </label>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                          	<div class="input-field col s12 center">
                                  <a class="btn modal-close" href="./registrationRequest?txnID=${not empty param.txnID ? param.txnID : 'null'}&source=${not empty param.source ? param.source : 'null'}"><spring:message code="modal.cancel" /></a>
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


	<!--scrollbar-->
	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
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

	
	
	
		
		<script type="text/javascript">
		var vatStatus = $('#vat').val();
		if(vatStatus== 1){
			$("#yes").prop("checked", true);
			$("#uploadedvatFileDiv").css({"display":"block"});
			$("#vatNumberField").css({"display":"block"});
		}else if(vatStatus == 0){
			$("#no").prop("checked", true);
		}
		
		
		
		</script>
<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
<script type="text/javascript">var countHit="";  $( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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