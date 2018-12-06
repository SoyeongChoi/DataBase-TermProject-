<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBeanMovie" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="movie" class="login.LogonDataBeanMovie">
    	<jsp:setProperty name="movie" property="*"/>
    </jsp:useBean>

    <%
    Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "thdud5313";
	Connection conn = null;
	PreparedStatement p1 = null;
	ResultSet r1 = null;
	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
	movie.setmStartDate(movie.getmStartDate().replace("-", ""));
	movie.setmEndDate(movie.getmEndDate().replace("-", ""));
	p1 = conn.prepareStatement("select count(*) from 영화 where 영화제목='"+movie.getmTitle()+"'");
	r1 = p1.executeQuery();
	r1.first();
	int checking = r1.getInt(1);
    movie.setmId(movie.getmTitle()+String.valueOf(checking+1));
    
    LogonDBBeanMovie logon = LogonDBBeanMovie.getInstance();
    logon.insertMovie(movie);
    %>
    
    <jsp:getProperty property="mId" name="movie"/>영화가 등록되었습니다.<br/>
    <input type="button" value="영화관리페이지로 이동하기" onclick="goMovieManagement()">
    <script type="text/javascript">
    function goMovieManagement(){
    	location.href="movieManagement.jsp";
    }
    </script>