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
<html class="no-js" lang="en" dir="ltr">
<head><title>EIRS Portal</title>
<!--<title>Currency Management</title>-->
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='-1'>
<meta http-equiv='pragma' content='no-cache'>
<meta name="fragment" content="!">
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

<script type="text/javascript"
	src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

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
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>

<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>



</head>
<body data-id="23"
	data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}"
	data-selected-username="${username}"
	session-value="en"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}"
	data-session-source="${not empty param.source ? param.source : 'menu'}">

	<%-- session-value="${not empty param.NID ? param.NID : 'null'}" --%>

	<!-- START CONTENT -->
	<!-- START CONTENT -->
	<section id="content">
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
							<form action="${context}/currencyManagement" id="viewFilter"
								method="post">
								<div class="registrationTableDiv_box" id="CurrencyTableDiv"
									style="padding-bottom: 5px; background-color: #e2edef52;">
									<div id="filterBtnDiv"></div>
								</div>
							</form>
							<table id="currencyManagementLibraryTable"
								class="responsive-table striped display"></table>

						</div>

					</div>
				</div>
				<div id="footerBtn"></div>
			</div>
		</div>
		
	
		<!--end container-->
	</section>
	
 	<div id="addCurrency" class="modal" style="z-index: 1003; display: none; opacity: 1; transform: scaleX(1); top: 10%;">
        <h6 class="modal-header">Add Exchange Rate </h6>
        <div class="modal-content">
          	<form action="" onsubmit="return submitPort()" method="post" >
                <div class="row" style="margin-top: 10px;">
					
					<!-- <div class="input-field col s12 m6" style="margin-top: 22px;">
						<input type="text" name="month"
						id='month' class='form-control datepick'
						autocomplete='off'  required /> 
						<label for="month" class="center-align">Month <span class="star">*</span>
						</label> <span class="input-group-addon" style="color: #ff4081"><i
												class="fa fa-calendar" aria-hidden="true"></i></span>
					
					</div> -->
					<div class="col s12 m6">
					<label for="port" class="active">Month<span class="star">  *</span></label>
                     	 <select class="browser-default" id="addMonth" required="required">
                                <option value="" selected >Select Month</option>
                          </select>
                        
                        
                    </div>
					
					<div class="col s12 m6">
					<label for="port" class="active">Year<span class="star">  *</span></label>
                     	 <select class="browser-default" id="addYear" required="required">
                                <option value="" selected>Select Year</option>
                          </select>
                        
                        
                    </div>
					
					<div class="col s12 m6">
					<label for="port" class="active">Currency<span class="star">  *</span></label>
                     	 <select class="browser-default" id="currency" required="required">
                                <option value=""  selected>Select Currency</option>
                          </select>
                        
                        
                    </div>
					
					<div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="number" id="cambodianRiel" 
                        pattern="<spring:eval expression="@environment.getProperty('pattern.Currency')" />"
                        oninput="InvalidMsg(this,'input','<spring:message code="validation.currencyMsg" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.currencyMsg" />');"
                        maxlength="8" required="required">
                        <label for="cambodianRiel" class="">To Cambodian Riel <span class="star"> *</span></label>
                    </div>
                    
                    
                    <div id="currencyDiv" class="input-field col s12 m6" style="display: none;">
                        <input type="number" id="dollar" 
                        pattern="<spring:eval expression="@environment.getProperty('pattern.Currency')" />"
                         title="Please enter numeric numbers"  maxlength="8">
                        <label for="number" class="">To US Dollar <span class="star"> *</span></label>
                    </div>

					 <div class="col s12 m12 center" style="margin-top: 20px;">
                        <button class="btn" type="submit">Submit</button>
                        <a href="#" onclick="resetFields()" class="btn modal-close" id="Cancel" style="margin-left: 10px;">Cancel</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
		
		
		 	<div id="editCurrencyModal" class="modal" style="z-index: 1003; display: none; opacity: 1; transform: scaleX(1); top: 10%;">
        <h6 class="modal-header">Edit Exchange Rate</h6>
        <div class="modal-content">
          	<form action="" onsubmit="return updateCurrency()" method="post" >
                <div class="row" style="margin-top: 10px;">
					
					<div class="col s12 m6">
					<label for="port" class="active">Month</label>
                     	 <select class="browser-default"  id="editMonth" required="required"  disabled>
                                <option value="" selected>Select Month</option>
                          </select>
                        
                         <input type="text" id="editId" hidden>
                    </div>
					
					<div class="col s12 m6">
					<label for="port" class="active">Year</label>
                     	 <select class="browser-default" id="editYear" required="required" disabled>
                                <option value=""  selected>Select Year</option>
                          </select>
                    </div>
					
					<div class="col s12 m6">
					<label for="editCurrency" class="active">Currency</label>
                     	 <select class="browser-default" id="editCurrency" required="required" disabled>
                                <option value=""  selected>Select Currency</option>
                          </select>
                        
                        
                    </div>
					
					<div class="input-field col s12 m6" style="margin-top: 23px;">
                        <input type="number" id="editCambodianRiel" 
                        pattern="<spring:eval expression="@environment.getProperty('pattern.Currency')" />"
                         oninput="InvalidMsg(this,'input','<spring:message code="validation.currencyMsg" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.currencyMsg" />');"
                         maxlength="8" required="required">
                        <label for="editCambodianRiel" class="">Cambodian Riel <span class="star"> *</span></label>
                    </div>
  <div class="row myRow">
                   	<div class="input-field col s12 m6">
                        <input type="text" id="editmodifiedBy" name="value" disabled>
                        <label for="editmodifiedBy" class="">Modified By </label>
                    </div>
                    
                    
                    <div id="editcurrencyDiv" class="input-field col s12 m6" style="display: none;">
                    	<input type="number" id="editDollar"
                        pattern="<spring:eval expression="@environment.getProperty('pattern.Currency')" />"
                           oninput="InvalidMsg(this,'input','<spring:message code="validation.currencyMsg" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.currencyMsg" />');"
                         title="Please enter numeric numbers"  maxlength="8" required="required">
                        <label for="editDollar" class="">US Dollar <span class="star">  *</span></label>
  </div>
					</div>
					 <div class="col s12 m12 center" style="margin-top: 20px;">
                        <button class="btn" type="submit">Submit</button>
                        <a href="#" class="btn modal-close" id="Cancel" style="margin-left: 10px;">Cancel</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
		
	<div id="confirmField" class="modal">
		<h6 class="modal-header">Add Exchange Rate</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="sucessMessage"> </h6>
			</div>
			 <div class="row">
				<div class="input-field col s12 center">
                   <a href="" class="modal-close btn" class="btn">ok</a>
                </div>
			</div> 
		</div>
	</div>
	
	
		
	   <!-- --------------------------------------------------------------Delete Field Modal Start --------------------------------------------------------------->


	<div id="DeleteFieldModal" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.deletePort" /></h6>
		<div class="modal-content">
		<div class="row">
				<h6><spring:message code="modal.message.Port.delete" /></h6>
			</div> 
			<input type="text" id="deletePortId" hidden>
			<div class="row">
				<div class="input-field col s12 center">
					<a onclick="confirmantiondelete()"
						class="modal-close modal-trigger btn" type="submit"><spring:message code="modal.yes" /></a>
					<button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
				</div>
			</div>
		</div>
	</div>	
	
	<div id="closeDeleteModal" class="modal">
			<h6 class="modal-header"><spring:message code="modal.header.deletePort" /></h6>
			<div class="modal-content">
		
			
			<div class="row">

				<h6 id="tacModalText"><spring:message code="modal.message.portDeleted" /> </h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a href="" class="modal-close btn"
						style="margin-left: 10px;"><spring:message code="modal.close" /></a>
				</div>
			</div>
		</div>
	</div>
		
		
		
	<div id="updateFieldsSuccess" class="modal">
     <h6 class="modal-header" style="margin:0px;">Edit Exchange Rate</h6>
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
<!--materialize js-->
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>

	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>



	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
	<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>

	
	<!--custom-script.js - Add your own theme custom JS-->


	
	<!--scrollbar-->
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
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>


	<script type="text/javascript"
		src="${context}/resources/project_js/viewCurrencyManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
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


