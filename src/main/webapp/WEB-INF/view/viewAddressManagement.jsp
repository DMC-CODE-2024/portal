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







<div id="editModal" class="modal" tabindex="-1" role="dialog">
<div class="modal-dialog modal-lg" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title">Edit Address List Management</h5>
</div>
<div class="modal-content_">
<form id="form1">
<div class="modal-body">
<div class="form-row">
<div class="form-group col-md-6">
<label for="">Province in english<span>*</span></label>
<select id="province-edit" name="editState" name="state" class="form-control" class="mySelect" onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required>
<option value='' >Select</option>
</select>
</div>


<div class="form-group col-md-6">
<label for="">District in english <span>*</span></label>
<select id="district-edit" name="editState" name="district" class="form-control" class="mySelect" onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required>
<option value='' >Select</option>
</select>
</div>
</div>

<div class="form-row">
<div class="form-group col-md-6">
<label for="">Commune in english <span>*</span></label>
<select id="commune-edit" name="editState" name="commune" class="form-control" class="mySelect" onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required>
<option value=''>Select</option>
</select>
</div>
</div>




<div class="form-row">
<div class="form-group col-md-6">
<label for="">Province in khmer<span>*</span></label>
<select id="province-edit-kh" name="editState" name="state" class="form-control" class="mySelect" onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required>
<option value='' >Select</option>
</select>
</div>


<div class="form-group col-md-6">
<label for="">District in khmer <span>*</span></label>
<select id="district-edit-kh" name="editState" name="district" class="form-control" class="mySelect" onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required>
<option value='' >Select</option>
</select>
</div>
</div>

<div class="form-row">
<div class="form-group col-md-6">
<label for="">Commune in khmer <span>*</span></label>
<select id="commune-edit-kh" name="editState" name="commune" class="form-control" class="mySelect" onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required>
<option value=''>Select</option>
</select>
</div>
</div>
</div>
<div class="modal-footer">
<button class="save-product btn" onclick="update(event)" style="margin-left: 10px;"><spring:message code="button.update" /></button>
<button class="cancel-product btn modal-close" type="button" style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
</div>
</form>
</div>
</div>
</div>
</div>





<div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="">Delete Address List Management</h5>

</div>
<div class="modal-body prl-80">
<div class="form-row">
<div class="form-group col-md-12 mb-4">
<center><label for="">Are you sure you want to delete ?</label></center>
</div>
</div>

<div class="form-row">
<div class="form-group col-md-12 center">
<button type="button" class="btn btn-primary save-product mr-1" data-target="#confirmationModal" onclick="deleteByID()">Yes</button>
<button type="button" class="btn btn-outline-danger modal-close cancel-product" >No</button>
</div>
</div>

</div>
</div>
</div>
</div>


<div id="updateFieldsSuccess" class="modal" tabindex="-1" role="dialog">
<div class="modal-dialog modal-lg" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="modalTitle">Update Address List Management</h5>
</div>
<div class="modal-body">
<p id="updateFieldMessage"></p>
</div>
<div class="modal-footer">
<a href="${context}/address-management?featureId=102" class="cancel-product btn modal-close"><spring:message code="modal.ok" /></a>
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
<script type="text/javascript"
src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

<script type="text/javascript"
src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>
<%-- 	<script type="text/javascript"
		src="${context}/resources/project_js/service_status.js?version=<%= (int) (Math.random() * 10) %>"></script> --%>
<script type="text/javascript"
src="${context}/resources/project_js/viewAddressManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
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

