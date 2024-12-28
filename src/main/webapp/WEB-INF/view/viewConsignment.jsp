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
<!--<title>Consignment</title>-->
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


<link rel="icon" href="${context}/resources/images/DMC-Logo.png" sizes="32x32">
<!-- CORE CSS-->
<link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection">


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

.header-fixed-style{
width: inherit;
 z-index: 1003; 
 position: fixed;
}
</style>
</head>
<body data-id="3"
	data-roleType="${usertype}" data-userTypeID="${usertypeId}"
	data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}"
	data-selected-consignmentTxnId="${consignmentTxnId}"
	data-selected-consignmentStatus="${consignmentStatus}"
	session-value="en"
	session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}" 
	data-username="${username}"
	data-session-source="${not empty param.source ? param.source : 'menu'}">

	<%-- session-value="${not empty param.NID ? param.NID : 'null'}" --%>

	<!-- START CONTENT -->
	<!-- START CONTENT -->
	<section id="content">
		<div id="initialloader"></div>

		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div class="container-fluid pageHeader" id="pageHeader">

								<a href="" class="boton right" id="btnLink"></a>
							</div>
							<form action="${context}/viewConsignment" id="viewFilter"
								method="post">
								<div class="registrationTableDiv_box" id="consignmentTableDIv"
									style="padding-bottom: 5px; background-color: #e2edef52;">
									<div id="filterBtnDiv"></div>
								</div>
							</form>
							<table id="consignmentLibraryTable"
								class="responsive-table striped display"></table>

						</div>

					</div>
				</div>
				<div id="footerBtn"></div>
			</div>
		</div>
		<!--end container-->
	</section>

	<!--viewModal Modal start   -->

	<div id="viewModal" class="modal-form" >
		   
		<div class="header-fixed header-fixed-style">
			<h6 class="modal-header">
			<spring:message code="modal.header.viewConsignment" />
		</h6>
		</div>

		<div class="scrollDivHeight"></div>

		<div class="modal-content modal-content-style">
		
			<div class="row myRow">
				<div class="input-field col s12 m6">
					<input type="text" name="name" id="supplierId" placeholder=""
						readonly="readonly" /> <label for="Name" class="center-align"><spring:message
							code="input.supplier" /></label>
				</div>

				<div class="input-field col s12 m6">
					<input type="text" name="name" id="supplierName" placeholder=""
						readonly="readonly" /> <label for="Name" class="center-align"><spring:message
							code="input.suppliername" /></label>
				</div>
				<div class="input-field col s12 m6">
					<input type="text" name="name" id="consignmentNumber"
						placeholder="" readonly="readonly" /> <label for="Name"
						class="center-align"><spring:message
							code="input.consignmentnumber" /></label>
				</div>
				<div class="input-field col s12 m6">
					<!-- <p class="input-text-date" style="color: #c4c4c4;">Expected
						Dispatch Date</p> -->
					<input type="text" id="expectedDispatcheDate" placeholder=""
						readonly="readonly" placeholder=""> <label
						for="expectedDispatcheDate"><spring:message
							code="input.dispatchdate" /></label> <span class="input-group-addon"
						style="color: #ff4081"><i class="fa fa-calendar"
						aria-hidden="true"></i></span>
				</div>

				<div class="input-field col s12 m6">
					<input type="text" id="countryview" class="browser-default"
						readonly="readonly" class="mySelect" placeholder=""> <label
						for="Name" class="center-align"><spring:message
							code="input.country" /></label> <label for="countryview"
						class="center-align"></label>
				</div>

				<div class="input-field col s12 m6" style="color: #c4c4c4;">
					<!-- <p style="margin-top: -5px; margin-bottom: -13px; font-size: 12px;">Expected
						Arival Date</p> -->
					<input type="text" id="expectedArrivaldate" placeholder=""
						readonly="readonly" placeholder=""> <label
						for="expectedArrivaldate" class="center-align"><spring:message
							code="input.arrivaldate" /></label> <span class="input-group-addon"
						style="color: #ff4081"><i class="fa fa-calendar"
						aria-hidden="true"></i></span>
				</div>

				<div class="input-field col s12 m6">
					<!-- <label for="Name" class="center-align">Expected arrival port</label> -->
					<input type="text" id="expectedArrivalPort" readonly="readonly"
						placeholder=""> <label for="expectedArrivalPort"
						class="center-align"><spring:message
							code="input.arrivalport" /></label>
				</div>
				
				
				
				<div class="col s12 m6">
				<label><spring:message code="registration.portAddress" /> <span class="star"></span></label>
					<input type="text" id="portAddress" readonly="readonly" placeholder="" style="height: 2.1em;">
								</div>	
								

				<div class="input-field col s12 m6">
					<input type="text" name="Quantity" placeholder="" id="Quantity"
						readonly="readonly" /> <label for="Quantity" class="center-align"><spring:message
							code="input.quantity" /></label>
				</div>

				<div class="input-field col s12 m6">
					<input type="text" name="TransactionId" placeholder=""
						id="TransactionId" readonly="readonly" maxlength="15" /> <label
						for="TransactionId" class="center-align"><spring:message
							code="input.transactionID" /></label>
				</div>


