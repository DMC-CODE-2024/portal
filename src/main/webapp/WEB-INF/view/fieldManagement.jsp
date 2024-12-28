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
<!--<title>Field Management</title>-->
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
<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>

<!------------------------------------------- Dragable Model---------------------------------->
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>


</head>
<body data-id="23"
	data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}"
	data-selected-username="${username}"
	data-action="${action}"
	session-value="en"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}">

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
							<form action="${context}/fieldManagement" id="viewFilter"
								method="post">
								<div class="registrationTableDiv_box" id="FieldTableDiv"
									style="padding-bottom: 5px; background-color: #e2edef52;">
									<div id="filterBtnDiv"></div>
								</div>
							</form>
							<table id="fieldManagementLibraryTable"
								class="responsive-table striped display"></table>

						</div>

					</div>
				</div>
				<div id="footerBtn"></div>
			</div>
		</div>
		
	
		<!--end container-->
	</section>
	
 	<div id="addTags" class="modal" style="z-index: 1003; display: none; opacity: 1; transform: scaleX(1); top: 10%;">
        <h6 class="modal-header">Add New Field</h6>
        <div class="modal-content">
          	<form action="" onsubmit="return submitTag()" method="post" >
                <div class="row" style="margin-top: 10px;">
					
					<div class="col s12 m6">
					<label for="tag" class="active">Field </label>
                        <!-- <input type="text" id="tag" name="tag" pattern="[A-Za-z]{0,30}" Placeholder=""  maxlength="15" value="" required="required" disabled> -->
                        <select class="browser-default" id="tag" disabled>
                                <option value="" disabled="" selected="">Select field</option>
                          </select>
                        
                         <input type="text" id="displayName" hidden>
                        
                    </div>
					
					
					
					 <div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="text" id="tagId" name="addFieldId"  
                        pattern="<spring:eval expression="@environment.getProperty('pattern.fieldID')" />" 
                        oninput="InvalidMsg(this,'input','<spring:message code="validation.fieldID" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.fieldID" />');" maxlength="10" >
                        <label for="addFieldId" class="">Field ID </label>
                    </div>
					
                    <div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="text" id="addInterp" name="interp" 
                        pattern="<spring:eval expression="@environment.getProperty('pattern.fieldID')" />"
                       oninput="InvalidMsg(this,'input','<spring:message code="validation.fieldID" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.fieldID" />');"
                        maxlength="30" required="required">
                        <label for="addInterp" class="">Display Name <span class="star">*</span></label>
                    </div>
						
					<div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="text" id="description" name="value" 
                        pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
                        oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
                         maxlength="200" style="min-height:8rem">
                        <label for="description" class="">Description</label>
                    </div>
						
                   

                    <div class="col s12 m12 center" style="margin-top: 20px;">
                        <button class="btn" type="submit">Submit</button>
                        <a href="#" onclick="resetFields()" class="btn modal-close" id="Cancel" style="margin-left: 10px;">Cancel</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
		
		
		<div id="editTags" class="modal" style="z-index: 1003; display: none; opacity: 1; transform: scaleX(1); top: 10%;">
        <h6 class="modal-header">Edit Field Details</h6>
        <div class="modal-content">
          	<form action="" onsubmit="return updatedTag()">
                <div class="row" style="margin-top: 10px;">
					
					<div class="col s12 m6">
					<label for="tag" class="active">Field </label>
                        <!-- <input type="text" id="tag" name="tag" pattern="[A-Za-z]{0,30}" Placeholder=""  maxlength="15" value="" required="required" disabled> -->
                        <select class="browser-default" id="Edittag" disabled>
                                <option value="" disabled="" selected="">Select field</option>
                          </select>
                        
                         <input type="text" id="editdisplayName" hidden>
                          <input type="text" id="editId" hidden>
                    </div>
					
					
                    <div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="text" id="editFieldId" name="editField" 
                       pattern="<spring:eval expression="@environment.getProperty('pattern.fieldID')" />" 
                        oninput="InvalidMsg(this,'input','<spring:message code="validation.fieldID" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.fieldID" />');"
                         title="Please enter alphabets and numbers upto 10 characters only" maxlength="10" >
                        <label for="editFieldId" class="">Field ID</label>
                    </div>
					

                    <div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="text" id="editInterp" name="interp" 
                        pattern="<spring:eval expression="@environment.getProperty('pattern.fieldID')" />" 
                        oninput="InvalidMsg(this,'input','<spring:message code="validation.fieldID" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.fieldID" />');"
                        maxlength="30" required="required">
                        <label for="editInterp" class="">Display Name <span class="star">*</span></label>
                    </div>
					
					<div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="text" id="editdescription" name="value" 
                          pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
                        oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');" 
                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
                         maxlength="200" style="min-height:8rem">
                        <label for="editdescription" class="">Description</label>
                    </div>
                    
                    <div class="input-field col s12 m6" style="margin-top: 20px;">
                        <input type="text" id="editModifiedBy"  disabled>
                        <label for="editModifiedBy" class="center-align">Modified By </label>
                    </div>
					

                    <div class="col s12 m12 center" style="margin-top: 20px;">
                        <button class="btn" type="submit">Update</button>
                        <a href="#" class="btn modal-close" id="Cancel" style="margin-left: 10px;">Cancel</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
		
	<div id="confirmField" class="modal">
		<h6 class="modal-header">Add New Field</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="sucessMessage">New Field Added Successfully</h6>
			</div>
			 <div class="row">
				<div class="input-field col s12 center">
                   <a href="" class="modal-close btn" class="btn">OK</a>
                </div>
			</div> 
		</div>
	</div>
	
	
		
	   <!-- --------------------------------------------------------------Delete Field Modal Start --------------------------------------------------------------->


	<div id="DeleteFieldModal" class="modal">
		<h6 class="modal-header"><spring:message code="modal.header.deleteField" /></h6>
		<div class="modal-content">
		<div class="row">
				<h6><spring:message code="modal.message.field.delete" /></h6>
			</div> 
			<input type="text" id="deleteFieldId" hidden>
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
			<h6 class="modal-header"><spring:message code="modal.header.deleteField" /></h6>
			<div class="modal-content">
		
			
			<div class="row">

				<h6 id="tacModalText"><spring:message code="modal.message.fieldDeleted" /> </h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a href="" class="modal-close btn"
						style="margin-left: 10px;">OK</a>
				</div>
			</div>
		</div>
	</div>
		
		
		
	<div id="updateFieldsSuccess" class="modal">
     <h6 class="modal-header" style="margin:0px;"><spring:message code="button.update" /></h6>
        <div class="modal-content">
            
            <div class="row">
                <h6 id="updateFieldMessage"><spring:message code="input.requestupdated" /></h6>
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
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<%-- 		<script type="text/javascript"
		src="${context}/resources/project_js/disable_inspectElement.js"></script> --%>
	<script type="text/javascript"
		src="${context}/resources/project_js/fieldManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
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


