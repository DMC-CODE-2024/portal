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
<!--<title>Report Block</title>-->
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

	
<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">


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
    </style>
<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<!--   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"></script>  
 -->

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
<body data-id="7" data-roleType="${usertype}" data-userID="${userid}"
	data-selected-roleType="${selectedUserTypeId}" data-userTypeID="${usertypeId}"
	data-username="${username}">


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
                                            <p class="PageHeading"><spring:message code="operator.report" /></p>
                                            
                                        </div>

                                        <div class="row">
                                            <div class="col s12">
                                                <ul class="tabs">
                                                    <li class="tab col s3"><a class="active" onclick="showSingleImeiBlock()"><spring:message code="operator.single" /></a>
                                                    </li>
                                                    <li class="tab col s3"><a onclick="showMultipleImeiBlock()"><spring:message code="operator.bulk" /></a></li>
                                                </ul>
                                            </div>
                                            <div id="SingleImeiBlock" class="col s12" style="display:block; margin-top: 30px;">
                                                 <form action="" id="SingleImeiBlockform" onsubmit="return submitSingleBlockDevicesRequest()" method="POST" enctype="multipart/form-data">
                                                    <div class="row">
                                                        <div class="row">
                                        
                                                            <div class="col s12 m6">
                                                                <label for="blockdeviceType"><spring:message code="operator.devicetype" /></label>
                                                                <select class="browser-default" id="blockdeviceType" 
                                                                oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                                oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" >
                                                                    <option value=""  selected><spring:message code="operator.devicetype1"/></option> 
                                                                    
                                                                </select>
                                                            </div>
                                                            <div class="col s12 m6"><label for="blockdeviceIdType">
                                                                    <spring:message code="operator.deviceidtype" /> <span class="star">*</span></label>
                                                                <select class="browser-default" id="blockdeviceIdType" 
                                                                 oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                                 oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                                              			required >
                                                                    <option value="" disabled selected>
                                                                        <spring:message code="operator.selectdeviceidtype"/>
                                                                    </option>
                                                                   
                                                                </select>
                                                            </div>
                                        
                                                            <div class="col s12 m6">
                                                                <label for="blockmultipleSimStatus"><spring:message code="registration.selectMultiplestLawfull" /> <span class="star">*</span></label>
                                                                <select class="browser-default" required="required" id="blockmultipleSimStatus" onchange="setContactIMEINumber('blockmultipleSimStatus','IMEIndContact1','IMEIndContact2','IMEIndContact3','IMEIndContact4')"
                                                                 oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                                 oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');">
                                                                    <option value=""  selected><spring:message code="operator.multiplestatus" /></option>
                                                                    
                                                                </select>
                                                            </div>
                                        
                                                            <div class="input-field col s12 m6" style="margin-top: 23px;">
                                                                <input type="text" id="singleblockserialNumber" name="serialNumber" 
                                                                pattern="<spring:eval expression="@environment.getProperty('pattern.serialNumber')" />"
                                                                    oninput="InvalidMsg(this,'input','<spring:message code="validation.numberfirst" />');" 
                                                                    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15serialNo" />');"
                                                                     maxlength="25">
                                                                        <label for="singleblockserialNumber"><spring:message code="operator.deviceserial" /></label>
                                                            </div>
                                        
                                                            <div class="input-field col s12 m6">
                                                                <textarea id="singleblockremark"  class="materialize-textarea" 
                                                                oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');" 
                                                                oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
                                                                maxlength="200" required /></textarea>
                                                                <label for="singleblockremark"><spring:message code="input.remarks" /> <span class="star">*</span></label>
                                                            </div>
                                                              <div class="col s12 m6"><label for="singleDeviceCategory"><spring:message code="operator.category" />
                                                            <span class="star">*</span></label>
                                                        <select class="browser-default" id="singleDeviceCategory" 
                                                         oninput="InvalidMsg(this,'input','<spring:message code="validation.numberfirst" />');" 
                                                         oninvalid="InvalidMsg(this,'input','<spring:message code="validation.numberfirst" />');"
                                                                   required>
                                                            <option value="" disabled selected><spring:message code="operator.selectcategory" />
                                                            </option>
                                                            
                                                        </select>
                                                    </div>
                                                    

                                                        </div>
                                                        <div class="row input_fields_wrap">
                                                        
                                                        <div class="col s12 m6">
