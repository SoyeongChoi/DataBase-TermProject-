package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogonDBBeanScreenSchedule {

	private static LogonDBBeanScreenSchedule instance = new LogonDBBeanScreenSchedule();

	public static LogonDBBeanScreenSchedule getInstance() {
		return instance;
	}

	private LogonDBBeanScreenSchedule() {
	}

	private Connection getConnection() throws Exception {
		Connection conn = null;

		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "thdud5313";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		return conn;
	}

	public void insertScreenSchedule(LogonDataBeanScreenSchedule schedule) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into 상영일정 values (?, ?, ?, ?)");
			pstmt.setString(1, schedule.getScheduleCode());
			pstmt.setString(2, schedule.getsTime());
			pstmt.setString(3, schedule.geteTime());
			pstmt.setString(4, schedule.getsId());
			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}

	public String[][] getInfoAll(String sId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Info[][] = null;
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from 상영일정 where 상영관아이디=?");
			pstmt.setString(1, sId);
			rs = pstmt.executeQuery();
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();

			Info = new String[count][3];

			int r = 0; // 행
			while (rs.next()) {
				Info[r][0] = rs.getString("상영일정코드");
				Info[r][1] = rs.getString("시작시간");
				Info[r][2] = rs.getString("종료시간");
				r += 1;
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return Info;
	}

	public void deleteScreenSchedule(String sId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from 상영일정 where 상영관아이디=?");
			pstmt.setString(1, sId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String sql = "delete from 상영일정 where 상영관아이디 = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sId);
				pstmt.executeUpdate();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}
	
	public String[][] getTime(String sId, String selectDay) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String time[][] = null;

		try {
			conn = getConnection();
			System.out.println(sId);
			pstmt = conn.prepareStatement("select * from 상영일정 where 상영관아이디=?");
			pstmt.setString(1, sId);
			rs = pstmt.executeQuery();
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();
			time = new String[count][2];
			int i=0;
			while (rs.next()) {
				System.out.println(rs.getString("상영일정코드").split("@")[2]);
				System.out.println(selectDay);
				if(rs.getString("상영일정코드").split("@")[2].equals(selectDay)) {
					time[i][0]=rs.getString("시작시간");
					System.out.println("시작시간"+time[i][0]);
					time[i][1]=rs.getString("종료시간");
					System.out.println("종료시간"+time[i][1]);
					i++;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return time;
	}
}
