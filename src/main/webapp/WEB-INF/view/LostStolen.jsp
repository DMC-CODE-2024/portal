<!DOCTYPE html>
<html class="no-js" lang="en" dir="ltr">
<head><title>EIRS Portal</title>
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
<style type="text/css">
body {
    background:white !important;
    overflow: auto !important;
}
</style>
</head>
<body data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-selected-username="${username}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}">


	<div class="dashboard-layout">
	<div id="initialloader"></div>
        <div class="dashboard-header navbar navbar-expand navbar-dark align-items-center">
            <!-- Brand -->
            <a class="navbar-brand" href="#">
                <img src="${context}/resources/assets/images/logo.png" alt="logo" class="img-fluid">
                <span>CEIR</span>
            </a>

        </div>
        
        <%-- <div class="alert alert-National fade show alert-dismissible alertID  alert-position1 mb-4 " role="alert" id="invalidOTP" style="display:none">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close" class=""></span>
            </button>
            <strong><i class="fa fa-info-circle" aria-hidden="true"></i></strong><spring:message code="input.invalidOTP1" />            
          </div> --%>
        <div class="Status-form " id="stolenFormBlock">
          
		<%--  <div class="alert alert-National fade show alert-dismissible alertID  alert-position mb-4" role="alert" id="invalidPairBlock" style="display:none">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close" class=""></span>
            </button>
            <strong><i class="fa fa-info-circle" aria-hidden="true"></i></strong><spring:message code="input.NIDMessage1" /><br><spring:message code="input.NIDMessage2" />            
          </div> --%>
          
         
           <h1><spring:message code="stolen.heading" /></h1>
           <div class="form-content">
            <form  onsubmit="return submitStolenDeviceRequest()" action="">
              <h4><spring:message code="stolen.heading2" /></h4>
                <div class="form-row">
                   <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.contact1" /> <span class="star">*</span></label>
                        <input type="text" class="form-control" id="stolenMobile1"  required
                          pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />" 
                          oninput="InvalidMsg(this,'input','<spring:message code="AssigneContactNumber" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="AssigneContactNumber" />');" >
												 
                        </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.IMEI1" /> <span class="star">*</span></label>
                        <input type="text" class="form-control" id="stolenIMEI1" required 
                          pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />" 
                          oninput="InvalidMsg(this,'input','<spring:message code="validation.stolenIMEI" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.stolenIMEI" />');"
                          >
			   		</div>
			   		
                      <div class="form-group col-md-12">
                        <label for=""><spring:message code="recovery.Reason" /> <span class="star">*</span></label>
                        <select class="form-control" id="recoveryReason" required="required">
                         
                      </select>
                      </div>
                    
						
                </div>
                 <div class="form-row">
                  <div class="form-group col-md-6">
                      <label for=""><spring:message code="stolen.IMEI3" /> <span class="star">*</span></label>
                      <input type="text" class="form-control" id="stolenIMEI3"  required 
                      pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.stolenIMEI" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.stolenIMEI" />');" 
                      >
                    </div>

                     <div class="form-group col-md-6">
                      <label for=""><spring:message code="stolen.IMEI4" /> <span class="star">*</span></label>
                      <input type="text" class="form-control" id="stolenIMEI4"  required 
                      pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.stolenIMEI" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.stolenIMEI" />');" 
                      >
                    </div>
              </div>
              <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.deviceBrand" /> <span class="star">*</span></label>
                        <input type="text" class="form-control" id="stolenDeviceBrand" required >
                      </div>

                       <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.deviceModel" /> <span class="star">*</span></label>
                        <input type="text" class="form-control" id="stolenDeviceModel" required >
                      </div>

                      
                </div>
                
                <div class="form-row">
					<div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.devicePurchaseInvoice" /> <span class="star">*</span></label>
                        <input type="file" id="stolenMobileInvoice" required class="input-file mb-1" accept="image/*,.pdf">
                        <p><small><spring:message code="stolen.invoiceType" /></small></p>
                      </div>
                       <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.category" /> <span class="star">*</span></label>
                        <select class="form-control" id="category"  required="required">
                          
                      </select>
                      </div>
                </div>
                 <h4><spring:message code="stolen.InfoHeading" /></h4>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.date" /> <span class="star">*</span></label>
                        <input type="date"  id="stolenDate" class="form-control text-uppercase" required >
                      </div>
                     
                      <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.time" /> <span class="star">*</span></label>
                        <input type="time" id="stolenTime" class="form-control text-uppercase" required >
                      </div>
				</div>
               

                <div class="form-row">
                    
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.provinceCity" /> <span class="star">*</span></label>
                        <select class="form-control" id="provinceCity" onchange="getDistrict('provinceCity')" required="required">
                         
                      </select>
                      </div>
                      
                

                       
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.district" /> <span class="star">*</span></label>
                        <select class="form-control" id="district" required="required" onchange="getCommune('district')">
                         
                      </select>
                      </div>
                      
              
                </div>
                
                <div class="form-row">
                    
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.commune" /> <span class="star">*</span></label>
                        <select class="form-control" id="commune" required="required" onchange="getPolice('commune')">
                         
                      </select>
                      </div>
                      <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.policeStation" /> <span class="star">*</span></label>
                        <select class="form-control" id="policeStation" required="required">
                        </select>
                      </div>
                  </div>
                
                 <h4><spring:message code="stolen.heading2" /></h4>
                <div class="form-row">
                   <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.Nationality" /> <span class="star">*</span></label>
                        <select class="form-control" id="ownerNationality" required="required" onchange="chooseNationality()">
                       
                      </select>
                      </div>
                </div>
 <h4><spring:message code="stolen.personalInfo" /></h4> 
                <div class="form-row">
                  <div class="form-group col-md-6">
                      <label for=""><spring:message code="stolen.owner" /> <span class="star">*</span></label>
                      <input type="text" required class="form-control" id="stolenOwner" 
                       pattern="<spring:eval expression="@environment.getProperty('pattern.ownerName')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.Stolen20Character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.Stolen20Character" />');"  >
                    </div>

                    <div class="form-group col-md-6" id="ownerEmailDiv" >
                      <label for=""><spring:message code="stolen.email" /> <span class="star">*</span></label>
                      <input type="text" class="form-control" id="stolenEmail" required
                        pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.stolenEmail" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.stolenEmail" />');">
                    </div>
                    
                    
                    <div class="form-group col-md-6" id="ownerDOBlDiv" style="display: none">
                        <label for=""><spring:message code="stolen.ownwerDOB" /> <span class="star">*</span></label>
                        <input type="date"  id="ownerDOB" class="form-control text-uppercase" >
                      </div>
                   

                   
              </div>
			<div class="form-row">
			 <div class="form-group col-md-6">
                      <label for=""><spring:message code="stolen.Address1" /> <span class="star">*</span></label>
                      <input type="text" required class="form-control" id="stolenOwnerAddress1" 
                       pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.StolenAddress20characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.StolenAddress20characters" />');">
                    </div>
                    
                <div class="form-group col-md-6">
                    <label for=""><spring:message code="stolen.Address2" />  </label>
                    <input type="text" class="form-control" id="stolenOwnerAddress2" 
                     pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.StolenAddress20characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.StolenAddress20characters" />');">
                  </div>
