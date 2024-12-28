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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Security Tags -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:csrfMetaTags />
<!-- Security Tags -->
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head><title>EIRS Portal</title>
<!--<title>Customer Search</title>-->

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


<link
	href="${context}/resources/plugins/data-tables/css/jquery.dataTables.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">
<link
	href=""
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
	href="${context}/resources/assets/css/iconStates.css">


<link rel="stylesheet"
	href="${context}/resources/custom_js/jquery-ui.css">
<script src="${context}/resources/custom_js/1.12.1_jquery-ui.min.js"></script>

<script src="${context}/resources/custom_js/jquery.blockUI.js"></script>

<style type="text/css">
 #starColor {
            color: red;
        }
        
.disable {
    color: grey;
}    
</style>

</head>
<body data-id="26"
data-roleType="${usertype}" data-userID="${userid}" data-userTypeID="${usertypeId}" data-selectedRoleTypeId="${selectedRoleTypeId}"
	data-selected-roleType="${selectedUserTypeId}"
	 data-stolenselected-roleType="${stolenselectedUserTypeId}"
	 session-valueTxnID="${not empty param.txnID ? param.txnID : 'null'}" 
	 data-period="${period}" data-msisdn="${msisdn}" data-imei="${imei}" data-deviceIdType="${deviceIdType}" data-deviceIdvalue="${deviceIdvalue}"
	 data-selected-username="${username}">


	<!-- START CONTENT -->
	<section id="content">
	<div id="initialloader"></div>
		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div class="container" id="CustomerDetail">
                  <div id="profile-page" class="section">

                    <div class="row">
                      <form action="">
                        <div class="col s12 m12 l12">
                          <h4 class="header2 device-info">
                           <spring:message code="modal.DeviceInformation" /></h4>
                          <div class="row">
                            <div class="input-field col s12 m4 l4">
                              <input type="text" id="MSISDN" name="MSISDN" value="" disabled>
                              <label for="MSISDN" ><spring:message code="input.msisdn" /></label>
                            </div>

                            <div class="input-field col s12 m4 l4">
                              <input type="text" id="IMEI" name="IMEI" value="" disabled>
                              <label for="IMEI" ><spring:message code="input.imei" /></label>
                            </div>

                            <div class="input-field col s12 m4 l4">
                              <input type="text" id="IMSI" name="IMSI" value="" disabled>
                              <label for="IMSI" ><spring:message code="input.imsi" /></label>
                            </div>
                          </div>
                        </div>

                        <div class="col s12 m12 l12">
                          <h4 class="header2 tac-info">
                            <spring:message code="modal.header.tacInformation" /></h4>
                          <div class="row">
                            <div class="input-field col s12 m3 l3">
                              <input type="text" id="handsetType" name="handsetType" value="" disabled>
                              <label for="handsetType" ><spring:message code="input.HandsetType" /></label>
                            </div>

                            <div class="input-field col s12 m3 l3">
                              <input type="text" id="osType" name="osType" value="" disabled>
                              <label for="osType" ><spring:message code="input.osType" /></label>
                            </div>

                            <div class="input-field col s12 m3 l3">
                              <input type="text" id="brand" name="brand" value="" disabled>
                                     <label for="brand" ><spring:message code="table.ProductName" /></label>
                            </div>

                            <div class="input-field col s12 m3 l3">
                              <input type="text" id="modal" name="modal" value="" disabled>
                              <label for="modal" ><spring:message code="table.ModelNumber" /></label>
                            </div>
                          </div>
                        </div>

                        <div class="col s12 m12" >
                          <h4 class="header2 device-state">
                            <spring:message code="modal.deviceState" /></h4>
                          <div class="col s12 m6">
                            <table class="responsive-table striped datatable" id="DeviceStateTable">
                              <thead>
                                <tr>
                                  <th><spring:message code="table.State"/></th>
                                  <th><spring:message code="table.date"/></th>
                                  <th><spring:message code="table.State"/></th>
                                  <th><spring:message code="table.view"/></th>
                                </tr>
                              </thead>
  							  <tbody style="background-color: #fff;">
                             
                              </tbody>
                            </table>
                          </div>

                          <div class="col s12 m6">
                            <table class="responsive-table striped datatable" id="DeviceTable">
                              <thead>
                                <tr>
                                  <th><spring:message code="table.DeviceFound"/></th>
                                  <th><spring:message code="table.date"/></th>
                                    <th><spring:message code="table.State"/></th>
                                  <th><spring:message code="table.view"/></th>
                                </tr>
                              </thead>
  
                              <tbody style="background-color: #fff;">
                                
                              </tbody>
                            </table>
                          </div>
                        </div>
                        

                        <div class="col s12 m12">
                          <h4 class="header2" style="font-weight: bold; margin-top: 50px;">
                            <spring:message code="modal.NotificationInformation" /> </h4>
                            <table class="responsive-table striped display" id="Notification-data-table" cellspacing="0">
                          
                          </table>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
						</div>

					</div>
				</div>
				<div id="footerBtn"></div>
			</div>
		</div>
		<!--end container-->
	</section>






	<div id="viewModal" class="modal-form">
	<div class="header-fixed header-fixed-style">
		<h6 class="modal-header">
			<spring:message code="modal.header.viewConsignment" />
		</h6>
		</div>
		<div class="scrollDivHeight"></div>
		<div class="modal-content" style="margin-top: 5px;">
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
					<input type="text" name="totalPrice" placeholder=""
						disabled="disabled" id="viewtotalPrice" maxlength="7" />
					<label for="totalPrice" class="center-align"><spring:message
							code="input.totalprice" /></label>
				</div>

			
				<div class="input-field col s12 m6">
					<textarea id="remark" class="materialize-textarea"
						style="height: 0px;" readonly="readonly" placeholder=""></textarea>
					<label for="remark" class=""><spring:message
							code="input.remarks" /></label>

					<!--   <input type="textarea" name="Remark" placeholder="Remark" id="remark" readonly="readonly" maxlength="15" />
                                               <label for="TransactionId" class="center-align">Remark</label> -->
				</div>
					<div class="col s12 m6" id="viewCurrencyDiv">
					<label for="Currency"><spring:message code="input.currency" /></label>
					<select id="viewcurrency" class="browser-default"
						disabled="disabled">
						<option value="" disabled selected><spring:message
								code="input.currency" /></option>

					</select>
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
	

 
 	<div id="viewStockModal" class="modal">
 	<div class="header-fixed header-fixed-style">
		<h6 class="modal-header">
			<spring:message code="modal.header.viewStock" />
		</h6>
		</div>
		<div class="scrollDivHeight"></div>
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
					 
					  <div class="col s12 m6" id="endUserEmailDiv">
                           <label for="endUseremail" style="color: #000;"><spring:message code="input.EmailID" /> </label>
                           <input type="text" id="endUseremail"  disabled name="endUseremail"/>
                      </div>
					<div class="input-field col s12 m6">
						<input type="text" name="Quantity" id="StockQuantity" placeholder=""
							disabled /> <label for="StockQuantity" class="center-align"><spring:message
								code="input.quantity" /></label>
					</div>
					<div class="input-field col s12 m6">
						<input type="text" name="StockDeviceQuantity" id="StockDeviceQuantity" placeholder=""
							disabled /> <label for="StockDeviceQuantity" class="center-align"><spring:message
								code="input.devicequantity" /></label>
					</div>

					<div class="input-field col s12 m6" id="invoiceNumberDiv">
						<input type="text" name="InvoiceNumber" id="InvoiceNumber"
							placeholder="" disabled /> <label for="InvoiceNumber"
							class="center-align"><spring:message
								code="input.invoiceNumber" /></label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" name="TransactionId" id="StockTransactionId"
							disabled placeholder="" maxlength="18" /> <label
							for="StockTransactionId" class="center-align"><spring:message
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
	
	<div id="viewImporterModal" class="modal">
			<div class="header-fixed header-fixed-style">
			<h6 class="modal-header">
				<spring:message code="input.ViewType" />
			</h6>
			</div>
			<div class="scrollDivHeight"></div>
			<div class="modal-content">




				<div class="row" style="margin-top: 10px;">
					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewtradmark" name="tradmark"
							placeholder="" disabled=""> <label for="viewtradmark"
							class="active"><spring:message code="input.Trademark" /></label>
					</div>
					
					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewtxnId" name="transactioId"
							placeholder="" disabled=""> <label for="viewtxnId"
							class="active"><spring:message code="table.transactionID" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewmodelName" name="modelName"
							placeholder="" disabled="disabled"> <label
							for="viewmodelName" class="active"><spring:message
								code="input.modelName" /> <span class="star"></span></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewModelnumber" name="modelNumber"
							placeholder="" disabled="disabled"> <label
							for="viewModelnumber" class="active"><spring:message
								code="input.modelNumber" /> <span class="star"></span></label>
					</div>

					


					<!-- <div class="input-field col s12 m6 l6">
						<input type="text" id="viewDeviceType" name="deviceType"
							placeholder="" disabled=""> <label
							for="deviceType" class="active">Device Type </label>
					</div> -->


				</div>

				<!-- <div class="row" style="margin-top: 5px;">
					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewdeviceTypeID" name="deviceType"
							placeholder="" disabled=""> <label for="deviceType"
							class="active">Device ID Type</label>
					</div> -->


				<div class="row">

					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewFrequency" name="tac" placeholder=""
							disabled=""> <label for="viewFrequency" class="active"><spring:message
								code="input.frequency" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewImportertac" name="tac" placeholder=""
							disabled=""> <label for="tac" class="active"><spring:message
								code="input.TAC" /></label>
					</div>
				</div>
				
				<div class="input-field col s12 m6 l6" style="width: 402px;margin-left: 1px;">
						<input type="text" id="viewManufacturercountry" name="Country" style="padding-left: 8px;"
							placeholder="" disabled=""> <label
							for="viewManufacturercountry" class="active"><spring:message
								code="input.Country" /></label>
				</div>
				<div class="modal-content">
					<div id="live-chat">
						<div class="chat">
							<div class="chat-history">
								<div class="chat-message clearfix" id="chatMsg" style="cursor: pointer;"></div>
								<!-- end chat-message -->


							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row ">
				<div class="center  popup-btn-div" style="margin-top: 10px;">
					<button class="modal-close btn" type="button" id="Cancel"
						style="margin-left: 10px;">
						<spring:message code="modal.close" />
					</button>
				</div>



			</div>
		</div>
	
