<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBeanMovie" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="movie" class="login.LogonDataBeanMovie">
    	<jsp:setProperty name="movie" property="*"/>
    </jsp:useBean>

    <%
    LogonDBBeanMovie logon = LogonDBBeanMovie.getInstance();
    movie.setmStartDate(movie.getmStartDate().replace("-", ""));
	movie.setmEndDate(movie.getmEndDate().replace("-", ""));
	
    logon.updateMovie(movie);
    %>
    
    <jsp:getProperty property="mId" name="movie"/>의 영화정보가 수정되었습니다.<br/>
    <input type="button" value="영화관리페이지로 이동하기" onclick="goMovieManagement()">
    <script type="text/javascript">
    function goMovieManagement(){
    	location.href="movieManagement.jsp";
    }
    </script>