<div class="input-field col s12 m6">
					<input type="text" name="deviceQuantity" placeholder=""
						disabled="disabled" id="deviceQuantity" maxlength="7" />
					<label for="deviceQuantity" class="center-align"><spring:message
							code="input.deviceQty" /></label>
				</div>
				

<div class="input-field col s12 m6">
					<textarea id="remark" class="materialize-textarea"
						style="height: 0px;" readonly="readonly" placeholder=""></textarea>
					<label for="remark" class=""><spring:message
							code="input.remarks" /></label>

					<!--   <input type="textarea" name="Remark" placeholder="Remark" id="remark" readonly="readonly" maxlength="15" />
                                               <label for="TransactionId" class="center-align">Remark</label> -->
				</div>
				
				
				<div class="input-field col s12 m6">
					<input type="text" name="totalPrice" placeholder=""
						disabled="disabled" id="viewtotalPrice" maxlength="12" />
					<label for="totalPrice" class="center-align"><spring:message
							code="input.totalprice" /></label>
				</div>

			
				
					<div class="col s12 m6" id="viewCurrencyDiv">
					<label for="Currency"><spring:message code="input.currency" /></label>
					<input type="text" name="viewcurrency" placeholder=""
						disabled="disabled" id="viewcurrency" maxlength="7" style="height:4.3vh;"/>
					
					<!-- <input type="text" id="viewcurrency" placeholder="" disabled="disabled"> -->
					<input type="text" id="viewhideCurrency" style="display: none;">
				</div>
			</div>

			<div class="row button-div">
				<div class="input-field col s12 center">
					<button class="btn" onclick="closeViewModal()"
						class="modal-close btn" id="add_user">
						<spring:message code="modal.close" />
					</button>
				</div>
			</div>


		</div>
	</div>
	<!-- Modal End -->


<!--Delete Modal start   -->

	<div id="DeleteConsignment" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.deleteConsignment" />
		</h6>
		<form action="" id="deleteFormID" onsubmit=" return confirmantiondelete()" method="POST">
		<div class="modal-content">
		
				<h6>
					<spring:message code="modal.withdraw.message" />
					(<span id="transID"></span>)
				</h6>
			</div>

			<div class="row">
				<div class="input-field col s12 m12">
					<textarea id="textarea1" required="required" maxlength="200"  class="materialize-textarea"></textarea>
					<label for="textarea1"><spring:message code="input.remarks" /><span class="star">*</span></label>
				</div>
			</div>
			<input type="text" id="popupTransactionId" maxlength="15" hidden />
			<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" type="submit"><spring:message
								code="modal.yes" /></button>
						<button class="modal-close btn" type="reset"
							onclick="closeUpdateModal()" style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
		
			</div>
		</form>
		</div>
		
	</div>
	<!-- Modal End -->
	<!-- END CONTENT -->




	<!-- Modal 1 start   -->

	<div id="updateConsignment" class="modal">
		
		   <div class="header-fixed" style="width:inherit;z-index:1003;position: fixed;">
		<h6 class="modal-header">
			<spring:message code="modal.header.viewConsignment" />
		</h6>
		</div>
		
		 <div style="height: 50px;">
