<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Security Tags -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:csrfMetaTags />
<!-- Security Tags -->
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html translate="no">  
<head><title>EIRS Portal</title>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="msapplication-tap-highlight" content="no">
    <meta name="google" content="notranslate" />
    <meta name="description"
        content="Materialize is a Material Design Admin Template,It's modern, responsive and based on Material Design by Google. ">
    <meta name="keywords"
        content="materialize, admin template, dashboard template, flat admin template, responsive admin template,">
        <!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- Security Tags -->
    <!--<title>CEIR | Importer Portal</title>-->

    <link href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css" type="text/css" rel="stylesheet"
        media="screen,projection">
<%-- <jsp:include page="/WEB-INF/view/endUserHeader.jsp" ></jsp:include>
<jsp:include page="/WEB-INF/view/endUserFooter.jsp" ></jsp:include>
 --%>
    <!-- Favicons-->
    <!--<link rel="icon" href="images/favicon/favicon-32x32.png" sizes="32x32">-->
    <!-- Favicons-->
        <link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
    <link rel="apple-touch-icon-precomposed" href="images/favicon/apple-touch-icon-152x152.png">
    <!-- For iPhone -->
    <meta name="msapplication-TileColor" content="#00bcd4">
    <meta name="msapplication-TileImage" content="images/favicon/mstile-144x144.png">
    

    <!-- For Windows Phone -->
    <link rel="stylesheet" href="${context}/resources/font/font-awesome/css/font-awesome.min.css">

    <!-- CORE CSS-->
    <link href="${context}/resources/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="${context}/resources/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- Custome CSS-->
    <link href="" type="text/css" rel="stylesheet" media="screen,projection">

    <!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
    <link href="${context}/resources/plugins/prism/prism.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css" type="text/css" rel="stylesheet"
        media="screen,projection">
    <link href="${context}/resources/plugins/chartist-js/chartist.min.css" type="text/css" rel="stylesheet" media="screen,projection">

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
<script>
var contextpath = "${context}";
</script>

</head>
<body data-lang-param="${pageContext.response.locale}">
<section id="content">
                <!--start container-->
           
                <div id="initialloader">
                
                </div>
            
                <input type="text" id="pageTypeValue" value="${showPagetype}" style="display: none;">
                <div class="container" id="uploadPaidStatusDiv" style="dispay:none">
                    <div class="section">
                        <div class="row card-panel upload-stock-responsive-page">
                            <h6 class="fixPage-modal-header ">
<div class="col s9 m10 l10 select-lang-lable-all width87">
<p><spring:message code="modal.UploadStock" /></p>


