<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.LogonDBBeanTheater"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="theater" class="login.LogonDataBeanTheater">
	<jsp:setProperty name="theater" property="*" />
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String name = request.getParameter("tName");
	LogonDBBeanTheater logon = LogonDBBeanTheater.getInstance();
	String[] Info = logon.getInfo(name);

	String addr = Info[0];
	String tel = Info[1];
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>레코드 수정</title>
</head>
<body>
	<h2>영화관 정보 수정</h2>
	<form method="post" action="updateTheaterPro.jsp">
		영화관 이름 : <input type="text" name="mName" value="<%=name%>" maxlength="30" readonly>
			<br /> 
			주소 : <input type="text" name="mAddress"
			value="<%=addr%>" maxlength="100">
			<br /> 
			 전화번호 : <input type="text" name="mTelephone" value=<%=tel%> maxlength="30">
			 <br />
		<input type="submit" value="수정하기">
	</form>

	<input type="submit" value="영화관 삭제" onclick="button_event()">
	<script type="text/javascript">
			function button_event(){
				if (confirm("정말 삭제하시겠습니까?")){ //확인
					location.href="deleteTheaterPro.jsp?mName="+"<%=name%>";
			} else {
				return;
			}
		}
	</script>
</body>
</html>