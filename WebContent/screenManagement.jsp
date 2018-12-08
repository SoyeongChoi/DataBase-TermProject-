<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.LogonDBBeanTheater"%>
<%@ page import="login.LogonDBBeanScreen"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="theater" class="login.LogonDataBeanTheater">
	<jsp:setProperty name="theater" property="*" />
</jsp:useBean>
<jsp:useBean id="screen" class="login.LogonDataBeanScreen">
    	<jsp:setProperty name="screen" property="*"/>
    </jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String tName = request.getParameter("tName");
	
	LogonDBBeanScreen logonS = LogonDBBeanScreen.getInstance();
	String[][] Info = logonS.getInfoAll(tName);
	
	String sId=null;
	String sName=null;
	String row=null;
	String column=null;
	String mId=null;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상영관 목록</title>
</head>
<body>
	<h2><%=tName %> 상영관 목록</h2>
	
	<form method="post" action = "TheaterManagement.jsp">
      <input type="submit" value = "영화관관리 페이지로 돌아가기">
    </form>
	<form method="post" action="insertScreen.jsp">
	<input type="hidden" name="tName" value="<%=tName%>"/>
	<input type="submit" value="상영관 등록"/>
	</form>
	<br/><br/><br/>

	<script type="text/javascript">
	function submitfuc(index){
		if(index==1){
			 document.testform.action="insertScreenMovie.jsp";
		}
		if(index==2){
			 document.testform.action="screenScheduleManagement.jsp";
		}
		if(index==3){
			document.testform.action="deleteScreenMovie.jsp";
		}
		document.testform.submit();
	}
	</script>
	
	<form method="post" name="testform">
		<table id="insertTable" border="1" style="border-collapse:collapse">
		<tr>
			<th width=50></th>
			<th width=100>상영관아이디</th>
			<th width=100>상영관이름</th>
			<th width=100>좌석행</th>
			<th width=100>좌석열</th>
			<th width=100>영화관이름</th>
			<th width=100>영화아이디</th>
		</tr>
		</table>
		<input type="hidden" name="tName" value="<%=tName%>"/>
		
		<input type="button" onclick="submitfuc(<%="1"%>)" id="b1" value="상영영화 등록/수정하기" disabled>
		<input type="button" onclick="submitfuc(<%="3"%>)" id="b3" value="상영영화 삭제하기" disabled>
		<input type="button" onclick="submitfuc(<%="2"%>)" id="b2" value="상영일정 관리" disabled>
	</form>
	
	<script type="text/javascript">
	var mtable = document.getElementById("insertTable");
	<%
	int i=0;
	while(i<Info.length){
		sId=Info[i][0];
		sName = Info[i][1];
		row = Info[i][2];
		column = Info[i][3];
		mId = Info[i][4];
	%>
	var tr = document.createElement("tr");
	
	var td = document.createElement("td");
	td.setAttribute("width", "50");
	
	var radio = document.createElement("input");
	radio.setAttribute("type", "radio");
	radio.setAttribute("name", "sId");
	radio.setAttribute("value", "<%=sId%>");
	radio.setAttribute("onclick", "disabledF()");
	td.appendChild(radio);
	
	var td0 = document.createElement("td");
	td0.setAttribute("width", "100");
	td0.innerText = "<%=sId%>";
	
	var td1 = document.createElement("td");
	td1.setAttribute("width", "100");
	td1.innerText = "<%=sName%>";
	
	var td2 = document.createElement("td");
	td2.setAttribute("width", "100");
	td2.innerText = "<%=row%>";
	
	var td3 = document.createElement("td");
	td3.setAttribute("width", "100");
	td3.innerText = "<%=column%>";
	
	var td4 = document.createElement("td");
	td4.setAttribute("width", "100");
	td4.innerText = "<%=tName%>";
	
	var td5 = document.createElement("td");
	td5.setAttribute("width", "100");
	td5.innerText = "<%=mId%>";
	
	tr.appendChild(td);
	tr.appendChild(td0);
	tr.appendChild(td1);
	tr.appendChild(td2);
	tr.appendChild(td3);
	tr.appendChild(td4);
	tr.appendChild(td5);
	
	mtable.appendChild(tr);
	<%
	i++;
	}
	%>
	</script>
	
	<script>
	function disabledF(){
		document.getElementById("b1").disabled = false;
		document.getElementById("b3").disabled = false;
		document.getElementById("b2").disabled = false;
	}
	</script>
</body>
</html>