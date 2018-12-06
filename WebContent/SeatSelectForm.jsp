<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.LogonDBBeanScreen"%>
<%@ page import="login.LogonDBBeanSeat"%>
<%@ page import="java.util.Calendar"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="screen" class="login.LogonDataBeanScreen">
	<jsp:setProperty name="screen" property="*" />
</jsp:useBean>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>좌석 선택</title>
</head>
<body>

	<h2>좌석 선택 페이지</h2>

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
	<input type="button" value="메인 페이지로 이동" onclick="main()">
	<script type="text/javascript">
    function main(){
    	location.href="cookieMainMember.jsp?";
    }
    </script>

	<br />
	<br />

	<%
  	 request.setCharacterEncoding("utf-8");
  	String id = request.getParameter("id");
  	String time_code = request.getParameter("time");
  	String screen_id = request.getParameter("screen");
  	String date = request.getParameter("date");
  	LogonDBBeanScreen logon = LogonDBBeanScreen.getInstance();
  	String[] seat_num = logon.getSeat(screen_id);
  	int row = Integer.parseInt(seat_num[0]);
  	int column = Integer.parseInt(seat_num[1]);
  	Class.forName("com.mysql.jdbc.Driver");
    String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
    String dbId = "root";
    String dbPass = "thdud5313";
    int total = 0;
    int size = 0;
    try {
       Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
       Statement stmt = conn.createStatement();
       String totalSql = "select * from 좌석 where 상영관아이디='"+screen_id+"' and 상영일정코드='"+time_code+"'";
       ResultSet rs = stmt.executeQuery(totalSql);

       while (rs.next()) {
          total += 1;
       }

       String listSql = "select * from 좌석 where 상영관아이디='"+screen_id+"' and 상영일정코드='"+time_code+"'";
       rs = stmt.executeQuery(listSql);
       String[] seat_list = new String[total];
       int[][] list = new int[row][column];
       while (rs.next()) {
           seat_list[size]= rs.getString(1);
           String[] temp = seat_list[size].split("@");
           list[Integer.parseInt(temp[0])-1][Integer.parseInt(temp[1])-1] = 1;
           size++;
       }
       
    
    rs.close();
    conn.close();
    stmt.close();

 %>

	<form method="post" action="SeatSelectPro.jsp">
		<table id="insertTable" border="1" style="border-collapse: collapse">
			<%
    
    for(int i=1; i<=row; i++){
    	%>
			<tr>
				<%
    	for(int j=1; j<=column; j++){
    		String temp = i+"@"+j;
    		if(list[i-1][j-1]!=1){
    			%>
				<td><input type="radio" name="seat_code" value="<%=temp %>"></td>
				<%
    		}else{
    			%>
				<td>X</td>
				<%
    		}
    	}

    	%>
			</tr>
			<%
    }
    }catch (SQLException e) {
        out.println(e.toString());
     }
    
    
    
    %>
		</table>
		<input type="hidden" name="id" value="<%=id%>"> <input
			type="hidden" name="date" value="<%=date%>"> <input
			type="hidden" name="screen_id" value="<%=screen_id%>"> <input
			type="hidden" name="schedule_code" value="<%=time_code %>"> <input
			type="hidden" name="check" value=1> <input type="submit"
			value="좌석선택">
	</form>

</body>
</html>