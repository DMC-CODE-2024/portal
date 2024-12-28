<%@ page import="java.util.Date"%>
<%
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Cache-Control", "no-store");
   response.setDateHeader("Expires", 0);
   response.setHeader("Pragma", "no-cache");

   int timeout = session.getMaxInactiveInterval();

   long accessTime = session.getLastAccessedTime();
   long currentTime = new Date().getTime();
   long dfd = accessTime + timeout;
   if (currentTime < dfd) {

   %>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Security Tags -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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

      <!-- CSS for icons(to remove later) -->
      <link rel="stylesheet"
         href="${context}/resources/project_css/iconStates.css">
      <link
         href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
         type="text/css" rel="stylesheet" media="screen,projection">
      <!-- CORE CSS-->
      <link rel="stylesheet" href="${context}/resources/assets/css/stolenStyle.css">
      <script>
         var contextpath = "${context}";
      </script>
   <style type="text/css">
   body {
       background:#f1f1f1 !important;
       overflow: auto !important;

   }
   html, body {
                   scroll-behavior: smooth;            }
              :root {
     scroll-behavior: auto !important;
   }
    .file-input-wrapper,.file-input-wrapper1,.file-input-wrapper2,.file-input-wrapper3,.file-input-wrapper4 {
               position: relative;
               width: 200px;
               height: 40px;
               margin-bottom: 4px;
           }
    .stolenFiles {
               position: absolute;
               width: 200px;
               height: 40px;
               top: 0;
               left: 0;
               opacity: 0; /* Hide the actual file input */
               cursor: pointer;
           }
    .custom-file-button, .NidFile,.firCopy,.otherdocument,.file-nameStolen{
               position: absolute;
               width: 150px;
               height: 40px;
               top: 0;
               left: 0;
               background-color: #F19D5B;;
               color: white;
               text-align: center;
               line-height: 40px;
               border-radius: 8px;
               cursor: pointer;
           }
    .file-name ,.file-nameNid,.file-nameFir,.file-nameOtherDoc,.bulkFile{
                      display: inline-block;
                          margin-left: 160px;
                          max-width: 300px;
                          white-space: nowrap;
                          overflow: hidden;
                          text-overflow: ellipsis;
                          vertical-align: top;
                          font-size: 14px;
                          color: black !important;
             }
   </style>
   </head>

   <body data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}"
      data-selected-roleType="${selectedUserTypeId}" data-featureid="${featureId}"
      data-selected-username="${username}" data-lang-param="${pageContext.response.locale}"
      data-stolenselected-roleType="${stolenselectedUserTypeId}">
      <input type="text" id="requestIdToFetchDetail" value="${requestId}" style="display:none">
  <div class="content-box">
    <div class="content-container" >
       <h1 class="stolenHeading"><spring:message code="stolen.headingBulk" /></h1>

 <div class="Status-form width-90-200" id="stolenFormBlock">
     <div class="form-content">
                 <form  onsubmit="return submitStolenDeviceRequest()" id="fromStolenId" action="">
                                            <h4><spring:message code="stolen.heading2" /></h4>

                                              <div class="form-row">
                                              <div class="form-group col-md-6">
                                                  <label for=""><spring:message code="stolen.BulkFile" /> <span class="star">*</span></label>
                                                  <div class="file-path-wrapper">
                                                  		<input class="form-control mr-10" disabled
                                                  		   id="stolenMobileFileBulk" type="text">
                                                  				<a href="#" id="stolenMobileFileBulkPreview" class="viewRightIcon">
                                                  				<img src="./resources/assets/images/download-icon-blue.svg" alt="icon" class="img-fluid">
                                                  				</a>
                                                  </div>
                                               </div>
                                              <div class="form-group col-md-6">
                                                      <label for=""><spring:message code="stolen.devicePurchaseInvoice" /> <span class="star">*</span></label>
                                                        <div class="file-path-wrapper">
                                                  							<input class="form-control mr-10" disabled
                                                  								id="stolenMobileInvoiceBulk" type="text">
                                                  								 <a href="#" id="stolenMobileInvoiceBulkPreview" class="viewRightIcon">
                                                  								 <img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid">
                                                  								 </a>
                                                  </div>
                                                   </div>


                                              </div>
                                               <h4><spring:message code="stolen.InfoHeading" /></h4>

                                              <div class="form-row">
                                                  <div class="form-group col-md-6">
                                                      <label for=""><spring:message code="stolen.date" /> <span class="star">*</span></label>
                                                      <input type="date"  id="stolenDateBulk" disabled class="form-control text-uppercase" required >
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                      <label for=""><spring:message code="stolen.time" /> <span class="star">*</span></label>
                                                      <input type="time" id="stolenTimeBulk" disabled class="form-control text-uppercase" required >
                                                    </div>
                              				</div>


                                              <div class="form-row">

                                                  <div class="form-group col-md-6">
                                                      <label for=""><spring:message code="lost.provinceCity" /> <span class="star">*</span></label>
                                                      <select class="form-control" disabled id="provinceCityBulk" onchange="getDistrict('provinceCityBulk')" required="required">
                                                       <option value=""  selected><spring:message code="select.provinceCity" />
                                                    </select>
                                                    </div>




                                                  <div class="form-group col-md-6">
                                                      <label for=""><spring:message code="lost.district" /> <span class="star">*</span></label>
                                                      <select class="form-control" disabled id="districtBulk" required="required" onchange="getCommune('districtBulk')">
                                                        <option value=""  selected><spring:message code="select.LostDistrict" />
                                                    </select>
                                                    </div>


                                              </div>

                                              <div class="form-row">

                                                  <div class="form-group col-md-6">
                                                      <label for=""><spring:message code="lost.commune" /> <span class="star">*</span></label>
                                                      <select class="form-control" disabled id="communeBulk" required="required" onchange="getPolice('communeBulk')">
                                                        <option value=""  selected><spring:message code="select.LostCommune" />
                                                    </select>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                      <label for=""><spring:message code="lost.policeStation" /> <span class="star">*</span></label>
                                                      <select class="form-control" disabled id="policeStationBulk"  required="required">
                                                      <option value=""  selected><spring:message code="select.PoliceStation" />
                                                      </select>
                                                    </div>
                                             </div>
                                             <div class="form-row">
                                                <div class="form-group col-md-6">
                                                  <label for=""><spring:message code="lost.category" /> <span class="star">*</span></label>
                                                                <select class="form-control" disabled id="categoryBulk"  required="required">
                                                                  <option ><spring:message code="select.category" />
                                                                  <option value="1"  ><spring:message code="select.categoryLost" />
                                                                  <option value="2"  ><spring:message code="select.categoryStolen" />
                                                                </select>
                                                 </div>

                                                 <div class="form-group col-md-6">
                                                                              <label for=""><spring:message code="stolen.firCopy" /> <span class="star">*</span></label>
                                                                              <div class="file-path-wrapper">
                                                                                 <input class="form-control mr-10" disabled
                                                                                     id="deviceFirCopyBulk" type="text">
                                                                                  		<a href="#" id="deviceFirCopyBulkPreview" class="viewRightIcon">
                                                                                  		<img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid">
                                                                                  		</a>
                                                                                  </div>
                                                 </div>

                                             </div>
                                              <div class="form-row">
                                               <div class="form-group col-md-12">
                                                 <label for=""><spring:message code="stolen.incident" /><span class="star">*</span> </label>
                                                      <textarea id="incidentDetailBulk" disabled required="required" name="incidentDetail"    class="form-control" id="stolenIncident"  placeholder="<spring:message code="placeholder.incident" />"
                                                          oninput="validateTextarea(this,'stolenLostButton','error-message','<spring:eval expression='@environment.getProperty(\"pattern.Incident\")'/>')">
                                                       </textarea>
                                                       <p id="error-message" style="color: red; display: none;"><spring:message code="validation.StolenInicdent" /></p>
                                                 </div>
                                              </div>


                                               <h4><spring:message code="lost.Nationality" /></h4>
                                              <div class="form-row">
                                                 <div class="form-group col-md-6">
                                                      <label for=""><spring:message code="lost.Nationality" /> <span class="star">*</span></label>
                                                      <select class="form-control" disabled id="ownerNationalityBulk" required="required" onchange="chooseNationality()">

                                                    </select>
                                                    </div>
                                              </div>
                               <h4><spring:message code="stolen.personalInfo" /></h4>
                                              <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label for=""><spring:message code="stolen.owner" /> <span class="star">*</span></label>
                                                    <input type="text" disabled required autocomplete="off" class="form-control " id="stolenOwnerBulk"  placeholder="<spring:message code="placeholder.name" />"
                                                     pattern="<spring:eval expression="@environment.getProperty('pattern.ownerName')" />"
                              											    oninput="InvalidMsg(this,'input','<spring:message code="validation.Stolen20Character" />');"
                              												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.Stolen20Character" />');"  >
                                                </div>

                                                  <div class="form-group col-md-6" id="ownerEmailDivBulk" >
                                                    <label for=""><spring:message code="stolen.email" /> <span class="star">*</span></label>
                                                    <input type="text" disabled  class="form-control" maxlength="50" autocomplete="off" id="stolenEmailBulk" required placeholder="<spring:message code="placeholder.email" />"
                                                      pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
                              											    oninput="InvalidMsg(this,'input','<spring:message code="validation.stolenEmail" />');"
                              												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.stolenEmail" />');">
                                                  </div>


                                                  <div class="form-group col-md-6" id="ownerDOBlDivBulk" style="display: none">
                                                      <label for=""><spring:message code="stolen.ownwerDOB" /> <span class="star">*</span></label>
                                                      <input type="date" disabled  id="ownerDOBBulk" class="form-control text-uppercase" >
                                                    </div>



                                            </div>
                              			<div class="form-row">
                              			 <div class="form-group col-md-6">
                                                    <label for=""><spring:message code="stolen.Address1" /> <span class="star">*</span></label>
                                                    <input type="text" disabled required autocomplete="off" class="form-control" id="stolenOwnerAddress1Bulk" placeholder="<spring:message code="placeholder.address1" />"
                                                     pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
                              											    oninput="InvalidMsg(this,'input','<spring:message code="validation.StolenAddress20characters" />');"
                              												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.StolenAddress20characters" />');">
                                                  </div>

                                              <div class="form-group col-md-6">
                                                  <label for=""><spring:message code="stolen.Address2" />  </label>
                                                  <input type="text" disabled class="form-control" autocomplete="off" id="stolenOwnerAddress2Bulk
                                                  " placeholder="<spring:message code="placeholder.address2" />"
                                                   pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
                              											    oninput="InvalidMsg(this,'input','<spring:message code="validation.StolenAddress20characters" />');"
                              												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.StolenAddress20characters" />');">
                                                </div>
                              </div>
                              				<div class="form-row">


                                              <div class="form-group col-md-6" id="ownerNIDdiv">
                                                <label for=""> <spring:message code="stolen.nid" />  <span class="star">*</span></label>
                                                <input type="text" disabled maxlength="13" autocomplete="off" required class="form-control" id="stolenOwnerNIDBulk" placeholder="<spring:message code="placeholder.nid" />"
                                                 pattern="<spring:eval expression="@environment.getProperty('pattern.nid')" />"
                              											    oninput="InvalidMsg(this,'input','<spring:message code="validation.Stolen12NID" />');"
                              												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.Stolen12NID" />');">
                                              </div>

                                              <div class="form-group col-md-6" id="ownerPassportDiv" style="display:none">
                                                <label for=""> <spring:message code="stolen.passport" />  <span class="star">*</span></label>
                                                <input type="text" disabled maxlength="13" autocomplete="off" class="form-control" id="stolenOwnerPassportBulk" placeholder="<spring:message code="placeholder.passport" />"
                                                 pattern="<spring:eval expression="@environment.getProperty('pattern.nid')" />"
                              											    oninput="InvalidMsg(this,'input','<spring:message code="validation.Stolen12NID" />');"
                              												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.Stolen12NID" />');">
                                              </div>

                                             <%--  <div class="form-group col-md-6" id="otpContactDiv">
                                                <label for=""><spring:message code="stolen.OTPContact" /> <span class="star">*</span></label>
                                                <input type="text" maxlength="10" autocomplete="off" required class="form-control" id="stolenOwnerOTPContactBulk" placeholder="<spring:message code="placeholder.contact" />"
                                                 pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
                              					oninput="InvalidMsg(this,'input','<spring:message code="validation.StolenContact" />');"
                              					oninvalid="InvalidMsg(this,'input','<spring:message code="validation.StolenContact" />');">
                                              </div> --%>

                                               <div class="form-group col-md-6" id="otpContactDiv">
                                                      <label for=""><spring:message code="stolen.OTPContact" /> <span class="star">*</span></label>
                                                     <div class="flex">
                                                      <input type="text" disabled maxlength="9" autocomplete="off" required class="form-control border-none pl-0" id="stolenOwnerOTPContactBulk" placeholder="<spring:message code="placeholder.contact" />"
                                                 pattern="<spring:eval expression="@environment.getProperty('pattern.StolencontactNo')" />"
                              											    oninput="InvalidMsg(this,'input','<spring:message code="validation.StolenContact" />');"
                              												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.StolenContact" />');">

                                                      </div></div>

                                              <div class="form-group col-md-6" id="otpEmailDiv" style="display:none">
                                                    <label for=""><spring:message code="stolen.emailPassport" /> <span class="star">*</span></label>
                                                    <input type="text" disabled class="form-control" maxlength="50" autocomplete="off" id="stolenOtpEmailBulk" placeholder="<spring:message code="placeholder.email" />"
                                                      pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
                              											    oninput="InvalidMsg(this,'input','<spring:message code="validation.stolenEmail" />');"
                              												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.stolenEmail" />');">
                                                  </div>
                                        </div>

                                      <div class="form-row">
                                        <div class="form-group col-md-6">
                                          <label for="" id="NIDblockLabel"><spring:message code="stolen.nidUpload" /> <span class="star">*</span></label>
                                           <label for="" id="PassportblockLabel"style="display: none"><spring:message code="stolen.passportUpload" /> <span class="star">*</span></label>
                                           <div class="file-path-wrapper">
                                                       <input class="form-control mr-10" disabled
                                                         id="stolenOwnerNIDfileBulk" type="text">
                                                          <a href="#" id="stolenOwnerNIDfileBulkPreview" class="viewRightIcon">
                                                          <img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid">
                                                          </a>
                                           </div>
                                          </div>
                                                  <div class="form-group col-md-6">
                                                           <label for="" ><spring:message code="stolen.otherDocument" /></label>
                                                         <div class="file-path-wrapper">
                                                                 <input class="form-control mr-10"
                                                                    id="stolenOtherdocumentBulk" disabled type="text">
                                                                     <a href="#" id="stolenOtherdocumentBulkPreview" class="viewRightIcon">
                                                                     <img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid">
                                                                     </a>
                                                              </div>
                                            </div>

                                    </div>
                                    <div class="form-row">

                                                  <div class="form-group col-md-12">
                                                   <label for=""><spring:message code="stolen.Remark" /><span class="star">*</span> </label>
                                                    <textarea id="stolenRemarkBulk" disabled required="required" name="stolenRemark"    class="form-control"  placeholder="<spring:message code="placeholder.incident" />"
                                                     oninput="validateTextarea(this,'stolenLostButton','error-messageRemark','<spring:eval expression='@environment.getProperty(\"pattern.Incident\")'/>')">
                                                     </textarea>
                                                     <p id="error-messageRemark" style="color: red; display: none;"><spring:message code="input.Remark" /></p>
                                                     </div>
                                    </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="no-border flex-end">
                                              <a href="./policeTrackLostDevice"    class="btn cancel-btn"><spring:message code="OTP.back" /></a>
                                        </div>
                                    </div>
                                </div>
                        </form>
             </div>

             </div>


