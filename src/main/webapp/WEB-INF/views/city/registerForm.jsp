<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!-- Bootstrap:CSS Framework -->
<!-- Error는 Spring의 Custom tag 써야 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerForm.jsp</title>
<%@ include file="/WEB-INF/views/common.jspf"%>
<style type="text/css">
	.form-center {
		border: 1px solid red;
		border-radius: 10px;
		width: 400px;	
		padding: 10px; /* 나 기준으로 Child사이와의 거리 */
 		margin-left: 50px; 
/* 		margin: auto;	/*나 기준으로 부모사이와의 거리 */ */
	}
	
	/* box class 정의 */
	.box {
		width: 100px;
		height: 100px;
		border-radius: 10px;
		background-color: orange;
	}
</style>


</head>
<body>

<!-- 다국어 처리 위해 하드코딩말고 spring custom tag의 message를 써서 property에서 읽어서 값 출력 -->
<h1><spring:message code="city.register.title" arguments="[World]"/></h1>

<!-- HTML Form Tag - Error 처리를 쉽게 form이 부모역할 -->
<form:form commandName="city" action="register" method="post" cssClass="form-center">

	<!-- Global Error 출력:commandName에 error가 있으면 error출력 -->
	<div class="text-danger text-center">
	<%-- <form:errors cssStyle="color:red;"/> --%>
	<form:errors/>
	</div>

	<!-- city.name:block level부모의 width전체를 차지 -->
	<div class="form-group">
		<label for="name"><spring:message code="city.name"/></label>
		<form:input path="name" cssClass="form-control"/>
		<form:errors path="name" cssClass="text-primary bg-danger"/>
	</div>

	<!-- city.countryCode Map가정에서 List로 -->
	<!-- custom form option tag에 의해 option이 만들어짐. -->
	<!--  request영역객체에 있는 countryCode Bean에 value<-code, label<-name을 넣어서 생성 -->
	<!-- jQuery AJAX는 현재 Page를 Dynamic하게 변경 처리 - HTML정적문서를 Application화 하려면 JavaScript요소 ChangeEvent를 설정,  -->
	<!-- 서버에 있는 Data를 가져와서 getDistricts()를 호출 form option으로 넣도록  -->
	<div class="form-group">
		<label for="countryCode"><spring:message code="city.countryCode"/></label>
<%-- 		<form:input path="countryCode" cssClass="form-control"/> --%>
		<form:select path="countryCode"  cssClass="form-control">
			<form:option value="">-- 선택하세요 --</form:option>
			<form:options items="${countryCode}" itemValue="code" itemLabel="name"/> 
		</form:select>
		<form:errors path="countryCode" cssClass="text-primary bg-danger"/>
	</div>
	
	<!-- city.district -->
	<div class="form-group">
		<label for="district"><spring:message code="city.district"/></label>
		<%-- <form:input path="district" cssClass="form-control"/> --%>
		<form:select path="district"  cssClass="form-control">
			<form:option value="">-- 선택하세요 --</form:option>			 
			<form:options items="${districts}"/>
		</form:select>
		<form:errors path="district" cssClass="text-primary bg-danger"/>
	</div>
	<%-- <form:options items="${district}" itemValue="code" itemLabel="value"/> --%>
	<!-- bean list인 경우 itemValue, itemLabel 명시해야, dynamic list는 Ajax를 써야 -->

	<!-- city.population -->
	<div class="form-group">
		<label for="population"><spring:message code="city.population"/></label>
		<form:input path="population" cssClass="form-control"/> 
		<%-- <form:errors path="population" cssStyle="color:red;"/> --%>
		<form:errors path="population" cssClass="text-primary bg-danger"/>
	</div>
	<!-- form:errors path에 error가 있으면 properties에서 error message를 읽어서 출력 -->

<!-- input path에 property value만 주면 id,name,type,value를 다 채워줌 -->
<!-- Submit -->
<input class="btn btn-primary" type="submit" value="도시추가"/>

<!-- Error 처리는 Form tag에서  -->
</form:form>

<!-- jstl사용해서 box -->
<c:forEach var="i" begin="0" end="10">
	<div class="box"><strong>${i}</strong></div>

</c:forEach>

<!-- library 사용:jquery-ui 함수method .form-center 객체 return -->
<script type="text/javascript">
	/*jQuery() = $('.form-center').draggable();
	jQuery() = $('.box').draggable(); */
	var form = jQuery('.form-center'); //jQuery 객체가 .form-center를 담아 form에 return-Method Chain 방식
	form.draggable();
	
	form.mousedown(function() {
		console.log("form.mousedown() event called...");
		$(this).css('box-shadow', '20px 20px 10px orange')
	});	
	
	form.mouseup(function() {
		console.log("form.mouseup() event called...");
		$(this).css('box-shadow', '')
	});
	
	$('.box').draggable();
	//먼저 id를 #으로 지칭해서 객체의 ref를 가져와 객체를 return, Class지칭은 .dot를 사용 changeEvent()를 설정/달고 
	//Listener anonymous function를 달아
	jQuery('#countryCode').change(function() {
		//alert("change event called... value = " + $(this).val());
		var countryCode = $(this).val();
		console.log("change event called... value = " + countryCode);//값에 해당하는 District를 가져오도록
		
		//AJax를 써서 Server에 요청,요청이 완료될때 함수에 데이타 parameter로, status-Error Code, Client Error-400,Server Error-500 
		//jQuery의 전역함수 $.get()
		//AJax (Asynchronous javascript and xml)
		$.get('district/' + countryCode, function(data, status) { //url-상대경로, 조회성 GET방식
			console.log("data = " + data + "\n" + "status = " + status);
			$('#district').html(data);	//distrcit라는 form option을 찾아서 html에 집어넣음		
		});
		
	});  
 	/* jQuery() = $(), alert=toast, console.log = lo4j */
 	
 	//$('xxx').
</script>
<!-- form:select path="countryCode"의 id로 객체 ref를 jQuery(Cross Browser문제해결)로 찾아와 변경 Event를 받아 처리 -->

</body>
</html>