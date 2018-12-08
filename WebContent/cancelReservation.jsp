<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>예약취소</title>
</head>
<body>
<%
   String member_id = "";
   try{
      Cookie[] cookies = request.getCookies();
      if(cookies != null){
         for(int i =0; i<cookies.length;i++){
            if(cookies[i].getName().equals("id")){
               member_id = cookies[i].getValue();
            }
         }
         if(member_id.equals("")){
            response.sendRedirect("loginForm.jsp");
         }
      }else{
         response.sendRedirect("loginForm.jsp");
      }
   }catch(Exception e){
      
   }
   System.out.println("member_id"+member_id);
   %>
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String reservationCode= request.getParameter("reservationCode");
	String movieName = request.getParameter("movieName");
%>

<%
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "Lovedkwjd23@";
        
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int total = 0;
		try {
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			System.out.println(reservationCode);
			pstmt = conn.prepareStatement("select * from 예약 where 예약코드= ?");
			pstmt.setString(1,reservationCode);
			rs = pstmt.executeQuery();
			
			String sitCode="";
			String screenSchedule="";
			String screenId="";
			
			if(rs.next()){
				sitCode=rs.getString("좌석코드");
				screenSchedule=rs.getString("상영일정코드");
				screenId=rs.getString("상영관아이디");
			}
			
			pstmt = conn.prepareStatement("delete from 예약 where 예약코드=?");
			pstmt.setString(1,reservationCode);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("set foreign_key_checks=0");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("delete from 좌석 where 좌석코드=? and 상영관아이디=? and 상영일정코드=?");
			pstmt.setString(1,sitCode);
			pstmt.setString(2,screenId);
			pstmt.setString(3,screenSchedule);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("set foreign_key_checks=1");
			pstmt.executeUpdate();
			
			rs.close();
			conn.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
		
%>


	<%=movieName%> 영화취소가 완료되었습니다.
	<br/>
	<form method="post" action='cookieMain.jsp'>
	<input type="submit" value="메인 페이지로 돌아가기"/>
	</form>
</body>
</html>