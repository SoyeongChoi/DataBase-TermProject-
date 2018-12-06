<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.LogonDBBeanScreen"%>
<%@ page import="login.LogonDBBeanScreenSchedule"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="screen" class="login.LogonDataBeanScreen">
	<jsp:setProperty name="screen" property="*" />
</jsp:useBean>
<jsp:useBean id="schedule" class="login.LogonDataBeanScreenSchedule">
	<jsp:setProperty name="schedule" property="*" />
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String tName = request.getParameter("tName");
	String sId = request.getParameter("sId");
	LogonDBBeanScreen logon = LogonDBBeanScreen.getInstance();
	logon.updateScreenMovie(sId,null);
	LogonDBBeanScreenSchedule logon2= LogonDBBeanScreenSchedule.getInstance();
	logon2.deleteScreenSchedule(sId);
%>
<form method="post" action="screenManagement.jsp">
	<input type="submit" value="상영관 관리페이지로 돌아가기"/>
	<input type="hidden" name="tName" value="<%=request.getParameter("tName")%>"/>
</form>
	
<%=tName%> <%=sId%> 의 상영영화가 삭제되었습니다. 