<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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

<html>

<head><title>EIRS Portal</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="msapplication-tap-highlight" content="no">
    <meta name="description"
        content="Materialize is a Material Design Admin Template,It's modern, responsive and based on Material Design by Google. ">
    <meta name="keywords"
        content="materialize, admin template, dashboard template, flat admin template, responsive admin template,">
       <!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- Security Tags --> 
    <!--<title>Forgot Password</title>-->

    <link href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css" type="text/css" rel="stylesheet"
        media="screen,projection">
    <!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<!-- For Windows Phone -->
    <link rel="stylesheet" href="${context}/resources/font/font-awesome/css/font-awesome.min.css" >

    <!-- CORE CSS-->
    <link href="${context}/resources/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="${context}/resources/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- Custome CSS-->
    <link href="" type="text/css" rel="stylesheet" media="screen,projection">

    <!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
    <link href="${context}/resources/plugins/prism/prism.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css" type="text/css" rel="stylesheet"
        media="screen,projection">

    <style>
        .boton {
            color: #2979a5;
            float: right;
            border: solid 1px rgba(33, 167, 201, 0.774);
            padding: 4px 10px;
            border-radius: 7px;
            font-size: 14px;
            background-color: #fff;
        }


        input[type=text] {
            /* height: 35px; */
            margin: 0 0 5px 0;
        }
        .fa-eye-slash, .fa-eye {
	position: absolute;
	right: 10px;
	top: 10px;
}

.select-lang-lable {
    margin-top: 9px;
    text-align: right;
    }
    
    .select-lang-drpdwn {
    width: 75px;
    margin-top: 0;
    border-bottom: none;
}
    </style>
<script type="text/javascript">
var contextpath='${context}';
</script>
</head>

<body data-lang-param="${pageContext.response.locale}">


    <!-- //////////////////////////////////////////////////////////////////////////// -->

    <!-- START MAIN -->
    <div id="">
        <!-- START WRAPPER -->
        <div class="wrapper">

         

            <!-- //////////////////////////////////////////////////////////////////////////// -->

            <!-- START CONTENT -->
             <section id="content">
                <!--start container-->
                <div class="container">
                    <div class="section">
                        <div class="row card-panel login-card-panel" style="width:67%;    position: absolute; margin: 10vh 39vh;">
                           
                           		<h5 class="fixPage-modal-header ">
							<spring:message code="registration.forgotpassword" />
															<div class="col s10 m11 select-lang-lable-fp width87">

			<i class="fa fa-globe fa-6" aria-hidden="true"></i>
		</div>
		<div class="col s2 m1 right width13" style="padding: 0;">
			<select class="browser-default select-lang-drpdwn-fp" id="langlist">
				<option value="en" class="fontBlack">English</option>
				<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
			</select>
		</div>
									</h5>
					
										<div class="col s12 m12">
											
											<span id="errorMsg" style="color: red;"></span>
										
										</div>
                            <div class="col s12 m12 l12">
                                <form  id="forgotPassword" onsubmit="return forgotPassword()" >
                                <div class="row">
                       			<span style="color: red;" id="errorMsg"></span>
               
                                           
                                 <!--     <hr style="margin-bottom: 30px;"> -->

                                    <div class="row myRow">
                                        <div class="input-field col s12 m6">
                                            
                                            <label for="username" class="right"><spring:message code="registration.pleaseenteryouruserid" /> <span class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m6 l6">
                                            <input type="text" name="username" 
     oninput="InvalidMsg(this,'input','<spring:message code="validation.50alphanumeric" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50alphanumeric" />');"
              title= "<spring:message code="validation.requiredMsg" />" required id="username" maxlength="10" />
                                        </div>
                                    </div>

                                    <div class="row myRow">
                                        <div class="input-field col s12 m6">
                                            
                                            <label for="questionId"><spring:message code="registration.pleasesecurity" /> <span class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m6 l6">
                                            <select class="browser-default" id="questionId" 
   													title="<spring:message code="validation.selectFieldMsg" />" oninput="setCustomValidity('')"  
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"  required  >
                                                <option value="" disabled selected><spring:message code="registration.securityquestion" /></option>
                                             </select>
                                        </div>
                                    </div>

                                    <div class="row myRow" style="margin-top: 20px;">
                                        <div class="input-field col s12 m6">
                                            
                                            <label for="answer" class="center-align"> <spring:message code="registration.provideanswertothequestion" /><span class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m6 l6">
                                            <input type="text" name="answer" 
