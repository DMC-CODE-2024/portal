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
<!--<title>Visa</title>-->

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- Security Tags -->

<!-- Favicons-->
<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<script type="text/javascript"
	src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
<!--   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"></script>  
 -->
<%-- <jsp:include page="/WEB-INF/view/endUserHeader.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/endUserFooter.jsp"></jsp:include>
 --%>
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">

<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<!-- Custome CSS-->
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

<!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
<link href="${context}/resources/plugins/prism/prism.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<%--  <link href="${context}/resources/plugins/chartist-js/chartist.min.css" type="text/css" rel="stylesheet" media="screen,projection"> --%>
<link rel="stylesheet"
	href="${context}/resources/project_css/viewConsignment.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
<link rel="stylesheet"
	href="${context}/resources/project_css/intlTelInput.css">
	
	

<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">

<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>

<!------------------------------------------- Dragable Model---------------------------------->
<script
	src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>
 <style>
   
   /*      ul li {
            display: inline-flex;
        }

        li {
            padding: 7px 15px;
            border: solid 1px #c9c9c9;
            border-radius: 5px;
            margin-right: 10px;
        }
        select{
            height: 1.5rem;
            border: none;
        }
        footer {
            padding-left: 0;
        }
        
         /* body {
            background-color: #00bcd4;
        } */

        .boton {
            color: #2979a5;
            float: right;
            border: solid 1px rgba(33, 167, 201, 0.774);
            padding: 4px 10px;
            border-radius: 7px;
            font-size: 14px;
            background-color: #fff;
        }

        .row {
            margin-bottom: 0;
            margin-top: 0;
        }

        textarea.materialize-textarea {
            padding: 0;
        }

        input[type=text] {
            height: 35px;
            margin: 0 0 5px 0;
        }

        footer {
            padding-left: 0;
        }

        .card-panel {
            width: 50%;
            
        }

        @media only screen  and (max-width: 992px){
            .card-panel {
            width: 100%;
        } 
        }

        #content .container .row {
            margin: auto;
        }

        @media only screen and (max-width: 425px){
            .selectDropdwn {
                margin-top: 0px;
            }

            .selectDropdwn label {
                margin-left: 2%;
            }
        }

        @media only screen and (max-width: 425px) {
            select {
                width: 96%;
                margin-left: 2%;
            }
        }

        .small-modal {
            width: 40%;
        }

        @media only screen and (max-width: 992px) {
            .small-modal {
            width: 70%;
        }
        }

        @media only screen and (max-width: 600px) {
            .small-modal {
            width: 95%;
        }
        }
        
        .modal {
        	width: 50%;
        }
        .row.card-panel.headerLang {
          width: 100%;
          }
        
 */    

div#initialloader {
position: absolute;
left: 0px;
top: 58px !important;
width: 100%;
height: 86% !important;
z-index: 9999;
background: url(resources/images/loader.gif) 50% 50% no-repeat white;
}

.container {
      max-width: 100% !important;
    width: 100%;
    position: absolute;
    margin: 10vh 0vh;
}
 </style>
</head>
<body  data-lang-param="${pageContext.response.locale}">


	<section id="content">
	
		<!--start container-->

					<div class="container" style="margin-top: 10vh;">
	
			<div class="section">
				<div class="row card-panel login-card-panel">
					<h6 class="fixPage-modal-header ">
<div class="col s9 m10 l10 select-lang-lable-all width87">
<p><spring:message code="input.UpdateVisaValidity" /></p>



