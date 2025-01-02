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
<sec:csrfMetaTags /> <!-- Security Tags -->
<c:set var="context" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en" class="no-js">
<head><title>EIRS Portal</title>

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
<link rel="icon" type="image/x-icon" href="${context}/resources/assets/images/logo.png"> <%-- <link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection"> --%>
<link rel="stylesheet" href="${context}/resources/assets/fonts/line-awesome/css/line-awesome.min.css">
<link rel="stylesheet" href="${context}/resources/assets/fonts/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${context}/resources/assets/css/mdr/style.css">
<link rel="stylesheet" href="${context}/resources/assets/css/bootstrap.min.css">
<script src="${context}/resources/assets/js/jquery.min.js"></script>
<script src="${context}/resources/assets/js/popper.min.js"></script>
<script src="${context}/resources/assets/js/bootstrap.min.js"></script>
<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>
<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}" /> <!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" /> <!-- Security Tags -->
<script type="text/javascript" src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
    var path = "${context}";
</script>
<link rel="stylesheet"
         href="${context}/resources/custom_js/jquery-ui.css">
<link href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
          type="text/css" rel="stylesheet" media="screen,projection">
 <!-- CSS for icons(to remove later) -->
<link rel="stylesheet"
         href="${context}/resources/assets/css/iconStates.css">
<link href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
         type="text/css" rel="stylesheet" media="screen,projection">
<!-- CORE CSS-->
<link rel="stylesheet" href="${context}/resources/assets/css/mdr/style.css">

<link href="${context}/resources/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">


</head>

