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

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!--<title>Report UnBlock</title>-->
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='-1'>
<meta http-equiv='pragma' content='no-cache'>
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


<style type="text/css">
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
    textarea.materialize-textarea {
padding: 0 !important;
}
    </style>
<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<!--   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"></script>  
 -->
<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">

<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
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
	href="${context}/resources/project_css/viewStock.css">
	

<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>

<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>
</head>
<body data-roleType="${usertype}" data-userID="${userid}" data-id="7"
	data-selected-roleType="${selectedUserTypeId}" data-userTypeID="${usertypeId}"
	data-username="${username}">



<section id="content">
                <!--start container-->
                 <div id="initialloader"></div>
                <div class="container">
                    <div class="section">
                        <div class="row">
                            <div class="col s12 m12 l12">
                                <div class="row card-panel">
                                    <div id="reportBlockUnblock">
                                        <div class="container-fluid pageHeader">
                                            <p class="PageHeading"><spring:message code="operator.reportUnblock" /></p>
                                        </div>

                                        <div class="row">
                                            <div class="col s12">
                                                <ul class="tabs">
                                                    <li class="tab col s3"><a class="active" onclick="showSingleImeiUnBlock()"><spring:message code="operator.single" /></a>
                                                    </li>
                                                    <li class="tab col s3"><a onclick="showMultipleImeiUnBlock()"><spring:message code="operator.bulk" /></a></li>
                                                </ul>
                                            </div>
                                            <div id="SingleImeiUnBlock" class="col s12" style="margin-top: 30px;display: block">
                                                 <form action="" id="SingleImeiUnBlockform" onsubmit="return submitSingleUnBlockDevicesRequest()" method="POST" enctype="multipart/form-data">
                                                  
                                                        <div class="row">
                                        
                                                            <div class="col s12 m6">
                                                                <label for="deviceType"><spring:message code="operator.devicetype" /></label>
                                                                <select class="browser-default" id="unbockSingledeviceType"
                                                                 oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                                 oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
                                                                    <option value=""  selected><spring:message code="operator.devicetype" /></option> 
                                                                </select>
                                                            </div>
                                                             <div class="col s12 m6"><label for="UnblockdeviceIdType">
                                                                    <spring:message code="operator.deviceidtype" /> <span class="star">*</span></label>
                                                                <select class="browser-default" id="UnblockdeviceIdType" 
                                                                oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                                oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                                                required>
                                                                    <option value="" disabled  selected>
                                                                        <spring:message code="operator.selectdeviceidtype" />
                                                                    </option>
                                                                   
                                                                </select>
                                                            </div>
                                        
                                                            <div class="col s12 m6">
                                                                <label for="deviceType"><spring:message code="registration.selectMultiplestLawfull" /><span class="star">*</span></label>
                                                                <select class="browser-default" required="required" id="unbockSingleMultipleSimStatus" onchange="setContactIMEINumber('unbockSingleMultipleSimStatus','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
                                                                 oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                                 oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
                                                                    <option value=""  selected><spring:message code="operator.multiplesim" /></option>
                                                                   
                                                                </select>
                                                            </div>
                                        
                                                            <div class="input-field col s12 m6" style="margin-top: 23px;">
                                                                <input type="text" id="unbockSingleSerialNumber" name="unbockSingleserialNumber" 
                                                                 pattern="<spring:eval expression="@environment.getProperty('pattern.serialNumber')" />"
                                                                   oninput="InvalidMsg(this,'select','<spring:message code="validation.numberfirst" />');" 
                                                                   oninvalid="InvalidMsg(this,'select','<spring:message code="validation.15serialNo" />');"
                                                                     maxlength="25">
                                                                <label for="serialNumber"><spring:message code="operator.deviceserial" /></label>
                                                            </div>
                                                            
                                                              <div class="col s12 m6"><label for="singleDeviceUnblock"><spring:message code="operator.category" />
                                                            <span class="star">*</span></label>
                                                        <select class="browser-default" id="singleDeviceUnblock"  
                                                     		 oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                     		 oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                                                required  >
                                                            <option value="" disabled selected><spring:message code="operator.selectcategory" />
                                                            </option>
                                                          
                                                        </select>
                                                    </div>
                                                            <div class="input-field col s12 m6" style="margin-top: 27px;">
                                                                <textarea id="unbockSingleRemark"  class="materialize-textarea" 
                                                                oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');" 
                                                                oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
                                                                maxlength="200" required /></textarea>
                                                                <label for="Remark"><spring:message code="input.remarks" /> <span class="star">*</span></label>
                                                            </div>
                                                           
                                                        <div class="row input_fields_wrap">
                                                        <div class="col s12 m12">
                                                   <%--      <div class="col s12 m6">
