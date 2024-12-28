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
		
</head>

<body data-id="6" data-roleType="${usertype}"
	data-userTypeID="${usertypeId}" data-userID="${userid}"
	data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-grievanceTxnId="${grievanceTxnId}"
	data-grievanceId="${grievanceId}" data-userName="${userName}"
	data-grievanceStatus="${grievanceStatus}"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}"
	data-session-source="${not empty param.source ? param.source : 'menu'}">


	<body>

            <div class="content-box">
                <div class="content-container">
                    <div class="content-header" id="pageHeader">
                       <!--  <h1>Grievance Management</h1> -->
                    </div>
                    <div class="filter-box">
                        <form action="" class="filter-row" id="greivancefilterform">
       						<div id="greivanceTableDiv" class="filter-form-row"></div>
       						<div id="greivanceTableButtonDiv" class="filter-btn-row"></div>
                        </form>
                    </div>
                    <div class="table-box">
                        <div class="table-responsive">
                            <table id="grivanceLibraryTable" class="table">
                            	<thead class="thead-dark"></thead>
                            </table>
                        </div>
                        <div id="footerBtn" class="table-paginationbox">
                        </div>
                    </div>
                </div>
            </div>
        
 </body>


<div id="manageAccount" class="modal fade GrievanceHistory-modal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title"><spring:message code="modal.header.grievancehistory" /> 
                <span><spring:message code="input.grievID"/><span class="d-inline-block" id="viewGrievanceId"></span></span></h4>
               	<button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div id="chatMsg" class="chat-history">
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade GrievanceReply-modal" id="replyModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

           <!-- Modal Header -->
             <div class="modal-header">
                <h4 class="modal-title"><spring:message code="input.reply" /> 
                <span><spring:message code="input.grievID"/><span class="d-inline-block" id="grievanceIdToSave"></span></span></h4>
               	<button type="button"  onclick="cleanReplyPopUp()" class="close" data-dismiss="modal">&times;</button>
               	<span id="grievanceTxnId" style="display: none;"></span>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
             <%-- <form action="/action_page.php"> --%>
             <form id="replymessageForm" onsubmit="return saveGrievanceReply()"
				method="POST" enctype="multipart/form-data">
                <div id="viewPreviousMessage" class="replyform-box">
                
                </div>
                <div class="reply-form pb-0">
                <div class="reply-container">
                       <p><spring:message code="input.requiredfields" /> <span class="text-danger">*</span></p>
                            <div class="form-group">
                                <label><spring:message code="input.remarks" /> <span class="text-danger">*</span></label>
                                <input type="text" id="replyRemark" maxlength="200"  class="form-control"
                                oninput="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
								oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200characters" />');"
								required placeholder="Remarkes will here">
								<input type="text" style="display: none" id="grievanceUserid">
                            </div> 
                     <div id="mainDiv" class="mainDiv">
						<div id="filediv" class="row justify-content-end">
								<div class="col-md-6 form-group pr-md-2 mb-0">
										<label><spring:message code="input.documenttype"/></label>	
											<select class="form-control"
										id="docTypetag1" onchange="enableSelectFileforGrievance()"
										oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
										<option value="" disabled selected><spring:message
												code="select.documenttype" />
										</option>

									</select>

								</div>
								
								<div class="file-field col-md-6 form-group pl-md-2 mb-0"  id="removestar">
								    <label style="color: #BDBDBD;"  id="supportingdocumentFile"><spring:message code="input.supportingdocument" /></label>
									
									
									<div class="row">
                                        <div class="col-5 pr-1">
	                                        <label class="btn choose-input p-0">
												<span>
													<%-- <spring:message code="input.selectfile" /> --%> Attach
													<img src="${context}/resources/assets/images/attach-file.svg" alt="icon">
                                                </span> 
                                                <input
													type="file" name="files[]" id="docTypeFile1"
													onchange="enableAddMore('docTypeFile1','filediv')" disabled="disabled"
													oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
													oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');">
													
											</label>
                                        </div>
                                        <div class="col-7 pl-1">
                                            <div class="file-path-wrapper">
												<input class="file-path validate form-control" type="text" id="filetextField"
													placeholder="<spring:message code="grievanceFileMessage"/>" disabled="disabled">
												<div>
													<p id="myFiles"></p>
												</div>
											</div>
                                        </div>
                                    </div>
                                    
                                    
									
								</div>


						</div>

					</div>
					<div class="d-flex justify-content-end">
						<button class="btn right add_field_button add-file-btn btn-light" disabled="disabled" >
							<span style="font-size: 20px;">+</span>
							<spring:message code="input.addmorefile" />
						</button>
					</div>
                            

					
                            </div>
                            <div id="closeTicketCheckbox" style="display: none;" class="modal-footer justify-content-center mt-3 pb-0">
                                <div class="col-12 form-group form-check p-0">
                                    <label class="form-check-label"><spring:message
										code="modal.message.griev.closeticket" /> <input type="checkbox" 
										class="form-check-input" id="closeTicketCheck">
                                    </label>
                                </div>
                                <button class="btn" type="submit" id="grievanceReplyButton">
                                <spring:message code="input.reply" /></button>
                     </div>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>

		<div id="replyMsg" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.grievancereply" />
		</h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="showReplyResponse">
					<spring:message code="modal.message.grievance.reply" />
					<span id="replyGrievanceId"> </span>
					<spring:message code="modal.issuccessful" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="./grievanceManagement" class="modal-close btn"><spring:message
								code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

		
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

	<script>var ctx = "${pageContext.request.contextPath}"</script>
	<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/grievanceManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
	
	<script type="text/javascript">
	function enableSelectFileforGrievance(){
		if($('#docTypetag1').val() != ''){
			$("#docTypeFile1").attr("disabled", false);
			$("#docTypeFile1").attr("required", true);
			$("#removestar").find(".star").remove();
			$("#supportingdocumentFile").append('<span class="star">*</span>');
		}else{
			$("#docTypeFile1").attr("required", false);
			$('#filetextField').val('');
			$("#removestar").find(".star").remove();
		}
		
	}
	
	</script>

	
	
<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
<script type="text/javascript">var countHit="";  $( document ).ready(function() {   if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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
%>
<script language="JavaScript">
sessionStorage.setItem("loginMsg",
"*Session has been expired");
window.top.location.href = "./login";
</script>

<%
}
%>