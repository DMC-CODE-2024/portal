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
<head><title>EIRS Portal</title>
<!--<title>Add</title>-->

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
<!-- Security Tags -->

<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<!--   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"></script>  
 -->

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png"
	sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">


<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link href="" type="text/css" rel="stylesheet" media="screen,projection">
<!-- Custome CSS-->
<link href="" type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
<link href="${context}/resources/plugins/prism/prism.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<%--  <link href="${context}/resources/plugins/chartist-js/chartist.min.css" type="text/css" rel="stylesheet" media="screen,projection"> --%>
<link rel="stylesheet"
	href="${context}/resources/project_css/viewConsignment.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">

<%-- <link rel="stylesheet"
	href="${context}/resources/project_css/jquery-ui.css"> --%>
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>

<script src="${context}/resources/js/jquery.blockUI.js"></script>


<style>
.row {
	margin-bottom: 0;
	margin-top: 0;
}

/* input[type=text] {
      height: 35px; 
      margin: 0 0 5px 0;
    } */
input








[
type
=
text
]








:not




 




(
.browser-default




 




)
{
font-size








:




 




13
px








;
/* height: 30px; */
}
input[type=date] {
	font-size: 0.8rem;
}

textarea.materialize-textarea {
	padding: 0;
	padding-left: 10px;
}

.btn-flat {
	height: auto;
}

#starColor {
	color: red;
}

section {
	margin-top: 10px;
}

div#error_Modal {
    width: 610px;
}
</style>

</head>
<body data-id="3" data-roleType="${usertype}"
	data-userTypeID="${usertypeId}" data-userID="${userid}"
	data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}"
	session-value="en"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}"
	data-username="${username}">
	<!-- START MAIN -->

	<!-- START WRAPPER -->
	<div class="wrapper">

		<!-- START CONTENT -->
		<section id="content">
			<!--start container-->
			<div class="container">
				<div class="section">
					<div class="row">
						<div class="col s12 m12 l12">
							<div class="row card-panel">
								<form action="" onsubmit="return save()" method="POST"
									enctype="multipart/form-data" id="register">
									<div class="container-fluid pageHeader">
										<p class="PageHeading">
											<spring:message code="button.add" />
										</p>

									</div>




									<div class="row myRow">
										<div class=" col s12 m6">
											<p style="margin: 0; font-size: 12px;">
												<spring:message code="table.ruleName" />
												<span class="star">*</span>
											</p>
											<select id="Rule" name="rule" class="browser-default"
												class="mySelect"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');getFeature(this);"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required>
												<option value="null" selected="">Rule Name</option>
												</select>
										</div>


										<div class=" col s12 m6">
											<p style="margin: 0; font-size: 12px;">
												<spring:message code="table.featureName" />
												<span class="star">*</span>
											</p>
											<select id="Feature" name="organisationcountry"
												class="browser-default" class="mySelect"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');getGrace(this);getFeaturedUserType('Feature')"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required>
												<option value="null" selected="">Feature Name</option>
												</select>
										</div>
									</div>

									<div class="row myRow">
										<div class=" col s12 m6">
											<p style="margin: 0; font-size: 12px;">
												<spring:message code="table.userType" />
												<span class="star">*</span>
											</p>
											<select id="User" name="organisationcountry"
												class="browser-default" class="mySelect"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required></select>
										</div>

										<div class="input-field col s12 m6">
											<input type="text" name="ord er" id="order"
												pattern="<spring:eval expression="@environment.getProperty('pattern.order')" />"
												maxlength="7"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"
												 /> <label for="quantity" class="center-align"><spring:message
													code="table.order" /> <span class="star"></span></label>
										</div>

									</div>



									<div class="row myRow">
										<div class=" col s12 m6">
											<p style="margin: 0; font-size: 12px;">
												<spring:message code="table.gracePeriod" />
												<span class="star">*</span>
											</p>
											<select id="GracePeriod" name="organisationcountry"
												class="browser-default" class="mySelect"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required></select>
										</div>


										<div class=" col s12 m6">
											<p style="margin: 0; font-size: 12px;">
												<spring:message code="table.postGracePeriod" />
												<span class="star">*</span>
											</p>
											<select id="PostGracePeriod" name="organisationcountry"
												class="browser-default" class="mySelect"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required></select>
										</div>
									</div>



									<div class="row myRow">
										<div class=" col s12 m6">
											<p style="margin: 0; font-size: 12px;">
												<spring:message code="table.moveToGracePeriod" />
												<span class="star">*</span>
											</p>
											<select id="MoveToGracePeriod" name="organisationcountry"
												class="browser-default" class="mySelect"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required></select>
										</div>


										<div class=" col s12 m6">
											<p style="margin: 0; font-size: 12px;">
												<spring:message code="table.moveToPostGracePeriod" />
												<span class="star">*</span>
											</p>
											<select id="MoveToPostGracePeriod" name="organisationcountry"
												class="browser-default" class="mySelect"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required></select>
										</div>
									</div>


									<div class="row myRow">
										<div class=" col s12 m6">
											<p style="margin: 0; font-size: 12px;">
												<spring:message code="table.expectedOutput" />
												<span class="star">*</span>
											</p>
											<select id="output" name="output" class="browser-default"
												class="mySelect"
												onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required>
												<option value="Yes">Yes</option>
												<option value="No">No</option>
											</select>
										</div>
									</div>



									<div class="row">
										<div class="input-field col s12 center">

											<button class=" btn" id="consignmentSubbmitButton"
												type="submit">
												<spring:message code="button.submit" />
											</button>

											<a href="#cancelMessage" class="btn modal-trigger"
												type="cancel" style="margin-left: 10px;"><spring:message
													code="button.cancel" /></a>

										</div>

									</div>
								</form>
							</div>

						</div>
					</div>

				</div>
			</div>
		</section>
	</div>


	<div id="cancelMessage" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.cancelrequest" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6>
					<spring:message code="modal.message" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="${context}/ruleFeatureMav?FeatureId=30" class="btn"><spring:message
								code="modal.yes" /></a>
						<button class="modal-close waves-effect waves-light btn"
							style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>




