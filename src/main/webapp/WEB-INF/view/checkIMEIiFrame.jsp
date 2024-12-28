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
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="msapplication-tap-highlight" content="no">

<link rel="icon" type="image/x-icon"
	href="${context}/resources/assets/images/logo.png">

<link media="print" onload="this.media='all'" rel="stylesheet" href="${contex}/resources/assets/css/select2.min.css">
<link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/assets/css/select2.css">
<link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/assets/css/interalLangSelect.min.css">
<link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/assets/css/interalLangSelect.css">
<link rel="stylesheet" href="${context}/resources/assets/css/bootstrap.mincheckIMEI.css" id="bootstrap-stylesheet"/>
<link media="print" onload="this.media='all'" href="${context}/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css"/>
<link media="print" onload="this.media='all'" href="${context}/resources/assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-stylesheet"/>
<link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/font/font-awesome/css/font-awesome.min.css">
<link media="print" onload="this.media='all'" rel="stylesheet" href="${context}/resources/assets/css/style.css">

<%-- <link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection"> --%>

<!--------Language Dropdown-------->
	<%-- <script src="${context}/resources/assets/js/jquery__.min.js"></script> --%>
	
	<!--------Language Dropdown-------->
		<%-- <script src="${context}/resources/assets/js/jquery__.min.js"></script> --%>
		<!--------Language Dropdown-------->
<!--------Language Dropdown-------->

	
<script async defer src="${context}/resources/assets/js/jquery.min.js"></script>
<script async defer src="${context}/resources/assets/js/popper.min.js"></script>





<!-- Check IMEI CSS -->
<link rel="shortcut icon"
	href="${context}/resources/assets/images/favicon.ico">
<!-- App css -->

<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<!-- Security Tags -->


<%-- <jsp:include page="/WEB-INF/view/endUserHeader.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/endUserFooter.jsp"></jsp:include> --%>


<link rel="apple-touch-icon-precomposed"
	href="images/favicon/apple-touch-icon-152x152.png">
<!-- For iPhone -->
<meta name="msapplication-TileColor" content="#00bcd4">
<meta name="msapplication-TileImage"
	content="images/favicon/mstile-144x144.png">
<!-- For Windows Phone -->

<!-- CORE CSS-->
<%-- <link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection"> --%>

<%--  --%>


	

<!-- <script type="text/javascript">
	var path = "${context}";
</script> -->

 <style>
body[data-layout=horizontal] .content-page {
    margin-left: 0 !important;
    margin-top: 0px !important;
    border: none;
}

.mb-4{margin-bottom: 0px !important;}

.content-page .content {
    padding: 0px 0px 80px 0px;
    min-height: auto !important;
    position: relative;
}

.card, .card-box {
    margin-bottom: 0px;
    border: none;
}

.footer {
    /* border-top: 2px solid #f2f4f5; */
    bottom: 0;
    padding: 21px 15px 0px;
    position: absolute;
    right: 0;
    color: #1457c1;
    left: 0;
}

.content-page .content {
    padding: 20px 0px 0px 0px;
    min-height: auto !important;
    position: relative;
}  

.justify-content-center {
    justify-content: center!important;
}

@media (max-width: 991px)
body[data-layout=horizontal] .content-page {
    margin-top: 0px;
    border: none;
}
@media (max-width: 600px)
.getimei {
    max-width: 340px !important;
}
.getimei{max-width:440px;}

}

   
</style>

</head>

<body data-lang-param="${pageContext.response.locale}"
	data-layout="horizontal">
	<div id="initialloader"></div>
 
                <div class="loader-mask" style="display:none" id="loaderDiv">
                    <div class="box loader">
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
           
	<!-- Begin page -->
	<div id="wrapper">

		<!-- Navigation Bar-->
		


		<!-- End Navigation Bar-->

		<!-- ============================================================== -->
		<!-- Start Page Content here -->
		<!-- ============================================================== -->

		<div class="content-page">
			<div class="content">
