<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
   request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VIP관리</title>
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
   %>

   <h2>VIP관리 페이지</h2>

   <input type="button" value="메인 페이지로 이동" onclick="main()">
   <script type="text/javascript">
      function main() {
         location.href = "cookieMain.jsp";
      }
   </script>

   <br />
   <br />

   <%
      final HashMap map = new HashMap();
   Calendar oCalendar = Calendar.getInstance();
    int nowYear =oCalendar.get(Calendar.YEAR);
    
      Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "thdud5313";

      int total = 0;
      try {

         Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         Statement stmt1 = conn.createStatement();
         String countSql = "select count(*) from 결제";
         ResultSet rs1 = stmt1.executeQuery(countSql);
         int ticket_count = 0;
         while (rs1.next()) {
            ticket_count = Integer.parseInt(rs1.getString(1));
         }
         Statement stmt2 = conn.createStatement();
         String Sql = "select * from 결제";
         String paycode = null;
         ResultSet rs = stmt2.executeQuery(Sql);
         while (rs.next()) {
            Statement stmt3 = conn.createStatement();
            Statement stmt5 = conn.createStatement();
            String sql2 = "select * from 결제 where 회원아이디='"+rs.getString(2)+"'";
            rs.getString(1);
            ResultSet rs5 = stmt5.executeQuery(sql2);
            int i_temp = 0;
               while(rs5.next()){
                  String date = rs5.getString(1).split("=")[2];   
                  if(date.contains(String.valueOf(nowYear))){
                     i_temp++;
                  }
               
               String temp = String.valueOf(i_temp);
               map.put(rs.getString(2), temp);
            }
         }
         Statement stmt4 = conn.createStatement();
         String coSql = "select count(*) from 회원";
         ResultSet rs4 = stmt1.executeQuery(coSql);
         int member_count = 0;
         while (rs4.next()) {
            member_count = Integer.parseInt(rs4.getString(1));
         }
   %>
   <table id="Table" border="1" style="border-collapse: collapse">
      <tr>
         <th width=50></th>
         <th width=100>회원아이디</th>
      </tr>

      <%
         List list = new ArrayList();
            list.addAll(map.keySet());
            Collections.sort(list, new Comparator() {
               public int compare(Object o1, Object o2) {
                  Object v1 = map.get(o1);
                  Object v2 = map.get(o2);
                  return ((Comparable) v2).compareTo(v1);
               }
            });
            
            for (int i = 0; i < 10 && i<list.size(); i++) {
               PreparedStatement pstmt = conn.prepareStatement("update 회원 set 회원등급 = ? where 회원아이디=?");
               String key = (String)list.get(i);
               
               pstmt.setString(1, "VIP");
               pstmt.setString(2, key);
               pstmt.executeUpdate();
            %>


      <tr>
         <td><%=i + 1%></td>
         <td><%= key %></td>
      </tr>
      <%
         }
      %>
   </table>
   <%

   rs1.close();
   stmt1.close();
   rs.close();
   stmt2.close();
   rs4.close();
   stmt4.close();
   conn.close();
      } catch (SQLException e) {
         out.println(e.toString());
      }
   %>

</body>
</html>