<div id="updateModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="updateRuleOrderHeader.message" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="errorMessage">
					<spring:message code="updateRuleOrder.message" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn"  onclick="confirmRuleUpdate()"  ><spring:message
								code="modal.yes" /></button>
						<button class="modal-close waves-effect waves-light btn"  onclick="closeRuleUpdateOrder()"
							style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
						 
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="updateModalAllowed" class="modal">
		<h6 class="modal-header">
			<spring:message code="updateRuleOrderHeader.message" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="ErrorFieldMessage"></h6>
				<span id="expectedValue"> </span>				
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close waves-effect waves-light btn"  onclick="closeRuleUpdateOrder()"
						class="modal-close btn" id="add_user">
						<spring:message code="modal.close" />
					</button>
					</div>
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
	
	
	<div id="successModal" class="modal">
		<h6 class="modal-header" style="margin: 0px;">
			<spring:message code="button.add" />
		</h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="updateFieldMessage">Successfully Added New Rule
					FeatureMapping.</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a class="modal-close btn"
						href="${context}/ruleFeatureMav?FeatureId=30"><spring:message
							code="modal.ok" /></a>
				</div>
			</div>
		</div>
	</div>

	<div id="cancelMessage" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.cancelrequest" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6>
					<spring:message code="modal.message" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="${context}/Consignment/viewConsignment" class="btn"><spring:message
								code="modal.yes" /></a>
						<button class="modal-close waves-effect waves-light btn"
							style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!--end container-->



	<!-- END MAIN -->


	<!--materialize js-->
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>

	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>



	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
	<script src="${context}/resources/custom_js/bootstrap.min.js"></script>


	<!--custom-script.js - Add your own theme custom JS-->



	<!--scrollbar-->
	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<!-- chartist -->


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
		src="${context}/resources/project_js/htmlValidationi18n.js?version=<%= (int) (Math.random() * 10) %>"></script>
<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	
<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/newRule.js?version=<%= (int) (Math.random() * 10) %>"></script>


<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
      
<script type="text/javascript">var countHit="";  $( document ).ready(function() { if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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
	else{timeoutTime = currentTime + timeout;}});});</script>
	
	
</body></html>

<%
	} else {
	/*  request.setAttribute("msg", "  *Please login first");
	request.getRequestDispatcher("./index.jsp").forward(request, response); */
%>
<script language="JavaScript">
	sessionStorage.setItem("loginMsg", "*Session has been expired");
	window.top.location.href = "./login";
</script>
<%
	}
%>