<p style="margin-top: 3px; margin-bottom: 5px;"><spring:message code="operator.blocking" /></p>
<label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio" id=""
value="Immediate"
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod" checked><spring:message code="operator.immediate" />
</label> <label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio"
value="Default"
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod"><spring:message code="operator.default" />
</label> <label> <input type="radio" value="tilldate" class="blocktypeRadio"
onclick="document.getElementById('calender').style.display = 'block';"
name="stolenBlockPeriod"><spring:message code="operator.later" />
</label>
<div class="col s6 m2 responsiveDiv"
style="display: none; width: 30%; float: right; margin-right: 30%; margin-top: -15px;" id="calender">
<div id="startdatepicker" class="input-group date">
<input type="text" id="stolenDatePeriodUnblock" 
style="margin-top: -9px" /> <span class="input-group-addon"
style="color: #ff4081"><i class="fa fa-calendar"
aria-hidden="true" style="float: right; margin-top: -30px;"></i></span>
</div>
</div>
                                                        </div> --%>
                                                           
                                                            <div id="IMEIndContact1" style="display: none">
                                                             <div class="col s12 m12">
                                                                <p style="margin-bottom: 0;"><spring:message code="title.imeiMeidEsn" /> </p>
                                                            </div>
                                                            <div class="input-field col s12 m6">
                                                                           <input type="text" id="unbockSingleIMEI1"  name="IMEI1" pattern="[0-9]{15,16}" 
                                                                   oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');" 
                                                                   oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                required   maxlength="16">
                                                                <label for="IMEI1"><spring:message code="title.one" /> <span class="star">*</span></label>
                                                                 <p id="errorMsgOnModal" class="deviceErrorTitle" style="margin-top:-75px;margin-left:115px;"></p>
                                                            </div></div>
                                                             <div id="IMEIndContact2" style="display: none">
                                        
                                                            <div class="input-field col s12 m6">
                                                                                            <input type="text" id="unbockSingleIMEI2" name="IMEI2" pattern="[0-9]{15,16}" 
                                                                   oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');" 
                                                                   oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                    maxlength="16">
                                                                <label for="IMEI2"><spring:message code="title.two" /></label>
                                                            </div>  </div>
                                                             <div id="IMEIndContact3" style="display: none">
                                                            
                                                            <div class="input-field col s12 m6">
                                                          <input type="text" id="unbockSingleIMEI3" name="IMEI3" pattern="[0-9]{15,16}" 
                                                                   oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');" 
                                                                   oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                   maxlength="16">
                                                                <label for="IMEI3"><spring:message code="title.three" /></label>
                                                              
                                                            </div></div>
            												 <div id="IMEIndContact4" style="display: none">
                                                            <div class="input-field col s12 m6">
                                                      <input type="text" id="unbockSingleIMEI4" name="IMEI4[]" pattern="[0-9]{15,16}"
                                                                   oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');" 
                                                                   oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                 maxlength="16">
                                                                <label for="IMEI4"><spring:message code="title.four" /></label>
                                                            </div></div>
                                                        	<div class="col s12 m12"><span><spring:message code="input.requiredfields" /> <span class="star">*</span></span></div>
                                                         </div>
                                                        </div>
                                                        
                                                       
                                                    </div>

                                                    

                                                    <div class="input-field col s12 center">
                                                      <button class="btn" id="singleUnblockSubmitButton" type="submit"><spring:message code="button.submit" /></button>
                                                        <a href="./stolenRecovery" class="btn" style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
                                                 
                                                                 </div>
                                                </form>
                                            </div>
                                            <div id="multipleImeiUnBlock" class="col s12" style="display: none">
                                             <form action="" id="multipleImeiUnBlockform" onsubmit="return submitUnBlockImei()" method="POST" enctype="multipart/form-data">
                                                    
                                                     <div class="col s12 m6"><label for="bulkBlockdeviceCategory"><spring:message code="operator.category" />
                                                            <span class="star"> *</span></label>
                                                        <select class="browser-default" id="bulkunBlockdeviceCategory"  
                                                        oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                                         required>
                                                            <option value="" disabled selected><spring:message code="operator.selectcategory" />
                                                            </option>
                                                          
                                                        </select>
                                                    </div>
                                                    <div class="input-field col s12 m6 " style="margin-top: 22px;">
                                                        <input type="text" id="unblockbulkquantity" name="quantity" 
                                                         pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
                                                        oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');" 
                                                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
                                                        required >
                                                        <label for="unblockbulkquantity"><spring:message code="input.quantity" /> <span class="star"> *</span></label>
                                                    </div>
                                                    
                                                    <div class="input-field col s12 m6 " style="margin-top: 28px;">
                                                        <input type="text" id="unblockbulkDevicequantity" name="unblockbulkDevicequantity" 
                                                         pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />" 
                                                        oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');" 
                                                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
                                                        required>
                                                        <label for="unblockbulkDevicequantity"><spring:message code="input.devicequantity" /> <span class="star"> *</span></label>
                                                    </div>
                                                    
                                                    <div class="file-field input-field col s12 m6" style="margin-top: -75px;">
                                                        <p style="color: #000;"><spring:message code="operator.upload" /> <span class="star"> *</span></p>
                                                        <div class="btn">
                                                            <span><spring:message code="operator.file" /></span>
                                                            <input type="file" id="unblockBulkFile"  onchange="blockfileTypeValueChanges()"
                                                           oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');" 
                                                           oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');" 
                                                            required >
                                                        </div>
                                                        <div class="file-path-wrapper">
                                                            <input class="file-path validate" type="text" id="unblockFileName" placeholder="">
                                                        </div>
                                                    </div>

                                                    <div class="input-field col s12 m6" style="margin-top: 62px;">
                                                        <textarea id="unblockbulkRemark" class="materialize-textarea" maxlength="200" 
                                                        oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');" 
                                                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
                                                        required ></textarea>
                                                        <label for="unblockbulkRemark"><spring:message code="input.remarks" /> <span class="star">*</span></label>
                                                    </div>
                                                    
                                                <p style="margin-left: 10px;"><a href="./Consignment/sampleFileDownload/7"><spring:message code="input.downlaod.sample" /></a></p>
                                                    <span style="margin-left: 5px;"><spring:message code="input.requiredfields" /> <span class="star"> *</span></span>
                                                
                                                   <div class="input-field col s12 center">
                                                <button class="btn " id="bulkUnblockSubmitButton" type="submit"><spring:message code="button.submit" /></button>
                                                        <a href="./stolenRecovery" class="btn" style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
                                                    
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
                <!--end container-->
            </section>


    <div id="markAsUnblock" class="modal">
            <h6 class="modal-header"><spring:message code="operator.markunblock" /></h6>
        <div class="modal-content">
         <div class="row">
                <h6 id="saveSingleMsg"><spring:message code="operator.markedwith" /> <span id="txnIdblocksingleDevice"></span></h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a href="./stolenRecovery" class="btn"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>
    
    
    <div id="markBulkAsUnblock" class="modal">
        <h6 class="modal-header"><spring:message code="operator.markunblock" /></h6>
        <div class="modal-content">
         <div class="row">
                <h6 id="bulkSaveSucessMsg"><spring:message code="operator.markedwith" /> <span id="txnIdUnblocksingleDevice"></span></h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a href="./stolenRecovery" class="btn"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>
    
    <div id="fileFormateModal" class="modal">
		<h6 class="modal-header"><spring:message code="fileValidationModalHeader" /></h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="fileErrormessage"><spring:message code="fileValidationName" /><br> <br> <spring:message code="fileValidationFormate" /> <br><br> <spring:message code="fileValidationSize" /> </h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close waves-effect waves-light btn" onclick="blockfileClearName()"
							style="margin-left: 10px;"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	

