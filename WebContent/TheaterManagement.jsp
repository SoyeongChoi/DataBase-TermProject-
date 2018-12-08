<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화관 관리</title>
</head>
<body>

	<h2>영화관 관리 페이지</h2>
	
	<input type="button" value="메인으로 돌아가기" onclick="main()">
	<script type="text/javascript">
    function main(){
    	location.href="cookieMainManager.jsp?id=<%=request.getParameter("id")%>";
    }
	</script>
 	
	<form method="post" action="insertTheaterForm.jsp">
		<input type="submit" value="영화관 추가">
	</form>
	
	<br/>
	<br/>
-------------------------------------------------------------------------------------
<br/>	
	<h3>영화관 목록</h3>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "Lovedkwjd23@";
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
	<form name = "testform" method="post">
	<table border="1" style="border-collapse:collapse">
		<tr>
			<th></th>
			<th>영화관이름</th>
			<th>영화관 주소</th>
			<th>영화관 전화번호</th>
		</tr>
		<%
			if (total == 0) {
		%>
		<tr>
			<td colspan="4">현재 추가한 영화관이 없습니다.</td>
		</tr>
		<%
			} else {
					while (rs.next()) {
						String name = rs.getString(1);
						String addr = rs.getString(2);
						String tel = rs.getString(3);
		%>
		<tr>

			<td><input type="radio" name="tName" value="<%=name%>" onclick=disabledF()></td>
			<td><%=name%></td>
			<td><%=addr%></td>
			<td><%=tel%></td>
		</tr>
		<%
			}
				}
				rs.close();
				conn.close();
				stmt.close();
			} catch (SQLException e) {
				out.println(e.toString());
			}
		%>
	</table>
	<input type="button" onclick="submitfuc1()" value="영화관정보수정" id="button1" disabled/>
	<input type="button" onclick="submitfuc2()" value="상영관 관리" id="button2" disabled/>
	</form>
	<br>
	
	<script>
	function disabledF(){
		document.getElementById("button1").disabled = false;
		document.getElementById("button2").disabled = false;
	}
	</script>
	
	<script>
	function submitfuc1(){
		document.testform.action="updateTheaterForm.jsp";
		document.testform.submit();
	}
 	</script>  
 	
 	<script type="text/javascript">
 	function submitfuc2(){
		document.testform.action="screenManagement.jsp";
		document.testform.submit();
	}
 	</script>
	
</body>
</html>