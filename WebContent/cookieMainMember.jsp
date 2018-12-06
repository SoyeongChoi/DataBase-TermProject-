<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 완료</title>
</head>
<body>
<%
	String id = "";
	try{
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(int i =0; i<cookies.length;i++){
				if(cookies[i].getName().equals("id")){
					id = cookies[i].getValue();
				}
			}
			if(id.equals("")){
				response.sendRedirect("loginForm.jsp");
			}
		}else{
			response.sendRedirect("loginForm.jsp");
		}
	}catch(Exception e){
		
	}
%>
	<b><%=id %></b>님이 로그인하셨습니다.
	<form method="post" action = "cookieLogout.jsp">
		<input type="submit" value = "로그아웃">
	</form>
	<form method="post" action = "lookingMember.jsp?id=<%=id%>">
		<input type="submit" value = "회원정보관리">
	</form>
	<!-- 회원정보수정에서 포인트확인이랑 등급보기 하면될거같음  'readonly' -->
	<form method="post" action = "movieSelectForm.jsp?id=<%=id%>">
      <input type="submit" value = "영화예약하기">
   </form>
	<form method="post" action = "ShowMovieChart.jsp?id=<%=id%>">
      <input type="submit" value = "영화차트보기">
   </form>
	<form method="post" action = "ReservationList.jsp?id=<%=id%>">
      <input type="submit" value = "예약내역보기">
   </form>
	<form method="post" action = "PayList.jsp?id=<%=id%>">
      <input type="submit" value = "결제내역보기">
   </form>
</body>
</html>