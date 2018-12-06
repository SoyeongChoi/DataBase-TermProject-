<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBeanScreen" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="screen" class="login.LogonDataBeanScreen">
    	<jsp:setProperty name="screen" property="*"/>
    </jsp:useBean>

    <%
    Class.forName("com.mysql.jdbc.Driver");
   	String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
   	String dbId = "root";
   	String dbPass = "thdud5313";
   	Connection conn = null;
   	PreparedStatement p1 = null;
   	ResultSet r1 = null;
   	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
    screen.setsID(screen.gettName()+"@"+screen.getsName());
   	p1 = conn.prepareStatement("select count(*) from 상영관 where 상영관아이디='"+screen.gettName()+"@"+screen.getsName()+"'");
   	r1 = p1.executeQuery();
   	r1.first();
   	int checking = r1.getInt(1);
   	if(checking>0){
   		%>
   		<script>
   			alert("이미 존재하는 상영관입니다.");
   			history.go(-1);
   		</script>
   		<%
   	}else{
	    LogonDBBeanScreen logon = LogonDBBeanScreen.getInstance();
     	logon.insertScreen(screen);
   		
   	}
    %>
    
    <jsp:getProperty property="sID" name="screen"/> 상영관이 등록되었습니다.<br/>
    
    <form method="post" action="screenManagement.jsp">
	<input type="submit" value="상영관 관리페이지로 돌아가기"/>
	<input type="hidden" name="tName" value="<%=screen.gettName()%>"/>
	
	</form>
	<br/><br/><br/>