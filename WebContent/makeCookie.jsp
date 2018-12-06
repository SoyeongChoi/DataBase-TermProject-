<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String cookieName = "id";
	Cookie cookie = new Cookie(cookieName, "Soyeong"); //쿠키를 생성
	cookie.setMaxAge(60 * 2); //쿠키의 지속시간을 설정
	response.addCookie(cookie); //쿠키추가
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>쿠키 생성</title>
</head>
<body>
	<h2>쿠키를 생성하는 페이지</h2>
	"<%=cookieName%>"쿠키가 생성되었습니다.
	<br>
	<form method="post" action="useCookie.jsp">
		<input type="submit" value="생성된 쿠키 확인">
	</form>
</body>
</html>
