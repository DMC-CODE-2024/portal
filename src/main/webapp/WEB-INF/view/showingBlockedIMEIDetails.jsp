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

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon"
	href="${context}/resources/assets/images/logo.png">
<%-- <link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection"> --%>
<link rel="stylesheet"
	href="${context}/resources/assets/css/bootstrap.min.css">
<script src="${context}/resources/assets/js/jquery.min.js"></script>
<script src="${context}/resources/assets/js/popper.min.js"></script>
<script src="${context}/resources/assets/js/bootstrap.min.js"></script>


<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
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
<body data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-selected-username="${username}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-featureId="${featureId}">

	<!-- START CONTENT -->
	<div class="content-box">
                <div class="content-container">
                    <div class="content-header d-flex align-items-center justify-content-between" id="pageHeader">
                    </div>
                    <div class="filter-box">
                        <form action="" class="filter-row" id="viewFilter">
                        	<div id="errorMsgDiv" class="filter-form-row" style="width: 100%;"></div>
       						<div id="filterSection" class="filter-form-row"></div>
       						<div id="filterButtonSection" class="filter-btn-row"></div>
                        </form>
                    </div>
                    <div class="table-box">
                        <div class="table-responsive">
                            <table id="server-side-table" class="table">
                            	<thead class="thead-dark"></thead>
                            </table>
                        </div>
                        <div id="footerBtn" class="table-paginationbox">
                        </div>
                    </div>
                </div>
            </div>