oninput="InvalidMsg(this,'input','<spring:message code="validation.50alphanumeric" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50alphanumeric" />');"
												 title= "<spring:message code="validation.requiredMsg" />" required id="answer" maxlength="50" />
                                        </div>
                                    </div>
                                                                   </div>
                         
                                <div class="row" style="margin-top: 30px;">
                                    <div class="input-field col s12 m12 l12 center">
                                        <button id="forgotPasswordBtn"   type="submit" class="btn"><spring:message code="button.submit" /></button>
                                        <a href="${context}/login" class="btn" style="margin-left: 10px;"><spring:message code="modal.cancel" /></a>
                                    </div>
                                </div>
                            </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!--end container-->
            </section>
            <!-- END CONTENT -->

        </div>
        <!-- END WRAPPER -->

    </div>
    <!-- END MAIN -->



    <!-- //////////////////////////////////////////////////////////////////////////// -->

    

<div id="changePassword" class="modal" style="width: 40%;">
		<h6 class="modal-header" ><spring:message code="registration.setnewpassword" /></h6>  
		<div class="modal-content">
		<form onsubmit="return udapteNewPassword()">
			<div class="row">  
 
				<h5 style="text-align: -webkit-center;"><spring:message code="registration.newpassword" /></h5>
  <span style="text-align: center;color: red;" id="errorMsg"></span>
				<div class="col s1">
					<i class="fa fa-lock" aria-hidden="true"
						style="font-size: 30px; margin-top: 12px; color: #ff4081;"></i>
				</div>
				<div class="col s1">
					<span class="fa-passwd-reset fa-stack"
						style="margin-top: 12px; color: #ff4081;"> <i
						class="fa fa-undo fa-stack-2x"></i> <i
						class="fa fa-lock fa-stack-1x"></i>
					</span>
				</div>
				<div class="input-field col s11">
                    <input type="hidden" id="usernamedata">
					<label for="password" style="color: #000; font-size: 12px;">
						<spring:message code="registration.newpassword" /></label> <input type="password"  id="password" class="password"
						pattern="<spring:eval expression="@environment.getProperty('pattern.password')" />"
						oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
						oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');" 
												 title= "<spring:message code="validation.minumum8" />" required/>
				<div class="input-field-addon">
				<i  class="fa fa-eye-slash teal-text toggle-password" aria-hidden="true"></i>
											</div>					
				</div>           

				<div class="col s1">
					<i class="fa fa-check-square-o" aria-hidden="true"
						style="font-size: 28px; margin-top: 12px; color: #ff4081;"></i>
				</div>   
				<div class="input-field col s11">
					<label for="confirm_password" style="color: #000; font-size: 12px;">
						<spring:message code="registration.confirmpassword" /></label> <input type="password" class="password2" id="confirm_password"
						pattern="<spring:eval expression="@environment.getProperty('pattern.password')" />"
						oninput="InvalidMsg(this,'input','<spring:message code="validation.password" />');"
						oninvalid="InvalidMsg(this,'input','<spring:message code="validation.password" />');" 
												 title= "<spring:message code="validation.minumum8" />" required/>								
				<div class="ienput-field-addon">
				<i  class="fa fa-eye-slash teal-text toggle-password2" aria-hidden="true"></i>
											</div>					
				</div>
			</div>  
			<div class="row" style="margin-top: 30px;">
				<div class="input-field col s12 m12 l12 center">
					<button   
						class="btn" type="submit" id="UpdatePassBtn"
						style="width: 100%;"><spring:message code="registration.save" /></button>
				</div>
			</div>
			</form>
		</div>
	</div>
	
	
	<div id="submitBtnAction" class="modal" style="width:40% !important">
        <button type="button" class="modal-action modal-close waves-effect waves-green btn-flat right"
            data-dismiss="modal"></button>
        <h6 class="modal-header"><spring:message code="registration.forgotpassword" /></h6>
        <div class="modal-content">
                <h6 id="responseMsg"></h6>
            <div class="row">
                <div class="input-field col s12 center">
                    <a href="${context}/login" class="btn"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>

   	<!-- modal start -->

	<div id="otpVerification" class="modal" style="width: 40%;">
		<!-- <button type="button" class=" modal-action modal-close waves-effect waves-green btn-flat right"
            data-dismiss="modal">&times;</button> -->
		<h6 class="modal-header"><spring:message code="registration.otp" /></h6>
		<div class="modal-content">
			<form id="verifyOtpForm" onsubmit="return verifyOtp2()" >
				<p class="center" id="verifyOtpResp"></p>
				<input type="hidden" id="userid" name="userid" value="${userId}">
				<div class="row">
					<div class="input-field col s12 m12">
						<input type="text" placeholder="<spring:message code="placeholder.emailotp" />" name="emailOtp" maxlength="6" id="emailOtp"
							pattern="[0-9]{0,6}" oninput="InvalidMsg(this,'input','<spring:message code="validation.6Character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6Character" />');" 
							 required  />
					</div>
					<div class="input-field col s12 m12">
						<input placeholder="<spring:message code="placeholder.optphone" />" type="text" name="phoneOtp" maxlength="6" pattern="[0-9]{0,6}"
							id="phoneOtp" oninput="InvalidMsg(this,'input','<spring:message code="validation.6Character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6Character" />');" 
							required  />
					</div>
				</div>
				<a href="javascript:void(0)"
					onclick="resendOtp(); document.getElementById('resendOtp').style.display ='block';"
					class="right"><spring:message code="registration.resendotp" /></a>
				<button type="submit"  id="otpVerifyBtn" class="btn"
					style="width: 100%; margin-top: 20px; margin-bottom: 20px;">
					<spring:message code="registration.done" />
				</button>
			</form>
		</div>
	</div>
	
	
	<div id="otpMsgModal" class="modal"
		style="width: 40%; margin-left: 30%; margin-top: 10vh;">
		<!-- <button type="button"
			class=" modal-action modal-close waves-effect waves-green btn-flat right"
			data-dismiss="modal">&times;</button> -->
		<h6 class="modal-header">
			<spring:message code="registration.verifyotp" />
		</h6>
		<div class="modal-content">
			<!-- <h4 class="header2 pb-2">User Info</h4> -->

			<p style="padding: 10px;" class="center" id="otpMsg"></p>

			<a href="javascript:void(0)" onclick="openOtpPopup()" class="btn"
				style="width: 100%; margin-top: 20px; margin-bottom: 20px;"><spring:message
					code="registration.verifyotp" /></a>
		</div>
	</div>
     <!--  Modal End -->
    
    <div id="otpMessage2" class="modal">
<!-- 		<button type="button"
			class="modal-action modal-close waves-effect waves-green btn-flat right"
			data-dismiss="modal">&times;</button> -->
		<h6 class="modal-header">
			<spring:message code="registration.verifyotp" />
		</h6>
		<div class="modal-content">
			<h6 id="otpResponse"></h6>
			<div class="row">
				<div class="input-field col s12 center">
					<a href="${context}/login" class="btn"><spring:message
							code="modal.ok" /></a>
				</div>
			</div>
		</div>
	</div>


	<!-- ================================================
    Scripts
    ================================================ -->
	<!-- jQuery Library -->

	<script
		src="${context}/resources/custom_js/2.2.1_jquery.min.js"></script>
	<!--materialize js-->
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>

	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/signup/Registration.js?version=<%= (int) (Math.random() * 10) %>"></script>
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
	<script type="text/javascript" src="${context}/resources/project_js/signup/Password.js?version=<%= (int) (Math.random() * 10) %>"></script>


	<!--plugins.js - Some Specific JS codes for Plugin Settings-->

	<script type="text/javascript" src="${context}/resources/project_js/signup/Login.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript" src="${context}/resources/project_js/forgotPassword.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>

</body></html>