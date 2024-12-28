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
                        <!-- Security Tags -->
                        <%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
                            <sec:csrfMetaTags />
                            <!-- Security Tags -->
                            <c:set var="context" value="${pageContext.request.contextPath}" />
                            <html lang="en" class="no-js">

                            <head>
                                <meta http-equiv='cache-control' content='no-cache'>
                                <meta http-equiv='expires' content='-1'>
                                <meta http-equiv='pragma' content='no-cache'>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
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
                                    <script type="text/javascript" src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
                                    <script type="text/javascript">
                                        var path = "${context}";
                                    </script>
                                    <link rel="stylesheet" href="${context}/resources/custom_js/jquery-ui.css">
                                    <script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
                                    <link href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css" type="text/css" rel="stylesheet" media="screen,projection">
                                    <!-- CSS for icons(to remove later) -->
                                    <link rel="stylesheet" href="${context}/resources/assets/css/iconStates.css">
                                    <link href="${context}/resources/font/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet" media="screen,projection">
                                    <!-- CORE CSS-->
                                    <link rel="stylesheet" href="${context}/resources/assets/css/style.css">
                                    <script>
                                        var contextpath = "${context}";
                                    </script>
                            </head>

                            <body data-roleType="${usertype}" data-featureId="${featureId}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}" data-selected-username="${username}" data-transactionId="${transactionId}" data-stolenselected-roleType="${stolenselectedUserTypeId}" data-timeout="<spring:eval expression="@environment.getProperty('otp-timeout')" />">

                                <body>
                                    <div class="content-box" id="contentBox">
                                        <div class="content-container" id="datatableViewDiv">
                                            <div id="initialloader"></div>
                                            <div class="content-header" id="pageHeader">
                                                <h1 id="pageHeaderTitle">Stolen IMEI Status Check</h1>
                                                <div class="toggle-row ml-auto mr-4">
                                                </div>
                                            </div>
                                            <div class="filter-box" id="filterBox">
                                                <form action="" class="filter-row" id="filterform">
                                                    <div id="errorMsgDiv" class="filter-form-row" style="width: 100%;"></div>
                                                    <div id="dataTableDiv" class="filter-form-row"></div>
                                                    <div id="filterButtonDiv" class="filter-btn-row"></div>
                                                    <div id=textbox-container> </div>
                                                </form>
                                            </div>
                                            <div id="LibraryTableDiv" class="table-box">
                                                <div class="table-responsive visibleScroll">
                                                    <table id="LibraryTable" class="table">
                                                        <thead class="thead-dark"></thead>
                                                    </table>
                                                </div>
                                                <div id="footerBtn" class="table-paginationbox"> </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="Validate-form" id="verifyOtpForm" style="display:none">
                                        <div class="UnBlock" style="padding-top: 1px !important;">
                                            <h1 class="mb-4 mb-70">
                 <spring:message code="OTP.heading" />
              </h1>
                                            <h6 class="mb-4">
                 <spring:message code="OTP.verficationequest" />
              </h6>
                                            <h6 class="mb-2">
                 <spring:message code="OTP.verficationequest1" />
              </h6>
                                            <P id="phoneNumberOTP">
                                                <spring:message code="OTP.verficationequest2" />
                                            </P>
                                            <P id="emailOTPMsg" style="display:none">
                                                <spring:message code="OTP.emailMsg" />
                                            </P>
                                            <div class="Validate-box" style="width: calc(80% - 0%) !important;">
                                                <form onsubmit="return submitOTPRequest()" action="">
                                                    <div class="form-group text-center mt-20" id="inputs">
                                                        <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox1" maxlength=1>
                                                        <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox2" maxlength=1>
                                                        <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox3" maxlength=1>
                                                        <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox4" maxlength=1>
                                                        <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox5" maxlength=1>
                                                        <input class="otp" autocomplete="off" type="text" required oninput='digitValidate(this)' id="OtpBox6" maxlength=1>
                                                        <input type="text" id="OTPRequestId" style=display:none>
                                                        <div class="col-md-12 text-left timer" style="margin-top: 20px !important;width: 430px; margin: auto;">
                                                            <a href="#" id="resendOTPclick">
                                                                <spring:message code="OTP.resend" />
                                                            </a>
                                                            <p id="resendOTPclick_time">
                                                                <spring:message code="OTP.timeDuration" />
                                                                <span id="countdown"></span>
                                                            </p>
                                                        </div>
                                                        <%-- <div class="col-md-3"> <a href="ForgotTicket.html" class="btn-block text-right"><spring:message code="OTP.back" /></a></div> --%>
                                                    </div>
                                                    <%-- <button type="button" class="btn cancel-btn"><spring:message code="OTP.back" /></button> --%>
                                                        <div class="no-border center">
                                                            <a href="./imeiStatusCheck" class="btn cancel-btn">
                                                                <spring:message code="OTP.back" />
                                                            </a>
                                                            <button type="submit" class="btn save-button-dark">
                                                                <spring:message code="OTP.verify" />
                                                            </button>
                                                        </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="Status-form" style="display:none" id="successOTPScreen">
                                        <div class="UnBlock" style="padding-top: 1px !important;">
                                            <p><img src="${context}/resources/assets/images/check.png" alt="logo" class="img-fluid"></p>
                                            <h1 style="font-size: 2rem !important;margin-top: 15px;">
              <spring:message code="verifyOTPOTP.h1Msg" />
            </h1>
                                            <p id="verifyOTPrequestid">
                                                <spring:message code="verifyOTPOTP.p1Msg" />
                                            </p>
                                            <p>
                                                <spring:message code="verifyOTPOTP.p2Msg" /> .
                                                <br>
                                                <spring:message code="verifyOTPOTP.p3Msg" />
                                            </p>
                                            <a href="./policeTrackLostDevice" class="btn save-button-dark" style="margin-top: 20px;">
                                                <spring:message code="Stolen.done" />
                                            </a>
                                        </div>
                                    </div>
                                    <!-- Modal View-->


                                    <!--------- model for file format ---->
                                    <div class="modal fade modalBackdrop hidden" data-toggle="modal fade" data-target="123318911" id="fileFormateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true" style="display:none">
                                        <div class="modal-dialog modal-sm transform-10" id="1233189" role="document">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <button type="button" class="alert-close close" onclick="closeModal('invalidMobileNumber')" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span> </button>
                                                    <p class="Rejected">
                                                        <h6 id="fileErrormessage1">
                  <spring:message code="fileValidationName" />
                  <br> <br>
                  <spring:message code="fileValidationFormate" />
                  <br><br>
                  <spring:message code="fileValidationSize" />
                </h6>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--------- model for file format ---->


                                    <!------------------- Confirmation modal for Back button ---------------------------------------------------------->
                                    <div class="modal fade modalBackdrop hidden" data-toggle="modal fade" data-target="123318911" id="backButtonConfirmation" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true" style="display:none">
                                        <div class="modal-dialog modal-sm transform-10" id="1233189" role="document">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <button type="button" class="alert-close close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span> </button>
                                                    <p class="Rejected">
                                                        <h6 id="backButtonConfirmation">
                  <spring:message code="backButtonConfirmation" />
                </h6>
                                                    </p>
                                                    <a href="./policeTrackLostDevice" style="width: 60px;margin-left: 109px;padding: 2px 15px 0px 16px;margin-top: 12px;                 background-color: #F19D5B;" class="btn cancel-btn">
                                                        <spring:message code="OTP.back" />
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!------------------- Confirmation modal for Back button ends here  ---------------------------------------------------------->

                                    <!--------------invalid OTP modal  -------------->
                                    <div class="modal fade modalBackdrop hidden" data-toggle="modal fade" data-target="1233189" id="invalidOTP" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true" style="display:none">
                                        <div class="modal-dialog modal-sm transform-10" id="1233189" role="document">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <button type="button" class="alert-close close" onclick="closeModal('invalidOTP')" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span> </button>
                                                    <p class="Rejected">
                                                        <spring:message code="input.invalidOTP1" />
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--------------invalid OTP modal  -------------->

                                    <!-------------- modal OTP limit exceed -------------->
                                    <div class="Status-form" style="display:none" id="otplimitExceed">
                                        <div class="UnBlock">
                                            <p class="Rejected"><img src="${context}/resources/assets/images/limitaccess.png" alt="logo" class="img-fluid"></p>
                                            <h1>
              <spring:message code="verifyOTPOTP.limitExceed" />
            </h1>
                                            <button type="submit" onclick="viewSaveForm('stolenFormBlock')" class="btn save-button-dark">
                                                <spring:message code="OTP.back" />
                                            </button>
                                        </div>
                                    </div>
                                    <%-- <div class="sidear-footer"><spring:message code="stolen.copyright" /></div> --%> </div>

                                        <!-------------- modal limit exceed -------------->