<i class="fa fa-globe fa-6" aria-hidden="true"></i> 
</div>
<div class="col s3 m2 l2 right width13" >
<select class="browser-default select-lang-drpdwn-all" id="langlist">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
</div>
</h6>
                           	<form action="" onsubmit="return uploadEndUserStock()" method="POST"
								enctype="multipart/form-data" >
                                <div class="col s12 m12 l12">
                                    <div class="row">
                                        

                                        <div class="row myRow">
                                            <div class="input-field col s12 m6">
                                                <label for="endUser" style="color: #000;"><spring:message code="input.EmailID" /> </label>
                                                <input type="email" id="endUseremail"
                                                pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"  
											    oninput="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');" 
												   name="email"/>
                                            </div>

                                            <div class="input-field col s12 m6 quantity" style="margin-top: 19px;">
                                                <label for="endUserquantity" style="color: #000;"><spring:message code="input.quantity" />  <span class="star">*</span></label>
                                                <input type="text" id="endUserquantity" maxlength="7" name="endUserquantity" 
                                                pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');" 
												 title= "<spring:message code="validation.7digits" />" required> </div>
												 
											<div class="input-field col s12 m6 quantity" style="margin-top: 19px;">
                                                <label for="endUserDevicequantity" style="color: #000;"><spring:message code="input.devicequantity" />  <span class="star">*</span></label>
                                                <input type="text" id="endUserDevicequantity"  name="endUserDevicequantity"
                                                   pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
												oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');" 
												 title= "<spring:message code="validation.7digits" />" required> </div>	 

                                            <div class="file-field col s12 m6">
                                                <h6 style="margin-top: 15px;"><spring:message code="registration.uploadfile" /> <span
                                                        class="star">*</span></h6>
                                                <div class="btn">
                                                    <span><spring:message code="input.selectfile" /></span>
                                                    <input type="file" id="endUsercsvUploadFile" accept=".csv"  onchange="fileTypeValueChanges(this,'fileType')"
                                                    oninput="InvalidMsg(this,'fileType','<spring:message code="validation.file" />');"
												oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.file" />');" 
                                                    title="<spring:message code="validation.NoChosen" />" required />                                                    

                                                </div>
                                                <div class="file-path-wrapper">
                                                    <input class="file-path validate responsive-file-div" id="endUsersaveFileName" type="text">
                                                </div>
                                            </div>

                                            <!-- <div class="col s12 m6 l6" style="margin-top: 15px;">
                                                <label for="Category">Document Type <span class="star">*</span></label>
                                                <select class="browser-default">
                                                    <option value="" disabled selected>Select Document Type </option>
                                                    <option value="1">Passport Number</option>
                                                    <option value="2">Visa Number</option>
                                                    <option value="3">Pan Number</option>
                                                </select>
                                            </div> -->
                                        </div>
                                        
                                        <p style="margin-left: 10px;"><a href="./Consignment/sampleFileDownload/4"><spring:message code="input.downlaod.sample" /></a></p>
                                        <p style="margin-left: 10px;"> <spring:message code="input.requiredfields" /> <span class="star">*</span></p>
                                    </div>
                                    <div class="row" style="margin: 30px 0 30px 0;">
                                        <div class="input-field col s12 m12 l12 center">
                                            <!-- <a href="#submitStock" class="btn modal-trigger">Submit</a> -->
                                            <button class=" btn" id="endUserStock" type="submit"><spring:message code="button.submit" /></button>
                                            <a  class="btn" onclick="openCancelPopUp()"
                                                style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
                                        </div>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                                       <div class="container" style="margin-top:10vh;display: none" id="checkUploadStatusDiv" >
                    <div class="section">
                        <div class="row card-panel upload-stock-responsive-page" >
                            <!-- <a href="index.html" class="modal-close btn-flat modal-btn right"
                            
                                data-dismiss="modal">&times;</a> -->
                               
                               <h6 class="fixPage-modal-header ">
<div class="col s9 m10 l10 select-lang-lable-all width87">
<p><spring:message code="modal.CheckStatus" /></p>


