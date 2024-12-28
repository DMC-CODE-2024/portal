<%@ page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Cache-Control", "no-store");
   response.setDateHeader("Expires", 0);
   response.setHeader("Pragma", "no-cache");
 
   int timeout = session.getMaxInactiveInterval();
   
   long accessTime = session.getLastAccessedTime();
   long currentTime = new Date().getTime();
   long dfd = accessTime + timeout;
   if (currentTime < dfd) {
  
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
<html lang="en">
<head>
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
<link rel="icon" type="image/x-icon"
	href="${context}/resources/assets/images/logo.png">
<%-- <link href="${context}/resources/css/materialize.css" type="text/css"
         rel="stylesheet" media="screen,projection"> --%>
<link rel="stylesheet"
	href="${context}/resources/assets/css/bootstrap.min.css">
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
	href="${context}/resources/project_css/iconStates.css">
<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<!-- CORE CSS-->
<link rel="stylesheet" href="${context}/resources/assets/css/style.css">
<script>
         var contextpath = "${context}";
      </script>
<style type="text/css">
.bg {
	background-color: #FFF !important;
	background: : #FFF !important;
}
</style>
</head>
<body data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-selected-username="${username}" data-featureId="${featureId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}" data-lang="${pageContext.response.locale}" data-lang-param="${pageContext.response.locale}">

	<div class="content-box">
		<div class="content-container" id="datatableViewDiv">
			<div id="initialloader"></div>
			<div class="content-header" id="pageHeader">
				<h1 id="pageHeaderTitle"></h1>
				<div class="toggle-row ml-auto mr-4"></div>
			</div>
			<div class="filter-box" id="filterBox">
				<form action="" class="filter-row" id="filterform">
					<div id="errorMsgDiv" class="filter-form-row" style="width: 100%;"></div>
					<div id="dataTableDiv" class="filter-form-row"></div>
					<div id="filterButtonDiv" class="filter-btn-row"></div>
					<div id=textbox-container></div>
				</form>
			</div>
			<div id="LibraryTableDiv" class="table-box">
				<div class="table-responsive">
					<table id="LibraryTable" class="table">
						<thead class="thead-dark"></thead>
					</table>
				</div>
				<div id="footerBtn" class="table-paginationbox"></div>
			</div>
		</div>
	</div>
</body>

<!-- Modal View-->
<!-- Modal View-->
<div class="modal fade" id="ViewTrackLostDeviceModel" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel"><spring:message code="stolen.popup.approve" /></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="content-container">
					<form id="stolenFormID" action="">
						<h4>
							<spring:message code="stolen.heading2" />
						</h4>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.contact1" />
									<span class="star"></span></label> <input readonly="readonly"
									type="text" class="form-control bg" id="stolenMobile1" /> <input
									type="text" class="form-control bg" id="stolenMgmtid"
									style="display: none"> <input type="text"
									class="form-control bg" id="stolenMgmtRequestid"
									style="display: none">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.IMEI1" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="stolenIMEI1" />
							</div>
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.IMEI2" /> <span
									class="star"></span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="stolenIMEI2" />
							</div>


						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.IMEI3" /> <span
									class="star"></span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="stolenIMEI3" />
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.IMEI4" /> <span
									class="star"></span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="stolenIMEI4" maxlength="16" />
							</div>
						</div>

						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message
										code="stolen.db.Device_brand" /> <span class="star">*</span></label>
								<input readonly="readonly" type="text" class="form-control bg"
									id="stolenDeviceBrand" required>
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message
										code="stolen.db.Device_model" /> <span class="star">*</span></label>
								<input readonly="readonly" type="text" class="form-control bg"
									id="stolenDeviceModel" required>
							</div>


						</div>

						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.deviceType" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" class="form-control bg" id="stolenDeviceType"
									required>
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.serialNumber" />
									</label> <input readonly="readonly"
									type="text" class="form-control bg" id="stolenSerialNumber"
									required>
							</div>


						</div>

						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message
										code="stolen.devicePurchaseInvoice" /> </label>
								<div class="file-path-wrapper flexIcon">
									<input readonly="readonly" class="form-control mr-10 bg"
										id="fileNameEdit" type="text"> <a href="#"
										id="stolenPreviewID" style="margin-top: 6px;"> <img
										src="./resources/assets/images/eye-icon.svg" alt="icon"
										class="img-fluid">
									</a>
								</div>
							</div>
							
						</div>
						<h4>
							<spring:message code="stolen.InfoHeading" />
						</h4>

						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.date" /> <span
									class="star">*</span></label> <input readonly="readonly" type="date"
									id="stolenDate" class="form-control text-uppercase bg" required>
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.time" /> <span
									class="star">*</span></label> <input readonly="readonly" type="time"
									id="stolenTime" class="form-control text-uppercase bg" required>
							</div>
						</div>

						<div class="form-row">

							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.provinceCity" />
									<span class="star">*</span></label>
								<!-- <select class="form-control" id="provinceCity" onchange="getDistrict('provinceCity')" required="required">
                         
                      </select> -->
								<input readonly="readonly" type="text" class="form-control bg"
									id="provinceCity">
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.district" /> <span
									class="star">*</span></label>
								<!--  <select class="form-control" id="district" required="required" onchange="getCommune('district')">
                         
                      </select> -->
								<input readonly="readonly" type="text" class="form-control bg"
									id="district">
							</div>


						</div>

						<div class="form-row">

							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.commune" /> <span
									class="star">*</span></label>
								<!-- <select class="form-control" id="commune" required="required" onchange="getPolice('commune')">
                         
                      </select> -->
								<input readonly="readonly" type="text" class="form-control bg"
									id="commune">
							</div>
							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.policeStation" />
									<span class="star">*</span></label>
								<!-- <select class="form-control" id="policeStation" required="required">
                        </select> -->

								<input readonly="readonly" type="text" class="form-control bg"
									id="policeStation">
							</div>
						</div>

						<div class="form-row">

							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.category" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="category">
							</div>
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.incident" />
									<span class="star">*</span></label>
								<!-- <select class="form-control" id="policeStation" required="required">
                        </select> -->

								<input readonly="readonly" type="text" class="form-control bg"
									id="stolenIncident">
							</div>
						</div>

						<h4>
							<spring:message code="lost.Nationality" />
						</h4>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.Nationality" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" class="form-control bg" id="ownerNationality">
							</div>
						</div>
						<h4>
							<spring:message code="stolen.personalInfo" />
						</h4>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.owner" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									required class="form-control bg" id="stolenOwner" />
							</div>

							<div class="form-group col-md-6" id="ownerEmailDiv">
								<label for=""><spring:message code="stolen.email" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="stolenEmail" required />
							</div>


							<div class="form-group col-md-6" id="ownerDOBlDiv"
								style="display: none">
								<label for=""><spring:message code="stolen.ownwerDOB" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="date" id="ownerDOB"
									class="form-control bg text-uppercase">
							</div>



						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.Address1" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" required class="form-control bg"
									id="stolenOwnerAddress1" />
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.Address2" />
								</label> <input readonly="readonly" type="text" class="form-control bg"
									id="stolenOwnerAddress2" />
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6" id="ownerNIDdiv">
								<label for=""> <spring:message code="stolen.nid" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									required class="form-control bg" id="stolenOwnerNID" />
							</div>

							<div class="form-group col-md-6" id="ownerPassportDiv"
								style="display: none">
								<label for=""> <spring:message code="stolen.passport" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" class="form-control bg" id="stolenOwnerPassport" />
							</div>

							<div class="form-group col-md-6" id="otpContactDiv">
								<label for=""><spring:message code="stolen.OTPContact" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" required class="form-control bg"
									id="stolenOwnerOTPContact" />
							</div>

							<div class="form-group col-md-6" id="otpEmailDiv"
								style="display: none">
								<label for=""><spring:message code="stolen.emailPassport" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="stolenOtpEmail" />
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="" id="NIDblockLabel"><spring:message code="stolen.nidUpload" /> <span class="star">*</span></label>
                                             <label for="" id="PassportblockLabel"style="display: none"><spring:message code="stolen.passportUpload" /> <span class="star">*</span></label>
								<%-- <input disabled="disabled" type="file"  class="input-file mb-1" id="stolenOwnerNIDfile" accept="image/*,.pdf">
            	<p><small><spring:message code="stolen.complaintCopyType" /></small></p> --%>
								<div class="file-path-wrapper flexIcon">
									<input readonly="readonly" class="form-control mr-10 bg"
										id="fileNameEdit2" type="text"> <a href="#"
										id="stolenPreviewID2" style="margin-top: 6px;"> <img
										src="./resources/assets/images/eye-icon.svg" alt="icon"
										class="img-fluid">
									</a>
								</div>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-12 mb-4">
								<label for=""><spring:message code="input.Remark" /></label>
								<textarea class="form-control bg" readonly="readonly" id="addRemark" rows="2"
									maxlength="250"
									placeholder="<spring:message code="stolen.approve.remark" />" ></textarea>
								<input type="text" id="requestNo1" name="requestNo"
									style="display: none;"> <span class="star"
									id="errorRemarks"></span>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div class="no-border flex-end"  id="MOI_STATUS_WISE_SHOW_SINGLE">
									<a href="#" onclick='requestReject("REJECT")'
										class="btn cancel-btn"><spring:message code="modal.header.reject" /></a>

									<!--  <button type="submit" id="stolenLostButton" class="btn save-button-dark">Approve</button> -->

									<a onclick='requestApproved("START")' id="submitButton"
										class="btn save-button-dark" data-dismiss="modal"> <spring:message code="modal.header.approve" />
									</a>
								</div>
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal View close-->


<!-- Modal View-->
<div class="modal fade" id="ViewBulkLostDeviceModel" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel"><spring:eval expression="@environment.getProperty('stolen.popup.approve')" /></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="content-container">
					<form id="stolenFormID" action="">
						<h4>
							<spring:message code="stolen.heading2" />
						</h4>

						<div class="form-row">
							<div class="form-group col-md-6">
								<table border="0" style="margin-top: 15px;">
									<tr>
										<td style="vertical-align:top"><label for="" id="fileNameBulksEdit"> </label></td>
										<td></td>
										<td><a href="" id="fileNameBulkEdit"
											style="margin-left: 15px;"> <img  style="width: 20px"
												src="./resources/assets/images/download-icon-blue.svg"
												alt="icon" class="img-fluid">
										</a></td>
									</tr>
								</table>



							</div>
							<div class="form-group col-md-6">
								<table border="0" style="margin-top: 15px;">
									<tr>
										<td style="vertical-align:top"><label for="" id="fileBulkName"></label></td>
										<td></td>
										<td><a href="#" id="stolenPreviewIDBulk"
											style="margin-left:15px;"> <img style="width: 20px"
												src="./resources/assets/images/eye-icon.svg"
												alt="icon" class="img-fluid">
										</a></td>
									</tr>
								</table>

							</div>
						</div>
						<h4>
							<spring:message code="stolen.InfoHeading" />
						</h4>

						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.date" /> <span
									class="star">*</span></label> <input readonly="readonly" type="date"
									id="stolenDateBulk" class="form-control text-uppercase bg" required>
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.time" /> <span
									class="star">*</span></label> <input readonly="readonly" type="time"
									id="stolenTimeBulk" class="form-control text-uppercase bg" required>
							</div>
						</div>

						<div class="form-row">

							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.provinceCity" />
									<span class="star">*</span></label>
								<!-- <select class="form-control" id="provinceCity" onchange="getDistrict('provinceCity')" required="required">

                      </select> -->
								<input readonly="readonly" type="text" class="form-control bg"
									id="provinceCityBulk">
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.district" /> <span
									class="star">*</span></label>
								<!--  <select class="form-control" id="district" required="required" onchange="getCommune('district')">

                      </select> -->
								<input readonly="readonly" type="text" class="form-control bg"
									id="districtBulk">
							</div>


						</div>

						<div class="form-row">

							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.commune" /> <span
									class="star">*</span></label>
								<!-- <select class="form-control" id="commune" required="required" onchange="getPolice('commune')">

                      </select> -->
								<input readonly="readonly" type="text" class="form-control bg"
									id="communeBulk">
							</div>
							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.policeStation" />
									<span class="star">*</span></label>
								<!-- <select class="form-control" id="policeStation" required="required">
                        </select> -->

								<input readonly="readonly" type="text" class="form-control bg"
									id="policeStationBulk">
							</div>
						</div>

						<div class="form-row">


							<div class="form-group col-md-12">
								<label for=""><spring:message code="stolen.incident" />
									<span class="star">*</span></label>
								<!-- <select class="form-control" id="policeStation" required="required">
                        </select> -->

								<input readonly="readonly" type="text" class="form-control bg"
									id="stolenIncidentBulk">
							</div>
						</div>

						<h4>
							<spring:message code="stolen.heading2" />
						</h4>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="lost.Nationality" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" class="form-control bg" id="ownerNationalityBulk">
							</div>
						</div>
						<h4>
							<spring:message code="stolen.personalInfo" />
						</h4>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.owner" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									required class="form-control bg" id="stolenOwnerBulk" />
							</div>

							<div class="form-group col-md-6" id="ownerEmailDivBulk">
								<label for=""><spring:message code="stolen.email" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="stolenEmailBulk" required />
							</div>


							<div class="form-group col-md-6" id="ownerDOBlDivBulk"
								style="display: none">
								<label for=""><spring:message code="stolen.ownwerDOB" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="date" id="ownerDOBBulk"
									class="form-control bg text-uppercase">
							</div>



						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.Address1" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" required class="form-control bg"
									id="stolenOwnerAddress1Bulk" />
							</div>

							<div class="form-group col-md-6">
								<label for=""><spring:message code="stolen.Address2" />
								</label> <input readonly="readonly" type="text" class="form-control bg"
									id="stolenOwnerAddress2Bulk" />
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6" id="ownerNIDdivBulk">
								<label for=""> <spring:message code="stolen.nid" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									required class="form-control bg" id="stolenOwnerNIDBulk" />
							</div>

							<div class="form-group col-md-6" id="ownerPassportDivBulk"
								style="display: none">
								<label for=""> <spring:message code="stolen.passport" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" class="form-control bg" id="stolenOwnerPassportBulk" />
							</div>

							<div class="form-group col-md-6" id="otpContactDivBulk">
								<label for=""><spring:message code="stolen.OTPContact" />
									<span class="star">*</span></label> <input readonly="readonly"
									type="text" required class="form-control bg"
									id="stolenOwnerOTPContactBulk" />
							</div>

							<div class="form-group col-md-6" id="otpEmailDivBulk"
								style="display: none">
								<label for=""><spring:message code="stolen.emailPassport" /> <span
									class="star">*</span></label> <input readonly="readonly" type="text"
									class="form-control bg" id="stolenOtpEmailBulk" />
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="" id="NIDblockLabelDiv"><spring:message code="stolen.nidUpload" /> <span class="star">*</span></label>
                                <label for="" id="PassportblockLabelDiv"style="display: none"><spring:message code="stolen.passportUpload" /> <span class="star">*</span></label>
								<%-- <input disabled="disabled" type="file"  class="input-file mb-1" id="stolenOwnerNIDfile" accept="image/*,.pdf">
            	<p><small><spring:message code="stolen.complaintCopyType" /></small></p> --%>
								<div class="file-path-wrapper flexIcon">
									<input readonly="readonly" class="form-control mr-10 bg"
										id="fileNameEdit2Bulk" type="text"> <a href="#"
										id="stolenPreviewID2Bulk" style="margin-top: 6px;"> <img
										src="./resources/assets/images/eye-icon.svg" alt="icon"
										class="img-fluid">
									</a>
								</div>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-12 mb-4">
								<label for=""><spring:message code="stolen.Remark" /></label>
								<textarea class="form-control" id="addRemarkBulk" rows="2"
									maxlength="250" placeholder="<spring:message code="stolen.approve.remark" />" ></textarea>
								<input type="text" id="requestNo1Bulk" name="requestNo"
									style="display: none;"> <span class="star"
									id="errorRemarksBulk"></span>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div class="no-border flex-end" id="MOI_STATUS_WISE_SHOW_BULK">
									<a href="#" onclick='requestRejectBulk("REJECT")'
										class="btn cancel-btn"><spring:message code="modal.header.reject" /></a>

									<a onclick='requestApproved("START")' id="submitButton"
										class="btn save-button-dark" data-dismiss="modal"> <spring:message code="modal.header.approve" />
									</a>
								</div>
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal Bulk View close-->
<!-- Modal Bulk View close-->

<div class="modal fade" id="noRecordMessage" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Track
					Lost/Stolen Device Details</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true" onclick="ResetModel()" class="cross">&times;</span>
				</button>
			</div>
			<div class="modal-body prl-30">
				<div class="form-group col-md-12" style="text-align: center;">
					<h4><spring:message code="stolen.request.notfound" /></h4>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- Save Modal close-->



<!-- Modal MOI Admin Approve-->
<div class="modal fade" id="approveMOIAdminModal" tabindex="-2"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<div class="form-row">

					<div class="form-group col-md-12" style="text-align: center;">
						<p class="mb-10">
							<img src="${context}/resources/assets/images/CheckIcon.svg"
								" alt="logo" class="img-fluid" style="width: 45px">
						</p>
						<h4><spring:message code="stolen.approve.success" /></h4>
					</div>
				</div>


				<div class="form-row">
					<div class="form-group col-md-12 center">
						<div class="form-group col-md-12 center">
							<a href="./moiAdminTrackLostDevice" class="btn save-button-dark center"
								data-dismiss="modal"><spring:message code="Stolen.done" /></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Priview -->

<!-- Modal MOI Admin Approve-->
<div class="modal fade" id="rejectedMOIAdminModal" tabindex="-10"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">

				<div class="form-row">
					<div class="form-group col-md-12" style="text-align: center;">
						<p class="mb-10">
							<img src="${context}/resources/assets/images/close.svg"
								alt="logo" class="img-fluid" style="width: 45px">
						</p>
						<h4><spring:message code="stolen.reject.success" /></h4>
					</div>

				</div>

				<div class="form-row">
					<div class="form-group col-md-12 center">
						<a href="./moiAdminTrackLostDevice" class="btn save-button-dark center"
							data-dismiss="modal"><spring:message code="Stolen.done" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" id="viewuplodedModel" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" onclick="closeModal1()">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<img src="" id="fileSource" width="100%">
			</div>
		</div>
	</div>
</div>
<!-- Priview END -->

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
      src="${context}/resources/project_js/service_status.js"></script>
   <script type="text/javascript"
      src="${context}/resources/project_js/viewStolenMOIAdminDevice.js?version=<%= (int) (Math.random() * 10) %>"></script>
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