<div id="initialloader"></div>

				<div class="container-fluid" id="imeiBox">

					<div class="row mt-5_ justify-content-center">
						
						<!--/col-md-5 -->
						
						<div style="width:125px !important;display:none" >
								<input type="text" id="utm_source" value="${utm_source}" style="display:none"> 
								<select name='options[212]' class="form-controlR" id="langlist" style="display: none">
									<option <c:if test="${param.lang=='en'}">selected="selected"</c:if> value="en" data-src="${context}/resources/assets/images/us.png">English</option>
									<option <c:if test="${param.lang=='km'}">selected="selected"</c:if> value="km" data-src="${context}/resources/assets/images/cambodia.png"><spring:message code="lang.khmer" /></option>
								</select>
<input type="text" id="leftPannelSideValue" value="${rightPanel}" style="display:none">
								<%-- <select class="darken-1" id="langlist">
										<option  value="en" style="color: #444;" data-src="${context}/resources/assets/images/us.png">English</option>
										<option value="km" style="color: #444;" data-src="${context}/resources/assets/images/cambodia.png"><spring:message code="lang.khmer" /></option>
									</select> --%>
								</div>
						
						<div style="border-left :0px #bdbdbd solid !important" class="col-12 col-sm-12 col-md-4 col-lg-4 getimei line-right">

							<div class="p-4 pd-tb0">
								<div class="card no-border">
									<div class="card-body pd-lr40 pd-lr0 pd-30">
										<div class="mb-4 mb-0 mt-3">
											<h1><spring:message code="imei.informationIframe" /></h1>
										</div>
										<form id="checkIMEIForm" action="" 
											method="POST" enctype="multipart/form-data" class="p-2 recaptchaForm">
											<!-- <div class="form-group">
												<label for="imei">IMEI</label> <input class="form-control"
													type="text" id="imei" required=""
													placeholder="Enter 15 digit IMEI number">
											</div> -->
			
											<div class="form-group" >
												<label for="imei"><spring:message code="input.imei" /></label> 
													<div class="input-group">
													<input type="text" id="IMEIStatus" value="${IMEIStatus}" style="display:none">
													<input type="text" id="InvalidIMEIAutoFill" value="${IMEI}" style="display:none">
													<input class="form-control max-input"
													type="text" id="DeviceID"
													pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
													
													placeholder="<spring:message code="imei.placeholder"/>" maxlength="15" required>
													<div class="Validation-addon" id="count">0/15</div>
													</div>
												
												<!--  <!-- <input type="text" id="countstroke" /> -->	
												
											</div>

											<div class="form-group">
											<div class="g-recaptcha" data-callback="recaptchaCallback" data-sitekey="<spring:eval expression="@environment.getProperty('captcha.dataSitekey')" />"></div>
											<!-- <div class="g-recaptcha"  data-sitekey="6LeLYSwmAAAAAFPrU8jvMZc1ziENdczQw9tZ4QYZ"></div> -->
											</div>

											<%-- <div class="form-group">
												<span class="input-icon"> <img id="captchaImage"
													src="${context}/captcha">
													<button
														style="background: none; border: none; outline: none; color: black;"
														type="button"
														onclick="checkImeiRefreshCaptcha('captchaImage','${context}')">
														<i class="fa fa-refresh"></i>
													</button>

												</span>
											</div> --%>

											
											<%-- <div class="form-group mb-4 pb-2">
												<label for="captcha"><spring:message
														code="registration.enteryourcaptcha" /></label> <input
													autocomplete="off" type="text" name="captcha"
													class="form-control" id="captcha"
													oninput="setCustomValidity('')"
													oninvalid="this.setCustomValidity('<spring:message code="validation.requiredMsg" />')"
													title="<spring:message code="validation.requiredMsg" />"
													required>
												<span id="errorMsgOnModal"  class="text-danger" style="display: none" ><spring:message code="imei.invalidCaptcha" /></span>	
												
											</div> --%>
											
											<span id="errorMsgOnModal"  class="text-danger" style="display: none" ><spring:message code="imei.invalidCaptcha" /></span>
											
											<div class="mb-3 text-center">
												<button id="submitbutton" class="btn btn-primary btn-block" type="submit" disabled>
												<spring:message code="check.imei" /></button>

											</div>
										</form>
									</div>
									<!-- end card-body -->
								</div>
								<!-- end card -->

							</div>

						</div>
						<!--/col-md-5-->
					</div>

				</div>
				
				<!-- END content-page -->
				
				<!-- Valid IME DIV -->
				<div class="container-fluid" id="validbox" style="display: none" >
					<div class="card_">
						<div class="card-body pd-65">
							<div class="text-center mb-4 mt-3">
								<h1><spring:message code="title.imeiMeidEsn" /></h1>
								<center>
								<img src="${context}/resources/assets/images/success.png" id="greenImg"  style="display:none" title="Valid" height="60">
								<img src="${context}/resources/assets/images/successYellow.png" id="yellowImg" style="display:none" title="Valid" height="60">
								</center>
								<h2  id="validIMEIHeading" style="color:black !important;"></h2>
								<h2 class="black" style=" width: 60%;   text-align: center; margin: auto;" id="validIMEIMessage"></h2>
							</div>
			
						</div>
						<!-- end card-body -->
					</div>
					<!-- end card -->
					<div class="row mt-2 justify-content-center">
						<div class="col-md-7 col-lg-4">
							<div class="card_">
								<div class="card-body pd-65">
									<div class="text-center mb-4 mt-3">
										<center>
										<img src="${context}/resources/assets/images/success.png" id="greenImg"  style="display:none" title="Valid" height="60">
										<img src="${context}/resources/assets/images/successYellow.png" id="yellowImg" style="display:none" title="Valid" height="60">
										</center>
										<h2  id="validIMEIHeading" style="color:black !important;"></h2>
										<h2 class="black" id="validIMEIMessage"></h2>
										<h3 class="blue"><spring:message code="input.imeiTag" /> <span id="validimei" class="blue"></span></h3>
									</div>
									<div class="card">
										<table class="card-table table">
											<tbody>
												<tr>
													<td class="no-border"><spring:message code="table.ProductName" /></td>													<td id="brandname" class="no-border"></td>
												</tr>
												<tr>
													<td><spring:message code="table.ModelNumber" /></td>
													<td id="modelname" ></td>
												</tr>
												<tr>
													<td><spring:message code="roletype.Manufacturer" /></td>
													<td id="manufacturer"></td>
												</tr>
												<tr>
													<td><spring:message code="operator.devicetype" /></td>
													<td id="devicetype"></td>
												</tr>
												<tr>
													<td class="noborder"><spring:message code="imei.MarketingName" /></td>
													<td class="noborder" id="marketingname"></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="mb-3 mt-4 text-center">
										<a onclick="RedirectTOMainPortal()" class="btn btn-primary btn-block">
										<spring:message code="imei.CheckotherImei" />
										</a>
									</div>
								</div>
								<!-- end card-body -->
							</div>
							<!-- end card -->


						</div>
						<!-- end col -->
					</div>
					<!-- end row -->

				</div>
				
				<!-- Invalid IMEI Box -->
				<div class="container-fluid" id="invalidbox" style="display: none">
					<div class="card_">
						<div class="card-body pd-65">
							<div class="text-center mb-4 mt-3">
								<h1><spring:message code="title.imeiMeidEsn" /></h1>
								<img src="${context}/resources/assets/images/Invalid.png" title="Valid" height="60">
								<h2  id="invalidIMEIHeading" style="color:black !important;"></h2>
							</div>
							
							 
						</div>
						<!-- end card-body -->
					</div>
					<!-- end card -->	
					
					<div class="row mt-2 justify-content-center">
                            <div class="col-md-7 col-lg-4">
                                <div class="card_">
                                    <div class="card-body pd-65">
                                        <div class="text-center mb-4 mt-3">
                                            <h2  id="invalidIMEIHeading" style="color:black !important;"></h2>
                                            <h3 class="blue"><spring:message code="input.imeiTag" /> <span id="invalidimei" class="blue"></span></h3>
                                        </div>
                                        <div class="card-body card">
                                           <%--  <p><spring:message code="input.Remark" /><br> --%>
                                               <span id="invalidMsg"></span> 
                                            </p>
                                          </div>
                                          <%-- <p><center><spring:message code="invalid.action" /></center></p> --%>
                                          <div class="mb-3 mt-4 text-center">
                                            <a onclick="RedirectTOMainPortal()"  class="btn btn-primary btn-block"><spring:message code="imei.CheckotherImei" /></a>
                                        </div>
                                    </div>
                                    <!-- end card-body -->
                                </div>
                                <!-- end card -->
        
        
                            </div>
                            <!-- end col -->
                        </div>
                        <!-- end row -->

                    </div>
					
					<!-- Error response DIV -->
				  <div class="container-fluid" id="errormsgbox" style="display: none">

                        <div class="row mt-2 justify-content-center">
                            <div class="col-md-7 col-lg-5">
                                <div class="card_">
                                    <div class="card-body">
                                        <div class="text-center mb-4 mt-3">
                                            <img src="${context}/resources/assets/images/oops.jpg" title="Valid" height="350">
                                            <h1><spring:message code="error.oops" /></h1>
                                            <h2><spring:message code="error.mgs" /></h2>
                                        </div>
                                    </div>
                                    <!-- end card-body -->
                                </div>
                                <!-- end card -->
        
        
                            </div>
                            <!-- end col -->
                        </div>
                        <!-- end row -->

                    </div>
				<!-- Footer Start -->
				<%-- <footer class="footer">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12"><spring:message code="imei.copyright" /> &copy; 
							<spring:message code="copyright.reserved" /></div>
							
						</div>
					</div>
				</footer> --%>
				<!-- end Footer -->

			</div>
			<!-- end content -->

		</div>
		<!-- END content-page -->

	</div>
	<!-- END wrapper -->




	<div id="errorModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="input.CheckDevice" />
		</h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="">
					<spring:message code="input.notDeviceId" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<!-- <a href="homePage" class="btn">Yes</a> -->
						<button class="modal-close btn" style="margin-left: 10px;">
							<spring:message code="modal.ok" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>







	<!-- Submit Modal start   -->

	<div id="submitIMEI" class="modal" style="display:none">
		<div class="modal-content">
			<h6>
				<spring:message code="registration.submitimei" />
			</h6>
			<hr>
			<div class="row">
				<h6>
					<spring:message code="registration.Theimeivalid" />
				</h6>
				<form action="">
					<div class="input-field col s6 m4">
						<label for="transactionID"><spring:message
								code="registration.tacnumberis" /></label>
					</div>
					<div class="input-field col s6 m8">
						<input type="text" id="transactionID" name="transactionID"
							placeholder="TAC12345678" disabled>
					</div>

					<div class="input-field col s6 m4">
						<label for=""><spring:message
								code="registration.modaltype" /></label>
					</div>
					<div class="input-field col s6 m8">
						<input type="text" name="" placeholder="ABC Modal" disabled>
					</div>
				</form>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="index.html" class="btn"><spring:message
								code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Submit Modal End -->




	<!-- ================================================
    Scripts
    ================================================ -->


