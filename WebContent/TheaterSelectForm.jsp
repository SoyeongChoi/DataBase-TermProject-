<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="login.LogonDBBeanTheater"%>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="movie" class="login.LogonDataBeanTheater">
       <jsp:setProperty name="movie" property="*"/>
    </jsp:useBean>
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>영화관선택</title>
</head>
<body>

   <h2>영화관 선택 페이지</h2>

   <input type="button" value="메인 페이지로 이동" onclick="main()">
	<script type="text/javascript">
    function main(){
    	location.href="cookieMainMember.jsp?";
    }
    </script>
   
   <br/>
   <br/>

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
   
  	 request.setCharacterEncoding("utf-8");
  	String id = request.getParameter("id");
  	String date = request.getParameter("date");
      Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "thdud5313";
      int total = 0;
      try {
         Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         Statement stmt = conn.createStatement();
         String totalSql = "select * from 영화관";
         ResultSet rs = stmt.executeQuery(totalSql);

         if (rs.next()) {
            total += 1;
         }

         String listSql = "select * from 영화관";
         rs = stmt.executeQuery(listSql);
   %>
   
   <form method="post" action = "ScreenSelectForm.jsp">
   <table id="insertTable" border="1" style="border-collapse:collapse">
      <tr>
         <th width=50></th>
         <th width=100>영화관 이름</th>
         <th width=300>영화관 주소</th>
         <th width=150>영화관 전화번호</th>
      </tr>
      <%
      int size = 0;
         if (total == 0) {
      %>
      <tr>
         <td colspan="4">현재 등록된 영화관이 없습니다.</td>
      </tr>
      <%
         } else {
               while (rs.next()) {
                  String name = rs.getString(1);
                  String address = rs.getString(2);
                  String tel = rs.getString(3);
                  
               
         
      %>
      <tr>
         <td><input type="radio" name="theater" value="<%=name%>"></td>
         <td><%=name%></td>
         <td><%=address%></td>
         <td><%=tel%></td>
      </tr>
      	<%
            size++;
                           
                        }
                     
               }
               if (size == 0) {
         %>
         <tr>
            <td colspan="4">현재 영화가 없습니다.</td>
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
      
		 <input type="hidden" name = "id" value="<%=id%>">
         <input type="hidden" name = "date"value="<%=date%>">
        
         </table>
   	
      <input type="submit" value = "영화관선택">
   </form>
   
</body>
</html>