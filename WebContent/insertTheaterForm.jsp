<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화관 추가</title>
</head>
<body>

<h2>영화관 추가</h2>
	<form method="post" action="insertTheaterPro.jsp">
		영화관 이름 : <input type="text" name="mName" maxlength="30" required><br /> 
		영화관 주소 : <input type="text" name="mAddress" maxlength="100" required><br />
		영화관 전화번호 : <input type="text" name="mTelephone" maxlength="30" required><br />
		<input type="submit" value="영화관 추가">
		<input type="reset" value="다시입력">
	</form>
</body>
</html>