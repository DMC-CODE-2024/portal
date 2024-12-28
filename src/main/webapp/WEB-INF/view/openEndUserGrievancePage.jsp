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
 --%>    <!-- Favicons-->
    <!--<link rel="icon" href="images/favicon/favicon-32x32.png" sizes="32x32">-->
    <!-- Favicons-->
        <link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
  <link rel="stylesheet" href="${context}/resources/font/font-awesome/css/font-awesome.min.css">

    <!-- CORE CSS-->
    <link href="${context}/resources/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="${context}/resources/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
   
    <!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
    <link href="${context}/resources/plugins/prism/prism.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.css" type="text/css" rel="stylesheet"
        media="screen,projection">
    <link href="${context}/resources/plugins/chartist-js/chartist.min.css" type="text/css" rel="stylesheet" media="screen,projection">
   <link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">
    <style>
 /*        ul li {
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
           /*  border: none; */
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
           /*  height: 35px; */
            margin: 0 0 5px 0;
        }

        footer {
            padding-left: 0;
        }

        .card-panel {
            width: 50%;
            margin-top: 0vh;
        }
        .row.card-panel.headerLang {
          width: 100%;
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
        .selectDropdwn {
   margin-top: 0;
}
 div#trackGrievanctableDiv {
    width: 70%;
} 
.backdrop {
	display: none !important;
}


    </style>
<script>
var contextpath = "${context}";
</script>

</head>
<body data-lang-param="${pageContext.response.locale}" onLoad='self.scrollTo(0,0)'>
         <!-- START CONTENT -->
            <section id="content">
            <div id="initialloader"></div>
           
                <!--start container-->
                <div class="container" style="margin-top: 10vh;" >
                    <div class="section">
                        <div class="row card-panel  login-card-panel" id="endUserRaiseGrievance" style="display: none">
                           <h6 class="fixPage-modal-header">

<div class="col s9 m10 l10 select-lang-lable-all width87">
<p> <spring:message code="modal.Grievance" /> </p>



<i class="fa fa-globe fa-6" aria-hidden="true"></i>
</div>
<div class="col s3 m2 l2 right width13">
<select class="browser-default select-lang-drpdwn-all " id="langlist">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
</div>