</div>
				<div class="form-row">
              
            
                <div class="form-group col-md-6" id="ownerNIDdiv">
                  <label for=""> <spring:message code="stolen.nid" />  <span class="star">*</span></label>
                  <input type="text"  required class="form-control" id="stolenOwnerNID" 
                   pattern="<spring:eval expression="@environment.getProperty('pattern.nid')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.Stolen12NID" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.Stolen12NID" />');">
                </div>
                
                <div class="form-group col-md-6" id="ownerPassportDiv" style="display:none">
                  <label for=""> <spring:message code="stolen.passport" />  <span class="star">*</span></label>
                  <input type="text"  class="form-control" id="stolenOwnerPassport" 
                   pattern="<spring:eval expression="@environment.getProperty('pattern.nid')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.Stolen12NID" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.Stolen12NID" />');">
                </div>

                <div class="form-group col-md-6" id="otpContactDiv">
                  <label for=""><spring:message code="stolen.OTPContact" /> <span class="star">*</span></label>
                  <input type="text" required class="form-control" id="stolenOwnerOTPContact" 
                   pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.StolenContact" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.StolenContact" />');">
                </div>
                
                <div class="form-group col-md-6" id="otpEmailDiv" style="display:none">
                      <label for=""><spring:message code="stolen.email" /> <span class="star">*</span></label>
                      <input type="text" class="form-control" id="stolenOtpEmail"
                        pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.stolenEmail" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.stolenEmail" />');">
                    </div>
          </div>

        <div class="form-row">
          <div class="form-group col-md-12">
            <label for=""><spring:message code="stolen.nidUpload" /> <span class="star">*</span></label>
            <input type="file" required class="input-file mb-1" id="stolenOwnerNIDfile" accept="image/*,.pdf">
            <p><small><spring:message code="stolen.complaintCopyType" /></small></p>
            </div>
      </div>   
      
      <div class="form-group">
      <p class="mt-2 mb-6"><spring:message code="stolen.Mandatory" /> <span class="red">*</span></p>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="gridCheck" required>
        <label class="form-check-label" for="gridCheck"><spring:message code="stolen.Declaration" />
          
        </label>
      </div>
    </div>
    
    <div class="form-group">
											<div class="g-recaptcha" data-callback="recaptchaCallback" data-sitekey="<spring:eval expression="@environment.getProperty('captcha.dataSitekey')" />"></div>
											<!-- <div class="g-recaptcha"  data-sitekey="6LeLYSwmAAAAAFPrU8jvMZc1ziENdczQw9tZ4QYZ"></div> -->
											<span id="errorMsgOnModal"  class="text-danger" style="display: none" ><spring:message code="imei.invalidCaptcha" /></span>
											</div>
			<div class="row">
                <div class="col-lg-12">
                    <div class="no-border flex-end">
                       <!--  <button type="button" class="btn cancel-btn">Back</button> -->
                       <a href="#" onclick="redirectTomToMainPage()"  class="btn cancel-btn">Back</a>
                        <button type="submit" id="stolenLostButton" class="btn save-button-dark">Submit</button>
                    </div>
                </div>
            </div> 
            
				</form>
        </div>
            
        </div><!------Status-form close------>



