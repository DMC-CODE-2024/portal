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
      <script>
         var contextpath = "${context}";
      </script>
   </head>
   <body data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}"
      data-selected-roleType="${selectedUserTypeId}"
      data-selected-username="${username}"
      data-featureId="${featureId}"
      data-stolenselected-roleType="${stolenselectedUserTypeId}">
      <body>
         <div class="content-box" id="contentDiv">
            <div class="content-container" id="datatableViewDiv">
               <div id="initialloader"></div>
               <div class="content-header" id="pageHeader">
                  <h1 id="pageHeaderTitle"></h1>
                  <button type="button" id="upload" class="btn btn-outline-dark mr-2" onclick="upload()" style="width: auto;"> + New Search (Recovery) </button>
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
                  <div class="table-responsive">
                     <table id="LibraryTable" class="table">
                        <thead class="thead-dark"></thead>
                     </table>
                  </div>
                  <div id="footerBtn" class="table-paginationbox"> </div>
               </div>
            </div>
         </div>


   </body>

    <div class="modal fade" id="NewRequest" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLabel">New Search (Recovery)</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                    <div class="modal-body_">
                        <div class="product-detail-section">
                            <div class="row">
                                <div class="col-md-12">
                                    <ul class="nav nav-tabs product-tabs border-0">
                                        <li><a data-toggle="tab" href="#tab1" class="active">Single</a></li>
                                        <li><a data-toggle="tab" href="#tab2">Bulk</a></li>
                                    </ul>

                                    <div class="tab-content">
                                        <div id="tab1" class="tab-pane active">

                                           <div class="RequestForm">
                                            <form id="form1" action="" onsubmit="return singleRequest()">
                                                <div class="form-group row">
                                                  <label for="tac" class="col-sm-3 col-form-label">IMEI 1<span class="star">*</span></label>
                                                  <div class="col-sm-9">
                                                    <input type="" class="form-control" id="form1-imei1"  maxlength="15"
                                                     pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
                                                     oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                     oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                     placeholder="Enter IMEI" required>

                                                  </div>
                                                </div>

                                                  <div class="form-group row">
                                                    <label for="inputPassword3" class="col-sm-3 col-form-label">IMEI 2 </label>
                                                    <div class="col-sm-9">
                                                            <input type="" class="form-control" id="form1-imei2"  maxlength="15"
                                                             pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
                                                             oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                             oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                             placeholder="Enter IMEI">
                                                     </div>
                                                  </div>
                                                  <div class="form-group row">
                                                    <label for="inputPassword3" class="col-sm-3 col-form-label">IMEI 3 </label>
                                                    <div class="col-sm-9">
                                                              <input type="" class="form-control" id="form1-imei3"  maxlength="15"
                                                               pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
                                                               oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                               oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                               placeholder="Enter IMEI">
                                                     </div>
                                                  </div>
                                                  <div class="form-group row">
                                                    <label for="inputPassword3" class="col-sm-3 col-form-label">IMEI 4</label>
                                                   <div class="col-sm-9">
                                                                <input type="" class="form-control" id="form1-imei4"  maxlength="15"
                                                                 pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
                                                                 oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                  placeholder="Enter IMEI">
                                                        </div>
                                                  </div>
                                                  <div class="form-group row">
                                                                  <label for="inputPassword3" class="col-sm-3 col-form-label">Remark<span class="star"> *</span></label>
                                                                  <div class="col-sm-9">
                                                                  <textarea class="form-control"  maxlength="250" id="form1-remarks" placeholder="Enter Remarks if any" rows="2" required></textarea>
                                                              </div>
                                                  </div>
                                                <div class="form-group row">
                                                  <div class="col-sm-12 center">
                                                    <button type="submit" id="form1-submit" class="btn Submit-button">Submit</button>
                                                  </div>
                                               <span id="errorDiv" class=""></span></div>
                                              </form>
                                            </div>
                                        </div>
                                        <div id="tab2" class="tab-pane fade">
                                            <div class="RequestForm">
                                                <form id="form2" action="" onsubmit="return bulkRequest()">
                                                      <div class="form-group row">
                                                       <label for="" class="col-sm-3 col-form-label">Upload IMEI File <span class="star">*</span></label>
                                                        <div class="col-sm-12">
                                                            <input type="file" accept=".csv" class="input-file mb-1"  id="fileInput"
                                                            oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');" onchange="validateFile(this,'CSV_ALLOWED');" required>
                                                            <p><a href="#" onclick=" if(typeof sampleFileDownloadById === 'function')  sampleFileDownloadById('112','sample_sts')"><img src="${context}/resources/assets/images/download-icon-blue.svg" alt="icon" title="TA file" class="img-fluid"><small> Download Sample File </small></a></p>

                                                        </div>
                                                      </div>
                                                    <div class="form-row">
                                                                          <div class="form-group col-md-12 mb-4">
                                                                             <label for="">Remark <span class="star"> *</span></label>
                                                                             <textarea class="form-control" id="form2-remarks" rows="2" maxlength="250" placeholder="Write any remarks (if any)" required></textarea>
                                                                          </div>
                                                    </div>

                                                    <div class="form-group row">
                                                      <div class="col-sm-12 center">
                                                      <button type="submit" id="form2-submit" class="btn Submit-button">Upload</button>
                                                      </div>
                                                        <div id="form2-errorDiv" class="filter-form-row" style="width: 100%;color: red;font-size: 15px;left: 23px;margin: 0;"></div>

                                                    </div>
                                                </div>
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                  </div>
                </div>
    </div>


    <div class="Status-form" style="display:block" id="newRecoverySuccessScreen">
                      <div class="UnBlock" style="padding-top: 1px !important;">
                                 <p><img src="${context}/resources/assets/images/check.png" alt="logo" class="img-fluid"></p>
                                          <h1 style="font-size: 2rem !important;margin-top: 15px;"><spring:message code="verifyOTPOTP.h1Msg" /> </h1>
                                              <p id="recoveryTransactionId">
                                                    <spring:message code="verifyOTPOTP.p1Msg" />
                                              </p>
                                              <p>
                                                     <spring:message code="verifyOTPOTP.p2Msg" />.
                                                     <br>  <spring:message code="ir.recoveryRequestSuccess" />
                                              </p>
                                              <a href="./imeiStatusCheck?FeatureId=112" class="btn save-button-dark" style="margin-top: 20px;">
                                                            <spring:message code="Stolen.done" />
                                              </a>
                      </div>
         </div>

    <div class="Status-form" style="display:block" id="newRecoveryFailedScreen">
                          <div class="UnBlock" style="padding-top: 1px !important;">
                                     <p><img src="${context}/resources/assets/images/Invalid.png" alt="logo" class="img-fluid"></p>
                                              <h1 style="font-size: 2rem !important;margin-top: 15px;"><spring:message code="input.tacDeatilsInvalid" /> </h1>
                                                  <p>
                                                         <spring:message code="verifyOTPOTP.p2Msg" />
                                                         <br> <spring:message code="ir.provideCorrectDetails" />
                                                  </p>
                                                  <a href="./imeiStatusCheck?FeatureId=112" class="btn save-button-dark" style="margin-top: 20px;">
                                                                <spring:message code="Stolen.done" />
                                                  </a>
                          </div>
             </div>

   <!--materialize js-->
   <script type="text/javascript"
      src="${context}/resources/plugins/materialize.js"></script>
   <script type="text/javascript"
      src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

   <!-- chartist -->
   <script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
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
      src="${context}/resources/project_js/stolenIMEIStatusCheck.js?version=<%= (int) (Math.random() * 10) %>"></script>
   <script type="text/javascript"
      src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>

   <script type="text/javascript"
      src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>


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