<div class="Validate-form" id="verifyOtpForm" style="display:none">
           <div class="UnBlock" style="padding-top: 1px !important;">
            <h1 class="mb-4 mb-70" ><spring:message code="OTP.heading" />  </h1>
            <h6 class="mb-4"><spring:message code="OTP.verficationequest" /></h6>
            <h6 class="mb-2"><spring:message code="OTP.verficationequest1" /></h6>
            <P id="phoneNumberOTP"><spring:message code="OTP.verficationequest2" /> </P>
			<P id="emailOTPMsg" style="display:none"><spring:message code="OTP.emailMsg" /> </P>
            <div class="Validate-box">
                <form onsubmit="return submitOTPRequest()" action="" >
                    <div class="form-group text-center mt-20" id="inputs">

                    <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox1" onkeyup='tabChange(1)' maxlength=1 >
                    <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox2" onkeyup='tabChange(2)' maxlength=1 >
                    <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox3" onkeyup='tabChange(3)' maxlength=1 >
                    <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox4" onkeyup='tabChange(4)' maxlength=1 >
                     <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox5" onkeyup='tabChange(5)' maxlength=1 >
                    <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox6" onkeyup='tabChange(6)' maxlength=1 >
                    <input type="text" id="OTPRequestId" style=display:none >


                    <div class="col-md-12 text-left timer" style="padding: 0 23% !important; margin-top: 20px !important;">
                        <a href="#" id="resendOTPclick" ><spring:message code="OTP.resend" />  </a>
                        <p id="resendOTPclick_time" ><spring:message code="OTP.timeDuration" /> <span id="countdown"></span></p>
                    </div>
                    <%-- <div class="col-md-3"> <a href="ForgotTicket.html" class="btn-block text-right"><spring:message code="OTP.back" /></a></div> --%>

                </div>

                  <%-- <button type="button" class="btn cancel-btn"><spring:message code="OTP.back" /></button> --%>
                   <div class="no-border center">
                   <a href="#" onclick="redirectTomToMainPage()"   class="btn cancel-btn"><spring:message code="OTP.back" /></a>
                  <button type="submit" class="btn save-button-dark"><spring:message code="OTP.verify" /></button>
                  </div>
                  </form>
            </div>


        </div>

        </div>