</div>
		
		<div class="modal-content">



			<div class="row">
				<h6 id="sucessMessage">
					<spring:message code="modal.message.update" />
				</h6>
			</div>
			<div class="row button-div">
				<div class="input-field col s12 center">
					<a href="${context}/viewConsignment" class="btn"><spring:message
							code="modal.ok" /></a>
				</div>
			</div>
		</div>
	</div>





	<!-- Delete confirmation Modal start   -->

	<div id="confirmDeleteConsignment" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.deleteConsignment" />
		</h6>
		<div class="modal-content">



			<!-- <h4 class="header2 pb-2">User Info</h4> -->

			<div class="row">
				<h6 id=consignmentText>
					<%-- <spring:message code="modal.message.consignmentDelete" /> --%>
				</h6>
			</div>

			<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="${context}/viewConsignment" class="btn"><spring:message
								code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- -----------------------------------------------------------------Approved Model------------------------------------------------------------------------------ -->


	<div id="ApproveConsignment" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.message.approveConsignment" />
		</h6>
		<div class="modal-content">


						<div class="row">
				<h6 id="approveConsignmnetHeading">
					<spring:message code="modal.message.clearConsignment" />
					<span id="displayname"></span>
				<%-- 	<spring:message code="modal.message.havingTxn" /> --%>
					( <span id="ApproveConsignmentTxnid"></span> )
					<spring:message code="modal.message.hasBeenpaid" />
				</h6>
				<div class="row">
					<h6>
						<spring:message code="modal.message.doApprove" />
					</h6>
					<form action=""  >
          <p id="tacSatusForCustom" style="display: none">
            <label>
              <input type="checkbox" id="tacStatusChecKbox" >
              <span id="tacStatucMessage"></span>
            </label>
          </p>
        </form>
				</div>
</div>
			<div class="row">
				<%-- <h6 id="confirmationMessage">
					<spring:message code="modal.message.clearConsignment" />
				</h6> --%>
				<input type="text" id="setApproveConsignmentTxnId"
					style="display: none">
			</div>
						<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close modal-trigger btn" id="approveButton" disabled="disabled"
							onclick="approveSubmit(0)">
							<spring:message code="modal.yes" />
						</button>
						<button class="modal-close btn"   style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</div>

		</div>
	</div>

	<div id="confirmApproveConsignment" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.message.approveConsignment" />
		</h6>
		<div class="modal-content">


			<div class="row">
				<h6 id="approveSuccessMessage">
					<spring:message code="modal.message.approved" />
				</h6>
			</div>
			<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="${context}/viewConsignment"
							class="modal-close btn"><spring:message code="modal.close" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div id="RejectConsignment" class="modal">
	  <div class="header-fixed header-fixed-style">
		<h6 class="modal-header">
			<spring:message code="modal.header.rejectConsignment" />
		</h6>
		</div>
		<div class="scrollDivHeight"></div>
		<div class="modal-content">

