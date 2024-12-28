<%@ page import="java.util.Date" %>
<%
   response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "no-cache");

	 int timeout = session.getMaxInactiveInterval();

	 long accessTime = session.getLastAccessedTime();
	 long currentTime= new Date().getTime();
	 long dfd= accessTime +timeout;
	 if( currentTime< dfd){

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
<html class="no-js" lang="en" dir="ltr">
<head><title>EIRS Portal</title>
<!--<title>Currency Management</title>-->
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

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon"
	href="${context}/resources/assets/images/logo.png">

<link rel="stylesheet"
	href="${context}/resources/assets/css/bootstrap.min.css">
<script src="${context}/resources/assets/js/jquery.min.js"></script>
<script src="${context}/resources/assets/js/popper.min.js"></script>
<script src="${context}/resources/assets/js/bootstrap.min.js"></script>


<!-- Security Tags -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
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
	href="${context}/resources/assets/css/iconStates.css">

<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

 <!-- CORE CSS-->


<link rel="stylesheet" href="${context}/resources/assets/css/style.css">
</head>
<body data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}" data-selected-roleType="${selectedUserTypeId}"
	data-selected-username="${username}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}">


	<div class="content-box">
                <div class="content-container">
                    <div class="content-header" id="pageHeader">
                       <!--  <h1>Grievance Management</h1> -->
                       <a href="" class="boton right" id="btnLink" hidden></a>
                    </div>
                    <div class="filter-box">
                        <form action="" class="filter-row" id="viewFilter">
                        	<div id="errorMsgDiv" class="filter-form-row" style="width: 100%;"></div>
       						<div id="configTableDiv" class="filter-form-row"></div>
       						<div id="configTableButtonDiv" class="filter-btn-row"></div>
                        </form>
                    </div>
                    <div class="table-box">
                        <div class="table-responsive">
                            <table id="configLibraryTable" class="table">
                            	<thead class="thead-dark"></thead>
                            </table>
                        </div>
                        <div id="footerBtn" class="table-paginationbox">
                        </div>
                    </div>
                </div>
            </div>


	<div id="viewAdminSystemModel" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
		  <div class="modal-content">
				<h5 class="modal-header"><spring:message code="modal.IMEI-Configuration" /></h5>
			<div class="modal-body">
				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="viewTag" class=""><spring:message code="registration.tag" /></label>
						<input type="text" id="viewTag" class="materialize-textarea form-control" placeholder="Tag" readonly="readonly">
					</div>
					<div class="form-group col-md-6">
						<label for="viewModifiedBy" class="center-align">Modified By </label>
						<input type="text" id="viewModifiedBy" class="form-control" disabled>
					</div>

					<div class="form-group col-md-6">
						<label for="viewValue" class=""><spring:message code="registration.value" /></label>
					<textarea id="viewValue" class="materialize-textarea form-control" placeholder="Value" readonly="readonly" style="min-height:8rem"></textarea>
					</div>
					<div class="form-group col-md-6">
						<label for="description" class=""><spring:message code="table.Description" /></label>
					<textarea id="description" class="materialize-textarea form-control" placeholder="Description" readonly="readonly" style="min-height:8rem"></textarea>
					</div>
<!--
					<div class="form-group col-md-6">
						<label for="type"><spring:message code="table.Type" /></label>
						<input type="text" id="viewtype" name="type" class="form-control"
							placeholder="Type" maxlength="20" disabled>
					</div>
