<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
</head>
<body>

<h2>회원가입</h2>
	<form method="post" action="insertMemberPro.jsp">
		아이디 : <input type="text" name="id" maxlength="30" required><br /> 
		비밀번호 : <input type="password" name="passwd" maxlength="30" required><br />
		성명 : <input type="text" name="name" maxlength="30" required><br /> 
		생년월일 : <input type="number" name="birth" maxlength="10" required value="19970000" onfocus="this.value=''""><br /> 
		주소 : <input type="text" name="address" maxlength="100" required><br />
		전화번호 : <input type="text" name="phoneNum" maxlength="30" required><br />
		<input type="submit" value="회원가입">
		<input type="reset" value="다시입력">
	</form>
</body>
</html>