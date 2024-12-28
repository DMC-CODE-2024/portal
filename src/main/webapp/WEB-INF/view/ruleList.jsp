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
<body data-id="29"
	data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}"
	session-value="en" 	data-selected-username="${username}"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}"
	data-session-source="${not empty param.source ? param.source : 'menu'}">

	<%-- session-value="${not empty param.NID ? param.NID : 'null'}" --%>

	<!-- START CONTENT -->


                <div class="content-box">
                <div class="content-container">
                    <div class="content-header" id="pageHeader">
                       <!--  <h1>Grievance Management</h1> -->
                    </div>
                    <div class="filter-box">

                        <form action="${context}/ruleListMav" id="viewFilter"
								method="post" class="filter-row">
						<div id="errorMsgDiv" class="filter-form-row" style="width: 100%;"></div>
       					<div id="FieldTableDiv" class="filter-form-row"></div>
       					<div id="registrationTableButtonDiv" class="filter-btn-row"></div>

                        </form>
                    </div>
                    <div class="table-box">
                        <div class="table-responsive">
                            <table id="table" class="table">
                            	<thead class="thead-dark"></thead>
                            </table>
                        </div>
                        <div id="footerBtn" class="table-paginationbox">
                        </div>
                    </div>
                </div>
            </div>


	<div id="viewModel" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
		  <div class="modal-content">
				<h5 class="modal-header"><spring:message code="modal.ViewRuleList" /></h5>
			<div class="modal-body">
				<div class="form-row">
					<div class="form-group col-md-6">
					<label for="totalPrice" class=""><spring:message code="table.name" /></label>
                    	<input type="text" class="form-control" name="viewName" id="viewName"
                        							placeholder=""
                        							oninput="InvalidMsg(this,'input','<spring:message code="validation.50character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50character" />');"
                                                readonly="readonly" ></div>
					<div class="form-group col-md-6">
						 <label for="viewState" class=""><spring:message code="table.status" /></label>
                        								<input type="text" name="viewState" id="viewState" class="form-control"
                            							placeholder="" 	oninput="InvalidMsg(this,'input','<spring:message code="validation.50character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50character" />');"
                            					 readonly="readonly" ></div>

					<div class="form-group col-md-6">
					<label for="viewModifiedBy" class="">Modified By </label>
                    <input type="text" id="viewModifiedBy" class="form-control" disabled>
                    </div>
                    	<div class="form-group col-md-12">
                    					<label for="viewDescription" class=""><spring:message code="registration.description" /></label>
                    					<textarea id="viewDescription" class="form-control" Placeholder="" readonly="readonly"   maxlength="200" style="padding-top: 8px !important;"></textarea>

                    					</div>

				</div>
			</div>
			<div class="modal-footer">
				<button class="cancel-product btn modal-close" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
			</div>
		  </div>
		</div>
	  </div>



	<div id="editModel" class="modal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg" role="document">
			  <div class="modal-content">
				<div class="modal-header">
				  <h5 class="modal-title"><spring:message code="modal.EditRuleList" /></h5>
				</div>
				<div class="modal-content_">
					<form action="" onsubmit="return update()">
						<div class="modal-body">
						<div class="form-row">
						<div class="form-group col-md-6">
                      <label for="totalPrice" class=""><spring:message
                      								code="table.name" /></label>
                      	<input type="text" class="form-control" name="name" id="editName"
                      							placeholder="" 	oninput="InvalidMsg(this,'input','<spring:message code="validation.50character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50character" />');"
                      							maxlength="50" required disabled>
                        								</div>


                                <div class="form-group col-md-6">
								<label for="totalPrice" class=""><spring:message code="table.status" /> <span class="star">*</span></label>
                                								<select id="editState" name="editState"
                                							class="form-control" class="mySelect"
                                							onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                							required></select>
                                							</div>
								</div>

						<div class="form-row">
                        <div class="form-group col-md-6">
								 <label for="editModifiedBy" class="">Modified By </label>
                                <input type="text" id="editModifiedBy" class="form-control" disabled>
								</div>
				    </div>

				<div class="form-row">
                                        <div class="form-group col-md-12">
                				<label for="editdescription" class=""><spring:message code="registration.description" /></label>
                                <textarea id="editDescription"  class="form-control" Placeholder="" placeholder=""  maxlength="200" style="padding-top: 8px !important;"></textarea>
                                                					</div>
                				    </div>


					</div>
				<div class="modal-footer">
					<button class="save-product btn" type="submit" style="margin-left: 10px;"><spring:message code="button.update" /></button>
					<button class="cancel-product btn modal-close" type="button" style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
				</div>
			</form>
			  </div>
			</div>
		  </div>
	</div>



	<div id="updateFieldsSuccess" class="modal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg" role="document">
			  <div class="modal-content">
				<div class="modal-header">
				  <h5 class="modal-title">Update Rule List</h5>
				</div>
				<div class="modal-body">
				  <p id="updateFieldMessage"></p>
				</div>
				<div class="modal-footer">
					<a href="${context}/ruleListMav" class="cancel-product btn modal-close"><spring:message code="modal.ok" /></a>
				</div>
			  </div>
			</div>
		  </div>
		</section>



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
		src="${context}/resources/project_js/ruleList.js?version=<%= (int) (Math.random() * 10) %>"></script>
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

