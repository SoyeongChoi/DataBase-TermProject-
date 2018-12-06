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
   
	<h2>예약 내역 확인</h2>
	<input type="submit" value="메인으로 돌아가기" onclick="main()">
	<script type="text/javascript">
		function main() {
			location.href = "cookieMainMember.jsp";
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
        String id = member_id;
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
	
		<form name="testform" method="post">
		
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
				<td colspan="8">현재 예매한 내역이 없습니다.</td>
			</tr>
			<%
					}else{
		                  while (rs.next()) {
							String reservationCode = rs.getString(1);
							//reservationCode = 예약일+좌석행+좌석열+상영관아이디(=영화관이름+상영관이름)+상영일정코드
							String reservCode[] = reservationCode.split("@");
							String UserId = rs.getString(2);
							String SeatCode = rs.getString(3);
							String ScreenScheduleCode = rs.getString(4);
							String Schedule[] = ScreenScheduleCode.split("@");
							String startTime = Schedule[0];
							String endTime = Schedule[1];
							String screenDay = Schedule[2];
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
							if(startTime.length()==3){
								startTime="0"+startTime.substring(0,1);
							}
							else{
								startTime=startTime.substring(0,2);
							}
							if(endTime.length()==3){
								endTime="0"+endTime.substring(0,1);
							}
							else{
								endTime=endTime.substring(0,2);
							}
							 %>
				
					         <tr>
					            <td><input type="hidden" name="movieName" value="<%=MovieName%>"><%=MovieName%></td>
					            <td><%=TheaterName%></td>
					            <td><%=ScreenName%></td>
					            <td><%=reservCode[0].substring(0,4)+"."+reservCode[0].substring(4,6)+"."+reservCode[0].substring(6,8)%></td>
					            <td><%=reservCode[1]+"행"+reservCode[2]+"열"%></td>
					            <td><%=screenDay.substring(0,4)+"."+screenDay.substring(4,6)+"."+screenDay.substring(6,8)+"\n"+startTime+":00"+"~"+ endTime+":00" %></td>
					            <td>
					            	<input type = "checkbox" name = "selectedItems" value = "<%=reservationCode%>" onclick="checkBox()"/>
					            </td>
					            <td>
					            	<input type="hidden" name="reservationCode" value ="<%=reservationCode%>"/>
					            	<input type="submit" onclick="cancelRsv()" value="예약취소">
					           	</td>
					         </tr>
					         
					         <%} %>
					         </table>
					         <input type="button" value="결제하기" onclick="submitfuc(2)" disabled id="doPay"/>
					         </form>
					         
							<script type="text/javascript">
								function cancelRsv(){
									if (confirm("정말 예약을 취소하시겠습니까?")){ //확인
										document.testform.action="cancelReservation.jsp?id=<%=id%>";
										document.testform.submit();
									}
									else{ 
										return;
									}
								}
							</script>
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
					               document.testform.action="PayReservation.jsp?id=<%=id%>";
					            }            
					            
					            document.testform.submit();
					         }
					         
					         function checkBox(){
					        	 var checked = document.getElementsByName("selectedItems");
					        	 var ln = 0;
						     	 for(var i=0; i< checked.length; i++) {
						     		   if(checked[i].checked == true && checked[i].disabled == false){
						     		        ln++
						     		    }
						     	}
					        	 if(ln>0){
					        		 document.getElementById("doPay").disabled=false;
					        	 }
					        	 else{
					        		 document.getElementById("doPay").disabled=true;
					        	 }
					         }
					      </script>
		
					         <%
					}
					rs.close();
					conn.close();
					stmt.close();
				} catch (SQLException e) {
					out.println(e.toString());
				}
			%>
		
</body>
</html>