<div class="Status-form" style="display:none" id="successOTPScreen">
           <div class="UnBlock" style="padding-top: 1px !important;">
            <p><img src="${context}/resources/assets/images/check.png" alt="logo" class="img-fluid"></p>
            <h1 style="font-size: 2rem !important;margin-top: 15px;"><spring:message code="verifyOTPOTP.h1Msg" /> </h1>
          <p id="verifyOTPrequestid"><spring:message code="verifyOTPOTP.p1Msg" />  </p>
          <p><spring:message code="verifyOTPOTP.p2Msg" />.<br> <spring:message code="verifyOTPOTP.p3Msg" /></p>
              <a href="./policeTrackLostDevice"    class="btn save-button-dark" style="margin-top: 20px;" ><spring:message code="Stolen.done" /></a>
        </div>

        </div>
   <!-- Modal View-->


<!--------------invalid OTP modal  -------------->
 <div class="modal fade modalBackdrop hidden"  data-toggle="modal fade" data-target="1233189" id="invalidOTP" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true" style="display:none">
  <div class="modal-dialog modal-sm transform-10" id="1233189" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="alert-close close"  onclick="closeModal('invalidOTP')" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span>
        </button>

        <p class="Rejected">
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

        <p class="Rejected">
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

        <p class="Rejected">
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

        <p class="Rejected">
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

        <p class="Rejected">
        <spring:message code="input.duplicateIMEI" />
            <spring:message code="input.duplicateIMEI2" />
        </p>
      </div>
    </div>
  </div>
