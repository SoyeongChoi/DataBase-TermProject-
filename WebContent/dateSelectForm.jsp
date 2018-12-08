<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.*" %>
    <%@ page import = "java.text.*" %>
    <%@ page import="login.LogonDBBeanMovie"%>
    <%@ page import="java.util.Calendar" %>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="movie" class="login.LogonDataBeanMovie">
       <jsp:setProperty name="movie" property="*"/>
    </jsp:useBean>
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>날짜선택</title>
</head>
<body>

   <h2>날짜 선택 페이지</h2>

   <input type="button" value="메인 페이지로 이동" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="cookieMain.jsp";
    }
    </script>
   
   <br/>
   <br/>

   <%
      request.setCharacterEncoding("utf-8");
      String id = request.getParameter("id");
  	String nowDate = request.getParameter("selectDay");
      LogonDBBeanMovie logon = LogonDBBeanMovie.getInstance();
    String[] date = logon.getDate(id);
    System.out.println("!!!!!!!11"+id);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
   
      int start_int = Integer.parseInt(date[0]);
      String start_m = date[0].substring(4,6);
      String start_d = date[0].substring(6,8);
      System.out.println(start_m+"+"+start_d);
      int end_int = Integer.parseInt(date[1]);
      
    Date date1 = sdf.parse(date[0]);
    String Date1 = sdf2.format(date1);

    Date date2 = sdf.parse(date[1]);
    String Date2 = sdf2.format(date2);
    Calendar oCalendar = Calendar.getInstance();
	int nowYear = oCalendar.get(Calendar.YEAR);
	 String day = String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH));
     if(String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)).length()==1){
    	 day = "0"+day;
     }
     String str_nowDate = String.valueOf(oCalendar.get(Calendar.MONTH) + 1) + day;
	String now = String.valueOf(nowYear) + str_nowDate;
	
	Date date3 = sdf.parse(now);
	String Date3 = sdf2.format(date3);//현재날짜
	String StimeEtime[][]=null;
	if(nowDate!=null){		
		Date3 = nowDate;
	}
	

         %>
   
   <form method="post" action = "TheaterSelectForm.jsp">
   <table id="TheaterTable" border="1" style="border-collapse:collapse">
      <tr>
         <th width=100>날짜</th>
      </tr>
         
            
            <%
                %>
               <tr>
               <td><input type="date" id="start" name="date" value="<%=Date3%>"
         min="<%=Date1%>" max="<%=Date2%>" onchange="handler(event);"></td>
               
               </tr>
               
            <%
            
            %>
      <input hidden="text" name ="id" value = "<%=id%>">
      
   </table>
      <input type="submit" value = "날짜선택">
   </form>
   <script>
   function handler(e){
		  var day = e.target.value;
		  location.href="dateSelectForm.jsp?selectDay="+day+"&id="+"<%=id%>";
		}
   </script>
</body>
</html>