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
  %> <%@ page language="java" contentType="text/html; charset=utf-8"
  pageEncoding="utf-8"%> <%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Security Tags --> <%@ taglib prefix="sec"
  uri="http://www.springframework.org/security/tags"%>
<sec:csrfMetaTags />
<!-- Security Tags -->
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
  <head>
    <title>EIRS Portal</title>
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
    <link rel="stylesheet" href="${context}/resources/assets/fonts/line-awesome/css/line-awesome.min.css">
    <link rel="stylesheet" href="${context}/resources/assets/fonts/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${context}/resources/assets/css/style.css">
    <link rel="stylesheet" href="${context}/resources/assets/css/bootstrap.min.css">
    <%-- <link
      href="${context}/resources/js/plugins/perfect-scrollbar/perfect-scrollbar.css"
      type="text/css" rel="stylesheet" media="screen,projection"> --%> <script src="${context}/resources/assets/js/jquery.min.js"></script>
    <script src="${context}/resources/assets/js/popper.min.js"></script>
    <script src="${context}/resources/assets/js/bootstrap.min.js"></script> <%-- <script src="${context}/resources/custom_js/jquery.blockUI.js"></script> --%>
    <!-- Security Tags -->
    <meta name="_csrf" content="${_csrf.token}" />
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <!-- Security Tags -->
    <script type="text/javascript" src="${context}/resources/js/plugins/jquery-1.11.2.min.js"></script>
    <script type="text/javascript">
      var path = "${context}";
    </script>

    <link rel="stylesheet"
             href="${context}/resources/custom_js/jquery-ui.css">
    <link href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
              type="text/css" rel="stylesheet" media="screen,projection">

    <!-- CSS for icons(to remove later) -->
    <link rel="stylesheet" href="${context}/resources/project_css/iconStates.css">
    <link href="${context}/resources/font/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- CORE CSS-->
    <link rel="stylesheet" href="${context}/resources/assets/css/MdrDashboard/style.css">
    <link href="${context}/resources/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
    <script src="${context}/resources/custom_js/jquery.blockUI.js"></script>
  </head>
  <body data-featureId="${featureId}" data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}" data-stolenselected-roleType="${stolenselectedUserTypeId}" data-userName="${userName}" session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}" data-session-source="${not empty param.source ? param.source : 'menu'}">
    <body>
      <div class="content-box">
        <div class="content-container" id="datatableViewDiv">
        <div class="stats-list">
             			<a class="stats-card">
                            <p>Total devices</p>
                            <h5 id="totalDeviceCount"></h5>
                        </a>
                        <a class="stats-card">
                            <p>New Devices</p>
                            <h5 id="newDeviceCount"></h5>
                        </a>
                        <a class="stats-card">
                            <p>Updated Devices</p>
                            <h5 id="updatedDeviceCount"></h5>
                        </a>
                        <a class="stats-card">
                            <p>Completed</p>
                            <h5 id="completedDeviceCount"></h5>
                        </a>
           </div>
          <div id="initialloader"></div>
          <div class="content-header" id="pageHeader">
            <h1 id="pageHeaderTitle">Latest Notifications</h1>
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
         <!------------------------------- View Div Start --------------------------->
                    <div class="content-container" id="mobileDetailViewDiv" style="display: none">
                        <div class="content-header d-flex align-items-center justify-content-between">
                            <h1 id="viewModelLabel">
                                <spring:message code="input.view" />
                            </h1>
                            <%-- <a id="editFromViewBtn" class="btn btn-outline-dark ml-auto"> <img src="${context}/resources/assets/images/edit-icon.svg" alt="icon" class="img-fluid">
                                <spring:message code="input.Edit" />
                            </a> --%>
                        </div>
                        <div class="product-box">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="pro-detail-card">
                                        <h1>
                                            <spring:message code="roletype.Manufacturer" />
                                        </h1>
                                        <p id="viewManufacturer"></p>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="pro-detail-card">
                                        <h1>
                                            Marketing Name
                                        </h1>
                                        <p id="viewMarketingname"></p>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="pro-detail-card">
                                        <h1>
                                            <spring:message code="input.TAC" />
                                        </h1>
                                        <p id="viewtac"></p>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="pro-detail-card">
                                        <h1>
                                            <spring:message code="Manufacturing.Address" />
                                        </h1>
                                        <p id="viewManAddress"></p>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="pro-detail-card">
                                        <h1>
                                            <spring:message code="table.ProductName" />
                                        </h1>
                                        <p id="viewbrand"></p>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="pro-detail-card">
                                        <h1>
                                            <spring:message code="input.modelName" />
                                        </h1>
                                        <p id="viewModel"></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="product-detail-section">
                            <div class="row">
                                <div class="col-md-8" >
                                    <ul class="nav nav-tabs product-tabs border-0">
                                        <li><a data-toggle="tab" href="#tab1" class="active">
                                                <spring:message code="input.Network" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab2">
                                                <spring:message code="input.Launch" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab3">
                                                <spring:message code="input.Body" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab4">
                                                <spring:message code="input.Display" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab11">
                                                <spring:message code="input.Platform" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab5">
                                                <spring:message code="input.Camera" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab6">
                                                <spring:message code="input.Sound" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab7">
                                                <spring:message code="input.comm" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab8">
                                                <spring:message code="input.Misc" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab9">
                                                <spring:message code="input.Price" />
                                            </a></li>
                                        <li><a data-toggle="tab" href="#tab10">
                                                <spring:message code="input.Issues" />
                                            </a></li>
                                         <li><a data-toggle="tab" href="#tab13">
                                                TRC
                                            </a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="tab1" class="tab-pane active">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.Technology" />
                                                        </h1>
                                                    </div>
                                                    <!-- <div class="col-md-8">
                                                        <p id="viewNetworktech"></p>
                                                    </div> -->
                                                    <div class="col-md-8">
                                                            <ul class="nav" style="gap: 14px;">
                                                                <li><label class="checkbox-container"> <input id="viewGSMCheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                        <spring:message code="input.GSM" />
                                                                    </label></li>
                                                                <li><label class="checkbox-container"> <input id="viewCDMACheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                        <spring:message code="input.CDMA" />
                                                                    </label></li>
                                                                <li><label class="checkbox-container"> <input id="viewEVDOCheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                        <spring:message code="input.EVDO" />
                                                                    </label></li>
                                                                <li><label class="checkbox-container"> <input id="viewLTECheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                        <spring:message code="input.LTE" />
                                                                    </label></li>
                                                                <li><label class="checkbox-container"> <input id="view5GCheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                        <spring:message code="input.5G" />
                                                                    </label></li>
                                                            </ul>
                                                        </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.2GBand" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewnetworkBand2G"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.3GBand" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewnetworkBand3G"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.4Gband" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewnetworkBand4G"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.5Gband" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewnetworkBand5G"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.NetworkSpeed" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewnetworkspeed"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.BrandDetails" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="BrandDetails"></p>
                                                    </div>
                                                </div>

                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="table.devicetype" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewDeviceType"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            Network Specific Identifier
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewNetworkIdentifier"></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="tab2" class="tab-pane fade">
                                            <div class="product-detail-list">
                                               	 <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.AnnounceDate" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8"> <input type="date" id="viewannounceDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" disabled> </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.launchdate" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8"> <input type="date" id="viewLaunchDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" disabled> </div>
                                                    </div>
                                               	<div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.devicestatus" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="viewDevicestatus" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                                <option value=""><spring:message code="dropdown.select" /></option>
                                                            </select> </div>
                                                 </div>


                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.OEM" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewOEM"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.OrganizationID" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewOrganizationId"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.DeviceIDAllocationDate" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8"> <input type="date" id="viewallocationDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" disabled> </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.DiscontinuedDate" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8"> <input type="date" id="viewdiscontinuedDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" disabled> </div>
                                                    </div>
                                            </div>
                                        </div>
                                        <div id="tab3" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.NumberofsIMslots" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewSimSlots"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.NumberofIMEI" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewnumberofIMEI"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.SIMtype" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewSimtype"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.Dimension" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewDimension"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.bodyweight" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewBodyweight"></p>
                                                    </div>
                                                </div>
                                               <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.eSIMsupport" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="vieweSimSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                        <option value="0"><spring:message code="dropdown.select" /></option> </select> </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.softSIMsupport" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="viewSoftSimSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                        <option value="0"><spring:message code="dropdown.select" /></option>
                                                        </select> </div>
                                                    </div>
                                            </div>
                                        </div>
                                        <div id="tab4" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.type" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewtype"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.size" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewSize"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.resolution" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewResolution"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.Protection" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewProtection"></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="tab11" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.OS" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewOs"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.OSversion" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewOSversion"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.internalmemory" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewinternalMemory"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.RAM" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewRAM"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.MemoryCardSlot" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewMemoryCardSlot"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.CPU" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewCPU"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.GPU" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewGPU"></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="tab5" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.mainCameraType" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="viewTriple" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                        <option value="0"><spring:message code="dropdown.select" /></option>
                                                        </select> </div>
                                                </div>

                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.mainCameraSpecs" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewMainCameraSpecs"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.mainCameraFeature" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewMainCameraFeature"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.mainCameraVideo" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewMainCameraVideo"></p>
                                                    </div>
                                                </div>
                                               <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.SelfieCameraType" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="viewSelfieCameratype" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                        <option value="0"><spring:message code="dropdown.select" /></option>
                                                        </select> </div>
                                                 </div>

                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.SelfieCameraSpecs" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewSelfieCameraSpecs"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.SelfieCameraFeature" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewSelfieCameraFeature"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.SelfieCameraVideo" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewSelfieCameraVideo"></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="tab6" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.Loudspeaker" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="viewLoudspeaker" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                        <option value="0"><spring:message code="dropdown.select" /></option>
                                                         </select> </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.Sound3.5MMJack" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="viewSoundJack" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                        <option value="0"><spring:message code="dropdown.select" /></option>
                                                        </select> </div>
                                                    </div>

                                            </div>
                                        </div>
                                        <div id="tab7" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.WLANsupport" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewWLANSupport"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.BluetoothSupport" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewBluetoothSupport"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.GPSsupport" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewGPSSupport"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.USBsupport" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewUSBSupport"></p>
                                                    </div>
                                                </div>
                                               <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.radioSupport" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="viewRadioSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                        <option value="0"><spring:message code="dropdown.select" /></option>
                                                        </select> </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.NFCSupport" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8 pl-5"> <select id="viewNFCSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                        <option value="0"><spring:message code="dropdown.select" /></option>
                                                        </select> </div>
                                                    </div>
                                            </div>
                                        </div>
                                        <div id="tab8" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.Sensors" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewSensors"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.DeviceColor" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewDeviceColor"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.UICC" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewUICC"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.EUICC" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewEUICC"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.BatteryCapacity" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewBatteryCapacity"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.BatteryChargingSupport" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewBatteryChargingSupport"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.BatteryChargingSupport" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewBatteryChargingSupport2"></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="tab9" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            Launch Price In Asia Market
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewAsia"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            Launch Price In US Market
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewUS"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            Launch Price In Europe Market
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewEurope"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            Launch Price In International Market
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewInternational"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.launchPriceCambodia" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewLaunchPriceCambodia"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.sourcePriceCambodia" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewSourcePriceCambodia"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.customPrice" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewCustomPrice"></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="tab10" class="tab-pane fade">
                                            <div class="product-detail-list">
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.GlobalReportedIssue" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewGlobalIssue"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.LocalReportedIssue" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewLocalIssue"></p>
                                                    </div>
                                                </div>
                                                <!--  New Field Add Remarks  -->
                                                  <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.remarks" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewRemarks"></p>
                                                    </div>
                                                </div>
                                                 <!-- End New Field Add Remarks  -->

                                            </div>
                                        </div>
                                        <!-- TRC View Code Start -->

                                        <div id="tab13" class="tab-pane fade">
                                            <div class="product-detail-list">
                                            	<div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.trcApprovedStatus" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewtrcApprovedStatus"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.trcTypeApprovedBy" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewTrcTypeApprovedBy"></p>
                                                    </div>
                                                </div>
                                                <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.trcApprovalDate" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewTrcApprovalDate"></p>
                                                    </div>
                                                </div>
                                                  <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.isTypeApproved" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewIsTypeApproved"></p>
                                                    </div>
                                                </div>
                                                 <div class="row product-detail-item">
                                                    <div class="col-md-4">
                                                        <h1>
                                                            <spring:message code="input.manufacturerCountry" />
                                                        </h1>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p id="viewManufacturerCountry"></p>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <!-- End TRC View Cide -->
                                        <div class="close-row"> <a onclick='closeViewButton();' class="btn btn-outline-danger close-product">
                                                <spring:message code="modal.close" />
                                            </a> </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="product-image">
                                        <div class="tab-content">
                                            <div id="home" class="tab-pane active">
                                                <div class="product-img-banner product-img-banner-edit">
                                                <img id="mainFrame" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" class="img-fluid" alt=""> </div>
                                            </div>
                                        </div>
                                        <div class="slider-row"> <button class="btn slide-left"><i class="las la-angle-left"></i></button>
                                            <ul class="nav slide-content">
                                                <li>
                                                    <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGView('subFrame1')">
                                                    <img id="subFrame1" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGView('subFrame2')">
                                                    <img id="subFrame2" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGView('subFrame3')">
                                                    <img id="subFrame3" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGView('subFrame4')">
                                                    <img id="subFrame4" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGView('subFrame5')">
                                                    <img id="subFrame5" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                                    </div>
                                                </li>
                                            </ul> <button class="btn slide-right"><i class="las la-angle-right"></i></button>
                                        </div>
                                    </div>
                                </div>
                           	 </div>
                        </div>
                    </div>
                    <!------------------------------- View Div End --------------------------->
      </div>
  </body>
  <script type="text/javascript" src="${context}/resources/js/materialize.js"></script>
  <script type="text/javascript"
            src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>

  <script src="${context}/resources/assets/js/custom.js"></script>
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
  <script>
    var ctx = "${pageContext.request.contextPath}"
  </script>
  <script type="text/javascript" src="${context}/resources/project_js/globalVariables.js?version=<%= (int) (Math.random() * 10) %>"></script>
  <script type="text/javascript" src="${context}/resources/project_js/mdrDashboard.js?version=<%= (int) (Math.random() * 10) %>"></script>
  <script type="text/javascript" src="${context}/resources/project_js/enterKey.js?version=<%= (int) (Math.random() * 10) %>"></script>
  <script type="text/javascript"
    src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script> 
  <script type="text/javascript" src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script> <%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%> <script type="text/javascript">
    var countHit="";  $( document ).ready(function() {   if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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
  <%-- <script type="text/javascript" src="${context}/resources/ajax/keyBoardShortcut.js?version=<%= (int) (Math.random() * 10) %>"></script> --%>
  </body>
</html>
<%
  } else {
  %> <script language="JavaScript">
  sessionStorage.setItem("loginMsg",
  "*Session has been expired");
  window.top.location.href = "./login";
</script> <%
  }
  %>