<!--materialize js-->
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>
	
<script type="text/javascript"
	src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>





	<script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	
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

	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

<script type="text/javascript"
src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>	

<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
		<script type="text/javascript"
		src="" async></script>
		

		
			<script type="text/javascript"
			src="${context}/resources/project_js/reportBlock.js?version=<%= (int) (Math.random() * 10) %>"></script>

		
		
		
		
		
		
		<script type="text/javascript">
		window.parent.$('#langlist').on('change', function() {
			var lang=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
			
			window.location.assign("openBlockUnblockPage?pageType=block&lang="+lang);
		}); 
		
		var langParam=window.parent.$('#langlist').val() == 'km' ? 'km' : 'en';
		$.i18n().locale = langParam;
		var successMsg;
		$.i18n().load( {
			'en': './resources/i18n/en.json',
			'km': './resources/i18n/km.json'
		} ).done( function() { 
		//	successMsg=$.i18n('successMsg');
		});

		
		
		$(document).ready(function () {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajaxSetup({
			headers:
			{ 'X-CSRF-TOKEN': token }
			});


			$.getJSON('./getDropdownList/DEVICE_TYPE', function(data) {
					
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].value).text(data[i].interp)
						.appendTo('#unbockSingledeviceType');
						////console.log.log('#unbockSingledeviceType')
					}
				});

				$.getJSON('./getDropdownList/LAWFULL_SIM_STATUS', function(data) {
					
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].value).text(data[i].interp)
						.appendTo('#unbockSingleMultipleSimStatus');
						//console.log('#unbockSingleMultipleSimStatus');
					}
				});
				
				$.getJSON('./getDropdownList/DEVICE_ID_TYPE', function(data) {
					
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].value).text(data[i].interp)
						.appendTo('#UnblockdeviceIdType');
						//console.log('#UnblockdeviceIdType');
					}
				});
				
				$.getJSON('./getTypeDropdownList/BLOCK_CATEGORY/'+$("body").attr("data-userTypeID"), function(data) {
					
					for (i = 0; i < data.length; i++) {
						$('<option>').val(data[i].value).text(data[i].interp)
						.appendTo('#bulkunBlockdeviceCategory');
						//console.log('#bulkunBlockdeviceCategory');
						$('<option>').val(data[i].value).text(data[i].interp)
						.appendTo('#singleDeviceUnblock');
						//console.log('#singleDeviceUnblock');
						
					}
				});
				
				
				var timeoutTime = <%=session.getLastAccessedTime()%>;
				var timeout = <%=session.getMaxInactiveInterval()%>;
				timeoutTime += timeout;
				var currentTime;
				$("body").click(function(e) {
				$.ajaxSetup({
				headers:
				{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }
				});
				$.ajax({
				url: './serverTime',
				type: 'GET',
				async: false,
				success: function (data, textStatus, jqXHR) {
				currentTime = data;
				},
				error: function (jqXHR, textStatus, errorThrown) {}
				});
				if( currentTime > timeoutTime ){
				window.top.location.href = "./login";
				}else{
				timeoutTime += timeout;
				}
				});
				
		});
		
		
		 $('#stolenDatePeriodUnblock').datepicker({
	        	dateFormat: "yy-mm-dd"
	        	});
		 
		 
		 function blockfileTypeValueChanges() {
				var uploadedFileName = $("#unblockBulkFile").val();
				uploadedFileName = uploadedFileName.replace(/^.*[\\\/]/, '');
				var ext = uploadedFileName.split('.').pop();

				var fileSize = ($("#unblockBulkFile")[0].files[0].size);
				fileSize = (Math.round((fileSize / 1024) * 100) / 100)
				if (uploadedFileName.length > 30) {
					$('#fileFormateModal').openModal({dismissible:false});

				} 
				else if(ext!='csv')
				{
					$('#fileFormateModal').openModal({
						dismissible:false
					});

				}
				else if(fileSize>='10000'){
					$('#fileFormateModal').openModal({
						dismissible:false
					});

				}



			}


			function blockfileClearName() {
				$('#unblockFileName').val('');
				$("#blockBulkFile").val('');
				$("#unblockBulkFile").val('');
				$('#fileFormateModal').closeModal();
			}
			
			$("input[type=file]").keypress(function(ev) {
			    return false;
			    //ev.preventDefault(); //works as well

			});
			$('div#initialloader').delay(300).fadeOut('slow');
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
} else {

%>
<script language="JavaScript">
sessionStorage.setItem("loginMsg",
"*Session has been expired");
window.top.location.href = "./login";
</script>
<%
}
%>