<div id="InvalidTxnModal" class="modal">
<div class="header-fixed header-fixed-style">
		<h6 class="modal-header"></h6>
		</div>
		<div class="scrollDivHeight"></div>
		<div class="modal-content">
			<div class="row">
				<h6 id="fileErrormessage"><spring:message code="invalidaTxnIdMsg" /> </h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<div class="input-field col s12 center">
						<button class="modal-close btn " 
							style="margin-left: 10px;"><spring:message code="modal.ok" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<%-- <div id="viewImporterModal" class="modal" >
			<h6 class="modal-header">
				<spring:message code="input.ViewType" />
			</h6>
			<div class="modal-content">




				<div class="row" style="margin-top: 10px;">
					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewtradmark" name="tradmark"
							placeholder="" disabled=""> <label for="viewtradmark"
							class="active"><spring:message code="input.Trademark" /></label>
					</div>
					
					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewtxnId" name="transactioId"
							placeholder="" disabled=""> <label for="viewtxnId"
							class="active"><spring:message code="table.transactionID" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewmodelName" name="modelName"
							placeholder="" disabled="disabled"> <label
							for="viewmodelName" class="active"><spring:message
								code="input.modelName" /> <span class="star"></span></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewModelnumber" name="modelNumber"
							placeholder="" disabled="disabled"> <label
							for="viewModelnumber" class="active"><spring:message
								code="input.modelNumber" /> <span class="star"></span></label>
					</div>

					


					<!-- <div class="input-field col s12 m6 l6">
						<input type="text" id="viewDeviceType" name="deviceType"
							placeholder="" disabled=""> <label
							for="deviceType" class="active">Device Type </label>
					</div> -->


				</div>

				<!-- <div class="row" style="margin-top: 5px;">
					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewdeviceTypeID" name="deviceType"
							placeholder="" disabled=""> <label for="deviceType"
							class="active">Device ID Type</label>
					</div> -->


				<div class="row">

					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewFrequency" name="tac" placeholder=""
							disabled=""> <label for="viewFrequency" class="active"><spring:message
								code="input.frequency" /></label>
					</div>

					<div class="input-field col s12 m6 l6">
						<input type="text" id="viewImportertac" name="tac" placeholder=""
							disabled=""> <label for="tac" class="active"><spring:message
								code="input.TAC" /></label>
					</div>
				</div>
				
				<div class="input-field col s12 m6 l6" style="width: 402px;margin-left: 1px;">
						<input type="text" id="viewManufacturercountry" name="Country" style="padding-left: 8px;"
							placeholder="" disabled=""> <label
							for="viewManufacturercountry" class="active"><spring:message
								code="input.Country" /></label>
				</div>
				<div class="modal-content">
					<div id="live-chat">
						<div class="chat">
							<div class="chat-history">
								<div class="chat-message clearfix" id="chatMsg" style="cursor: pointer;"></div>
								<!-- end chat-message -->


							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row ">
				<div class="center  popup-btn-div" style="margin-top: 10px;">
					<button class="modal-close btn" type="button" id="Cancel"
						style="margin-left: 10px;">
						<spring:message code="modal.close" />
					</button>
				</div>



			</div>
		</div>
 --%>	
	
	
	<div id="viewDeviceInfo" class="modal">
	<div class="header-fixed header-fixed-style">
	<h6 class="modal-header">
				                                          <spring:message code="modal.deviceInfo" />
			                                            </h6></div>
			                                            <div class="scrollDivHeight"></div>
			                                   <div class="modal-content modal-content-style">         
										<div id="mainDeviceInformation" class="mainDeviceInformation">
										<div id="deviceInformation" class="deviceInformation">
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m12" style="margin-top: 30px;">
														
														<%-- <h5><spring:message code="modal.deviceInfo" /></h5> --%>
														
													</div>

													<div class="col s12 m6">
														<label class="moveLabelUp" for="endUserdeviceType"><spring:message code="select.deviceType" /><span
															class="star"></span></label>
															<input type="text" value=""  readonly="readonly" id="endUserdeviceType">
													</div>

													<div class="col s12 m6">
														<label class="moveLabelUp" for="endUserdeviceIdType"><spring:message code="select.deviceIDType" /><span
															class="star"></span></label> 
															<input type="text" value=""  readonly="readonly" id="endUserdeviceIdType">
													</div>

													<div class="col s12 m6">
														<label class="moveLabelUp" for="endUserMultiSimStatus"><spring:message code="select.multiSimStatus" /><span class="star"></span>
														</label> <input type="text" value=""  readonly="readonly" id="endUserMultiSimStatus">
													</div>

													<div class="col s12 m6">
														<label for="endUserCountry"><spring:message code="select.countryBoughtFrom" /><span
															class="star"></span></label> 
															<input type="text" value="" class="moveLabelUp" readonly="readonly" id="endUserCountry">
													</div>

													<div class=" col s12 m6">
														 <label for="endUserSerialNumer" class="center-align"> <spring:message code="input.deviceSerialNumber" /><span class="star"></span>
														</label>
														<input type="text" value="" name="endUserSerialNumer"  readonly="readonly" id="endUserSerialNumer">
														
													</div>

													<div class="col s12 m6">
														<label class="moveLabelUp" for="endUserTaxPaid"><spring:message code="select.taxPaidStatus" /><span
															class="star"></span></label> <input type="text"  readonly="readonly" value="" id="endUserTaxPaid">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class="col s12 m6">
														<label class="moveLabelUp" for="endUserDeviceStatus"><spring:message code="select.deviceStatus" /><span
															class="star"></span></label> 
														<input type="text" readonly="readonly" value=""  id="endUserDeviceStatus">	
													</div>

													<div class=" col s12 m6 l6">
													<label class="moveLabelUp" for="endUserPrice"><spring:message code="select.price" /></label>
														<input  type="text" value="" readonly="readonly"  id="endUserPrice">
														
													</div>

													<div class="col s12 m6">
														<label class="moveLabelUp" for="endUserCurrency"><spring:message code="input.currency" /><span class="star"></span></label>
														<input type="text" value=""  readonly="readonly" id="endUserCurrency">
													</div>
													<div class="col s12 m6">
													<label class="moveLabelUp" for="enduserTransactionId" class="center-align"><spring:message code="input.transactionID" /></label>
													<input type="text"   name="enduserTransactionId" id="enduserTransactionId"
							                        disabled placeholder="" maxlength="18" /> 
								</div>
								<div class="col s12 m6">
												<label for="enduserNid"
														class="center-align ml-10"><spring:message code="registration.nid/passportnumber" /></label>	
													<input type="text"   name="enduserTransactionId" id="enduserNid"
							                        disabled placeholder="" maxlength="18" /> 
								</div>
												</div>
											</div>
											<div class="row">
												<div class="col s12 m12">
													<div class='col s12 m12 input_fields_wrap'>
														<p><spring:message code="title.imeiMeidEsn" /></p>
														<div class='row'>
															<div class=" col s12 m6">
																
																 <label class="moveLabelUp" for="endUserImei1"><spring:message code="title.one" /><span
																	class="star"></span></label>
															<input type="text" value=""   readonly="readonly" id="endUserImei1">
															</div>
															<div class=" col s12 m6">
																
																 <label class="moveLabelUp" for="endUserImei2"><spring:message code="title.two" /></label>
															<input type="text" value="" readonly="readonly" id="endUserImei2">
															</div>

															<div class=" col s12 m6">
																
																 <label class="moveLabelUp" for="endUserImei3"><spring:message code="title.three" /></label>
															<input type="text" value=""  readonly="readonly" id="endUserImei3" > 
															</div>

															<div class=" col s12 m6" id="field">
																
																 <label class="moveLabelUp" for="endUserImei4"><spring:message code="title.four" /></label>
															<input type="text" value=""  readonly="readonly" id="endUserImei4">
															</div>
														</div>
													</div>
												</div>
											</div>
											
											<div class="row ">
				<div class="center  popup-btn-div" style="margin-top: 10px;">
					<button class="modal-close btn" type="button" id="Cancel"
						style="margin-left: 10px;">
						<spring:message code="modal.close" />
					</button>
				</div>
				</div>
										</div>
									</div>
