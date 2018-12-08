<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.LogonDBBeanTheater"%>
<%@ page import="login.LogonDataBeanTheater"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="theater" class="login.LogonDataBeanTheater">
	<jsp:setProperty name="theater" property="*" />
</jsp:useBean>

<%
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "Lovedkwjd23@";
	Connection conn = null;
	PreparedStatement p1 = null;
	ResultSet r1 = null;
	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
	p1 = conn.prepareStatement("select count(*) from 영화관 where 영화관이름='" + theater.getmName()+ "'");
	r1 = p1.executeQuery();
	r1.first();
	int checking = r1.getInt(1);
	if(checking> 0){
		%>
		<script>
			alert("이미 존재하는 영화관입니다.");
			history.go(-1);
		</script>
		<%
	}else{
	LogonDBBeanTheater logon = LogonDBBeanTheater.getInstance();
	logon.insertTheater(theater);
	}
%>

<jsp:getProperty property="mName" name="theater" />영화관이 등록되었습니다.
<br />
<input type="button" value="영화관관리로 돌아가기" onclick="goTheaterManagement()">
<script type="text/javascript">
	function goTheaterManagement() {
		location.href = "TheaterManagement.jsp";
	}
</script>