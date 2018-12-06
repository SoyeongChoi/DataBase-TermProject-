<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.LogonDBBean"%>

<jsp:useBean id="member" class="login.LogonDataBean">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
		String real_id = request.getParameter("mId");
		LogonDBBean logon = LogonDBBean.getInstance();
		logon = LogonDBBean.getInstance();
		logon.deleteMember(real_id);
%>
<jsp:getProperty property="real_id" name="member" />님의 탈퇴가 완료되었습니다.
<br />
<input type="button" value="메인으로 돌아가기" onclick="main()">
<script type="text/javascript">
	function main() {
		location.href = "cookieMain.jsp";
	}
</script>