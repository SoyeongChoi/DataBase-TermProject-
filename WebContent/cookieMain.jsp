<%@ page import="login.LogonDBBean"%>
<%
	request.setCharacterEncoding("utf-8");
%>
 
<%
String member_id;
member_id = request.getParameter("id");
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
System.out.println("Cmember_id"+member_id);

	LogonDBBean logon = LogonDBBean.getInstance();
	int mcheck = logon.managerCheck(member_id);
	Cookie cookie = new Cookie("id", member_id);
	cookie.setMaxAge(60*60*24); //1일
	response.addCookie(cookie);
	if (mcheck == 1) {//관리자면
		response.sendRedirect("cookieMainManager.jsp");
	} else {
		response.sendRedirect("cookieMainMember.jsp");
	}
%>