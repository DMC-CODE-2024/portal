<%@ page import="java.util.Date"%>
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
long currentTime = new Date().getTime();
long dfd = accessTime + timeout;
if (currentTime < dfd) {
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
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:csrfMetaTags />
<!-- Security Tags -->
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<!-- <head> <title>EIRS Admin Portal</title> -->


<!--<title>Grievance</title>-->

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
		<link rel="icon" type="image/x-icon" href="${context}/resources/assets/images/logo.png">
		<%-- <link href="${context}/resources/css/materialize.css" type="text/css"
	rel="stylesheet" media="screen,projection"> --%>
		<link rel="stylesheet" href="${context}/resources/assets/css/bootstrap.min.css">
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
	href="${context}/resources/assets/css/iconStates.css">

<link
	href="${context}/resources/font/font-awesome/css/font-awesome.min.css"
	type="text/css" rel="stylesheet" media="screen,projection">

 <!-- CORE CSS-->


<link rel="stylesheet" href="${context}/resources/assets/css/style.css">

<script>
var contextpath = "${context}";
</script>
</head>
<body data-roleType="${usertype}" data-userTypeID="${usertypeId}" data-userID="${userid}"
	data-selected-roleType="${selectedUserTypeId}"
	data-selected-username="${username}"
	data-stolenselected-roleType="${stolenselectedUserTypeId}">


	<!-- START CONTENT -->
	<!-- START CONTENT -->
	<%-- <section id="content">
	<div id="initialloader"></div>
		<!--start container-->
		<div class="container">
			<div class="section">
				<div class="row">
					<div class="col s12 m12 l12">
						<div class="row card-panel">
							<div class="container-fluid pageHeader" id="pageHeader">

								<a href="" class="boton right" id="btnLink" hidden></a>
							</div>
							<form action="${context}/messageManagement" id="viewFilter"
								method="post">
								<div class="registrationTableDiv_box" id="messageTableDiv"
									style="padding-bottom: 5px; background-color: #e2edef52;">
									<div id="filterBtnDiv">
										<!-- 							<div class='col s12 m2 l2'><button type='submit' class='btn primary botton' id='submitFilter'></button></div>
		 -->
									</div>
								</div>
							</form>
							<table id="messageLibraryTable"
								class="responsive-table striped display"></table>

						</div>

					</div>
				</div>
				<div id="footerBtn"></div>
			</div>
		</div>
		<!--end container-->
	</section> --%>

	<body>

            <div class="content-box">
                <div class="content-container">
                    <div class="content-header" id="pageHeader">
                       <!--  <h1>Grievance Management</h1> -->
                    </div>
                    <div class="filter-box">
                        <form action="${context}/messageManagement" id="viewFilter"
								method="post" class="filter-row">
						<div id="errorMsgDiv" class="filter-form-row" style="width: 100%;"></div>
       					<div id="messageTableDiv" class="filter-form-row"></div>
       					<div id="registrationTableButtonDiv" class="filter-btn-row"></div>

                        </form>
                    </div>
                    <div class="table-box">
                        <div class="table-responsive">
                            <table id="messageLibraryTable" class="table">
                            	<thead class="thead-dark"></thead>
                            </table>
                        </div>
                        <div id="footerBtn" class="table-paginationbox">
                        </div>
                    </div>
                </div>
            </div>

 </body>
	<!-- Modal 2 start   -->

	<!-- <div id="viewMessageModel" class="modal">
		<h6 class="modal-header"><spring:message code="registration.viewmessagemanagement" /></h6>
		<div class="modal-content">

			<div class="row">
				<div class="row" style="margin-top:10px">

						<input type="text" name="tag" id="viewTag"
							placeholder="tag" disabled hidden="hidden" >


					<div class="input-field col s12 m6" style="margin-top:22px">
					<input type="text" id= "viewChannel" placeholder="" disabled>
					<label for="viewChannel" class="center-align"><spring:message code="registration.channel" /></label>

					</div>

					<div class="input-field col s12 m6" style="margin-top:22px">
					<input type="text" id="viewFeature" placeholder="" disabled>
					<label for="viewFeature" class="center-align"><spring:message code="table.feature" /></label>

					</div>

					<div class="input-field col s12 m6" >
					<textarea id="viewSubject" class="materialize-textarea" readonly="readonly" style="min-height:8rem"></textarea>
					<label for="viewSubject" class="center-align"><spring:message code="table.subject" /> </label>

					</div>

					<div class="input-field col s12 m6" >
					<textarea id="viewValue" class="materialize-textarea" readonly="readonly" style="min-height:8rem"></textarea>
					<label for="viewValue" class="center-align"><spring:message code="registration.value" /> </label>

					</div>


					<div class="input-field col s12 m6">
					<textarea id="description" class="materialize-textarea" readonly="readonly" style="min-height:8rem"></textarea>
					<label for="description" class="center-align"><spring:message code="registration.description" /></label>

					</div>

					<div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="text" id="viewMessageModifiedBy"  disabled>
                        <label for="viewModifiedBy" class="center-align">Modified By </label>
                    </div>



				</div>



				<div class="row input_fields_wrap">
					<div class="col s12 m12 center" style="margin-top: 10px;">
					<button class="btn modal-close" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
				</div>

				</div>
			</div>
		</div>
	</div>-->
	<div  id="viewMessageModel" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
		  <div class="modal-content">
				<h5 class="modal-header"><spring:message code="registration.viewmessagemanagement" /></h5>
			<div class="modal-body">
				<form>
				<div class="form-row">
				<div class="form-group col-md-6">
				<label for="viewChannel" class="center-align"><spring:message code="registration.channel" /></label>
				<input type="text" class="form-control" name="tag" id="viewTag" placeholder="tag" disabled hidden="hidden" >
				<input type="text" class="form-control" id= "viewChannel" placeholder="" disabled>
				</div>

				<div class="form-group col-md-6">
				<label for="viewFeature" class="center-align"><spring:message code="table.feature" /></label>
				<input type="text" class="form-control" id="viewFeature" placeholder="" disabled>
				</div>

				<div class="form-group col-md-6" >
				<label for="viewSubject" class="center-align"><spring:message code="table.subject" /> </label>
				<textarea id="viewSubject" class="materialize-textarea form-control" readonly="readonly" style="min-height:8rem"></textarea>
				</div>

				<div class="form-group col-md-6" >
				<label for="viewValue" class="center-align"><spring:message code="registration.value" /> </label>
				<textarea id="viewValue" class="materialize-textarea form-control" readonly="readonly" style="min-height:8rem"></textarea>
				</div>

				<div class="form-group col-md-12">
				<label for="description" class="center-align"><spring:message code="registration.description" /></label>
				<textarea id="description" class="materialize-textarea form-control" readonly="readonly" style="min-height:8rem"></textarea>
				</div>

				<div class="form-group col-md-6">
					<label for="viewModifiedBy" class="center-align">Modified By </label>
					<input type="text" class="form-control" id="viewMessageModifiedBy"  disabled>
				</div>



			</div>
		   </form>
			</div>
			<div class="modal-footer">
				<button class="cancel-product btn modal-close" style="margin-left: 10px;"><spring:message code="modal.close" /></button>
			</div>
		  </div>
		</div>
	  </div>
	<!-- Modal End -->


	<!-- Modal 3 start   -->

	<!-- <div id="editMessageModel" class="modal">
		<h6 class="modal-header"><spring:message code="registration.editmessagemanagement" /></h6>
		<div class="modal-content">
		<form action="" onsubmit="return updateMessage()">
			<div class="row">
				<div class="row">

					<div class="input-field col s12 m6 l6">
						<input type="text" name="Tag" id="Edittag"
							placeholder="tag" disabled
							style="height: 28px;" hidden = "hidden">
					</div>

					<div class="input-field col s12 m6 l6" style = "margin-top: 22px">
						<input type="text" name="id" id="EditId"
							placeholder="tag" disabled hidden="hidden">
					</div>

					<div class="input-field col s12 m6">
					<input type="text" id= "editChannel"  placeholder="" disabled>
					<label for="editChannel" class="center-align"><spring:message code="registration.channel" /></label>

					</div>

					<div class="input-field col s12 m6">
					<input type="text" id="editFeature" placeholder="" disabled>
					<label for="editFeature" class="center-align"><spring:message code="table.feature" /></label>

					</div>

					<div class="input-field col s12 m6" >
					<textarea id="editSubject" class="materialize-textarea" style="min-height:8rem" maxlength="100"></textarea>
					<label for="editSubject" class="center-align"><spring:message code="table.subject" /> </label>

					</div>


					<div class="input-field col s12 m6">
					<textarea id="editValue" class="materialize-textarea" placeholder="" title="Please enter alphabets and numbers upto 500 characters only" maxlength="500" required="required" style="min-height:8rem"></textarea>
					<label for="editValue" class="center-align"><spring:message code="registration.value" /> <span class="star">*</span></label>

					</div>


					<div class="input-field col s12 m6">
					<textarea id="editdescription" class="materialize-textarea" placeholder="" title="Please enter alphabets and numbers upto 200 characters only" maxlength="200" style="min-height:8rem"></textarea>
					<label for="editdescription" class="center-align"><spring:message code="registration.description" /></label>

					</div>

					<div class="input-field col s12 m6" style="margin-top: 22px;">
                        <input type="text" id="editMessageModifiedBy"  disabled>
                        <label for="editModifiedBy" class="center-align">Modified By </label>
                    </div>




				</div>



				<div class="row input_fields_wrap">
					<div class="col s12 m12 center" style="margin-top: 10px;">
					<button class="btn " type="submit"><spring:message code="button.update" /></button>
					<button class="modal-close btn" type="button" style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
				</div>

				</div>
			</div>
			</form>
		</div>
	</div> -->

	  <div id="editMessageModel" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
		  <div class="modal-content">
			<form action="" onsubmit="return updateMessage()">
				<h5 class="modal-header"><spring:message code="registration.editmessagemanagement" /></h5>
			<div class="modal-body">

				<div class="form-row">
					<div class="form-group col-md-6">
						<input type="text" name="Tag" id="Edittag"	placeholder="tag" disabled style="height: 28px;" hidden = "hidden">
					</div>

					<div class="form-group col-md-6">
						<input type="text" name="id" id="EditId" placeholder="tag" disabled hidden="hidden">
					</div>

					<div class="form-group col-md-6">
					<label for="editChannel" class="center-align"><spring:message code="registration.channel" /></label>
					<input type="text" class="form-control" id= "editChannel"  placeholder="" disabled>
					</div>

					<div class="form-group col-md-6">
					<label for="editFeature" class="center-align"><spring:message code="table.feature" /></label>
					<input type="text" class="form-control" id="editFeature" placeholder="" disabled>
					</div>

					<div class="form-group col-md-6">
					<label for="editSubject" class="center-align"><spring:message code="table.subject" /> </label>
					<textarea id="editSubject" class="materialize-textarea form-control" style="min-height:8rem" maxlength="100"></textarea>
					</div>

					<div class="form-group col-md-6">
					<label for="editValue" class="center-align"><spring:message code="registration.value" /> <span class="star">*</span></label>
					<textarea id="editValue" class="materialize-textarea form-control" placeholder="" title="Please enter alphabets and numbers upto 500 characters only" maxlength="500" required="required" style="min-height:8rem"></textarea>
					</div>

					<div class="form-group col-md-12">
					<label for="editdescription" class="center-align"><spring:message code="registration.description" /></label>
					<textarea id="editdescription" class="materialize-textarea form-control" placeholder="" title="Please enter alphabets and numbers upto 200 characters only" maxlength="200" style="min-height:8rem"></textarea>
					</div>

					<div class="form-group col-md-6">
						<label for="editModifiedBy" class="center-align">Modified By </label>
						<input type="text" class="form-control" id="editMessageModifiedBy"  disabled>
					</div>
				</div>

			</div>
			<div class="modal-footer">
				<button class="save-product btn" type="submit"><spring:message code="button.update" /></button>
				<button class="cancel-product btn modal-close" type="button" style="margin-left: 10px;"><spring:message code="button.cancel" /></button>
			</div>
		</form>
		  </div>
		</div>
	  </div>
	<!-- Modal End -->

   		<!-- Modal 3 start   -->

	<!--  -<div id="confirmedUpdatedMessage" class="modal">
		<h6 class="modal-header"><spring:message code="registration.updatemessagemanagement" /></h6>
		<div class="modal-content">



			<div class="row">
				<h6 id="sucessMessage"><spring:message code="registration.messageupdatedsuccessfully" /></h6>
			</div>
			<div class="row">
				<div class="input-field col s12 center">
					<a href="${context}/messageManagement" class="btn"><spring:message code="modal.ok" /></a>
				</div>
			</div>
		</div>
	</div> -->
	<div id="confirmedUpdatedMessage" class="modal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg" role="document">
			  <div class="modal-content">

					<h5 class="modal-header"><spring:message code="registration.updatemessagemanagement" /></h5>
				<div class="modal-body">
				  <p id="sucessMessage"><spring:message code="registration.messageupdatedsuccessfully" /></p>
				</div>
				<div class="modal-footer">
					<a href="${context}/messageManagement" class="cancel-product btn modal-close"><spring:message code="modal.ok" /></a>
				</div>
			  </div>
			</div>
		  </div>

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
		src="${context}/resources/project_js/dragableModal.js"></script>

	<script type="text/javascript"
		src="${context}/resources/project_js/viewMessageManagement.js?version=<%= (int) (Math.random() * 10) %>"></script>
	<script type="text/javascript"
		src="${context}/resources/project_js/_dateFunction.js?version=<%= (int) (Math.random() * 10) %>" async></script>
		<script type="text/javascript"
		src="" async></script>
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
