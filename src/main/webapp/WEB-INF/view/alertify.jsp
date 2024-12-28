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
    <script>
    var contextpath = "${context}";
    </script>
    <body>
    <!----AlertNotifications---->
    <link rel="stylesheet" href="${context}/resources/assets/css/AlertNotifications.css">
    <link rel="stylesheet" href="${context}/resources/assets/css/AlertNotificationsDefault.css">
    <script src="${context}/resources/assets/js/AlertNotifications.js"></script>
    <!----AlertNotifications close---->
        </html>
        </body>