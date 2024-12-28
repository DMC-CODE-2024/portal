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
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!-- Security Tags -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:csrfMetaTags />
<!-- Security Tags -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head><title>EIRS Portal</title>
<!--<title>Registration</title>-->

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
<!--   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"></script>  
 -->
	
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
<%--  <link href="${context}/resources/plugins/chartist-js/chartist.min.css" type="text/css" rel="stylesheet" media="screen,projection"> --%>
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

input#expectedArrivaldate {
    height: 6vh;
}
input#quantity {
    height: 7vh;
}
</style>

</head>
<body data-id="3" data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}"
	data-username="${username}">
	<!-- START MAIN -->

	<!-- START WRAPPER -->
	<div class="wrapper">

		<!-- START CONTENT -->
		<section id="content">
		<div id="initialloader"></div>
			<!--start container-->
			<div class="container">
				<div class="section">
					<div class="row">
						<div class="col s12 m12 l12">
							<div class="row card-panel">
								<form action="" onsubmit="return registerConsignment()"
									method="POST" enctype="multipart/form-data"
									id="registerConsignment">
									<div class="container-fluid pageHeader">
										<p class="PageHeading"><spring:message code="registerconsignment.view.header.title" /></p>
										<!-- <button type="button" class="waves-effect waves-light modal-trigger boton right"
                      data-target="modal1">Register Consignment</button> -->
									</div>

									<div class="row myRow">
										<div class="input-field col s12 m6">
											<input type="text" name="supplierId" id="supplierId"
												pattern="<spring:eval expression="@environment.getProperty('pattern.supplierID')" />"
												 oninput="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												maxlength="15" /> <label for="supplierId" class="center-align"><spring:message code="input.supplier" /></label>
										</div>

										<div class="input-field col s12 m6">
											<input type="text" name="supplierName" id="supplierName"
												 pattern="<spring:eval expression="@environment.getProperty('pattern.supplierName')" />"
												 oninput="InvalidMsg(this,'input','<spring:message code="validation.50character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50character" />');"
												
												maxlength="50" required /> <label for="supplierName"
												class="center-align"><spring:message code="input.suppliername"/> <span
												class="star">*</span></label>
										</div>
									</div>
									<div class="row myRow">
										<div class="input-field col s12 m6">
											<input type="text" name="consignmentNumber"
												id="consignmentNumber" 
												pattern="<spring:eval expression="@environment.getProperty('pattern.consignmentNumber')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.15alphanumeric" />');"
												 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15alphanumeric" />');"
												maxlength="15" /> <label for="consignmentNumber" class="center-align"><spring:message code="input.consignmentnumber" /></label>
										</div>

										<div class="input-field col s12 m6">
											<input type="text" name="expectedDispatcheDate"
												id='expectedDispatcheDate' class='form-control datepick'
												autocomplete='off'  onchange="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');checkDate(expectedDispatcheDate,expectedArrivaldate);" oninvalid="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');" 
												 required /> 
												<label
												for="expectedDispatcheDate" class="center-align"><spring:message code="input.dispatchdate" /> <span class="star">*</span>
											</label> <span class="input-group-addon" style="color: #ff4081"><i
												class="fa fa-calendar" aria-hidden="true"></i></span>
					<p id="errorMsgOnModal" class="onEditModalTitle" class="left"></p>
										</div>
									</div>

									<div class="row myRow">
										<div class=" col s12 m6">
										<p style="margin: 0;font-size: 12px;"><spring:message code="input.country" /> <span class="star">*</span></p>
											<select id="country" name="organisationcountry" 
												 class="browser-default" class="mySelect" onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;"   required ></select>
										</div>


										<div class="input-field col s12 m6">
											<input name="expectedArrivaldate" id="expectedArrivaldate"
												type="text" class='form-control datepick' autocomplete='off' onchange="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');checkDate(expectedDispatcheDate,expectedArrivaldate);" oninvalid="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');"
												
												required /> <label for="expectedArrivaldate"
												class="center-align"><spring:message code="input.arrivaldate" /> <span
												class="star">*</span></label> <span class="input-group-addon"
												style="color: #ff4081"><i class="fa fa-calendar"
												aria-hidden="true"></i></span>
										</div>
									</div>

								
						
								<div class="row myRow">
										<div class=" col s12 m6">
											
												<label for="expectedArrivalPort"><spring:message code="input.arrivalport" /> <span class="star">*</span></label>
											<select class="browser-default" id="expectedArrivalPort"  onchange="getByPort(this.value)" oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required
												 name="expectedArrivalPort" >
												<%-- <spring:message code="input.arrivalport" /> --%>
												<option value="" disabled selected> <spring:message code="input.arrivalport" /></option>
											</select>
										</div>
										
								<div class="col s12 m6">
									<label><spring:message code="registration.portAddress" /> <span class="star">*</span></label>
									<select id="portAddress" class="browser-default"  
									oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required>
										<option value="" disabled selected><spring:message code="selectport" /></option>
											</select>
								</div>	
									</div>
									
										
						
									<div class="row myRow">
										<div class="input-field col s12 m6">
											<input type="text" name="quantity" id="quantity"
												pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"  required/> 
												<label for="quantity" class="center-align" style="margin-top: 5px;"><spring:message code="input.quantity" /> <span class="star">*</span></label>
										</div>
										
									<div class="file-field col s12 m6"
											style="margin-top: 5px;">
					<h6 class="file-upload-heading" >
											<spring:message code="input.bulkdevice" /> <span class="star">*</span>
										</h6>
											<div class="btn">
												<span><spring:message code="input.selectfile" /></span> <input type="file" onchange="isFileValid('file')"
													 name="file" id="file" accept=".csv"  
												oninput="InvalidMsg(this,'fileType','<spring:message code="validation.file" />');" oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.file" />');"  required />
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate responsive-file-div" id="fileName"
													type="text">
											</div>
										</div>	
									</div>			
									
								
								
									<div class="row myRow">
									
										<div class="input-field col s12 m6">
											<input type="text" name="deviceQuantity" id="deviceQuantity"
										
												pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
												 oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"  required/> 
												<label for="deviceQuantity" class="center-align" style="margin-top: 5px;"><spring:message code="input.deviceQty" /> <span class="star">*</span></label>
										</div>
										
									
										<div class="input-field col s12 m6">
										<input type="text" name="totalPrice" id="totalPrice" 
											pattern="^\d+(?:\.\d{1,2})?$" maxlength="7"
												 oninput="InvalidMsg(this,'input','<spring:message code="validation.12Char" />');"
												 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.12Char" />');"> 
												 <label for="totalPrice" class="center-align"><spring:message code="input.totalprice" /></label>
										</div>
										
										
										
										<div class="col s12 m6" id="currencyDiv" style="display: none;" >
											<label for="currency"><spring:message code="input.currency" /> <span class="star">*</span></label>
											<select class="browser-default" id="currency"  oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"  oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" name="currency" 
											style="height: 2.2rem !important;">
												<option value=""  selected><spring:message code="input.currency" /></option>
									
											</select>
										</div>
									</div>	
									

									<div class="row myRow">
										
										
										<div class="col s12 m12">
											<p>
											<a href="./Consignment/sampleFileDownload/3"><spring:message code="input.downlaod.sample" /></a>
										</p>
										<p><spring:message code="input.requiredfields" /> <span
											class="star">*</span></p>
										</div>
									</div>


									<div class="row">
										<div class="input-field col s12 center">
						
											<button class=" btn" id="consignmentSubbmitButton" type="submit"><spring:message code="button.submit" /></button>
												
											<a href="#cancelMessage" class="btn modal-trigger"
												type="cancel" style="margin-left: 10px;"><spring:message code="button.cancel" /></a>


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


	<div id="submitConsignment" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.submitConsignment" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="sucessMessage"><spring:message code="modal.message.futureRef" /></h6>
				<input type="text" style="display: none" id="errorCode">
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<form action="${context}/viewConsignment"
						id="closeOkPop" method="POST">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<a onclick="closeConfirmation()" class="btn"><spring:message code="modal.ok" /></a>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="cancelMessage" class="modal">
		<h6 class="modal-header"> <spring:message code="modal.cancelrequest" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6><spring:message code="modal.message" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="${context}/viewConsignment" class="btn"><spring:message code="modal.yes" /></a>
						<button class="modal-close waves-effect waves-light btn"
							style="margin-left: 10px;"><spring:message code="modal.no" /></button>
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
		src="${context}/resources/project_js/htmlValidationi18n.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/registerConsignment.js?version=<%= (int) (Math.random() * 10) %>"></script>	
	<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
					<script type="text/javascript"
		src="" async></script>
<script type="text/javascript"> var countHit=""; $( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;

$("body").click(function(e) {
	
	
	$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});
	$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {
		currentTime = data;
		countHit=0;
		
	},
		error: function (jqXHR, textStatus, errorThrown) {}});
	if( currentTime > timeoutTime )
	{
		 document.addEventListener("click", handler, true);
	  function handler(e) {
			  e.stopPropagation();
			  e.preventDefault();
			}  
			 window.top.location.href = "./login?isExpired=yes";   
		   }
	   else{
		   timeoutTime = currentTime + timeout;
		   }
	   
	   });});
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