</div>
</div>

<div id="greyListTableModal" class="modal">
 <button type="button" style="    font-size: 25px;"
			class=" modal-action modal-close  btn-flat right"
			data-dismiss="modal">&times;</button>
		<h6 class="modal-header">Device Details</h6>
		<div class="modal-content">
			<div class="row">
				<%-- <h6 id="fileErrormessage"><spring:message code="invalidaTxnIdMsg" /> </h6> --%>
			</div>
			<div class="row">
				<table id="greyListDataTable" style="margin-top: 10px">
				<thead>
				<tr>
				<th>Created On</th>
				<th>Updated On</th>
				<th>MSISDN</th>
				<th>IMEI</th>
				<th>IMSI</th>
				</tr>
				</thead>
				<tbody >
				
				</tbody >
				</table>
			</div>
		</div>
	</div>
	
	
	<div id="globalBlackListTableModal" class="modal">
 <button type="button"
			class=" modal-action modal-close  btn-flat right"
			data-dismiss="modal">&times;</button>
		<h6 class="modal-header">Device Details</h6>
		<div class="modal-content">
			<div class="row">
				<%-- <h6 id="fileErrormessage"><spring:message code="invalidaTxnIdMsg" /> </h6> --%>
			</div>
			<div class="row">
				<table id="globalBlackListDataTable" style="margin-top: 10px">
				<thead>
				<tr>
				<th>Created On</th>
				<th>Black List Status</th>
				<th>Grey List Status</th>
				</tr>
				</thead>
				<tbody >
				
				</tbody >
				</table>
			</div>
		</div>
	</div>
	
	 	<div id="blockListModal" class="modal">
		<h6 class="modal-header" id="blockDeviceHeader">Block Device Details
			<%-- <spring:message code="modal.header.viewStock" /> --%>
		</h6>
		<div class="modal-content">


			<form action="" style="margin-top: 10px;">

				<div class="row myRow">
					<div class="input-field col s12 m6" id="">
						<input type="text" name="SupplierId" id="blockedUserType"
							placeholder="" disabled /> <label for="blockedUserType"
							id="" class="center-align"><%-- <spring:message
								code="input.supplierID" /> --%>User Type</label>
					</div>

					<div class="input-field col s12 m6" id="">
						<input type="text" name="SupplierName" id="blockedUserName"
							placeholder="" disabled /> <label for="blockedUserName"
							id="SupplierNameLabel" class="center-align"><%-- <spring:message
								code="input.supllierName" /> --%>User Name</label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" name="Quantity" id="blockedDate" placeholder=""
							disabled /> <label for="blockedDate" class="center-align"><%-- <spring:message
								code="input.quantity" /> --%>Date </label>
					</div>

					<div class="input-field col s12 m6" >
						<input type="text" name="InvoiceNumber" id="blockExpiryDate"
							placeholder="" disabled /> <label for="blockExpiryDate"
							class="center-align"><%-- <spring:message
								code="input.invoiceNumber" /> --%> Expiry Date</label>
					</div>
					<div class="input-field col s12 m6" id="">
						<input type="text" name="SupplierName" id="blockeModeType"
							placeholder="" disabled /> <label for="blockeModeType"
							id="SupplierNameLabel" class="center-align"><%-- <spring:message
								code="input.supllierName" /> --%>Mode Type</label>
					</div>

					<div class="input-field col s12 m6">
						<input type="text" name="Quantity" id="complaintType" placeholder=""
							disabled /> <label for="complaintType" class="center-align"><%-- <spring:message
								code="input.quantity" /> --%>Complaint Type </label>
					</div>

					

				
				</div>

				<div class="row center" style="margin-top: 20px;">

					<button class="modal-close btn" type="button"><spring:message
							code="modal.close" /></button>
				</div>
			</form>
		</div>
	</div>
	<!-- END MAIN -->
