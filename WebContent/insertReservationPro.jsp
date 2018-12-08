<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.util.Calendar" %>
    <%@ page import = "login.LogonDBBeanReservation" %>
    <%@ page import = "login.LogonDataBeanReservation" %>
    <%@ page import = "login.LogonDBBeanScreen" %>
    <%@ page import = "login.LogonDBBeanMovie" %>
    <%
    String member_id = "";
    try{
       Cookie[] cookies = request.getCookies();
       if(cookies != null){
          for(int i =0; i<cookies.length;i++){
             if(cookies[i].getName().equals("id")){
                member_id = cookies[i].getValue();
             }
          }
          if(member_id.equals("")){
             response.sendRedirect("loginForm.jsp");
          }
       }else{
          response.sendRedirect("loginForm.jsp");
       }
    }catch(Exception e){
       
    }
    request.setCharacterEncoding("utf-8");
  	String seat_code = request.getParameter("Scode");
  	String time_code = request.getParameter("time_code");
  	String screen_id = request.getParameter("screen_id");
  	String id = request.getParameter("id");
  	
  	System.out.println(member_id);
  	Calendar oCalendar = Calendar.getInstance();
    int nowYear =oCalendar.get(Calendar.YEAR);
    String day = String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH));
    if(String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)).length()==1){
       day = "0"+day;
    }
    String str_nowDate = String.valueOf(oCalendar.get(Calendar.MONTH) + 1) + day;
    String now = String.valueOf(nowYear)+str_nowDate;
    
    LogonDBBeanReservation r = LogonDBBeanReservation.getInstance();
    LogonDataBeanReservation r2 = new LogonDataBeanReservation();
    r2.setId(member_id);
    r2.setSchedule_code(time_code);
    r2.setScode(seat_code);
    r2.setScreen_id(screen_id);
    r2.setRcode(now+"@"+seat_code+"@"+screen_id+"@"+time_code);
    r.insertReservation(r2);
	
   %>
    
    예약이 완료되었습니다.<br/>
    <input type="button" value="메인 페이지로 이동" onclick="main()">
    <script type="text/javascript">
    function main(){
       location.href="cookieMainMember.jsp";
    }
    </script>