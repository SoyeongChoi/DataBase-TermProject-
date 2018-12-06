<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.LogonDBBeanTheater"%>
<%@ page import="login.LogonDBBeanMovie"%>
<%@ page import="java.util.Calendar" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="theater" class="login.LogonDataBeanTheater">
	<jsp:setProperty name="theater" property="*" />
</jsp:useBean>
<jsp:useBean id="movie" class="login.LogonDataBeanMovie">
	<jsp:setProperty name="movie" property="*" />
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<form method="post" action="screenManagement.jsp">
	<input type="submit" value="상영관 관리페이지로 돌아가기"/>
	<input type="hidden" name="tName" value="<%=request.getParameter("tName")%>"/>
</form>
<%
	String sId = request.getParameter("sId");
	String tName = request.getParameter("tName");
	LogonDBBeanMovie logonM = LogonDBBeanMovie.getInstance();
	String[][] Info = logonM.getInfoAll();
	
	 Calendar oCalendar = Calendar.getInstance();
     int nowYear =oCalendar.get(Calendar.YEAR);
     String day = String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH));
     if(String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)).length()==1){
    	 day = "0"+day;
     }
     String str_nowDate = String.valueOf(oCalendar.get(Calendar.MONTH) + 1) + day;
     String now = String.valueOf(nowYear)+str_nowDate;
     int nowDate = Integer.parseInt(now);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상영영화 등록</title>
</head>
<body>
	<h2>상영영화 등록</h2>
	<form method="post" action="insertScreenMoviePro.jsp">
			상영관 아이디 : <input type="text" name="sId" value="<%=sId%>" readonly>
			<input type="hidden" name="tName" value="<%=tName%>">
			<br /> 
			영화 선택
				<table id="insertTable" border="1" style="border-collapse:collapse">
				<tr>
					<th width=50></th>
					<th width=100>영화아이디</th>
					<th width=100>영화제목</th>
					<th width=100>감독</th>
					<th width=100>출연</th>
					<th width=100>등급</th>
					<th width=100>주요정보</th>
					<th width=100>예매율</th>
					<th width=100>시작날짜</th>
					<th width=100>종료날짜</th>
				</tr>
				</table>
		<input type="submit" id="insertMovie" value="영화등록하기" disabled>
	</form>
	
	<script type="text/javascript">
	var mtable = document.getElementById("insertTable");
	<%
	int i=0;
	while(i<Info.length){
		String mId=Info[i][0];
		String mTitle = Info[i][1];
		String mDirector = Info[i][2];
		String mActor = Info[i][3];
		String mRating = Info[i][4];
		String mDetail = Info[i][5];
		String mBookingRate = Info[i][6];
		String mStartDate = Info[i][7];
		String mEndDate = Info[i][8];
	%>
	var tr = document.createElement("tr");
	
	var td = document.createElement("td");
	td.setAttribute("width", "50");
	
	var radio = document.createElement("input");
	radio.setAttribute("type", "radio");
	radio.setAttribute("name", "mId");
	radio.setAttribute("value", "<%=mId%>");
	radio.setAttribute("onclick", "disabledF()");
	td.appendChild(radio);
	
	var td0 = document.createElement("td");
	td0.setAttribute("width", "100");
	td0.innerText = "<%=mId%>";
	
	var td1 = document.createElement("td");
	td1.setAttribute("width", "100");
	td1.innerText = "<%=mTitle%>";
	
	var td2 = document.createElement("td");
	td2.setAttribute("width", "100");
	td2.innerText = "<%=mDirector%>";
	
	var td3 = document.createElement("td");
	td3.setAttribute("width", "100");
	td3.innerText = "<%=mActor%>";
	
	var td4 = document.createElement("td");
	td4.setAttribute("width", "100");
	td4.innerText = "<%=mRating%>";
	
	var td5 = document.createElement("td");
	td5.setAttribute("width", "100");
	td5.innerText = "<%=mDetail%>";
	
	var td6 = document.createElement("td");
	td6.setAttribute("width", "100");
	td6.innerText = "<%=mBookingRate%>";
	
	var td7 = document.createElement("td");
	td7.setAttribute("width", "100");
	td7.innerText = "<%=mStartDate%>";
	
	var td8 = document.createElement("td");
	td8.setAttribute("width", "100");
	td8.innerText = "<%=mEndDate%>";
	<%
	System.out.println(mStartDate);
	System.out.println(nowYear);
	System.out.println(mEndDate);
	%>
	<% if(nowDate-Integer.parseInt(mStartDate)>=0 && 0<=Integer.parseInt(mEndDate)-nowDate){%>
	tr.appendChild(td);
	tr.appendChild(td0);
	tr.appendChild(td1);
	tr.appendChild(td2);
	tr.appendChild(td3);
	tr.appendChild(td4);
	tr.appendChild(td5);
	tr.appendChild(td6);
	tr.appendChild(td7);
	tr.appendChild(td8);
	
	mtable.appendChild(tr);
	<%}%>
	
	<%
	i++;
	}
	%>
	</script>
	
	<script>
	function disabledF(){
		document.getElementById("insertMovie").disabled = false;
	}
	</script>
</body>
</html>