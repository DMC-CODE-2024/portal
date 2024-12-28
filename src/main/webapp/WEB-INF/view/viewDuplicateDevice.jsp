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
      data-stolenselected-roleType="${stolenselectedUserTypeId}"
      data-featureId="${featureId}" >
      <body>
         <div class="content-box">
            <div class="content-container" id="datatableViewDiv">
               <div id="initialloader"></div>
               <div class="content-header" id="pageHeader">
                  <h1 id="pageHeaderTitle"></h1>
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
   
   <!-- Modal View-->
<div class="modal fade" id="ViewApprovedModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Approved Status</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <div class="content-container">
                <div class="filter-box pd-tb-20 pd-b20">
                    <form action="" class="filter-row">
                        <div class="form-input-row modalPopup modal-gap">
                            <div class="form-group">
                                <label>Detection Date</label>
                                <input type="text" id="viewDetectionDate" class="form-control" readonly="">
                            </div>
                            <div class="form-group">
                                <label>IMEI</label>
                                <input type="text" id="viewIMEI" class="form-control" readonly="">
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="text" id="viewPhoneNumber" class="form-control" readonly="">
                            </div>
                            <div class="form-group">
                                <label>Updated By</label>
                                <input type="text" id="viewUpdatedBy" class="form-control" readonly="">
                            </div>
                            <div class="form-group">
                                <label>Status</label>
                                <input type="text" id="viewStatus" class="form-control" readonly="">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="table-box TableBorder">
                    <table id="viewApproveTable" class="table" style="white-space: normal;">
                        <thead class="thead-dark">
                            <tr>
                                <th>Name</th>
								<th>Type</th>
								<th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <%-- <center><p class="pd-30">These are the Document Type uploaded by EIRS Admin</p></center> --%>
            </div><!--close-->
        </div>
      </div>
  </div>
  </div>
  <!-- Modal View close--> 
  
 <!-- Modal Approve-->
<div class="modal fade" id="approvefileModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Approve Status</h5>
          <button type="button" class="close" onclick="resetApproveModel()" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <div class="form-content">
                <form id="duplicateApproveForm" onsubmit="return approveDuplicate()"
				method="POST" enctype="multipart/form-data">
                
                <div id="imeiContainer">
                	<div class="form-row document-row">
                        <div class="form-group col-md-5">
                            <label for="">Document Type <span class="star">*</span></label>
                            <select id="docTypetag1" class="form-control" onchange="enableFileInput()" required>
                                <option value="" >Select Document Type</option>
                            </select>
                          </div>
							<p id="rowId" style="display: none;"></p>	
                          <div class="form-group col-md-5">
                            <label for="">Browse File <span class="star">*</span></label>
                            <input class="input-file mb-1 " type="file" name="files" id="docTypeFile1" 
                            oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');" 
                            accept=".png, .jpg, .jpeg, .pdf" size="2097152" required>
                          </div>

                          <div class="form-group col-md-2">
                            <label for="" class="mt-38"><a href="#" onclick="add_field_button()" class="addImei">+ More</a></label>
                          </div>
                    </div>
                    
                 </div>
   					
   					<div class="form-row">
						<div class="form-group col-md-12">
						<label for="">Remarks</label>
						<textarea class="form-control" placeholder="Write any remarks (if any)" maxlength="150" rows="3" id="approveRemark"></textarea>
						</div>
					</div>
	
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="">Maximum 4 document can be updated.</label>
                          </div>
                    </div>

                  <div class="row">
                    <div class="col-lg-12 mr-tb-40">
                        <div class="no-border center">
                            <button type="submit" id="submitButton" class="btn Submit-button" >Approve</button>
                            
                        </div>
                    </div>
                </div> 
    
                  </form>
            </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal Approve close-->

<!-- Save Modal -->
        <div class="modal fade" id="saveConfirmationMessage" role="dialog">
          <div class="modal-dialog modal-sm">
            <div class="modal-content success-popup">
              <div class="modal-body">
                <p><img src="${context}/resources/assets/images/check.svg" alt="" class="">  Device Approved successfully.</p>
              </div>
              
            </div>
          </div>
        </div>
        <!-- Save Modal close-->
        
        
 <!-- Save Modal -->
        <div class="modal fade" id="fileLimitExceedModel" role="dialog">
          <div class="modal-dialog modal-sm">
            <div class="modal-content success-popup">
              <div class="modal-body">
                <p><img src="${context}/resources/assets/images/check.svg" alt="" class="">  Device Approved successfully.</p>
              </div>
              
            </div>
          </div>
        </div>
        <!-- Save Modal close-->       
   
 <!-- view pdf -->
  <div class="modal fade" id="viewApprovedDocument" onclick="resetImage()" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">View</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <img src="" alt="icon" class="img-fluid">
        </div>

      </div>
    </div>
  </div>
  <!-- view pdf close -->  
   
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
      src="${context}/resources/project_js/viewDuplicateDevice.js?version=<%= (int) (Math.random() * 10) %>"></script>
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