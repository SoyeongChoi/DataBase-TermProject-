<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.Calendar"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약내역 확인</title>
</head>
<body>
	<h2>예약 내역 확인</h2>
	<input type="button" value="메인으로 돌아가기" onclick="main()">
	<script type="text/javascript">
		function main() {
			location.href = "cookieMain.jsp";
		}
	</script>
	<br />
	<br />
	<%
	
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "thdud5313";
	    
        // getParameter()를 이용해 넘겨진 파라미터 값을 얻어올 수 있다.
        // 파라미터 값을 얻을때 name= 에 지정해둔 값과 동일한 값을 인자로 지정해야 된다.
        String id = request.getParameter("id");
		int total = 0;
		try {
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			Statement stmt = conn.createStatement();
			String totalSql = "select * from 예약 where 회원아이디="+"'"+id+"'";
			ResultSet rs = stmt.executeQuery(totalSql);
			if (rs.next()) {
				total += 1;
			}

			String listSql = "select * from 예약 where 회원아이디="+"'"+id+"'" ;
			rs = stmt.executeQuery(listSql);
	%>
	 <form name = "testform" method="post">
		<table id="insertTable" border="1" style="border-collapse: collapse">
			<tr>
				<th width=100>영화제목</th>
				<th width=100>영화관</th>
				<th width=100>상영관</th>
				<th width=100>예매날짜</th>
				<th width=100>좌석</th>
				<th width=100>상영일정</th>
				<th width=80>결제</th>
				<th width=80>예약취소</th>
			</tr>
			<%
				//예매날짜는 내가 선택한 날짜고 결제날짜는 현재날짜임 !!!!! 중요중요%%%%%%%%%%%%%%%%

					if (total == 0) {
			%>
			<tr>
				<td colspan="7">현재 예매한 내역이 없습니다.</td>
			</tr>
			<%
					}else{
		                  while (rs.next()) {
							String reservationCode = rs.getString(1);
							//reservationCode = 예약일+좌석행+좌석열+상영관아이디(=영화관이름+상영관이름)+상영일정코드
							String reservCode[] = reservationCode.split("&");
							String UserId = rs.getString(2);
							String SeatCode = rs.getString(3);
							String ScreenScheduleCode = rs.getString(4);
							String Schedule[] = ScreenScheduleCode.split("&");
							String startTime = Schedule[0];
							String endTime = Schedule[1];
							String ScreenId = rs.getString(5);
							Statement stmt2 = conn.createStatement();
							String ScreenSql = "select 영화아이디, 영화관이름, 상영관이름 from 상영관 where 상영관아이디="+"'"+ScreenId+"'";
							ResultSet rs2 = stmt2.executeQuery(ScreenSql);
							rs2.first();
							String TheaterName = rs2.getString(2);
							String ScreenName = rs2.getString(3);
							Statement stmt3 = conn.createStatement();
							String MovieSql = "select 영화제목 from 영화 where 영화아이디="+"'"+rs2.getString(1)+"'";
							ResultSet rs3 = stmt3.executeQuery(ScreenSql);
							rs3.first();
							String MovieName = rs3.getString(1);
							 %>
					         <tr>
					            <td><%=MovieName %></td>
					            <td><%=TheaterName%></td>
					            <td><%=ScreenName%></td>
					            <td><%=reservCode[0]%></td>
					            <td><%=reservCode[1]+"행"+reservCode[2]+"열"%></td>
					            <td><%=startTime +"~"+endTime %></td>
					            <td>
					        	    <input type = "checkbox" name = "selectedItems" value = "<%=reservationCode%>"/>
					            </td>
					            <td><input type="button" onclick="delete_ticket()" value ="<%=reservationCode%>"></td>
					         </tr>
					         <%
					         System.out.println(reservationCode);
		                }
					}
					rs.close();
					conn.close();
					stmt.close();
				} catch (SQLException e) {
					out.println(e.toString());
				}
			%>
			</table>
		<input type="button" value="결제하기" onclick="submitfuc(2)"/>
	</form>
		
		
		<script type="text/javascript">
			function submitfuc(index){	
				if(index==2){
					var checkbox = document.getElementsByName("selectedItems");
					var size = document.getElementsByName("selectedItems").length;
					var check_size = 0;
					for(var i = 0; i < size; i++){
						if(checkbox[i].checked == true){
							check_size++;
						}
					}
					var SelectCheck = [];
					SelectCheck.length = check_size;
					for(var i = 0; i < size; i++){
						if(checkbox[i].checked == true){
							SelectCheck[i] = checkbox[i].value;
						}
					}
					document.testform.action="PayReservation.jsp";
				}				
				
				document.testform.submit();
			}
			
		</script>
		
		
</body>
</html>