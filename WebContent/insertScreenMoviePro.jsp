<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBeanScreen" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="screen" class="login.LogonDataBeanScreen">
    	<jsp:setProperty name="screen" property="*"/>
    </jsp:useBean>

    <%
    String sId = request.getParameter("sId");
    String mId = request.getParameter("mId");
    LogonDBBeanScreen logon = LogonDBBeanScreen.getInstance();
    logon.updateScreenMovie(sId, mId);
    %>
    
    <%=sId%> 상영관에 <%=mId%> 영화가 등록되었습니다.<br/>
    
    <form method="post" action="screenManagement.jsp">
	<input type="submit" value="상영관 관리페이지로 돌아가기"/>
	<input type="hidden" name="tName" value="<%=request.getParameter("tName")%>"/>
	</form>
	<br/><br/><br/>