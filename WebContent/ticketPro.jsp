<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Ƽ�� Ȯ��</title>
</head>
<body>
	<h2>Ƽ��Ȯ��</h2>


<%
   String member_id = "";
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
   System.out.println("member_id"+member_id);
   %>

	<%
		String id = request.getParameter("id");
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "thdud5313";
		try {
	%>
	���̵� :
	<%=id%>
	<table id="insertTable" border="1" style="border-collapse: collapse">
		<tr>
			<th width=100>��ȭ����</th>
			<th width=100>��ȭ��</th>
			<th width=100>�󿵰�</th>
			<th width=100>������¥</th>
			<th width=100>�¼�</th>
			<th width=100>������</th>
			<th width=100>��������</th>
		</tr>

		<%
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
				Statement stmt = conn.createStatement();
				String totalSql = "select * from ���� where ȸ�����̵�=" + "'" + id + "'";
				System.out.println(totalSql);
				ResultSet rs = stmt.executeQuery(totalSql);
				boolean test = true;
				int count = 0;
				while (rs.next()) {
					count++;
				}
				if (count == 0) {
					test = false;
		%>

		<tr>
			<td colspan="7">������ ������ �����ϴ�.</td>
		</tr>
		<%
			}
				Statement new_stmt = conn.createStatement();
				rs = new_stmt.executeQuery(totalSql);
				while (rs.next()) {

					if (test) {
						String payCode = rs.getString(1);
						String[] PayDate = payCode.split("@");
						String payDate = PayDate[PayDate.length - 1];
						String UserId = rs.getString(2);
						String payType = rs.getString(3);
						String SeatCode = rs.getString(4);
						String seat[] = SeatCode.split("@");
						String ScheduleCode = rs.getString(5);
						String[] schedule = ScheduleCode.split("@");
						String startTime =schedule[0];
						String endTime = schedule[1];
						String ScreenId = rs.getString(6);

						Statement stmt2 = conn.createStatement();
						String screenSql = "select �󿵰��̸�, ��ȭ���̸�, ��ȭ���̵� from �󿵰� where �󿵰����̵�=" + "'" + ScreenId + "'";
						System.out.println(screenSql);
						ResultSet rs2 = stmt.executeQuery(screenSql);
						rs2.first();
						String TheaterName = rs2.getString(2);
						String ScreenName = rs2.getString(1);
						String MovieId = rs2.getString(3);

						Statement stmt3 = conn.createStatement();
						String MovieSql = "select ��ȭ���� from ��ȭ where ��ȭ���̵�=" + "'" + MovieId + "'";
						System.out.println(MovieSql);
						ResultSet rs3 = stmt.executeQuery(MovieSql);
						rs3.first();
						String MovieName = rs3.getString(1);
						
						if(startTime.length()==3){
							startTime="0"+startTime.substring(0,1);
						}
						else{
							startTime=startTime.substring(0,2);
						}
						if(endTime.length()==3){
							endTime="0"+endTime.substring(0,1);
						}
						else{
							endTime=endTime.substring(0,2);
						}
		%>
		<tr>
			<td><%=MovieName%></td>
			<td><%=TheaterName%></td>
			<td><%=ScreenName%></td>
			<td><%=payDate%></td>
			<td><%=seat[0]%>�� <%=seat[1]%>��</td>
			<td>�Ͻ� : <%=schedule[2]%> <br /> <%=startTime%>:00 ~ <%=endTime%>:00</td>
			<td><%=payType%></td>
		</tr>
		<%


					}

				}
		%>
	</table>
	<br /> 
	
	<br/>
	<br/>
	���೻��
	<%
		Statement stmt5 = conn.createStatement();
		int total = 0;
			String totalSql5 = "select * from ���� where ȸ�����̵�=" + "'" + id + "'";
			ResultSet rs5 = stmt.executeQuery(totalSql5);
			if (rs5.next()) {
				total += 1;
			}

			String listSql5 = "select * from ���� where ȸ�����̵�=" + "'" + id + "'";
			rs5 = stmt.executeQuery(listSql5);
	%>

	<form name="testform" method="post">

		<table id="insertTable" border="1" style="border-collapse: collapse">
			<tr>
				<th width=100>��ȭ����</th>
				<th width=100>��ȭ��</th>
				<th width=100>�󿵰�</th>
				<th width=100>���ų�¥</th>
				<th width=100>�¼�</th>
				<th width=100>������</th>
				<th width=80>����</th>
				<th width=80>�������</th>
			</tr>
			<%
				//���ų�¥�� ���� ������ ��¥�� ������¥�� ���糯¥�� !!!!! �߿��߿�%%%%%%%%%%%%%%%%

					if (total == 0) {
			%>
			<tr>
				<td colspan="8">���� ������ ������ �����ϴ�.</td>
			</tr>
			<%
				} else {
						while (rs5.next()) {
							String reservationCode = rs5.getString(1);
							//reservationCode = ������+�¼���+�¼���+�󿵰����̵�(=��ȭ���̸�+�󿵰��̸�)+�������ڵ�
							String reservCode[] = reservationCode.split("@");
							String UserId = rs5.getString(2);
							String SeatCode = rs5.getString(3);
							String ScreenScheduleCode = rs5.getString(4);
							String Schedule[] = ScreenScheduleCode.split("@");
							String startTime = Schedule[0];
							String endTime = Schedule[1];
							String screenDay=Schedule[2];
							String ScreenId = rs5.getString(5);
							Statement stmt2 = conn.createStatement();
							String ScreenSql = "select ��ȭ���̵�, ��ȭ���̸�, �󿵰��̸� from �󿵰� where �󿵰����̵�=" + "'" + ScreenId + "'";
							ResultSet rs2 = stmt2.executeQuery(ScreenSql);
							rs2.first();
							String TheaterName = rs2.getString(2);
							String ScreenName = rs2.getString(3);
							Statement stmt3 = conn.createStatement();
							String MovieSql = "select ��ȭ���� from ��ȭ where ��ȭ���̵�=" + "'" + rs2.getString(1) + "'";
							ResultSet rs3 = stmt3.executeQuery(ScreenSql);
							rs3.first();
							String MovieName = rs3.getString(1);
							if(startTime.length()==3){
								startTime="0"+startTime.substring(0,1);
							}
							else{
								startTime=startTime.substring(0,2);
							}
							if(endTime.length()==3){
								endTime="0"+endTime.substring(0,1);
							}
							else{
								endTime=endTime.substring(0,2);
							}
			%>

			<tr>
				<td><input type="hidden" name="movieName"
					value="<%=MovieName%>"><%=MovieName%></td>
				<td><%=TheaterName%></td>
				<td><%=ScreenName%></td>
				<td><%=reservCode[0].substring(0,4)+"."+reservCode[0].substring(4,6)+"."+reservCode[0].substring(6,8)%></td>
				<td><%=reservCode[1]+"��"+reservCode[2]+"��"%></td>
				<td><%=screenDay.substring(0,4)+"."+screenDay.substring(4,6)+"."+screenDay.substring(6,8)+"\n"+startTime+":00" +"~"+ endTime+":00" %></td>
				<td><input type="checkbox" name="selectedItems"
					value="<%=reservationCode%>" /></td>
				<td><input type="hidden" name="reservationCode"
					value="<%=reservationCode%>" /> <input type="button"
					onclick="cancelRsv()" value="�������"></td>
			</tr>
		<%} %>
		</table>
		<input type="button" value="�����ϱ�" onclick="submitfuc(2)" />
	</form>

	<script type="text/javascript">
               function cancelRsv(){
                  if (confirm("���� ������ ����Ͻðڽ��ϱ�?")){ //Ȯ��
                     document.testform.action="cancelReservation.jsp?id=<%=id%>";
                     document.testform.submit();
                  }
                  else{ 
                     return;
                  }
               }
            </script>
	<script type="text/javascript">
               function submitfuc(index){   
                  if(index==2){
                     var checkbox = document.getElementsByName("selectedItems");
                     var size = document.getElementsByName("selectedItems").length;
                     var check_size = 0;
                     for(var i = 0; i < size; i++){
                        if(checkbox[i].checked == true){
                           check_size++;
                        }
                     }
                     var SelectCheck = [];
                     SelectCheck.length = check_size;
                     for(var i = 0; i < size; i++){
                        if(checkbox[i].checked == true){
                           SelectCheck[i] = checkbox[i].value;
                        }
                     }
                     document.testform.action="PayPlace.jsp?id=<%=id%>";
			}

			document.testform.submit();
		}
	</script>

	<%
			}

			rs.close();
			conn.close();
			stmt.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>


</body>
</html>