<form action="" onsubmit=" return disapproveSubmit(1)" method="POST">
			<div class="row">
				<h6>
					<spring:message code="modal.message.markConsignment" />
					<span id="disapprovedDisplayname"></span>
					<spring:message code="modal.message.havingTxn" />
					<span id="disaproveTxnId"></span>
					<spring:message code="modal.message.asRejected" />
				</h6>
				<input type="text" id="setDisapproveConsignmentTxnId"
					style="display: none">
			</div>
			<div class="row">
				<div class="input-field col s12 m12" style="margin-left: -10px;">
					<textarea id="dispproveRemarks" class="materialize-textarea" required="required"
					style="min-height: 8rem;" style="padding-left: 0;"></textarea>
					<label for="textarea1"><spring:message code="input.remarks" />
						<span class="star">*</span></label>
				</div>
				<p>
					<spring:message code="input.requiredfields" />
					<span class="star">*</span>
				</p>
			</div>
			<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" type="submit">
							<spring:message code="modal.yes" />
						</button>
						<button class="modal-close btn" type="reset" style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>





	<%-- <div id="ApproveConsignment" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.message.approveConsignment" />
		</h6>
		<div class="modal-content">


			<div class="row">
				<h6>
					<spring:message code="modal.message.taxAgainst" />
					( <span id="ApproveConsignmentTxnid"></span> )
					<spring:message code="modal.message.hasBeenpaid" />
				</h6>
			</div>
			<div class="row">
				<h6>
					<spring:message code="modal.message.doApprove" />
				</h6>
				<input type="text" id="setApproveConsignmentTxnId"
					style="display: none">
			</div>
			<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close modal-trigger btn"
							onclick="approveSubmit(0)">
							<spring:message code="modal.yes" />
						</button>
						<button class="modal-close btn" style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div> --%>

	<div id="confirmApproveConsignment" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.message.approveConsignment" />
		</h6>
		<div class="modal-content">


			<div class="row">
				<h6 id="approveSuccessMessage">
					<spring:message code="modal.message.approved" />
				</h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="${context}/viewConsignment"
							class="modal-close btn"><spring:message code="modal.close" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<%-- <div id="RejectConsignment" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.rejectConsignment" />
		</h6>
		<div class="modal-content">


			<div class="row">
				<h6>
					<spring:message code="modal.message.haveTxn" />
					<span id="disaproveTxnId"></span>
					<spring:message code="modal.message.asRejected" />
					.
				</h6>
				<input type="text" id="setDisapproveConsignmentTxnId"
					style="display: none">
			</div>
			<div class="row">
				<div class="input-field col s12 m12" style="margin-left: -10px;">
					<textarea id="dispproveRemarks" class="materialize-textarea"
						style="padding-left: 0;"></textarea>
					<label for="textarea1"><spring:message code="input.remarks" />
						<span class="star">*</span></label>
				</div>
				<p>
					<spring:message code="input.requiredfields" />
					<span class="star">*</span>
				</p>
			</div>
			<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close modal-trigger btn"
							onclick="disapproveSubmit(1)">
							<spring:message code="modal.yes" />
						</button>
						<button class="modal-close btn" style="margin-left: 10px;">
							<spring:message code="modal.no" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div> --%>


	<div id="confirmRejectConsignment" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.header.rejectConsignment" />
		</h6>
		<div class="modal-content">


			<div class="row">
				<h6 id="disapproveSuccessMessage">
					<spring:message code="modal.message.rejected" />
				</h6>
			</div>
			<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<a href="${context}/viewConsignment"
							class="modal-close btn"><spring:message code="modal.ok" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Update Modal Start -->
		<div id="updateModal" class="modal-form">
		
		<div class="header-fixed header-fixed-style">
				<h6 class="modal-header">
			<spring:message code="modal.header.editConsignment" />
		</h6>
		</div>

		<div class="scrollDivHeight"></div>

		<div class="modal-content modal-content-style">

		
		
			<form action="" onsubmit="return editRegisterConsignment()"
				method="POST" enctype="multipart/form-data">
				<div class="row myRow" style="margin-top: 5px;" >
					<div class="input-field col s12 m6">
						<input type="text" name="supplierId" id="supplierIdEdit"
						pattern="<spring:eval expression="@environment.getProperty('pattern.supplierID')" />"
							placeholder=""  /> <label for="Name"
							class="center-align"><spring:message
								code="input.supplier" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" name="supplierName" id="supplierNameEdit"
							placeholder="" pattern="<spring:eval expression="@environment.getProperty('pattern.supplierName')" />"
							oninput="InvalidMsg(this,'input','<spring:message code="validation.15alphanumeric" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.15alphanumeric" />');"
							 required /> <label for="Name"
							class="center-align"><spring:message
								code="input.suppliername" /><span class="star">*</span> </label>
					</div>
					<div class="input-field col s12 m6">
						<input type="text" name="consignmentNumber"
							id="consignmentNumberEdit" 
							pattern="<spring:eval expression="@environment.getProperty('pattern.consignmentNumber')" />"
							placeholder=""  /> <label for="Name"
							class="center-align"><spring:message
								code="input.consignmentnumber" /></label>
					</div>

					<div class="input-field col s12 m6">

						<input name="expectedDispatcheDateEdit" id="expectedDispatcheDateEdit"
							placeholder="" type="text" class='form-control datepick'
							autocomplete='off'
							onchange="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');checkDateOnModal(expectedDispatcheDateEdit,expectedArrivaldateEdit);" oninvalid="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');"
							 required />
						<label for="dispatchDate" class="center-align"><spring:message
								code="input.dispatchdate" /><span class="star">*</span> </label>
								<p id="errorMsgOnModal" class="onEditModalTitle"></p>
								 <span
							class="input-group-addon" style="color: #ff4081"><i
							class="fa fa-calendar" aria-hidden="true"></i></span>
					</div>
					<div class="input-field col s12 m6">
						<p style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;"><spring:message code="input.country" /> <span class="star">*</span></p>
						<select id="country" name="organisationcountry"
							class="browser-default" class="mySelect"
							onchange="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');"
							required></select> <label for="country" class="center-align"></label>
					</div>


					<div class="input-field col s12 m6">
						<!-- <p class="input-text-date">Expected Dispatch Date <span class="star">*</span></p> -->
						<!-- <label for="Name">Expected arrival Date</label> -->
						<input name="expectedArrivaldateEdit" id="expectedArrivaldateEdit"
							placeholder="" type="text" class='form-control datepick'
							autocomplete='off' onchange="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');checkDateOnModal(expectedDispatcheDateEdit,expectedArrivaldateEdit);" oninvalid="InvalidMsg(this,'date','<spring:message code="validation.requiredMsg" />');"
							 required />
						<label for="dispatchDate" class="center-align"><spring:message
								code="input.arrivaldate" /><span class="star">*</span> </label> <span
							class="input-group-addon" style="color: #ff4081"><i
							class="fa fa-calendar" aria-hidden="true"></i></span>
					</div>
					<div class="input-field col s12 m6">
					<p style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;">	<spring:message code="input.arrivalport" /> <span class="star">*</span></p>
					<%-- <label for="expectedArrivalPort"><spring:message code="input.arrivalport" /> <span class="star">*</span></label> --%>
				
						<select name="expectedArrivalPort" id="expectedArrivalPortEdit"
							class="browser-default" onchange="getByPort(this.value)">
							<option value="" disabled selected><spring:message
									code="input.arrivalport" />*
							</option>

						</select>
					</div>
					
					
						
						<div class="input-field col s12 m6">
									<label style="margin-top: -15px; margin-bottom: -3px; font-size: 12px;"><spring:message code="registration.portAddress" /> <span class="star">*</span></label>
									<select id="editPortAddress" class="browser-default"  
									oninput="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" oninvalid="InvalidMsg(this,'select','<spring:message code="validation.selectFieldMsg" />');" required>
										<option value="" disabled selected><spring:message code="selectport" /></option>
											</select>
								</div>	
								
								
					
					
					

					<div class="input-field col s12 m6">
						<input type="text" name="quantity" id="QuantityEdit"
							pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
							 placeholder=""  oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');" 
							required /> <label for="Quantity" class="center-align" style="margin-top: 5px;"><spring:message
								code="input.quantity" /><span class="star">*</span></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" name="txnId" id="TransactionIdEdit"
							placeholder="Transaction ID" value="" readonly maxlength="15" />
						<label for="TransactionId" class="center-align" style="margin-top: 5px;"><spring:message
								code="input.transactionID" /></label>
					</div>




							
										<div class="input-field col s12 m6">
											<input type="text" name="editDeviceQuantity" id="editDeviceQuantity"
												pattern="<spring:eval expression="@environment.getProperty('pattern.IMEI/DeviceQuantity')" />"
												  oninput="InvalidMsg(this,'input','<spring:message code="validation.7character" />');" oninvalid="InvalidMsg(this,'input','<spring:message code="validation.7character" />');"  required/> 
												<label for="editDeviceQuantity" class="center-align" style="margin-top: 5px;"><spring:message code="input.deviceQty" /> <span class="star">*</span></label>
										</div>
										
										
										
										
										
             <div class="file-field input-field col s12 m6"
						style="margin-top: 5px;">
						<h6 class="file-upload-heading" style="margin-top: -5px;">
							<spring:message code="input.bulkdevice" />
							<span class="star">*</span>
						</h6>
						<div class="btn">
							<span><spring:message code="input.selectfile" /></span> <input
								type="file" name="file" id="csvUploadFile" accept=".csv" onchange="isFileValid('csvUploadFile')"
								>
						</div>
						<div class="file-path-wrapper">
							<input class="file-path validate responsive-file-div"
								id="fileNameEdit" type="text">
						</div>
					</div>



				
				
					<div class="input-field col s12 m6">
						<input type="text" name="totalPrice" id="totalPrice" 
							pattern="^\d+(?:\.\d{1,2})?$" maxlength="9"
							placeholder=""  oninput="InvalidMsg(this,'input','<spring:message code="validation.12Char" />');"
					 oninvalid="InvalidMsg(this,'input','<spring:message code="validation.12Char" />');"/> <label for="totalPrice" class="center-align"><spring:message
								code="input.totalprice" /></label>
					</div>
					
						
					<div class="col s12 m6" id="currencyDiv">
						<input type="text" id="fileNameToBeSame" style="display: none;">
						<label for="Currency"><spring:message
								code="input.currency" /></label> <select id="currency"
							class="browser-default" style="height: 4.6vh;">
							<option value="" disabled selected><spring:message
									code="input.currency" /></option>

						</select> <input type="text" id="hideCurrency" style="display: none;">
					</div>
					
				
				
				</div>




				<div class="row" style="padding-bottom: 15px">
					<div class="col s12 m12">
						<a href="./Consignment/sampleFileDownload/3"><spring:message
								code="input.downlaod.sample" /></a></br> <span> <spring:message
								code="input.requiredfields" /> <span class="star">*</span>
						</span>
					</div>
					<div class="input-field col s12 center">
						<button class=" btn" type="submit">
							<spring:message code="button.update" />
						</button>
						<button class="modal-close btn" type="button"
							onclick="closeUpdateModal()" style="margin-left: 10px;">
							<spring:message code="button.cancel" />
						</button>
					</div>
				</div>
			</form>
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
			<div class="row button-div">
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
			<div class="row button-div">
				<div class="input-field col s12 center">
					<!-- <button class="modal-close btn" style="margin-left: 10px;">ok</button> -->
					<a onclick="redirectToViewPage()" class="btn"><spring:message
							code="modal.close" /></a>
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
	
	<!-- -----------------------------------------------------------------Approve DRT Consignment------------------------------------------------------------------------------ -->


	<div id="PayDRTtaxPopup" class="modal">
		<h6 class="modal-header">
			<spring:message code="modal.message.taxConsignmentDRT" />
		</h6>
			<form action="" onsubmit="return payTaxDRT()" method="post" >
		<div class="modal-content">
		<div class="row">
				<div class="row">
					<h6>
						<spring:message code="modal.message.taxPaidMessage" />
					</h6>
				</div>
		</div>
			<div class="row">
			<div class="input-field col s12 m6">
                       <input type="number" id="amount" name=""  pattern="[0-9]{8,8}" title="Please enter numeric numbers"  maxlength="" required="required">
                        <label for="amount" class=""><spring:message code="modal.Amount" /><span class="star"> *</span></label> 
                        	<%-- <input type="text" id="amount" name="amount" 
								pattern="[0-9]{8,8}" maxlength="8"
								oninput="InvalidMsg(this,'input','<spring:message code="validation.tac8" />');"
								oninvalid="InvalidMsg(this,'input','<spring:message code="validation.tac8" />');"
								required> <label for="amount"><spring:message
								code="modal.Amount" /> <span class="star">*</span></label> --%>
						                        
            </div>
			</div>
				<div class="row button-div">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="btn" type="submit"><spring:message code="modal.payNow" /></button>
                        <a href="#" class="btn modal-close" id="Cancel" style="margin-left: 10px;"><spring:message code="modal.paylater" /></a>
					</div>
				</div>
			</div>

		</div>
		</form>
	</div>


	<!-- Modal start   -->

	<div id="tableOnModal" class="modal">
		
		
				<div class="header-fixed header-fixed-style">
				<button type="button"
			class=" modal-action modal-close waves-effect waves-green btn-flat right"
			data-dismiss="modal">&times;</button>
			<h6 class="modal-header">
			<spring:message code="modal.header.viewHistory" />
		</h6>
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
	<!-- Modal End -->
	<!--materialize js-->
	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>



	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
	<script
		src="${context}/resources/custom_js/bootstrap.min.js"></script>

	<!--custom-script.js - Add your own theme custom JS-->



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
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>

	<%-- 		<script type="text/javascript"
		src="${context}/resources/project_js/disable_inspectElement.js"></script> --%>
	<script type="text/javascript"
		src="${context}/resources/project_js/viewConsignment.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
		<script type="text/javascript"
		src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="" async></script>