-->
					<div class="form-group col-md-6">
						<label for="language"><spring:message code="nf.msgLang" /></label>
						<input type="text" id="viewLanguage" name="language" class="form-control"
							placeholder="Type" maxlength="20" disabled>
					</div>
					<div class="form-group col-md-6">
								<label for="editfeature"><spring:message code="table.moduleName" /> </label>
								<input type="text" id="viewfeatureName" class="form-control" name="feature" placeholder="" maxlength="20" placeholder="Module Name" disabled>
					</div>




					<div class="form-group col-md-12">
						<label for="remarks" class=""><spring:message code="msgmanagement.input.remarks" /></label>
					<textarea id="remarks" class="materialize-textarea form-control" placeholder="Remarks" readonly="readonly" style="min-height:8rem"></textarea>
					</div>


				</div>
			</div>
			<div class="modal-footer">
				<button class="cancel-product btn modal-close" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
			</div>
		  </div>
		</div>
	  </div>



	<div id="editAdminSystemModel" class="modal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg" role="document">
			  <div class="modal-content">
				<div class="modal-header">
				  <h5 class="modal-title"><spring:message code="modal.IMEI-EditConfiguration" /></h5>
				</div>
				<div class="modal-content_">
					<form action="" onsubmit="return updateSystem()">
						<div class="modal-body">
						<div class="form-row">
						<div class="form-group col-md-6">
                        									<label for="editTag" class=""><spring:message code="registration.tag" />
                        									<span class="star">*</span>
                        									</label>
                        									<input type="text" id="editTag" class="form-control" name="editTag" placeholder="" maxlength="100"  required="required" disabled>

                        								</div>


                                <div class="form-group col-md-6">
									<label for="editModifiedBy" class="center-align">Modified By </label>
									<input type="text" id="editModifiedBy" class="form-control" disabled>
								</div>
								</div>


						<div class="form-row">

<div class="form-group col-md-6">
                        									<input type="text" name="Id" id="EditId"
                        										placeholder="ID" disabled hidden="hidden">

                        		<label for="editValue" class=""><spring:message code="registration.value" />
                        		</label>
                        								<textarea id="editValue" class="materialize-textarea form-control" Placeholder=""
                        								 style="min-height:8rem" ></textarea>
                        								 </div>

								<div class="form-group col-md-6">
									<label for="editdescription" class=""><spring:message code="registration.description" /></label>
								<textarea id="editdescription" class="materialize-textarea form-control" Placeholder="" placeholder="" title="Please enter alphabets and numbers upto 200 characters only" style="min-height:8rem"></textarea>

								</div>
				    </div>

				    <div class="form-row">
				    <!--
                    <div class="form-group col-md-6">
                    									<label for="type"><spring:message code="table.Type" /></label>
                    									<input type="text" id="edittype" class="form-control" name="type" placeholder="" maxlength="20" disabled>
                    								</div>
-->
 <div class="form-group col-md-6">
                    									<label for="language"><spring:message code="nf.msgLang" /></label>
                    									<input type="text" id="editLanguage" class="form-control" name="language" placeholder="" maxlength="20" disabled>
                    								</div>

                    								 <div class="form-group col-md-6">
                    									<label for="editfeature"><spring:message code="table.moduleName" /> </label>
                    									<input type="text" id="editfeatureName" class="form-control" name="feature" placeholder="" maxlength="20" placeholder="Module Name" disabled>
                    							  	</div>
                    </div>


<div class="form-row">
<div class="form-group col-md-12">
									<label for="editremarks" class=""><spring:message code="msgmanagement.input.remarks" /></label>
								<textarea id="editremarks" placeholder="Remarks" class="materialize-textarea form-control" style="min-height:8rem"></textarea>

								</div>
</div>

					</div>
				<div class="modal-footer">
					<button class="save-product btn" type="submit" style="margin-left: 10px;"><spring:message code="button.update" /></button>
					<button class="cancel-product btn modal-close" type="button" style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
				</div>
			</form>
			  </div>
			</div>
		  </div>
	</div>


	<div id="confirmedUpdatedSystem" class="modal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg" role="document">
			  <div class="modal-content">
				<div class="modal-header">
				  <h5 class="modal-title"><spring:message code="modal.IMEI-UpdateSystem" /></h5>
				</div>
				<div class="modal-body">
				  <p id="updateFieldMessage"></p>
				</div>
				<div class="modal-footer">
					<a href="${context}/CheckIMEIParam" class="cancel-product btn modal-close"><spring:message code="modal.ok" /></a>
				</div>
			  </div>
			</div>
		  </div>
		</section>


	<script type="text/javascript"
		src="${context}/resources/plugins/materialize.js"></script>
	<script type="text/javascript"
		src="${context}/resources/plugins/data-tables/js/jquery.dataTables.min.js"></script>


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
		src="${context}/resources/project_js/dragableModal.js?version=<%= (int) (Math.random() * 10) %>"></script>


	<script type="text/javascript"
		src="${context}/resources/project_js/viewCheckIMEIManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
			<script type="text/javascript"
		src="${context}/resources/project_js/validationMsg.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
			<script type="text/javascript"
		src="" async></script>
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

