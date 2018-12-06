<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBeanSeat" %>
    <%@ page import = "login.LogonDBBeanReservation" %>
   	
    <% request.setCharacterEncoding("UTF-8");
    String id= request.getParameter("id");
    %>
    
   <jsp:useBean id="seat" class="login.LogonDataBeanSeat">
    	<jsp:setProperty name="seat" property="*"/>
    </jsp:useBean>
    
    
    <%
    LogonDBBeanSeat logon_s = LogonDBBeanSeat.getInstance();
    logon_s.insertSeat(seat);
    String seat_code = seat.getSeat_code();
    String time_code = seat.getSchedule_code();
    String screen_id = seat.getScreen_id();
    %>
    
    <jsp:getProperty property="seat_code" name="seat"/>좌석이 선택되었습니다.<br/>
 	
 	<form method="post" action="insertReservationPro.jsp">
 		<input type="hidden" name="Scode" value=<%=seat_code %>>
 		<input type="hidden" name="time_code" value=<%=time_code %>>
 		<input type="hidden" name="screen_id" value=<%=screen_id %>>
 		<input type="hidden" name="id" value=<%=id %>>
 		<input type="submit" value="예약">
 	</form>
   