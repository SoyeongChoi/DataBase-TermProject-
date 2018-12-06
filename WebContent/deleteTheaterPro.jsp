<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBeanTheater" %>
    
   <jsp:useBean id="theater" class="login.LogonDataBeanTheater">
       <jsp:setProperty name="theater" property="*"/>
    </jsp:useBean>

    <%
    LogonDBBeanTheater logon = LogonDBBeanTheater.getInstance();
   logon.deleteTheater(request.getParameter("mName"));
    %>
    <jsp:getProperty property="mName" name="theater"/>영화관 삭제가 완료되었습니다.<br/>
    <input type="button" value="영화관관리페이지로 이동하기" onclick="goTheaterManagement()">
    <script type="text/javascript">
    function goTheaterManagement(){
       location.href="TheaterManagement.jsp";
    }
    </script>