<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>


	<script type="text/javascript"
		src=""></script>
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


	<script type="text/javascript" src="${context}/resources/project_js/common.js?version=<%= (int) (Math.random() * 10) %>"></script>
	
	<script type="text/javascript"
		src="${context}/resources/project_js/customerCare.js?version=<%= (int) (Math.random() * 10) %>"></script>  

	<script type="text/javascript"
		src="${context}/resources/project_js/dragableModal.js"></script>
	<script type="text/javascript"
		src="" async></script>	


<%-- <script type="text/javascript">$( document ).ready(function() {if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;$("body").click(function(e) {$.ajaxSetup({headers:{ 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") }});$.ajax({url: './serverTime',type: 'GET',async: false,success: function (data, textStatus, jqXHR) {currentTime = data;},error: function (jqXHR, textStatus, errorThrown) {}});if( currentTime > timeoutTime ){window.top.location.href = "./login?isExpired=yes";}else{timeoutTime = currentTime + timeout;}});});</script> --%>

<script type="text/javascript">var countHit="";  $( document ).ready(function() { if($("body").attr("data-roleType") == '' || ($("body").attr("data-roleType") != window.parent.$("body").attr("data-roleType"))){window.top.location.href = "./login?isExpired=yes";} var timeoutTime = <%=session.getLastAccessedTime()%>;var timeout = <%=session.getMaxInactiveInterval()%>;timeoutTime += timeout;var currentTime;
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