<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.LogonDBBeanTheater"%>


<%
	request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="theater" class="login.LogonDataBeanTheater">
	<jsp:setProperty name="theater" property="*" />
</jsp:useBean>
 <%
 	LogonDBBeanTheater logon = LogonDBBeanTheater.getInstance();
	logon.updateTheater(theater);
%>
<jsp:getProperty property="mName" name="theater" />님의 회원정보가 수정되었습니다.
<br />
<input type="button" value="영화관리스트로 돌아가기" onclick="main()">
<script type="text/javascript">
	function main() {
		location.href = "TheaterManagement.jsp";
	}
</script>