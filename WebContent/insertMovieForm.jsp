<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화추가</title>
</head>
<body>

<h2>영화추가</h2>
	<form method="post" action="insertMoviePro.jsp">
		영화제목 : <input type="text" name="mTitle" maxlength="40" required><br />
		감독 : <input type="text" name="mDirector" maxlength="20" required><br /> 
		출연 : <input type="text" name="mActor" maxlength="50" required><br /> 
		등급 : <input type="number" name="mRating" max="20" min="0" maxlength="10" required><br />
		주요정보 : <input type="text" name="mDetail" maxlength="100" required><br />
		시작날짜 : <input type="date" name="mStartDate" required><br />
		종료날짜 : <input type="date" name="mEndDate" required><br />
		<input type="submit" value="등록하기">
	
	</form>
</body>
</html>