<i class="fa fa-globe fa-6" aria-hidden="true"></i>
</div>
<div class="col s3 m2 l2 right width13" style="padding: 0;">
<select class="browser-default select-lang-drpdwn-all" id="langlistHeader">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
</div>
</h6>
                                 	
                                <div class="col s12 m12 l12">
                                <form action="" onsubmit="return validateTxnId()" method="POST"
								enctype="multipart/form-data" >
                                    <div class="row" id="singleInput">
                                        <div class="row">
                                            <div class="input-field col s6 m5">
                                                <label for="transactionID"><spring:message code="input.TransactionID2" /><span class="star">*</span> :</label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                               <input type="text" id="checktransactionID" name="checktransactionID"
                                                   pattern="<spring:eval expression="@environment.getProperty('pattern.transactionId')" />" 
 												oninput="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
												 title= "<spring:message code="validation.T18characters" />" required />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="input-field col s12 center">
                                               <!--  <a href="#" class="btn"
                                                    onclick="document.getElementById('singleInput').style.display ='none'; 
                                                    document.getElementById('inputDetails').style.display ='block';">Submit</a> -->
                                                    <button class=" btn" type="submit"><spring:message code="button.submit" /></button>
                                                <a href="./redirectToHomePage" class="btn"
                                                    style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
                                            </div>
                                        </div>
                                    </div></form>
                                    <div class="row" id="inputDetails" style="display: none;">
                                    <form action="" onsubmit="return updateFile()" method="POST"
								enctype="multipart/form-data" id="uploadStock">
                                        <div class="row">
                                            <div class="input-field col s6 m5">
                                                <label for="transactionID"><spring:message code="input.TransactionID3" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <input type="text" id="transactionID" name="transactionID"
                                                    placeholder="" readonly="readonly">
                                            </div>

                                            <div class="input-field col s6 m5">
                                                <label for="uploadDate"><spring:message code="input.UploadDate" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <input type="text" id="uploadDate" name="uploadDate"
                                                    placeholder="" readonly="readonly">
                                            </div>
                                            
                                            <div class="input-field col s6 m5">
                                                <label for="endUser" style="color: #000;"><spring:message code="input.EmailID" /> </label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <input type="text" id="viewEndUserEmail" name="viewEndUserEmail"
                                                    placeholder="" readonly="readonly">
                                            </div>
                                            
                                            <div class="input-field col s6 m5">
                                                <label for="endUserquantity" style="color: #000;"><spring:message code="input.quantity" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <input type="text" id="viewEndUserquantity" name="viewEndUserquantity"
                                                    placeholder="" readonly="readonly">
                                            </div>
                                            
                                            <div class="input-field col s6 m5">
                                               <label for="endUserDevicequantity" style="color: #000;"><spring:message code="input.devicequantity" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <input type="text" id="viewEdUserDevicequantity" name="viewEdUserDevicequantity"
                                                    placeholder="" readonly="readonly">
                                            </div>
                                            
                                            
                                            <div id="stockRemarkDivId" style="display: none">
                                            <div class="input-field col s6 m5">
                                                <label for="stockRemark"><spring:message code="input.Remark" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <input type="text" id="stockRemark" name="stockRemark"
                                                    placeholder="" readonly="readonly">
                                            </div>
                                            </div>
                                            <div class="input-field col s6 m5">
                                                <label for="viewUploadFile"><spring:message code="input.ViewUploadFile" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                               <a   id="endUserStockFileLink" > <i class="fa fa-download download-icon" aria-hidden="true"
                                                    style="position: absolute; right: 0; margin: 10px 15px 0 0;"
                                                    title="download"></i></a>
                                                <input type="text" id="viewUploadFile" name="viewUploadFile"
                                                     placeholder="" readonly="readonly">
                                            </div>
                                             <div class="input-field col s6 m5">
                                                <label for="errorFileStatus"><spring:message code="input.StockStatus" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <input type="text" id="errorFileStatus" name="errorFileStatus"
                                                    placeholder="" readonly="readonly">
                                            </div>
											<div id="errorFileStatusDiv" style="display: none;">
                                           
                                            

                                            <div class="input-field col s6 m5">
                                                <label for="errorFileName"><spring:message code="input.ViewErrorReport" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <a  id="errorFileStock"><i class="fa fa-download download-icon" aria-hidden="true"
                                                    style="position: absolute; right: 0; margin: 10px 15px 0 0;"
                                                    title="download"></i></a>
                                                <input type="text" id="errorFileName" name="errorFileName"
                                                    placeholder="" readonly="readonly">
                                            </div>

                                            <%-- <div class="input-field col s6 m5">
                                                <label for="viewUploadFile"><spring:message code="input.freshfile" /></label>
                                            </div>
                                            <div class="input-field col s6 m7">
                                                <div class=" boxHeight" style="margin-top: 8px;">
                                                    <input class="with-gap" name="group3" type="radio"
                                                        onclick="document.getElementById('uploadFile').style.display = 'block';">
                                                    <spring:message code="modal.yes" />
                                                </div>
                                            </div> --%>

													
                                            <div id="uploadFile" style="display: none;">
                                            
                                                <!-- <h6 class="file-upload-heading" style="margin-left: 15px;">Upload File
                                                </h6> -->
                                                <div class="file-field input-field col s12 m12"
                                                    style="margin-top: 5px;">
                                                    <div class="btn">
                                                        <span><spring:message code="input.selectfile" /></span>
                                                        <input type="file" id="csvUploadFile" required="required" accept=".csv">
                                                    </div>
                                                    <div class="file-path-wrapper">
                                                        <input class="file-path validate responsive-file-div"
                                                            type="text">
                                                    </div>
                                                </div><br><br>
                                               
                                            </div>
                                        </div></div>
                                        <div class="row">
                                            <div class="input-field col s12 center">
                                                <!-- <a href="homePage" class="btn" style="width: 100%;">ok</a> -->
                                                 <a href="./redirectToHomePage" class=" btn" id="updateEndUserStockOK" type=""><spring:message code="modal.close" /></a>
                                                <%-- <button class=" btn" id="updateEndUserStock" type="submit"><spring:message code="button.submit" /></button> --%>
                                            </div>
                                        </div>
                                         </form>
                                    </div>

                                    <div class="row" id="cancelInputDetails" style="display: none;">
                                        <h6><spring:message code="input.CancelStock" /></h6>
                                        <div class="row">
                                            <h6 style="margin-left: 15px;"><spring:message code="input.Exitpage" />
                                            </h6>
                                        </div>
                                        <div class="row">
                                            <div class="input-field col s12 center">
                                                <div class="input-field col s12 center">
                                                    <a href="index.html" class="btn"><spring:message code="modal.yes" /></a>
                                                    <button class="btn" style="margin-left: 10px;"
                                                        onclick="document.getElementById('singleInput').style.display = 'none';
                                                        document.getElementById('cancelInputDetails').style.display = 'none';
                                                        document.getElementById('inputDetails').style.display = 'block';"><spring:message code="modal.no" /></button>
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
            <!-- END CONTENT -->




    <!-- Submit Modal start   -->

    <div id="endUserStockModal" class="modal">
     <h6 class="modal-header"><spring:message code="modal.header.submitStock" /></h6>
        <div class="modal-content">
           
            <div class="row">
                <!-- <h6>Your request to upload device details has been accepted. The Transaction ID is ___________. Please
                    save this for future reference.
                    Kindly check the status of file upload by clicking on the check upload status button on the previous
                    page and providing the Transaction ID. -->
                   <h6 id="sucessMessageId"> <spring:message code="modal.message.stock" /> <span id="endUsertXnId"></span></h6>
             <!--    </h6> -->
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <div class="input-field col s12 center">
                        <a href="./redirectToHomePage" class="btn"><spring:message code="modal.ok" /></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <div id="cancelStock" class="modal">
         <h6 class="modal-header"><spring:message code="input.CancelStock" /></h6>
        <div class="modal-content">
           
            <div class="row">
                <h6><spring:message code="input.Exitpage" />
                </h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <div class="input-field col s12 center">
                        <a href="./redirectToHomePage" class="btn"><spring:message code="modal.yes" /></a>
                        <button class="btn" onclick="closeCancelPopUp()" style="margin-left: 10px;"><spring:message code="modal.no" /></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
     <div id="errorModal" class="modal">
         <h6 class="modal-header"><spring:message code="input.CheckStock" /></h6>
        <div class="modal-content">
           
            <div class="row">
                <h6 id=""><spring:message code="input.notTransactionId" />
                </h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <div class="input-field col s12 center">
                        <!-- <a href="homePage" class="btn">Yes</a> -->
                        <button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.ok" /></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
         <div id="fileUpdateSucessModal" class="modal">
         <h6 class="modal-header"><spring:message code="modal.Stockfileuplaod" /></h6>
        <div class="modal-content">
           
            <div class="row">
                <h6 id="endUserStockSuceesMessage">
                </h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <div class="input-field col s12 center">
                        <a href="./redirectToHomePage" class="btn"><spring:message code="modal.ok" /></a>
                        <!-- <button class="modal-close btn" style="margin-left: 10px;">OK</button> -->
                    </div>
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
						<button class=" btn" onclick="clearFileName()"
							style="margin-left: 10px;"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
    <!-- ================================================
    Scripts
    ================================================ -->
 <!-- jQuery Library -->
 
 
    
   <script type="text/javascript" src="${context}/resources/plugins/jquery-1.11.2.min.js"></script>
       <!-- ajax js -->
    <script type="text/javascript" src="${context}/resources/project_js/signup/Registration.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <!--materialize js-->
    <script type="text/javascript" src="${context}/resources/plugins/materialize.js"></script>

    <!--scrollbar-->
    <script type="text/javascript" src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    
   
    <!-- data-tables -->
    <script type="text/javascript" src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="${context}/resources/plugins/data-tables/data-tables-script.js"></script>
    
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
	
	
    <!--plugins.js - Some Specific JS codes for Plugin Settings-->

    <!--custom-script.js - Add your own theme custom JS-->
    <script type="text/javascript" src=""></script>
        <script type="text/javascript" src="${context}/resources/project_js/endUserStock.js?version=<%= (int) (Math.random() * 10) %>"></script>
 
<script type="text/javascript"
		src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>

   <script type="text/javascript">
   $('div#initialloader').delay(300).fadeOut('slow');
   </script>
</body></html>