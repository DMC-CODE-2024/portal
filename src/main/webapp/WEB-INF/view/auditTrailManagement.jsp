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
long currentTime = new Date().getTime();
long dfd = accessTime + timeout;
if (currentTime < dfd) {
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
<!-- <head> <title>EIRS Admin Portal</title> -->


<!--<title>Grievance</title>-->

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
		<link rel="icon" type="image/x-icon" href="${context}/resources/assets/images/logo.png">
		<%-- <link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection"> --%>
		<link rel="stylesheet" href="${context}/resources/assets/css/bootstrap.min.css">
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
	href="${context}/resources/assets/css/iconStates.css">
	
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

 <!-- CORE CSS-->

 
<link rel="stylesheet" href="${context}/resources/assets/css/style.css">

<script>
var contextpath = "${context}";
</script>
</head>
<%-- <body data-roleType="${usertype}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"> --%>
<body data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}" data-stolenselected-roleType="${stolenselectedUserTypeId}">


	<!-- START CONTENT -->
	<!-- START CONTENT -->
	<body>

            <div class="content-box">
                <div class="content-container">
                    <div class="content-header" id="pageHeader">
                       <!--  <h1>Grievance Management</h1> -->
                    </div>
                    <div class="filter-box">
                        <form action="${context}/auditTrail" id="viewFilter"
								method="post" class="filter-row">
       					<div id="errorMsgDiv" class="filter-form-row" style="width: 100%;"></div>
       					<div id="auditTableDiv" class="filter-form-row"></div>
       					<div id="registrationTableButtonDiv" class="filter-btn-row"></div>
       						
                        </form>
                    </div>
                    <div class="table-box">
                        <div class="table-responsive">
                            <table id="auditLibraryTable" class="table">
                            	<thead class="thead-dark"></thead>
                            </table>
                        </div>
                        <div id="footerBtn" class="table-paginationbox">
                        </div>
                    </div>
                </div>
            </div>
        
 </body>

   <!-- Modal 2 start   -->

	<%-- <div id="viewAuditModel" class="modal">
		<h6 class="modal-header"><spring:message code="registration.viewauditmanagement" /></h6>
		<div class="modal-content">

			<div class="row">
				<div class="row" style="margin-top:10px">
					<div class="input-field col s12 m6 l6">
						<input type="text" name="policyOrder" id="viewUserName"
							placeholder="" disabled>
						<label for="viewUserName"><spring:message code="table.UserName" /></label>
					</div>	
						
				
					<div class="input-field col s12 m6 l6" >
						<input type="text" name="TxnId" id="viewTxnId"
							placeholder="" disabled >
						<label for="viewTxnId"><spring:message code="table.transactionID" /></label>
					</div>
					
					
					
					<div class="input-field col s12 m6 l6" >
						<input type="text" name="period" id="viewUserType"
							placeholder="" disabled >
						<label for="viewUserType"><spring:message code="table.userType" /></label>
					</div>
					
					<div class="input-field col s12 m6 l6" >
						<input type="text" name="RoleType" id="viewRoleType"
							placeholder="" disabled >
						<label for="viewRoleType"><spring:message code="table.roleType" /></label>
					</div>
					
						
					<div class="input-field col s12 m6">
						<input type="text" id="viewFeature" name="status"
							placeholder="" maxlength="20" disabled>
						<label for="viewFeature"><spring:message code="table.feature" /></label>
					</div>
			
					
					<div class="input-field col s12 m6">
						<input type="text" id="viewSubFeature" name="status"
							placeholder="" maxlength="20" disabled >
						<label for="viewSubFeature"><spring:message code="table.SubFeature" /></label>
					</div>
					
					<div class="input-field col s12 m6">
						<input type="text" id="viewPublicIp" name="status"
							placeholder=""  disabled >
						<label for="viewPublicIp"><spring:message code="table.publicIp" /></label>
					</div>
					
					<div class="input-field col s12 m6">
						<input type="text" id="viewBrowser" name="status"
							placeholder="" disabled >
						<label for="viewBrowser"><spring:message code="table.browser" /></label>
					</div>
					
				</div>

				
				<div class="row input_fields_wrap">
					<div class="col s12 m12 center" style="margin-top: 10px;">
					<button class="btn modal-close" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
				</div>

				</div>
			</div>
		</div>
	</div> --%>
	
   <div id="viewModal" class="modal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-lg" role="document">
	  <div class="modal-content">
		<div class="modal-header">
		  <h5 class="modal-title"><spring:message code="module.audit.trail.modal.title" /></h5>
		</div>
		<div class="modal-body">
				<div class="form-row">
				  <div class="form-group col-md-6">
					<label for="moduleName"><spring:message code="module.audit.trail.modal.moduleName" /></label>
					<input type="text" name="moduleName" class="form-control" id="moduleName" placeholder="" disabled>
				  </div>
				  <div class="form-group col-md-6">
					<label for="featureName"><spring:message code="module.audit.trail.modal.featureName" /></label>
					<input type="text" name="featureName" class="form-control" id="featureName" placeholder="" disabled >
				  </div>
				</div>

				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="executionTime"><spring:message code="module.audit.trail.modal.executionTime" /></label>
						<input type="text" name="executionTime" class="form-control" id="executionTime" placeholder="" disabled >
					</div>
					<div class="form-group col-md-6">
						<label for="count"><spring:message code="module.audit.trail.modal.count" /></label>
						<input type="text" name="count" class="form-control" id="count" placeholder="" disabled >
					</div>
				  </div>

				  <div class="form-row">
					<div class="form-group col-md-6">
						<label for="count2"><spring:message code="module.audit.trail.modal.count2" /></label>
						<input type="text" id="count2" class="form-control" name="count2" placeholder="" maxlength="20" disabled>
					</div>
					<div class="form-group col-md-6">
						<label for="failureCount"><spring:message code="module.audit.trail.modal.failureCount" /></label>
						<input type="text" id="failureCount" class="form-control" name="failureCount" placeholder="" maxlength="20" disabled >
					</div>
				  </div>

				  <div class="form-row">
					<div class="form-group col-md-6">
						<label for="modal-status"><spring:message code="module.audit.trail.modal.status" /></label>
						<input type="text" id="modal-status" class="form-control" name="modal-status" placeholder=""  disabled >
					</div>
					<div class="form-group col-md-6">
						<label for="info"><spring:message code="module.audit.trail.modal.info" /></label>
						<input type="text" id="info" class="form-control" name="info" placeholder="" disabled >
					</div>
				  </div>
				  	  <div class="form-row">
                  					<div class="form-group col-md-6">
                  						<label for="viewaction"><spring:message code="module.audit.trail.modal.action" /></label>
                  						<input type="text" id="viewaction" class="form-control" name="action" placeholder=""  disabled >
                  					</div>
                  				  </div>
		</div>
		<div class="modal-footer">
			<button class="cancel-product btn modal-close"><spring:message code="modal.close" /></button>
		</div>
	  </div>
	</div>
  </div>
	<!-- Modal End -->

	
	
	
<!--materialize js-->
	
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

	<!-- chartist -->
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
	

	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js"></script>	

	<script type="text/javascript"
		src="${context}/resources/project_js/auditTrailManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>	
		<script type="text/javascript"
		src="" async></script>
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
</body></html>
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
