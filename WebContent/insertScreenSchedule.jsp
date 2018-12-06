<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.LogonDBBeanScreenSchedule"%>
<%@ page import="login.LogonDBBeanScreen"%>

<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
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
	String sId = request.getParameter("sId");
	String nowDate = request.getParameter("selectDay");
	System.out.println(sId);
	LogonDBBeanScreen logon = LogonDBBeanScreen.getInstance();
	LogonDBBeanScreenSchedule logon2 = LogonDBBeanScreenSchedule.getInstance();
	String[] date = logon.getDate(sId);
	System.out.println("+##############"+date[0] + date[1]);

	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

	Date date1 = sdf.parse(date[0]);
	String Date1 = sdf2.format(date1);

	Date date2 = sdf.parse(date[1]);
	String Date2 = sdf2.format(date2);//마지막날짜
	System.out.println(Date2+"@@@@##!#!#$@#$@$");
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
	
	StimeEtime = logon2.getTime(sId, Date3.replace("-", ""));
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상영일정 등록</title>
</head>
<body onload="javascript:reload()">
	<h2>상영일정 등록</h2>
	<form method="post" action="insertScreenSchedulePro.jsp" id="formtest">
		상영관 아이디 : <input type="text" name="sId" value="<%=sId%>" readonly><br />
		상영 날짜 : <input type="date" id="screenDay" name="sDay" value="<%=Date3%>"
			min="<%=Date1%>" max="<%=Date2%>" onchange="handler(event);">
			<script>
			<%if(Integer.valueOf(date[0])<Integer.valueOf(now)){%>
				document.getElementById("screenDay").setAttribute("min", "<%=Date3%>");
			<%}%>
			</script>
			
		<br />

		<%
			for (int i = 0; i < 24; i++) {
		%>
	
		<script>
		var chbox = document.createElement("input");
		chbox.setAttribute("type", "checkbox");
		chbox.setAttribute("name", "time");
		
		var t = "<%=i%>"+"00";
		chbox.setAttribute("onclick", "limitCount('<%=i+"00"%>')");
		chbox.setAttribute("id",t);
		chbox.setAttribute("value",t);
		document.getElementById("formtest").appendChild(chbox);
		
		if(<%=i%><=9){
			document.write("0"+"<%=i%>"+":00");
		}
		else{
			document.write("<%=i%>"+":00");
		}
		</script>
		<%}%>
		
		<script>
		function reload(){
		<%
			for(int i=0; i<StimeEtime.length; i++){
				System.out.println("i"+i);
				if(StimeEtime[i][0]!=null){
					int st=0,et=0;
					if(StimeEtime[i][0].length()==3){
						st = Integer.parseInt(StimeEtime[i][0].substring(0,1));
						System.out.println("st"+st);
						}
					if(StimeEtime[i][0].length()==4){
						st = Integer.parseInt(StimeEtime[i][0].substring(0,2));
						System.out.println("st"+st);
					}
					if(StimeEtime[i][1].length()==3){
						et = Integer.parseInt(StimeEtime[i][1].substring(0,1));
						System.out.println("et"+et);
					}
					if(StimeEtime[i][1].length()==4){
						et = Integer.parseInt(StimeEtime[i][1].substring(0,2));
						System.out.println("et"+et);
					}
					while(st<et){%>
						var ch = document.getElementById("<%=st%>"+"00");
						ch.checked="true";
						ch.disabled="true";
					<%
						st=st+1;
					}
					%>
				<%
				System.out.println("Stime"+StimeEtime[i][0]);
				System.out.println("Etime"+StimeEtime[i][1]);
				}
				else{
					break;
				}
			}
		%>
		}
		</script>
		
		
		<br /> <br /> <input type="submit" id="insertMovie" value="등록하기">
	</form>
</body>

<script>
	function handler(e){
	  var day = e.target.value;
	  location.href="insertScreenSchedule.jsp?selectDay="+day+"&sId="+"<%=sId%>";
	}
	
	function limitCount(id){
		var checked = document.getElementsByName("time");
		var ln = 0;
		for(var i=0; i< checked.length; i++) {
		    if(checked[i].checked == true && checked[i].disabled == false){
		        ln++
		    }
		}
		if(ln==1){
			for(var i=0; i< checked.length; i++) {
				var j=0;
			    if(checked[i].checked == true && checked[i].disabled == false){
			    	var element = document.createElement("input");
		    		element.setAttribute("type","hidden")
		    		element.setAttribute("name", "sTime");
		    		element.setAttribute("id", "sTime");
		    		element.setAttribute("value", checked[i].value);
		    		document.getElementById("formtest").appendChild(element);
		    		var element2 = document.createElement("input");
		    		element2.setAttribute("type","hidden")
		    		element2.setAttribute("name", "eTime");
		    		element2.setAttribute("id", "eTime");
		    		element2.setAttribute("value", (checked[i].value*1+100)+"");
			    	document.getElementById("formtest").appendChild(element2);
			    }
			 }
		}
		if(ln==2){
			var j=0;
			for(var i=0; i< checked.length; i++) {
			    if(checked[i].checked == true && checked[i].disabled == false){
			    	if(j==0){
			    		var element = document.getElementById("sTime");
			    		element.setAttribute("value", checked[i].value);
			    		j++;
			    	}
			    	else{
			    		var element2 = document.getElementById("eTime");
			    		element2.setAttribute("value", (checked[i].value*1+100)+"");
			    	}
			    }
			}
		}
		if(ln>2){
			document.getElementById(id).checked=false;
			alert("두 개만 선택 가능합니다.");
		}
	}
</script>
</html>

