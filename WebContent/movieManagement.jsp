<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="login.LogonDBBeanMovie"%>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="movie" class="login.LogonDataBeanMovie">
    	<jsp:setProperty name="movie" property="*"/>
    </jsp:useBean>
    
    <%
    LogonDBBeanMovie logon = LogonDBBeanMovie.getInstance();
	String[][] Info = logon.getInfoAll();
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>영화관리</title>
</head>
<body>

	<h2>영화 관리 페이지</h2>

	<input type="button" value="메인으로 돌아가기" onclick="main()">
	<script type="text/javascript">
    function main(){
    	location.href="cookieMainManager.jsp?id=<%=request.getParameter("id")%>";
    }
    </script>

	<form method="post" action="insertMovieForm.jsp">
		<input type="submit" value="영화추가">
	</form>
	
	<br/>
	<br/>

	<script type="text/javascript">
	function submitfuc(index){
		if(index==1){
			 document.testform.action="updateMovieForm.jsp";
		}
		document.testform.submit();
	}
	</script>
	
	<form name = "testform" method="post">
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
	<input type="button" onclick="submitfuc(1)" value="영화정보수정" id="modify" disabled/>
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
	radio.setAttribute("name", "movie");
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
	<%
	i++;
	}
	%>
	</script>
	
	<script>
	function disabledF(){
		document.getElementById("modify").disabled = false;
	}
	</script>
</body>
</html>