<div class="Validate-form" id="verifyOtpForm" style="display:none">
           <div class="UnBlock">
            <h1 class="mb-4 mb-70"><spring:message code="OTP.heading" />  </h1>
            <h6 class="mb-4"><spring:message code="OTP.verficationequest" /></h6>
            <h6 class="mb-2"><spring:message code="OTP.verficationequest1" /></h6>
            <P id="phoneNumberOTP"><spring:message code="OTP.verficationequest2" /> </P>

            <div class="Validate-box">
                <form onsubmit="return submitOTPRequest()" action="">
                    <div class="form-group text-center mt-20">
                    <input class="otp" type="text" required oninput='digitValidate(this)' id="OtpBox1" onkeyup='tabChange(1)' maxlength=1 >
                    <input class="otp" type="text" required oninput='digitValidate(this)' id="OtpBox2" onkeyup='tabChange(2)' maxlength=1 >
                    <input class="otp" type="text" required oninput='digitValidate(this)' id="OtpBox3" onkeyup='tabChange(3)' maxlength=1 >
                    <input class="otp" type="text" required oninput='digitValidate(this)' id="OtpBox4" onkeyup='tabChange(4)' maxlength=1 >
                    <input type="text" id="OTPRequestId" style=display:none >
                </div>
                <div class="row  mt-4 mb-2 plr-50 mb-4">
                    <div class="col-md-9 text-left timer">
                        <a href="#" id="resendOTPclick" ><spring:message code="OTP.resend" />  </a>
                        <p><spring:message code="OTP.timeDuration" /> <span id="countdown"></span></p>
                    </div>
                    <div class="col-md-3"> <a href="ForgotTicket.html" class="btn-block text-right"><spring:message code="OTP.back" /></a></div>
                  </div>
                  <%-- <button type="button" class="btn cancel-btn"><spring:message code="OTP.back" /></button> --%>
                   <a href="#" onclick="redirectTomToMainPage()"   class="btn cancel-btn"><spring:message code="OTP.back" /></a>
                  <button type="submit" class="btn save-button-dark"><spring:message code="OTP.verify" /></button>
                  </form>
            </div>

           
        </div>
            
        </div>

	 <div class="Status-form" style="display:none" id="successOTPScreen">
           <div class="UnBlock">
            <p><img src="${context}/resources/assets/images/check.png" alt="logo" class="img-fluid"></p>
            <h1><spring:message code="verifyOTPOTP.h1Msg" /> </h1>
          <p id="verifyOTPrequestid"><spring:message code="verifyOTPOTP.p1Msg" />  </p>
          <p><spring:message code="verifyOTPOTP.p2Msg" />.<br> <spring:message code="verifyOTPOTP.p3Msg" /></p>
        </div>
            
        </div>
        
         <div class="Status-form" style="display:none" id="otplimitExceed">
           <div class="UnBlock">
            <p><img src="${context}/resources/assets/images/limitaccess.png" alt="logo" class="img-fluid"></p>
            <h1><spring:message code="verifyOTPOTP.limitExceed" /> </h1>
        </div>
            
        </div>
        <div class="sidear-footer"><spring:message code="stolen.copyright" /></div>
       </div>

