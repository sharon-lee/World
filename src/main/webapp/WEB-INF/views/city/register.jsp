<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<!-- Error는 Spring의 Custom tag 써야 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register.jsp</title>
</head>
<body>
<h1>CityCommand</h1>

<!-- @ModelAttribute("city")로 하면 cityCommand는 city로 맵핑  -->
<form:form commandName="city">
<ul>
	<li>${city.name} <form:errors path="name" cssStyle="color:red;"/></li>
	<li>${city.countryCode} <form:errors path="countryCode" cssStyle="color:red;"/></li>
	<li>${city.district} <form:errors path="district" cssStyle="color:red;"/></li>
	<li>${city.population} <form:errors path="population" cssStyle="color:red;"/> </li>
</ul>
</form:form>
</body>
</html>