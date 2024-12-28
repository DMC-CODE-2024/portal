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
<body data-id="41"
	data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}"
	data-selected-username="${username}"
	session-value="en"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}">

	<%-- session-value="${not empty param.NID ? param.NID : 'null'}" --%>

	<!-- START CONTENT -->
	<!-- START CONTENT -->
<%-- 	<section id="content">
		<div id="initialloader"></div>

		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div class="container-fluid pageHeader" id="pageHeader">

								<a class="boton right" id="btnLink"></a>
							</div>
							<form action="${context}/userManagement" id="viewFilter"
								method="post">
								<div class="registrationTableDiv_box" id="userTableDiv"
									style="padding-bottom: 5px; background-color: #e2edef52;">
									<div id="filterBtnDiv"></div>
								</div>
							</form>
							<table id="userLibrarayTableDiv"
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
                        <form action="${context}/userManagement" id="viewFilter"
								method="post" class="filter-row">
       					<div id="userTableDiv" class="filter-form-row"></div>
       					<div id="registrationTableButtonDiv" class="filter-btn-row"></div>
       						
                        </form>
                    </div>
                    <div class="table-box">
                        <div class="table-responsive">
                            <table id="userLibrarayTableDiv" class="table">
                            	<thead class="thead-dark"></thead>
                            </table>
                        </div>
                        <div id="footerBtn" class="table-paginationbox">
                        </div>
                    </div>
                </div>
            </div>
        
 </body>
	
 	 <div id="ViewModel" class="modal">
			<h6 class="modal-header">
				View User
			</h6>
			<div class="modal-content">
				

					<div class="row" style="margin-top: 10px;">
						<div class="input-field col s12 m4">
                                            <input type="text" id="viewfirstName"  name="firstName" pattern="[a-zA-Z]{0,20}" required="required" disabled
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"  >
                                            <label for="viewfirstName"><spring:message code="input.firstName" /> </label>
                                        </div>

                                        <div class="input-field col s12 m4">
                                            <input type="text" id="viewmiddleName" name="middleName" pattern="[a-zA-Z]{0,20}" disabled
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');" maxlength="20" />
                                            <label for="viewmiddleName"><spring:message code="input.middleName" /></label>
                                        </div>
										
										<div class="input-field col s12 m4">
                                            <input type="text" id="viewlastName" name="lastName" pattern="[a-zA-Z]{0,20}"  disabled
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													 required   maxlength="20" />
                                            <label for="viewlastName"><spring:message code="input.lastName" /> </label>
                                        </div>
						
						
						
					</div>

					<div class="row myRow">
								 <div class="input-field col s12 m6">
                                            <input type="text" id="viewcontactNumber" name="contactNumber" pattern="[0-9]{10,12}" disabled
 													oninput="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
												  required   maxlength="10" />
                                            <label for="viewcontactNumber"><spring:message code="input.contact" /></label>
                                        </div>

                                        <div class="input-field col s12 m6">
                                            <input type="email" id="viewemailID" name="emailID" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"  disabled
											oninput="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
												required maxlength="30" />
                                            <label for="viewemailID"><spring:message code="input.EmailID" /></label>
                                        </div>

							</div>			

					<%-- <div class="row myRow">
							 	<div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="viewPassword" name="password" disabled
                                               pattern="[a-zA-Z]{0,20}" required maxlength="18" />
                                            <label for="viewPassword"><spring:message code="registration.password" /><span class="star"> *</span></label>
                                        </div>
                                        
                                        <div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="viewconfirmPassword" name="confirmPassword" disabled
                                               pattern="[a-zA-Z]{0,20}" required maxlength="18" />
                                            <label for="viewconfirmPassword"><spring:message code="registration.retypepassword"/><span class="star"> *</span></label>
                                        </div>
						</div> --%>

					<div class="row myRow">
							
							<div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="viewuserName" name="userName" disabled
                                               pattern="[a-zA-Z]{0,20}" required maxlength="18" />
                                            <label for="viewuserName"><spring:message code="registration.username"/></label>
                              </div>
							
						  <div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="viewuserType" name="userType" disabled
                                               pattern="[a-zA-Z]{0,20}" required maxlength="18" />
                                            <label for="viewuserType"><spring:message code="table.userType"/></label>
                            </div>
                                        
                                   
						</div>
						
						<div class="row myRow">
						
						     						   <div class="col s12 m6 selectDropdwn" style="margin-top: 0px;">         
                                <label for="viewStatus"><spring:message code="table.status" /></label>
                                            <select class="browser-default" disabled 
											title="<spring:message code="" />" 
										            oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
										  required   id="viewStatus">
                                                <option value=""  selected >Select Status</option> 
                                            </select>
                               </div>
							
							 <div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="viewModifiedBy" name="modifiedBy" disabled
                                             maxlength="18" />
                                            <label for="viewModifiedBy">Modified By</label>
                            </div>
                            
						</div>
						
						<div class="row myRow">
						
						     <div class="input-field col s12 m6">
                                            <textarea id="viewuserRemark" 
										  oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
													
											disabled required   maxlength="200" class="materialize-textarea" style= "min-height: 8rem;"></textarea>
                                            <label for="viewuserRemark">Remarks</label>
                                        </div>
							
							 
                            
						</div>

		<div class="row">
						<div class="input-field col s12 center">
							<button class="modal-close btn" type="button"
								style="margin-left: 10px;">
								<spring:message code="modal.close" />
							</button>


						</div>

					</div>
				
			</div>
		</div>
		
						     
		
		
		
		<div id="editModel" class="modal">
			<h6 class="modal-header">
				<spring:message code="Edit User" />
			</h6>
			<div class="modal-content">
				<form action="" onsubmit="return update()" method="POST"
					enctype="multipart/form-data" id="register">

					<div class="row" style="margin-top: 10px;">
						<div class="input-field col s12 m4">
                                            <input type="text" id="editfirstName"  name="firstName"  required="required"
                                            pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" maxlength="20"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');" disabled
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"/>
                                            <label for="editfirstName"><spring:message code="input.firstName" /></label>
                                        </div>
										
										<input type="text" id="editId" hidden="hidden">
                                       
                                        <div class="input-field col s12 m4">
                                            <input type="text" id="editmiddleName" name="middleName" disabled
                                            pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" maxlength="20"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');" maxlength="20" />
                                            <label for="editmiddleName"><spring:message code="input.middleName" /></label>
                                        </div>
										
										<div class="input-field col s12 m4">
                                            <input type="text" id="editlastName" name="lastName" disabled
                                            pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />" maxlength="20"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													 required   maxlength="20" />
                                            <label for="editlastName"><spring:message code="input.lastName" /></label>
                                        </div>
						
						
						
					</div>

					<div class="row myRow">
								 <div class="input-field col s12 m6">
                                          <%--   <input type="text" id="editcontactNumber" name="contactNumber" pattern="[0-9]{10,12}" 
 													oninput="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
												  required   maxlength="10" /> --%>
											<input type="text" name="contactNumber" maxlength="15" id="editcontactNumber" 
											pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"  
                              				 	 oninput="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" 
                              		 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.contact" />');" required>	  
                                            <label for="editcontactNumber"><spring:message code="input.contact" /><span
                                                    class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m6">
                                            <input type="email" id="editemailID" name="emailID"
                                             pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />" 
											oninput="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
												required  />
                                            <label for="editemailID"><spring:message code="input.EmailID" /> <span class="star"> *</span></label>
                                        </div>

							</div>			

					<%-- <div class="row myRow">
							 	<div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="editPassword" name="password" disabled
                                               pattern="[a-zA-Z]{0,20}" required maxlength="18" />
                                            <label for="editPassword"><spring:message code="registration.password" /><span class="star"> *</span></label>
                                        </div>
                                        
                                        <div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="EditconfirmPassword" name="confirmPassword" disabled
                                               pattern="[a-zA-Z]{0,20}" required maxlength="18" />
                                            <label for="EditconfirmPassword"><spring:message code="registration.retypepassword"/><span class="star"> *</span></label>
                                        </div>
						</div> --%>
						
						 						<div class="row myRow">
				 				
                                   <div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="edituserName" name="userName" disabled
                                               pattern="[a-zA-Z]{0,20}" required maxlength="18" />
                                            <label for="edituserName"><spring:message code="registration.username"/></label>
                              </div>
                                  
                             <div class="input-field col s12 m6" style="margin-top: 23px;">
                                            <input type="text" id="editModifiedBy" name="modifiedBy" disabled
                                             maxlength="18" />
                                            <label for="editModifiedBy">Modified By</label>
                            </div>            
                                        
						</div>
						
						 <div class="row myRow">
						 
						 	  <div class="col s12 m6 selectDropdwn">         
                                <label for="edituserType"><spring:message code="table.userType" /> <span class="star">*</span></label>
                                            <select class="browser-default" 
											title="<spring:message code="" />" oninput="setCustomValidity('')"  
										            oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
										  required   id="edituserType">
                                                <option value=""  selected><spring:message code="select.usertype" /></option>
                                            </select>
                                        </div> 
                            
						   <div class="col s12 m6 selectDropdwn">         
                                <label for="userStatus"><spring:message code="table.status" /> <span class="star">*</span></label>
                                            <select class="browser-default" 
											title="<spring:message code="" />" 
										            oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
										  required   id="userStatus">
                                                <option value=""  selected>Select Status</option> 
                                            </select>
                                        </div>
						 </div>
						 
						 <div class="row myRow">
						 	<div class="input-field col s12 m6">
                                            <textarea id="edituserRemark" 
										  oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
													
											required   maxlength="200" class="materialize-textarea" style= "min-height: 8rem;"></textarea>
                                            <label for="edituserRemark">Remarks<span
                                                    class="star">*</span></label>
                                        </div>
						 </div>

		<div class="row">
						<div class="input-field col s12 center">

							<button class="btn " type="submit" style="margin-left: 10px;">
								<spring:message code="button.update" />
							</button>
							<button class="modal-close btn" type="button"
								style="margin-left: 10px;">
								<spring:message code="button.cancel" />
							</button>


						</div>

					</div>
				</form>
			</div>
		</div>
	
		
		
		
	<div id="updateFieldsSuccess" class="modal">
     <h6 class="modal-header" style="margin:0px;">Edit User </h6>
        <div class="modal-content">
            
            <div class="row">
                <h6 id="updateFieldMessage"></h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a href="" class="modal-close btn"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>	
    
    
        <div id="DeleteFieldModal" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.deleteSystemUser" /></h6>
		<div class="modal-content">
		<div class="row">
				<h6><spring:message code="modal.message.User.delete" /></h6>
			</div> 
			<div class="row">
				<div class="input-field col s12 center">
					<a onclick="deleteModal()"
						class="modal-close modal-trigger btn" type="submit"><spring:message code="modal.yes" /></a>
					<button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
				</div>
			</div>
		</div>
	</div>	



<div id="closeDeleteModal" class="modal">
			<h6 class="modal-header"><spring:message code="modal.header.deleteSystemUser" /></h6>
			<div class="modal-content">
		
			
			<div class="row">

				<h6 id="deleteModalText"></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a href="" class="modal-close btn"
						style="margin-left: 10px;"><spring:message code="modal.ok" /></a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="error_Modal_reg" role="dialog">
		<div class="modal-dialog">
			<div class="row" id="modalMessageBodyReg"
					style="text-align: center;"></div>
			
		</div>
	</div>
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
		src="${context}/resources/project_js/userManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
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