<body data-featureId="${featureId}" data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
data-tomcat-path="<spring:eval expression=" @environment.getProperty('tomcat.path')" /> "
data-stolenselected-roleType="${stolenselectedUserTypeId}" data-userName="${userName}" session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}" data-session-source="${not empty param.source ? param.source : 'menu'}">

    <body>
        <div class="content-box">
            <div class="content-container" id="datatableViewDiv">
                <div id="initialloader"></div>
                <div class="content-header" id="pageHeader">
                    <h1 id="pageHeaderTitle"></h1>

                    <div id="multiEditDiv" class="toggle-row ml-auto mr-4">
                      <!-------  <h6>
                            <spring:message code="button.MultiEdit" />
                        </h6> <label class="switch">
                        <input type="checkbox" id="multiEditButton" onchange="multiEditOnChanged(this)">
                        <span class="switch-slider"></span> </label> ------------->
                    </div>

                </div>
                <div class="filter-box" id="filterBox">
                    <form action="" class="filter-row" id="filterform">
                        <div id="dataTableDiv" class="filter-form-row"></div>
                        <div id="filterButtonDiv" class="filter-btn-row"></div>
                        <div id=textbox-container> </div>
                    </form>
                    <form action="" class="filter-row" id="historyFilterform">
                        <div id="historydataTableDiv" class="filter-form-row" style="display: none"></div>
                        <div id="historyfilterButtonDiv" class="filter-btn-row" style="display: none"></div>
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
                <div id="historyTableDiv" class="table-box" style="display: none">
                    <div class="table-responsive">
                        <table id="data-table-history" class="table">
                            <thead class="thead-dark"></thead>
                        </table>
                    </div>
                    <div id="footerBtn1" class="table-paginationbox"> </div>
                </div>
            </div>

            <!------------------------------- View Div Start --------------------------->
                        <div class="content-container" id="mobileDetailViewDiv" style="display: none">
                            <div class="content-header d-flex align-items-center justify-content-between">
                                <h1 id="viewModelLabel">
                                    <spring:message code="input.view" />
                                </h1>
                                <a id="editFromViewBtn" class="btn btn-outline-dark ml-auto"> <img src="${context}/resources/assets/images/edit-icon.svg" alt="icon" class="img-fluid">
                                    <spring:message code="input.Edit" />
                                </a>
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
                                                                Band Details
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
                                                            <option value=""><spring:message code="dropdown.select" /></option> </select> </div>
                                                        </div>
                                                        <div class="row product-detail-item">
                                                            <div class="col-md-4">
                                                                <h1>
                                                                    <spring:message code="input.softSIMsupport" />
                                                                </h1>
                                                            </div>
                                                            <div class="col-md-8 pl-5"> <select id="viewSoftSimSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                            <option value=""><spring:message code="dropdown.select" /></option>
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
                                                            <option value=""><spring:message code="dropdown.select" /></option>
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
                                                            <option value=""><spring:message code="dropdown.select" /></option>
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
                                                            <option value=""><spring:message code="dropdown.select" /></option>
                                                             </select> </div>
                                                        </div>
                                                        <div class="row product-detail-item">
                                                            <div class="col-md-4">
                                                                <h1>
                                                                    <spring:message code="input.Sound3.5MMJack" />
                                                                </h1>
                                                            </div>
                                                            <div class="col-md-8 pl-5"> <select id="viewSoundJack" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                            <option value=""><spring:message code="dropdown.select" /></option>
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
                                                            <option value=""><spring:message code="dropdown.select" /></option>
                                                            </select> </div>
                                                        </div>
                                                        <div class="row product-detail-item">
                                                            <div class="col-md-4">
                                                                <h1>
                                                                    <spring:message code="input.NFCSupport" />
                                                                </h1>
                                                            </div>
                                                            <div class="col-md-8 pl-5"> <select id="viewNFCSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                            <option value=""><spring:message code="dropdown.select" /></option>
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

                                                </div>
                                            </div>
                                            <div id="tab9" class="tab-pane fade">
                                                <div class="product-detail-list">
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.Asia" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <p id="viewAsia"></p>
                                                        </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.US" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <p id="viewUS"></p>
                                                        </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.Europe" />
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <p id="viewEurope"></p>
                                                        </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                <spring:message code="input.International" />
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
                                                                TRC Approved Status
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <p id="viewtrcApprovedStatus"></p>
                                                        </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                Type Approved By
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <p id="viewTrcTypeApprovedBy"></p>
                                                        </div>
                                                    </div>
                                                    <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                TRC Approval Date
                                                            </h1>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <p id="viewTrcApprovalDate"></p>
                                                        </div>
                                                    </div>
                                                      <div class="row product-detail-item">
                                                        <div class="col-md-4">
                                                            <h1>
                                                                Is Type Approved
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
                                            <div class="slider-row"> <a class="btn slide-left"><i class="las la-angle-left"></i></a>
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
                                                </ul> <a class="btn slide-right"><i class="las la-angle-right"></i></a>
                                            </div>
                                        </div>
                                    </div>
                               	 </div>
                            </div>
                        </div>
                        <!------------------------------- View Div End --------------------------->


             <!-------------------------------View history Div Start --------------------------->
            <div class="content-container" id="mobileDetailHistoryViewDiv" style="display: none">
            <form action="#" enctype="multipart/form-data" id="viewDeviceHistoryForm">
                <div class="content-header d-flex align-items-center justify-content-between">
                    <h1 id="viewHistoryModelLabel">
                        <spring:message code="input.viewHistory" />
                    </h1>

                </div>
                <div class="product-box">
                    <div class="row">
                        <div class="col-md-2">
                            <div class="pro-detail-card">
                                <h1>
                                    <spring:message code="roletype.Manufacturer" />
                                </h1>
                                <p id="viewHistoryManufacturer"></p>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="pro-detail-card">
                                <h1>
                                    <spring:message code="imei.MarketingName" />
                                </h1>
                                <p id="viewHistoryMarketingname"></p>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="pro-detail-card">
                                <h1>
                                    <spring:message code="input.TAC" />
                                </h1>
                                <p id="viewHistorytac"></p>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="pro-detail-card">
                                <h1>
                                    <spring:message code="Manufacturing.Address" />
                                </h1>
                                <p id="viewHistoryManAddress"></p>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="pro-detail-card">
                                <h1>
                                    <spring:message code="table.ProductName" />
                                </h1>
                                <p id="viewHistorybrand"></p>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="pro-detail-card">
                                <h1>
                                    <spring:message code="input.modelName" />
                                </h1>
                                <p id="viewHistoryModel"></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="product-detail-section">
                    <div class="row">
                        <div class="col-md-8" >
                            <ul class="nav nav-tabs product-tabs border-0">
                                <li><a data-toggle="tab" href="#tabHistory1" class="active">
                                        <spring:message code="input.Network" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory2">
                                        <spring:message code="input.Launch" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory3">
                                        <spring:message code="input.Body" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory4">
                                        <spring:message code="input.Display" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory11">
                                        <spring:message code="input.Platform" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory5">
                                        <spring:message code="input.Camera" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory6">
                                        <spring:message code="input.Sound" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory7">
                                        <spring:message code="input.comm" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory8">
                                        <spring:message code="input.Misc" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory9">
                                        <spring:message code="input.Price" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory10">
                                        <spring:message code="input.Issues" />
                                    </a></li>
                                <li><a data-toggle="tab" href="#tabHistory13">
                                        TRC
                                    </a></li>
                            </ul>
                            <div class="tab-content">
                                <div id="tabHistory1" class="tab-pane active">
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
                                                        <li id="historyCheck1"><label class="checkbox-container"> <input id="viewHistoryGSMCheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                <spring:message code="input.GSM" />
                                                            </label></li>
                                                        <li id="historyCheck2"><label class="checkbox-container"> <input id="viewHistoryCDMACheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                <spring:message code="input.CDMA" />
                                                            </label></li>
                                                        <li id="historyCheck3"><label class="checkbox-container"> <input id="viewHistoryEVDOCheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                <spring:message code="input.EVDO" />
                                                            </label></li>
                                                        <li id="historyCheck4"><label class="checkbox-container"> <input id="viewHistoryLTECheck" type="checkbox" disabled> <span class="checkmark"></span>
                                                                <spring:message code="input.LTE" />
                                                            </label></li>
                                                        <li id="historyCheck5"><label class="checkbox-container"> <input id="viewHistory5GCheck" type="checkbox" disabled> <span class="checkmark"></span>
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
                                                <p id="viewHistorynetworkBand2G"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.3GBand" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorynetworkBand3G"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.4Gband" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorynetworkBand4G"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.5Gband" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorynetworkBand5G"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.NetworkSpeed" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorynetworkspeed"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    Band Details
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="HistoryBrandDetails"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="table.devicetype" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="HistoryDeviceType"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    Network Specific Identifier
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="HistoryNetworkIdentifier"></p>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div id="tabHistory2" class="tab-pane fade">
                                    <div class="product-detail-list">
                                       	 <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.AnnounceDate" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <input type="date" id="viewHistoryannounceDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" disabled> </div>
                                            </div>
                                            <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.launchdate" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <input type="date" id="viewHistoryLaunchDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" disabled> </div>
                                            </div>
                                       	<div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.devicestatus" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistoryDevicestatus" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
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
                                                <p id="viewHistoryOEM"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.OrganizationID" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryOrganizationId"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.DeviceIDAllocationDate" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <input type="date" id="viewHistoryallocationDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" disabled> </div>
                                            </div>
                                            <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.DiscontinuedDate" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <input type="date" id="viewHistorydiscontinuedDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" disabled> </div>
                                            </div>
                                    </div>
                                </div>
                                <div id="tabHistory3" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.NumberofsIMslots" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorySimSlots"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.NumberofIMEI" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorynumberofIMEI"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.SIMtype" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorySimtype"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.Dimension" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryDimension"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.bodyweight" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryBodyweight"></p>
                                            </div>
                                        </div>
                                       <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.eSIMsupport" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistoryeSimSupport" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
                                                <option value=""><spring:message code="dropdown.select" /></option> </select> </div>
                                            </div>
                                            <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.softSIMsupport" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistorySoftSimSupport" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
                                                <option value=""><spring:message code="dropdown.select" /></option>
                                                </select> </div>
                                            </div>
                                    </div>
                                </div>
                                <div id="tabHistory4" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.type" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorytype"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.size" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorySize"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.resolution" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryResolution"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.Protection" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryProtection"></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tabHistory11" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.OS" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryOs"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.OSversion" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryOSversion"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.internalmemory" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryinternalMemory"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.RAM" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryRAM"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.MemoryCardSlot" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryMemoryCardSlot"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.CPU" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryCPU"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.GPU" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryGPU"></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tabHistory5" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.mainCameraType" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistoryTriple" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
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
                                                <p id="viewHistoryMainCameraSpecs"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.mainCameraFeature" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryMainCameraFeature"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.mainCameraVideo" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryMainCameraVideo"></p>
                                            </div>
                                        </div>
                                       <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.SelfieCameraType" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistorySelfieCameratype" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
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
                                                <p id="viewHistorySelfieCameraSpecs"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.SelfieCameraFeature" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorySelfieCameraFeature"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.SelfieCameraVideo" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorySelfieCameraVideo"></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tabHistory6" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.Loudspeaker" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistoryLoudspeaker" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
                                                <option value=""><spring:message code="dropdown.select" /></option>
                                                 </select> </div>
                                            </div>
                                            <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.Sound3.5MMJack" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistorySoundJack" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
                                                <option value=""><spring:message code="dropdown.select" /></option>
                                                </select> </div>
                                            </div>

                                    </div>
                                </div>
                                <div id="tabHistory7" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.WLANsupport" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryWLANSupport"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.BluetoothSupport" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryBluetoothSupport"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.GPSsupport" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryGPSSupport"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.USBsupport" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryUSBSupport"></p>
                                            </div>
                                        </div>
                                       <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.radioSupport" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistoryRadioSupport" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
                                                <option value=""><spring:message code="dropdown.select" /></option>
                                                </select> </div>
                                            </div>
                                            <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.NFCSupport" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="viewHistoryNFCSupport" class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
                                                <option value=""><spring:message code="dropdown.select" /></option>
                                                </select> </div>
                                            </div>
                                    </div>
                                </div>
                                <div id="tabHistory8" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.Sensors" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorySensors"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.DeviceColor" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryDeviceColor"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.UICC" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryUICC"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.EUICC" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryEUICC"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.BatteryCapacity" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryBatteryCapacity"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.BatteryChargingSupport" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryBatteryChargingSupport"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.BatteryChargingSupport" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryBatteryChargingSupport2"></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tabHistory9" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.Asia" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryAsia"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.US" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryUS"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.Europe" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryEurope"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.International" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryInternational"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.launchPriceCambodia" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryLaunchPriceCambodia"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.sourcePriceCambodia" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorySourcePriceCambodia"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.customPrice" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryCustomPrice"></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tabHistory10" class="tab-pane fade">
                                    <div class="product-detail-list">
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.GlobalReportedIssue" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryGlobalIssue"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.LocalReportedIssue" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryLocalIssue"></p>
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
                                                <p id="viewHistoryRemarks"></p>
                                            </div>
                                        </div>
                                         <!--  End Field Add Remarks  -->
                                    </div>
                                </div>

                                <!-- TRC History Code Start -->

                                <div id="tabHistory13" class="tab-pane fade">
                                    <div class="product-detail-list">
                                    	 <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    TRC Approved Status
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistorytrcApprovedStatus"></p>
                                            </div>
                                        </div>
                                          <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    Type Approved By
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryTrcTypeApprovedBy"></p>
                                            </div>
                                        </div>
                                        <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    TRC Approval Date
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryTrcApprovalDate"></p>
                                            </div>
                                        </div>
                                         <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    Is Type Approved
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryIsTypeApproved"></p>
                                            </div>
                                        </div>
                                         <div class="row product-detail-item">
                                            <div class="col-md-4">
                                                <h1>
                                                    <spring:message code="input.manufacturerCountry" />
                                                </h1>
                                            </div>
                                            <div class="col-md-8">
                                                <p id="viewHistoryManufacturerCountry"></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- End TRC History Cide -->
                                <div class="close-row"> <a onclick='closeHistoryViewButton();' class="btn btn-outline-danger close-product">
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
                                <div class="slider-row"> <a class="btn slide-left"><i class="las la-angle-left"></i></a>
                                    <ul class="nav slide-content">
                                        <li>
                                            <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGView('subFrame0')">
                                            <img id="subFrame0" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                            <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                            </div>
                                        </li>
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
                                    </ul> <a class="btn slide-right"><i class="las la-angle-right"></i></a>
                                </div>
                            </div>
                        </div>
                   	 </div>
                </div>
                </form>
            </div>
            <!------------------------------- View history Div End --------------------------->

            <!------------------------------- Edit Div Start --------------------------->
                       <div class="content-container" id="mobileDetailEditDiv" style="display: none">
                           <form action="#" id="editForm" onsubmit="return updateDeviceConfirmation()" method="POST" enctype="multipart/form-data">
                               <div class="content-header d-flex align-items-center justify-content-between">
                                   <h1>
                                       <spring:message code="input.Edit" />
                                   </h1> <a href="#" class="btn btn-outline-dark ml-auto" data-toggle="modal" data-target="#CopyForm">
                                       <spring:message code="input.CopyFrom" />
                                   </a>
                               </div>
                               <div class="product-box">
                                   <div class="row">
                                       <div class="col-md-2">
                                           <div class="pro-detail-card">
                                               <h1 class="Importaint-Fields">
                                                   <spring:message code="roletype.Manufacturer" />
                                               </h1> <input type="text" id="editManufacturer" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />" disabled> <p id="editId" style="display: none"></p>
                                               <p id="editCopiedId" style="display: none"></p>

                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="pro-detail-card">
                                               <h1 class="Importaint-Fields">
                                                   Marketing Name
                                               </h1> <input type="text" id="editMarketingName" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="pro-detail-card">
                                               <h1>
                                                   <spring:message code="input.TAC" />
                                               </h1>
                                               <p id="editTac"></p>
                                               <p id="editCopiedTac" style="display: none"></p>
                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="pro-detail-card">
                                               <h1>
                                                   <spring:message code="Manufacturing.Address" />
                                               </h1> <input type="text" id="editManufacturingAddress" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="pro-detail-card">
                                               <h1 class="Importaint-Fields">
                                                   <spring:message code="input.BrandName" />
                                               </h1> <input type="text" id="editBrand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />" disabled>

                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="pro-detail-card">
                                               <h1 class="Importaint-Fields">
                                                   <spring:message code="input.modelName" />
                                               </h1> <input type="text" id="editModel" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />" disabled>

                                          	</div>
                                       </div>
                                   </div>
                               </div>
                               <div class="product-detail-section">
                                   <div class="row">
                                       <div class="col-md-8">
                                           <ul class="nav nav-tabs product-tabs border-0">
                                               <li><a data-toggle="tab" href="#tabEdit1" class="active">
                                                       <spring:message code="input.Network" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit2">
                                                       <spring:message code="input.Launch" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit3">
                                                       <spring:message code="input.Body" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit4">
                                                       <spring:message code="input.Display" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tab12">
                                                       <spring:message code="input.Platform" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit5">
                                                       <spring:message code="input.Camera" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit6">
                                                       <spring:message code="input.Sound" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit7">
                                                       <spring:message code="input.comm" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit8">
                                                       <spring:message code="input.Misc" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit9">
                                                       <spring:message code="input.Price" />
                                                   </a></li>
                                               <li><a data-toggle="tab" href="#tabEdit10">
                                                       <spring:message code="input.Issues" />
                                                   </a></li>
                                                <li><a data-toggle="tab" href="#tabEdit13">
                                                       TRC
                                                   </a></li>
                                           </ul>
                                           <div class="tab-content">
                                               <div id="tabEdit1" class="tab-pane active">
                                                   <div id="editTechnologyCheckBoxdiv" class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.Technology" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8">
                                                               <ul class="nav" style="gap: 14px;">
                                                                   <li><label class="checkbox-container"> <input id="editGSMCheck" type="checkbox"> <span class="checkmark"></span>
                                                                           <spring:message code="input.GSM" />
                                                                       </label></li>
                                                                   <li><label class="checkbox-container"> <input id="editCDMACheck" type="checkbox"> <span class="checkmark"></span>
                                                                           <spring:message code="input.CDMA" />
                                                                       </label></li>
                                                                   <li><label class="checkbox-container"> <input id="editEVDOCheck" type="checkbox"> <span class="checkmark"></span>
                                                                           <spring:message code="input.EVDO" />
                                                                       </label></li>
                                                                   <li><label class="checkbox-container"> <input id="editLTECheck" type="checkbox"> <span class="checkmark"></span>
                                                                           <spring:message code="input.LTE" />
                                                                       </label></li>
                                                                   <li><label class="checkbox-container"> <input id="edit5GCheck" type="checkbox"> <span class="checkmark"></span>
                                                                           <spring:message code="input.5G" />
                                                                       </label></li>
                                                               </ul>
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item align-items-center">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.2GBand" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="edit2GBand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.3GBand" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="edit3GBand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.4Gband" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="edit4GBand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item align-items-center">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.5Gband" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="edit5GBand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.NetworkSpeed" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editNetworkSpeed" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item align-items-center">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                  Band Details
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editBrandDetails" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                      <%--  <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="table.devicetype" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editDeviceType" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />" disabled>
                                                           </div>
                                                       </div> --%>

                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="table.devicetype" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editDeviceType" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" disabled>
                                                           <option value="0"><spring:message code="dropdown.select" /></option>
                                                           </select>

                                                           </div>
                                                       </div>

                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   Network Specific Identifier
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editnetworkSpecificIdentifier" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tabEdit2" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.AnnounceDate" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="date" id="editAnnounceDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.launchdate" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="date" id="editLaunchdate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.devicestatus" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editDeviceStatus" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                   <option value="0"><spring:message code="dropdown.select" /></option>
                                                               </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.OEM" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editOem" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />"/ disabled>

                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.OrganizationID" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editOrganizationID" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" placeholder="" / disabled>

                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.DeviceIDAllocationDate" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="date" id="editDeviceIDAllocationDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="" disabled> </div>

                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.DiscontinuedDate" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="date" id="editDiscontinuedDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tabEdit3" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.NumberofsIMslots" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editSimSlots" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value="0"><spring:message code="dropdown.select" /></option>
                                                           </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.NumberofIMEI" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editnumberofIMEI" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value="0"><spring:message code="dropdown.select" /></option>
                                                           </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.SIMtype" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editSimtype" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength20')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength20" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength20" />');" maxlength="15" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.Dimension" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editDimension" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.bodyweight" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editBodyweight" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength10')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength10" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength10" />');" maxlength="10" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.eSIMsupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editSimSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value=""><spring:message code="dropdown.select" /></option>
                                                           </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.softSIMsupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editSoftSimSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value=""><spring:message code="dropdown.select" /></option>
                                                           </select> </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tabEdit4" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.type" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="edittype" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.size" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editSize" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.resolution" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editResolution" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.Protection" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editProtection" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tab12" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.OS" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editOs" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.OSversion" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editOSversion" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.internalmemory" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editInternalMemory" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.RAM" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editRAM" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength20')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength20" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength20" />');" maxlength="20" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.MemoryCardSlot" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editMemoryCardSlot" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value=""><spring:message code="dropdown.select" /></option>
                                                           </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.CPU" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editCPU" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.GPU" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editGPU" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tabEdit5" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.mainCameraType" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editTriple" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value="0"><spring:message code="dropdown.select" /></option>
                                                            </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.mainCameraSpecs" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editMainCameraSpecs" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.mainCameraFeature" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editMainCameraFeature" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.mainCameraVideo" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editMainCameraVideo" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.SelfieCameraType" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editSelfieCameratype" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value="0"><spring:message code="dropdown.select" /></option>
                                                            </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.SelfieCameraSpecs" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editSelfieCameraSpecs" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.SelfieCameraFeature" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editSelfieCameraFeature" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.SelfieCameraVideo" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editSelfieCameraVideo" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tabEdit6" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.Loudspeaker" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editLoudspeaker" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value=""><spring:message code="dropdown.select" /></option>
                                                           </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.Sound3.5MMJack" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editSoundJack" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value=""><spring:message code="dropdown.select" /></option>
                                                           </select> </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tabEdit7" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.WLANsupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editWLANSupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.BluetoothSupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editBluetoothSupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.GPSsupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editGPSsupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.USBsupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editUSBSupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.radioSupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editRadioSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value=""><spring:message code="dropdown.select" /></option>
                                                            </select> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.NFCSupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8 pl-5"> <select id="editNFCSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           <option value=""><spring:message code="dropdown.select" /></option>
                                                           </select> </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tabEdit8" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.Sensors" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editSensors" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.DeviceColor" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editDeviceColor" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.UICC" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editUICC" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.EUICC" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editEUICC" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.BatteryCapacity" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editBatteryCapacity" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.BatteryChargingSupport" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editBatteryChargingSupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>

                                                   </div>
                                               </div>
                                               <div id="tabEdit9" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.Asia" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" name="Asia" id="editAsia" pattern="<spring:eval expression="@environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.US" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" name="US" id="editUS" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.Europe" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" name="Europe" id="editEurope" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.International" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" name="International" id="editInternational" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.launchPriceCambodia" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" name="launchPriceCambodia" id="editlaunchPriceCambodia" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />"
                                                           	oninput="InvalidMsg(this,'input','<spring:message code="validation.price" />');"
                                                           	oninvalid="InvalidMsg(this,'input','<spring:message code="validation.price" />');"
                                                               maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.sourcePriceCambodia" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" name="sourcePriceCambodia" id="editsourcePriceCambodia" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 class="Importaint-Fields">
                                                                   <spring:message code="input.customPrice" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text"  name="customPrice" id="editcustomPrice" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div id="tabEdit10" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.GlobalReportedIssue" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editGlobalReportedIssue" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   <spring:message code="input.LocalReportedIssue" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input type="text" id="editLocalReportedIssue" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                           </div>
                                                       </div>

                                                        <!--  New Field Add Remarks  -->
                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1 style="padding-top: 16px;">
                                                                   <spring:message code="input.remarks" />
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8">
                                                           <textarea class="form-control border-0 p-0 h-auto bg-transparent_" rows="3" cols="60" style="width: 100%; border: none" id="editRemarks"oninput="InvalidMsg(this,'input','
                                                           <spring:message code="validation.alphanumericSpecialCharactersLength256" />');" oninvalid="InvalidMsg(this,'input','
                                                           <spring:message code="validation.alphanumericSpecialCharactersLength256" />');"   maxlength="256" placeholder="<spring:message code="placeholder.enter" />"></textarea>

                                                              <%-- <input type="text" id="editRemarks" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength256')" />" oninput="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength256" />');" oninvalid="InvalidMsg(this,'input','
                                                               <spring:message code="validation.alphanumericSpecialCharactersLength256" />');" maxlength="256" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> --%>
                                                           </div>
                                                       </div>
                                                        <!--  End New Field Add Remarks  -->

                                                   </div>
                                               </div>

                                               <!--  Edit Tab 11 TRC -->

                                               <div id="tabEdit13" class="tab-pane fade">
                                                   <div class="product-detail-list">
                                                   	<div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   TRC Approved Status
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input readonly="readonly" type="text" id="edittrcApprovedStatus" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="">

                                                           </div>
                                                       </div>

                                                        <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   Type Approved By
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input readonly="readonly" type="text" id="editTrcTypeApprovedBy" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="">

                                                           </div>
                                                       </div>

                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   TRC Approval Date
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8">
                                                           	<input readonly="readonly" type="date" id="editTrcApprovalDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="">

                                                           </div>
                                                       </div>

                                                     	 <div class="row product-detail-item">
                                                           <div class="col-md-4">
                                                               <h1>
                                                                   Is Type Approved
                                                               </h1>
                                                           </div>
                                                           <div class="col-md-8"> <input readonly="readonly" type="text" id="editIsTypeApproved" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="">

                                                           </div>
                                                       </div>

                                                       <div class="row product-detail-item">
                                                           <div class="col-md-4 Importaint-Fields">
                                                               <h1>
                                                                   <spring:message code="input.manufacturerCountry" />
                                                               </h1>
                                                           </div>
                                                            <div class="col-md-8">
                                                            	<select id="editManufacturerCountry" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                           		<option value="" selected="selected">Select</option>
                                                           	</select>
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>

                                               <!--  End Edit Tab 11 TRC -->

                                               <div class="close-row"> <a id="cancelbtn" class="btn btn-outline-danger cancel-product">
                                                       <spring:message code="button.cancel" />
                                                   </a> <%-- <a href="#"  class="btn btn-primary save-product" data-toggle="modal" data-target="#myModal">
           								 <spring:message code="registration.save" /></a> --%> <button type="submit" class="btn btn-primary save-product" data-toggle="modal" data-target="#updateConfirmationModal">
                                                       <spring:message code="registration.save" />
                                                   </button> </div>
                                           </div>
                                       </div>
                                       <div class="col-md-4">
                                           <div class="product-image">
                                               <form> <label class="product-img-add product-img-edit"> + Upload Image <input type="file" class="subImageClass" name="files" data-max-size="20,000,000" accept="image/png, image/jpg, image/jpeg" id="docTypeFile1" /> </label>
                                                   <p>
                                                       <center><spring:message code="limit.size2MB" /></center>

                                                   </p>
                                               </form>
                                               <div class="tab-content">
                                                   <div id="home" class="tab-pane active">
                                                       <div class="product-img-banner product-img-banner-edit">
                                                       <img id="mainFrameEdit" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" class="img-fluid" alt=""> </div>
                                                   </div>
                                               </div>
                                               <div class="slider-row"> <a class="btn slide-left"><i class="las la-angle-left"></i></a> <!-- <img src="http://159.223.159.153/docs/ceir/uploaded-files/01111400/MDR/Sample-PNG.png" alt=""> -->
                                                   <ul class="nav slide-content" >
                                                       <li>
                                                           <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGEdit('mainFrameEdit1')">
                                                           <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameEditInput1" data-max-size="20,000,000" onchange="UploadImage('mainFrameEdit1','mainFrameEdit')" />
                                                           <img id="mainFrameEdit1" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid resetImgID" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                               <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameEdit1','mainFrameEditInput1')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                           <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                               <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                           </g>
                                                                           <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                               <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                   <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                               </clipPath>
                                                                           </defs>
                                                                       </svg> </a> <a onclick="document.getElementById('replaceBtnID1').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25">
                                                                       <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="replaceBtnID1" data-max-size="20,000,000" onchange="UploadUpdateImage('1','mainFrameEdit')" />
                                                                       <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                           <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                           <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                           <g id="SVGRepo_iconCarrier">
                                                                               <g>
                                                                                   <g>
                                                                                       <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                       <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                   </g>
                                                                               </g>
                                                                           </g>
                                                                       </svg> </a> </div>
                                                           </div>
                                                       </li>
                                                       <li>
                                                           <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGEdit('mainFrameEdit2')">
                                                           <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameEditInput2" data-max-size="20,000,000" onchange="UploadImage('mainFrameEdit2','mainFrameEdit')" />
                                                           <img id="mainFrameEdit2" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid resetImgID" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                               <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameEdit2','mainFrameEditInput2')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                           <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                               <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                           </g>
                                                                           <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                               <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                   <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                               </clipPath>
                                                                           </defs>
                                                                       </svg> </a> <a onclick="document.getElementById('replaceBtnID2').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25">
                                                                       <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="replaceBtnID2" data-max-size="20,000,000" onchange="UploadUpdateImage('2','mainFrameEdit')" />
                                                                       <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                           <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                           <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                           <g id="SVGRepo_iconCarrier">
                                                                               <g>
                                                                                   <g>
                                                                                       <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                       <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                   </g>
                                                                               </g>
                                                                           </g>
                                                                       </svg> </a> </div>
                                                           </div>
                                                       </li>
                                                       <li>
                                                           <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGEdit('mainFrameEdit3')">
                                                           <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameEditInput3" data-max-size="20,000,000" onchange="UploadImage('mainFrameEdit3','mainFrameEdit')" />
                                                           <img id="mainFrameEdit3" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid resetImgID" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                               <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameEdit3','mainFrameEditInput3')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                           <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                               <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                           </g>
                                                                           <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                               <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                   <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                               </clipPath>
                                                                           </defs>
                                                                       </svg> </a> <a onclick="document.getElementById('replaceBtnID3').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25">
                                                                       <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="replaceBtnID3" data-max-size="20,000,000" onchange="UploadUpdateImage('3','mainFrameEdit')" />
                                                                       <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                           <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                           <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                           <g id="SVGRepo_iconCarrier">
                                                                               <g>
                                                                                   <g>
                                                                                       <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                       <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                   </g>
                                                                               </g>
                                                                           </g>
                                                                       </svg> </a> </div>
                                                           </div>
                                                       </li>
                                                       <li>
                                                           <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGEdit('mainFrameEdit4')">
                                                           <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameEditInput4" data-max-size="20,000,000" onchange="UploadImage('mainFrameEdit4','mainFrameEdit')" />
                                                           <img id="mainFrameEdit4" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid resetImgID" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                               <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameEdit4','mainFrameEditInput4')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                           <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                               <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                           </g>
                                                                           <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                               <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                   <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                               </clipPath>
                                                                           </defs>
                                                                       </svg> </a> <a onclick="document.getElementById('replaceBtnID4').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25">
                                                                       <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="replaceBtnID4" data-max-size="20,000,000" onchange="UploadUpdateImage('4','mainFrameEdit')" />
                                                                       	<svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                           <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                           <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                           <g id="SVGRepo_iconCarrier">
                                                                               <g>
                                                                                   <g>
                                                                                       <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                       <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                   </g>
                                                                               </g>
                                                                           </g>
                                                                       </svg> </a> </div>
                                                           </div>
                                                       </li>
                                                       <li>
                                                           <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGEdit('mainFrameEdit5')">
                                                           <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameEditInput5" data-max-size="20,000,000" onchange="UploadImage('mainFrameEdit5','mainFrameEdit')" />
                                                           <img id="mainFrameEdit5" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid resetImgID" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                               <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameEdit5','mainFrameEditInput5')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2">
                                                               <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                           <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                               <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                           </g>
                                                                           <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                               <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                   <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                               </clipPath>
                                                                           </defs>
                                                                       </svg> </a> <a onclick="document.getElementById('replaceBtnID5').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25">
                                                                       <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="replaceBtnID5" data-max-size="20,000,000" onchange="UploadUpdateImage('5','mainFrameEdit')" />
                                                                       <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                           <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                           <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                           <g id="SVGRepo_iconCarrier">
                                                                               <g>
                                                                                   <g>
                                                                                       <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                       <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                   </g>
                                                                               </g>
                                                                           </g>
                                                                       </svg> </a> </div>
                                                           </div>
                                                       </li>
                                                   </ul> <a class="btn slide-right"><i class="las la-angle-right"></i></a>
                                               </div>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                           </form>
                       </div>
                       <!------------------------------- Edit Div End --------------------------->




        <!------------------------------- Add Device Confirmation modal Start --------------------------->
        <div class="modal fade Save-modal" id="AddconfirmationModal">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">
                            <spring:message code="button.SaveandExit" />
                        </h4>
                    </div>
                    <div class="modal-body">
                        <spring:message code="msg.saveConfirmation" />
                        <div class="Popup">
                     <p><label class="checkbox-container" data-tooltip-id="">
        			<input id="completeCheckBox" onchange="validateImportaintField()" type="checkbox" title=" " data-tooltip-id=""> <span class="checkmark" data-tooltip-id=""></span>
                            Mark it as complete</label></p>
                            <h4 id="fieldValidationMsg" class="red" style="display: none">Please complete the following Important Fields</h4>
                            <h4 id="fieldValidationSuccessMsg" class="green" style="display: none;color: #219653;" >All Importaint information is complete</h4>
                        <div id="errorFieldList" style="display: none" class="scrollY">
                            </div>
                            </div>
                    </div>

                    <div class="modal-footer border-0"> <%-- <button type="button" class="btn btn-outline-danger cancel-product"
						data-dismiss="modal"><spring:message code="modal.close" /></button> --%> <a onclick='closeConfirmation()' class="btn btn-outline-danger cancel-product">
                            <spring:message code="modal.close" />
                        </a> <a onclick='addDeviceDetails()' id="saveDeviceButton" class="btn btn-primary save-product" data-dismiss="modal">
                            <spring:message code="registration.save" />
                        </a> </div>
                </div>
            </div>
        </div>
        <!------------------------------- Add Device Confirmation modal End --------------------------->



    <!-- Save Modal -->
        <div class="modal fade" id="saveConfirmationMessage" role="dialog">
          <div class="modal-dialog modal-sm">
            <div class="modal-content">
              <div class="modal-body">
                <p> <i class="fa fa-check savedicon" aria-hidden="true"></i> Data successfully saved</p>
              </div>

            </div>
          </div>
        </div>
        <!-- Save Modal close-->


     <!-- Save Modal -->
            <div class="modal fade" id="saveFailedConfirmationMessage" role="dialog">
              <div class="modal-dialog modal-sm">
                <div class="modal-content">
                  <div class="modal-body">
                    <p> <i class="fa fa-check savedicon" aria-hidden="true"></i> Device already exists</p>
                  </div>

                </div>
              </div>
            </div>
            <!-- Save Modal close-->
        <!------------------------------- update Confirmation modal Start --------------------------->
        <div class="modal fade Save-modal" id="updateConfirmationModal">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">
                            <spring:message code="button.SaveandExit" />
                        </h4>
                    </div>
                    <div class="modal-body">
                        <spring:message code="msg.saveConfirmation" />
                         <div class="Popup">
                     <p><label class="checkbox-container" data-tooltip-id="">
        			<input id="completeCheckBoxEdit" onchange="validateImportaintFieldUpdate()" type="checkbox" title=" " data-tooltip-id=""> <span class="checkmark" data-tooltip-id=""></span>
                            Mark it as complete</label></p>
                            <h4 id="fieldValidationMsgEdit" class="red" style="display: none">Please complete the following Important Fields</h4>
                            <h4 id="fieldValidationSuccessMsgEdit" style="display: none;color: #219653;" >All Importaint information is complete</h4>
                        <div id="errorFieldListEdit" style="display: none" class="scrollY">
                            </div>
                            </div>
                    </div>

                    <div class="modal-footer border-0"> <button type="button" onclick='closeConfirmationupdate()' class="btn btn-outline-danger cancel-product" data-dismiss="modal">
                            <spring:message code="modal.close" />
                        </button> <a onclick="updateDeviceDetails('simpleEdit')" id="updateButton" class="btn btn-primary save-product" data-dismiss="modal" style="width: 200px;">
                            <spring:message code="registration.save" />
                        </a> </div>
                </div>
            </div>
        </div>
        <!------------------------------- update Confirmation modal End --------------------------->


         <!-- Save Modal -->
        <div class="modal fade" id="updateConfirmationMessage" role="dialog">
          <div class="modal-dialog modal-sm">
            <div class="modal-content">
              <div class="modal-body">
                <p> <i class="fa fa-check savedicon" aria-hidden="true"></i> Data successfully Updated</p>
              </div>

            </div>
          </div>
        </div>
        <!-- Save Modal close-->

        <!------------------------------- Delete modal Start --------------------------->
        <div class="modal fade Save-modal" id="deleteModal">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">
                            <spring:message code="MDR.DeleteDevice" />
                        </h4>
                    </div>
                    <div class="modal-body">
                        <spring:message code="msg.deleteConfirmation" />
                    </div>
                    <p id="deleteDeviceId" style="display: none"></p>
                    <div class="modal-footer border-0"> <button type="button" class="btn btn-outline-danger cancel-product" data-dismiss="modal">
                            <spring:message code="modal.close" />
                        </button> <a onclick='deleteDeviceDetails()' class="btn btn-primary save-product" data-dismiss="modal">
                            <spring:message code="msg.delete" />
                        </a> </div>
                </div>
            </div>
        </div>
        <!------------------------------- Delete modal End --------------------------->


        <!-- Delete Modal -->
        <div class="modal fade" id="deleteConfirmationMessage" role="dialog">
            <div class="modal-dialog modal-sm">
              <div class="modal-content">
                <div class="modal-body">
                  <p> <i class="fa fa-trash-o deletedicon" aria-hidden="true"></i> Data successfully Deleted</p>
                </div>

              </div>
            </div>
          </div>
          <!-- Delete Modal Close-->

        <!------------------------------- Copy From modal Start --------------------------->
        <div class="modal fade copy-form" id="CopyForm">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">
                            <spring:message code="mdr.copyfrom" />
                        </h4> <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div> <!-- Modal body -->
                    <form action="" class="copyform-box" id="copyform-serach-box">
                        <div class="modal-body pb-0">
                            <div class="form-group row align-items-center">
                                <div class="col-md-4 text-right pr-0"> <label>
                                        <spring:message code="input.TAC" />
                                        <!-- <sup class="text-danger">*</sup> -->
                                    </label> </div>
                                <div class="col-md-8">
                                <input type="text" id="copyFromTac" class="form-control" placeholder="<spring:message code="placeholder.enter" />"  pattern="<spring:eval expression=" @environment.getProperty('pattern.tac')" />"
                                    oninput="InvalidMsg(this,'input','<spring:message code="validation.tac8" />');"
                                    <%-- oninvalid="InvalidMsg(this,'input','<spring:message code="validation.tac" />');" --%>
                                    oninvalid="this.setCustomValidity('<spring:message code="validation.requiredMsg" />');"
                                    maxlength="8" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />" required="required"> </div>
                            </div>
                            <div class="form-group row align-items-center">
                                <div class="col-md-4 text-right pr-0"> <label>
                                        <spring:message code="input.BrandName" />
                                    </label> </div>
                                <div class="col-md-8"> <select class="form-control" id="copyFromBrandName">
                                       <option value=""><spring:message code="dropdown.select" /></option>
                                    </select> </div>
                            </div>
                            <div class="form-group row align-items-center">
                                <div class="col-md-4 text-right pr-0"> <label>
                                        Model Name
                                    </label> </div>
                                <div class="col-md-8"> <input type="text" id="copyFromMarketingName" class="form-control" placeholder="<spring:message code="placeholder.enter" />"> </div>
                            </div>
                        </div>
                        <div class="modal-footer border-0 pt-0"> <button onclick="searchDetails('copyFrom','')" data-toggle="modal" data-target="#CopyForm-choose" class="btn btn-primary save-product" data-dismiss="modal">
                                <spring:message code="modal.header.Search" />
                            </button> </div>
                    </form>
                </div>
            </div>
        </div>
        <!------------------------------- Copy From modal End --------------------------->


        <!------------------------------- Copy From view modal start --------------------------->
        <div class="modal fade copy-view-form" id="CopyForm-choose">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">
                            <spring:message code="input.CopyFrom" />
                        </h4> <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div> <!-- Modal body -->
                    <div class="modal-body">
                        <div class="copyform-box">
                            <div class="form-group row align-items-center justify-content-end">
                                <div class="col-md-4 text-right pr-0"> <label class="font-weight-normal">
                                        <spring:message code="mdr.FilterMarketingName" />
                                    </label> </div>
                                <div class="col-md-4"> <input type="text" id="copyFromfilterMarketingName" class="form-control" placeholder="<spring:message code="placeholder.enter" />"> </div>
                            </div>
                        </div>
                        <div class="table-box">
                            <table id="copyDetailTable" class="table">
                                <thead class="thead-dark"></thead>
                            </table>
                            <div id="footerBtn" class="table-paginationbox"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <p id="selectedBrandName" style="display: none"></p>
        <p id="selectedModelName" style="display: none"></p>
        <p id="selectedTac" style="display: none"></p>


        <div class="modal fade" id="CopyForm-view">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">
                            <spring:message code="titles.View" />
                        </h4> <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div> <!-- Modal body -->
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="product-detail-list">
                                    <div class="row product-detail-item">
                                        <div class="col-md-4">
                                            <h1>
                                                <spring:message code="input.BrandName" />
                                            </h1>
                                        </div>
                                        <div class="col-md-8">
                                            <p id="copyViewbrand"></p>
                                        </div>
                                    </div>
                                    <div class="row product-detail-item">
                                        <div class="col-md-4">
                                            <h1>
                                                <spring:message code="input.modelName" />
                                            </h1>
                                        </div>
                                        <div class="col-md-8">
                                            <p id="copyViewmodelName"></p>
                                        </div>
                                    </div>
                                    <div class="row product-detail-item">
                                        <div class="col-md-4">
                                            <h1>
                                                <spring:message code="input.osType" />
                                            </h1>
                                        </div>
                                        <div class="col-md-8">
                                            <p id="copyViewOsType"></p>
                                        </div>
                                    </div>
                                    <div class="row product-detail-item">
                                        <div class="col-md-4">
                                            <h1>
                                                <spring:message code="imei.MarketingName" />
                                            </h1>
                                        </div>
                                        <div class="col-md-8">
                                            <p id="copyViewMarketingName"></p>
                                        </div>
                                    </div>
                                    <div class="row product-detail-item">
                                        <div class="col-md-4">
                                            <h1>
                                                <spring:message code="roletype.Manufacturer" />
                                            </h1>
                                        </div>
                                        <div class="col-md-8">
                                            <p id="copyViewManufacturer"></p>
                                        </div>
                                    </div>
                                    <div class="row product-detail-item">
                                        <div class="col-md-4">
                                            <h1>
                                                <spring:message code="Manufacturing.Address" />
                                            </h1>
                                        </div>
                                        <div class="col-md-8">
                                            <p id="copyViewManufacturingAddress"></p>
                                        </div>
                                    </div>
                                    <div class="row product-detail-item">
                                                <div class="col-md-4">
                                                    <h1>
                                                        <spring:message code="input.devicestatus" />
                                                    </h1>
                                                </div>
                                                <div class="col-md-8"> <select id="copyViewdevicestatus"  class="form-control border-0 p-0 h-auto w-auto bg-transparent" disabled>
                                                        <option value=""><spring:message code="dropdown.select" /></option>
                                                    </select>
                                                </div>
                                     </div>
                                    <div class="row product-detail-item">
                                        <div class="col-md-4">
                                            <h1>
                                                <spring:message code="input.OrganizationID" />
                                            </h1>
                                        </div>
                                        <div class="col-md-8">
                                            <p id="copyViewOrganizationID"></p>
                                        </div>
                                    </div>
                                    <div class="row product-detail-item">
                                        <div class="col-md-4">
                                            <h1>
                                                <spring:message code="input.DeviceIDAllocationDate" />
                                            </h1>
                                        </div>
                                        <div class="col-md-8">
                                            <p id="copyViewDeviceIDAllocationDate"></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="close-row"> <a id="copyButton" data-dismiss="modal" data-toggle="modal" class="btn btn-primary save-product"> <img src="${context}/resources/assets/images/copy-icon-white.svg" data-dismiss="modal" data-toggle="modal" alt="icon">
                                        <spring:message code="btn.copy" />
                                    </a> </div>
                            </div>
                        <div class="col-md-4">
                            <div class="product-image">
                                <div class="tab-content">
                                    <div id="home" class="tab-pane active">
                                        <div class="product-img-banner product-img-banner-edit">
                                        <input type="file" class="subImageClass" name="files" style="display:none;" data-max-size="20,000,000" accept="image/png, image/jpg, image/jpeg" id="docTypeFileCopyfrom" />
                                        <img id="copyFromsubFrame" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" class="img-fluid" alt=""> </div>
                                    </div>
                                </div>
                                <div class="slider-row"> <a class="btn slide-left"><i class="las la-angle-left"></i></a>
                                    <ul class="nav slide-content">
                                        <li>
                                        	<div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGCopyView('copyFromsubFrame1')">
                                        	<input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="copyFromsubFrameInput0" data-max-size="20,000,000" />
                                            <img id="copyFromsubFrame1" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                            <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGCopyView('copyFromsubFrame2')">
                                            <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="copyFromsubFrameInput1" data-max-size="20,000,000" />
                                            <img id="copyFromsubFrame2" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                            <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGCopyView('copyFromsubFrame3')">
                                            <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="copyFromsubFrameInput2" data-max-size="20,000,000" />
                                            <img id="copyFromsubFrame3" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                            <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGCopyView('copyFromsubFrame4')">
                                            <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="copyFromsubFrameInput3" data-max-size="20,000,000"/>
                                            <img id="copyFromsubFrame4" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                            <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMGCopyView('copyFromsubFrame5')">
                                            <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="copyFromsubFrameInput4" data-max-size="20,000,000"/>
                                            <img id="copyFromsubFrame5" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                            <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> </div>
                                            </div>
                                        </li>
                                    </ul> <a class="btn slide-right"><i class="las la-angle-right"></i></a>
                                </div>
                            </div>
                        </div>
                            <!-- <div class="col-md-4">
                                <div class="product-image">
                                    <div class="tab-content">
                                        <div id="home" class="tab-pane active">
                                            <div class="product-img-banner"> <img src="" id="copyFromMainFrame" class="img-fluid" alt=""> </div>
                                        </div>
                                    </div>
                                    <div class="slider-row"> <button id="slide-left" class="btn"><i class="las la-angle-left"></i></button>
                                        <ul class="nav" id="slide-content" style="max-width:220px;">
                                            <li> <a data-toggle="tab" href="#home" class="active"> <img onclick="selectImage(this.src)" src="" id="copyFromsubFrame1" alt="" class="img-fluid"> </a> </li>
                                            <li> <a data-toggle="tab" href="#menu1"> <img onclick="selectImage(this.src)" src="" id="copyFromsubFrame2" alt="" class="img-fluid"> </a> </li>
                                            <li> <a data-toggle="tab" href="#menu2"> <img onclick="selectImage(this.src)" src="" id="copyFromsubFrame3" alt="" class="img-fluid"> </a> </li>
                                            <li> <a data-toggle="tab" href="#menu3"> <img onclick="selectImage(this.src)" src="" id="copyFromsubFrame4" alt="" class="img-fluid"> </a> </li>
                                        </ul> <button id="slide-right" class="btn"><i class="las la-angle-right"></i></button>
                                    </div>
                                </div>
                            </div> -->
                        </div>
                    </div>
                </div>
            </div>
        </div> <!--  Modal content for the above example -->
        <div id="imageViewModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="myLargeModalLabel">
                            <spring:message code="model.View.images" />
                        </h5> <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> </button>
                    </div>
                    <div class="modal-body pb-0_">
                        <center><img id="imgInViewForm" style="width:100%;" alt="" class="mr-15"></center>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->



        <!------------------------------- Add Div Start --------------------------->
                            <div class="content-container" id="addMobileDetailDiv" style="display: none">
                                <form action="#" onsubmit="return addDeviceform()" method="POST" enctype="multipart/form-data" id="addDeviceForm">
                                    <div class="content-header d-flex align-items-center justify-content-between">
                                        <h1>
                                        <span>ADD</span>
                                        </h1>
                                    </div>
                                    <div class="product-box">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <div class="pro-detail-card">
                                                    <h1 class="Importaint-Fields">
                                                        <spring:message code="roletype.Manufacturer" /><sup class="text-danger">*</sup>
                                                    </h1> <input type="text" id="addManufacturer" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="pro-detail-card">
                                                    <h1 class="Importaint-Fields">
                                                        Marketing Name
                                                    </h1> <input type="text" id="addMarketingName" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="pro-detail-card">
                                                    <h1>
                                                        <spring:message code="input.TAC"/><sup class="text-danger">*</sup>
                                                    </h1><input type="text" id="addTac" pattern="<spring:eval expression=" @environment.getProperty('pattern.tac')" />"
                                                    oninput="InvalidMsg(this,'input','<spring:message code="validation.tac8" />');"
                                                   oninvalid="InvalidMsg(this,'input','<spring:message code="validation.tac8" />');"

                                                    maxlength="8" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />" required="required">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="pro-detail-card">
                                                    <h1>
                                                        <spring:message code="Manufacturing.Address" />
                                                    </h1> <input type="text" id="addManufacturingAddress" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="pro-detail-card">
                                                    <h1 class="Importaint-Fields">
                                                        <spring:message code="input.BrandName" /><sup class="text-danger">*</sup>
                                                    </h1> <input type="text" id="addBrand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="pro-detail-card">
                                                    <h1 class="Importaint-Fields">
                                                        <spring:message code="input.modelName" /><sup class="text-danger">*</sup>
                                                    </h1> <input type="text" id="addModel" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-detail-section">
                                        <div class="row">
                                            <div class="col-md-8" id="addTabs">
                                                <ul class="nav nav-tabs product-tabs border-0">
                                                    <li><a data-toggle="tab" href="#tabadd1" class="active">
                                                            <spring:message code="input.Network" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd2">
                                                            <spring:message code="input.Launch" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd3">
                                                            <spring:message code="input.Body" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd4">
                                                            <spring:message code="input.Display" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd12">
                                                            <spring:message code="input.Platform" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd5">
                                                            <spring:message code="input.Camera" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd6">
                                                            <spring:message code="input.Sound" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd7">
                                                            <spring:message code="input.comm" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd8">
                                                            <spring:message code="input.Misc" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd9">
                                                            <spring:message code="input.Price" />
                                                        </a></li>
                                                    <li><a data-toggle="tab" href="#tabadd10">
                                                            <spring:message code="input.Issues" />
                                                        </a></li>
                                                </ul>
                                                <div class="tab-content">
                                                    <div id="tabadd1" class="tab-pane active">
                                                        <div id="addTechnologyCheckBoxdiv" class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.Technology" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <ul class="nav" style="gap: 14px;">
                                                                        <li><label class="checkbox-container"> <input id="addGSMCheck" type="checkbox"> <span class="checkmark"></span>
                                                                                <spring:message code="input.GSM" />
                                                                            </label></li>
                                                                        <li><label class="checkbox-container"> <input id="addCDMACheck" type="checkbox"> <span class="checkmark"></span>
                                                                                <spring:message code="input.CDMA" />
                                                                            </label></li>
                                                                        <li><label class="checkbox-container"> <input id="addEVDOCheck" type="checkbox"> <span class="checkmark"></span>
                                                                                <spring:message code="input.EVDO" />
                                                                            </label></li>
                                                                        <li><label class="checkbox-container"> <input id="addLTECheck" type="checkbox"> <span class="checkmark"></span>
                                                                                <spring:message code="input.LTE" />
                                                                            </label></li>
                                                                        <li><label class="checkbox-container"> <input id="add5GCheck" type="checkbox"> <span class="checkmark"></span>
                                                                                <spring:message code="input.5G" />
                                                                            </label></li>
                                                                        <!-- <li><label class="checkbox-container"> <input id="add6GCheck" type="checkbox"> <span class="checkmark"></span>
                                                                                6G
                                                                            </label></li>
                                                                        <li><label class="checkbox-container"> <input id="add7GCheck" type="checkbox"> <span class="checkmark"></span>
                                                                                7G
                                                                            </label></li>    -->
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item align-items-center">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.2GBand" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="add2GBand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.3GBand" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="add3GBand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.4Gband" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="add4GBand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item align-items-center">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.5Gband" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="add5GBand" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.NetworkSpeed" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addNetworkSpeed" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item align-items-center">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        Band Details
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addBrandDetails" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                            </div>
                                                            <%-- <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="table.devicetype" /><sup class="text-danger">*</sup>
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addDeviceType" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div> --%>

                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="table.devicetype" /><sup class="text-danger">*</sup>
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addDeviceType" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent" required>
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>

                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        Network Specific Identifier
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addNetworkSpeceficIdentifier" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div id="tabadd2" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.AnnounceDate" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="date" id="addAnnounceDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.launchdate" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="date" id="addLaunchdate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.devicestatus" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addDeviceStatus" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                        <option value="0"><spring:message code="dropdown.select" /></option>
                                                                        <!-- <option value='1'>Available</option> -->
                                                                        <!-- <option value='0'>Unavailable</option> -->
                                                                    </select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.OEM" /><sup class="text-danger">*</sup>
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addOem" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.OrganizationID" /><sup class="text-danger">*</sup>
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addOrganizationID" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto w-auto_ bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.DeviceIDAllocationDate" /><sup class="text-danger">*</sup>
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="date" id="addDeviceIDAllocationDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.DiscontinuedDate" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="date" id="addDiscontinuedDate" class="form-control border-0 p-0 h-auto w-auto text-uppercase bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="tabadd3" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.NumberofsIMslots" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addSimSlots" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option></select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.NumberofIMEI" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addnumberofIMEI" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.SIMtype" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addSimtype" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength15')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength15" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength15" />');" maxlength="15" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.Dimension" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addDimension" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.bodyweight" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addBodyweight" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength10')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength10" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength10" />');" maxlength="10" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.eSIMsupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addSimSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value=""><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.softSIMsupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addSoftSimSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value=""><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="tabadd4" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.type" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addtype" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.size" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addSize" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.resolution" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addResolution" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.Protection" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addProtection" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="tabadd12" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.OS" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addOs" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.OSversion" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addOSversion" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.internalmemory" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addInternalMemory" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.RAM" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addRAM" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength20')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength20" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength20" />');" maxlength="20" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.MemoryCardSlot" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addMemoryCardSlot" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.CPU" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addCPU" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.GPU" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addGPU" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="tabadd5" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.mainCameraType" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addTriple" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.mainCameraSpecs" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addMainCameraSpecs" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.mainCameraFeature" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addMainCameraFeature" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.mainCameraVideo" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addMainCameraVideo" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.SelfieCameraType" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addSelfieCameratype" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                 </select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.SelfieCameraSpecs" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addSelfieCameraSpecs" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.SelfieCameraFeature" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addSelfieCameraFeature" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.SelfieCameraVideo" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addSelfieCameraVideo" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="tabadd6" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.Loudspeaker" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addLoudspeaker" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.Sound3.5MMJack" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addSoundJack" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="tabadd7" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.WLANsupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addWLANSupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.BluetoothSupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addBluetoothSupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.GPSsupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addGPSsupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.USBsupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addUSBSupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.radioSupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addRadioSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                </select> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.NFCSupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8 pl-5"> <select id="addNFCSupport" class="form-control border-0 p-0_ h-auto w-auto_ bg-transparent">
                                                                <option value="0"><spring:message code="dropdown.select" /></option>
                                                                 </select> </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="tabadd8" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.Sensors" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addSensors" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.DeviceColor" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addDeviceColor" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.UICC" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addUICC" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.EUICC" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addEUICC" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength50')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength50" />');" maxlength="50" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.BatteryCapacity" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addBatteryCapacity" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.BatteryChargingSupport" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addBatteryChargingSupport" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div id="tabadd9" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.Asia" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addAsia" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.US" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addUS" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.Europe" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addEurope" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.International" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addInternational" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.launchPriceCambodia" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addlaunchPriceCambodia" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.sourcePriceCambodia" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addsourcePriceCambodia" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 class="Importaint-Fields">
                                                                        <spring:message code="input.customPrice" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addcustomPrice" pattern="<spring:eval expression=" @environment.getProperty('pattern.Currency')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.price" />');" maxlength="9" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="tabadd10" class="tab-pane fade">
                                                        <div class="product-detail-list">
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.GlobalReportedIssue" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" class="form-control border-0 p-0 h-auto" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" id="addGlobalReportedIssue" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1>
                                                                        <spring:message code="input.LocalReportedIssue" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8"> <input type="text" id="addLocalReportedIssue" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength100')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength100" />');" maxlength="100" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />">
                                                                </div>
                                                            </div>
                                                             <!--  New Field Add Remarks  -->
                                                            <div class="row product-detail-item">
                                                                <div class="col-md-4">
                                                                    <h1 style="padding-top: 16px;">
                                                                        <spring:message code="input.remarks" />
                                                                    </h1>
                                                                </div>
                                                                <div class="col-md-8">
                                                                <textarea class="form-control border-0 p-0 h-auto bg-transparent_" style="width: 100%; border: none" rows="3" cols="60" id="addRemarks"oninput="InvalidMsg(this,'input','
                                                                <spring:message code="validation.alphanumericSpecialCharactersLength256" />');" oninvalid="InvalidMsg(this,'input','
                                                                <spring:message code="validation.alphanumericSpecialCharactersLength256" />');" maxlength="256" placeholder="<spring:message code="placeholder.enter" />"></textarea>

                                                                <%-- <input type="text" id="addRemarks" pattern="<spring:eval expression=" @environment.getProperty('pattern.alphanumericSpecialCharactersLength256')" />" oninput="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength256" />');" oninvalid="InvalidMsg(this,'input','
                                                                    <spring:message code="validation.alphanumericSpecialCharactersLength256" />');" maxlength="256" class="form-control border-0 p-0 h-auto bg-transparent" placeholder="<spring:message code="placeholder.enter" />"> --%>
                                                                </div>
                                                            </div>
                                                             <!--  End New Field Add Remarks  -->

                                                        </div>
                                                    </div>
                                                     <div class="close-row">
                										<a href="#tabadd1" onclick='closeAddPage()' id="cancelbtn" class="btn btn-outline-danger cancel-product">
                                                            <spring:message code="button.cancel" />
                                                        </a>
                                                        <button type="submit" class="btn btn-primary save-product">
                                                            <spring:message code="registration.save" />
                                                        </button>
                                                    </div>
                                            </div>

                                            </div><!-------col-md-8 close------->
                                            <div class="col-md-4">
                                                <div class="product-image">
                                                    <form> <label class="product-img-add product-img-edit"> + Upload Image <input type="file" class="subImageAddClass" name="files" data-max-size="20,000,000" accept="image/png, image/jpg, image/jpeg" id="docTypeFileSave" /> </label>
                                                        <p>
                                                            <center><spring:message code="limit.size2MB" /></center>
                                                        </p>
                                                    </form>
                                                    <div class="tab-content">
                                                        <div id="home" class="tab-pane active">
                                                            <div class="product-img-banner product-img-banner-edit">
                                                            <img id="mainFrameSave" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" class="img-fluid" alt=""> </div>
                                                        </div>
                                                    </div>
                                                    <div class="slider-row"> <a class="btn slide-left"><i class="las la-angle-left"></i></a> <!-- <img src="http://159.223.159.153/docs/ceir/uploaded-files/01111400/MDR/Sample-PNG.png" alt=""> -->
                                                        <ul class="nav slide-content" >
                                                            <li>
                                                                <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMG('mainFrameSave1')">
                                                                <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameSaveInput1" data-max-size="20,000,000" onchange="UploadImage('mainFrameSave1','mainFrameSave')" />
                                                                 <img id="mainFrameSave1" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameSave1','mainFrameSaveInput1')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                                <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                                    <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                                </g>
                                                                                <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                                    <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                        <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                                    </clipPath>
                                                                                </defs>
                                                                            </svg> </a> <a onclick="document.getElementById('replaceBtnIDSave1').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25">
                                                                            <input class="subImageAddClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="replaceBtnIDSave1" data-max-size="20,000,000" onchange="UploadImage('1','mainFrameSave')" /> <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                                <g id="SVGRepo_iconCarrier">
                                                                                    <g>
                                                                                        <g>
                                                                                            <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                            <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                        </g>
                                                                                    </g>
                                                                                </g>
                                                                            </svg> </a> </div>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMG('mainFrameSave2')">
                                                                <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameSaveInput2" data-max-size="20,000,000" onchange="UploadImage('mainFrameSave2','mainFrameSave')" /> <img src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" id="mainFrameSave2" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameSave2','mainFrameSaveInput2')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                                <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                                    <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                                </g>
                                                                                <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                                    <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                        <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                                    </clipPath>
                                                                                </defs>
                                                                            </svg> </a> <a onclick="document.getElementById('replaceBtnIDSave2').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25"> <input class="subImageClass" type="file" style="display:none;" id="replaceBtnIDSave2" accept="image/png, image/jpg, image/jpeg" data-max-size="20,000,000" onchange="UploadImage('2','mainFrameSave')" /> <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                                <g id="SVGRepo_iconCarrier">
                                                                                    <g>
                                                                                        <g>
                                                                                            <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                            <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                        </g>
                                                                                    </g>
                                                                                </g>
                                                                            </svg> </a> </div>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMG('mainFrameSave3')">
                                                                 <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameSaveInput3" data-max-size="20,000,000" onchange="UploadImage('mainFrameSave3','mainFrameSave')" /> <img id="mainFrameSave3" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameSave3','mainFrameSaveInput3')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                                <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                                    <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                                </g>
                                                                                <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                                    <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                        <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                                    </clipPath>
                                                                                </defs>
                                                                            </svg> </a> <a onclick="document.getElementById('replaceBtnIDSave3').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25"> <input class="subImageClass" type="file" style="display:none;" id="replaceBtnIDSave3" accept="image/png, image/jpg, image/jpeg" data-max-size="20,000,000" onchange="UploadImage('3','mainFrameSave')" /> <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                                <g id="SVGRepo_iconCarrier">
                                                                                    <g>
                                                                                        <g>
                                                                                            <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                            <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                        </g>
                                                                                    </g>
                                                                                </g>
                                                                            </svg> </a> </div>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMG('mainFrameSave4')">
                                                                 <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameSaveInput4" data-max-size="20,000,000" onchange="UploadImage('mainFrameSave4','mainFrameSave')" /> <img id="mainFrameSave4" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameSave4','mainFrameSaveInput4')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                                <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                                    <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                                </g>
                                                                                <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                                    <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                        <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                                    </clipPath>
                                                                                </defs>
                                                                            </svg> </a> <a onclick="document.getElementById('replaceBtnIDSave4').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25"> <input class="subImageClass" type="file" style="display:none;" id="replaceBtnIDSave4" accept="image/png, image/jpg, image/jpeg" data-max-size="20,000,000" onchange="UploadImage('4','mainFrameSave')" /> <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                                <g id="SVGRepo_iconCarrier">
                                                                                    <g>
                                                                                        <g>
                                                                                            <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                            <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                        </g>
                                                                                    </g>
                                                                                </g>
                                                                            </svg> </a> </div>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="add-img-container" data-tooltip-id="9ffa3c45-e3c2-98c1-6b29-8bf6730d0688" onmouseover="hoverIMG('mainFrameSave5')">
                                                                 <input class="subImageClass" type="file" accept="image/png, image/jpg, image/jpeg" style="display:none;" id="mainFrameSaveInput5" data-max-size="20,000,000" onchange="UploadImage('mainFrameSave5','mainFrameSave')" /> <img id="mainFrameSave5" src="https://ami-sni.com/wp-content/themes/consultix/images/no-image-found-360x250.png" alt="img" class="img-fluid" data-tooltip-id="50b5cfda-c987-f2b8-ae6e-ef001613ffb0">
                                                                    <div class="img-action" data-tooltip-id="afd23ac1-054c-c109-6b54-fef2be1c95c6"> <a onclick="removeIMG('mainFrameSave5','mainFrameSaveInput5')" data-tooltip-id="23e71980-6dc6-098e-9beb-cbdc7896f7f2"> <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" data-tooltip-id="ec02ebf8-991e-0395-ce1e-ad54e92b23fa">
                                                                                <g clip-path="url(#clip0_750_81496)" data-tooltip-id="94e78616-e7ce-e65b-0be0-3116a0c4614c">
                                                                                    <path d="M16.2857 9.25L16.2857 19.6667H7.71429L7.71429 9.25H16.2857ZM14.6786 3H9.32143L8.25 4.04167H4.5L4.5 6.125H19.5L19.5 4.04167H15.75L14.6786 3ZM18.4286 7.16667H5.57143L5.57143 19.6667C5.57143 20.8125 6.53571 21.75 7.71429 21.75H16.2857C17.4643 21.75 18.4286 20.8125 18.4286 19.6667L18.4286 7.16667Z" fill="white" data-tooltip-id="11f70e18-300e-1202-a6f7-e41da3bb0627"></path>
                                                                                </g>
                                                                                <defs data-tooltip-id="34669393-3bce-8acd-be82-1d7a335fc25f">
                                                                                    <clipPath id="clip0_750_81496" data-tooltip-id="3726fe14-0afa-234a-37c7-44210fcb1408">
                                                                                        <rect width="24" height="24" fill="white" data-tooltip-id="aa4006dc-1947-ae88-375c-4c486de19418"></rect>
                                                                                    </clipPath>
                                                                                </defs>
                                                                            </svg> </a> <a onclick="document.getElementById('replaceBtnIDSave5').click()" data-tooltip-id="d13b7082-c724-ccd6-cf27-4cb3ae9f0b25"> <input class="subImageClass" type="file" style="display:none;" id="replaceBtnIDSave5" accept="image/png, image/jpg, image/jpeg" data-max-size="20,000,000" onchange="UploadImage('5','mainFrameSave')" /> <svg fill="#ffffff" height="100px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 489.698 489.698" xml:space="preserve" stroke="#ffffff">
                                                                                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                                                                <g id="SVGRepo_iconCarrier">
                                                                                    <g>
                                                                                        <g>
                                                                                            <path d="M468.999,227.774c-11.4,0-20.8,8.3-20.8,19.8c-1,74.9-44.2,142.6-110.3,178.9c-99.6,54.7-216,5.6-260.6-61l62.9,13.1 c10.4,2.1,21.8-4.2,23.9-15.6c2.1-10.4-4.2-21.8-15.6-23.9l-123.7-26c-7.2-1.7-26.1,3.5-23.9,22.9l15.6,124.8 c1,10.4,9.4,17.7,19.8,17.7c15.5,0,21.8-11.4,20.8-22.9l-7.3-60.9c101.1,121.3,229.4,104.4,306.8,69.3 c80.1-42.7,131.1-124.8,132.1-215.4C488.799,237.174,480.399,227.774,468.999,227.774z"></path>
                                                                                            <path d="M20.599,261.874c11.4,0,20.8-8.3,20.8-19.8c1-74.9,44.2-142.6,110.3-178.9c99.6-54.7,216-5.6,260.6,61l-62.9-13.1 c-10.4-2.1-21.8,4.2-23.9,15.6c-2.1,10.4,4.2,21.8,15.6,23.9l123.8,26c7.2,1.7,26.1-3.5,23.9-22.9l-15.6-124.8 c-1-10.4-9.4-17.7-19.8-17.7c-15.5,0-21.8,11.4-20.8,22.9l7.2,60.9c-101.1-121.2-229.4-104.4-306.8-69.2 c-80.1,42.6-131.1,124.8-132.2,215.3C0.799,252.574,9.199,261.874,20.599,261.874z"></path>
                                                                                        </g>
                                                                                    </g>
                                                                                </g>
                                                                            </svg> </a> </div>
                                                                </div>
                                                            </li>
                                                        </ul> <a class="btn slide-right"><i class="las la-angle-right"></i></a>
                                                    </div>
                                                </div>
                                            </div><!-------col-md-4 close------------->
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!------------------------------- Add Div End --------------------------->


    <script type="text/javascript"
          src="${context}/resources/plugins/materialize.js"></script>
    <script type="text/javascript"
          src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
		<script src="${context}/resources/assets/js/custom.js"></script>
	<!-- i18n library -->

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


    <script type="text/javascript" src="${context}/resources/project_js/viewDeviceManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script type="text/javascript" src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>


    <%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%> <script type="text/javascript">
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

</body>

</html> <%
	} else {
%> <script language="JavaScript">
    sessionStorage.setItem("loginMsg",
    "*Session has been expired");
    window.top.location.href = "./login";
</script> <%
}
%>