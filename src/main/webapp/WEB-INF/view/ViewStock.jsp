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
	
	if (session.getAttribute("usertype") != null) { */
%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!-- Security Tags -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:csrfMetaTags />
<!-- Security Tags -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html class="no-js" lang="en" dir="ltr">
<head><title>EIRS Portal</title>
<!--<title>Stock</title>-->
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='-1'>
<meta http-equiv='pragma' content='no-cache'>
<meta name="fragment" content="!">
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

<script type="text/javascript"
	src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>
<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

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
	href="${context}/resources/project_css/viewConsignment.css">
<link rel="stylesheet"
	href="${context}/resources/assets/css/iconStates.css">


<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>

<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>


	
<style type="text/css">
/* .dataTables_scrollBody {
    height: 100px !important;
} */
.dataTables_scrollBody {
    width: 100%;
    max-height: 400px !important;

   height: auto !important;


}
.dataTables_scroll {
    margin-top: 2px;
}
button.modal-action.modal-close.waves-effect.waves-green.btn-flat.right {
   height: 36px;
	 font-size: 31px
}
</style>
</head>
<body data-id="4" data-roleType="${usertype}" data-userID="${userid}"
	data-userTypeID="${usertypeId}" 
	data-selectedRoleTypeId="${selectedRoleTypeId}"
	data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}"
	data-Source="${source}" data-filterSource="${filterSource}"
	data-period="${period}" data-username="${username}">


	<!-- START CONTENT -->
	<section id="content">
		<div id="initialloader"></div>
		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel" id="verifyType">
							<div class="container-fluid pageHeader" id="pageHeader">

								<a href="" class="boton right" id="btnLink"></a>
							</div>
                    <form action="${context}/viewConsignment" id="viewStockFilter"
								method="post">
							<div class="registrationTableDiv_box" id="consignmentTableDIv"
								style="padding-bottom: 5px; background-color: #e2edef52;">
								<div id="filterBtnDiv"></div>
							</div>
                   </form>
							<table id="stockTable" class="responsive-table striped display"></table>

						</div>

					</div>
				</div>
				<div id="footerBtn"></div>
			</div>
		</div>
		<!--end container-->
	</section>







	<!-- Modal 1 start   -->



	<div id="successUpdateStockModal" class="modal">
		<h6 class="modal-header" style="font-size: 16px;">
			<spring:message code="modal.header.updateStock" />
		</h6>
		<div class="modal-content">



			<div class="row">
				<p id="stockSucessMessage"></p>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a href="" class="btn"><spring:message code="modal.ok" /></a>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal End -->

	<div id="editStockModal" class="modal">
	<div class="header-fixed header-fixed-style" data-original-title="" title="">
	
		<h6 class="modal-header">
			<spring:message code="modal.header.editStock" />
		</h6></div>
		<div class="scrollDivHeight" data-original-title="" title=""></div>
		<div class="modal-content">


			<form action="" onsubmit="return editUploadStock()" method="POST"
				enctype="multipart/form-data" style="margin-top: 10px;">
				<div class="row myRow">
					<div class="input-field col s12 m6" id="editSupplierIdDiv">
						<input type="text" name="SupplierId" id="editSupplierId"
							placeholder="" pattern="<spring:eval expression="@environment.getProperty('pattern.supplierID')" />"
					oninput="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
					oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
							/> <label for="editSupplierId"
							id="editSupplierIdLabel" class="center-align"><spring:message
								code="input.supplierID" /></label>
					</div>

					<div class="input-field col s12 m6" id="editSupplierNameDiv">
						<input type="text" name="SupplierName" id="editSupplierName"
							placeholder="" pattern="<spring:eval expression="@environment.getProperty('pattern.supplierName')" />"
							oninput="InvalidMsg(this,'input','<spring:message code="validation.50character" />');"
							oninvalid="InvalidMsg(this,'input','<spring:message code="validation.50character" />');"
							> <label for="editSupplierName"
							id="editSupplierNameLabel" class="center-align"><spring:message
								code="input.supllierName" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" name="Quantity" id="editQuantity"
							placeholder=""pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
							oninput="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
							oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7digits" />');"
							required> <label for="Quantity" class="center-align"><spring:message
								code="input.quantity" /> <span class="star">*</span></label>
					</div>

					<div class="input-field col s12 m6" id="editInvoiceNumberDiv">
						<input type="text" name="InvoiceNumber" id="editInvoiceNumber"
							placeholder="" pattern="<spring:eval expression="@environment.getProperty('pattern.supplierID')" />"
							oninput="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
							oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15character" />');"
							 /> <label for="InvoiceNumber" class="center-align"><spring:message
								code="input.invoiceNumber" /></label>
					</div>
                        <div class="input-field col s12 m6">
											<input type="text" name="devicequantity" id="editdevicequantity"
												pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
												 oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"
												 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"  required/> 
												 <label for="editdevicequantity"
												class="center-align"><spring:message code="input.devicequantity" /> <span class="star">*</span></label>
										</div>
					<div class="input-field col s12 m6" style="margin-top: 22px;">
						<input type="text" name="TransactionId" id="editTransactionId"
							placeholder="" disabled maxlength="15" /> <label
							for="TransactionId" class="center-align"><spring:message
								code="input.transactionID" /></label>
					</div>

					<div class="file-field col s12 m6">
						<p class="upload-file-label" style="margin-bottom: 0;">
							<spring:message code="modal.header.uploadBlockStock" />
							<span class="star">*</span>
						</p>
						<div class="btn">
							<span><spring:message code="input.selectfile" /></span> <input
								type="file" onchange="fileTypeValueChanges()"
								id="editcsvUploadFile" accept=".csv"
								oninput="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');"
								oninvalid="InvalidMsg(this,'fileType','<spring:message code="validation.NoChosen" />');">
						</div>
						<div class="file-path-wrapper">
							<input class="file-path validate responsive-file-div"
								id="editcsvUploadFileName" type="text">
						</div>
						<input type="text" id="existingFileName" style="display: none;">
					</div>
				</div>


				<div class="row myRow">
					<p style="margin-left: 10px;">
						<a href="./Consignment/sampleFileDownload/4"><spring:message
								code="input.downlaod.sample" /></a>
					</p>
					<p style="margin-left: 10px;">
						<spring:message code="input.requiredfields" />
						<span class="star">*</span>
					</p>
				</div>




				<div class="row">
					<div class="input-field col s12 center">
						<button class="btn" type="submit">
							<spring:message code="button.update" />
						</button>
						<a onclick="closeEditModal();" class="btn" type="cancel"
							style="margin-left: 10px;"><spring:message
								code="modal.cancel" /></a>


					</div>
				</div>
			</form>
		</div>
	</div>


	<!-- View Stock Modal start   -->

	<div id="viewStockModal" class="modal">
	<div class="header-fixed header-fixed-style" data-original-title="" title="">
		<h6 class="modal-header">
			<spring:message code="modal.header.viewStock" />
		</h6>
		</div>
		<div class="scrollDivHeight" data-original-title="" title=""></div>
		<div class="modal-content">


			<form action="" style="margin-top: 10px;">

				<div class="row myRow">
					<div class="input-field col s12 m6" id="supplierIdDiv">
						<input type="text" name="SupplierId" id="SupplierId"
							placeholder="" disabled /> <label for="SupplierId"
							id="SupplierIdLabel" class="center-align"><spring:message
								code="input.supplierID" /></label>
					</div>

					<div class="input-field col s12 m6" id="supplierNameDiv">
						<input type="text" name="SupplierName" id="SupplierName"
							placeholder="" disabled /> <label for="SupplierName"
							id="SupplierNameLabel" class="center-align"><spring:message
								code="input.supllierName" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" name="Quantity" id="Quantity" placeholder=""
							disabled /> <label for="Quantity" class="center-align"><spring:message
								code="input.quantity" /></label>
					</div>
						
					<div class="input-field col s12 m6">
											<input type="text" name="devicequantity" id="viewdevicequantity"
												pattern="[0-9]{0,7}"
												disabled
												maxlength="7"  oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"
												 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"  required/> <label for="viewdevicequantity"
												class="center-align"><spring:message code="input.devicequantity" /> <span class="star"></span></label>
										</div>
					<div class="input-field col s12 m6" id="invoiceNumberDiv">
						<input type="text" name="InvoiceNumber" id="InvoiceNumber"
							placeholder="" disabled /> <label for="InvoiceNumber"
							class="center-align"><spring:message
								code="input.invoiceNumber" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" name="TransactionId" id="TransactionId"
							disabled placeholder="" maxlength="15" /> <label
							for="TransactionId" class="center-align"><spring:message
								code="input.transactionID" /></label>
					</div>

					<div class="input-field col s12 m6">
						<label><spring:message
								code="modal.header.uploadBlockStock" /></label> <input placeholder=""
							id="csvUploadFileName" type="text" disabled>
					</div>
					<div class="input-field col s12 m6">
						<textarea id="withdrawnRemark" class="materialize-textarea"
							style="height: 0px;" readonly="readonly" placeholder=""></textarea>
						<label for="remark" class=""><spring:message
								code="input.remarks" /></label>

						<!--   <input type="textarea" name="Remark" placeholder="Remark" id="remark" readonly="readonly" maxlength="15" />
                                               <label for="TransactionId" class="center-align">Remark</label> -->
					</div>
				</div>

				<div class="row center" style="margin-top: 20px;">

					<a onclick="closeViewModal()" class="btn" type="cancel"><spring:message
							code="modal.close" /></a>
				</div>
			</form>
		</div>
	</div>

	<!-- --------------------------------------------------------------View Stock Modal End --------------------------------------------------------------->


	<!-- --------------------------------------------------------------Delete Stock Modal End --------------------------------------------------------------->


	<div id="DeleteStockconfirmationModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.deleteStock" />
		</h6>
		<div class="modal-content">


			<form action="" onsubmit="return confirmantiondelete()" method="POST">

				<div class="row">
					<h6>
						<spring:message code="modal.message.stock.widthdraw" />
						<span id="stockdeleteTxnId"></span>
					</h6>
				</div>
				<div class="row">
					<div class="input-field col s12 m12">
						<textarea id="deleteStockremark"
							oninput="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
							oninvalid="InvalidMsg(this,'input','<spring:message code="validation.200character" />');"
							maxlength="200" class="materialize-textarea" required></textarea>
						<label for="textarea1" class=""><spring:message
								code="input.remarks" /> <span class="star">*</span></label>
					</div>
				</div>
				<input type="text" id="popupTransactionId" maxlength="15" hidden />
				<div class="row">
					<div class="input-field col s12 center">
						<button class=" btn" type="submit">
							<spring:message code="modal.yes" />
						</button>
						<button class="modal-close btn" type="reset"
							style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="closeDeleteModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.deleteStock" />
		</h6>
		<div class="modal-content">


			<div class="row">

				<h6 id="stockModalText">
					<spring:message code="modal.message.stockDeleted" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a href="" class="modal-close btn" style="margin-left: 10px;"><spring:message
							code="modal.ok" /></a>
				</div>
			</div>
		</div>
	</div>

	<div id="markAsMultipleStolen" class="modal">
		<h6 class="modal-header">
			<spring:message code="button.markAsStolen" />
		</h6>
		<div class="modal-content">




			<div class="row">
				<h6>
					<spring:message code="modal.message.txnmarked" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a onclick="openMulipleStolenPopUp()"
						class="modal-close modal-trigger btn"><spring:message
							code="modal.yes" /></a>
					<button class="modal-close btn" style="margin-left: 10px;">
						<spring:message code="modal.no" />
					</button>
				</div>
			</div>
		</div>
	</div>
	<div id="markAsStolenDone" class="modal">
		<h6 class="modal-header">
			<spring:message code="button.markAsStolen" />
		</h6>
		<div class="modal-content">


			<div class="row">
				<h6>
					<spring:message code="modal.message.markedasstolen" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<!-- <button class="modal-close btn" style="margin-left: 10px;">ok</button> -->
					<a onclick="redirectToViewPage()" class="btn"><spring:message
							code="modal.close" /></a>
				</div>
			</div>
		</div>
	</div>
	<div id="ApproveStock" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.approveStock" />
		</h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="stockApproveMessage">
					<spring:message code="modal.message.stock.txnID" />
					<span id="approveStockTxnId"> </span>
					<spring:message code="modal.message.hasBeenpaid" />
				</h6>
				<input type="text" id="approveStockTransactionId"
					style="display: none;">
			</div>
			<div class="row">
				<h6 id="stockAppapprove">
					<spring:message code="modal.message.do.approveStock" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class=" modal-close modal-trigger btn"
							onclick="approveStockSubmit(0)">
							<spring:message code="modal.yes" />
						</button>
						<button class="modal-close btn" style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="confirmApproveStockModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.approveStock" />
		</h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="stockApproveSucessMessage">
					<spring:message code="modal.message.stockUpload" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="./assignDistributor" class="modal-close btn"><spring:message
								code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="RejectStockModal" class="modal">
	 <div class="header-fixed header-fixed-style">
		<h6 class="modal-header">
			<spring:message code="modal.header.rejectStock" />
		</h6></div>
		<div class="scrollDivHeight"></div>
		<form onsubmit="return disApproveStockSubmit(1)" method="POST" >
		<div class="modal-content">

			<div class="row">
				<h6>
					<spring:message code="modal.message.stock.txnID" />
					<span id="disaproveTxnId"> </span>
					<spring:message code="modal.message.asRejected" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 m12" style="margin-left: -10px;">
					<textarea id="stockDispproveRemarks" class="materialize-textarea" required="required" style="min-height: 8rem;"
						style="padding-left: 0;"></textarea>
					<label for="textarea1"><spring:message code="input.remarks" /><span class="star">*</span></label>
				</div>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" type="submit">
							<spring:message code="modal.yes" />
						</button>
						<button class="modal-close btn" type="reset" style="margin-left: 10px;" >
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</div>
		</div>
		</form>
	</div>
	<div id="confirmRejectStock" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.rejectStock" />
		</h6>
		<div class="modal-content">

			<div class="row">
				<h6 id="stockDisapproveSucessMessage">
					<spring:message code="modal.message.stockRejected" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="./assignDistributor" class="modal-close btn"><spring:message
								code="modal.close" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div id="fileFormateModal" class="modal">
		<h6 class="modal-header">
			<spring:message code="fileValidationModalHeader" />
		</h6>
		<div class="modal-content">
			<div class="row">
				<h6 id="fileErrormessage">
					<spring:message code="fileValidationName" />
					<br> <br>
					<spring:message code="fileValidationFormate" />
					<br>
					<br>
					<spring:message code="fileValidationSize" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close waves-effect waves-light btn"
							onclick="clearFileName()" style="margin-left: 10px;">
							<spring:message code="modal.ok" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End -->
	<!-- END MAIN -->
<div id="tableOnModal" class="modal">
		<div class="header-fixed header-fixed-style">
		<button type="button"
			class=" modal-action modal-close waves-effect waves-green btn-flat right"
			data-dismiss="modal">&times;</button>
		<h6 class="modal-header"><spring:message code="modal.header.viewHistory" /></h6>
		</div>
		<div class="scrollDivHeight"></div>
		<div class="modal-content modal-content-style">

			<div class="row">
				<table class="responsive-table striped display"
					id="data-table-history" cellspacing="0">
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js">"></script>


	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>



	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
		<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>

	<!--custom-script.js - Add your own theme custom JS-->

	<!--prism
    
	<!--scrollbar-->
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
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/viewStock.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="" async></script>
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