</div>

</div></div>
<!-------------- Modal National ID Close-------------->
<div class="modal fade" id="ViewTrackLostDeviceModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Track Lost/Stolen Device Details</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <div class="content-container">
            <form id="stolenFormID" action="">
              <h4><spring:message code="stolen.heading2" /></h4>
                <div class="form-row">
                   <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.contact1" /> <span class="star"></span></label>

                        <input readonly="readonly" type="text" class="form-control" id="stolenMobile1" />
									<input type="text" class="form-control" id="stolenMgmtid"  style="display: none">
									<input type="text" class="form-control" id="stolenMgmtRequestid"  style="display: none">
                        </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.IMEI1" /> <span class="star">*</span></label>
                        <input readonly="readonly" type="text" class="form-control" id="stolenIMEI1" />
			   		</div>
			   		 <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.IMEI2" /> <span class="star"></span></label>
                        <input readonly="readonly" type="text" class="form-control" id="stolenIMEI2" />
			   		</div>


                </div>
                 <div class="form-row">
                  <div class="form-group col-md-6">
                      <label for=""><spring:message code="stolen.IMEI3" /> <span class="star"></span></label>
                      <input readonly="readonly" type="text" class="form-control" id="stolenIMEI3"  />
                    </div>

                     <div class="form-group col-md-6">
                      <label for=""><spring:message code="stolen.IMEI4" /> <span class="star"></span></label>
                      <input readonly="readonly" type="text" class="form-control" id="stolenIMEI4"   maxlength="16"/>
                    </div>
              </div>

              <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.deviceBrand" /> <span class="star">*</span></label>
                        <input readonly="readonly" type="text" class="form-control" id="stolenDeviceBrand" required >
                      </div>

                       <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.deviceModel" /> <span class="star">*</span></label>
                        <input readonly="readonly" type="text" class="form-control" id="stolenDeviceModel" required >
                      </div>


                </div>

                <div class="form-row">
					<div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.devicePurchaseInvoice" /> </label>
                       <%--  <input disabled="disabled" type="file" id="stolenMobileInvoice"  class="input-file mb-1" accept="image/*,.pdf">
                        <p><small><spring:message code="stolen.invoiceType" /></small></p> --%>
                         <div class="file-path-wrapper flexIcon">
							<input readonly="readonly" class="form-control mr-10"
								id="fileNameEdit" type="text">
								 <a href="#" id="stolenPreviewID" style="margin-top: 6px;">
								 <img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid">
								 </a>
						</div>
                      </div>
                       <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.category" /> <span class="star">*</span></label>
                        <!-- <select class="form-control" id="category"  required="required">

                      </select> -->
                      	 <input readonly="readonly" type="text" class="form-control" id="category"  >
                      </div>
                </div>
                 <h4><spring:message code="stolen.InfoHeading" /></h4>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.date" /> <span class="star">*</span></label>
                        <input readonly="readonly" type="date"  id="stolenDate" class="form-control text-uppercase" required >
                      </div>

                      <div class="form-group col-md-6">
                        <label for=""><spring:message code="stolen.time" /> <span class="star">*</span></label>
                        <input readonly="readonly" type="time" id="stolenTime" class="form-control text-uppercase" required >
                      </div>
				</div>

                <div class="form-row">

                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.provinceCity" /> <span class="star">*</span></label>
                        <!-- <select class="form-control" id="provinceCity" onchange="getDistrict('provinceCity')" required="required">

                      </select> -->
                      	 <input readonly="readonly" type="text" class="form-control" id="provinceCity"  >
                      </div>

                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.district" /> <span class="star">*</span></label>
                       <!--  <select class="form-control" id="district" required="required" onchange="getCommune('district')">

                      </select> -->
                      		 <input readonly="readonly" type="text" class="form-control" id="district"  >
                      </div>


                </div>

                <div class="form-row">

                    <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.commune" /> <span class="star">*</span></label>
                        <!-- <select class="form-control" id="commune" required="required" onchange="getPolice('commune')">

                      </select> -->
                       <input readonly="readonly" type="text" class="form-control" id="commune"  >
                      </div>
                      <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.policeStation" /> <span class="star">*</span></label>
                        <!-- <select class="form-control" id="policeStation" required="required">
                        </select> -->

                        <input readonly="readonly" type="text" class="form-control" id="policeStation"  >
                      </div>
                  </div>

                 <h4><spring:message code="stolen.heading2" /></h4>
                <div class="form-row">
                   <div class="form-group col-md-6">
                        <label for=""><spring:message code="lost.Nationality" /> <span class="star">*</span></label>
                       <!--  <select class="form-control" id="ownerNationality" required="required" onchange="chooseNationality()">

                      </select> -->
                      		<input readonly="readonly" type="text" class="form-control" id="ownerNationality"  >
                      </div>
                </div>
 				<h4><spring:message code="stolen.personalInfo" /></h4>
                <div class="form-row">
                  <div class="form-group col-md-6">
                      <label for=""><spring:message code="stolen.owner" /> <span class="star">*</span></label>
                      <input readonly="readonly" type="text" required class="form-control" id="stolenOwner" />
                    </div>

                    <div class="form-group col-md-6" id="ownerEmailDiv" >
                      <label for=""><spring:message code="stolen.email" /> <span class="star">*</span></label>
                      <input readonly="readonly" type="text" class="form-control" id="stolenEmail" required />
                    </div>


                    <div class="form-group col-md-6" id="ownerDOBlDiv" style="display: none">
                        <label for=""><spring:message code="stolen.ownwerDOB" /> <span class="star">*</span></label>
                        <input readonly="readonly" type="date"  id="ownerDOB" class="form-control text-uppercase" >
                      </div>



              </div>
			<div class="form-row">
			 <div class="form-group col-md-6">
                      <label for=""><spring:message code="stolen.Address1" /> <span class="star">*</span></label>
                      <input readonly="readonly" type="text" required class="form-control" id="stolenOwnerAddress1" />
                    </div>

                <div class="form-group col-md-6">
                    <label for=""><spring:message code="stolen.Address2" />  </label>
                    <input readonly="readonly" type="text" class="form-control" id="stolenOwnerAddress2" />
                  </div>
			</div>
			<div class="form-row">
                <div class="form-group col-md-6" id="ownerNIDdiv">
                  <label for=""> <spring:message code="stolen.nid" />  <span class="star">*</span></label>
                  <input readonly="readonly" type="text"  required class="form-control" id="stolenOwnerNID" />
             </div>

                <div class="form-group col-md-6" id="ownerPassportDiv" style="display:none">
                  <label for=""> <spring:message code="stolen.passport" />  <span class="star">*</span></label>
                  <input readonly="readonly" type="text"  class="form-control" id="stolenOwnerPassport" />
                </div>

                <div class="form-group col-md-6" id="otpContactDiv">
                  <label for=""><spring:message code="stolen.OTPContact" /> <span class="star">*</span></label>
                  <input readonly="readonly" type="text" required class="form-control" id="stolenOwnerOTPContact" />
                </div>

                <div class="form-group col-md-6" id="otpEmailDiv" style="display:none">
                      <label for=""><spring:message code="stolen.email" /> <span class="star">*</span></label>
                      <input readonly="readonly" type="text" class="form-control" id="stolenOtpEmail"/>
                    </div>
          	</div>
        	<div class="form-row">
          		<div class="form-group col-md-6">
            	<label for=""><spring:message code="stolen.nidUpload" /> <span class="star"></span></label>
            	<%-- <input disabled="disabled" type="file"  class="input-file mb-1" id="stolenOwnerNIDfile" accept="image/*,.pdf">
            	<p><small><spring:message code="stolen.complaintCopyType" /></small></p> --%>
            	 <div class="file-path-wrapper flexIcon">
							<input readonly="readonly" class="form-control mr-10 "
								id="fileNameEdit2" type="text">
								 <a href="#" id="stolenPreviewID2" style="margin-top: 6px;">
								 	<img src="./resources/assets/images/eye-icon.svg" alt="icon" class="img-fluid">
								 </a>
						</div>
			 	</div>
      		</div>
		</form>
        </div>
        </div>
        </div>
      </div>
  </div>
  <!-- Modal View close-->

 	<div class="modal fade" id="noRecordMessage" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">

               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Track Lost/Stolen Device Details</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" onclick="ResetModel()" class="cross">&times;</span>
                  </button>
               </div>
               <div class="modal-body prl-30">
                   <div class="form-group col-md-12" style="text-align: center;">
                        <h4>Request Number Not Found</h4>
                    </div>
               </div>
         </div>
      </div>
   </div>

 <!-- Priview -->

 	<div class="modal fade" id="viewuplodedModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="closeModal1()" >
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<img src="" id="fileSource" width="100%" >
				</div>
			</div>
		</div>
	</div>
 <!-- Priview END -->

   <!--materialize js-->
   <script type="text/javascript"
      src="${context}/resources/plugins/materialize.js"></script>
   <script src="${context}/resources/assets/js/custom.js"></script>
   <!-- chartist -->
   <script type="text/javascript" src="${context}/resources/project_js/globalVariables.js?version=<%= (int) (Math.random() * 10) %>"></script>
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
      src="${context}/resources/project_js/backbutton.js"></script>
   <script type="text/javascript"
      src="${context}/resources/project_js/dragableModal.js"></script>
   <script type="text/javascript"
      src="${context}/resources/project_js/enterKey.js"></script>
   <script type="text/javascript"
         src="${context}/resources/project_js/addressDropdowns_2.js?version=<%= (int) (Math.random() * 10) %>"></script>
   <script type="text/javascript"
      src="${context}/resources/project_js/viewBulkStolenDeviceDetail.js?version=<%= (int) (Math.random() * 10) %>"></script>
   <script type="text/javascript"
         src="${context}/resources/project_js/otp.js?version=<%= (int) (Math.random() * 10) %>"></script>

   <script type="text/javascript"
         src="${context}/resources/project_js/globalVariables.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script type="text/javascript"
      src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
   <script type="text/javascript"
      src="" async></script>
   <script type="text/javascript"
      src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
   <script type="text/javascript"
      src="${context}/resources/ajax/keyBoardShortcut.js?version=<%= (int) (Math.random() * 10) %>"></script>
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