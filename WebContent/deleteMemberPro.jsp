<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.LogonDBBean"%>

<jsp:useBean id="member" class="login.LogonDataBean">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
	LogonDBBean logon = LogonDBBean.getInstance();
	logon = LogonDBBean.getInstance();
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("id")) {
				cookies[i].setMaxAge(0);
				response.addCookie(cookies[i]);
				logon.deleteMember(cookies[i].getValue());
			}
		}
	}
%>
<jsp:getProperty property="id" name="member" />님의 탈퇴가 완료되었습니다.
<br />
<input type="button" value="로그인 하러가기" onclick="main()">
<script type="text/javascript">
	function main() {
		location.href = "loginForm().jsp";
	}
</script>