<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>
      
<script type="text/javascript">var countHit="";  $( document ).ready(function() {   if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
$("body").click(function(e) {
	$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});
	$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {
		currentTime = data; 
	countHit=0;
	console.log("session");
 
	 }
	 ,error: function (jqXHR, textStatus, errorThrown) {
	console.log("in erro function")	 
	 }});
	 
	if( currentTime > timeoutTime )
	{
		console.log("in time out function")	 
		document.addEventListener("click", handler, true);
	  function handler(e) {
			  e.stopPropagation();
			  e.preventDefault();
			}  
			   
	
		window.top.location.href = "./login?isExpired=yes";   
		   
 		 
		}
	else{timeoutTime = currentTime + timeout;}});});</script>
	
	


<script type="text/javascript">
initScriptLoad(0);
</script>
</body></html>
<%
	} else {
		/*  request.setAttribute("msg", "  *Please login first");
		request.getRequestDispatcher("./index.jsp").forward(request, response); */
%>
<script language="JavaScript">
initScriptLoad(0);
	sessionStorage.setItem("loginMsg",
			"*Session has been expired");
	window.top.location.href = "./login";
</script>
<!-- <script language="JavaScript">
window.onload = function() {
setInterval(function() {
window.location.replace("../login");
}, 10);
}
 --></script>
<%
	}
%>