</h6>
                            <form onsubmit="return saveaAonymousGrievance()" method="POST" enctype="multipart/form-data" >
                             <input type="text" id="pageTypeValue" value="${reportType}" style="display: none;">
                                <div class="col s12 m12 l12">
                                    <div class="row">
                                        <div class="input-field col s12 m4">
                                            <input type="text" id="firstName"  name="firstName"  required="required" 
                                            pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"/>
                                            <label for="firstName"><spring:message code="input.firstName" /> <span class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m4">
                                            <input type="text" id="middleName" name="middleName"
                                            pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"  />
                                            <label for="middleName"><spring:message code="input.middleName" /></label>
                                        </div>

                                        <div class="input-field col s12 m4">
                                            <input type="text" id="lastName" name="lastName" 
                                            pattern="<spring:eval expression="@environment.getProperty('pattern.name')" />"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.20Character" />');"
													    />
                                            <label for="lastName"><spring:message code="input.lastName" /> <span class="star"></span></label>
                                        </div>

                                        <div class="input-field col s12 m6">
                                            <input type="text" id="contactNumber" name="contactNumber" maxlength="10"
                                            pattern="<spring:eval expression="@environment.getProperty('pattern.contactNo')" />"
 													oninput="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.10digits" />');"
												  required    />
                                            <label for="contactNumber"><spring:message code="input.contact" /><span
                                                    class="star">*</span></label>
                                        </div>

                                        <div class="input-field col s12 m6">
                                            <input type="email" id="emailID" name="emailID" 
                                            pattern="<spring:eval expression="@environment.getProperty('pattern.mail')" />"
											oninput="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.emailformate" />');"
												required />
                                            <label for="emailID"><spring:message code="input.EmailID" /> <span class="star"> *</span></label>
                                        </div>

                                        <div class="col s12 m6 selectDropdwn">
                                            <label for="endUsercategory"><spring:message code="input.Category" /> <span class="star">*</span></label>
                                            <select class="browser-default" 
											title="<spring:message code="" />" oninput="setCustomValidity('')"  
										            oninput="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.selectFieldMsg" />');"
										  required   id="endUsercategory">
                                                <option value="" selected><spring:message code="input.SelectCategory" /></option>
                                            </select>
                                        </div>

                                       
                                       <div class="input-field col s12 m6" style="margin-top: 22px;">
                                            <input type="text" id="endUsertransactionId" name="transactionId" 
                                               pattern="<spring:eval expression="@environment.getProperty('pattern.transactionId')" />"  
      										 oninput="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
												 />
                                            <label for="endUsertransactionId"><spring:message code="input.TransactionID1" /></label>
                                        </div>
                                       
                                       
                                        <div class="input-field col s12 m12">
                                            <textarea id="endUserRemark" 
										  oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
													
												  required   maxlength="200" class="materialize-textarea" style= "min-height: 8rem;"></textarea>
                                            <label for="endUserRemark"><spring:message code="input.remarks" /><span
                                                    class="star">*</span></label>
                                        </div>

								</div>
									<div id="endUsermainDiv" class="endUsermainDiv">
									<div id="endUserfilediv" class="endUserfileDiv">	
                                    <div class="row">
                                        <div class="col s12 m6">
                                            <label for="endUserdocTypetag1"><spring:message code="input.documenttype" /></label>
                                            
                                            <select class="browser-default" id="endUserdocTypetag1"
                                                     oninput="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.18digit" />');"
                                             onchange="enableSelectFile()">
                                            
                                                <option value="" selected><spring:message code="select.documenttype" /></option>
                                            </select>
                                        </div>

                                        
                                        <div class="file-field col s12 m6" id="removestar">
                                            <h6 class="upload-file-label" id="endUserFileLabel"><spring:message code="modal.UploadSupporting" />
                                            </h6>
                                            <div class="btn">
                                                <span><spring:message code="input.selectfile" /></span>
                                                <input id="endUserdocTypeFile1" type="file"   onchange="enableEndUserAddMore('endUserdocTypeFile1','endUserfilediv')"  disabled="disabled"
 												
						oninput="InvalidMsg(this,'input','<spring:message code="validation.NoChosen" />');"
													oninvalid="InvalidMsg(this,'input','<spring:message code="validation.NoChosen" />');"
						 name="files[]" id="filer_input"
                                                    multiple="multiple" />
                                            </div>
                                            <div class="file-path-wrapper" >
                                                <input class="file-path validate" type="text" id="filetextField"
                                                    placeholder="<spring:message code="input.selectfile" />">
                                            </div>
                                        </div>

                                        <div class="input_fields_wrap"></div>

                                      
                                       
                                    </div>
									</div>
									</div>	

                                      <div class="col s12 m6 right">
                                            <button class="btn right endUser_add_field_button" disabled><span
                                                    style="font-size: 20px;">+</span><spring:message code="input.addmorefile" /></button>
                                        </div>
                                         <p><spring:message code="input.requiredfields" /> <span class="star">*</span></p>
                                    <div class="row" style="margin-top: 30px;">
                                        <div class="input-field col s12 m12 l12 center">
                                            <button class="btn" id="saveAnonymousGrieavance" type="submit"><spring:message code="button.submit" /></button>
                                            <a onclick="openCancelPopUp()" class="btn"
                                                style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
                                        </div>
                                    </div>

                                </div>
                            </form>
                        </div>
                        
                        
                           <div class="row card-panel login-card-panel" id="trackGrievanceHeader" >
                              
                     <!--        <a href="./redirectToHomePage" class="modal-close btn-flat modal-btn right" data-dismiss="modal">&times;</a> -->
                            <h6 class="fixPage-modal-header ">
