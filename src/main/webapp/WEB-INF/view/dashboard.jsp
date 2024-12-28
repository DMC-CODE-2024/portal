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
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


    <!-- Security Tags -->
    <%@ taglib prefix="sec"
    uri="http://www.springframework.org/security/tags"%>
    <sec:csrfMetaTags />
    <!-- Security Tags -->
    <%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>
    <c:set var="context" value="${pageContext.request.contextPath}" />
    <!DOCTYPE html>
    <html lang="en" class="no-js">
    <head><title>EIRS Portal</title>
    <!--<title>Dashboard</title>-->
    <meta charset="utf-8" />
    <meta name="viewport"
    content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="" name="description" />
    <meta content="" name="author" />

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${context}/resources/assets/images/logo.png">
    <link rel="stylesheet" href="${context}/resources/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${context}/resources/assets/css/style.css">
    <script src="${context}/resources/assets/js/jquery.min.js"></script>
    <script src="${context}/resources/assets/js/popper.min.js"></script>
    <script src="${context}/resources/assets/js/bootstrap.min.js"></script>
    <!----AlertNotifications---->
    <link rel="stylesheet" href="${context}/resources/assets/css/AlertNotifications.css">
    <link rel="stylesheet" href="${context}/resources/assets/css/AlertNotificationsDefault.css">
    <script src="${context}/resources/assets/js/AlertNotifications.js"></script>
    <!----AlertNotifications close---->
    <!-- Security Tags -->
    <meta name="_csrf" content="${_csrf.token}" />
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <!-- Security Tags -->

    <link rel="shortcut icon" href="">
    <script type="text/javascript"
    src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>

    <!-- CSS for fa fa ICONS -->
    <link
    href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
    type="text/css" rel="stylesheet" media="screen,projection">

    <!-- Custome CSS-->
    <link rel="stylesheet"
    href="${context}/resources/custom_js/jquery-ui.css">
    <script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
    <script>
    var contextpath = "${context}";
    <%String usertype = (String) session.getAttribute("usertype");
    String name = (String) session.getAttribute("name");
    Integer usertypeId = (Integer) session.getAttribute("usertypeId");
    if (usertypeId == null) {
    usertypeId = 0;
    }

    Integer selfRegister = (Integer) session.getAttribute("selfRegister");
    if (selfRegister == null) {
    selfRegister = 0;
    }%>
    </script>
    <jsp:include page="alertify.jsp" /></head>
    </head>

    <body data-lang="${language}" data-usertype="${usertype}"
    data-roleType="${usertype}" data-userTypeID="${usertypeId}"
    data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
    data-stolenselected-roleType="${stolenselectedUserTypeId}"
    data-selected-consignmentTxnId="${consignmentTxnId}"
    data-operatorTypeId="${operatorTypeId}"
    data-selected-consignmentStatus="${consignmentStatus}"
    data-selected-username="${username}"
    data-defaultLink="${defaultLink}"
    data-featureID="${feature.id}"
    data-currentTime=" <%=currentTime%>"
    data-dfd=" <%=dfd%>"
    data-user-state="${userStatusValue}">
    <style type="text/css">
    .modal-header {
    display: -ms-flexbox;
    display: inline;
    -ms-flex-align: start;
    align-items: flex-start;
    -ms-flex-pack: justify;
    justify-content: space-between;
    padding: 1rem 1rem;
    border-bottom: 1px solid #dee2e6;
    border-top-left-radius: calc(0.3rem - 1px);
    border-top-right-radius: calc(0.3rem - 1px);
    }
    .field-icon {
    float: right;
    margin-top: -26px !important;
    margin-right: 7px !important;
    position: relative;
    z-index: 2;
    cursor: pointer;
    }
    .modal-footer {
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    -ms-flex-align: center;
    align-items: center;
    -ms-flex-pack: end;
    justify-content: flex-end;
    padding: 0.75rem;
    border-top: 1px solid #ffff;
    border-bottom-right-radius: calc(0.3rem - 1px);
    border-bottom-left-radius: calc(0.3rem - 1px);
    }
    .modal .modal-header {
    background: var(--main-color) !important;
    color: var(--white-color) !important;
    width: 100%;
    float: left;
    }
    .input-field input {
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    }
    .input-field-addon {
    float: right;
    margin-left: -25px;
    margin-top: -25px;
    position: relative;
    z-index: 2;
    right: 10px;
    }

    </style>
    <!-- Start Page Loading -->
    <!-- <div id="loader-wrapper">

    <div class="loader-section section-left"></div>
    <div class="loader-section section-right"></div>
    </div> -->
    <!-- End Page Loading -->
    <!-- //////////////////////////////////////////////////////////////////////////// -->

    <!-- START HEADER -->
    <div class="dashboard-layout">
    <div class="dashboard-header navbar navbar-expand navbar-dark align-items-center">
    <!-- Brand -->
    <a class="navbar-brand">
    <img src="${context}/resources/assets/images/logo.png" alt="logo" class="img-fluid">
    <span id="cierRoletype"> <spring:message code="page.eir" /> </span>

    <%
    if ("Operator".equalsIgnoreCase(usertype)) {
    %> - <%=session.getAttribute("operatorTypeName")%> <%
    } else {
    }
    %> </a>
    <p class="company-name" >
    <spring:message code="page.welcome" />
    <%=name%>(<%=(String) session.getAttribute("username")%>)
    <!-- <br><span id="userState"></span> -->
    </p>
    <ul class="navbar-nav ml-auto">
    <li class="nav-item">
    <!--
    <form id="manualDownload" autocomplete="off" action="./Consignment/ManualFileDownload" method="post">
    <input type="hidden" name="userTypeId" value="${usertypeId}">
    <input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
    <input type="hidden" name="contextName">
    <a class="nav-link" href="javascript:{}" onclick="document.getElementById('manualDownload').submit();">
    <img src="${context}/resources/assets/images/Download.svg" alt="">
    </a>
    </form> -->



    <a class="nav-link" href="javascript:void(0)" onclick="downloadUserGuide()" target="mainArea">
    <img src="${context}/resources/assets/images/Download.svg" alt="">
    </a>

    </li>


    <li>
    <div style="width: 80px !important;" id="lang_selectction">
    <select class="browser-default select-lang-drpdwn"
    id="langlist">
    <option value="en">English</option>
    <option value="km"><spring:message code="lang.khmer" /></option>
    </select>
    </div>
    </li>

    <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbardrop" data-toggle="dropdown" data-activates="profile-dropdown">
    <img src="${context}/resources/assets/images/Account-circle.svg" alt="icon" class="img-fluid">
    </a>
    <div id="profile-dropdown" class="dropdown-menu dropdown-menu-right">
    <div class="dropdown-header">
    <img src="${context}/resources/assets/images/Account-circle-black.svg" alt="">
    </h6>
    </div>
    <ul id="profile-dropdown" class="dropdown-content">
    <%
    if (selfRegister != 0) {
    %>
    <!-- <li><a class="dropdown-item" id="editLink" href="javascript:void(0)"
    target="mainArea"><i class="fa fa-pencil dropdownColor"
    style="float: left;"></i><span style="float: left"
    class="dropdownColor"><spring:message
    code="registration.editinfo" /></span></a></li>

    <li><a class="dropdown-item" onclick="manageAccountPopup();"
    href="javascript:void(0)"><i
    class="mdi-action-settings dropdownColor"></i> <span
    class="dropdownColor"> <spring:message
    code="registration.activate/deactivateaccount" /></span></a></li>
    -->

    <%
    }
    %>

    <%
    if (selfRegister == 0) {
    %>
    <!-- <li>
    <a class="dropdown-item" id="viewProfile" href="./userManagement?type=user_view" target="mainArea"  class="dropdown-item" href="#">
    <span> <spring:message code="registration.viewProfile" /></span>
    </a>
    </li> -->
    <%
    }
    %>

    <li><a class="dropdown-item" href="javascript:void(0)"
    onclick="changePasswordPopup()">
    <span><spring:message code="registration.changepassword" /></span></a></li>


    <li><a class="dropdown-item" href="javascript:void(0)" onclick="openLogout()">
    <span> <spring:message code="registration.logout" /></span></a></li>
    </ul>
    </div>
    </li>


    </ul>
    </div>
    <!-- END HEADER -->

    <!-- //////////////////////////////////////////////////////////////////////////// -->

    <!-- START MAIN -->
    <div class="content-row">
    <div class="sidebar-box">
    <ul class="navbar-nav" id="sidebarUlID">
    <c:forEach items="${features}" var="feature">

    <li class="nav-item">
    <a class="nav-link" href="${feature.link}&FeatureId=${feature.id}"
    target="mainArea" data-featureID="${feature.id}" id="">
