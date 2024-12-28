<%@ page import="java.util.Date" %>
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
<link rel="stylesheet" href="${context}/resources/assets/css/RePairDevice.css">
<link rel="stylesheet" href="${context}/resources/assets/css/style.css">


<style>
body{
    background: #f1f1f1 !important;
}    
.content-box {
    width: 100% !important;
    padding: 0px 10px 20px 10px;
    height: 100%;
}

.width-90 {
    width: calc(100% - 0px) !important;
    margin: auto;
    padding: 0px 0px 20px 0px;
}
 
.content-box h1 {
    font-size: 24px;
    font-weight: 600;
    text-align: center;
    margin: 0 0 0 0px !important; 
}    

.dataTables_wrapper .dataTables_scroll {
clear: both;
overflow-x: inherit !important;
}
</style>
</head>

<body data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
data-selected-username="${username}"
data-stolenselected-roleType="${stolenselectedUserTypeId}"
data-lang-param="${pageContext.response.locale}"
data-layout="horizontal"
data-featureId="${featureId}"
style="background-color:#fff;">

<input type="text" id="langList" value="${lang}" style="display:none">
<!-- START CONTENT -->
<div class="content-box">
<div class="content-container">
    <div class="content-header" data-tooltip-id="">
        <h1 data-tooltip-id="">
            Search
        </h1>
    </div>
<div class="width-90 mt-35_" id="ccFormDiv">
<div class="form-content">
<form id="ccform">
<div class="form-row align-items-center">
<div class="form-group col-md-4 mb-3">
<label> <spring:message code="tag.cc.requestId" /><span class="red"> *</span></label>
<input type="text" autocomplete="off" class="form-control mb-2" id="requestId"
 minlength="18" maxlength="18" oninput="InvalidMsg(this,'input','<spring:message code="pattern.transactionId" />');"
 oninvalid="InvalidMsg(this,'input','<spring:message code="pattern.transactionId" />');"
 placeholder="<spring:message code="tag.cc.placeholder.requestId" />" required>
</div>
<div class="col-auto">
<button type="submit" class="btn save-button" ><spring:message code="tag.cc.search" /></button>
<button type="button" class="btn cancel-btn" onclick="resetAll()"><spring:message code="tag.cc.clear" /></button>
</div>
</form>
</div>
</div>
</div>
</div>




<div class="width-90 mt-20 center  width-100"  id="ccValidModal" style="display:none">
<p class="mb-10"><img src="${context}/resources/assets/images/CheckIcon.svg" alt="logo" class="img-fluid"></p>
<p><spring:message code="tag.cc.confirmationMsg" /></p>
<div class="row">

<div class="table-box TableBorder">
<table class="table align-left display" id="requestIDdatatable">
<thead class="thead-dark">
<tr>

</tr>
</thead>
<tbody>
</tbody>
</table>
</div>

<div class="col-lg-12 mt-20">

<div class="no-border center">
<a href="${context}/customer-care" type="button" class="btn orange-button width50-btn"><spring:message code="tag.cc-pair.done" /></a></div>
</div>
</div>
</div>
</div>

    <div class="width-90 mt-20 center width-100" id="rejectedMsgModal" style="display:none">
    <p class="mb-10"><img src="${context}/resources/assets/images/close.svg" alt="logo" class="img-fluid"></p>

    <p id="rejectModalMsg"><spring:message code="cc.invalid.id" /></p>
    <div class="row">
    <div class="col-lg-12 mt-20">
    <div class="col-lg-12 mt-20">
    <div class="no-border center">
    <a href="${context}/customer-care" type="button" class="btn orange-button width50-btn"><spring:message code="tag.cc-pair.done" /></a></div>
    </div>
    </div>
    </div> </div>

</body>


<%-- <script src="${context}/resources/assets_imei/js/custom.js"></script> --%>
<script type="text/javascript"
src="${context}/resources/plugins/materialize.js"></script>
<script type="text/javascript"
src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

<script src="https://www.google.com/recaptcha/api.js"></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=en"
async defer>
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
src="${context}/resources/project_js/pair-cc.js?version=<%= (int) (Math.random() * 10) %>"></script>
<script type="text/javascript"
src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
<script type="text/javascript"
src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>

</html>


