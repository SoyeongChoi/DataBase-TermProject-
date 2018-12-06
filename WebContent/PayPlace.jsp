<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>결제</title>
</head>
<body>
	<h2>결제페이지</h2>
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
	<input type="button" value="메인으로 돌아가기" onclick="main()">
	<script type="text/javascript">
		function main() {
			location.href = "cookieMainManager.jsp";
		}
	</script>
	
	<%
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "thdud5313";

		// getParameter()를 이용해 넘겨진 파라미터 값을 얻어올 수 있다.
		// 파라미터 값을 얻을때 name= 에 지정해둔 값과 동일한 값을 인자로 지정해야 된다.
		String reservation = request.getParameter("reservation");//이건 예약페이지에서 결제로 오는거

		String reservList[] = request.getParameterValues("selectedItems");
		System.out.println(reservList.length);
		int total = 0;
		try {
	%>
	<br />
	<br />
	<br />
	<h3>결제내역리스트</h3>
	<br />
	<br />
	
	<form method="post" action="PayPlacePro.jsp">
	<table id="insertTable" border="1" style="border-collapse: collapse">
		<tr>
			<th width=100>영화제목</th>
			<th width=100>감독</th>
			<th width=100>주요정보</th>
			<th width=100>영화관</th>
			<th width=100>상영관</th>
			<th width=100>좌석</th>
		</tr>
		<%
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
				int size = 0;
				String UserId = "";
				while (size < reservList.length) {
					//첫번째 쿼리
					Statement stmt = conn.createStatement();
					String totalSql = "select * from 예약 where 예약코드=" + "'" + reservList[size] + "'";
					System.out.println(totalSql);
					ResultSet rs = stmt.executeQuery(totalSql);
					rs.first();
					String reservationCode = rs.getString(1);
					
					UserId = rs.getString(2);
					String SeatCode = rs.getString(3);
					String ScheduleCode = rs.getString(4);
					String[] seat = SeatCode.split("@");
					String ScreenId = rs.getString(5);
					//두번째 쿼리
					Statement stmt2 = conn.createStatement();
					String ScreenSql = "select 영화아이디, 영화관이름, 상영관이름 from 상영관 where 상영관아이디=" + "'" + ScreenId + "'";
					System.out.println(ScreenSql);
					ResultSet rs2 = stmt2.executeQuery(ScreenSql);
					rs2.first();
					String MovieId = rs2.getString(1);
					String TheaterName = rs2.getString(2);
					String ScreenName = rs2.getString(3);
					//세번째 쿼리
					Statement stmt3 = conn.createStatement();
					String MovieSql = "select 영화제목, 감독, 주요정보 from 영화 where 영화아이디="+"'" + MovieId+"'";
					ResultSet rs3 = stmt3.executeQuery(MovieSql);
					rs3.first();
					String MovieName = rs3.getString(1);
					String director = rs3.getString(2);
					String Info = rs3.getString(3);

					size++;
				
				%>
		<tr>
			<td><%=MovieName%></td>
			<td><%=director%></td>
			<td><%=Info%></td>
			<td><%=TheaterName%></td>
			<td><%=ScreenName%></td>
			<td><%=seat[0] + "행" + seat[1] + "열"%>
			<input type="hidden" name="reservation" value="<%=reservationCode %>">
			</td>		
		</tr>
				<%
				}
				Statement stmt2 = conn.createStatement();
				String UserSql = "select point from 회원 where 회원아이디=" + "'" + UserId + "'";
				System.out.println(UserSql);
				ResultSet rs2 = stmt2.executeQuery(UserSql);
				rs2.first();
				int point = Integer.valueOf(rs2.getString(1));
				int ticket = 10000 * reservList.length;
		%>

	</table>
	<br /> 현재 가용 포인트 내역 :<%=point%>
	<br />
	<br /> 티켓 가격 :
	<%=ticket%>
	원

	<br />
	<br />
	<input type ="button" onclick="input()" value="포인트 사용하기">

	<script type="text/javascript">
		var total;
		var using;
		function input() {
			var input = document.getElementById("usingPoint").value;
			if (
	<%=point%>
		> 1000) {
				if (input <=
	<%=point%>
		) {

					if (input >= 0) {
						temp = input;
						var origin = 10000;
						total = origin - input;
						using =
	<%=point%>
		- input;
						document.getElementById("output").value = total;
					}
				} else {
					alert("가용 포인트 이내 값만 입력할 수 있습니다.");
				}
			} else {
				alert("point가 1000점 이상만 사용가능");
			}

		}
	</script>

	
		총 결제할 영화 수 : <input type="hidden"
			name="totalTicket" value="<%=ticket/10000 %>" />
		 	
			<br/>
		포인트 차감: <input type="number" id="usingPoint" name="usingPoint" min="0"
			max="<%=point%>"> <br /> <br> 총 결제 가격 : <input
			type="text" id="output" name="output" value=<%=ticket %> readonly>
		<input type="submit" value="결제하기" />
	</form>
	<br>
	<br>
	<br>
	<!-- 아래부터 자바스크립트 -->
	<%
		
	%>
	<%
		conn.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>


</body>
</html>