<!--------------invalid OTP modal  -------------->
 <div class="modal fade modalBackdrop hidden"  data-toggle="modal fade" data-target="1233189" id="invalidOTP" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true" style="display:none">
  <div class="modal-dialog modal-sm transform-10" id="1233189" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="alert-close close"  onclick="closeModal('invalidOTP')" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span>
        </button>
 
        <p>
          <spring:message code="input.invalidOTP1" />
        </p>
      </div>
    </div>
  </div>
</div>

<!--------------invalid OTP modal  -------------->

<!-------------- modal limit exceed -------------->
<div class="modal fade modalBackdrop hidden"  data-toggle="modal fade" data-target="1233111" id="otplimitExceed" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle1" aria-hidden="true" style="display:none">
  <div class="modal-dialog modal-sm transform-10" id="1233111" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="alert-close close"  onclick="closeModal('otplimitExceed')" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span>
        </button>
 
        <p>
          <spring:message code="input.NIDMessage1" /><br>
            <spring:message code="input.NIDMessage2" />
        </p>
      </div>
    </div>
  </div>
</div>  
	     <!-------------- modal limit exceed -------------->
	   <!-------------- Modal National ID -------------->
<div class="modal fade modalBackdrop hidden"  data-toggle="modal fade" data-target="12331" id="invalidPairBlock" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display:none">
  <div class="modal-dialog modal-sm transform-10" id="12331" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="alert-close close"  onclick="closeModal('invalidPairBlock')" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span>
        </button>
 
        <p>
          <spring:message code="input.tacNotexist" /><br>
            <spring:message code="input.tacNotexist1" />
        </p>
      </div>
    </div>
  </div>
</div>


<div class="modal fade modalBackdrop hidden"  data-toggle="modal fade" data-target="123311" id="invalidTACBlock" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display:none">
  <div class="modal-dialog modal-sm transform-10" id="123311" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="alert-close close"  onclick="closeModal('invalidTACBlock')" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span>
        </button>
 
        <p>
          <spring:message code="input.duplicteTAC" /><br>
            <spring:message code="input.duplicteTAC1" />
        </p>
      </div>
    </div>
  </div>
</div> 

<div class="modal fade modalBackdrop hidden"  data-toggle="modal fade" data-target="123311" id="duplicateIMEIBlock" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display:none">
  <div class="modal-dialog modal-sm transform-10" id="12331" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="alert-close close"  onclick="closeModal('duplicateIMEIBlock')" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span>
        </button>
 
        <p>
        <spring:message code="input.duplicateIMEI" />
            <spring:message code="input.duplicateIMEI2" />
        </p>
      </div>
    </div>
  </div>
</div>  


<!-------------- Modal National ID Close-------------->
	   


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
		src="${context}/resources/project_js/LostStolen.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
		
			<script type="text/javascript"
		src="" async></script>
<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>


		
		<script type="text/javascript"
		src="${context}/resources/project_js/otp.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/addressDropdowns.js?version=<%= (int) (Math.random() * 10) %>"></script>
	
		<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>
</body></html>