<!--
	<script>
		/*  function hide() {
		     var In = $('#DeviceID').val()
		     if (In == "black") {

		         $("#inputDetails").css("display", "block");
		         $("#singleInput").css("display", "none");

		     } else if (In == "blue") {
		         $("#inputDetails").css("display", "none");
		         $("#singleInput").css("display", "block");
		     }
		 } */
	</script>
	-->
u<!-- ajax js -->
	<script type="text/javascript"
		src="${context}/resources/project_js/signup/Registration.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<!--materialize js-->
	<%-- <script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script> --%>
		
	<!-- Vendor js -->
	<script src="${context}/resources/assets/js/vendor.min.js"></script>

	<!-- App js -->
	<script src="${context}/resources/assets/js/app.min.js"></script>

	<script src="${context}/resources/assets/js/select2.min.js"></script>
	<script src="${context}/resources/assets/js/select2.js"></script>
	
	<script async defer src="https://www.google.com/recaptcha/api.js"></script>
	<script async defer src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=en" async defer></script>
	<!--<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=en" async defer>
	</script>-->
	
	<%-- <script src='https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.10/vue.min.js'></script>
	<script src="${context}/resources/assets/js/LimitCount.js"></script> --%>
	
	<!-- ajax js -->
	<%-- <script type="text/javascript"
		src="${context}/resources/project_js/signup/Registration.js?version=<%= (int) (Math.random() * 10) %>"></script> --%>
	
	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
	<%--  --%>
	<!--custom-script.js - Add your own theme custom JS-->
	<!-- i18n library -->
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
		src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/checkIMEI.js?version=<%= (int) (Math.random() * 10) %>"></script>

</body>
</html>
