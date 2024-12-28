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

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:ital,opsz,wght@0,6..12,200..1000;1,6..12,200..1000&display=swap" rel="stylesheet">
<c:if test="${pageContext.response.locale=='en'}">

        <link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/assets/css/en.css">

</c:if>

<c:if test="${pageContext.response.locale=='km'}">

        <link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/assets/css/km.css">

</c:if>
        <style>

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
        data-timeout="<spring:eval expression="@environment.getProperty('otp-timeout')" />"
        style="background-color:#fff;">
        <input type="text" id="langList" value="${lang}" style="display:none">
        <!-- START CONTENT -->
        <div class="popup-header">
        <h1><spring:message code="tag.pair-device.checkpairstatus" /></h1>
        </div>
        <div class="content-container">

        <div class="width-90 mt-35" id="checkPairStatusFormDiv">

        <div class="form-content">
        <form id="checkPairStatusForm" onsubmit="return formSubmit(event)">
        <div id="imeiContainer">

        <label for="emailAddress"><spring:message code="tag.pair-device.imeiOrPhoneNumber" /> <span class="star">*</span></label>
        <div class="form-row imei-row">
        <div class="form-group col-md-6">
        <label for="imei"><spring:message code="tag.pair-device.imei" /></label>
        <input type="text" autocomplete="off" class="form-control" id="imei" name="imei" placeholder="<spring:message code="placeholder.pair-device.15digitimei" />"
        pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />" minlength="15" maxlength="15" oninput="InvalidMsg(this,'input','<spring:message code="validation.imei.16digit" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.imei.16digit" />');">
        </div>
        <div class="form-group col-md-6">
        <label for="imei"><spring:message code="tag.pair-device.phoneNumber" /></label>

        <input type="text" autocomplete="off" class="form-control phoneNumber" id="phoneNumber1" name="phoneNumber1" placeholder="<spring:message code="placeholder.pair-device.phonenumber" />"
        minlength="9" maxlength="12" pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo-0855')" />"  oninput="InvalidMsg(this,'input','<spring:message code="validation.msisdn.10digit.0855" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.msisdn.10digit.0855" />');">
        </div>
        </div>
        </div>
        <label><spring:message code="tag.pair-device.otp" /> <span class="star">*</span></label>
        <div class="form-row align-items-center">
        <div class="form-group col-md-6">
        <label for="contactNumber"><spring:message code="tag.pair-device.contactNumber" /></label>

        <input type="text" autocomplete="off" class="form-control" id="contactNumber"  name="contactNumber" placeholder="<spring:message code="placeholder.pair-device.855contactnumber" />"
        minlength="9" maxlength="12"  pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo-0855')" />"  oninput="InvalidMsg(this,'input','<spring:message code="validation.msisdn.10digit.0855" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.msisdn.10digit.0855" />');" >
        </div>

        <div class="form-group col-md-6">
        <label for="emailAddress"><spring:message code="tag.pair-device.emailAddress" /></label>
        <input type="email" autocomplete="off" class="form-control" id="emailAddress" name="emailAddress"  placeholder="<spring:message code="placeholder.pair-device.emailaddress" />"
        pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
        oninput="InvalidMsg(this,'input','<spring:message code="tag.pair-device.validation.email" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="tag.pair-device.validation.email" />');">
        </div>
        </div>

        <div class="form-row">
        <div class="form-group col-md-12">
        <label><spring:message code="tag.pair-device.mandatoryField" /> <span class="star">*</span></label>
        </div>
     <span id="errorMsgDiv" class="error"></span>
        </div>

        <div class="form-group">
        <div class="g-recaptcha" data-callback="recaptchaCallback" data-sitekey="<spring:eval expression="@environment.getProperty('captcha.dataSitekey')" />"></div>
        <span id="errorMsgOnModal"  class="text-danger" style="display: none" ><spring:message code="bulk.invalidCaptcha" /></span>
        </div>


        <div class="row">
        <div class="col-lg-12 mt-20">
        <div class="no-border center">

        <button  id="cpsSubmitBtn" type="submit" class="orange-button btn" style="margin-left: 10px;"><spring:message code="tag.pair-device.submit" /></button>
        </div>
        </div>
        </div>
        </form>
        </div>
        </div>
        </div>
        </div>



        <div class="width-90 mt-20 center width-100" id="OTPForm" style="display:none">

        <h5 class="mb-10"><spring:message code="tag.pair-device.validateOTP" /></h5>
        <p><spring:message code="tag.pair-device.verifysent" /></p>
         <!--
        <span id="countryCode"></span> <span id="phoneNumberOTP"></span> / </p>
        <p><spring:message code="tag.pair-device.emailAddress" /> <span id="emailMasking"></span></p> -->
        <form id="otpFormRequest">
        <div class="width-87 width-100">

        <div class="form-row">
        <div class="form-group col-md-12 mt-20">
        <div class="form-group text-center" id="inputs">
        <input class="otp" type="tel"  id="field1" name="field1" oninput='digitValidate(this)'  oninvalid="InvalidMsg(this,'input',null);"
        maxlength=1 required>
        <input class="otp" type="tel"  id="field2" name="field2"  oninvalid="InvalidMsg(this,'input',null);"
        oninput='digitValidate(this)' maxlength=1 required>
        <input class="otp" type="tel"  id="field3" name="field3"  oninvalid="InvalidMsg(this,'input',null);"
        oninput='digitValidate(this)'  maxlength=1 required>
        <input class="otp" type="tel"  id="field4" name="field4"  oninvalid="InvalidMsg(this,'input',null);"
        oninput='digitValidate(this)'  maxlength=1 required>
        <input class="otp" type="tel"  id="field5" name="field5"  oninvalid="InvalidMsg(this,'input',null);"
        oninput='digitValidate(this)'  maxlength=1 required>
        <input class="otp" type="tel"  id="field6" name="field6"  oninvalid="InvalidMsg(this,'input',null);"
        oninput='digitValidate(this)'  maxlength=1 required>
        </div>
        </div>
        </div>
        <div class="row">
        <div class="col-md-9 text-left timer pd-23">
        <p id="resendOTPclick"  onclick="resendOTP()" class="resent"><spring:message code="OTP.resend" /></p>
        <p id="resendOTPclick_time"><spring:message code="OTP.timeDuration" /> <span id="countdown"></span></p>

        </div>

        </div>
        </div>

        <div class="row">
        <div class="col-lg-12 mt-20">
        <div class="no-border center">
        <button type="button" class="btn grey-button" onclick="back()"><spring:message code="tag.pair-device.back" /></button>
        <button onclick="return submitOTPRequest(event,'checkpairstatus')" class="btn orange-button"><spring:message code="tag.pair-device.verify" /></button>
        </div>
        </div>
        </div>
        <span id="errorDiv" class="error"></span>
        </form>
        </div>



        <div class="content-box50 mt-100 center cps-datatable" id="cps-datatable" style="display:none">
        <div class="table-box TableBorder">
        <table class="table align-left display" id="dataTable">
        <thead class="thead-dark">
        <tr>
        <th>S.No</th>
        <th>IMEI</th>
        <th>MSISDN</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
        </table>
        </div>

            <div class="col-lg-12 mt-20">
            <div class="col-lg-12 mt-20">
            <div class="no-border center">
            <a href="${context}/check-pair-status" type="button" class="btn orange-button width50-btn"><spring:message code="tag.button.check-other-status" /></a></div>
            </div>
            </div>
        </div>