<div class="col s9 m10 l10 select-lang-lable-all width87">
<p><spring:message code="modal.TrackGrievance" /></p>


<i class="fa fa-globe fa-6" aria-hidden="true"></i>
</div>
<div class="col s3 m2 l2 right width13" style="padding: 0;">
<select class="browser-default select-lang-drpdwn-all" id="langlistTrack">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
</div>
</h6>
                           <div id="trackGrievanceDiv" style="display: none;">
                            <div class="col s12 m12 l12">
                                <form action="" onsubmit="return endUsergrivanceLibraryTable()" method="POST" enctype="multipart/form-data">
                                    <div class="row" id="singleInput">
                                        <!-- <h6>Track Grievance</h6>
                                        <hr> -->
                                        <div class="row">
                                            <div class="input-field col s6 m6 l5">
                                                <label for="trackGrievanceId"><spring:message code="modal.PleaseGrievanceID" /><span class="star">*</span> :</label>
                                            </div>
                                            <div class="input-field col s6 m6 l6">
                                                <input type="text" id="trackGrievanceId"  name="trackGrievanceId" 
                                                pattern="<spring:eval expression="@environment.getProperty('pattern.transactionId')" />" 
													oninput="InvalidMsg(this,'input','<spring:message code="validation.18digitGrievanceId" />');"
												oninvalid="InvalidMsg(this,'input','<spring:message code="validation.18digitGrievanceId" />');"
												 title= "<spring:message code="validation.18characters" />" required >
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="input-field col s12 center">
                                                <button class="btn" type="submit" ><spring:message code="button.submit" /></button>
                                                <a href="./redirectToHomePage" class="btn" style="margin-left: 10px;"><spring:message code="button.cancel" /></a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                </div>
                               
                            </div>
                            
                               
                        </div>
                            <div class="row card-panel track-grievance-responsive-page" id="trackGrievanctableDiv" style="display: none" >
                            
                                     <h6 class="fixPage-modal-header">
<div class="col s9 m10 l10 select-lang-lable-all width87">
<p> <spring:message code="modal.TrackGrievance" /> </p>



<i class="fa fa-globe fa-6" aria-hidden="true"></i>
</div>
<div class="col s3 m2 l2 right width13" style="padding: 0;">
<select class="browser-default select-lang-drpdwn-all " id="langlistTable">
<option value="en" class="fontBlack">English</option>
<option value="km" class="fontBlack"><spring:message code="lang.khmer" /></option>
</select>
</div>


