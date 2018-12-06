<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.LogonDBBeanTheater"%>
<%@ page import="login.LogonDBBeanMovie"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="theater" class="login.LogonDataBeanTheater">
	<jsp:setProperty name="theater" property="*" />
</jsp:useBean>
<jsp:useBean id="movie" class="login.LogonDataBeanMovie">
	<jsp:setProperty name="movie" property="*" />
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String name = request.getParameter("tName");
	LogonDBBeanTheater logon = LogonDBBeanTheater.getInstance();
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상영관 등록</title>
</head>
<body>
	<h2>상영관 등록</h2>
	<form method="post" action="insertScreenPro.jsp">
			영화관 이름 : <input type="text" name="tName" value="<%=name%>" readonly>
			<br /> 
			상영관 이름 : <input type="text" name="sName" maxlength="30" required><br />
			좌석행 : <input type="number" name="row" maxlength="10" required><br />
			좌석열: <input type="number" name="column" maxlength="10" required><br />
		<input type="submit" id="insertScreen" value="상영관 등록하기">
	</form>
</body>
</html>