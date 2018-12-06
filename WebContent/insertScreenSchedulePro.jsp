<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBeanScreenSchedule" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="schedule" class="login.LogonDataBeanScreenSchedule">
    	<jsp:setProperty name="schedule" property="*"/>
    </jsp:useBean>

    <%
    LogonDBBeanScreenSchedule logon = LogonDBBeanScreenSchedule.getInstance();
    schedule.setsDay(schedule.getsDay().replace("-", ""));
    System.out.println("###########"+schedule.getsTime());
    
    schedule.setScheduleCode(schedule.getsTime()+"@"+schedule.geteTime()+"@"+schedule.getsDay());
    logon.insertScreenSchedule(schedule);
    %>
    
    <jsp:getProperty property="sId" name="schedule"/> 에 상영일정이 등록되었습니다.<br/>
    
    <form method="post" action="screenScheduleManagement.jsp">
	<input type="submit" value="상영일정 관리 페이지로 돌아가기"/>
	<input type="hidden" name="sId" value="<%=schedule.getsId()%>"/>
	</form>
	<br/><br/><br/>