</h6>
              
                          
                        <table id="endUsergrivanceLibraryTable" style="display: none"
								class="responsive-table striped display"></table>
								  <div class="input-field col s12 m12 l12 center">
                                           
                                            <a href="./redirectToHomePage" class="btn" style="margin-left: 10px;"><spring:message code="modal.close" /></a>
                                        </div>
                    
                </div>
                
								</div></div>
                <!--end container-->
            </section>
            <!-- END CONTENT -->



 
    <!-- END FOOTER -->

    <!-- Grievance Modal start   -->

    <!-- Grievance Modal End -->

    <!-- Otp Modal start   -->



    <!-- Otp Modal End -->

    <!-- cancel Modal start   -->

    <div id="cancelMessage" class= " full-screen-modal modal" >
         <h6 class="modal-header"><spring:message code="button.cancel" /></h6>
        <div class="modal-content">
           <div class="row">
                <h6><spring:message code="modal.message" /></h6>
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
    
     <div id="exceptionMessage" class="full-screen-modal modal">
       <h6 class="modal-header"><spring:message code="modal.SaveGrievance" /></h6>
        <div class="modal-content">
            <div class="row">
                <h6><spring:message code="modal.Somethingwrong" /></h6>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <div class="input-field col s12 center">
                        
                        <button class="modal-close btn" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

    <div id="GrievanceMsg" class="full-screen-modal modal">
    <h6 class="modal-header"><spring:message code="modal.header.submitGReport" /></h6>
        <div class="modal-content">
            
            <div class="row">
                <h6 ><spring:message code="modal.message.grievance" /> <span id="sucessMessageGrievance"></span></h6>

                <p ><spring:message code="modal.note" /></p>
            </div>
            <div class="row">
                <div class="input-field col s12 center">
                    <a href="./redirectToHomePage" class="btn"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>
    <!-- cancel Modal End -->

	<div id="replyModal" class="full-screen-modal modal" >
        <button class="modal-close btn-flat right" onclick="cleanReplyPopUp()">&times;</button>
             <h6 class="modal-header"><spring:message code="input.reply" /></h6>
             <div class="modal-content">
             <form id="replymessageForm" onsubmit="return saveGrievanceReply()" method="POST" enctype="multipart/form-data" >
            <div class="row">
                <div class="col s12 m12">
                    <h6 style="font-weight: bold;"><spring:message code="input.grievID" /><span id="grievanceIdToSave"></span></h6>
                    <span id="grievanceTxnId" style="display: none;"></span>
                    <hr>
                </div>

                <div class="col s12 m12" id="viewPreviousMessage">
                   <!--  <h6 style="float: left; font-weight: bold;" id="mesageUserType"> </h6>
                    <h6 style="float: left;"></h6>
                        <span style="float:right;"></span> -->
                </div>
               <input type="text" id="grievanceSelectedCategory" style="display: none">
 
               <div class="col s12 m12">
                  <label for="replyRemark" style="margin-top: 7px"><spring:message code="input.remarks" /><span class="star">*</span></label>
                    <textarea id="replyRemark" class="materialize-textarea" 
                    oninput="InvalidMsg(this,'input');" oninvalid="InvalidMsg(this,'input');"
                    title= "<spring:message code="validation.200characters" />" required maxlength="200" placeholder=""></textarea>
                    <input type="text" style="display: none" id="grievanceUserid">
                    <!-- <h6 style="color: #000;">Upload Supporting Document </h6> -->
                </div>
               <!--   <div class="file-field col s12 m12">
                    <div class="btn"><span>Select File</span><input id="replyFile" type="file" accept=".csv" ></div>
                    <div class="file-path-wrapper"><input class="file-path validate" type="text"
                            placeholder="">
                        <div>
                            <p id="myFiles"></p>
                        </div>
                    </div>
                </div> -->
                
 <div id="mainDiv" class="mainDiv">
<div id="filediv" class="fileDiv">
<div class="row">

<div class="col s12 m6 l6" style="margin-top: 8px;">
<label for="Category"><spring:message code="input.documenttype" /></label>
<select class="browser-default" id="docTypetag1" onchange="enableReplySelectFile()" >
<option value="" disabled selected><spring:message code="select.documenttype" /> </option>

</select>

</div>

<div class="file-field col s12 m6" id="removestar1">
<h6 id="docTypeFile1Label" style="color: #000;"><spring:message code="input.supportingdocument" /></h6>
<div class="btn">
<span><spring:message code="input.selectfile" /></span>
<input type="file" name="files[]" id="docTypeFile1" disabled="disabled" onchange="enableEndUserReplyAddMore('docTypeFile1','filediv')" 
oninput="InvalidMsg(this,'input','<spring:message code="validation.NoChosen" />');"
oninvalid="InvalidMsg(this,'input','<spring:message code="validation.NoChosen" />');"
 multiple>

</div>
<div class="file-path-wrapper">
<input class="file-path validate" type="text" id="filetextField1" multiple
placeholder="<spring:message code="input.selectfile" />">
<div>
<p id="myFiles"></p>
</div>
</div>
</div>

</div>


</div>

