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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>영화관리</title>
</head>
<body>

   <h2>영화 차트 보기</h2>
   <input type="button" value="메인으로 돌아가기" onclick="location.href='cookieMainMember.jsp?'">

   <br />
   <br />


   <%
      Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "Lovedkwjd23@";
      int total = 0;
      try {
         Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         Statement stmt = conn.createStatement();
         String totalSql = "select count(*) from 영화 ORDER BY 예매율 DESC";
         ResultSet rs = stmt.executeQuery(totalSql);
		 rs.first();
         total = rs.getInt(1);
		System.out.println(total);
         String listSql = "select * from 영화 ORDER BY 예매율 DESC";
         rs = stmt.executeQuery(listSql);
   %>
   <form name="testform" method="post">
      <table id="insertTable" border="1" style="border-collapse: collapse">
         <tr>
            <th width=50>순위</th>
            <th width=100>영화아이디</th>
            <th width=100>영화제목</th>
            <th width=100>감독</th>
            <th width=100>출연</th>
            <th width=100>등급</th>
            <th width=100>주요정보</th>
            <th width=100>예매율</th>
         </tr>
         <%
            int size = 0;
               if (total == 0) {
         %>
         <tr>
            <td colspan="8">현재 영화가 없습니다.</td>
         </tr>
         <%
            } else {
                  while (rs.next()) {
                     String id = rs.getString(1);
                     String title = rs.getString(2);
                     String director = rs.getString(3);
                     String actor = rs.getString(4);
                     int rate = rs.getInt(5);
                     String info = rs.getString(6);
                     float reservation = rs.getFloat(7);
                     String start = rs.getString(8);
                     String end = rs.getString(9);
                     Calendar oCalendar = Calendar.getInstance(); // 현재 날짜/시간 등의 각종 정보 얻기
                     String str_startYear = String.valueOf(start.charAt(0)) + String.valueOf(start.charAt(1))
                           + String.valueOf(start.charAt(2)) + String.valueOf(start.charAt(3));
                     String str_startDate = String.valueOf(start.charAt(4)) + String.valueOf(start.charAt(5))
                           + String.valueOf(start.charAt(6)) + String.valueOf(start.charAt(7));
                     String str_endYear = String.valueOf(end.charAt(0)) + String.valueOf(end.charAt(1))
                           + String.valueOf(end.charAt(2)) + String.valueOf(end.charAt(3));
                     String str_endDate = String.valueOf(end.charAt(4)) + String.valueOf(end.charAt(5))
                           + String.valueOf(end.charAt(6)) + String.valueOf(end.charAt(7));
                     int startYear = Integer.valueOf(str_startYear);
                     int endYear = Integer.valueOf(str_endYear);
                     int startDate = Integer.valueOf(str_startDate);
                     int endDate = Integer.valueOf(str_endDate);
                     int nowYear = oCalendar.get(Calendar.YEAR);
                     System.out.println(nowYear);
                     String day = String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH));
                     if(String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)).length()==1){
                        day = "0"+day;
                     }
                     String str_nowDate = String.valueOf(oCalendar.get(Calendar.MONTH) + 1) + day;
                     int nowDate = Integer.valueOf(str_nowDate);

                     if (startYear - nowYear == 0) {
                        //여기에 테이블 넣어!!!
                        if (nowDate - startDate >= 0) {
                           if (endDate - nowDate >= 0) {
                              if (reservation >= 0.0) {

                                 size++;
                                 System.out.println(size);
         %>
         <tr>
            <td><%=size %></td>
            <td><%=id%></td>
            <td><%=title%></td>
            <td><%=director%></td>
            <td><%=actor%></td>
            <td><%=rate%></td>
            <td><%=info%></td>
            <td><%=reservation%></td>
         </tr>
         <%
                              }
                           }
                        }
                     } else if (startYear - nowYear < 0) {
                        if (endDate - nowDate >= 0) {
                           if (reservation >= 0.0) {
         %>
         <tr>

            <td><%=size+1 %></td>
            <td><%=id%></td>
            <td><%=title%></td>
            <td><%=director%></td>
            <td><%=actor%></td>
            <td><%=rate%></td>
            <td><%=info%></td>
            <td><%=reservation%></td>
         </tr>
         <%
            size++;
                           }
                        }
                     }

                  }
               }
               if (size == 0) {
         %>
         <tr>
            <td colspan="8">현재 영화가 없습니다.</td>
         </tr>
         <%
            }
               rs.close();
               conn.close();
               stmt.close();
            } catch (SQLException e) {
               out.println(e.toString());
            }
         %>

      </table>
   </form>

</body>
</html>