<img src="/docs/repo/${feature.logo}" alt="icon" class="img-fluid">
    <span><spring:message code="sidebar.${fn:replace(feature.name, ' ', '_')}" /></span>
    <!-- <span>FeatureName</span> -->
    </a>
    </li>
    </c:forEach>
    </ul>
    <p class="sidear-footer"> <spring:message code="registration.copyright"/></p>
    </div>
    <div class="main-content-box position-relative">
    <iframe name="mainArea" class="embed-responsive-item position-absolute h-100 w-100" id="mainArea" frameborder="0"
    src="${defaultLink}"  width="100%"  data-tooltip-id="353827d0-dc87-adef-ff26-bb11e9b8769e"></iframe>
    </div>

    </div>
    <!-- END MAIN -->

    </div>



    <!-- //////////////////////////////////////////////////////////////////////////// -->

    <!-- START FOOTER -->
    <%-- <footer class="page-footer">
    <div class="footer-copyright">
    <div class="container">

    <span id="copyrightText" class="right"><spring:message
    code="registration.copyright" /></span>

    </div>
    </div>
    </footer> --%>

    <!-- END FOOTER -->
    <div id="manageAccount" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
    <h5 class="modal-header"><spring:message code="registration.manageaccount" /></h5>

    <div class="modal-body">
    <form id="userStatusForm" onsubmit="return passwordPopup()">
    <span style="text-align: center; color: red;" id="errorMsg"></span>

    <p>
    <spring:message code="registration.requestceiradminto" />
    </p><br>

    <p>
    <label style="margin-right: 50px"> <input type="radio"
    name="status" value="Deactivate" id="deac" oninput="InvalidRadioMsg('radio');"
    oninvalid="InvalidRadioMsg('radio');"
    required> <span> <spring:message
    code="registration.deactivate" />
    </span></label>
    <spring:message code="registration.permanentlydeleteportal" />
    </p>

    <%
    //String status = (String) session.getAttribute("userStatus");
    Integer statusValue = (Integer) session.getAttribute("userStatusValue");

    %>
    <%
    if (statusValue == 3) {
    %>
    <p>
    <label style="margin-right: 67px"> <input type="radio"
    value="Disable" name="status"
    title=""required  > <span> <spring:message
    code="registration.disable" />
    </span></label>
    <spring:message code="registration.alltheactionwillbe" />
    </p>
    <%
    } else if (statusValue == 5) {
    %>

    <p>
    <label style="margin-right: 67px"> <input type="radio"
    value="Approved" name="status" required="required"><span>
    <spring:message code="registration.enable" />
    </span></label>
    <spring:message code="registration.allactionable" />
    </p>

    <%
    } else {
    }
    %>
    </div>
    <div class="modal-footer">
    <button class="save-product btn" id="updateStatusBtn"><spring:message code="button.submit" /></button>
    <button type="button" class="cancel-product btn modal-close"><spring:message code="modal.cancel" /></button>
    </div>
    </form>

    </div>
    </div>
    </div>
    <!-- Modal End -->

    <!-- Modal 4 start   -->

    <div id="manageAccountSubmit" class="modal">
    <h5 class="modal-header">
    <spring:message code="registration.manageaccount" />
    </h5>
    <div class="modal-content">
    <h6 id="mgAccount">
    <!-- The request has been successfully registered with CEIR
    Admin. Please find confirmation over registered mail in 2 to 3
    working days. -->
    </h6>

    <div class="input-field col s12 center">

    <form action="./login?isExpired=yes" method="post">
    <input type="hidden" name="${_csrf.parameterName}"
    value="${_csrf.token}" />

    <button type="submit" class="btn">
    <spring:message code="modal.ok" />
    </button>

    </form>

    </div>
    </div>
    </div>
    <!-- Modal End -->

    <!-- Modal 4 start   -->
    <div class="modal fade" id="changePassword" role="dialog">
    <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
    <form id="changePassForm" onsubmit="return changePassword();">
    <h6 class="modal-header">
    <spring:message code="registration.changepassword" />
    </h6>
    <div class="modal-body">
    <div class="form-row">
    <div class="col-md-12 mb-3">
    <div>
    <span style="text-align: center; color: red;" id="errorMsg"></span>
    <div class="col s1">

    <label for="oldPassword" class="center-align" style="color: #000; font-size: 12px;" data-tooltip-id="9f1d9475-6b00-3f83-2b9d-42d67aac990a">
    <i class="fa fa-lock" aria-hidden="true" style="font-size: 30px; margin-top: 12px; color: #ff4081;" data-tooltip-id="453af59d-94f1-3ad8-b2e6-8864e1ee3e6a"></i> Old Password
    </label>
    </div>
    <div class="input-field col s11" data-tooltip-id="88040930-0a1a-3178-cf65-f0683780c0cf">
    <input type="password" id="oldPassword" class="password" autocomplete="off" pattern="^(?=.*[A-Za-z0-9])(?=.*\d)(?=.*[@$!%*#?&amp;])[A-Za-z\d@$!%*#?&amp;]{8,10}$" maxlength="10" min="8" oninput="InvalidMsg(this,'input','
    Please enter at least one numeric char, one alphabet, one special character and must be of minimum 8 and maximum 10 length');" oninvalid="InvalidMsg(this,'input','
    Please enter at least one numeric char, one alphabet, one special character and must be of minimum 8 and maximum 10 length');" required="" title=" " data-tooltip-id="2550140d-dc81-8f03-ea91-265ba2de4e25">
    <div class="input-field-addon" data-tooltip-id="a3d83b23-27e0-7bf2-7bf6-9139e527e6d3"> <i class="fa fa-eye-slash teal-text toggle-password" aria-hidden="true" data-tooltip-id="990aaeca-bbd3-b63d-0a63-56f61a4a5f7e"></i> </div>
    </div>

    </div>
    </div>

    <div class="col-md-12 mb-3">
    <div>
    <div class="col s1">

    <label for="newPassword" class="center-align" style="color: #000; font-size: 12px;" data-tooltip-id="9f1d9475-6b00-3f83-2b9d-42d67aac990a">
    <i class="fa fa-lock" aria-hidden="true" style="font-size: 30px; margin-top: 12px; color: #ff4081;" data-tooltip-id="453af59d-94f1-3ad8-b2e6-8864e1ee3e6a"></i> New Password
    </label>
    </div>
    <div class="input-field col s11" data-tooltip-id="88040930-0a1a-3178-cf65-f0683780c0cf">
    <input type="password" id="password" class="password" autocomplete="off" pattern="^(?=.*[A-Za-z0-9])(?=.*\d)(?=.*[@$!%*#?&amp;])[A-Za-z\d@$!%*#?&amp;]{8,10}$" maxlength="10" min="8" oninput="InvalidMsg(this,'input','
    Please enter at least one numeric char, one alphabet, one special character and must be of minimum 8 and maximum 10 length');" oninvalid="InvalidMsg(this,'input','
    Please enter at least one numeric char, one alphabet, one special character and must be of minimum 8 and maximum 10 length');" required="" title=" " data-tooltip-id="2550140d-dc81-8f03-ea91-265ba2de4e25">
    <div class="input-field-addon" data-tooltip-id="a3d83b23-27e0-7bf2-7bf6-9139e527e6d3"> <i class="fa fa-eye-slash teal-text toggle-password" aria-hidden="true" data-tooltip-id="990aaeca-bbd3-b63d-0a63-56f61a4a5f7e"></i> </div>
    </div>

    </div>
    </div>

    <div class="col-md-12">
    <div class="col s1">
    <label for="confirm_password" style="color: #000; font-size: 12px;">
    <i class="fa fa-check-square-o" aria-hidden="true" style="font-size: 28px; margin-top: 12px; color: #ff4081;"></i> Confirm Password
    </label>
    </div>
    <div class="input-field col s11">
    <input type="password" autocomplete="off" class="password3" id="confirm_password" pattern="^(?=.*[A-Za-z0-9])(?=.*\d)(?=.*[@$!%*#?&amp;])[A-Za-z\d@$!%*#?&amp;]{8,10}$" maxlength="10" min="8" oninput="InvalidMsg(this,'input','
    Please enter at least one numeric char, one alphabet, one special character and must be of minimum 8 and maximum 10 length');" oninvalid="InvalidMsg(this,'input','
    Please enter at least one numeric char, one alphabet, one special character and must be of minimum 8 and maximum 10 length');" title=" " required="" data-tooltip-id="ba054083-2eed-3a29-0004-059b7b2568b7">
    <div class="input-field-addon" data-tooltip-id="ba85fa24-5432-f510-eefe-e189a57efb83"> <i class="fa fa-eye-slash teal-text toggle-password3" aria-hidden="true" data-tooltip-id="764ec166-30e3-3aac-a2c9-7f74500c68b5"></i> </div>
    </div>
    </div>
    </div>
    </div>
    <div class="modal-footer mb-3">
    <div class="input-field">
    <%-- <button class="btn" type="submit" id="changePassBtn">
    <spring:message code="button.submit" />
    </button> --%>
    <button class="btn btn btn-primary save-product" id="changePassBtn" type="submit" style="margin-left: 10px;">
    <spring:message code="button.submit" />
    </button>
    <button type="button" class="btn btn-outline-danger cancel-product btn modal-close" style="margin-left: 10px;">
    <spring:message code="modal.cancel" />
    </button>
    </div>
    </div>
    </form>
    </div>
    </div>
    </div>
    <!-- <div id="changePassword" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
    <h5 class="modal-header"><spring:message code="registration.changepassword" /></h5>
    <div class="modal-body">
    <form id="changePassForm" onsubmit="return changePassword();">
    <div class="form-row">


    <div class="form-group col-md-6">
    <span style="text-align: center; font-size: 12px; color: red;" id="errorMsg"></span>
    <i class="fa fa-lock" aria-hidden="true"
    style="font-size: 30px; margin-top: 12px; color: #ff4081;"></i>
    <label for="oldPassword" class="center-align"	style="color: #000; font-size: 12px;"> <spring:message code="registration.oldpassword" /> </label>
    <input type="password" id="oldPassword" class="password form-control" autocomplete="off"
    pattern="<spring:eval expression="@environment.getProperty('pattern.password')" />"
    maxlength="10" min="8"
    oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
    required />

    <div class="input-field-addon">
    <i class="fa fa-eye-slash teal-text field-icon toggle-password" aria-hidden="true"></i>
    </div>
    </div>


    <div class="form-group col-md-6">
    <span style="text-align: center; font-size: 12px; color: red;" id="errorMsg"></span>
    <i class="fa fa-lock" aria-hidden="true"
    style="font-size: 30px; margin-top: 12px; color: #ff4081;"></i>
    <label for="newPassword"><spring:message
    code="registration.newpassword" /></label>
    <input type="password" class="form-control" autocomplete="off" pattern="<spring:eval expression="@environment.getProperty('pattern.password')" />"
    maxlength="10" min="8" oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
    required id="password" class="password2" />
    <div class="input-field-addon">
    <i class="fa fa-eye-slash teal-text field-icon toggle-password2" aria-hidden="true"></i>
    </div>
    </div>

    <div class="form-group col-md-6">
    <i class="fa fa-check-square-o" aria-hidden="true"
    style="font-size: 28px; color: #ff4081;"></i>
    <label for="confirm_password"
    style="color: #000; font-size: 12px;"><spring:message
    code="registration.confirmpassword" />
    </label>
    <input type="password" autocomplete="off" class="password3 form-control" id="confirm_password"
    pattern="<spring:eval expression="@environment.getProperty('pattern.password')" />" maxlength="10" min="8" oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
    title="<spring:message code="validation.minumum8length" />"required>
    <div class="input-field-addon">
    <i class="fa fa-eye-slash teal-text field-icon toggle-password3" aria-hidden="true"></i>
    </div>
    </div>
    </div>

    <div class="modal-footer">
    <%-- <button class="btn" type="submit" id="changePassBtn">
    <spring:message code="button.submit" />
    </button> --%>
    <button class="save-product btn" id="changePassBtn" type="submit" style="margin-left: 10px;"><spring:message code="button.submit" /></button>
    <button type="button" class="cancel-product btn modal-close" style="margin-left: 10px;"><spring:message code="modal.cancel" /></button>
    </div>

    </div>

    </form>
    </div>
    </div> -->
    </div>
    </div>
    <!-- Modal End -->


    <!-- Modal 2 start   -->


    <!-- Modal 2 start -->

    <div id="submitActivateDeactivate" class="modal">
    <button type="button"
    class=" modal-action modal-close waves-effect waves-green btn-flat right"
    data-dismiss="modal">&times;</button>
    <div class="modal-content">

    <div class="row">
    <h6>
    <spring:message code="registration.therequesthasbee" />
    </h6>
    </div>
    <div class="row">
    <div class="input-field col s12 center">
    <div class="input-field col s12 center">
    <button class="modal-close waves-effect waves-light btn"
    style="margin-left: 10px;" type="submit" name="add_user"
    id="add_user">
    <spring:message code="modal.cancel" />
    </button>
    </div>
    </div>
    </div>
    </div>
    </div>
    <!-- Modal End -->

    <!-- Modal 2 start -->

    <div id="cancelActivateDeactivate" class="modal">
    <button type="button"
    class=" modal-action modal-close waves-effect waves-green btn-flat right"
    data-dismiss="modal">&times;</button>
    <div class="modal-content">

    <div class="row">
    <h6>
    <spring:message code="registration.cancelRequest" />
    </h6>
    </div>
    <div class="row">
    <div class="input-field col s12 center">
    <div class="input-field col s12 center">
    <a href="index.html" class="btn" type="submit" name="add_user"
    id="add_user"><spring:message code="modal.yes" /></a> <a
    href="#activateDeactivate" class="modal-close modal-trigger btn"
    style="margin-left: 10px;"><spring:message code="modal.no" /></a>
    </div>
    </div>
    </div>
    </div>
    </div>
    <!-- Modal End -->

    <!-- modal start -->
    <div class="modal fade" id="changePasswordMessage" role="dialog">
    <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
    <h6 class="modal-header">
    <spring:message code="registration.changepassword" />
    </h6>
    <div class="modal-body">
    <div class="form-row">
    <!-- <h6 id="cPassSucessMsg"></h6> -->
    <h7>User password  has been sucessfully changed.</h7>
    </div>
    </div>
    <div class="modal-footer mb-3">
    <div class="input-field">
    <%-- <button class="btn" type="submit" id="changePassBtn">
    <spring:message code="button.submit" />
    </button> --%>
    <button type="button" class="btn btn-outline-danger cancel-product btn modal-close" style="margin-left: 10px;">
    <spring:message code="modal.ok" /> </button>
    <!-- <button class="btn modal-close" type="button" class="btn btn-outline-danger cancel-product btn modal-close" data-dismiss="modal">Close</button>  -->
    </div>
    </div>
    </div>
    </div>
    </div>
    <!-- <div id="changePasswordMessage" class="modal" style="width:100%;">
    <h5 class="modal-header">
    <spring:message code="registration.changepassword" />
    </h5>
    <div class="modal-content">
    <div class="row">
    <h6 id="cPassSucessMsg"></h6>
    </div>
    <div class="row">
    <div class="center">

    <%
    String userLatestLang = (String) session.getAttribute("updatedLanguage");
    %>
    <%
    if (userLatestLang != null) {
    %>
    <a href="./?lang=<%=userLatestLang%>" class="btn modal-close"><spring:message
    code="modal.ok" /></a>
    <%
    } else {
    %>
    <a href="./?lang=<%=session.getAttribute("language")%>"
    class="btn modal-close"><spring:message code="modal.ok" /></a>
    <%
    }
    %>
    </div>
    </div>
    </div> -->
    </div>
    <!-- Modal start -->

    <div id="goToHome" class="modal modal-small" style="width: 100%;">
    <!-- <button type="button" class=" modal-action modal-close waves-effect waves-green btn-flat right"
    data-dismiss="modal">&times;</button> -->
    <h5 class="modal-header">
    <spring:message code="registration.homepage" />
    </h5>
    <div class="modal-content">
    <div class="row">
    <h6>
    <spring:message code="registration.pagewillredirectpanel" />
    </h6>
    </div>
    <div class="input-field col s12 center">
    <div class="input-field col s12 center">
    <a href="${context}/homePage" class="btn" type="submit"
    name="add_user" id="home_Links"><spring:message
    code="modal.yes" /></a> <a href="#" class="modal-close btn"
    style="margin-left: 10px;"><spring:message code="modal.no" /></a>
    </div>
    </div>
    </div>
    </div>


    <div id="goToLogout" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
    <form action="./login?isExpired=yes" method="post" id="logoutForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div class="modal-header">
    <h5 class="modal-title"><spring:message code="logout.page" /></h5>
    </div>
    <div class="modal-body">
    <p><spring:message code="logout.msg" /></p>
    </div>
    <div class="modal-footer">
    <button type="button" class="save-product btn" id="logOutsubmit" onclick="sessionLogOut(<%=session.getLastAccessedTime()+timeout %>, <%=new Date().getTime()  %>); disbaleSubmitLogiut('logOutsubmit')"><spring:message code="modal.yes" /></button>
    <a href="#" class="cancel-product btn modal-close" style="margin-left: 10px;"><spring:message code="modal.no" /></a>
    </div>
    </form>
    </div>
    </div>
    </div>

    <!-- Modal End -->

    <!-- Modal End -->
    <!-- Modal End -->

    <!-- File Related Modal  -->
    <div id="fileFormateModal" class="modal">
    <h5 class="modal-header">
    <spring:message code="fileValidationModalHeader" />
    </h5>
    <div class="modal-content">
    <div class="row">
    <h6 id="fileErrormessage">
    <spring:message code="fileValidationName" />
    <br> <br>
    <spring:message code="fileValidationFormate" />
    <br>
    <br>
    <spring:message code="fileValidationSize" />
    </h6>
    </div>
    <div class="row">
    <div class="input-field col s12 center">
    <div class="input-field col s12 center">
    <button class="modal-close waves-effect waves-light btn"
    onclick="document.getElementById('mainArea').contentWindow.clearFileName();"
    style="margin-left: 10px;">
    <spring:message code="modal.ok" />
    </button>
    </div>

    </div>
    </div>
    </div>
    </div>
    <!-- Modal End -->
    <!-- ================================================
    Scripts
    ================================================ -->
    <!-- 	Error Modal -->
    <div class="modal" id="error_Modal" role="dialog">
    <div class="modal-dialog">
    <div class="row" id="modalMessageBody" style="text-align: center;"></div>

    </div>
    </div>


    <!-- 	password Modal -->
    <div id="passwordModal"  class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
    <h5 class="modal-header"><spring:message code="registration.pleaseenteryourpassword" /></h6>
    <div class="modal-body" >
    <form  onsubmit="return updateUserStatusModal()">
    <div class="form-row">
    <div class="form-group col-md-12">
    <label for="confirmPassword"><spring:message code="registration.password" /></label>
    <input required="required"  type="password" class="password form-control" id="confirmPassword" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,10}$"  maxlength="10"
    oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');" >
    <div class="input-field-addon"><i class="fa fa-eye-slash teal-text field-icon toggle-password" aria-hidden="true"></i></div>
    </div>

    </div>
    </div>
    <div class="modal-footer">
    <button type="submit" id="passwordBtn" class="save-product btn"><spring:message code="button.submit" /></button>
    <button type="button" class="cancel-product btn modal-close"><spring:message code="button.cancel" /></button>
    </div>
    </form>
    </div>
    </div>
    </div>

    <!-- Modal End -->
    <div class="modal" id="error_Modal_reg" role="dialog">
    <div class="modal-dialog">
    <div class="row" id="modalMessageBodyReg"
    style="text-align: center;"></div>

    </div>

    </div>
    <!--
    <div id="500ErrorModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
    <div class="modal-header">
    <h5 class="modal-title"><spring:message code="modal.errorContent" /></h5>
    </div>
    <div class="modal-body">
    <div class="row" id="msgDialog" style="text-align: center;color:red;">



    </div>
    <div class="modal-footer">

    <button class="cancel-product btn modal-close" type="button" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
    </div>
    </div> </div> </div>
    -->

    <!-- 	password Modal -->
    <!-- jQuery Library -->

    <!--materialize js-->
    <script type="text/javascript"
    src="${context}/resources/plugins/materialize.js"></script>

    <script type="text/javascript"
    src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>

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



    <!-- Custom js -->




    <script type="text/javascript"
    src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script type="text/javascript"
    src="${context}/resources/project_js/signup/Password.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script type="text/javascript"
    src="${context}/resources/project_js/signup/Login.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <%-- 	<script type="text/javascript"
    src="${context}/resources/project_js/disable_inspectElement.js"></script> --%>
    </script>
    <script type="text/javascript"
    src="${context}/resources/project_js/signup/Profile.js?version=<%= (int) (Math.random() * 10) %>"></script>

    <script type="text/javascript"
    src="${context}/resources/project_js/dashboard.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script type="text/javascript"
    src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script type="text/javascript">


    </script>
    <script type="text/javascript">
    /*  function sessionLogOut(){

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({
    headers : {
    'X-CSRF-TOKEN' : token
    }
    });
    $.ajax({
    type : 'POST',
    url : './login?isExpired=yes',
    processData : false,
    contentType : false,
    success : function(data) {
    alert("SUCCESS=="+data);
    },

    error : function(xhr, ajaxOptions, thrownError) {
    alert("error");
    }
    });

    }  */
    function sessionLogOut(timeOut,currentTime){
    $('#logoutForm').submit();
    /*  if(currentTime > timeOut){
    				$('#logoutForm').submit();
    			}
    			else{
    				 window.location.href = "./login";
    			}  */
    }
    </script>
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
    else{timeoutTime = currentTime + timeout;}});});
    $(".sidebar-box .navbar-nav").on('click', 'li', function () {
    $(".navbar-nav li.active").removeClass("active").css('background', 'var(--main-light)');
    // adding classname 'active' to current click li
    $(this).addClass("active").css('background', '#b8cbe5');
    });

    </script>

    </body></html>
    <%
    } else {
    request.setAttribute("msg", "  *Session has been expired");
    request.getRequestDispatcher("./login.jsp").forward(request, response);
    }
    %>