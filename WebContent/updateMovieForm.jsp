<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
    <%@ page import="login.LogonDBBeanMovie"%>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="movie" class="login.LogonDataBeanMovie">
    	<jsp:setProperty name="movie" property="*"/>
    </jsp:useBean>
   
    <%
    String mId = request.getParameter("movie");
    
	LogonDBBeanMovie logon = LogonDBBeanMovie.getInstance();
	String[] Info = logon.getInfo(mId);
	
	String mTitle = Info[0];
	String mDirector = Info[1];
	String mActor = Info[2];
	String mRating = Info[3];
	String mDetail = Info[4];
	String mBookingRate = Info[5];
	String mStartDate = Info[6];
	String mEndDate = Info[7];
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

	Date date1 = sdf.parse(mStartDate);
	String Date1 = sdf2.format(date1);

	Date date2 = sdf.parse(mEndDate);
	String Date2 = sdf2.format(date2);

    %>
    
    <html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>영화정보 수정</title>
	</head>
	<body>
		<h2>영화 정보 수정</h2>
		<form method="post" action="updateMoviePro.jsp">
			영화아이디 : <input type="text" name="mId" value='<%=mId%>' maxlength="30" readonly><br /> 
			영화제목 : <input type="text" name="mTitle" value="<%=mTitle%>" maxlength="40"><br />
			감독 : <input type="text" name="mDirector" value="<%=mDirector%>" maxlength="20"><br /> 
			출연 : <input type="text" name="mActor" value="<%=mActor%>" maxlength="50"><br /> 
			등급 : <input type="number" name="mRating" max="20" min="0" value=<%=mRating%> maxlength="10"><br />
			주요정보 : <input type="text" name="mDetail" value="<%=mDetail%>" maxlength="100"><br />
			예매율 : <input type="text" name="mBookingRate" value=<%=mBookingRate%> maxlength="10"><br />
			시작날짜 : <input type="date" name="mStartDate" value=<%=Date1%> ><br />
			종료날짜 : <input type="date" name="mEndDate" value=<%=Date2%> ><br />
			<input type="submit" value="수정하기">
		</form>
		
		<input type="submit" value="영화삭제" onclick="button_event()">
		<script type="text/javascript">
			function button_event(){
				if (confirm("정말 삭제하시겠습니까?")){ //확인
					location.href="deleteMoviePro.jsp?mId="+"<%=mId%>";
				}
				else{ 
					return;
				}
			}
		</script>
	</body>
	</html>