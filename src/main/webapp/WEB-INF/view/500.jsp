<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!-- Security Tags -->
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:csrfMetaTags />
<!-- Security Tags -->
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<c:set var="context" value="${pageContext.request.contextPath}" />
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Internal Server Error</title>
	<link rel="stylesheet" href="${context}/resources/assets/css/500.css">
</head>
<body>
    <div class="container">
        <h1><spring:message code="500error.title" /></h1>
        <p><spring:message code="500error.section1" /></p>
        <p><spring:message code="500error.section2" /></p>
    </div>
</body>
</html>