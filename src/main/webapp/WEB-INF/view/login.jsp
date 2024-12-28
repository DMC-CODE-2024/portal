
        <%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
        <%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        <!-- Security Tags -->
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
        <sec:csrfMetaTags />
        <!-- Security Tags -->
        <%@page import="java.util.Locale"%>

        <c:set var="context" value="${pageContext.request.contextPath}" />

        <!DOCTYPE html>
        <html lang="en">

        <head><title>EIRS Portal</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="msapplication-tap-highlight" content="no">
        <meta name="description">
        <meta name="keywords"
        content="materialize, admin template, dashboard template, flat admin template, responsive admin template,">
        <!-- Security Tags -->
        <meta name="_csrf" content="${_csrf.token}"/>
        <!-- default header name is X-CSRF-TOKEN -->
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <!-- Security Tags -->
        <!--<title>CEIR Portal</title>-->


        <!-- Favicons-->
        <link rel="icon" href="${context}/resources/assets/images/logo-light.png" sizes="32x32">

        <!-- For Windows Phone -->
        <link rel="stylesheet" href="${context}/resources/font/font-awesome/css/font-awesome.min.css">

        <!-- CORE CSS-->
        <link href="${context}/resources/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
        <link href="${context}/resources/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
        <link rel="stylesheet" href="${context}/resources/assets/css/loaderMsg.css"  type="text/css" media="screen,projection">

        <!-- Login CSS-->
        <link href="${context}/resources/assets/css/login.css" type="text/css" rel="stylesheet">
        <link href="${context}/resources/assets/css/top.css" type="text/css" rel="stylesheet">
        <link href="${context}/resources/assets/css/bootstrap.min.css" type="text/css" rel="stylesheet">
        <!-- Login CSS close-->

        <script>
        var contextpath = "${context}";
        </script>
        </head>

        <body data-msg="${msg}" data-lang-param="${pageContext.response.locale}" data-userID="${userid}">
        <c:remove var="userid" scope="session"/>


        <!-- //////////////////////////////////////////////////////////////////////////// -->
          <!-- <div id="initialtextloader" style="display:none"> <strong>Verifying your credentials, please hold on...</strong></div>-->

        <div class="dashboard-header navbar navbar-expand navbar-dark align-items-center">
        <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown">
        <div style="width: 130px !important;display: none">
        <%-- <select name='options[212]' class="form-controlR" id="langlist">
        <option value="en"
        data-src="${context}/resources/assets/images/us.png">English</option>
        <option value="km"
        data-src="${context}/resources/assets/images/cambodia.png"><spring:message
        code="lang.khmer" /></option>
        </select> --%>
        <select name='options[212]' class="form-controlR" id="langlist">
        <option
        <c:if test="${param.lang=='en'}">selected="selected"</c:if>
        value="en" data-src="${context}/resources/assets/images/us.png">English</option>
        <option
        <c:if test="${param.lang=='km'}">selected="selected"</c:if>
        value="km"
        data-src="${context}/resources/assets/images/cambodia.png"><spring:message
        code="lang.khmer" /></option>
        </select>
        </div>
        </li>
        </ul>
        </div><!-- end navbar -->

        <!-- //////////////////////////////////////////////////////////////////////////// -->


        <div class="form-body">
        <div class="row">
        <div class="img-holder">
        <div class="bg"></div>
        <div class="info-holder">
        <img src="${context}/resources/assets/images/logo.png" alt="">
        </div>
        </div>
        <div class="form-holder">
        <div class="form-content">
        <div class="form-items">
        <div class="card-bg">
        <div class="card-body">
        <form id="loginForm" onsubmit="return login()" class="p-2">
        <div class="col s12 m12 l12">
        <div class="row">
        <!--<div class="col s9 m10 select-lang-lable">
        <i class="fa fa-globe fa-6" aria-hidden="true"></i>
        </div>
        <div class="col s3 m2 right" style="padding: 0;">
        <select class="browser-default select-lang-drpdwn"
        id="langlist">
        <option value="en">English</option>
        <option value="km"><spring:message code="lang.khmer" /></option>
        </select>
        </div>-->
        <div class="col s12 m12">
        <h5 style="text-align: -webkit-center;"><spring:message code="registration.login" /></h5>
        <span id="errorMsg" style="color: red;"></span>
        </div>


        <div class="form-group">
        <label for="username"><spring:message code="registration.username" /></label>
        <input type="text" name="username" id="username" class="form-control" pattern="[A-Za-z0-9]{6,9}" min="6" maxlength="15" oninput="InvalidMsg(this,'input','<spring:message code="validation.username" />');" oninvalid="this.setCustomValidity('Please fill in this field.');" title=" " required="required">
        </div>

        <div  class="form-group" id="show_hide_password">
        <label for="password"> <spring:message code="registration.password" /></label>
        <input type="password" class="form-control password" autocomplete="off" name="password" id="password" pattern="^(?=.*[A-Za-z0-9])(?=.*\d)(?=.*[@$!%*#?&amp;])[A-Za-z\d@$!%*#?&amp;]{8,10}$" min="8" maxlength="250" oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');" "="" oninvalid="this.setCustomValidity('Please fill in this field.');" oncopy="return false" onpaste="return false" required="required" title=" ">
        <i class="fa fa-eye-slash teal-text toggle-password field-icon" aria-hidden="true"></i>
        </div>

        <%-- <div class="form-group">
        <span class="input-icon"> <img id="captchaImage" src="${context}/captcha">
        <button style="background: none; border: none; outline: none; color: black;" type="button" onclick="refreshCaptcha('captchaImage')">
        <i class="fa fa-refresh"></i></button> <img src="${context}/captcha"" id="captchaImage">
        <br>
        <input type="button" onclick="refreshCaptcha('captchaImage')">
        <div class="form-group">
        <label for="captcha" style="left: 0.01rem;"><spring:message code="registration.enteryourcaptcha" /><span class="star">*</span> </label>
        <input autocomplete="off" type="text" name="captcha" class="form-control boxBorder boxHeight" id="captcha"
        oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('<spring:message code="validation.requiredMsg" />')"
        title= "<spring:message code="validation.requiredMsg" />" required>
        </div>

        </span>
        </div> --%>

        <div class="form-group">
        <!--    	   	<div class="g-recaptcha"  data-sitekey="<spring:eval expression="@environment.getProperty('captcha.dataSitekey')" />"></div> -->
        <div class="g-recaptcha"  data-sitekey="<spring:eval expression="@environment.getProperty('captcha.dataSitekey')" />"></div>
        <span id="errorMsgOnModal"  class="text-danger" style="display: none" ><spring:message code="imei.invalidCaptcha" /></span>
         </div>

        <div class="row" style="margin:18px 0 10px 0;">
        <div class="form-group">
        <%--     <a href="${context}/importerDashboard" class="btn" type="button" id="save" style="width: 100%;">Login</a> --%>
        <button type="submit" class="btn btn-primary btn-block login-btn" id="save" value="Login"><spring:message code="registration.login" /></button>
        </div>
        </div>
        <hr>

        <div class="form-group" style="display: none">
        <a href="${context}/forgotPassword" class="right forgotPassword bluetext"><spring:message code="registration.forgotpassword" /></a>
        <a href="JavaScript:Void(0);" id="newUserLink" class="right bluetext"><spring:message code="registration.newUser" /></a>
        </div>
        </div>
        </form>
        </div>
        <!-- end card-body -->
        </div><!-- end card -->

        </div>
        </div>
        </div>
        </div>
        </div><!--form-body close-->

        <div id="changePasswordMessage" class="modal" style="width: 40%;">
        <h5 class="modal-header"><spring:message code="registration.changepassword" /></h5>
        <div class="modal-content">
        <div class="row">
        <h6 id="cPassSucessMsg"></h6>
        </div>
        <div class="row">
        <div class="center">
        <a href="" class="btn"><spring:message code="modal.ok" /></a>
        </div>
        </div>
        </div>
        </div>


        <div id="changePassword" class="modal" style="width: 40%;">
        <h5 class="modal-header"><spring:message code="registration.changepassword" /></h5>
        <div class="modal-content">
        <form onsubmit="return changeExpiryPassword()">
        <div class="row">

        <input type="hidden" id="userId" >
        <span style="text-align: center; color: red;" id="errorMsg"></span>
        <div class="col s1">
        <i class="fa fa-lock" aria-hidden="true"
        style="font-size: 30px; margin-top: 12px; color: #ff4081;"></i>
        </div>
        <div class="input-field col s11">
        <input type="password" id="oldPassword" class="password2" autocomplete="off"
        pattern="<spring:eval expression="@environment.getProperty('pattern.password')" />"

        <%--  oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');" --%>

        oninput="this.setCustomValidity('<spring:message code="validation.requiredMsg" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
        <%-- oninvalid="this.setCustomValidity('<spring:message code="validation.requiredMsg" />')" --%>

        title="Please enter atleast one numeric char, one alphabet, one special character and must be of minumum 8 length"
        required /> <label for="oldPassword"
        class="center-align" style="color: #000; font-size: 12px;">
        <spring:message code="registration.oldpassword" /></label>
        <div class="input-field-addon">
        <i  class="fa fa-eye-slash teal-text toggle-password2" aria-hidden="true"></i>
        </div>
        </div>

        <div class="col s1">
        <span class="fa-passwd-reset fa-stack"
        style="margin-top: 12px; color: #ff4081;"> <i
        class="fa fa-undo fa-stack-2x"></i> <i
        class="fa fa-lock fa-stack-1x"></i>
        </span>
        </div>
        <div class="input-field col s11">

        <label for="newPassword" style="color: #000; font-size: 12px;"><spring:message code="registration.newpassword" /></label> <input type="password"
        pattern="<spring:eval expression="@environment.getProperty('pattern.password')" />" autocomplete="off"

        oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');"

        <%-- oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
        oninvalid="this.setCustomValidity('<spring:message code="validation.requiredMsg" />')" --%>
        required id="password2" class="password3" />
        <div class="input-field-addon">
        <i  class="fa fa-eye-slash teal-text toggle-password3" aria-hidden="true"></i>
        </div>
        </div>

        <div class="col s1">
        <i class="fa fa-check-square-o" aria-hidden="true"
        style="font-size: 28px; margin-top: 12px; color: #ff4081;"></i>
        </div>
        <div class="input-field col s11">

        <label for="confirm_password"
        style="color: #000; font-size: 12px;"><spring:message code="registration.confirmpassword" /></label> <input
        type="password" class="password4" id="confirm_password" autocomplete="off"
        pattern="<spring:eval expression="@environment.getProperty('pattern.password')" />"
        <%-- oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
        oninvalid="this.setCustomValidity('<spring:message code="validation.requiredMsg" />')" --%>

        oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
        required />
        <div class="input-field-addon">
        <i  class="fa fa-eye-slash teal-text toggle-password4" aria-hidden="true"></i>
        </div>
        </div>
        </div>
        <div class="row" style="margin-top: 30px;">
        <div class="input-field col s12 center">
        <button class="btn" id="updateStatusBtn" type="submit"><spring:message code="button.submit" /></button>
        <button type="button" class="btn modal-close"
        style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
        </div>

        </div>
        </form>
        </div>
        </div>


        <!-- //////////////////////////////////////////////////////////////////////////// -->

        <!-- ================================================
        Scripts
        ================================================ -->

       <!-- Login js-->
              <script src="${context}/resources/assets/js/jquery.min.js"></script>
              <script src="${context}/resources/assets/js/bootstrap.min.js"></script>
              <!-- Login js close-->


              <!-- jQuery Library -->
              <script src="${context}/resources/custom_js/jquery.min.js"></script>
              <script type="text/javascript" src="${context}/resources/plugins/materialize.js"></script>
              <script src="${context}/resources/custom_js/bootstrap.min.js"></script>


                      <script type="text/javascript" src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>


              <script src="https://www.google.com/recaptcha/api.js"></script>
              <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=en"
              async defer>

              <%-- <script type="text/javascript"
              src="${context}/resources/plugins/data-tables/data-tables-script.js"></script>

              --%>				<!-- i18n library -->
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
              src="${context}/resources/project_js/signup/Registration.js?version=<%= (int) (Math.random() * 10) %>"></script>

              <script type="text/javascript"
              src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

              <script type="text/javascript" src="${context}/resources/project_js/signup/clearSession.js?version=<%= (int) (Math.random() * 10) %>"></script>
              <script type="text/javascript" src="${context}/resources/project_js/signup/Login.js?version=<%= (int) (Math.random() * 10) %>"></script>
              <script type="text/javascript" src="${context}/resources/project_js/signup/Password.js?version=<%= (int) (Math.random() * 10) %>"></script>
              <script type="text/javascript" src="${context}/resources/project_js/login.js?version=<%= (int) (Math.random() * 10) %>"></script>

              <script type="text/javascript"
              src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>
      <script type="text/javascript">
        if(window.location.href.includes('isExpired=yes') && location.href.indexOf('reload')  ==-1)
        {
        location.href=location.href+'&reload';
        }
        </script>
              </body>
              </html>

