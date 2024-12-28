<%@ page import="java.util.Date" %>
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
	 long currentTime= new Date().getTime(); 
	 long dfd= accessTime +timeout;
	 if( currentTime< dfd){
	/*  response.setHeader("Refresh", timeout + "; URL = ../login");
	 System.out.println("timeout========"+timeout); 
	if (session.getAttribute("usertype") != null) { */
%>

<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!-- Security Tags -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:csrfMetaTags />
<!-- Security Tags -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head><title>EIRS Portal</title>
<!--<title>Company Recovery</title>-->

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="" name="description" />
<meta content="" name="author" />
<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- Security Tags -->

<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">


<!-- Custome CSS-->
<link href="" type="text/css"
	rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
<link href="${context}/resources/plugins/prism/prism.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<link rel="stylesheet"
	href="${context}/resources/project_css/stolenRecovery.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="${context}/resources/project_css/intlTelInput.css">

<style>
        .checkboxFont {
            color: #444;
            font-size: 16px;
            margin-right: 10px;
        }

        .section {
            padding-top: 0.5rem;
        }

        .welcomeMsg {
            padding-bottom: 50px !important;
            line-height: 1.5 !important;
            text-align: center;
        }

        .file-label {
           font-size: 0.9rem;
       }

       .contact-label {
            margin-top: -17px;
            margin-bottom: 0;
            font-size: 0.8rem;
        }
    </style>



</head>

<body data-id="5" data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-operatorTypeId="${operatorTypeId}"
	data-selected-roleType="${stolenselectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-txnID="${not empty param.txnId ? param.txnId : 'null'}"
	data-source="${not empty param.reqSource ? param.reqSource : 'null'}"	>





        <!-- START CONTENT -->
            <section id="content">
            	 <div id="initialloader"></div>
                <!--start container-->
                <div class="container">
                    <div class="section">
                        <div class="row">
                            <div class="col s12 m12 l12">
                                <div class="row card-panel">
                                    <div id="reportBlockUnblock">
                                        <div class="container-fluid pageHeader">
                                            <p id="headingType" class="PageHeading"> <spring:message code="registration.updatereportstolen" /></p>
                                        </div>

                                      <!--   <div class="row">
                                            <div class="col s12">
                                                <ul class="tabs">
                                                    <li class="tab col s3"><a class="active" onclick="singleRecoverydiv()">Single</a>
                                                    </li>
                                                    <li class="tab col s3"><a onclick="showBulkRecovery()">Company/Organisation/Government</a></li>
                                                </ul>
                                            </div> -->
                                            <div id="singleRecoveryDiv" class="col s12" style="margin-top: 30px; display: none">
                                                <form action="#" id="singleRecoveryForm">
                                                    <div class="row">
                                                        <div class="col-s12 m12">
                                                             <div class="input-field col s12 m6" style="margin-top: 22px;">
                                                                <input type="text" name="sigleRecoverydeviceBrandName" id="sigleRecoverydeviceBrandName" maxlength="30">
                                                                <label for="sigleRecoverydeviceBrandName"> <spring:message code="registration.devicebrandname" /></label>
                                                            </div>

                                                            <div class="input-field col s12 m6" style="margin-top: 22px;">
                                                                <input type="text" name="sigleRecoveryimeiNumber" id="sigleRecoveryimeiNumber" maxlength="30">
                                                                <label for="sigleRecoveryimeiNumber"> <spring:message code="registration.imei/meid/esnnumber" /><span class="star">*</span></label>
                                                            </div>

                                                            <div class="col s6 m6 selectDropdwn">
                                                                <label for="sigleRecoverydeviceIDType"><spring:message code="select.deviceIDType" /> <span class="star">*</span></label>
                                                                <select id="sigleRecoverydeviceIDType" class="browser-default">
                                                                  <option value="" disabled selected><spring:message code="select.deviceIDType" /></option>
                                                                </select>
                                                              </div>

                                                              <div class="col s6 m6 selectDropdwn">
                                                                <label for="sigleRecoverydeviceType"> <spring:message code="select.deviceType" /></label>
                                                                <select class="browser-default" id="sigleRecoverydeviceType">
                                                                    <option value="" disabled selected><spring:message code="select.deviceType" /></option>
                                                                </select>
                                                              </div> 
                                                              
                                                              <div class="col s6 m6 selectDropdwn">
                                                                <label for="sigleRecoverydeviceSimStatus"> <spring:message code="select.multiSimStatus" /></label>
                                                                <select id="sigleRecoverydeviceSimStatus" class="browser-default">
                                                                  <option value="" disabled selected><spring:message code="select.multiSimStatus" /></option>
                                                                </select>
                                                              </div>

                                                              <div class="input-field col s12 m6" style="margin-top: 22px;">
                                                                <input type="text" name="sigleRecoveryserialNumber" id="sigleRecoveryserialNumber" maxlength="30">
                                                                <label for="sigleRecoveryserialNumber"><spring:message code="input.deviceSerialNumber" /></label>
                                                            </div>

                                                            <div class="col s12 m12" style="margin-top: 30px;">
                                                                <h5><spring:message code="registration.placeofdevicerecovery" /></h5>
                                                                <hr>
                                                            </div>
                                                            <!-- <div class="col s12 m12">
                                                                <p><b>Place Of Device Recovery</b></p>
                                                            </div> -->
                                                            <div class="input-field col s12 m12">
                                                                <input type="text" name="sigleRecoveryaddress" class="form-control boxBorder boxHeight"
                                                                     pattern=[A-Za-z] title="Please enter your address">
                                                                <label for="sigleRecoveryaddress"><spring:message code="input.address" /> <span class="star">*</span></label>
                                                            </div>
                            
                                                            <div class="input-field col s12 m6 l6">
                                                                <input type="text" name="sigleRecoverystreetNumber" class="form-control boxBorder boxHeight"
                                                                    id="sigleRecoverystreetNumber" maxlength="30" pattern=[A-Za-z0-9] title="Please enter street number">
                                                                <label for="sigleRecoverystreetNumber"><spring:message code="input.streetNumber" /> <span class="star">*</span></label>
                                                            </div>
        
                                                            <div class="input-field col s12 m6 l6">
                                                                <input type="text" name="sigleRecoveryvillage" id="sigleRecoveryvillage" maxlength="20">
                                                                <label for="sigleRecoveryvillage"><spring:message code="input.village" /> <span class="star">*</span></label>
                                                            </div>
                            
                                                            <div class="input-field col s12 m6 l6">
                                                                <input type="text" name="sigleRecoverylocality" class="form-control boxBorder boxHeight"
                                                                    id="sigleRecoverylocality" maxlength="20" pattern=[A-Za-z0-9] title="Please enter your locality">
                                                                <label for="sigleRecoverylocality"><spring:message code="input.locality" />  <span class="star">*</span></label>
                                                            </div>
                                
                                                            <div class="input-field col s12 m6 l6">
                                                                <input type="text" name="sigleRecoverydistrict" id="sigleRecoverydistrict" maxlength="20">
                                                                <label for="sigleRecoverydistrict"><spring:message code="input.district" /> <span class="star">*</span></label>
                                                            </div>
                                
                                                            <div class="input-field col s12 m6 l6">
                                                                <input type="text" name="sigleRecoverycommune" id="sigleRecoverycommune" maxlength="20">
                                                                <label for="sigleRecoverycommune"><spring:message code="input.commune" /> <span class="star">*</span></label>
                                                            </div>
                                
                                                            <div class="input-field col s12 m6 l6">
                                                                <input type="text" name="sigleRecoverypin" class="form-control boxBorder boxHeight"
                                                                    id="sigleRecoverypin" maxlength="6">
                                                                <label for="sigleRecoverypin"><spring:message code="input.postalCode" /> <span class="star">*</span></label>
                                                            </div>
                            
                                                            <div class="col s12 m6 l6">
                                                                <label><spring:message code="table.country" /> <span class="star">*</span></label>
                                                                <select id="country1" class="browser-default" class="mySelect"
                                                                    style="padding-left: 0;" required></select>
                                                            </div>
                            
                                                            <div class="col s12 m6 l6">
                                                                <label> <spring:message code="input.province" /><span class="star">*</span></label>
                                                                <select id="state1" class="browser-default" class="mySelect" style="padding-left: 0;"
                                                                    required></select>
                                                            </div>

                                                            <div class="col s6 m6 selectDropdwn">
                                                                <label for="sigleRecoverydeviceStatus"><spring:message code="select.deviceStatus" /> <span class="star">*</span></label>
                                                                <select id="sigleRecoverydeviceStatus" class="browser-default">
                                                                  <option value="" disabled selected><spring:message code="select.deviceStatus" /></option>
                                                                </select>
                                                              </div>

                                                            <div class="input-field col s12 m6">
                                                                <textarea id="sigleRecovery" class="materialize-textarea"></textarea>
                                                                <label for="sigleRecovery"><spring:message code="input.remarksLawfull" /> </label>
                                                            </div>
                                                            </div>
                                                        </div>
                                                    <p> <spring:message code="input.requiredfields" /> <span class="star">*</span></p>


                                                    <div class="input-field col s12 center">
                                                        <button class="btn modal-trigger" data-target="submitStolen"><spring:message code="button.submit" /></button>
                                                        <a href="./stolenRecovery" class="btn"
                                                            style="margin-left: 10px;"><spring:message code="modal.cancel" /></a>
                                                    </div>
                                                </form>
                                            </div>
                                    </div>
<!-- ---------------------------------------------------------- bulk recovery edit------------------------------------------------------------------------- -->                                    
                                           
                                            <div id="bulkRecoveryDiv" class="col s12 m12" style="display: block">
                                                <form action="#" style="margin-top: 30px;" onsubmit="return updateCompanyRecoveryRequest()" method="POST" enctype="multipart/form-data"  id="">
                                                    <div class="input-field col s12 m6 l6" style="margin-top: 20px;">
                                                        <input type="text" name="bulkRecoveryquantity" required="required" class="form-control boxBorder boxHeight" placeholder=""
                                                              oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');" 
                                                            oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
                                                            id="bulkRecoveryquantity"
                                                            pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
                                                            title="Please enter number up to 7 digits">
                                                        <label for="bulkRecoveryquantity"><spring:message code="operator.quantity" /> <span class="star">*</span></label>
                                                    </div>
                                                    
                                            <div class="col s12 m6 l6"
												style="margin-top: -2px;">
												<label for="devicequantity" id="devicequantityLabel" class="active"> <spring:message
														code="input.devicequantity" /><span class="star">*</span></label>
												<input type="text" name="devicequantity"
													class="form-control boxBorder boxHeight" 
													id="devicequantity"
													pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
													required> 
											</div>
											
<input type="text" id="pageViewType" value="${viewType}" style="display: none;">
<input type="text" id="existingStolenTxnId" style="display:none" value="${stolenTxnId}" >
                                                    <div class="input-field col s12">
                                                        <textarea id="bulkRecoveryRemark"oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
                                                          oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
                                                          maxlength="10000"
                                                           class="materialize-textarea" placeholder=""></textarea>
                                                        <label for="bulkRecoveryRemark"><spring:message code="input.remarksLawfull" /></label>
                                                    </div>
                                                    
                                                    <div class="input-field col s12 m6" style="display: none;" id="bulkRecoveryRemarkRejectDiv">
                                                        <textarea id="bulkRecoveryRemarkReject"oninput="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
                                                          oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10000characters" />');"
                                                          maxlength="10000"
                                                           class="materialize-textarea" placeholder=""></textarea>
                                                        <label for="bulkRecoveryRemarkReject"><spring:message code="input.remarksRejected" /></label>
                                                    </div>

                                                    <div class="file-field col s12 m6">
                                                        <h6 style="margin: 2px;"><spring:message code="registration.uploadfile" /></h6>
                                                        <div class="btn" id="bulkRecoveryFileDiv">
                                                            <span id="bulkRecoveryFileText"><spring:message code="input.selectfile" /></span>
                                                            <input type="file" onchange="isFileValid('bulkRecoveryFile')"
                                                             oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');" 
                                                            oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
                                                               accept=".csv"
                                                             onchange="isFileValid('bulkRecoveryFile')" id="bulkRecoveryFile" placeholder="Upload Photo">
                                                        </div>
                                                        <div class="file-path-wrapper">
                                                            <input class="file-path validate" type="text" id="bulkRecoveryFileName" placeholder="<spring:message code="registration.uploadfile" />"
                                                                 title="Please upload your photo">
                                                                 <a href="#" id="bulkRecoveryFileLink" style="display: none;"><spring:message code="input.preView" /></a>
                                                        </div>
                                                    </div>
                                                    
                                                    
<%--                                                      <div class="col s12 m6">
<p style="margin-top: 3px; margin-bottom: 5px"><spring:message code="operator.blocking" /></p>
<label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio" id=""
value="Immediate"
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod" checked><spring:message code="operator.immediate" />
</label> <label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio"
value="Default"
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod"><spring:message code="operator.default" />
</label> <label> <input type="radio" required="required" value="tilldate" class="blocktypeRadio"
onclick="document.getElementById('calender').style.display = 'block';"
name="stolenBlockPeriod"><spring:message code="operator.later" />
</label>
<div class="col s6 m2 responsiveDiv"
style="display: none; width: 30%; margin-right: 30%; float: right; margin-top: -15px" id="calender">
<div id="startdatepicker" class="input-group date">
<input type="text" id="stolenDatePeriod"
style="margin-top: -9px" /> <span class="input-group-addon"
style="color: #ff4081"><i class="fa fa-calendar"
aria-hidden="true" style="float: right; margin-top: -30px;"></i></span>
</div>

</div>


<div class="col s12 m2 l2" style="width: 40%; display: none; float: right; margin-right:30%;"
id="stolenDate">

<label for="TotalPrice" class="center-align"><spring:message code="operator.tilldate" /></label>
<div id="startdatepicker" class="input-group" style="margin-top: 10px;">

<input class="form-control" name="inputsaves" type="text"
id="startDateFilter" readonly /> <span class="input-group-addon"
style="color: #ff4081"><i
class="glyphicon glyphicon-calendar"
onclick="_Services._selectstartDate()"></i></span>
</div>
</div>
</div> --%>

                                                   <div class="col s12 m12">
                                                       <a id="sampleFileDownload" href="./Consignment/sampleFileDownload/7"><spring:message code="input.downlaod.sample" /></a>
                                                   </div>

                                                   <div class="col s12 m12" style="margin-top: 30px;">
                                                    <h5><spring:message code="registration.placeofdevicerecovery" /></h5>
                                                    <hr>
                                                </div>
                                                    <!-- <div class="col s12 m12">
                                                        <p><b>Place Of Device Recovery</b></p>
                                                    </div> -->
                                                    <div class="input-field col s12 m12">
                                                        <input type="text" name="bulkRecoveryaddress" class="form-control boxBorder boxHeight" placeholder=""
                                                            id="bulkRecoveryaddress" 
                                                            pattern="<spring:eval expression="@environment.getProperty('pattern.address')" />"
                                                            title="" oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
                                                           oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
                                                             maxlength="200" required="required">
                                                        <label for="bulkRecoveryaddress"><spring:message code="input.address" /> <span class="star">*</span></label>
                                                    </div>
                    								
                    								<div class="col s12 m6 l6">
                                                        <label><spring:message code="table.country" /> <span class="star">*</span></label>
                                                        <select id="bulkRecoverycountry" class="browser-default" class="mySelect"
                                                        oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                                            style="padding-left: 0;" required></select>
                                                    </div>
                    
                                                    <div class="col s12 m6 l6">
                                                        <label> <spring:message code="input.province" /><span class="star">*</span></label>
                                                        <select id="bulkRecoverystate"  onchange="getDistrict(this,'bulkRecoverydistrict','bulkRecoverycommune');"
                                                        oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                                        class="browser-default" class="mySelect" style="padding-left: 0;"
                                                            required></select>
                                                    </div>
                                                    
                                                    <div class="col s12 m6 l6">
                                                        <%-- <input type="text" name="bulkRecoverydistrict" id="bulkRecoverydistrict" placeholder="" pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title=""
                                                             oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
                                                       oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
                                                             maxlength="30" required="required"> --%>
                                                        <label for="bulkRecoverydistrict"><spring:message code="input.district" /> <span class="star">*</span></label>
                                                        <select
										id="bulkRecoverydistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'bulkRecoverycommune','bulkRecoveryvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option></select>
                                                    </div>
                        
                                                    <div class="col s12 m6 l6">
                                                       <%--  <input type="text" name="bulkRecoverycommune" id="bulkRecoverycommune" placeholder="" pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title=""
                                                         oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
                                                       oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
                                                             maxlength="30" required="required"> --%>
                                                        <label for="bulkRecoverycommune"> <spring:message code="input.commune" /><span class="star">*</span></label>
                                                        <select
										id="bulkRecoverycommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'bulkRecoveryvillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option></select>
                                                    </div>
                                                    
                                                    <div class="col s12 m6 l6">
                                                        <%-- <input type="text" name="bulkRecoveryvillage" id="bulkRecoveryvillage" placeholder="" pattern="[a-zA-Z0-9\s,'*$-]{0,30}" title=""
                                                             oninput="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
                                                       oninvalid="InvalidMsg(this,'input','<spring:message code="validation.address30characters" />');"
                                                             maxlength="30"> --%>
                                                        <label for="bulkRecoveryvillage"><spring:message code="input.village" /> <span class="star"></span></label>
                                                        <select
										id=bulkRecoveryvillage class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
                                                    </div>
                    								
                                                    <div class="input-field col s12 m6 l6">
                                                        <input type="text" name="bulkRecoverystreetNumber" class="form-control boxBorder boxHeight" placeholder=""
                                                            id="bulkRecoverystreetNumber" title=""
                                                            pattern="<spring:eval expression="@environment.getProperty('pattern.street')" />"
                                                             oninput="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
                                                       oninvalid="InvalidMsg(this,'input','<spring:message code="validation.streetNumber" />');"
                                                            required="required">
                                                        <label for="bulkRecoverystreetNumber"><spring:message code="input.streetNumber" /> <span class="star">*</span></label>
                                                    </div>

                                                    
                    
                                                    <div class="input-field col s12 m6 l6" style="margin-left:1px;">
                                                        <input type="text" name="bulkRecoverylocality" class="form-control boxBorder boxHeight" placeholder=""
                                                            id="bulkRecoverylocality" title=""
                                                            pattern="<spring:eval expression="@environment.getProperty('pattern.locality')" />"
                                                             oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
                                                       oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
                                                            >
                                                        <label for="bulkRecoverylocality"> <spring:message code="input.locality" /><span class="star"></span></label>
                                                    </div>
                        
                                                    
                        
                                                    <div class="input-field col s12 m6 l6" style="margin-right: -1px;">
                                                        <input type="text" name="bulkRecoverypin"  placeholder="" class="form-control boxBorder boxHeight"
                                                            id="bulkRecoverypin" title="" 
                                                            pattern="<spring:eval expression="@environment.getProperty('pattern.postal')" />"
                                                            oninput="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');" 
                                                             oninvalid="InvalidMsg(this,'input','<spring:message code="validation.6digit" />');"
                                                          >
                                                        <label for="bulkRecoverypin"> <spring:message code="input.postalCode" /><span class="star"></span></label>
                                                    </div>
                    
                                                    
                                                    
                                                     <div class="input-field col s12 m6"> 
											<input type="text" name="deviceRecoveryDevice" placeholder=""
												id='bulkRecoveryDate' class='form-control datepick'
												autocomplete='off' 
												title="<spring:message code="validation.requiredMsg" />"  required /> 
												<label
												for="deviceRecoveryDevice" class="center-align"><spring:message code="operator.recoveryDate" /> <span class="star">*</span>
											</label> <span class="input-group-addon" style="color: #ff4081"><i
												class="fa fa-calendar" aria-hidden="true"></i></span>
										</div>

                                                    <div class="col s12 m12">
                                                        <p><spring:message code="input.requiredfields" /> <span class="star">*</span></p>
                                                    </div>

                                                    <div class="input-field col s12 center">
                                                        <button class="btn" type="submit" id="editCompanyRecoveryButton"><spring:message code="button.submit" /></button>
                                                        <a  onclick="closeViewPage()" class="btn"
                                                            style="margin-left: 10px;"><spring:message code="modal.cancel" /></a>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                 	 <div id="stolenSucessPopUp" class="modal">
  <h6 class="modal-header"><spring:message code="registration.updatereportstolen" /></h6>
        <div class="modal-content">
           
            <div class="row">
                <h6 id="dynamicMessage"><spring:message code="input.Theupdated" /></h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <div class="input-field col s12 center">
                        <a  href ="./stolenRecovery?FeatureId=5" class=" btn"><spring:message code="modal.ok" /></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
                <!--end container-->
            </section>


 <div id="fileFormateModal" class="modal">
		<h6 class="modal-header"><spring:message code="fileValidationModalHeader" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="fileErrormessage"><spring:message code="fileValidationName" /><br> <br> <spring:message code="fileValidationFormate" /> <br><br> <spring:message code="fileValidationSize" /> </h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close  btn" onclick="clearFileName()"
							style="margin-left: 10px;"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div id="viewuplodedModel" class="modal" style="overflow: hidden">
	<a href="#!" class="modal-close waves-effect waves-green btn-flat">&times;</a>
		<div class="modal-content">
			<div class="row">
					<img src="" id="fileSource" width="400" height="400">
			</div>
		</div>
	</div>
	
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>


	<script type="text/javascript"
		src=""></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>



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
	
	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
		<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>




	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	

		<script type="text/javascript"
		src="${context}/resources/project_js/provinceDropdown.js?version=<%= (int) (Math.random() * 10) %>" async></script>      
<script type="text/javascript"
		src="${context}/resources/project_js/CommanLocality.js?version=<%= (int) (Math.random() * 10) %>"></script>

		<script type="text/javascript"
		src="${context}/resources/project_js/editCompanyRecovery.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/lawfulStolenRecovery.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script>
		
		
		$.i18n().load( {
			'en': './resources/i18n/en.json',
			'km': './resources/i18n/km.json'
		}).done( function() { 
			recoveryCompany=$.i18n('recoveryCompany');
			editrecoveryCompany=$.i18n('editrecoveryCompany');
			
			viewPageType()
		});
		
        function viewPageType() {
            if($('#pageViewType').val()=='view')
            	{
            	
            	   $("#bulkRecoveryFileDiv").removeClass("btn");
            	   $('#bulkRecoveryFileText').text('');
            	   $('#bulkRecoveryFile').attr('type','text');
            	  // $("#bulkRecoveryFileLink").css("display", "block");
            	   $("#sampleFileDownload").css("display", "none");
            	   $("#bulkRecoveryFile").css("display", "none");
            	   
            	    
            	$('#headingType').text('');
            	$('#headingType').text(recoveryCompany);
            	  $("#bulkRecoveryDiv").find("input,select,textarea,button").prop("disabled",true);
            	  $("#bulkRecoveryDiv").find("select").attr("style", "pointer-events: none;");
            	  $("#editCompanyRecoveryButton").css("display", "none");
          		$(".star").css("display", "none");
          		 $("#bulkRecoveryRemarkRejectDiv").css("display", "block");
          		
            	}
            else{
            	$("#bulkRecoveryRemarkRejectDiv").css("display", "none");
            	$('#headingType').text('');
            	$('#headingType').text(editrecoveryCompany);
            	  $("#bulkRecoveryDiv").find("input,select,textarea,button").prop("disabled",false);
            	  $("#singleRecoveryDiv").find("select").attr("style", "pointer-events: none;");
            }
          
      }
		
		$('.datepick').datepicker({
			dateFormat : "yy-mm-dd",
			maxDate:"0"
		});
		
		$('#stolenDatePeriod').datepicker({
        	dateFormat: "yy-mm-dd"
        	});


    populateCountries(
        "country1",
        "state1"
    );
    populateStates(
        "country1",
        "state1"
    );
    
    populateCountries(
            "bulkRecoverycountry"
        );
        populateStates(
            "bulkRecoverycountry",
            "bulkRecoverystate"
        );
        
        $('#Stolenstartdatepicker').datepicker({
        	dateFormat: "yy-mm-dd"
        	});
    	setDropdownProviance('bulkRecoverystate');
        $("label[for='devicequantity']").addClass('active');
</script>
		

<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
<script type="text/javascript">var countHit="";  $( document ).ready(function() {   if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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

</body></html>
<%
	}else{
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