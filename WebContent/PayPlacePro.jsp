<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="login.LogonDBBeanScreen" %>
<%@ page import="login.LogonDBBeanMovie" %>
<%@ page import="login.LogonDBBeanReservation" %>

<%@ page import="java.util.Calendar"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>결제 완료페이지</title>
</head>
<body>
	<h2>결제가 완료되었습니다.</h2>
	<input type="button" value="메인으로 돌아가기" onclick="main()">
	<script type="text/javascript">
		function main() {
			location.href = "cookieMain.jsp";
		}
	</script>
	<%
		// getParameter()를 이용해 넘겨진 파라미터 값을 얻어올 수 있다.
		// 파라미터 값을 얻을때 name= 에 지정해둔 값과 동일한 값을 인자로 지정해야 된다.
		String UsingPoint = "0";
		if (request.getParameter("usingPoint") != "") {
			UsingPoint = request.getParameter("usingPoint");
		}
		String reservationCode = request.getParameter("reservation");
		boolean first = true;
		String totalTicket = request.getParameter("totalTicket");
		int NumTicket = Integer.valueOf(totalTicket);
		String reservList[] = request.getParameterValues("reservation");
		System.out.println(UsingPoint);
		
		int total = 0;
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "Lovedkwjd23@";
		try {
			for(int i = 0; i <reservList.length;i++){
			 Calendar oCalendar = Calendar.getInstance(); // 현재 날짜/시간 등의 각종 정보 얻기
			 int nowYear = oCalendar.get(Calendar.YEAR);
             System.out.println(nowYear);
             String day = String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH));
             if(String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)).length()==1){
                day = "0"+day;
             }
             String str_nowDate = String.valueOf(nowYear)+ String.valueOf(oCalendar.get(Calendar.MONTH) + 1) + day;
            

			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			Statement stmt = conn.createStatement();
			String totalSql = "select * from 예약 where 예약코드=" + "'" + reservList[i] + "'";
			System.out.println(totalSql);
			ResultSet rs = stmt.executeQuery(totalSql);
			rs.first();
			String UserId = rs.getString(2);
			String SeatCode = rs.getString(3);
			String ScheduleCode = rs.getString(4);
			String ScreenId = rs.getString(5);
			String MovieId = rs.getString(6);
			Statement stmt2 = conn.createStatement();
			String UserSql = "select point from 회원 where 회원아이디=" + "'" + UserId + "'";
			System.out.println(UserSql);
			ResultSet rs2 = stmt2.executeQuery(UserSql);
			rs2.first();
			int point = Integer.valueOf(rs2.getString(1));
			int real_point = 0;
			if(first){
			if(Integer.valueOf(UsingPoint)>=1000){
				real_point = point - Integer.valueOf(UsingPoint) + 100*NumTicket;
			}else{
				real_point = point + 100*NumTicket;
			}
			Statement updateStmt = conn.createStatement();
			PreparedStatement pstmt = conn
					.prepareStatement("update 회원  set point= ? where 회원아이디= ?");
			pstmt.setInt(1, real_point);
			pstmt.setString(2,UserId);
			pstmt.executeUpdate();
				first = false;
			}
			PreparedStatement pstmt2 = conn.prepareStatement("insert into 결제 values(?,?,?,?,?,?,?)");
			pstmt2.setString(1, reservList[i]+"@결제=true@결제일="+str_nowDate);
			pstmt2.setString(2, UserId);
			pstmt2.setString(3, "현장");
			pstmt2.setString(4, SeatCode);
			pstmt2.setString(5, ScheduleCode);
			pstmt2.setString(6, ScreenId);
			pstmt2.setString(7, MovieId);
			PreparedStatement pstmt3 = conn
					.prepareStatement("DELETE FROM 예약 WHERE 예약코드= ?");
			pstmt3.setString(1,reservList[i]);
			pstmt2.executeUpdate();
			pstmt3.executeUpdate();
			String payCode = reservList[i]+"@결제=true@결제일="+str_nowDate;
			String res[] = payCode.split("@");
			String ticketCode = res[0] + "@" + res[1] + "@" + res[2] + "@" + res[3] + "@" + res[4] + "@"
					+ res[5] + "@" + res[6] + "@" + res[7];
			String check = "select * from 티켓 where 티켓예매번호=" + "'" + ticketCode + "'";
			ResultSet rs4 = stmt.executeQuery(totalSql);
			boolean ticket_check = true;
			int ticket_count = 0;

				PreparedStatement pstmt = conn.prepareStatement("insert into 티켓 values (?, ?, ?, ?)");
				pstmt.setString(1, res[0] + "@" + res[1] + "@" + res[2] + "@" + res[3] + "@" + res[4] + "@"
						+ res[5] + "@" + res[6] + "@" + res[7]);
				pstmt.setInt(2, 1);
				pstmt.setString(3, SeatCode);
				pstmt.setString(4, payCode);

				pstmt.executeUpdate();
			
			
			 	HashMap<String, Integer> PayMovie = new HashMap<String, Integer>();
		     	
		     	ResultSet PayMId_RS = null;
		     	String PayM_str = "select 상영관아이디 from 결제";
		     	Statement stmtPayM = conn.createStatement();
		     	PayMId_RS = stmtPayM.executeQuery(PayM_str);
		     	ResultSet temp_rs = null;
		     	Statement temp_stmt = conn.createStatement();
		     	
		     	while(PayMId_RS.next()){
		     		String id = PayMId_RS.getString(1);
		     		String str = "select 영화아이디 from 상영관 where 상영관아이디='"+id+"'";
		     		temp_rs = temp_stmt.executeQuery(str);
		     		temp_rs.first();
		     		if(PayMovie.containsKey(temp_rs.getString(1))){
		     			int temp = PayMovie.get(temp_rs.getString(1));
		     			PayMovie.replace(temp_rs.getString(1), temp, temp+1);
		     		}else{
		     			PayMovie.put(temp_rs.getString(1), 1);
		     		}	
		     	}
		     	
		     	
		     	 LogonDBBeanMovie logon_m = LogonDBBeanMovie.getInstance();
		         
		        
		     	Statement stmt3 = conn.createStatement();
		     	 String s1 = "select count(*) from 결제";
		       	System.out.println(s1);
		       	
		       	ResultSet rr2 = stmt3.executeQuery(s1);
		       	rr2.first();
		      	int totalCount = rr2.getInt(1);
		        
		      	Iterator<String> keys = PayMovie.keySet().iterator();
		      	while(keys.hasNext()){
		      		String movie = keys.next();
		      		float result = (float)PayMovie.get(movie)/(float)totalCount;
		      		logon_m.updateMovie(movie,(float)result*100);
		      	}
		      	
		    
			
				
				
			rs.close();
			conn.close();
			stmt.close();
			}
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>
</body>
</html>