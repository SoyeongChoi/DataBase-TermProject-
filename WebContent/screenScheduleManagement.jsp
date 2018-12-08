<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="login.LogonDBBeanScreenSchedule"%>
    <%@ page import="login.LogonDBBeanScreenSchedule"%>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="schedule" class="login.LogonDataBeanScreenSchedule">
       <jsp:setProperty name="schedule" property="*"/>
    </jsp:useBean>
    
    <%
    String sId = request.getParameter("sId");
    
    LogonDBBeanScreenSchedule logon = LogonDBBeanScreenSchedule.getInstance();
   String[][] Info = logon.getInfoAll(sId);
   Class.forName("com.mysql.jdbc.Driver");
   String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
   String dbId = "root";
   String dbPass = "Lovedkwjd23@";
   int total = 0;
   Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
   Statement stmt = conn.createStatement();
   String totalSql = "select 영화아이디 from 상영관 where 상영관아이디='"+sId+"'";
   ResultSet rs = stmt.executeQuery(totalSql);
   rs.first();
   String checking = rs.getString(1);
   if(checking == null){
      
      %>
      <script>
         alert("선택한 영화가 없습니다.");
         history.go(-1);
      </script>
      
      <%
   }
   
   
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>상영일정 관리</title>
</head>
<body>

   <h2><%=sId%>의 상영일정 관리 페이지</h2>

   <form method="post" action="screenManagement.jsp">
      <input type="hidden" name="tName" value="<%=sId.split("@")[0]%>"/>
      <input type="submit" value="상영관 목록으로 돌아가기">
   </form>
   
   <form method="post" action="insertScreenSchedule.jsp">
      <input type="hidden" name="sId" value="<%=sId%>"/>
      <input type="submit" value="상영일정 추가"/>
   </form>
   
   <br/>
   <br/>
   
   <table id="insertTable" border="1" style="border-collapse:collapse">
      <tr>
         <th width=200>상영 일정 코드</th>
         <th width=100>시작 시간</th>
         <th width=100>종료 시간</th>
         <th width=150>상영관 아이디</th>
      </tr>
   </table>
   
   <script type="text/javascript">
   var mtable = document.getElementById("insertTable");
   <%
   int i=0;
   while(i<Info.length){
      String scheduleCode=Info[i][0];
      String sTime = Info[i][1];
      String eTime = Info[i][2];
   %>
   var tr = document.createElement("tr");
   
   var td0 = document.createElement("td");
   td0.setAttribute("width", "100");
   td0.innerText = "<%=scheduleCode%>";
   
   var td1 = document.createElement("td");
   td1.setAttribute("width", "100");
   td1.innerText = "<%=sTime%>";
   
   var td2 = document.createElement("td");
   td2.setAttribute("width", "100");
   td2.innerText = "<%=eTime%>";
   
   var td3 = document.createElement("td");
   td3.setAttribute("width", "100");
   td3.innerText = "<%=sId%>";

   tr.appendChild(td0);
   tr.appendChild(td1);
   tr.appendChild(td2);
   tr.appendChild(td3);
   
   mtable.appendChild(tr);
   <%
   i++;
   }
   %>
   </script>
</body>
</html>