<!-------------- modal OTP Resend limit exceed -------------->
<div class="modal fade modalBackdrop hidden" data-toggle="modal fade" data-target="1233111" id="otplimitExceedUpdated" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle1" aria-hidden="true" style="display:none">
    <div class="modal-dialog modal-sm transform-10" id="1233111" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="alert-close close" onclick="closeModal('otplimitExceed')" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true"><img src="${context}/resources/assets/images/close.png" alt="close"></span> </button>
                <p class="Rejected">
                    <spring:message code="ir.otpResendLimit" />
                 </p>
            </div>
        </div>
    </div>
</div>
<!-------------- modal OTP Resend limit exceed closed -------------->


                                        <div id="initiateRecoveryModel" class="modal" tabindex="-1" role="dialog">
                                            <div class="modal-dialog modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Initiate Recovery</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                <span aria-hidden="true">&times;</span>
                                                                              </button>
                                                    </div>
                                                    <div class="modal-content_">
                                                        <form action="" onsubmit="return submitRecovery()">
                                                            <div class="modal-body">
                                                                <div class="form-row">
                                                                    <input type="text" autocomplete="off" id="unblockRequestId" hidden>
                                                                    <div class="form-group col-md-6">
                                                                        <label for="">
                                                                            <spring:message code="recovery.Reason" /> <span class="star">*</span></label>
                                                                        <textarea class="form-control" id="recoveryReason" rows="2" maxlength="500" placeholder="<spring:message code="placeholder.incident" />" title=" " oninput="validateTextarea(this,'stolenLostButton','error-message','<spring:eval expression='@environment.getProperty(\"
                                                                        pattern.Incident\ ")'/>')" required></textarea>
                                                                    </div>

                                                                    <div class="form-group col-md-6">
                                                                        <label for="">
                                                                            <spring:message code="stolen.Remark" />
                                                                            <span class="star">*</span>
                                                                        </label>
                                                                        <textarea class="form-control" id="recoveryRemark" rows="2" maxlength="500" placeholder="<spring:message code="ir.enterRemark" />" title=" "
                                                                        oninput="validateTextarea(this,'stolenLostButton','error-message','<spring:eval expression='@environment.getProperty(\"
                                                                        pattern.Incident\ ")'/>')" required></textarea>
                                                                    </div>
                                                                </div>

                                                                <h4><spring:message code="recovery.Place" /></h4>

                                                                <div class="form-row">
                                                                    <div class="form-group col-md-6">
                                                                        <label for="">
                                                                            <spring:message code="recovery.date" /> <span class="star">*</span></label>
                                                                        <input type="date" id="recoveryStolenDate" class="form-control text-uppercase" required>
                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label for="">
                                                                            <spring:message code="stolen.time" />
                                                                        </label>
                                                                        <input type="time" id="recoveryStolenTime" class="form-control text-uppercase">
                                                                    </div>
                                                                </div>

                                                                <div class="form-row">
                                                                    <div class="form-group col-md-6">
                                                                        <label for="">
                                                                            <spring:message code="lost.provinceCity" /> <span class="star">*</span></label>
                                                                        <select class="form-control" id="recoveryProvinceCity"
                                                                         onchange="getDistrict('recoveryProvinceCity')" required>
                                                                            <option value="" selected>
                                                                                <spring:message code="select.provinceCity" /> </select>
                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label for="">
                                                                            <spring:message code="lost.district" /> <span class="star">*</span></label>
                                                                        <select class="form-control" id="recoveryDistrict"
                                                                        onchange="getCommune('recoveryDistrict')" required>
                                                                        <option value="" selected>
                                                                                <spring:message code="select.LostDistrict" /> </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-md-6">
                                                                        <label for="">
                                                                            <spring:message code="lost.commune" /> <span class="star">*</span></label>
                                                                        <select class="form-control" id="recoveryCommune"
                                                                        onchange="getPolice('en')" required>
                                                                          <option value="" selected>
                                                                                <spring:message code="select.LostCommune" /> </select>
                                                                    </div>
                                                                </div>

                                                                <div class="row">
                                                                    <div class="col-lg-12">
                                                                        <div class="no-border flex-end">
                                                                            <a href="./imeiStatusCheck?FeatureId=112" class="btn cancel-btn">
                                            Reject
                                        </a>
                                                                            <button type="submit" id="recoveryFormButton" class="btn save-button-dark">
                                                                                Approve
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                    </div>
                                                </div>
                                                </form>
                                            </div>
                                        </div>
                                        </div>
                                         <div class="modal fade" id="saveConfirmationMessage" role="dialog"><div class="modal-dialog modal-sm"><div class="modal-content success-popup"><div class="modal-body"><p><img src="${context}/resources/assets/images/check.svg" alt="" class="">  <spring:message code="modal.requestOtpResent" /></p></div></div></div></div>

                                        <div class="Status-form" style="display:none" id="successScreen">
                                            <div class="UnBlock" style="padding-top: 1px !important;">
                                                <p><img src="${context}/resources/assets/images/check.png" alt="logo" class="img-fluid"></p>
                                                <h1 style="font-size: 2rem !important;margin-top: 15px;"><spring:message code="verifyOTPOTP.h1Msg" /> </h1>
                                                <p id="referenceRequestid">
                                                    <spring:message code="verifyOTPOTP.p1Msg" /> </p>
                                                <p>
                                                    <spring:message code="verifyOTPOTP.p2Msg" />.
                                                    <br> Request for Initiate recovery is accepted successfully.
                                                </p>
                                                <a href="./imeiStatusCheck?FeatureId=112" class="btn save-button-dark" style="margin-top: 20px;">
                                                    <spring:message code="Stolen.done" />
                                                </a>
                                            </div>
                                        </div>

                                        <div id="viewStolenModal" class="modal" tabindex="-1" role="dialog">
                                            <div class="modal-dialog modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">View</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-content_">
                                                        <div class="modal-body">
                                                            <div class="form-row">
                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.requestId" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryRequestId" class="form-control" readonly>
                                                                </div>

                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.contactNumber" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryContactNumber" class="form-control" readonly>
                                                                </div>
                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.name" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryName" class="form-control" readonly>
                                                                </div>

                                                            </div>

                                                            <div class="form-row">

                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.address" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryAddress" class="form-control" readonly>
                                                                </div>

                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.commune" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryCommune" class="form-control" readonly>
                                                                </div>

                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.policeStation" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryPoliceStation" class="form-control" readonly>
                                                                </div>
                                                            </div>

                                                            <div class="form-row">

                                                            </div>
                                                            <div class="form-row">
                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.RequestMode" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryRequestMode" class="form-control" readonly>
                                                                </div>
                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.recordCount" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryRecordCount" class="form-control" readonly>
                                                                </div>
                                                                <div class="form-group col-md-4">
                                                                    <label for="">
                                                                        <spring:message code="ir.imeiFoundCount" />
                                                                    </label>
                                                                    <input type="text" id="viewRecoveryImeiFoundCount" class="form-control" readonly>
                                                                </div>
                                                            </div>
                                                           <div class="table-box TableBorder">
                                                                               <table id="viewStolenTable" class="table" style="white-space: normal;">
                                                                                   <thead class="thead-dark">
                                                                                       <tr>
                                                                                       <th>Lost/Stolen IMEI List</th>
                                                           							    <th>Matched IMEI List</th>
                                                           								</tr>
                                                                                   </thead>
                                                                                   <tbody>
                                                                                   </tbody>
                                                                               </table>
                                                                           </div>
                                                           </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </div>

                       <!---------- Notification Sent Modal ---------->
                                        <div class="modal fade" id="notificationSuccessModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                              <div class="modal-content">
                                                <div class="modal-body Bulk">
                                                                      <div class="form-row">
                                                                        <div class="form-group col-md-12 center">
                                                                          <p><img src="${context}/resources/assets/images/tick-circle.svg" alt="Check"></p>
                                                                            <p>Notification Submitted Successfully</p>
                                                                          </div>
                                                                    </div>

                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                      <p class="center"><button type="submit" onclick="closeModel('notificationSuccessModel')" class="btn lightorange" data-dismiss="modal" aria-label="Close">Done</button></p>
                                                                      </div>
                                                                    </div>
                                              </div>
                                              </div>
                                            </div>
                                          </div>

                                <!---------- Notification failed Modal ---------->
                                <div class="modal fade" id="notificationFailedModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                      <div class="modal-content">
                                        <div class="modal-body Bulk">
                                                              <div class="form-row">
                                                                <div class="form-group col-md-12 center">
                                                                  <p><img src="${context}/resources/assets/images/fi-rr-cross.svg" alt="Check"></p>
                                                                    <p>Contact Number Not Exists</p>
                                                                  </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                              <p class="center"><button type="submit" onclick="closeModel('notificationFailedModel')" class="btn lightorange" data-dismiss="modal" aria-label="Close">Done</button></p>
                                                              </div>
                                                            </div>
                                      </div>
                                      </div>
                                    </div>
                                  </div>
                                </body>


                                <!--materialize js-->
                                <script type="text/javascript" src="${context}/resources/plugins/materialize.js"></script>
                                <script type="text/javascript" src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

                                <!-- chartist -->
                                <script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
                                <!-- i18n library -->
                                <script type="text/javascript" src="${context}/resources/project_js/CLDRPluralRuleParser.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/i18n.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/messagestore.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/fallbacks.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/language.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/parser.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/emitter.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/bidi.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/history.js"></script>
                                <script type="text/javascript" src="${context}/resources/i18n_library/min.js"></script>


                                <script type="text/javascript" src="${context}/resources/project_js/otp.js?version=<%= (int) (Math.random() * 10) %>"></script>
                                <script type="text/javascript" src="${context}/resources/project_js/viewStolenIMEIStatus.js?version=<%= (int) (Math.random() * 10) %>"></script>
                                <script type="text/javascript" src="${context}/resources/project_js/addressDropdowns_2.js?version=<%= (int) (Math.random() * 10) %>"></script>
                                <script type="text/javascript" src="${context}/resources/project_js/globalVariables.js?version=<%= (int) (Math.random() * 10) %>"></script>

                                <script type="text/javascript" src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>

                                <script type="text/javascript" src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>

                                <%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout =
                                    <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function
                                        (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime
                                        + timeout;}});});</script> --%>
                                        <script type="text/javascript">
                                            var countHit="";  $( document ).ready(function() {  if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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