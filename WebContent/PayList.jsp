<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Calendar"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��������Ȯ�� ����Ʈ</title>
</head>
<body>
	<h2>���� ���� Ȯ��</h2>
	<input type="button" value="�������� ���ư���" onclick="main()">
	<script type="text/javascript">
		function main() {
			location.href = "cookieMain.jsp";
		}
	</script>
	<br />
	<br />
	<%
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "thdud5313";

		// getParameter()�� �̿��� �Ѱ��� �Ķ���� ���� ���� �� �ִ�.
		// �Ķ���� ���� ������ name= �� �����ص� ���� ������ ���� ���ڷ� �����ؾ� �ȴ�.
		String id = request.getParameter("id");
		int total = 0;
		try {
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			Statement stmt = conn.createStatement();
			String totalSql = "select * from ���� where ȸ�����̵�=" + "'" + id + "'";
			ResultSet rs = stmt.executeQuery(totalSql);
			if (rs.next()) {
				total += 1;
			}

			String listSql = "select * from ���� where ȸ�����̵�=" + "'" + id + "'";
			rs = stmt.executeQuery(listSql);
	%>
	<table id="PayTable" border="1" style="border-collapse: collapse">
		<tr>
			<th width=100>��ȭ����</th>
			<th width=100>��ȭ��</th>
			<th width=100>�󿵰�</th>
			<th width=100>������¥</th>
			<th width=100>�¼�</th>
			<th width=100>������</th>
			<th width=100>��������</th>
			<th width=100>Ƽ�Ϲߺ�</th>
		</tr>
		<%
			//���ų�¥�� ���� ������ ��¥�� ������¥�� ���糯¥�� !!!!! �߿��߿�%%%%%%%%%%%%%%%%

				if (total == 0) {
		%>
		<tr>
			<td colspan="7">���� ������ ������ �����ϴ�.</td>
		</tr>
		<%
			} else {
					while (rs.next()) {
						String PayCode = rs.getString(1);
						//reservationCode = ������+�¼���+�¼���+�󿵰����̵�(=��ȭ���̸�+�󿵰��̸�)+�������ڵ�
						String pCode[] = PayCode.split("&");
						String payDate[] = pCode[pCode.length - 1].split("=");
						String UserId = rs.getString(2);
						String PayType = rs.getString(3);
						String SeatCode = rs.getString(4);
						String seat[] = SeatCode.split("&");
						String ScreenScheduleCode = rs.getString(5);
						String Schedule[] = ScreenScheduleCode.split("&");
						String startTime = Schedule[0];
						String endTime = Schedule[1];
						String ScreenId = rs.getString(6);
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
		%>
		<tr>
			<td><%=MovieName%></td>
			<td><%=TheaterName%></td>
			<td><%=ScreenName%></td>
			<td><%=payDate[1]%></td>
			<td><%=seat[0] + "��" + seat[1] + "��"%></td>
			<td><%=startTime + "~" + endTime%></td>
			<td><%=PayType%></td>
			<td>
				<form method="post" action="ShowTicket.jsp">
					<input type="hidden" name="reservation"
						value="<%=PayCode%>" /> <input type="submit" value="Ƽ�Ϲߺ�" />
				</form>
			</td>

		</tr>
		<%
			}
				}
				rs.close();
				conn.close();
				stmt.close();
			} catch (SQLException e) {
				out.println(e.toString());
			}
		%>
	</table>
	<br />
	<br />
	<br /> ���೻��
	<br />
	
</body>
</html>