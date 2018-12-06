<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="login.LogonDBBeanScreen"%>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="movie" class="login.LogonDataBeanScreen">
       <jsp:setProperty name="movie" property="*"/>
    </jsp:useBean>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>상영관선택</title>
</head>
<body>

   <h2>상영관 선택 페이지</h2>
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
      
   }%>
   <input type="button" value="메인 페이지로 이동" onclick="main()">
	<script type="text/javascript">
    function main(){
    	location.href="cookieMainMember.jsp?";
    }
    </script>
   
   <br/>
   <br/>

   <%
  	 request.setCharacterEncoding("utf-8");
  	String id = request.getParameter("id");
  	String theater_name = request.getParameter("theater");
  	String date = request.getParameter("date");
  	System.out.println(theater_name);
  	LogonDBBeanScreen logon = LogonDBBeanScreen.getInstance();
    String[][] Info = logon.getInfoAll(id,theater_name);
      Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "thdud5313";
     
      %>
   
   <form method="post" action = "timeSelectForm.jsp">
   <table id="insertTable" border="1" style="border-collapse:collapse">
      <tr>
         <th width=50></th>
         <th width=100>상영관 이름</th>
         <th width=150>영화 아이디</th>
      </tr>
      <% 
      int size = 0;
      if(Info==null){  
      
      %>
      <tr>
         <td colspan="3">현재 해당 영화가 등록된 상영관이 없습니다.</td>
      </tr>
      <%
         } else {
               for (int i = 0; i<Info.length; i++) {
            	  String screen_id = Info[i][0];
            	  String screen_name = Info[i][1];
         
      %>
      <tr>
         <td><input type="radio" name="screen" value="<%=screen_id%>"></td>
         <td><%=screen_name%></td>
         <td><%=id%></td>
      </tr>
      
      <%
               }
         }
      %>
        
         </table>
   	<input type="hidden" name = "id" value="<%=id%>">
         <input type="hidden" name = "date"value="<%=date%>">
       
      <input type="submit" value = "상영관선택">
   </form>
   
</body>
</html>