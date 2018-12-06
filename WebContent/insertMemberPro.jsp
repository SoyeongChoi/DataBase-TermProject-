<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBean" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="member" class="login.LogonDataBean">
    	<jsp:setProperty name="member" property="*"/>
    </jsp:useBean>


    <%
    
    LogonDBBean logon = LogonDBBean.getInstance();
    logon.insertMember(member);
    if(!member.getId().contains("manager")){       
        logon.insertMember(member);
     }else{
     %>
     <script type="text/javascript">
       alert("manager가 포함된 아이디는 생성할 수 없습니다.");
       location.href="insertMemberForm.jsp";
    </script>
    <%
    }
    %>
    
    <jsp:getProperty property="name" name="member"/>님 회원가입을 축하합니다.<br/>
    <input type="button" value="로그인 하러가기" onclick="login()">
    <script type="text/javascript">
    function login(){
    	location.href="loginForm.jsp";
    }
    </script>