<p style="margin-top: 3px; margin-bottom: 5px"><spring:message code="operator.blocking" /></p>
<label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio" 
value="Immediate" onchange="setDateMandatoryOrOptional('Immediate','stolenDatePeriod')"
onclick="document.getElementById('calender').style.display = 'none';"
name="stolenBlockPeriod" checked><spring:message code="operator.immediate" />
</label> <label style="margin-right: 2%;"> <input type="radio" class="blocktypeRadio"
value="Default" title="" id="defaultPeriodId" onchange="setDateMandatoryOrOptional('Default','stolenDatePeriod')"
onclick="document.getElementById('calender').style.display = 'none';" 
name="stolenBlockPeriod"><spring:message code="operator.default" />
</label> <label> <input type="radio" required="required" value="tilldate" onchange="setDateMandatoryOrOptional('tilldate','stolenDatePeriod')" class="blocktypeRadio"
onclick="document.getElementById('calender').style.display = 'block';"
name="stolenBlockPeriod"><spring:message code="operator.later" />
</label>
<div class="input-field col s6 m2 responsiveDiv"
style="display: none; width: 30%; margin-right: 30%; float: right; margin-top: -15px" id="calender">
<div id="startdatepicker" class="input-group date">
<label for="stolenDatePeriod"><spring:message code="operator.blockingTypePeriod" /> <span class="star"> </span> 
																</label>
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
</div>
                                                        
                                                            
                                                            <div id="IMEIndContact1" style="display: none">
                                                            <div class="col s12 m12">
                                                                <p style="margin-bottom: 0;"><spring:message code="title.imeiMeidEsn" /></p>
                                                            </div>
                                                           <div class="input-field col s12 m6">
                                                                <input type="text" id="singleblockIMEI1" name="IMEI1" pattern="[0-9]{15,16}"  
                                                                  pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
                                                                   oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');" 
                                                                   oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                    required>
                                                                <label for="singleblockIMEI1"><spring:message code="title.one" /> <span class="star">*</span></label>
                                                                         <p id="errorMsgOnModal" class="deviceErrorTitle" style="margin-top:-72px;margin-left:115px;"></p>
                                                            </div></div>
                                        					<div id="IMEIndContact2" style="display: none"><p>	
                                                            <div class="input-field col s12 m6">
                                                                <input type="text" id="singleblockIMEI2" name="IMEI2" 
                                                                 pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
                                                                   oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');" 
                                                                   oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                  >
                                                                <label for="singleblockIMEI2"><spring:message code="title.two" /></label>
                                                            </div></div>  
                                                            <div id="IMEIndContact3" style="display: none"><p>
                                                            <div class="input-field col s12 m6">
                                                                <input type="text" id="singleblockIMEI3" name="IMEI3"
                                                                	 pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />" 
                                                                    oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');" 
                                                                    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                  >
                                                                <label for="singleblockIMEI3"><spring:message code="title.three" /></label>
                                                  
                                                            </div></div>
                                                            <div id="IMEIndContact4" style="display: none"><p>
            
                                                            <div class="input-field col s12 m6">
                                                               <input type="text" id="singleblockIMEI4" name="IMEI4[]"
                                                               		 pattern="<spring:eval expression="@environment.getProperty('pattern.IMEINumber')" />"
                                                                    oninput="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');" 
                                                                    oninvalid="InvalidMsg(this,'input','<spring:message code="validation.1516digit" />');"
                                                                  >
                                                                <label for="singleblockIMEI4"><spring:message code="title.four" /></label>
                                                            </div></div>
                                                        </div>
                                                        <span><spring:message code="input.requiredfields" /> <span class="star">*</span></span>
                                                    </div>

                                                    

                                                    <div class="input-field col s12 center">
                                                        <button class="btn" id="singleblockSubmit" type="submit"><spring:message code="button.submit" /></button>
                                                        <a href="./stolenRecovery" class="btn" style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
                                                    </div>
                                                </form>
                                            </div>
                                            <div id="multipleImeiBlock" style="display: none" class="col s12">
                                                <form action="" id="multipleImeiBlockform" onsubmit="return submitBlockImei()" method="POST" enctype="multipart/form-data">
                                                
                                                <div class="col s12 m6"><label for="bulkBlockdeviceCategory"><spring:message code="operator.category" />
                                                            <span class="star">*</span></label>
                                                        <select class="browser-default" id="bulkBlockdeviceCategory" 
                                                        oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" 
                                                        oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
                                                       required   >
                                                            <option value="" disabled selected><spring:message code="operator.selectcategory" />
                                                            </option>
                                                            
                                                        </select>
                                                    </div>

                                                    <div class="input-field col s12 m6" style="margin-top: 22px;">
                                                        <input type="text" id="blockbulkquantity" name="quantity"
                                                        pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />" 
                                                        oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');" 
                                                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
                                                      required    >
                                                        <label for="blockbulkquantity"><spring:message code="input.quantity" /> <span class="star">*</span></label>
                                                    </div>
                                                    <div class="input-field col s12 m6" style="margin-top: 28px;">
                                                        <input type="text" id="blockbulkDeviceQuantity" name="blockbulkDeviceQuantity"
                                                        pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />" 
                                                        oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');" 
                                                        oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
                                                      required   maxlength="7" >
                                                        <label for="blockbulkDeviceQuantity"><spring:message code="input.devicequantity" /> <span class="star">*</span></label>
                                                    </div>
                                                    
                                                    <div class="file-field input-field col s12 m6" style="margin-top: -75px;">
                                                        <p style="color: #000;"><spring:message code="operator.upload" /> <span class="star">*</span></p>
                                                        <div class="btn">
                                                            <span><spring:message code="operator.file" /></span>
                                                            <input type="file" id="blockBulkFile" accept=".csv"  onchange="fileTypeValueChanges()"
                                                            oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
                                                             oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
                                                            required>
                                                        </div>
                                                        <div class="file-path-wrapper">
                                                            <input class="file-path validate" type="text" placeholder="" id="unblockFileName">
                                                        </div>
                                                    </div>

