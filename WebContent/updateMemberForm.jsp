<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="login.LogonDBBean"%>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="member" class="login.LogonDataBean">
    	<jsp:setProperty name="member" property="*"/>
    </jsp:useBean>
   
    <%
    String id="";
	
	try{
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(int i =0; i<cookies.length;i++){
				if(cookies[i].getName().equals("id")){
					id = cookies[i].getValue();
				}
			}
			if(id.equals("")){
				response.sendRedirect("loginForm.jsp");
			}
		}else{
			response.sendRedirect("loginForm.jsp");
		}
	}catch(Exception e){
		
	}
	LogonDBBean logon = LogonDBBean.getInstance();
	String[] Info = logon.getInfo(id);
	
	String passwd=Info[0];
	String name=Info[1];
	int birth=Integer.parseInt(Info[2]);
	String address=Info[3];
	String phoneNum=Info[4];
	int point=Integer.parseInt(Info[5]);
	String grade = Info[6];
    %>
    
    <html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>레코드 수정</title>
	</head>
	<body>
		<h2>회원 정보 수정</h2>
		<form method="post" action="updateMemberPro.jsp">
			
			아이디(변경 불가) : <input type="text" name="id" value=<%=id%> maxlength="30" readonly><br /> 
			비밀번호 : <input type="text" name="passwd" value=<%=passwd%> maxlength="30"><br />
			성명 : <input type="text" name="name" value=<%=name%> maxlength="30"><br /> 
			생년월일 : <input type="number" name="birth" value=<%=birth%> maxlength="10"><br /> 
			주소 : <input type="text" name="address" value="<%=address%>" maxlength="100"><br />
			전화번호 : <input type="text" name="phoneNum" value=<%=phoneNum%> maxlength="30"><br />
			<input type="submit" value="수정하기">
		</form>
		<input type="submit" value="메인으로 돌아가기" onclick="location.href='cookieMain.jsp'">
		<input type="submit" value="정보보기로 돌아가기" onclick="location.href='lookingMember.jsp'">
		<input type="submit" value="회원탈퇴" onclick="button_event()">
		<script type="text/javascript">
			function button_event(){
				if (confirm("정말 탈퇴하시겠습니까?")){ //확인
					location.href="deleteMemberPro.jsp?id="+"<%=id%>";
				}
				else{ 
					return;
				}
			}
		</script>
	</body>
	</html>