</div>
<div class="col s12 m6 right">
<button class="btn right add_field_button" disabled="disabled"><span
style="font-size: 20px;">+</span> <spring:message code="input.addmorefile" /></button>
</div>
              <div class="col s12 m12">  <p>
              <p id="closeTicketCheckbox" style="float: left; display: none;">
                        <label>
                            <span><spring:message code="modal.message.griev.closeticket" /></span>
                            <input type="checkbox" id="closeTicketCheck" />
                        </label>
                    </p> <br>
				<!-- <a href="./Consignment/sampleFileDownload/filetype=sample">Download Sample Format</a><br> -->
			

			<span> <spring:message code="input.requiredfields" /> <span class="star">*</span></span>
			
                </div>
                <div class="col s12 m12 center">
                 <%-- <p id="closeTicketCheckbox" style="float: left; display: none;">
                        <label>
                            <span><spring:message code="modal.message.griev.closeticket" /></span>
                            <input type="checkbox" id="closeTicketCheck" />
                        </label>
                    </p> --%>
                    <button class="right btn" type="submit" id="grievanceReplyButton"><spring:message code="input.reply" /></button>
                </div>
            </div>
            </form>
        </div>
    </div>

 <div id="replyMsg" class="full-screen-modal modal">
    <h6 class="modal-header"><spring:message code="modal.header.grievancereply" /></h6>
    <div class="modal-content">
        
        <div class="row">
            <h6 id="showReplyResponse"><spring:message code="modal.message.grievance.reply" /><span id="replyGrievanceId"> </span> <spring:message code="modal.issuccessful" /></h6>
        </div>
        <div class="row">
            <div class="input-field col s12 center">
                <div class="input-field col s12 center">
                    <a href="./redirectToHomePage" class="modal-close btn"><spring:message code="modal.ok" /></a>
                </div>
            </div>
        </div>
    </div>
</div>
  <div id="errorModal" class=" full-screen-modal modal">
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
    
    <div id="manageAccount" class=" full-screen-modal modal">
<button class="modal-close btn-flat right" data-dismiss="modal" style=" font-size: 25px;">&times;</button>
<h6 class="modal-header"><spring:message code="modal.header.grievancehistory" /></h6>
<div class="modal-content">
<div id="live-chat">
<div class="chat">
<div class="chat-history">
<div class="chat-message clearfix" id="chatMsg">

</div> <!-- end chat-message -->


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
			<input type="text" id='removeFileId' style="display: none;">
			<input type="text" id='removeFileInput' style="display: none">
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
	<div id="viewuplodedModel" class="modal" style="overflow: hidden">
		<a href="#!" class="modal-close waves-effect waves-green btn-flat">&times;</a>
		<div class="modal-content">
			<div class="row">
				<img src="" id="fileSource" width="400" height="400">
			</div>
		</div>
	</div>
    <!-- ================================================
    Scripts
    ================================================ -->
 <script type="text/javascript"
	src="${context}/resources/custom_js/2.2.1_jquery.min.js"></script>
	   <!-- ajax js -->
   <script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
  
    <script type="text/javascript"
		src="${context}/resources/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
    
   <!--plugins.js - Some Specific JS codes for Plugin Settings-->

   
<!-- i18n library -->
	<script type="text/javascript">
var path="${context}";
</script>
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
<script type="text/javascript" src="${context}/resources/project_js/signup/Registration.js?version=<%= (int) (Math.random() * 10) %>"></script>
    

    <script type="text/javascript"
		src="${context}/resources/project_js/grievanceManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
    <script type="text/javascript"
		src="${context}/resources/project_js/endUserGrievance.js?version=<%= (int) (Math.random() * 10) %>"></script>
	
		<script type="text/javascript"
		src="" async></script>
	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
<script type="text/javascript"
		src="${context}/resources/project_js/ValidationFileOutsidePortal.js?version=<%= (int) (Math.random() * 10) %>"></script>


  <script type="text/javascript">
/*   $('div#initialloader').delay(300).fadeOut('slow'); */
  </script> 
</body></html>