<div class="input-field col s12 m6" style="margin-top: 18px;">
                                                                <textarea id="blockbulkRemark"  class="materialize-textarea" 
                                                                oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');" 
                                                                oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
                                                                 maxlength="200" required /></textarea>
                                                                <label for="blockbulkRemark"><spring:message code="input.remarks" /> <span class="star">*</span></label>
                                                            </div>
													<div class="col s12 m6 blockingType">
												<p style="margin-top: 3px; margin-bottom: 5px">
													<spring:message code="operator.blocking" />
												</p>
												<label style="margin-right: 2%;"> <input
													type="radio" class="bulkblocktypeRadio"  value="Immediate" onchange="setDateMandatoryOrOptional('Immediate','stolenBulkDatePeriod')"
													onclick="document.getElementById('stolenCalender').style.display = 'none';"
													name="stolenBulkBlockPeriod" checked> <spring:message
														code="operator.immediate" />
												</label> <label style="margin-right: 2%;"> <input
													type="radio" class="bulkblocktypeRadio" value="Default" id="bulkblocktypeRadioId"
													onchange="setDateMandatoryOrOptional('Default','stolenBulkDatePeriod')"
													onclick="document.getElementById('stolenCalender').style.display = 'none';"
													name="stolenBulkBlockPeriod"> <spring:message
														code="operator.default" />
												</label> <label> <input type="radio" required="required"
													value="tilldate" class="bulkblocktypeRadio" onchange="setDateMandatoryOrOptional('tilldate','stolenBulkDatePeriod')"
													onclick="document.getElementById('stolenCalender').style.display = 'block';"
													name="stolenBulkBlockPeriod"> <spring:message
														code="operator.later" />
												</label>
												<div class="input-field col s6 m2 responsiveDiv"
													style="display: none; width: 30%; margin-right: 30%; float: right; margin-top: -15px"
													id="stolenCalender">
													<div id="Stolenstartdatepicker" class="input-group date">
														<label for="stolenBulkDatePeriod"><spring:message code="operator.blockingTypePeriod" /> <span class="star"> </span> 
																</label>
														<input type="text" id="stolenBulkDatePeriod"
															style="margin-top: -9px" /> <span
															class="input-group-addon" style="color: #ff4081"><i
															class="fa fa-calendar" aria-hidden="true"
															style="float: right; margin-top: -30px;"></i></span>
													</div>

												</div>


												<div class="col s12 m2 l2"
													style="width: 40%; display: none; float: right; margin-right: 30%;"
													id="stolenDate">

													<label for="TotalPrice" class="center-align"> <spring:message
															code="operator.tilldate" /></label>
													<div id="Stolenstartdatepicker" class="input-group"
														style="margin-top: 10px;">

														<input class="form-control" name="inputsaves" type="text"
															id="startDateFilter" readonly /> <span
															class="input-group-addon" style="color: #ff4081"><i
															class="glyphicon glyphicon-calendar"
															onclick="_Services._selectstartDate()"></i></span>
													</div>
												</div>
											</div>
		
                    
                      					
                                            <div class="col s12 m12">
                                                    <p style="margin-left: 10px;"><a href="./Consignment/sampleFileDownload/7"><spring:message code="input.downlaod.sample" /></a></p>
                                                   <span style="margin-left: 5px;"><spring:message code="input.requiredfields" /><span class="star">*</span></span>
											</div>							
                                                    <div class="input-field col s12 center">
                                               <button class="btn" type="submit" id="blockBulkSubmitButton" ><spring:message code="button.submit" /></button>
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

<div id="markBulkAsBlock" class="modal">
<h6 class="modal-header"><spring:message code="operator.markas" /></h6>
        <div class="modal-content">
            
            

            <div class="row">
                <h6 id="blockBulkDeviceMsg"><spring:message code="operator.thisfileblock" /><span id="txnIdsingleImei"></span></h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a href="./stolenRecovery" class="btn"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>
      <div id="markAsBlock" class="modal">
         <h6  class="modal-header"><spring:message code="operator.markas" /></h6>
        <div class="modal-content">
          <div class="row">
                <h6 id="singleDeviceBlockMessage"><spring:message code="operator.devicemarkedblock" /> <span id="txnIdblockBulkDevice"></span></h6>
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
						<button class="modal-close waves-effect waves-light btn" onclick="clearFileName()"
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

			<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
		<script type="text/javascript"
		src="" async></script>
	
		
		<script type="text/javascript"
		src="${context}/resources/project_js/reportBlock.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript">
	
	$('#stolenBulkDatePeriod').datepicker({
		dateFormat : "yy-mm-dd",
		minDate: "0"
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