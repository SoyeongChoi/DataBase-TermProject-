package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogonDBBeanScreen {

	private static LogonDBBeanScreen instance = new LogonDBBeanScreen();

	public static LogonDBBeanScreen getInstance() {
		return instance;
	}

	private LogonDBBeanScreen() {
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

	public void insertScreen(LogonDataBeanScreen screen) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into 상영관 values (?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, screen.getsID());
			pstmt.setString(2, screen.getsName());
			pstmt.setInt(3, screen.getRow());
			pstmt.setInt(4, screen.getColumn());
			pstmt.setString(5, screen.gettName());
			pstmt.setString(6, screen.getmId());
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

	public void updateScreenMovie(String sId, String mId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update 상영관 set 영화아이디=? where 상영관아이디 = ?");
			pstmt.setString(1, mId);
			pstmt.setString(2, sId);
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

	public String[][] getInfoAll(String tName) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Info[][] = null;
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from 상영관 where 영화관이름=?");
			pstmt.setString(1, tName);
			rs = pstmt.executeQuery();
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();

			Info = new String[count][5];
			System.out.println(count + "count:");

			int r = 0; // 행
			while (rs.next()) {
				Info[r][0] = rs.getString("상영관아이디");
				Info[r][1] = rs.getString("상영관이름");
				Info[r][2] = Integer.toString(rs.getInt("좌석행"));
				Info[r][3] = Integer.toString(rs.getInt("좌석열"));
				Info[r][4] = rs.getString("영화아이디");
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

	public String[][] getInfoAll(String mId, String mname) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Info[][] = null;
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from 상영관 where 영화아이디=? and 영화관이름=?");
			pstmt.setString(1, mId);
			pstmt.setString(2, mname);
			rs = pstmt.executeQuery();
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();

			Info = new String[count][5];
			System.out.println(count + "count:");

			int r = 0; // 행
			while (rs.next()) {
				Info[r][0] = rs.getString("상영관아이디");
				Info[r][1] = rs.getString("상영관이름");
				Info[r][2] = Integer.toString(rs.getInt("좌석행"));
				Info[r][3] = Integer.toString(rs.getInt("좌석열"));
				Info[r][4] = rs.getString("영화아이디");
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

	public String[] getDate(String sId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String date[] = new String[2];

		try {
			conn = getConnection();
			System.out.println(sId);
			pstmt = conn.prepareStatement("select * from 상영관 where 상영관아이디=?");
			pstmt.setString(1, sId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String mId = rs.getString("영화아이디");
				System.out.println(mId);
				pstmt = conn.prepareStatement("select * from 영화 where 영화아이디=?");
				pstmt.setString(1, mId);
				rs = pstmt.executeQuery();
				while(rs.next()) {
				date[0] = rs.getString("시작날짜");
				date[1] = rs.getString("종료날짜");
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
		return date;
	}

	public String[] getSeat(String sId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String seat[] = new String[2];
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from 상영관 where 상영관아이디=?");
			pstmt.setString(1, sId);
			rs = pstmt.executeQuery();
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();

			while (rs.next()) {
				seat[0] = Integer.toString(rs.getInt("좌석행"));
				seat[1] = Integer.toString(rs.getInt("좌석열"));
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
		return seat;
	}

	public String[] getScreenId(String mId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String[] movie = null;
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select 상영관아이디 from 상영관 where 영화아이디=?");
			pstmt.setString(1, mId);
			rs = pstmt.executeQuery();
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();

			movie = new String[count];

			int r = 0; // 행
			while (rs.next()) {
				movie[r] = rs.getString(1);
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
		return movie;
	}

}
