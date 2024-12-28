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
   <body data-id="26" data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" 
   	data-selected-roleType="${selectedUserTypeId}" 
      data-stolenselected-roleType="${stolenselectedUserTypeId}"
      data-period="${period}" data-msisdn="${msisdn}" data-imei="${imei}"
	 data-selected-username="${username}"
	 data-featureId="${featureId}" >
      
         <div class="content-box">
                <div class="content-container">
                <div id="initialloader"></div>
                    <div class="content-header">
                        <h1>Device Information</h1>
                    </div>
                    <div class="form-content">
                        <form>
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <label for="">IMEI</label>
                                    <input type="text"  class="form-control disabled-white" id="imei" placeholder="NA" disabled>
                                  </div>
                                  <div class="form-group col-md-3">
                                    <label for="">IMSI</label>
                                    <input type="text" class="form-control disabled-white" id="imsi" placeholder="NA" disabled>
                                  </div>
                                  <div class="form-group col-md-3">
                                    <label for="">MSISDN</label>
                                    <input type="text" class="form-control disabled-white" id="msisdn" placeholder="NA" disabled>
                                  </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <label for="">Handset Type</label>
                                    <input type="text" class="form-control disabled-white" id="handsetType" placeholder="NA" disabled>
                                  </div>
                                  <div class="form-group col-md-3">
                                    <label for="">OS Type</label>
                                    <input type="text" class="form-control disabled-white" id="osType" placeholder="NA" disabled>
                                  </div>
                                  <div class="form-group col-md-3">
                                    <label for="">Brand Name</label>
                                    <input type="text" class="form-control disabled-white" id="brandName" placeholder="NA" disabled>
                                  </div>
                                  <div class="form-group col-md-3">
                                    <label for="">Model Name</label>
                                    <input type="text" class="form-control disabled-white" id="modelName" placeholder="NA" disabled>
                                  </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <label for="">Marketing Name</label>
                                    <input type="text" class="form-control disabled-white" id="marketingName" placeholder="NA" disabled>
                                  </div>
                                  <div class="form-group col-md-3">
                                    <label for="">Manufacturer</label>
                                    <input type="text" class="form-control disabled-white" id="manufactureName" placeholder="NA" disabled>
                                  </div>
                                  <div class="form-group col-md-3">
                                    <label for="">Organization ID</label>
                                    <input type="text" class="form-control disabled-white" id="organizationId" placeholder="NA" disabled>
                                  </div>
                                  <div class="form-group col-md-3">
                                    <label for="">TRC Approval Status</label>
                                    <input type="text" class="form-control disabled-white" id="trcApprovalStatus" placeholder="NA" disabled>
                                  </div>
                            </div>
                          </form>

                          <div class="Status-table pt-3">
                            <h5>Device Status</h5>
                          <div class="row">
                            <div class="col-md-12">
                              <div class="table-responsive">
                                <table class="table" id="DeviceStateTable">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Status</th>
                                            <th>Date</th>
                                            <th>State</th>
                                            <th>View</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            </div>
							</div>
                        </div>
                    </div>
                </div>
            </div>
   </body>
  
<%-- <div id="ViewBlackListTableDetailModel" class="modal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-lg" role="document">
	  <div class="modal-content">
		<div class="modal-header">
		  <h5 class="modal-title">Black List</h5>
		</div>
		<div class="modal-body">
				<div class="form-row">
				  <div class="form-group col-md-6">
					<label for="blacklistCreatedOn">Created On</label>
					<input type="text" class="form-control" id="blacklistCreatedOn" placeholder="NA" disabled>
				  </div>
				  <div class="form-group col-md-6">
					<label for="blacklistModifiedOn">Modified On</label>
					<input type="text"  class="form-control" id="blacklistModifiedOn" placeholder="NA" disabled >
				  </div>
				</div>

				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="blacklistImei">IMEI</label>
						<input type="text" class="form-control" id="blacklistImei" placeholder="NA" disabled >
					</div>
					<div class="form-group col-md-6">
						<label for="blacklistMsisdn">MSISDN</label>
						<input type="text" class="form-control" id="blacklistMsisdn" placeholder="NA" disabled >
					</div>
				  </div>

				  <div class="form-row">
					<div class="form-group col-md-6">
						<label for="blacklistImsi">IMSI</label>
						<input type="text" id="blacklistImsi" class="form-control" placeholder="NA" maxlength="20" disabled>
					</div>
				</div>

				  
		</div>
		<div class="modal-footer">
			<button class="cancel-product btn modal-close"><spring:message code="modal.close" /></button>
		</div>
	  </div>
	</div>
  </div> --%>
    
     <!-- Modal View-->
 <div class="modal fade" id=ViewTableDetailModel tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog.modal-lg-detail" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="tableModelLabel"></h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div id="mainTableDiv" class="modal-body">
            <div class="content-container">
                <div class="table-box TableBorder">
                    <table id="tableDetailDatatable" class="table">
                        <thead class="thead-dark">
                            <tr>
                                
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table> 
                    <div class="table-responsive">


<br>
</div>
                </div>
            </div>
        </div>
      </div>
       <div id="historyTableDiv" class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="historyTableModelLabel"></h5>
          
        </div>
        <div class="modal-body">
            <div class="content-container">
                <div class="table-box TableBorder">
                    <table id="tableHistoryDetailDatatable" class="table">
                        <thead class="thead-dark">
                            <tr>
                                
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table> 
                    <div class="table-responsive">


<br>
</div>
                </div>
            </div>
        </div>
      </div>
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
      src="${context}/resources/project_js/searchIMEIContent.js?version=<%= (int) (Math.random() * 10) %>"></script>
   <script type="text/javascript"
      src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>

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
   </body>
</html>
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