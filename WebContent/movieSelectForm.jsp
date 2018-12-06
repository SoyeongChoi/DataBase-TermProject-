<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="login.LogonDBBeanMovie"%>
    <%@ page import="java.util.Calendar" %>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="movie" class="login.LogonDataBeanMovie">
       <jsp:setProperty name="movie" property="*"/>
    </jsp:useBean>
    
    <%
    LogonDBBeanMovie logon = LogonDBBeanMovie.getInstance();
   String[][] Info = logon.getInfoAll();
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
    %>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>영화선택</title>
</head>
<body>

   <h2>영화 선택 페이지</h2>

   <input type="button" value="메인으로 돌아가기" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="cookieMainMember.jsp?";
    }
    </script>
   
   <br/>
   <br/>

   <%
      Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "thdud5313";
      int total = 0;
      try {
         Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         Statement stmt = conn.createStatement();
         String totalSql = "select * from 영화";
         ResultSet rs = stmt.executeQuery(totalSql);

         if (rs.next()) {
            total += 1;
         }

         String listSql = "select * from 영화";
         rs = stmt.executeQuery(listSql);
   %>
   
   <form method="post" action = "dateSelectForm.jsp">
   <table id="insertTable" border="1" style="border-collapse:collapse">
      <tr>
         <th width=50></th>
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
         <td>현재 등록된 영화가 없습니다.</td>
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
                  System.out.println(str_startYear);
                  int startYear = Integer.parseInt(str_startYear);
                  int endYear = Integer.parseInt(str_endYear);
                  int startDate = Integer.parseInt(str_startDate);
                  int endDate = Integer.parseInt(str_endDate);
                  int nowYear =oCalendar.get(Calendar.YEAR);
                  String day = String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH));
                  if(String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)).length()==1){
                 	 day = "0"+day;
                  }
                  String str_nowDate = String.valueOf(oCalendar.get(Calendar.MONTH) + 1) + day;
                  int nowDate = Integer.parseInt(str_nowDate); 
                 


                  if (startYear - nowYear == 0) {
                     if (nowDate - startDate >= 0) {
                        if (endDate - nowDate >= 0) {

                              size++;
      
      %>
      <tr>
         <td><input type="radio" name="id" value="<%=id%>"></td>
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
                     } else if (startYear - nowYear < 0) {
                        if (endDate - nowDate > 0) {
                     
         %>
       <tr>
			
            <td><input type="radio" name="id" value="<%=id%>"></td>
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
      <input type="submit" value = "영화선택">
   </form>
   
</body>
</html>