<div class="modal fade" id="NewRequest" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">New Request</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body_">
            <div class="product-detail-section">
                <div class="row">
                    <div class="col-md-12">
                        <ul class="nav nav-tabs product-tabs border-0">
                            <li><a data-toggle="tab" href="#tab1" class="active">Single</a></li>
                            <li><a data-toggle="tab" href="#tab2">Bulk</a></li>
                        </ul>

                        <div class="tab-content">
                            <div id="tab1" class="tab-pane active">

                               <div class="RequestForm">
                                <form id="form1" action="" onsubmit="return singleRequest()">
                                    <div class="form-group row">
                                      <label for="inputEmail3" class="col-sm-3 col-form-label">MSISDN</label>
                                      <div class="col-sm-9">
                                        <input type="" class="form-control" id="form1-msisdn" minlength="9" maxlength="12" pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo-lm')" />"  oninput="InvalidMsg(this,'input','<spring:message code="validation.msisdn.10digit" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.msisdn.10digit" />');" placeholder="Enter 11 or 12 Digit MSISDN Number" >
                                      </div>
                                    </div>
                                    <div class="form-group row">
                                      <label for="inputPassword3" class="col-sm-3 col-form-label">IMEI</label>
                                      <div class="col-sm-9">
                                         <input type="" class="form-control" id="form1-imei" pattern="<spring:eval expression="@environment.getProperty('pattern.ImeiAplhanumericLength16')" />" minlength="1" maxlength="16" oninput="InvalidMsg(this,'input','<spring:message code="validation.imeialphanumeric.16digit" />');"
                                         oninvalid="InvalidMsg(this,'input','<spring:message code="validation.imeialphanumeric.16digit" />');" placeholder="Enter 1 to 16 AlphaNumeric IMEI Number" ></div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="inputPassword3" class="col-sm-3 col-form-label">IMSI</label>
                                        <div class="col-sm-9">
                                          <input type="" class="form-control" id="form1-imsi" minlength="15" maxlength="15" pattern="<spring:eval expression="@environment.getProperty('pattern.imsi')" />" oninput="InvalidMsg(this,'input','<spring:message code="validation.imsi.15digit" />');"
                                           oninvalid="InvalidMsg(this,'input','<spring:message code="validation.imsi.15digit" />');"placeholder="Enter 15 Digit IMSI Number" >
                                        </div>
                                      </div>
                                      <div class="form-group row">
                                        <label for="inputPassword3" class="col-sm-3 col-form-label">Category <span class="star">*</span></label>
                                        <div class="col-sm-9">
                                            <select class="form-control" id="form1-type" required>
                                                                         <option value='' selected>Select</option>
                                            </select>
                                        </div>
                                      </div>
                                      <div class="form-group row">
                                        <label for="inputPassword3" class="col-sm-3 col-form-label">Request Type <span class="star">*</span></label>
                                        <div class="col-sm-9">
                                            <select class="form-control" id="form1-action" required>
                                 <option value='' selected>Select</option>
                                            </select>
                                        </div>
                                      </div>
                                      <div class="form-group row">
                                        <label for="inputPassword3" class="col-sm-3 col-form-label">Remarks</label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control"  maxlength="250" id="form1-remarks" placeholder="Enter Remarks if any" rows="2"></textarea>
                                        </div>
                                      </div>
                                    <div class="form-group row">
                                      <div class="col-sm-12 center">
                                        <button type="submit" id="form1-submit" class="btn Submit-button">Submit</button>
                                      </div>
                                     <span id="errorDiv" class=""></span></div>
                                  </form>
                                </div>
                            </div>
                            <div id="tab2" class="tab-pane fade">
                                <div class="RequestForm">
                                    <form id="form2" action="" onsubmit="return bulkRequest()">
                                          <div class="form-group row">
                                            <label for="inputPassword3" class="col-sm-3 col-form-label">Category <span class="star">*</span></label>
                                            <div class="col-sm-9">
                                                <select class="form-control" id="form2-type" required>
                                                 <option value='' selected>Select</option>
                                                 </select>
                                            </div>
                                          </div>
                                          <div class="form-group row">
                                            <label for="inputPassword3" class="col-sm-3 col-form-label">Request Type <span class="star">*</span></label>
                                            <div class="col-sm-9">
                                                <select class="form-control" id="form2-action" required>
                                                 <option value='' selected>Select</option> </select>
                                            </div>
                                          </div>
                                          <div class="form-group row">
                                            <label for="inputPassword3" class="col-sm-3 col-form-label">Remarks</label>
                                            <div class="col-sm-9">
                                                <textarea class="form-control" id="form2-remarks"  maxlength="250" placeholder="Enter Remarks if any" rows="2"></textarea>
                                            </div>
                                          </div>
                                          <div class="form-group row">
                                            <div class="col-sm-12">
                                                <input type="file" class="input-file mb-1"  accept=".csv" id="fileInput" oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
                                                onchange="validateFile(this,'CSV_ALLOWED');" required>
                                                <p><a href="#" onclick="if(typeof sampleFileDownloadById === 'function') sampleFileDownloadById('87','sample_bimei')"><img src="${context}/resources/assets/images/download-icon-blue.svg" alt="icon" title="TA file" class="img-fluid"><small> Download Sample File </small></a></p>

                                            </div>
                                          </div>
                                        <div class="form-group row">
                                          <div class="col-sm-12 center">
                                          <button type="submit" id="form2-submit" class="btn Submit-button">Upload</button>
                                          </div>
                                            <div id="form2-errorDiv" class="filter-form-row" style="width: 100%;color: red;font-size: 15px;left: 23px;margin: 0;"></div>

                                        </div>
                                    </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>

        </div>
      </div>
    </div>
  </div>

 <!-- Modal View -->
 <div class="modal fade" id="ViewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">View Blocked List</h5>
        </div>

        <div class="modal-body">
          <div class="product-detail-section">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-row">
                            <div class="form-group col-md-4">
                              <label for="">MSISDN </label>
                              <input type="" class="form-control" id="view-msisdn"  readonly="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="">IMEI</label>
                                <input type="" class="form-control" id="view-imei"  readonly="">
                              </div>
                              <div class="form-group col-md-4">
                                <label for="">IMSI</label>
                                <input type="" class="form-control" id="view-imsi"  readonly="">
                              </div>
                          </div>

                          <div class="form-row">
                            <div class="form-group col-md-4">
                              <label for="">Transaction ID </label>
                              <input type="" class="form-control" id="view-txnid" readonly="">
                            </div>
                            <div class="form-group col-md-4">
                              <label for="">Mode</label>
                              <input type="" class="form-control" id="view-mode" readonly="">
                            </div>
                            <div class="form-group col-md-4">
                              <label for="">Status</label>
                              <input type="" class="form-control" id="view-status"  readonly="">
                            </div>
                          </div>

                          <div class="form-row">
                            <div class="form-group col-md-4">
                              <label for="">Request Type </label>
                              <input type="" class="form-control" id="view-request-type" readonly="">
                            </div>
                            <div class="form-group col-md-4">
                              <label for="">Category</label>
                              <input type="" class="form-control" id="view-category" readonly="">
                            </div>
                            <div class="form-group col-md-4">
                              <label for="">TAC</label>
                              <input type="" class="form-control" id="view-tac"  readonly="">
                            </div>
                          </div>

                          <div class="form-row">
                            <div class="form-group col-md-4">
                              <label for="">File Name </label>
                              <input type="" class="form-control" id="view-filename" readonly="">
                            </div>
                            <div class="form-group col-md-4">
                              <label for="">Quantity</label>
                              <input type="" class="form-control" id="view-quantity" readonly="">
                            </div>
                            <div class="form-group col-md-4">
                              <label for="">Uploaded By</label>
                              <input type="" class="form-control" id="view-addedby"  readonly="">
                            </div>
                          </div>

                          <div class="form-row">
                            <div class="form-group col-md-12">
                              <label for="">Remarks </label>
                              <textarea id="view-remarks" class="form-control"  rows="3" readonly=""></textarea>
                            </div>
                          </div>

                          <div class="close-row">
                         	<button class="cancel-product btn modal-close" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
                         			</div>

                    </div>
                </div>
            </div>
        </div>
      </div>
    </div>
  </div>
    <!-- Modal View Close-->

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
		<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>

		<script type="text/javascript"
	<script type="text/javascript"
		src="${context}/resources/project_js/blocked-imei.js?version=<%= (int) (Math.random() * 10) %>"></script>
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

