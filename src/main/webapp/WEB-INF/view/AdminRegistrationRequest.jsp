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

<body data-id="8" data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" 	
data-selected-username="${username}"
data-selected-roleType="${selectedUserTypeId}" 
data-stolenselected-roleType="${stolenselectedUserTypeId}" 
session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}"
data-session-id="${not empty param.id ? param.id : 'null'}"
data-session-roles="${not empty param.roles ? param.roles : 'null'}"
data-session-type="${not empty param.type ? param.type : 'null'}"
data-session-source="${not empty param.source ? param.source : 'menu'}">


	<!-- START CONTENT -->
	<!-- START CONTENT -->
<%-- 	<section id="content">
		<!--start container-->
			<div id="initialloader"></div>
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div class="container-fluid pageHeader" id="pageHeader">

								<a href="" class="boton right" id="btnLink"></a>
							</div>
							<form action="${context}/registrationRequest" id="viewFilter"
								method="post">
								<div class="registrationTableDiv_box" id="registrationTableDiv"
									style="padding-bottom: 5px; background-color: #e2edef52;">
									<div id="filterBtnDiv">
										
									</div>
								</div>
							</form>
							<table id="registrationLibraryTable"
								class="responsive-table striped display"></table>

						</div>

					</div>
				</div>
				<div id="footerBtn"></div>
			</div>
		</div>
		<!--end container-->
	</section> --%>

   	<body>

            <div class="content-box">
                <div class="content-container">
                    <div class="content-header" id="pageHeader">
                       <!--  <h1>Grievance Management</h1> -->
                    </div>
                    <div class="filter-box">
                        <form action="${context}/registrationRequest" id="registrationfilterform"
								method="post" class="filter-row">
       					<div id="registrationTableDiv" class="filter-form-row"></div>
       					<div id="registrationTableButtonDiv" class="filter-btn-row"></div>
       						
                        </form>
                    </div>
                    <div class="table-box">
                        <div class="table-responsive">
                            <table id="registrationLibraryTable" class="table">
                            	<thead class="thead-dark"></thead>
                            </table>
                        </div>
                        <div id="footerBtn" class="table-paginationbox">
                        </div>
                    </div>
                </div>
            </div>
        
 </body>
   
	<div id="approveInformation" class="modal">
           <h6 class="modal-header"><spring:message code="modal.header.approve" /></h6>
           <div class="modal-content">
            <div class="row">
                <form action="">
                 	<h6> <spring:message code="registration.thetransactionid" /><span id="registrationTxnId"> </span> <spring:message code="registration.pendingforapproval" /></h6>
                    <p><spring:message code="registration.dorequest" /></p>
                    <input type ="text" id="sessionUserName" hidden="hidden">
                    	
                </form>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a onclick="aprroveUser()" class="btn modal-trigger"><spring:message code="modal.yes" /></a>
                    <button class="btn modal-close" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
                      <span id="userId" hidden></span>
                       <span id="adminCurrentStatus" hidden></span>
                </div>
            </div>
        </div>
    </div>
	<div id="confirmApproveInformation" class="modal" style="width: 40%; z-index: 1005; opacity: 1; transform: scaleX(1); top: 10%;">
               <h6 class="modal-header"><spring:message code="modal.header.approve" /></h6>
                <div class="modal-content">
            <div class="row">
                <form action="">
            
                    <h6><spring:message code="registration.approveEmailregister" />.</h6>
                   
                </form>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                     <a class="btn modal-close" href="./registrationRequest"><spring:message code="modal.ok" /></a>
                   
                </div>
            </div>
        </div>
    </div>
	<div id="rejectInformation" class="modal">
	<div class="header-fixed header-fixed-style">
           <h6 class="modal-header"><spring:message code="modal.header.reject" /></h6>
           </div>
            <form action="" onsubmit="return rejectUser()">
            <div class="scrollDivHeight"></div>
            <div class="modal-content">
           
            <div class="row">
                <h6><spring:message code="registration.doreject" /></h6>
                    <div class="input-field" style="margin-top: 30px;">
                    
                        <textarea id="Reason"
                        oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
						oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');" 
                         class="materialize-textarea" style="min-height: 8rem;" maxlength="200"  required></textarea>
                        <label for="Reason" style="margin-left: -10px;"><spring:message code="input.remarks" /><span class="star">*</span></label>
                    </div>
                    
                    <input type ="text" id="rejectUserName" hidden="hidden">
               
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <button type="submit" class="btn" type="submit">
								<spring:message code="modal.yes" />
							</button>
                    <button class="modal-close btn" type="button" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
                </div>
            </div>
        </div>
        </form>
    </div>
	<div id="confirmRejectInformation" class="modal">
         <h6 class="modal-header"><spring:message code="registration.reject" /></h6>
          <div class="modal-content">
            <div class="row">
                <form action="">
                  
                    <h6><spring:message code="registration.approveEmailregister" /></h6>
                </form>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a class="btn modal-close" href="./registrationRequest"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>
    
    		<div id="statusChangemodal" class="modal">
               <form action="" onsubmit="return chanegeUserStatus()" method="POST"
								enctype="multipart/form-data" >
								  <div class="row" id="singleInput">
								  <h6 class="modal-header "> <spring:message code="registration.changeUserStatus" /></h6>
                                <div class="col s12 m12 l12">
                   	   
                                   <div class="row"  style="margin-top: 10px">
                                        	<div class="col s12 m6 l6" style="margin-bottom: 5px;">
											<label for="userStatus"><spring:message
													code="select.changeUserStatus" /> <span class="star">*</span></label>
											<select id="userStatus" class="browser-default"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												required>
												<option value="" selected><spring:message
														code="select.selectUserStatus" />
												</option>
											</select>
										</div> 
                                       		
                                       
										
									<div class="input-field col s12 m6" style="margin-top: 22px;">
										<input type="text" name="refererence" id="statusrefererenceId"
							placeholder="" oninput="InvalidMsg(this,'input','<spring:message code="validation.50character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50character" />');"
							maxlength="50"/> <label for="refererenceId"
							class="center-align"><spring:message
								code="input.refId" /> </label>
								</div>		
                                            
                   		  
								<div class="input-field col s12 m12">
							<textarea id="changeStatusRemark" style="min-height: 8rem;" 
								class="materialize-textarea" 
							oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
							oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');" maxlength="50" required></textarea>
							<label for="textarea1" class=""><spring:message
									code="input.remarks" /> <span class="star">*</span> </label>
								</div>
						
                                   
                                        </div>
                                 		 
                                        <div class="row">
                                            <div class="input-field col s12 center" style="padding: 20px 0;">
                                                <!-- <a href="#submitIMEI" class="btn modal-trigger">Submit</a>  -->
                                                 <button class=" btn" type="submit"><spring:message code="button.submit" /></button>
                                               	<button type="button" onclick = "resetButtons()" class="btn modal-close" style="margin-left: 10px;" title=" "><spring:message code="button.cancel" /></button>
                                            </div>

                                        </div>
                                      
									
                                    </div>
                                   </div></form>
                    </div>           
    
    <div id="confirmUserStatus" class="modal">
         <h6 class="modal-header"><spring:message code="registration.changeUserStatus" /></h6>
          <div class="modal-content">
            <div class="row">
                <form action="">
                  
                    <h6 id ="statusChangedMessage"></h6>
                </form>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a class="btn modal-close" href="./registrationRequest"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>
    
    	<div id="statusRoleChange" class="modal">
           <h6 class="modal-header"><spring:message code="table.RegistrationRequest" /></h6>
           <div class="modal-content">
            <div class="row">
              
                   <h5 class="center">
						<label> <input name="group1" type="radio" value="0"
							onclick="userChangeStatus('status');"/>
							<span class="checkboxFont"> <spring:message code="registration.changeUserStatus" /></span></label>
									
						 <label> <input name="group2" type="radio" value="1"
							onclick="userChangeStatus('roleType')"/>
							<span class="checkboxFont"> <spring:message code="changeRoleType" /></span>
						</label> 
					</h5>
							  
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <button class="btn modal-close" onclick = "resetButtons()"style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
                </div>
            </div>
        </div>
    </div>
    
    
    <div id="roleTypeChangemodal" class="modal">
               <form action="" onsubmit="return chanegeRole()" method="POST"
								enctype="multipart/form-data">
								  <div class="row" id="singleInput">
								  <h6 class="modal-header "> <spring:message code="changeRoleType" /></h6>
                                <div class="col s12 m12 l12">
                   	   
                                   <div class="row"  style="margin-top: 10px">
                                        	
                            
                                        <div class="col s12 m6 l6" style="margin-bottom: 5px;">
											<label for="addDeleteRole"><spring:message
													code="select.AddDeleteRole"/> <span class="star">*</span></label>
											<select id="addDeleteRole" class="browser-default"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												required>
												<option value="" disabled selected><spring:message code="select.AddDeleteRole" /></option>
												<option value="1"><spring:message code="select.add" /></option>
												<option value="2"><spring:message code="select.delete"/></option>
											</select>
										</div> 
                                        	
                                        	
                                        <div class="col s12 m6 l6" style="margin-bottom: 5px;">
											<label for="usertypes"><spring:message
													code="changeRoleType" /> <span class="star">*</span></label>
											<select id="usertypes" class="browser-default"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												required>
												<option value="" selected><spring:message
														code="select.changeUserRole" />
												</option>
											</select>
										</div> 
                                       		
                                       
										
									<div class="input-field col s12 m6" style="margin-top: 22px;">
										<input type="text" name="refererence" id="RoleRefererenceId"
							placeholder="" oninput="InvalidMsg(this,'input','<spring:message code="validation.50character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50character" />');"
							maxlength="50"/> <label for="RoleRefererenceId"
							class="center-align"><spring:message
								code="input.refId" /> </label>
								</div>		
                                            
                   		  
								<div class="input-field col s12 m6">
							<textarea id="changeRoleRemark" style="min-height: 8rem;" 
								class="materialize-textarea" 
							oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
							oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');" maxlength="50" required></textarea>
							<label for="textarea1" class=""><spring:message
									code="input.remarks" /> <span class="star">*</span> </label>
								</div>
						
                                   
                                        </div>
                                 		 
                                        <div class="row">
                                            <div class="input-field col s12 center" style="padding: 20px 0;">
                                                <!-- <a href="#submitIMEI" class="btn modal-trigger">Submit</a>  -->
                                                 <button class=" btn" type="submit"><spring:message code="button.submit" /></button>
                                               	<button type="button" onclick = "resetButtons()" class="btn modal-close" style="margin-left: 10px;" title=" "><spring:message code="button.cancel" /></button>
                                            </div>

                                        </div>
                                      
									
                                    </div>
                                   </div></form>
                    </div>           

    	<div id="ErrorModel" class="modal">
     <h6 class="modal-header" style="margin:0px;"><spring:message code="changeRoleType" /></h6>
        <div class="modal-content">
            
            <div class="row">
                <h6 id="ErrorFieldMessage"></h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <button class="btn modal-close" style="margin-left: 10px;" title="" data-original-title=" "><spring:message code="modal.ok" /></button>
                </div>
            </div>
        </div>
    </div>	
	
	<!-- Modal start   -->

	<div id="tableOnModal" class="modal">
		
		
				<div class="header-fixed header-fixed-style">
				<button type="button"
			class=" modal-action modal-close waves-effect waves-green btn-flat right"
			data-dismiss="modal">&times;</button>
			<h6 class="modal-header">
			<spring:message code="modal.header.viewHistory" />
		</h6>
		</div>

		<div class="scrollDivHeight"></div>

		<div class="modal-content modal-content-style">
		

			<div class="row">
				<table class="responsive-table striped display"
					id="registration-data-table-history" cellspacing="0">
				</table>
			</div>
		</div>
	</div>
	<!-- Modal End -->
	
	
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
		src="${context}/resources/project_js/AdminRegistrationRequest.js?version=<%= (int) (Math.random() * 10) %>"></script>
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