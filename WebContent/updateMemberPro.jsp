<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.LogonDBBean"%>

<%
   request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="member" class="login.LogonDataBean">
   <jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
   LogonDBBean logon = LogonDBBean.getInstance();
   logon.updateMember(member);
%>

<jsp:getProperty property="id" name="member" />님의 회원정보가 수정되었습니다.
<br />
<input type="button" value="메인으로 돌아가기" onclick="main()">
<script type="text/javascript">
   function main() {
      location.href = "cookieMain.jsp";
   }
</script>