<div class="width-90 mt-20 center width-100" id="otpLimitExceedModal" style="display:none">
    <p class="mb-10"><img src="${context}/resources/assets/images/close.svg" alt="logo" class="img-fluid"></p>
    <p><spring:message code="tag.pair-device.otplimitexceed" /></p>
    <div class="row">

    <div class="col-lg-12 mt-20">
    <div class="no-border center">
    <a href="${context}/check-pair-status" type="button" class="btn orange-button width50-btn"><spring:message code="tag.button.cancel" /></a>
    </div>
    </div>
    </div> </div>


    <div class="width-90 mt-20 center width-100" id="rejectedMsgModal" style="display:none">
    <p class="mb-10"><img src="${context}/resources/assets/images/close.svg" alt="logo" class="img-fluid"></p>
    <h1><spring:message code="tag.pair-device.checkpairstatus" /> </h1>
    <p id="rejectModalMsg"></p>
    <div class="row">
    <div class="col-lg-12 mt-20">
    <div class="col-lg-12 mt-20">
    <div class="no-border center">
    <a href="${context}/check-pair-status" type="button" class="btn orange-button width50-btn"><spring:message code="tag.button.check-other-status" /></a></div>
    </div>
    </div>
    </div> </div>





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
        src="${context}/resources/project_js/otp.js?version=<%= (int) (Math.random() * 10) %>"></script>
        <script type="text/javascript"
        src="${context}/resources/project_js/check-pair-status.js?version=<%= (int) (Math.random() * 10) %>"></script>
        <script type="text/javascript"
        src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
        <script type="text/javascript"
        src="${context}/resources/project_js/verify-msisdn-length.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=en"
    async defer>
        <script type="text/javascript"
        src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
        <script type="text/javascript"
        src="" async></script>


        </body></html>