<i class="fa fa-globe fa-6" aria-hidden="true"></i>
</div>
<div class="col s3 m2 l2 right width13" >
<select class="browser-default select-lang-drpdwn-all" id="langlist">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
</div>
</h6>
					<div class="col s12 m12 l12">
						<div class="row">
							<div class="row">
								<form  onsubmit="return findEndUserByNid()" method="POST"
									enctype="multipart/form-data">
									<div id="submitbtn">
										<div class="input-field col s12 m3 l3">
											<label for="Search" class="center-align ml-10" style="width: max-content;"><spring:message code="input.pportnumber" />
											<span class="star"> *</span></label>
										</div>
										<div class="input-field col s12 m3 l3">
											<input type="text" id="nidForEndUser"
												pattern="<spring:eval expression="@environment.getProperty('pattern.operatorNid')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.12NID" />');"
															oninvalid="InvalidMsg(this,'input','<spring:message code="validation.12NID" />');"
												title="<spring:message code="validation.12NID" />"
												required  name="Search" />

										</div>
										<div class="input-field col s12 m6" >
											<button  class="btn" type="submit" id="passPortBtnId">
												<spring:message code="button.submit" />
											</button>
											<a href="./redirectToHomePage" class="btn"><spring:message code="modal.close" /></a>
										</div>
									</div>
								</form>
							</div>
							<div id="EndUserInfoForm" style="display: none;">
								<form onsubmit="return updateVisaDetails()" method="POST"
									enctype="multipart/form-data">
									<div class="row">
										<div class="input-field col s12 m6">
											<input type="text" id="endUserpassportNumber"
												name="endUserpassportNumber" placeholder=""
												pattern="[a-zA-Z0-9]{1,15}"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.15numbers" />');"
															oninvalid="InvalidMsg(this,'select','<spring:message code="validation.15numbers" />');"
												title="<spring:message code="validation.15numbers" />"
												  maxlength="15" /> <label
												for="endUserpassportNumber"><spring:message
													code="input.passportNo" /> <span class="star"></span></label>
										</div>
										<input type="text" id="endUserTxnId" style="display: none">
										<div class="file-field col s12 m6" style="margin-top: -8px;">
											<h6 style="font-size: 12px;">
												<spring:message code="input.UploadImage" />
												<span class="star"></span>
											</h6>
											<div class="btn" id="passportFileDiv">
												<span><spring:message code="input.selectfile" /></span> <input
													type="file"
													oninput="InvalidMsg(this,'select','<spring:message code="validation.NoChosen" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.NoChosen" />');"
													  id="uploadPassportID">
													  
											</div>
											<div class="file-path-wrapper" id="passportFileNameDiv">
												<input class="file-path validate" type="text"
													id="passportFileName" placeholder="" value="">
													 <a id="firImageLink"
																	class="imgPreviewLink" ><spring:message code="input.preView" /></a>
											</div>
										</div>

										<div class="input-field col s12 m4">
											<input type="text" id="endUserfirstName" placeholder=""
												pattern="[a-zA-Z]{1,20}" oninput="InvalidMsg(this,'select','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.20Character" />');"
												
												    maxlength="20" /> <label
												for="endUserfirstName"><spring:message
													code="input.firstName" /> <span class="star"></span></label>
										</div>

										<div class="input-field col s12 m4">
											<input type="text" id="endUsermiddleName" placeholder=""
												pattern="[a-zA-Z]{1,20}" 
												oninput="InvalidMsg(this,'select','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.20Character" />');"
												
												maxlength="20" /> <label for="endUsermiddleName"><spring:message
													code="input.middleName" /></label>
										</div>

										<div class="input-field col s12 m4">
											<input type="text" id="endUserlastName" placeholder=""
												pattern="[a-zA-Z]{1,20}" 
												oninput="InvalidMsg(this,'select','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.20Character" />');"
												title=""
											    maxlength="20" /> <label for="endUserlastName"><spring:message
													code="input.lastName" /> <span class="star"></span></label>
										</div>
										<div class="col s12 m6" id="nationalityDiv"
											style="display: block">
											<label for="nationality" class="active"><spring:message
													code="input.Nationality" /> <span class="star"></span></label>
											<input type="text" id="nationality" name="nationality"
												pattern="[a-zA-Z]{1,25}" oninput="InvalidMsg(this,'input');"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
												title="" maxlength="25">
										</div>
										<div class="col s12 m6" id="entryCountryDiv" style="display: block;">
										<label for="datepicker" class="active"><spring:message
														code="input.EntryCountry" /> <span class="star"></span></label>
												<input type="text" id="datepicker"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													 maxlength="15" /> 
									</div>

										<div class="input-field col s12 m12 l12">
											<input type="text" placeholder=""  
												oninput="InvalidMsg(this,'select','<spring:message code="validation.200character" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.200Character" />');"
												title="<spring:message code="" />"   
												class="form-control boxBorder boxHeight" id="endUseraddress" required
												maxlength="200"> <label for="address"><spring:message
													code="input.address" /> <span class="star"></span></label>
										</div>
										
										<div class="input-field col s12 m6 l6">
											<p
												style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
												<spring:message code="input.Country" />
												<span class="star"></span>
											</p>
											<select id="country" class="browser-default" class="mySelect" disabled="disabled"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;color: rgb(53, 52, 52);"" required></select>
										</div>

										<div class="input-field col s12 m6 l6"
											style="margin-bottom: 5px;">
											<p
												style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
												<spring:message code="input.province" />
												<span class="star"></span>
											</p>
											<select id="state" class="browser-default" class="mySelect"
											onchange="getDistrict(this,'endUserdistrict','endUsercommune');"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
												style="padding-left: 0;" required>
												<option value=""><spring:message code="select.district" /></option>
												</select>
										</div>
										<div class="col s12 m6 l6">
											<%-- <input type="text" id="endUserdistrict"
												pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												required maxlength="30"> --%>
												<label for="endUserdistrict"><spring:message
													code="input.district" /> <span class="star"></span> </label>
													<select
										id="endUserdistrict" class="browser-default" class="mySelect"
										onchange="getCommune(this,'endUsercommune','endUservillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.district" /></option>
										</select>
												 
										</div>
										<div class="col s12 m6 l6">
											<%-- <input type="text" id="commune" pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												required maxlength="30"> --%> <label for="commune"><spring:message
													code="input.commune" /> <span class="star"></span></label>
													
													<select
										id="endUsercommune" class="browser-default" class="mySelect"
										onchange="getVillage(this,'endUservillage');InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" required>
										<option value=""><spring:message code="select.commune" /></option>
										</select>
										</div>
										
										<div class="col s12 m6 l6">
											<%-- <input type="text" id="village"
												pattern="[a-zA-Z0-9\s,'*$-]{0,30}"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.30characters" />');"
												title="" maxlength="30"> --%> <label for="village"><spring:message
													code="input.village" /> <span class="star"></span> </label>
													<select
										id="endUservillage" class="browser-default" class="mySelect"
										onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
										style="padding-left: 0;" >
										<option value=""><spring:message code="select.village" /></option>
										</select>
										</div>
										

										<div class="input-field col s12 m6 l6" style="margin-left: 0px;margin-top: 23px; ">
											<input type="text" required="required" placeholder=""
												 
												class="form-control boxBorder boxHeight"
												id="endUserstreetNumber" 
													oninput="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
												
												  maxlength="50"> <label
												for="streetNumber"><spring:message
													code="input.streetNumber" /> <span class="star"></span></label>
										</div>
										<div class="input-field col s12 m6 l6">
											<input type="text" placeholder="" placeholder=""
												 
												oninput="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
												 
												class="form-control boxBorder boxHeight"
												id="endUserlocality" required maxlength="20"> <label
												for="locality"><spring:message code="input.locality" />
												<span class="star"></span></label>
										</div>

										<%-- <div class="input-field col s12 m6 l6">
											<input type="text" placeholder="" id="endUservillage"
												 
												oninput="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
												   maxlength="20"> <label for="village"><spring:message
													code="input.village" /> <span class="star"></span></label>
										</div> --%>

										<%-- <div class="input-field col s12 m6 l6">
											<input type="text" placeholder=""
												 
												oninput="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
												     id="endUsercommune" maxlength="50"> <label
												for="commune"><spring:message code="input.commune" /><span
												class="star"></span></label>
										</div>

										<div class="input-field col s12 m6 l6">
											<input type="text" placeholder="" id="endUserdistrict"
												 
												oninput="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
													oninvalid="InvalidMsg(this,'select','<spring:message code="validation.50character" />');"
												   maxlength="50"> <label for="district"><spring:message
													code="input.district" /> <span class="star"></span></label>
										</div> --%>

										<div class="input-field col s12 m6 l6">
											<input type="text" placeholder="" pattern="[0-9]{6,10}"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.postalcode" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.postalcode" />');"
												
												class="form-control boxBorder boxHeight" id="endUserpin"
												   maxlength="6"> <label for="pin"><spring:message
													code="registration.postalcode" /><span class="star"></span></label>
										</div>

										<%-- <div class="input-field col s12 m6 l6">
											<p
												style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
												<spring:message code="input.Country" />
												<span class="star"></span>
											</p>
											<select id="country" class="browser-default" 
												class="mySelect"
												title="<spring:message code="validation.selectFieldMsg" />"
												oninput="InvalidMsg(this,'select','<spring:message code="validation.postalcode" />');"
												oninvalid="InvalidMsg(this,'select','<spring:message code="validation.postalcode" />');"
												
												style="padding-left: 0;" ></select>
										</div>

										<div class="input-field col s12 m6 l6"
											style="margin-bottom: 5px;">
											<p
												style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">
												<spring:message code="input.province" />
												<span class="star"></span>
											</p>
											<select id="state" class="browser-default" class="mySelect"
												title="<spring:message code="validation.selectFieldMsg" />"
												
												style="padding-left: 0;"  ></select>
										</div> --%>


										<div class="input-field col s12 m6" style="margin-top: 0;">
											<p class="contact-label">
												<spring:message code="input.contactNum" />
												<span class="star"></span>
											</p>
											<input type="tel" oninput="setCustomValidity('')"
												oninput="InvalidMsg(this,'input');" oninvalid="InvalidMsg(this,'input');"
												title= "<spring:message code="validation.10digits" />"   
											   placeholder="" id="phone" maxlength="10">
										</div>

										<div class="input-field col s12 m6">
											<input type="email" id="endUseremailID" placeholder=""
												title="<spring:message code="validation.Matchformat" />"
												oninput="InvalidMsg(this,'email');"
												oninvalid="InvalidMsg(this,'email');"
												 maxlength="30" /> <label for="emailID"><spring:message
													code="input.EmailID" /></label>
										</div>
									</div>

									<div class="row">
										<div class="col s12 m6">
											<label for="visaType"><spring:message
													code="input.VisaType" /> <span class="star"></span></label> <select
												class="browser-default" id="endUservisaType"  required="required"
												title="<spring:message code="validation.selectFieldMsg" />"
												oninput="setCustomValidity('')"
												oninput="InvalidMsg(this,'select');"
												oninvalid="InvalidMsg(this,'select');"
												style="padding: 0; height: 35px;">
												<option value="" disabled selected><spring:message
														code="input.SelectVisaType" /></option>

											</select>
										</div>

										<div class="input-field col s12 m6" id="endUserdatepickerDiv">
											<input type="text" id="endUserdatepicker1" placeholder=""
												oninput="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.date" />');"
												title="<spring:message code="validation.date" />"
												 maxlength="15" /> <label for="datepicker1"><spring:message
													code="input.EntryCountry" /> <span class="star"></span></label>
										</div>

										<div class="file-field col s12 m6" style="margin-top: -8px;">
											<h6>
												<spring:message code="input.UploadVisa" /> <span class="star">*</span>
												
											</h6>
											<div class="btn">
												<span><spring:message code="input.selectfile" /></span> <input
													type="file" accept="image/*" required="required"
													oninput="InvalidMsg(this,'fileType','<spring:message code="validation.file" />');" oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.file" />');"
													   id="endUseruploadnationalID" onchange="visaImageValidation('endUseruploadnationalID')"
														placeholder="<spring:message code="validation.visaPlaceholder" />">
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate" type="text" id="endUseruploadnationalIDPlaceHolder"
														placeholder="<spring:message code="validation.visaPlaceholder" />">
											</div>
										</div>

										<div class="input-field col s12 m6" style="margin-top: 22px;">
											<input type="text" id="endUserdatepicker" placeholder=""
												onchange="InvalidMsg(this,'date'); checkDate(endUserdatepicker1,endUserdatepicker)"
												oninvalid="InvalidMsg(this,'date');"
												title="<spring:message code="validation.date" />"
												required  maxlength="15" /> <label for="datepicker"><spring:message
													code="input.VisaExpiry" /> <span class="star">*</span></label>
													<span id="expiryMessage" style="color: red"></span>
										</div>
										
										<div class="input-field col s12 m6" style="margin-top: 22px;">
											<input type="text" id="endUserVisaNumber" 
												pattern="<spring:eval expression="@environment.getProperty('pattern.departmentID')" />"
													oninput="InvalidMsg(this,'input','<spring:message code="validation.departmentID" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.departmentID" />');"
													 maxlength="15" /> <label for=endUserVisaNumber><spring:message
														code="input.VisaNumber" /> <span class="star"></span></label>
										</div>
									</div>

									<p>
										<spring:message code="input.requiredfields" />
										<span class="star">*</span>
									</p>
									<div class="row">
										<div class="input-field col s12 m12 l12 center">
											<button id="updateVisaButton" class="btn" type="submit">
												<spring:message code="button.update" />
											</button>
											<a href="./redirectToHomePage" class="btn"
												style="margin-left: 10px;"><spring:message
													code="button.cancel" /></a>
										</div>
									</div>
								</form>
							</div>

                                       <!--  <div id="match-data" style="display: none;">
                                            <div class="row">
                                                <div class="input-field col s12 m12">
                                                    <input type="text" id="passportNumber" name="passportNumber"
                                                        pattern="[a-zA-Z0-9]" title="" maxlength="15" value="THU5463746"
                                                        disabled />
                                                    <label for="passportNumber">Passport Number <span
                                                            class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m4">
                                                    <input type="text" id="firstName" name="firstName"
                                                        pattern="[a-zA-Z]" title="" maxlength="15" value="Abc"
                                                        disabled />
                                                    <label for="firstName">First Name <span
                                                            class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m4">
                                                    <input type="text" id="middleName" name="middleName"
                                                        pattern="[a-zA-Z]" title="" maxlength="15" disabled />
                                                    <label for="middleName">Middle Name</label>
                                                </div>

                                                <div class="input-field col s12 m4">
                                                    <input type="text" id="lastName" name="lastName" pattern="[a-zA-Z]"
                                                        title="" maxlength="15" value="DEF" disabled />
                                                    <label for="lastName">Last Name <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m12 l12">
                                                    <input type="text" name="address" id="address"
                                                        value="12 kjdshkjdshfkdsj" disabled>
                                                    <label for="address">Address(Property Location) <span
                                                            class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6 l6">
                                                    <input type="text" name="streetNumber" id="streetNumber"
                                                        maxlength="30" value="13 hsk" disabled>
                                                    <label for="streetNumber">Street Number <span
                                                            class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6 l6">
                                                    <input type="text" name="locality" id="locality" maxlength="20"
                                                        value="dskjhkdjk" disabled>
                                                    <label for="locality">Locality <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6 l6">
                                                    <input type="text" name="village" id="village" maxlength="20"
                                                        value="djhcjdshj" disabled>
                                                    <label for="village">Village <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6 l6">
                                                    <input type="text" name="commune" id="commune" maxlength="20"
                                                        value="jhdscjhdsj" disabled>
                                                    <label for="commune">Commune <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6 l6">
                                                    <input type="text" name="district" id="district" maxlength="20"
                                                        value="kjdsnckjdsnk" disabled>
                                                    <label for="district">District <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6 l6">
                                                    <input type="text" name="pin" id="pin" maxlength="20" value="986753"
                                                        disabled>
                                                    <label for="pin">Pincode <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6">
                                                    <input type="text" name="Country" id="Country" maxlength="20"
                                                        value="Abc Country" disabled>
                                                    <label for="Country">Country <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6 l6">
                                                    <input type="text" name="Province" id="states" maxlength="20"
                                                        value="Abc" disabled>
                                                    <label for="state">Province <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6">
                                                    <p class="contact-label">Contact Number <span class="star">*</span>
                                                    </p>
                                                    <input type="tel" name="phone" id="phone1" maxlength="15"
                                                        value="+91 6968674536" disabled>
                                                </div>

                                                <div class="input-field col s12 m6">
                                                    <input type="text" id="emailID" name="emailID"
                                                        pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title=""
                                                        maxlength="30" value="mail@mail.com" disabled />
                                                    <label for="emailID">Email ID</label>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col s12 m6">
                                                <label for="visaType">Visa Type <span class="star">*</span></label>
                                                <select class="browser-default" id="visaType">
                                                    <option value="" disabled selected>Select Visa Type</option>
                                                    <option value="Yes">Tourist</option>
                                                    <option value="No">Other</option>
                                                </select>
                                            </div>

                                                <div class="input-field col s12 m6">
                                                    <input type="text" id="visaType" name="visaType" pattern="[]"
                                                        title="" maxlength="15" value="Tourist" disabled />
                                                    <label for="visaType">Visa Type <span class="star">*</span></label>
                                                </div>

                                                <div class="input-field col s12 m6">
                                                    <input type="text" id="datepicker1" name="entryDate" pattern="[]"
                                                        title="" maxlength="15" value="16/01/2020" disabled />
                                                    <label for="datepicker1">Entry Date In Country <span
                                                            class="star">*</span></label>
                                                </div>

                                                <div class="file-field col s12 m6" style="margin-top: -8px;">
                                                    <h6>Upload Visa Image <span class="star">*</span></h6>
                                                    <div class="btn">
                                                        <span>select file</span>
                                                        <input type="file" id="uploadnationalID" disabled>
                                                    </div>
                                                    <div class="file-path-wrapper">
                                                        <input class="file-path validate" type="text"
                                                            placeholder="Upload Visa Image" value="image.jpg" disabled>
                                                    </div>
                                                </div>

                                                <div class="input-field col s12 m6" style="margin-top: 22px;">
                                                    <input type="text" id="datepicker2" name="expiryDate" pattern="[]"
                                                        title="" maxlength="15" value="12/07/2020" />
                                                    <label for="datepicker2">Visa Expiry Date <span
                                                            class="star">*</span></label>
                                                </div>
                                            </div>

                                            
                                            <p>Required Field are marked with <span class="star">*</span></p>
                                            <div class="row">
                                                <div class="input-field col s12 m12 l12 center">
                                                    <a href="#successMsg" class="btn modal-trigger">Submit</a>
                                                    <a href="index.html" class="btn"
                                                        style="margin-left: 10px;">cancel</a>
                                                </div>
                                            </div>
                                        </div> -->
						</div>

					</div>
				</div>
			</div>
		</div>
		<div id="successMsg" class="modal open"
			style="width: 45%; z-index: 1003; opacity: 1; transform: scaleX(1); top: 10%;">
			<h6 class="modal-header">
				<spring:message code="button.submit" />
			</h6>
			<div class="modal-content">
				<div class="row">
					<h6 id="messageResponse"></h6>
				</div>
				<div class="row">
					<div class="input-field col s12 center">
						<div class="input-field col s12 center">
							<a href="./redirectToHomePage" class="btn"><spring:message
									code="modal.ok" /></a>
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
				<h6 id="visafileErrormessage"><spring:message code="fileValidationName" /><br> <br> <spring:message code="fileValidationFormate" /> <br><br> <spring:message code="fileValidationSize" /> </h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close  btn" onclick="clearVisaName()"
							style="margin-left: 10px;"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="errorModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="input.UpdateVisaValidity" />
		</h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="errorMessage">
					<spring:message code="passportNotExist" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<!-- <a href="homePage" class="btn">Yes</a> -->
						<a  href="./redirectToHomePage" class="modal-close btn" style="margin-left: 10px;">
							<spring:message code="modal.ok" />
						</a>
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
	<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>

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
		src="${context}/resources/project_js/provinceDropdown.js?version=<%= (int) (Math.random() * 10) %>" async></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/CommanLocality.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/endUserUpdateVisaValidity.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>	

		
	<script type="text/javascript"
		src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>

		
			 
</body></html>

